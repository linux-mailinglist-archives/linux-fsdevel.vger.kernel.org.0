Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DFD62C23A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKPPRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiKPPRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81EF51C03;
        Wed, 16 Nov 2022 07:17:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66532B81DC7;
        Wed, 16 Nov 2022 15:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA6C433C1;
        Wed, 16 Nov 2022 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611857;
        bh=IWBPFyJfGw10+bVeE4FZLU5ReB6gH3wpytKDa6wKi9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp2IB2VerS3UiYrnZbhW0RTGCbAxqV4oGtE77lfA2SwEE3xzClX1PiAhYQEm6lmnk
         0HPhsu1tpuVFcuYFlzkvUlnuXgT/a2RNV6vmEWbwUr2ujamMpSawjKmcnxAzr5A140
         Yq8/lvQl5X1OOn0CQqgrBUL00v+mvXQKZPjobW/fCSyGSD5+baxlIMTMlZIVG6BfLc
         teErOgyVerjMWyx8dORZR7VCsyKFs7w7WfdSxOaGiuNCkZSsqWxlroBoqw3xv3qR9X
         TgzVSxlFhJcB2b3plRS0qGHnotckm1wKvPTWPIDLL13HO5LTSj4CMfqA4vmmCuRfCt
         dL++2egxxDhsw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de
Subject: [PATCH 7/7] nfsd: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:26 -0500
Message-Id: <20221116151726.129217-8-jlayton@kernel.org>
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

nfsd currently doesn't access i_flctx safely everywhere. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 836bd825ca4a..da8d0ea66229 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4758,7 +4758,7 @@ nfs4_share_conflict(struct svc_fh *current_fh, unsigned int deny_type)
 
 static bool nfsd4_deleg_present(const struct inode *inode)
 {
-	struct file_lock_context *ctx = smp_load_acquire(&inode->i_flctx);
+	struct file_lock_context *ctx = locks_inode_context(inode);
 
 	return ctx && !list_empty_careful(&ctx->flc_lease);
 }
@@ -5897,7 +5897,7 @@ nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
 
 	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
 		nf = stp->st_stid.sc_file;
-		ctx = nf->fi_inode->i_flctx;
+		ctx = locks_inode_context(nf->fi_inode);
 		if (!ctx)
 			continue;
 		if (locks_owner_has_blockers(ctx, lo))
@@ -7713,7 +7713,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 	}
 
 	inode = locks_inode(nf->nf_file);
-	flctx = inode->i_flctx;
+	flctx = locks_inode_context(inode);
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
 		spin_lock(&flctx->flc_lock);
-- 
2.38.1

