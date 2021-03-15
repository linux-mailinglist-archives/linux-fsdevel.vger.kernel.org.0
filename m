Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9D33CA1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 00:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhCOXrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCOXq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:46:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228AC06174A;
        Mon, 15 Mar 2021 16:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q5WpvI+u/n7oGrB8MBjwp1b76X1ojPJiu1UvApa7aOM=; b=XxzZQEuiUGYF4WLGRYxkb+VC/J
        j2qyAgXjLSZg41dJFHIn5P1zKih5kQD/1ZWStdzhurTmzSKPCZXVdFVNomLX981LgUT0SdsO7MGmc
        mHErX73nV1kJErajGuK4dlSwT9B0AG/+qDmdfmbDFDLZNuZUllC3fzXFl2qRSPI5rKFsGF7tzp2j4
        VpLciNIv8K9JQLZT+skTA/JZav74HyRhK08CR2QiLlyYFypv2NSAwihXfevIVKNIUUqMerD82/bJV
        mjBn1kT+ta3yOrvCQiSu6wVpJkYUGl2T2NgIy+2mg62oIPjtP2VJV3LetXC2cWeNp5/iKX/7H6eyu
        3bAXjf1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLwuT-0012sM-9J; Mon, 15 Mar 2021 23:46:24 +0000
Date:   Mon, 15 Mar 2021 23:46:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v3] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <20210315234605.GD2577561@casper.infradead.org>
References: <cover.1610572007.git.cgoldswo@codeaurora.org>
 <2f13c006ad12b047e9e4d5de008e5d5c41322754.1610572007.git.cgoldswo@codeaurora.org>
 <20210315164138.c15727adeb184313f5e7e9f6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315164138.c15727adeb184313f5e7e9f6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 04:41:38PM -0700, Andrew Morton wrote:
> > When a buffer is added to the LRU list, a reference is taken which is
> > not dropped until the buffer is evicted from the LRU list. This is the
> > correct behavior, however this LRU reference will prevent the buffer
> > from being dropped. This means that the buffer can't actually be dropped
> > until it is selected for eviction. There's no bound on the time spent
> > on the LRU list, which means that the buffer may be undroppable for
> > very long periods of time. Given that migration involves dropping
> > buffers, the associated page is now unmigratible for long periods of
> > time as well. CMA relies on being able to migrate a specific range
> > of pages, so these types of failures make CMA significantly
> > less reliable, especially under high filesystem usage.
>
> It looks like patch this turns drop_buffers() into a very expensive
> operation.  And that expensive operation occurs under the
> address_space-wide private_lock, which is more ouch.

This patch set is obsoleted by Minchan Kim's more recent patch-set.
