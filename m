Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA27B8C29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbjJDS5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbjJDSza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F310FC;
        Wed,  4 Oct 2023 11:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB4C433CB;
        Wed,  4 Oct 2023 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445688;
        bh=pJnNsdencvKwZRbSlZ+blXLwAqnsIPx1YNtPzl1LJFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJtutZg6tWNN340g/jXrAr3pX1klt2TNzrwNNaZGsYnQZ2/AdEb9lrows+NaO0Ljp
         6BSgQvsxpy8XQaPXgF1rbbvZqWEwDh2qYf50j7GwKawcQjsV8erPMGtEYwxh3vfosw
         ncP9fAs06sjCz2F/bf+dY6Z1mqdt5zb5Dcmw5LcJqLfUtdm8GlMQs1wBzQRyCwPGrf
         yiofC9Er7trtM+j6CcRKV3ow7JcBofI3Wz8z0KqtPBjJe3r5SrsGWWmhke9oJzZ7qZ
         MlhtUs407eONSRPCDXndt//RA+GVh8wWZtRPJYfZqZ18NPqRm7CBrTnZViahx+yPeV
         0j3QTsuS83mCA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 52/89] nfsd: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:37 -0400
Message-ID: <20231004185347.80880-50-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/blocklayout.c | 3 ++-
 fs/nfsd/nfs3proc.c    | 4 ++--
 fs/nfsd/nfs4proc.c    | 8 ++++----
 fs/nfsd/nfsctl.c      | 2 +-
 fs/nfsd/vfs.c         | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 01d7fd108cf3..46fd74d91ea9 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -117,12 +117,13 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
+	struct timespec64 mtime = inode_get_mtime(inode);
 	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
 	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
+	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
 		lcp->lc_mtime = current_time(inode);
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 9571141701ff..b78eceebd945 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -295,8 +295,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS3_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				break;
 			}
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 60262fd27b15..2863ca530677 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				break;		/* subtle */
@@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				goto set_attr;	/* subtle */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b71744e355a8..2509b95d33d3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1133,7 +1133,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	/* Following advice from simple_fill_super documentation: */
 	inode->i_ino = iunique(sb, NFSD_MaxReserved);
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5bf3cffde831..9483c72ffbbd 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -538,7 +538,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode_get_ctime(inode).tv_sec)
+	if (check_guard && guardtime != inode_get_ctime_sec(inode))
 		return nfserr_notsync;
 
 	/*
-- 
2.41.0

