Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA004E732A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 13:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352787AbiCYMZE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359059AbiCYMYp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:24:45 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15329D5EBC;
        Fri, 25 Mar 2022 05:22:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V89zY3j_1648210967;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V89zY3j_1648210967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 20:22:48 +0800
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
Subject: [PATCH v6 15/22] erofs: register cookie context for bootstrap blob
Date:   Fri, 25 Mar 2022 20:22:16 +0800
Message-Id: <20220325122223.102958-16-jefflexu@linux.alibaba.com>
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

Registers fscache_cookie for the bootstrap blob file. The bootstrap blob
file can be specified by a new mount option, which is going to be
introduced by a following patch.

Something worth mentioning about the cleanup routine.

1. The init routine is prior to when the root inode gets initialized,
and thus the corresponding cleanup routine shall be placed inside
.kill_sb() callback.

2. The init routine will instantiate anonymous inodes under the
super_block, and thus .put_super() callback shall also contain the
cleanup routine. Or we'll get "VFS: Busy inodes after unmount." warning.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 459f31803c3b..d8c886a7491e 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -73,6 +73,7 @@ struct erofs_mount_opts {
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
 #endif
+	char *tag;
 	unsigned int mount_opt;
 };
 
@@ -151,6 +152,8 @@ struct erofs_sb_info {
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
 	struct completion s_kobj_unregister;
+
+	struct erofs_fscache *bootstrap;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 798f0c379e35..de5aeda4aea0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -598,6 +598,16 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
+	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && erofs_is_nodev_mode(sb)) {
+		struct erofs_fscache *bootstrap;
+
+		bootstrap = erofs_fscache_get(sb, ctx->opt.tag, true);
+		if (IS_ERR(bootstrap))
+			return PTR_ERR(bootstrap);
+
+		sbi->bootstrap = bootstrap;
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
@@ -753,6 +763,7 @@ static void erofs_kill_sb(struct super_block *sb)
 		return;
 
 	erofs_free_dev_context(sbi->devs);
+	erofs_fscache_put(sbi->bootstrap);
 	fs_put_dax(sbi->dax_dev);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -771,6 +782,12 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_put(sbi->bootstrap);
+	/*
+	 * Set sbi->bootstrap to NULL, so that the following cleanup routine
+	 * inside .kill_sb() could be skipped then.
+	 */
+	sbi->bootstrap = NULL;
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

