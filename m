Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE1762157
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGYSbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjGYSbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB21FC4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 11:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B38A461861
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 18:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA0EC433C7;
        Tue, 25 Jul 2023 18:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690309866;
        bh=F5JqDshbxaXCKris4572/rBxtI1EmqM7jtTeptVm1Hg=;
        h=Subject:From:To:Cc:Date:From;
        b=GaMZE71Ta/JLhienrTM3trvjeVgjaWFXxXsfKf4Wnm964prrKS4U6YQuXe0+dUQ5j
         J9I2JOg0vHRHJvF5cjzIPg73WNpz6XbdrKyMuTMXHpRxQ8TctI3I9iIKiTPbQtgihj
         bOmdgsUQu77EI3p6U/fVma77YnQVMv5RLSMDz3+dGzC/JyGX8TBUM48OH96EQk9BzR
         5XNcdiso7pSCs9T9onwgxkLe/xglfJLRlQVvEVRPcSVOEa0y2w4UFiq1x4azqOKLQk
         Rx3SbH8GTGeKbNs1HMHY8KeUHUSz+fabZDbzjRff37ijHXdvYob3nqB610bebLO29J
         D6zp+bsYW+hgQ==
Subject: [PATCH RFC] libfs: Remove parent dentry locking in
 offset_iterate_dir()
From:   Chuck Lever <cel@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, oliver.sang@intel.com,
        oe-lkp@lists.linux.dev, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Date:   Tue, 25 Jul 2023 14:31:04 -0400
Message-ID: <169030957098.157536.9938425508695693348.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Since offset_iterate_dir() does not walk the parent's d_subdir list
nor does it manipulate the parent's d_child, there doesn't seem to
be a reason to hold the parent's d_lock. The offset_ctx's xarray can
be sufficiently protected with just the RCU read lock.

Flame graph data captured during the git regression run shows a
20% reduction in CPU cycles consumed in offset_find_next().

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202307171640.e299f8d5-oliver.sang@intel.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

This is a possible fix for the will-it-scale regression recently
reported by the kernel test robot. It passes the git regression
test over NFS and doesn't seem to perturb xfstests.

I'm not able to run lkp here yet, so anyone who can run the
will-it-scale test, please report the results. Many thanks.


diff --git a/fs/libfs.c b/fs/libfs.c
index fcc0f1f3c2dc..b69c41fb3c63 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -406,7 +406,7 @@ static struct dentry *offset_find_next(struct xa_state *xas)
 	child = xas_next_entry(xas, U32_MAX);
 	if (!child)
 		goto out;
-	spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+	spin_lock(&child->d_lock);
 	if (simple_positive(child))
 		found = dget_dlock(child);
 	spin_unlock(&child->d_lock);
@@ -424,17 +424,14 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void offset_iterate_dir(struct dentry *dir, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
-	struct inode *inode = d_inode(dir);
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
 	struct dentry *dentry;
 
 	while (true) {
-		spin_lock(&dir->d_lock);
 		dentry = offset_find_next(&xas);
-		spin_unlock(&dir->d_lock);
 		if (!dentry)
 			break;
 
@@ -478,7 +475,7 @@ static int offset_readdir(struct file *file, struct dir_context *ctx)
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	offset_iterate_dir(dir, ctx);
+	offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 


