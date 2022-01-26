Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBC49D3BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiAZUiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 15:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiAZUiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:38:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BCC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ITwUUduvHGoqzChBubtdaEjI4Y8oSKQFVPed7lBjssw=; b=cUgP1qzoHQMfa1Kzd2pfNtV9S+
        63IbUP6eeSx7vcifOvwDGG1i4dGjk1xjxjd2r33QA4+qvY88bs7lTUDfnkzHhpCDvMV2yTRsGCL6s
        YkIT3mAf4KgTht6Y83arEx3mwQJYigXj0DeetBzuEV75uPte2396K4Lj81BQDb+Xw42wIaqMwU0Us
        jklIyCZmtcsLh+vY/6Cke1sX8jOZXFj6bgibGmtyNqoorbhSnRbZWuooh4W+NvX2jEldRc3d7r6jA
        yVPSkkEFaljN/2JZL7e3X+/DRuJ6KCK4AF26l2/JzEFQfGQC0oTFHf0EIP859ADX/Dkl7ewyTwAhk
        CKB5ryLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCp3c-004RNS-WD; Wed, 26 Jan 2022 20:38:21 +0000
Date:   Wed, 26 Jan 2022 20:38:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] Folios
Message-ID: <YfGxPKBRdR8FKDcv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

You might think that with a fortnightly meeting, presentations on the
subject of folios at several conferences and hundreds of patches merged,
I'd be short of things to discuss at LSFMM.  Hah.

From a filesystem point of view,

 - Converting APIs that filesystems implement to use folios (aops, primarily)
   to be folio based instead of page based
 - What it takes to support large (ie multi-page) folios in your
   filesystem
 - Removing old page-based APIs used by filesystems (eg everything in
   mm/folio-compat.c)
 - Converting your filesystem to use iomap.

For the MM crowd:
 - Continued conversion of the MM from pages to folios
   - GUP is done
   - page_vma_mapped is done, not yet posted for review
   - rmap in progress
   - mlock in progress
   - vmscan in progress
   (this list will have changed by May)
 - Splitting out other page types from struct page
 - Dynamically allocating struct folio & shrinking struct page

I'm going to throw a discussion of mapcount into this as well; getting
mapcount right on a multi-page folio is expensive.  I intend to send a full
proposal for making mapcount less accurate by default soon; just haven't
found time to do it yet.
