Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B66748D44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjGETIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjGETIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323F30E9;
        Wed,  5 Jul 2023 12:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 504B7616C4;
        Wed,  5 Jul 2023 19:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B789BC433C9;
        Wed,  5 Jul 2023 19:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583888;
        bh=nz4OgBYlsMOKdpSoA1HyBKv/O9jg4R14AE4cRb0Uh3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kan5Cvx9lHLoy6XyRcibzCs0nKOnNBUGlFOzV8oieR+t/dvFwzCsGh20hoDsdk4uG
         5nj1fIEwdvRV/XExVDTHN+tgIYw5xjbi3FNdnAXTzAidMKBG5gb3ZSOlqcAG5ynWW8
         6DsZ2QUSoqTrENweGMCX5O6lnAQ3s7MO2oIJbJzXHMDzQe8P9H/NWaX8AFUX0dL7Im
         vLaSjakV661euyKtWFPx4JWUfFKDcykpk30buOIZmPKjnjPC8FfxMbx4EZm0RdgEM/
         xVkXZS9LEUeNTNDr/tEOQSa0Rehaw3Yci6yxUulcbc52vKrvjp9JKzVxpRc7+knZd1
         jidF2E09cGkYw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 58/92] nfsd: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:23 -0400
Message-ID: <20230705190309.579783-56-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 2 +-
 fs/nfsd/vfs.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1b8b1aab9a15..a53c5660a8c4 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1131,7 +1131,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	/* Following advice from simple_fill_super documentation: */
 	inode->i_ino = iunique(sb, NFSD_MaxReserved);
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8a2321d19194..40a68bae88fc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -520,7 +520,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode->i_ctime.tv_sec)
+	if (check_guard && guardtime != inode_get_ctime(inode).tv_sec)
 		return nfserr_notsync;
 
 	/*
-- 
2.41.0

