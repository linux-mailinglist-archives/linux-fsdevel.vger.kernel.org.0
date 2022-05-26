Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84DA5353EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348691AbiEZT3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbiEZT30 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 15:29:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC674BFC2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ph6yrsMi6MgeXQ6bRsFN0xtbtdvaj4M9b9YlpQeI3wg=; b=ky2cmbr8PrJ/f18gC/mHTNuDNX
        wsmLWMAFjDyItY5VpEtQoNnW5OTdYd7SVpZJFz7vkVHS0OXYP/yDwqQHVRUEffvMuUdyBftcZFETv
        NrGjY4pgTv8SCQexgTq9bTanfXoiftoT0Lai1QoCd9wqKkoL+4wBDHV2dc72dbhmcGFYxlSPXESlb
        SD6Hf+RNfgb/eNT+yU0Xisf4rwV318XKohgYYUUSQ1wTqNtH/QN5mzE+n6OPSFzueu0BxcbJM0JXZ
        wpXPmGMdaRH8OWzNA06Nsjv1g2dVpfPy721TLBU5MyYNi0nILs3kdMh960Gts2OIF5Z5d7VSAcnxx
        n6oL3bkw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuJAb-001Uul-8r; Thu, 26 May 2022 19:29:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [RFC PATCH 7/9] jfs: Read quota through the page cache
Date:   Thu, 26 May 2022 20:29:08 +0100
Message-Id: <20220526192910.357055-8-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220526192910.357055-1-willy@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The comment above jfs_quota_read() is stale; sb_bread() will use the
page cache, so we may as well use the page cache directly and avoid
using jfs_get_block().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/super.c | 54 ++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 85d4f44f2ac4..1e7d117b555d 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -721,51 +721,39 @@ static int jfs_show_options(struct seq_file *seq, struct dentry *root)
 }
 
 #ifdef CONFIG_QUOTA
-
-/* Read data from quotafile - avoid pagecache and such because we cannot afford
- * acquiring the locks... As quota files are never truncated and quota code
- * itself serializes the operations (and no one else should touch the files)
- * we don't have to be afraid of races */
 static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
-			      size_t len, loff_t off)
+			      size_t len, loff_t pos)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
-	sector_t blk = off >> sb->s_blocksize_bits;
-	int err = 0;
-	int offset = off & (sb->s_blocksize - 1);
-	int tocopy;
+	struct address_space *mapping = inode->i_mapping;
 	size_t toread;
-	struct buffer_head tmp_bh;
-	struct buffer_head *bh;
+	pgoff_t index;
 	loff_t i_size = i_size_read(inode);
 
-	if (off > i_size)
+	if (pos > i_size)
 		return 0;
-	if (off+len > i_size)
-		len = i_size-off;
+	if (pos + len > i_size)
+		len = i_size - pos;
 	toread = len;
+	index = pos / PAGE_SIZE;
+
 	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
+		struct folio *folio = read_mapping_folio(mapping, index, NULL);
+		size_t tocopy = PAGE_SIZE - offset_in_page(pos);
+		void *src;
+
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
+
+		src = kmap_local_folio(folio, offset_in_folio(folio, pos));
+		memcpy(data, src, tocopy);
+		kunmap_local(src);
+		folio_put(folio);
 
-		tmp_bh.b_state = 0;
-		tmp_bh.b_size = i_blocksize(inode);
-		err = jfs_get_block(inode, blk, &tmp_bh, 0);
-		if (err)
-			return err;
-		if (!buffer_mapped(&tmp_bh))	/* A hole? */
-			memset(data, 0, tocopy);
-		else {
-			bh = sb_bread(sb, tmp_bh.b_blocknr);
-			if (!bh)
-				return -EIO;
-			memcpy(data, bh->b_data+offset, tocopy);
-			brelse(bh);
-		}
-		offset = 0;
 		toread -= tocopy;
 		data += tocopy;
-		blk++;
+		pos += tocopy;
+		index++;
 	}
 	return len;
 }
-- 
2.34.1

