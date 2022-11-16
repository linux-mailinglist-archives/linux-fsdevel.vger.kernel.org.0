Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE462C237
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiKPPRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbiKPPRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1A4E422;
        Wed, 16 Nov 2022 07:17:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C2E5B81DC3;
        Wed, 16 Nov 2022 15:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA57C4347C;
        Wed, 16 Nov 2022 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611856;
        bh=ZcWVwR1/kYODme5i6GoYMexE29jNpM2YaaFPdn+Cywc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJ3Vuq+Ctl+m/ZJRd5aS7hKmoK7xQqGGtY14xMamxm3SPj3RtNDQdHKxGvy56Nll6
         G14gzQbWkIcTKEkicikhWg8W6Kxx0SQnF0UbPUqjcfSRA4tmCm2X2muDOpn45IJUcN
         CJGrXfa/U/MrTx1VfgLC7b9GqAniav3inXSFQci+lU8gCF2T/UZ1aMivL+tZrFSCbw
         AMGuPeNFmIPmaa2LrynUxImhJEVpzN654HSZN38tohHF+Fydbj9q/KY4+ey/iw+V/3
         P7sVGmdNDk5yBRVr/pimN4NIZ+X+cno3C4ckSRsXuT+aEx6gHov252016Ue18fpLys
         +frDQJsXlgK/w==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH 6/7] nfs: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:25 -0500
Message-Id: <20221116151726.129217-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116151726.129217-1-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
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

nfs currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/delegation.c | 2 +-
 fs/nfs/nfs4state.c  | 2 +-
 fs/nfs/pagelist.c   | 2 +-
 fs/nfs/write.c      | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index ead8a0e06abf..cf7365581031 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -146,7 +146,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 {
 	struct inode *inode = state->inode;
 	struct file_lock *fl;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct list_head *list;
 	int status = 0;
 
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index a2d2d5d1b088..dd18344648f3 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1501,7 +1501,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	struct file_lock *fl;
 	struct nfs4_lock_state *lsp;
 	int status = 0;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct list_head *list;
 
 	if (flctx == NULL)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 317cedfa52bf..16be6dae524f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1055,7 +1055,7 @@ static unsigned int nfs_coalesce_size(struct nfs_page *prev,
 	if (prev) {
 		if (!nfs_match_open_context(nfs_req_openctx(req), nfs_req_openctx(prev)))
 			return 0;
-		flctx = d_inode(nfs_req_openctx(req)->dentry)->i_flctx;
+		flctx = locks_inode_context(d_inode(nfs_req_openctx(req)->dentry));
 		if (flctx != NULL &&
 		    !(list_empty_careful(&flctx->flc_posix) &&
 		      list_empty_careful(&flctx->flc_flock)) &&
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f41d24b54fd1..80c240e50952 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1185,7 +1185,7 @@ int nfs_flush_incompatible(struct file *file, struct page *page)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct nfs_lock_context *l_ctx;
-	struct file_lock_context *flctx = file_inode(file)->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(file_inode(file));
 	struct nfs_page	*req;
 	int do_flush, status;
 	/*
@@ -1321,7 +1321,7 @@ static int nfs_can_extend_write(struct file *file, struct page *page,
 				struct inode *inode, unsigned int pagelen)
 {
 	int ret;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct file_lock *fl;
 
 	if (file->f_flags & O_DSYNC)
-- 
2.38.1

