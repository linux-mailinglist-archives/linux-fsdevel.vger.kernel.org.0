Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4B7664472
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 16:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbjAJPVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 10:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbjAJPUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:20:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE783714B8;
        Tue, 10 Jan 2023 07:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE7F6B81731;
        Tue, 10 Jan 2023 15:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6D3C433EF;
        Tue, 10 Jan 2023 15:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673364030;
        bh=ZcLcQ7QNnXhTOAkBBEi6YS0XdNLDkyedU2bQ3dix0z8=;
        h=From:To:Cc:Subject:Date:From;
        b=A14aw1yTqcUhUrNpI2bVbqfIxCPETmpzk7/ZGjlGMb4N6tAAoV1XcWjKg/fOHDo4U
         FxTp74mxzJjTooDaRzxQMEfXAds0Z7VSIMH8SVNf2FyoOjjKShbsBHcj6Q2vnBtT7J
         Z4o5wjo+fjG888Qt6K6Rz0aTdkWFnL8Zij4yblKJagksqbZQyXf56IYXFIMqAK8Qbl
         dDVXXRSTSVk9zzNfJkQi7oejSvLxriQIgu4EfLZiUpyTg297DS/ect73DJGk4vNK/p
         g8JCOMLpzdBs/QHcqaiYxbbwCNpmLxWVZ7DlM8W0UgoXS2bcGuH22NOtIwdF7v5Xzr
         JrJBiSy6A2Nzg==
From:   Chao Yu <chao@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: [PATCH] proc: introduce proc_statfs()
Date:   Tue, 10 Jan 2023 23:20:03 +0800
Message-Id: <20230110152003.1118777-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce proc_statfs() to replace simple_statfs(), so that
f_bsize queried from statfs() can be consistent w/ the value we
set in s_blocksize.

stat -f /proc/

Before:
    ID: 0        Namelen: 255     Type: proc
Block size: 4096       Fundamental block size: 4096
Blocks: Total: 0          Free: 0          Available: 0
Inodes: Total: 0          Free: 0

After:
    ID: 0        Namelen: 255     Type: proc
Block size: 1024       Fundamental block size: 1024
Blocks: Total: 0          Free: 0          Available: 0
Inodes: Total: 0          Free: 0

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/proc/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..d39e3b9b3135 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/mount.h>
 #include <linux/bug.h>
+#include <linux/statfs.h>
 
 #include "internal.h"
 
@@ -176,6 +177,14 @@ static inline const char *hidepid2str(enum proc_hidepid v)
 	return "unknown";
 }
 
+static int proc_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	buf->f_type = dentry->d_sb->s_magic;
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+	buf->f_namelen = PROC_NAME_LEN;
+	return 0;
+}
+
 static int proc_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
@@ -195,7 +204,7 @@ const struct super_operations proc_sops = {
 	.free_inode	= proc_free_inode,
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= proc_evict_inode,
-	.statfs		= simple_statfs,
+	.statfs		= proc_statfs,
 	.show_options	= proc_show_options,
 };
 
-- 
2.25.1

