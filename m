Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905424E7339
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359049AbiCYMZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354234AbiCYMYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:42 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6671D555B;
        Fri, 25 Mar 2022 05:22:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89qR.F_1648210956;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89qR.F_1648210956)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:37 +0800
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
Subject: [PATCH v6 08/22] erofs: use meta buffers for erofs_read_superblock()
Date:   Fri, 25 Mar 2022 20:22:09 +0800
Message-Id: <20220325122223.102958-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only change is that, meta buffers read cache page without __GFP_FS
flag, which shall not matter.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 915eefe0d7e2..12755217631f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -281,21 +281,19 @@ static int erofs_init_devices(struct super_block *sb,
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
-	struct page *page;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
 	unsigned int blkszbits;
 	void *data;
 	int ret;
 
-	page = read_mapping_page(sb->s_bdev->bd_inode->i_mapping, 0, NULL);
-	if (IS_ERR(page)) {
+	data = erofs_read_metabuf(&buf, sb, 0, EROFS_KMAP);
+	if (IS_ERR(data)) {
 		erofs_err(sb, "cannot read erofs superblock");
-		return PTR_ERR(page);
+		return PTR_ERR(data);
 	}
 
 	sbi = EROFS_SB(sb);
-
-	data = kmap(page);
 	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
 	ret = -EINVAL;
@@ -365,8 +363,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (erofs_sb_has_ztailpacking(sbi))
 		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 out:
-	kunmap(page);
-	put_page(page);
+	erofs_put_metabuf(&buf);
 	return ret;
 }
 
-- 
2.27.0

