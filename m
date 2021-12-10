Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39946FBD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 08:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhLJHkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 02:40:47 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:45249 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237827AbhLJHkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:40:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0V-83nvu_1639121798;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V-83nvu_1639121798)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 15:36:39 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: [RFC 16/19] erofs: implement fscache-based data read
Date:   Fri, 10 Dec 2021 15:36:16 +0800
Message-Id: <20211210073619.21667-17-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
References: <20211210073619.21667-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 73 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  6 +++-
 fs/erofs/internal.h |  1 +
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 6fe31d410cbd..c849d3a89520 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -1,5 +1,78 @@
 #include "internal.h"
 
+/*
+ * erofs_fscache_readpage
+ *
+ * Copy data from backpage (bootstrap) to page of files among erofs.
+ */
+static int erofs_fscache_readpage(struct file *file, struct page *page)
+{
+	struct inode *inode = page->mapping->host;
+	struct super_block *sb = inode->i_sb;
+	erofs_off_t pos = page->index << PAGE_SHIFT;
+	struct erofs_map_blocks map = { .m_la = pos };
+	erofs_blk_t blkaddr;
+	struct page *backpage;
+	u64 total, batch, copied = 0;
+	char *vsrc, *vdst; /* virtual address of mapped src/dst page */
+	char *psrc, *pdst; /* cursor inside src/dst page */
+	u64 osrc;	   /* offset inside src page */
+	int err;
+
+	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (err)
+		goto out;
+
+	total = min_t(u64, PAGE_SIZE, map.m_plen - (pos - map.m_la));
+	blkaddr = map.m_pa >> PAGE_SHIFT;
+	osrc = map.m_pa & (PAGE_SIZE - 1);
+
+	while (total) {
+		backpage = erofs_get_meta_page(sb, blkaddr);
+		if (IS_ERR(backpage)) {
+			err = PTR_ERR(backpage);
+			goto out;
+		}
+
+		vsrc = psrc = kmap_atomic(backpage);
+		vdst = pdst = kmap_atomic(page);
+
+		psrc += osrc;
+		pdst += copied;
+		batch = min_t(u64, PAGE_SIZE - osrc, total);
+
+		memcpy(pdst, psrc, batch);
+
+		copied += batch;
+		total  -= batch;
+		blkaddr++;
+		osrc = 0; /* copy from the beginning of the next backpage */
+
+		/*
+		 * Avoid 'scheduling while atomic' error. Unmap before going
+		 * into the next turn, since we may schedule inside
+		 * erofs_get_meta_page().
+		 * */
+		kunmap_atomic(vsrc);
+		kunmap_atomic(vdst);
+
+		unlock_page(backpage);
+		put_page(backpage);
+	}
+
+out:
+	if (err)
+		SetPageError(page);
+	else
+		SetPageUptodate(page);
+	unlock_page(page);
+	return err;
+}
+
+const struct address_space_operations erofs_fscache_access_aops = {
+	.readpage = erofs_fscache_readpage,
+};
+
 static int erofs_begin_cache_operation(struct netfs_read_request *rreq)
 {
 	return fscache_begin_read_operation(&rreq->cache_resources,
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 2345f1de438e..452d147277c4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -299,7 +299,11 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		err = z_erofs_fill_inode(inode);
 		goto out_unlock;
 	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+
+	if (inode->i_sb->s_bdev)
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
+	else
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 
 out_unlock:
 	unlock_page(page);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d60d9ffaef2a..dd3f2edae603 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -353,6 +353,7 @@ struct page *erofs_grab_cache_page_nowait(struct address_space *mapping,
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_raw_access_aops;
+extern const struct address_space_operations erofs_fscache_access_aops;
 extern const struct address_space_operations z_erofs_aops;
 
 /*
-- 
2.27.0

