Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BBA502A3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 14:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353800AbiDOMjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345514AbiDOMj2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:39:28 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7F9C8BCE;
        Fri, 15 Apr 2022 05:36:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VA7Ug2g_1650026202;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VA7Ug2g_1650026202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 20:36:43 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: [PATCH v9 17/21] erofs: implement fscache-based metadata read
Date:   Fri, 15 Apr 2022 20:36:10 +0800
Message-Id: <20220415123614.54024-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the data plane of reading metadata from primary data blob
over fscache.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c    | 19 +++++++++++++++----
 fs/erofs/fscache.c | 27 +++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 14b64d960541..bb9c1fd48c19 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -6,6 +6,7 @@
  */
 #include "internal.h"
 #include <linux/prefetch.h>
+#include <linux/sched/mm.h>
 #include <linux/dax.h>
 #include <trace/events/erofs.h>
 
@@ -35,14 +36,20 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 	erofs_off_t offset = blknr_to_addr(blkaddr);
 	pgoff_t index = offset >> PAGE_SHIFT;
 	struct page *page = buf->page;
+	struct folio *folio;
+	unsigned int nofs_flag;
 
 	if (!page || page->index != index) {
 		erofs_put_metabuf(buf);
-		page = read_cache_page_gfp(mapping, index,
-				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (IS_ERR(page))
-			return page;
+
+		nofs_flag = memalloc_nofs_save();
+		folio = read_cache_folio(mapping, index, NULL, NULL);
+		memalloc_nofs_restore(nofs_flag);
+		if (IS_ERR(folio))
+			return folio;
+
 		/* should already be PageUptodate, no need to lock page */
+		page = folio_file_page(folio, index);
 		buf->page = page;
 	}
 	if (buf->kmap_type == EROFS_NO_KMAP) {
@@ -63,6 +70,10 @@ void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
 void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 			 erofs_blk_t blkaddr, enum erofs_kmap_type type)
 {
+	if (erofs_is_fscache_mode(sb))
+		return erofs_bread(buf, EROFS_SB(sb)->s_fscache->inode,
+				   blkaddr, type);
+
 	return erofs_bread(buf, sb->s_bdev->bd_inode, blkaddr, type);
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 066f68c062e2..3f00eb34ac35 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -58,7 +58,34 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
 	return ret;
 }
 
+static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
+{
+	int ret;
+	struct folio *folio = page_folio(page);
+	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_map_dev mdev = {
+		.m_deviceid = 0,
+		.m_pa = folio_pos(folio),
+	};
+
+	ret = erofs_map_dev(sb, &mdev);
+	if (ret)
+		goto out;
+
+	ret = erofs_fscache_read_folios(mdev.m_fscache->cookie,
+			folio_mapping(folio), folio_pos(folio),
+			folio_size(folio), mdev.m_pa);
+	if (ret)
+		goto out;
+
+	folio_mark_uptodate(folio);
+out:
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_meta_aops = {
+	.readpage = erofs_fscache_meta_readpage,
 };
 
 /*
-- 
2.27.0

