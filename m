Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9696282B22
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJDOQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:16:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D02C0613CE;
        Sun,  4 Oct 2020 07:16:06 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kP4ns-00BnIM-ID; Sun, 04 Oct 2020 14:15:56 +0000
Date:   Sun, 4 Oct 2020 15:15:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC][PATCHSET] epoll cleanups
Message-ID: <20201004141556.GO3421308@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <20201004121329.GG20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004121329.GG20115@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 04, 2020 at 01:13:29PM +0100, Matthew Wilcox wrote:

> Have you considered just storing a pointer to each struct file in an
> epoll set in an XArray?  Linked lists suck for modern CPUs, and there'd
> be no need to store any additional data in each struct file.  Using
> xa_alloc() to store the pointer and throw away the index the pointer
> got stored at would leave you with something approximating a singly
> linked list, except it's an array.  Which does zero memory allocations
> for a single entry and will then allocate a single node for your first
> 64 entries.

Won't work - those struct file can get freed while we are collecting the
set/allocating epitem/calling ->poll()/etc.
