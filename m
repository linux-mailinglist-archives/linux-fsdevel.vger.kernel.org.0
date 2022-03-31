Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE98A4ED901
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 13:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiCaMAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 08:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiCaMAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:00:25 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC330AE59;
        Thu, 31 Mar 2022 04:58:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0V8imruN_1648727893;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V8imruN_1648727893)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Mar 2022 19:58:14 +0800
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
Subject: [PATCH v7 13/19] erofs: register fscache context for primary data blob
Date:   Thu, 31 Mar 2022 19:57:47 +0800
Message-Id: <20220331115753.89431-14-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
References: <20220331115753.89431-1-jefflexu@linux.alibaba.com>
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
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3a4a344cfed3..eb37b33bce37 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -155,6 +155,7 @@ struct erofs_sb_info {
 
 	/* fscache support */
 	struct fscache_volume *volume;
+	struct erofs_fscache *s_fscache;
 };
 
 #define EROFS_SB(sb) ((struct erofs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6590ed1b7d3b..9498b899b73b 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -585,6 +585,9 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 
 	sb->s_magic = EROFS_SUPER_MAGIC;
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_op = &erofs_sops;
 
 	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
 		erofs_err(sb, "failed to set erofs blksize");
@@ -605,6 +608,11 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = erofs_fscache_register_fs(sb);
 		if (err)
 			return err;
+
+		err = erofs_fscache_register_cookie(sb, &sbi->s_fscache,
+						    sbi->opt.fsid, true);
+		if (err)
+			return err;
 	}
 
 	err = erofs_read_superblock(sb);
@@ -619,11 +627,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
@@ -763,6 +768,7 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev);
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 	erofs_fscache_unregister_fs(sb);
 	kfree(sbi);
 	sb->s_fs_info = NULL;
@@ -781,6 +787,7 @@ static void erofs_put_super(struct super_block *sb)
 	iput(sbi->managed_cache);
 	sbi->managed_cache = NULL;
 #endif
+	erofs_fscache_unregister_cookie(&sbi->s_fscache);
 }
 
 static struct file_system_type erofs_fs_type = {
-- 
2.27.0

