Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA6F717CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjEaKEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjEaKEU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 06:04:20 -0400
X-Greylist: delayed 359 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 03:04:18 PDT
Received: from out-58.mta0.migadu.com (out-58.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DA7E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 03:04:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685527121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1v6Nmr+iDUp1so91WjqnHTNpH9v5OnKQ0PJi2AfGq4=;
        b=rS4mRe4LmeoSOb/mL2JDcthPretqgBkrv8Kq1Nka9fPmRIXJQ4mg/9Wg8Bj9SViBUA7yr6
        PoZXbDH9wstFXz3FQzUyM1geHY3OxQh815EPwbi4X/Zntio/xy3pCNOacpjQfTALY9gKYI
        zTMcUPF8nNFvCOF+ZtfaP9t9mQ6pBAk=
From:   Qi Zheng <qi.zheng@linux.dev>
To:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 6/8] xfs: introduce xfs_fs_destroy_super()
Date:   Wed, 31 May 2023 09:57:40 +0000
Message-Id: <20230531095742.2480623-7-qi.zheng@linux.dev>
In-Reply-To: <20230531095742.2480623-1-qi.zheng@linux.dev>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kirill Tkhai <tkhai@ya.ru>

xfs_fs_nr_cached_objects() touches sb->s_fs_info,
and this patch makes it to be destructed later.

After this patch xfs_fs_nr_cached_objects() is safe
for splitting unregister_shrinker(): mp->m_perag_tree
is stable till destroy_super_work(), while iteration
over it is already RCU-protected by internal XFS
business.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/xfs/xfs_super.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 7e706255f165..694616524c76 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -743,11 +743,18 @@ xfs_fs_drop_inode(
 }
 
 static void
-xfs_mount_free(
+xfs_free_names(
 	struct xfs_mount	*mp)
 {
 	kfree(mp->m_rtname);
 	kfree(mp->m_logname);
+}
+
+static void
+xfs_mount_free(
+	struct xfs_mount	*mp)
+{
+	xfs_free_names(mp);
 	kmem_free(mp);
 }
 
@@ -1136,8 +1143,19 @@ xfs_fs_put_super(
 	xfs_destroy_mount_workqueues(mp);
 	xfs_close_devices(mp);
 
-	sb->s_fs_info = NULL;
-	xfs_mount_free(mp);
+	xfs_free_names(mp);
+}
+
+static void
+xfs_fs_destroy_super(
+	struct super_block	*sb)
+{
+	if (sb->s_fs_info) {
+		struct xfs_mount	*mp = XFS_M(sb);
+
+		kmem_free(mp);
+		sb->s_fs_info = NULL;
+	}
 }
 
 static long
@@ -1165,6 +1183,7 @@ static const struct super_operations xfs_super_operations = {
 	.dirty_inode		= xfs_fs_dirty_inode,
 	.drop_inode		= xfs_fs_drop_inode,
 	.put_super		= xfs_fs_put_super,
+	.destroy_super		= xfs_fs_destroy_super,
 	.sync_fs		= xfs_fs_sync_fs,
 	.freeze_fs		= xfs_fs_freeze,
 	.unfreeze_fs		= xfs_fs_unfreeze,
-- 
2.30.2

