Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DC33CA16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 00:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhCOXl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 19:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhCOXlp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98AF864F5E;
        Mon, 15 Mar 2021 23:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615851698;
        bh=ZRw4LBv8GBdf5Sggo16rGV3091lb93cVl67xHbNT2sI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MKiRV5vMH9JlAlXD4ZUmR+e8lrd5u8nHdUPWTZJzi+ZFniCOUKLm4Mk7b+WF+22Xa
         sg7IUeo+f+EtjPEnf6/nKIYmoeeWU/Y7FveVfj6I4hFPkzbC07ZMVrmaD2QdZnoY2U
         QGk6jX5TQ9wkj5oOZBNuj7tw7mQfl86O2C6ATslU=
Date:   Mon, 15 Mar 2021 16:41:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v3] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-Id: <20210315164138.c15727adeb184313f5e7e9f6@linux-foundation.org>
In-Reply-To: <2f13c006ad12b047e9e4d5de008e5d5c41322754.1610572007.git.cgoldswo@codeaurora.org>
References: <cover.1610572007.git.cgoldswo@codeaurora.org>
        <2f13c006ad12b047e9e4d5de008e5d5c41322754.1610572007.git.cgoldswo@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 13 Jan 2021 13:17:30 -0800 Chris Goldsworthy <cgoldswo@codeaurora.org> wrote:

> From: Laura Abbott <lauraa@codeaurora.org>
> 
> When a buffer is added to the LRU list, a reference is taken which is
> not dropped until the buffer is evicted from the LRU list. This is the
> correct behavior, however this LRU reference will prevent the buffer
> from being dropped. This means that the buffer can't actually be dropped
> until it is selected for eviction. There's no bound on the time spent
> on the LRU list, which means that the buffer may be undroppable for
> very long periods of time. Given that migration involves dropping
> buffers, the associated page is now unmigratible for long periods of
> time as well. CMA relies on being able to migrate a specific range
> of pages, so these types of failures make CMA significantly
> less reliable, especially under high filesystem usage.
> 
> Rather than waiting for the LRU algorithm to eventually kick out
> the buffer, explicitly remove the buffer from the LRU list when trying
> to drop it. There is still the possibility that the buffer
> could be added back on the list, but that indicates the buffer is
> still in use and would probably have other 'in use' indicates to
> prevent dropping.
> 
> Note: a bug reported by "kernel test robot" lead to a switch from
> using xas_for_each() to xa_for_each().

(hm, why isn't drop_buffers() static to fs/buffer.c??)

It looks like patch this turns drop_buffers() into a very expensive
operation.  And that expensive operation occurs under the
address_space-wide private_lock, which is more ouch.

How carefully has this been tested for performance?  In pathological
circumstances (which are always someone's common case :()


Just thinking out loud...

If a buffer_head* is sitting in one or more of the LRUs, what is
stopping us from stripping it from the page anyway?  Then
try_to_free_buffers() can mark the bh as buffer_dead(), declare success
and leave the bh sitting in the LRU, with the LRU as the only reference
to that buffer.  Teach lookup_bh_lru() to skip over buffer_dead()
buffers and our now-dead buffer will eventually reach the tail of the
lru and get freed for real.

