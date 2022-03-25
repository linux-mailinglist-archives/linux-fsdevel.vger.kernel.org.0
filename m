Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A314E733D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356120AbiCYMZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359089AbiCYMYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:49 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223A3D64F1;
        Fri, 25 Mar 2022 05:22:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89qR1S_1648210970;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89qR1S_1648210970)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:51 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
Subject: [PATCH v6 17/22] erofs: implement fscache-based data read for non-inline layout
Date:   Fri, 25 Mar 2022 20:22:18 +0800
Message-Id: <20220325122223.102958-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
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

Implements the data plane of reading data from bootstrap blob file over
fscache for non-inline layout.

Be noted that compressed layout is not supported yet.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/inode.c    |  8 ++++-
 fs/erofs/internal.h |  5 +++
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 91377939b4f7..4a9a4e60c15d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -60,10 +60,93 @@ static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
 	return ret;
 }
 
+static inline int erofs_fscache_get_map(struct erofs_map_blocks *map,
+					struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	map->m_fscache	= sbi->bootstrap;
+	return 0;
+}
+
+static int erofs_fscache_readpage_noinline(struct folio *folio,
+					   struct erofs_map_blocks *map)
+{
+	struct fscache_cookie *cookie = map->m_fscache->cookie;
+	/*
+	 * 1) For FLAT_PLAIN layout, the output map.m_la shall be equal to o_la,
+	 * and the output map.m_pa is exactly the physical address of o_la.
+	 * 2) For CHUNK_BASED layout, the output map.m_la is rounded down to the
+	 * nearest chunk boundary, and the output map.m_pa is actually the
+	 * physical address of this chunk boundary. So we need to recalculate
+	 * the actual physical address of o_la.
+	 */
+	loff_t start = map->m_pa + (map->o_la - map->m_la);
+
+	return erofs_fscache_read_folio(cookie, folio, start);
+}
+
+static int erofs_fscache_do_readpage(struct folio *folio)
+{
+	struct inode *inode = folio_file_mapping(folio)->host;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct erofs_map_blocks map;
+	int ret;
+
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		erofs_info(sb, "compressed layout not supported yet");
+		return -EOPNOTSUPP;
+	}
+
+	DBG_BUGON(folio_size(folio) != EROFS_BLKSIZ);
+
+	map.m_la = map.o_la = folio_pos(folio);
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		folio_zero_range(folio, 0, folio_size(folio));
+		return 0;
+	}
+
+	ret = erofs_fscache_get_map(&map, sb);
+	if (ret)
+		return ret;
+
+	switch (vi->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_CHUNK_BASED:
+		return erofs_fscache_readpage_noinline(folio, &map);
+	default:
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+}
+
+static int erofs_fscache_readpage(struct file *file, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	int ret;
+
+	ret = erofs_fscache_do_readpage(folio);
+	if (!ret)
+		folio_mark_uptodate(folio);
+
+	folio_unlock(folio);
+	return ret;
+}
+
 static const struct address_space_operations erofs_fscache_blob_aops = {
 	.readpage = erofs_fscache_readpage_blob,
 };
 
+const struct address_space_operations erofs_fscache_access_aops = {
+	.readpage = erofs_fscache_readpage,
+};
+
 /*
  * erofs_fscache_get_folio - find and read page cache of blob file
  * @ctx:	the context of the blob file
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index ff62f84f47d3..744faf3ef9f4 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -296,7 +296,13 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 		err = z_erofs_fill_inode(inode);
 		goto out_unlock;
 	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
+
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+	if (erofs_is_nodev_mode(inode->i_sb))
+		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+#endif
+	if (!erofs_is_nodev_mode(inode->i_sb))
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 
 out_unlock:
 	erofs_put_metabuf(&buf);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index fa89a1e3012f..6537ededed51 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -442,6 +442,9 @@ struct erofs_map_blocks {
 	unsigned short m_deviceid;
 	char m_algorithmformat;
 	unsigned int m_flags;
+
+	struct erofs_fscache *m_fscache;
+	erofs_off_t o_la;
 };
 
 /* Flags used by erofs_map_blocks_flatmode() */
@@ -634,6 +637,8 @@ struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path,
 void erofs_fscache_put(struct erofs_fscache *ctx);
 
 struct folio *erofs_fscache_get_folio(struct erofs_fscache *ctx, pgoff_t index);
+
+extern const struct address_space_operations erofs_fscache_access_aops;
 #else
 static inline int erofs_init_fscache(void) { return 0; }
 static inline void erofs_exit_fscache(void) {}
-- 
2.27.0

