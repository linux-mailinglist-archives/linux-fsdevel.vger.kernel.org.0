Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB4658EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 17:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiL2QLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 11:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiL2QKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:10:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1510DB;
        Thu, 29 Dec 2022 08:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JERcZZTMhkivNxo9SqHrHtIaAsMqudDjGhUiCLjWNr4=; b=uEGqoJWMD+5m6rJC3ueg05BpdS
        yvzRe5kSxtpJEljm6rFhRT1KRo1MlimyyptGn9oxiqWwdzZsevEiRJQrIRs1dUZqZsBMxlA9BWQsg
        M60+EvxQ4N/NiSFx77YOHKWe18eT6imHat7MQ+wu+cwl1ZsHZTSOBC43DUrAKHZSnlSSZSqwN25fl
        2xfzM4yW8GRHjwfPnIoPzDtp0qJrNfdyY8+uGVOXTBVIWPnbEUn981Z7rFSjcIz4HWuKxyiJ9WbEn
        sknQxfWX4y/0QjsHbAy7+s80zQxbjy4SGIct67u+X9EVRQv401lmk0efcwt/0lXTE79gy1wgzifMT
        RD2bgzOQ==;
Received: from rrcs-67-53-201-206.west.biz.rr.com ([67.53.201.206] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pAvUL-00HKLm-6s; Thu, 29 Dec 2022 16:10:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        linux-mm@kvack.org
Subject: [PATCH 2/6] ntfs3: stop using generic_writepages
Date:   Thu, 29 Dec 2022 06:10:27 -1000
Message-Id: <20221229161031.391878-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221229161031.391878-1-hch@lst.de>
References: <20221229161031.391878-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Open code the resident inode handling in ntfs_writepages by directly
using write_cache_pages to prepare removing the ->writepage handler
in ntfs3.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ntfs3/inode.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 20b953871574b8..b6dad2da59501b 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -852,12 +852,29 @@ static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, ntfs_get_block, wbc);
 }
 
+static int ntfs_resident_writepage(struct page *page,
+		struct writeback_control *wbc, void *data)
+{
+	struct address_space *mapping = data;
+	struct ntfs_inode *ni = ntfs_i(mapping->host);
+	int ret;
+
+	ni_lock(ni);
+	ret = attr_data_write_resident(ni, page);
+	ni_unlock(ni);
+
+	if (ret != E_NTFS_NONRESIDENT)
+		unlock_page(page);
+	mapping_set_error(mapping, ret);
+	return ret;
+}
+
 static int ntfs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	/* Redirect call to 'ntfs_writepage' for resident files. */
 	if (is_resident(ntfs_i(mapping->host)))
-		return generic_writepages(mapping, wbc);
+		return write_cache_pages(mapping, wbc, ntfs_resident_writepage,
+					 mapping);
 	return mpage_writepages(mapping, wbc, ntfs_get_block);
 }
 
-- 
2.35.1

