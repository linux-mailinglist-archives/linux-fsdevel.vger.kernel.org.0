Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6777050E017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 14:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiDYMZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiDYMZS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:25:18 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81E462A34;
        Mon, 25 Apr 2022 05:22:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VBG8mk6_1650889328;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VBG8mk6_1650889328)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Apr 2022 20:22:09 +0800
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
Subject: [PATCH v10 15/21] erofs: register fscache context for primary data blob
Date:   Mon, 25 Apr 2022 20:21:37 +0800
Message-Id: <20220425122143.56815-16-jefflexu@linux.alibaba.com>
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

Registers fscache context for primary data blob. Also move the
initialization of s_op and related fields forward, since anonymous
inode will be allocated under the super block when registering the
fscache context.

Something worth mentioning about the cleanup routine.

1. The fscache context will instantiate anonymous inodes under the super
block. Release these anonymous inodes when .put_super() is called, or
we'll get "VFS: Busy inodes after unmount." warning.

2. The fscache context is initialized prior to the root inode. If
.kill_sb() is called when mount failed, .put_super() won't be called
when root inode has not been initialized yet. Thus .kill_sb() shall
also contain the cleanup routine.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 5867cb63fd74..386658416159 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -155,6 +155,7 @@ struct erofs_sb_info {
 
 	/* fscache support */
 	struct fscache_volume *volume;
+	struct erofs_fscache *s_fscache;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index fd8daa447237..61dc900295f9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -589,6 +589,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_op = &erofs_sops;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -606,6 +609,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = erofs_fscache_register_fs(sb);
 		if (err)
 			return err;
+
+		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
+						    sbi->opt.fsid, true);
+		if (err)
+			return err;
 	} else {
 		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 			erofs_err(sb, "failed to set erofs blksize");
@@ -628,11 +636,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 			clear_opt(&sbi->opt, DAX_ALWAYS);
 		}
 	}
-	sb->s_flags |= SB_RDONLY | SB_NOATIME;
-	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_time_gran = 1;
 
-	sb->s_op = &erofs_sops;
+	sb->s_time_gran = 1;
 	sb->s_xattr = erofs_xattr_handlers;
 
 	if (test_opt(&sbi->opt, POSIX_ACL))
@@ -772,6 +777,7 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -790,6 +796,7 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

