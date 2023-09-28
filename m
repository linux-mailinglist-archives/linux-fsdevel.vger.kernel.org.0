Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA17B1A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjI1LI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjI1LH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:07:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37F219A8;
        Thu, 28 Sep 2023 04:05:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0FEC433C7;
        Thu, 28 Sep 2023 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899114;
        bh=UZbYji3vGdjWb2eeDZnDkQs3Num0C8JGBZvtY9Wk2uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCIomNvBbCcyXwBR2i9dwdEJRvhjHbaAVB6/bk4o7MvRbSGOoQHnF0VioXsJ5rAlU
         vtxNIbwERmrDajJ5WmuXfTMRZ8P4dJdSnartvY92TuO7LRXwGCoLVSobu3uiqeOAyv
         89b2Hga3sKmfjAN9dQQ+KsS8D+GFH5WcAAmJyDZSJqx7Kb3Y9UUQkgWtKFfcosPq+F
         7myn7E0kaFdrNP4ipOCTkKBGJV9KztNd1vE/5fQ0Cxtk37ROFNcY2rniyyfOX60Gwa
         iSdnJl7y/SAqrSicTS6GyL82LcH747l2XZ2fYVXoI725ETQPb8qJCRw9BmQW4Vs+Th
         yiJDFs9bv3ENA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH 51/87] fs/nfsd: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:00 -0400
Message-ID: <20230928110413.33032-50-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/blocklayout.c | 3 ++-
 fs/nfsd/nfs3proc.c    | 4 ++--
 fs/nfsd/nfs4proc.c    | 8 ++++----
 fs/nfsd/nfsctl.c      | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 01d7fd108cf3..bdc582777738 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -119,10 +119,11 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 {
 	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
+	struct timespec64 mtime = inode_get_mtime(inode);
 	int error;
 
 	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
+	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
 		lcp->lc_mtime = current_time(inode);
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 268ef57751c4..b1c90a901d3e 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS3_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
+			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				break;
 			}
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4199ede0583c..b17309aac0d5 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
+			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				break;		/* subtle */
@@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime(d_inode(child)).tv_sec == v_mtime &&
+			    inode_get_atime(d_inode(child)).tv_sec == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				goto set_attr;	/* subtle */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a36..846559e4769b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1132,7 +1132,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	/* Following advice from simple_fill_super documentation: */
 	inode->i_ino = iunique(sb, NFSD_MaxReserved);
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
-- 
2.41.0

