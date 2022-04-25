Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D607A50E030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbiDYM0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241794AbiDYMZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:25:26 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1FF62A17;
        Mon, 25 Apr 2022 05:22:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBDlJL0_1650889335;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBDlJL0_1650889335)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:22:16 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com,
        zhujia.zj@bytedance.com
Subject: [PATCH v10 19/21] erofs: implement fscache-based data read for inline layout
Date:   Mon, 25 Apr 2022 20:21:41 +0800
Message-Id: <20220425122143.56815-20-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
References: <20220425122143.56815-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement the data plane of reading data from data blobs over fscache
for inline layout.

For the heading non-inline part, the data plane for non-inline layout is
reused, while only the tail packing part needs special handling.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fscache.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index b3af72af7c88..5b779812a5ee 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -83,6 +83,33 @@ static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
 	return ret;
 }
 
+static int erofs_fscache_readpage_inline(struct folio *folio,
+					 struct erofs_map_blocks *map)
+{
+	struct super_block *sb = folio_mapping(folio)->host->i_sb;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	erofs_blk_t blknr;
+	size_t offset, len;
+	void *src, *dst;
+
+	/* For tail packing layout, the offset may be non-zero. */
+	offset = erofs_blkoff(map->m_pa);
+	blknr = erofs_blknr(map->m_pa);
+	len = map->m_llen;
+
+	src = erofs_read_metabuf(&buf, sb, blknr, EROFS_KMAP);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
+
+	dst = kmap_local_folio(folio, 0);
+	memcpy(dst, src + offset, len);
+	memset(dst + len, 0, PAGE_SIZE - len);
+	kunmap_local(dst);
+
+	erofs_put_metabuf(&buf);
+	return 0;
+}
+
 static int erofs_fscache_readpage(struct file *file, struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -108,6 +135,11 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 		goto out_uptodate;
 	}
 
+	if (map.m_flags & EROFS_MAP_META) {
+		ret = erofs_fscache_readpage_inline(folio, &map);
+		goto out_uptodate;
+	}
+
 	mdev = (struct erofs_map_dev) {
 		.m_deviceid = map.m_deviceid,
 		.m_pa = map.m_pa,
-- 
2.27.0

