Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4164884BB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 17:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbiAHQxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 11:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiAHQxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:53:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5CBC06173F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IZ3aBhdg5ws/7hz+7XCjvQK1BFvSlx4gLX1SH9TyhoA=; b=oQ2CKjU4LZI8zMHIzf/uSFRaDM
        WFCj3Ejoe9+I7V2+LLMlN0NaMhYGqf2nEqQibAFR7FBg6+HecaUzNkkeQDDVKKLBBt5N/mq7hpcEQ
        /JCM3DBpDUfXQTQIvvygXgPKRiQh7pRyQSwCTjG5G8WmlxT7GBJTYgYg4OwrjDWb7j1WfxhWWbPkQ
        6lOYsF5uKUf18guzJ447wGDh07bg3RcAnNxRxx4k1NoICtEn51uSqSxqeIam059OqG0bKmVq973ug
        aK80yCqJnfS2PACfcsWJ/MlnPnGYJIyl4Dxe+HeRFU3sV2ZhHASuEorDtqaOOgiIyqd3PWyrV+Reb
        Nb8NzK6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6Exl-000mO2-Uc; Sat, 08 Jan 2022 16:53:06 +0000
Date:   Sat, 8 Jan 2022 16:53:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
Message-ID: <YdnBcaSLv4TAGjfL@casper.infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <YdHQnSqA10iwhJ85@casper.infradead.org>
 <Ydkh9SXkDlYJTd35@casper.infradead.org>
 <a5433775-23b0-4ac-51c7-1178fad73fc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5433775-23b0-4ac-51c7-1178fad73fc@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 08, 2022 at 08:47:49AM -0800, Hugh Dickins wrote:
> On Sat, 8 Jan 2022, Matthew Wilcox wrote:
> > On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> > > On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > > > This all passes xfstests with no new failures on both xfs and tmpfs.
> > > > I intend to put all this into for-next tomorrow.
> > > 
> > > As a result of Christoph's review, here's the diff.  I don't
> > > think it's worth re-posting the entire patch series.
> > 
> > After further review and integrating Hugh's fixes, here's what
> > I've just updated the for-next tree with.  A little late, but that's
> > this time of year ...
> 
> I don't see any fix to shmem_add_to_page_cache() in this diff, my 3/3
> shmem: Fix "Unused swap" messages - I'm not sure whether you decided
> my fix has to be adjusted or not, but some fix is needed there.

I pushed that earlier because I had more confidence in my understanding
of that patch.  Here's what's currently in for-next:

@@ -721,20 +720,18 @@ static int shmem_add_to_page_cache(struct page *page,
        cgroup_throttle_swaprate(page, gfp);

        do {
-               void *entry;
                xas_lock_irq(&xas);
-               entry = xas_find_conflict(&xas);
-               if (entry != expected)
+               if (expected != xas_find_conflict(&xas)) {
+                       xas_set_err(&xas, -EEXIST);
+                       goto unlock;
+               }
+               if (expected && xas_find_conflict(&xas)) {
                        xas_set_err(&xas, -EEXIST);
-               xas_create_range(&xas);
-               if (xas_error(&xas))
                        goto unlock;
-next:
-               xas_store(&xas, page);
-               if (++i < nr) {
-                       xas_next(&xas);
-                       goto next;
                }
+               xas_store(&xas, page);
+               if (xas_error(&xas))
+                       goto unlock;
                if (PageTransHuge(page)) {
                        count_vm_event(THP_FILE_ALLOC);
                        __mod_lruvec_page_state(page, NR_SHMEM_THPS, nr);


