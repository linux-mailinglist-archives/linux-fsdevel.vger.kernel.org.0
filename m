Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51725C992
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgICTdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 15:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICTdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:33:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5AEC061244
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gmxKBZMmrHSKmVOYDRuC4LYj/xOebIyXf40iFmM5UwY=; b=oLCVb+CLmYh9LV6DQi9byumhVJ
        ExNipDk8/UQ6rntNcuG5vWe+xzWvP1CdqhofhHlYEWlUKBemiVkCXqC4Hdgg/+dWZgmB3pOTy+r5a
        W1JqxwYiy+RD57cJLxdHRNk/w+cBnZIpBA61K9Iu+MOnjXiUsjVWi2mx1InW4i9BlGPvTX9kdKI4z
        ssR/eNt0M1iw9SYGGfhSnzHnhaW1/HLvio8WAx/CPOQ2yKtt65ECmXrvhfVPIKQiqL9/hlGysceX0
        QPu6NwSK2Wzcsspk3RgVD0yVRqJ6vbitP/4pHpMABaSIFVk/zU523oh883St1vHIVo931g57os1UX
        K/xb5Png==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDuys-0007oT-Jp; Thu, 03 Sep 2020 19:33:10 +0000
Date:   Thu, 3 Sep 2020 20:33:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 3/9] mm/readahead: Make page_cache_ra_unbounded take a
 readahead_control
Message-ID: <20200903193310.GG14765@casper.infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
 <20200903140844.14194-4-willy@infradead.org>
 <20200903122218.42bd70d930cba998e3faf32c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903122218.42bd70d930cba998e3faf32c@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 12:22:18PM -0700, Andrew Morton wrote:
> On Thu,  3 Sep 2020 15:08:38 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Define it in the callers instead of in page_cache_ra_unbounded().
> > 
> 
> The changelogs for patches 2-9 are explaining what the patches do, but
> not why they do it, Presumably there's some grand scheme in mind, but
> it isn't being revealed to the reader!

Sorry!  For both pieces of infrastructure being build on top of this
patchset, we want the ractl to be available higher in the call-stack.

For David's work, he wants to add the 'critical page' to the ractl so that
he knows which page NEEDS to be brought in from storage, and which ones
are nice-to-have.  We might want something similar in block storage too.
It used to be simple -- the first page was the critical one, but then
mmap added fault-around and so for that usecase, the middle page is
the critical one.  Anyway, I don't have any code to show that yet,
we just know that the lowest point in the callchain where we have that
information is do_sync_mmap_readahead() and so the ractl needs to start
its life there.

For THP, I can show you the code that needs it.  It's actually the
apex patch to the series; the one which finally starts to allocate
THPs and present them to consenting filesystems:
http://git.infradead.org/users/willy/pagecache.git/commitdiff/798bcf30ab2eff278caad03a9edca74d2f8ae760

This doesn't need the ractl to be available as high in the stack as
David does, which is why he did the last few patches.
