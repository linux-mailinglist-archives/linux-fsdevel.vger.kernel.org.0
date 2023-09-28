Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CE7B1A0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjI1LI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjI1LH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:07:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBF19A0;
        Thu, 28 Sep 2023 04:05:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D528CC433C9;
        Thu, 28 Sep 2023 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899112;
        bh=SxtrHPABulsfIbZf0RrS3wMkJgGsWIGNvlX5kwWHXrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGc6IZYSlrFM13fw/pdZYDWmsU0wawDFuRbngjHDkQuJoE4TppFHnmJn+8XuKzj6O
         bNcLw1Ht6+i2kplBFIt44Ph1CN7xeke2mk+XhgK6ISe1SgPLrq+d+VCE35cXk56o40
         1qyvm78pnk/N7Z8jfmv6kiFxQrF+Yz32sQeLrMXU9Y/Be8Jyuv/Z+VCzY82fFJNsOn
         ytAPISsp7XHUrfSfouG05rX4FmvZf/pHlQm9Eirj+xxIIxU32SD6Mmz+nyA2OWPxqQ
         FHH/X1riRdNoj7F51GCtnbwHiI9KHthMbXsuAWxE7QEJ2GwjIl6+M9LCxOVMoN2bB1
         YgmsvitGUtsHA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 50/87] fs/nfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:59 -0400
Message-ID: <20230928110413.33032-49-jlayton@kernel.org>
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
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/fscache.h       |  4 ++--
 fs/nfs/inode.c         | 30 +++++++++++++++---------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 6bed1394d748..96a4923080ae 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -60,7 +60,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
 	res->ctime = inode_get_ctime(inode);
-	res->mtime = inode->i_mtime;
+	res->mtime = inode_get_mtime(inode);
 	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
 		args->bitmap[0];
 	res->bitmap[1] = (FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY) &
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 2dc64454492b..5407ab8c8783 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -114,8 +114,8 @@ static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *
 					      struct inode *inode)
 {
 	memset(auxdata, 0, sizeof(*auxdata));
-	auxdata->mtime_sec  = inode->i_mtime.tv_sec;
-	auxdata->mtime_nsec = inode->i_mtime.tv_nsec;
+	auxdata->mtime_sec  = inode_get_mtime(inode).tv_sec;
+	auxdata->mtime_nsec = inode_get_mtime(inode).tv_nsec;
 	auxdata->ctime_sec  = inode_get_ctime(inode).tv_sec;
 	auxdata->ctime_nsec = inode_get_ctime(inode).tv_nsec;
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e21c073158e5..ebb8d60e1152 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -512,8 +512,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		} else
 			init_special_inode(inode, inode->i_mode, fattr->rdev);
 
-		memset(&inode->i_atime, 0, sizeof(inode->i_atime));
-		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
+		inode_set_atime(inode, 0, 0);
+		inode_set_mtime(inode, 0, 0);
 		inode_set_ctime(inode, 0, 0);
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
@@ -527,11 +527,11 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		nfsi->read_cache_jiffies = fattr->time_start;
 		nfsi->attr_gencount = fattr->gencount;
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-			inode->i_atime = fattr->atime;
+			inode_set_atime_to_ts(inode, fattr->atime);
 		else if (fattr_supported & NFS_ATTR_FATTR_ATIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			inode->i_mtime = fattr->mtime;
+			inode_set_mtime_to_ts(inode, fattr->mtime);
 		else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
@@ -742,9 +742,9 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_ATIME
 				| NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-			inode->i_atime = fattr->atime;
+			inode_set_atime_to_ts(inode, fattr->atime);
 		else if (attr->ia_valid & ATTR_ATIME_SET)
-			inode->i_atime = attr->ia_atime;
+			inode_set_atime_to_ts(inode, attr->ia_atime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 
@@ -758,9 +758,9 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		NFS_I(inode)->cache_validity &= ~(NFS_INO_INVALID_MTIME
 				| NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-			inode->i_mtime = fattr->mtime;
+			inode_set_mtime_to_ts(inode, fattr->mtime);
 		else if (attr->ia_valid & ATTR_MTIME_SET)
-			inode->i_mtime = attr->ia_mtime;
+			inode_set_mtime_to_ts(inode, attr->ia_mtime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 
@@ -1451,11 +1451,11 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		inode_set_ctime_to_ts(inode, fattr->ctime);
 	}
 
-	ts = inode->i_mtime;
+	ts = inode_get_mtime(inode);
 	if ((fattr->valid & NFS_ATTR_FATTR_PREMTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_MTIME)
 			&& timespec64_equal(&ts, &fattr->pre_mtime)) {
-		inode->i_mtime = fattr->mtime;
+		inode_set_mtime_to_ts(inode, fattr->mtime);
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_PRESIZE)
 			&& (fattr->valid & NFS_ATTR_FATTR_SIZE)
@@ -1506,7 +1506,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 		if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 && !inode_eq_iversion_raw(inode, fattr->change_attr))
 			invalid |= NFS_INO_INVALID_CHANGE;
 
-		ts = inode->i_mtime;
+		ts = inode_get_mtime(inode);
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
 			invalid |= NFS_INO_INVALID_MTIME;
 
@@ -1534,7 +1534,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 	if ((fattr->valid & NFS_ATTR_FATTR_NLINK) && inode->i_nlink != fattr->nlink)
 		invalid |= NFS_INO_INVALID_NLINK;
 
-	ts = inode->i_atime;
+	ts = inode_get_atime(inode);
 	if ((fattr->valid & NFS_ATTR_FATTR_ATIME) && !timespec64_equal(&ts, &fattr->atime))
 		invalid |= NFS_INO_INVALID_ATIME;
 
@@ -2002,7 +2002,7 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PREMTIME) == 0) {
-		fattr->pre_mtime = inode->i_mtime;
+		fattr->pre_mtime = inode_get_mtime(inode);
 		fattr->valid |= NFS_ATTR_FATTR_PREMTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_SIZE) != 0 &&
@@ -2184,7 +2184,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	}
 
 	if (fattr->valid & NFS_ATTR_FATTR_MTIME)
-		inode->i_mtime = fattr->mtime;
+		inode_set_mtime_to_ts(inode, fattr->mtime);
 	else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MTIME;
@@ -2220,7 +2220,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			save_cache_validity & NFS_INO_INVALID_SIZE;
 
 	if (fattr->valid & NFS_ATTR_FATTR_ATIME)
-		inode->i_atime = fattr->atime;
+		inode_set_atime_to_ts(inode, fattr->atime);
 	else if (fattr_supported & NFS_ATTR_FATTR_ATIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_ATIME;
-- 
2.41.0

