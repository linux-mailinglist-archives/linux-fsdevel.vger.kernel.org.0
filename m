Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A426B343633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 02:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCVBUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 21:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVBTc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 21:19:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61EC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s8mDUf3Enn/FoZ62WD9h0qniVO0+W7pXAxP0P9xb0xM=; b=bxWPyq42IIMurRO11ZjV9eQYcx
        hw+m+fcvKHIt7z61WaXAUpxnHNNAqVcDkgkFHsZ74MR2l2ys91uH/AAFMP5jKj5YGDCVyFTnC4bgK
        Nd/yJFVsClbNzTYscrXYMvMAAV0/aud1pem6jjezn/Dbza3jHTlhKbckGoSOPEfV5pEEFLc59sMrh
        7Imx66t68wq5fy76XBNnk+Z+9ttFqm8XB99EtXkRBybM58TJvjwQbByEILiJ4Sb1mJqiK7dw6KDtM
        sckaYGz/97JGysnltywARUNTZENU7kNg/odcn5yfJGw2aJgC9avWxH8mZemRWm6MDAyEXRr8EoTPH
        DG9GjA7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lO9Dn-007nXh-Mc; Mon, 22 Mar 2021 01:19:23 +0000
Date:   Mon, 22 Mar 2021 01:19:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: set_page_dirty variants
Message-ID: <20210322011907.GB1719932@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We currently have three near-identical implementations of the
set_page_dirty address_space op:

__set_page_dirty_no_writeback added 2007 by Ken Chen (767193253bba)
(return value fixed by Bob Liu in 2011 (c3f0da631539))
anon_set_page_dirty added 2009 by Peter Zijlstra (d3a9262e59f7)
noop_set_page_dirty added 2018 by Dan Williams (f44c77630d26)

I persuaded Mike to remove hugetlbfs_set_page_dirty and
Daniel Vetter to remove fb_deferred_io_set_page_dirty (in -next)
so we're down from five to three.

I'd like to get it down to zero.  After all, the !mapping case in
set_page_dirty() is exactly what we want.  So is there a problem
with doing this?

+++ b/mm/page-writeback.c
@@ -2562 +2562 @@ int set_page_dirty(struct page *page)
-       if (likely(mapping)) {
+       if (likely(mapping && mapping_can_writeback(mapping))) {

But then I noticed that we have both mapping_can_writeback()
and mapping_use_writeback_tags(), and I'm no longer sure
which one to use.  Also, why don't we mirror the results of
inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK into
a mapping->flags & AS_something bit?  We have lots available, and
inode_to_bdi seems relatively complicated to be a static inline that
gets evaluated every time we call
pagecache_get_page(FGP_CREAT | FGP_WRITE).
