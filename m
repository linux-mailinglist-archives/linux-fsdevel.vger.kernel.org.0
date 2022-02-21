Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE84BE851
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350619AbiBUJel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 04:34:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350603AbiBUJea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:34:30 -0500
X-Greylist: delayed 1838 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 01:14:21 PST
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2D0329CA6
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 01:14:21 -0800 (PST)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 21 Feb 2022 17:43:40 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: kyeongdon.kim@lge.com
Received: from unknown (HELO localhost.localdomain) (10.159.40.99)
        by 156.147.1.126 with ESMTP; 21 Feb 2022 17:43:40 +0900
X-Original-SENDERIP: 10.159.40.99
X-Original-MAILFROM: kyeongdon.kim@lge.com
From:   Kyeongdon Kim <kyeongdon.kim@lge.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kyeongdon.kim@lge.com
Subject: [PATCH] pipe: use kmem_cache for pipe_inode_info
Date:   Mon, 21 Feb 2022 17:43:37 +0900
Message-Id: <20220221084337.207414-1-kyeongdon.kim@lge.com>
X-Mailer: git-send-email 2.10.2
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because kzalloc() is used,
the allocation size of pipe_inode_info is fixex at 192bytes,
but it's only use 144bytes per each.
We can use kmem_cache_zalloc() to reduce some dynamic allocation size.

Signed-off-by: Kyeongdon Kim <kyeongdon.kim@lge.com>
---
 fs/pipe.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7194683..3054816 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -47,6 +47,9 @@
  */
 #define PIPE_MIN_DEF_BUFFERS 2
 
+/* SLAB cache for pipe inode */
+static struct kmem_cache *pipe_inode_cachep;
+
 /*
  * The max size that a non-root user is allowed to grow the pipe. Can
  * be set by root in /proc/sys/fs/pipe-max-size
@@ -786,7 +789,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	unsigned long user_bufs;
 	unsigned int max_size = READ_ONCE(pipe_max_size);
 
-	pipe = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL_ACCOUNT);
+	pipe = kmem_cache_zalloc(pipe_inode_cachep, GFP_KERNEL_ACCOUNT);
 	if (pipe == NULL)
 		goto out_free_uid;
 
@@ -820,7 +823,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 
 out_revert_acct:
 	(void) account_pipe_buffers(user, pipe_bufs, 0);
-	kfree(pipe);
+	kmem_cache_free(pipe_inode_cachep, pipe);
 out_free_uid:
 	free_uid(user);
 	return NULL;
@@ -847,7 +850,7 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	if (pipe->tmp_page)
 		__free_page(pipe->tmp_page);
 	kvfree(pipe->bufs);
-	kfree(pipe);
+	kmem_cache_free(pipe_inode_cachep, pipe);
 }
 
 static struct vfsmount *pipe_mnt __read_mostly;
@@ -1496,6 +1499,9 @@ static int __init init_pipe_fs(void)
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("fs", fs_pipe_sysctls);
 #endif
+	pipe_inode_cachep = kmem_cache_create("pipe_inode",
+					sizeof(struct pipe_inode_info),
+					0, SLAB_PANIC, NULL);
 	return err;
 }
 
-- 
2.10.2

