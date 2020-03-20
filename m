Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7247718D05A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgCTOXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:23:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbgCTOWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/SQrh0NC9B/4IIKX+SOFUuY0GCDKmd4E0NcfkuJjHos=; b=pcB/9QPTh7YnWOIm2ghnxPADsV
        jUNiKAT2ROOLf8Z0Kjh4GVizaWHd4Jl/BSMdUeOliFlhPlmDsQsZly7IDmulQdWX1MQQtfwueam0h
        bbx25ng2ceWN+WX7wV06ox7qBfFWp0bP1hmNYXbotqiG9wCLlYnHcrJw1Seky/BAuB8S7xlgRbeAq
        6r9g2t/3XGz15oLBcpXU7U60KXdkUN6ipfcM1atlL4fkiEeO0tIkUyBONGyp2ZNjWPrh/V5d1l7/b
        DQaZKaioxJR02IiMDVquobwUYu9B7lnym1K/M5ttAYCmn+ib8iUrBtRLofKBP2wvE9fD0COZvWqas
        qxL+ahjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFIXi-0000jv-8O; Fri, 20 Mar 2020 14:22:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v9 23/25] f2fs: Pass the inode to f2fs_mpage_readpages
Date:   Fri, 20 Mar 2020 07:22:29 -0700
Message-Id: <20200320142231.2402-24-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320142231.2402-1-willy@infradead.org>
References: <20200320142231.2402-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This function now only uses the mapping argument to look up the inode,
and both callers already have the inode, so just pass the inode instead
of the mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 fs/f2fs/data.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 237dff36fe73..c8b042979fc4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2159,12 +2159,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * use ->readpage() or do the necessary surgery to decouple ->readpages()
  * from read-ahead.
  */
-static int f2fs_mpage_readpages(struct address_space *mapping,
+static int f2fs_mpage_readpages(struct inode *inode,
 		struct readahead_control *rac, struct page *page)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
-	struct inode *inode = mapping->host;
 	struct f2fs_map_blocks map;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	struct compress_ctx cc = {
@@ -2276,7 +2275,7 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(page_file_mapping(page), NULL, page);
+		ret = f2fs_mpage_readpages(inode, NULL, page);
 	return ret;
 }
 
@@ -2293,7 +2292,7 @@ static void f2fs_readahead(struct readahead_control *rac)
 	if (f2fs_has_inline_data(inode))
 		return;
 
-	f2fs_mpage_readpages(rac->mapping, rac, NULL);
+	f2fs_mpage_readpages(inode, rac, NULL);
 }
 
 int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
-- 
2.25.1

