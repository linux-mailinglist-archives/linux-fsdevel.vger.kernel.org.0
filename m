Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451CB2693B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINRjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINMZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:25:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D7C03542F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 05:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3uyCxaXwBxhd/H3rtFRPq1v+OzfzT6S4SsindOcilsM=; b=sRxT3Mwh2yHp2s56AysKPLm8b0
        lbUJswi30vyr6nLY2ZVG5Lzg1kRU6m1qqejMWUueNkwQhvzDRQViVETmKDb8qxUe56yhZTxpjwKTL
        mmohXesF3Ec4useFy6uZziG4jAXq1t+n8f7I3+CuMsaGEp3KjeU7rYXTuk8qvBPHtEgmR7mTsBAMJ
        mPc1F52juATNREW2bxMr/mDPaAiwSn82fU1P/+rxhXspiSyky9uHAR1XWNwoemhWN6Czt1YWr8pm+
        CsQdXOHIeI5a5/Se6BpP2C5SehcHsv10qsZ1GPAjS1sg13jsf6rl9n5ygid+ejpCVcBr0w6GDflNO
        lkWD0tOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHnVH-0000WV-Nb; Mon, 14 Sep 2020 12:22:39 +0000
Date:   Mon, 14 Sep 2020 13:22:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH] ramfs: Fix nommu mmap with gaps in the page cache
Message-ID: <20200914122239.GO6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

ramfs needs to check that pages are both physically contiguous and
contiguous in the file.  If the page cache happens to have, eg, page A
for index 0 of the file, no page for index 1, and page A+1 for index 2,
then an mmap of the first two pages of the file will succeed when it
should fail.

Fixes: 642fb4d1f1dd ("[PATCH] NOMMU: Provide shared-writable mmap support on ramfs")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 414695454956..355523f4a4bf 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -224,7 +224,7 @@ static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 	if (!pages)
 		goto out_free;
 
-	nr = find_get_pages(inode->i_mapping, &pgoff, lpages, pages);
+	nr = find_get_pages_contig(inode->i_mapping, pgoff, lpages, pages);
 	if (nr != lpages)
 		goto out_free_pages; /* leave if some pages were missing */
 
