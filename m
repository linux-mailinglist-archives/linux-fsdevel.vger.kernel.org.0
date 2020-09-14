Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C518268CE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 16:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgINOIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgINOHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:07:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C008C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LcdoEWDjr+1vruLTp3pTqHW/nKPn+9jvg4METqBqsKc=; b=AWvk9o8hEfhwm/nYAfgLut2hu6
        N/ABDGWAA1v3pKbgAqWUmHrQzGvBIuvEg6u1r8k/UidGlEv1vw1hvXf0S+4y1xNbtNEHlPBqcwbW/
        Qh76c1QxCrXNhWeBA2O/rtrCuyAd0fuVK1pQT8M0Fj9OHhvSZCXkxGahvBCR7o1g1ymHILXXKbT3d
        X8ZBQXZtx+/QPH0psg8UTqprFLVUd3gP/mKqjG3yJ36c9UirP+yRXvln6XRShd5tXGnCDvOnLh3+l
        rzNdp7bYrHRuTD0j+isD7W94lt6bo29u/SrexppuND9rlG+iVJo2B/yqMY2eIYV+srcYKCOJhCwvv
        CNeRfExA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHp8n-00074z-AC; Mon, 14 Sep 2020 14:07:34 +0000
Date:   Mon, 14 Sep 2020 15:07:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pradeep P V K <ppvk@codeaurora.org>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stummala@codeaurora.org, sayalil@codeaurora.org
Subject: Re: [PATCH V1] fuse: Remove __GFP_FS flag to avoid allocator
 recursing
Message-ID: <20200914140733.GP6583@casper.infradead.org>
References: <1600091775-10639-1-git-send-email-ppvk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600091775-10639-1-git-send-email-ppvk@codeaurora.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:26:15PM +0530, Pradeep P V K wrote:
> Process#1(kswapd) held an inode lock and initaited a writeback to free
> the pages, as the inode superblock is fuse, process#2 forms a fuse
> request. Process#3 (Fuse daemon threads) while serving process#2 request,
> it requires memory(pages) and as the system is already running in low
> memory it ends up in calling try_to_ free_pages(), which might now call
> kswapd again, which is already stuck with an inode lock held. Thus forms
> a deadlock.
> 
> So, remove __GFP_FS flag to avoid allocator recursing into the
> filesystem that might already held locks.

This is the wrong way to fix the problem.  The fuse daemon threads should
have called memalloc_nofs_save() as this prevents them from inadvertently
tripping over other places where they forgot to use GFP_NOFS (or have
no way to pass a GFP_NOFS flags argument).

