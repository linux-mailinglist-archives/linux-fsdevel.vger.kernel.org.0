Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93905748D46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjGETIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjGETII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C8B1FE0;
        Wed,  5 Jul 2023 12:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658AD616FB;
        Wed,  5 Jul 2023 19:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F714C433C7;
        Wed,  5 Jul 2023 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583886;
        bh=Jw3LMAKGkOFsBOZVpJySAYN8+fhYTz3ENhYo/GQ/OLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti5fV8z4pDl8/2IziWx/TrQmtZnwPXVBjS0Nqs2h1e5ESQhKVX5J34spB7hE8+4Ju
         DPEYYAkhkfvsMX3OCi+LK5WC1fCA75kaHHNC/Xd11yEOCPOTaJKWJKsc6gF2qtyqBJ
         2cNYS+YBiaIqzYUZztNFNLesPP0aji0L8Cr8RvHuR22r9LCshRNEZIipbr89dx+Nyk
         +GIzLLb4lFBY2ukzmGRfzrguAxD0RkZxUK+dNenFnx6FQBtVza2ikKY9tjIbem/Kn8
         fTMsjPbO+XrUFKnV9kefmeSFJFysW+0UyWeJcjIHnqh8tQbLjX8Nm8xUp6cMi6znD7
         JSOM6b0XqIS+g==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2 57/92] nfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:22 -0400
Message-ID: <20230705190309.579783-55-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/callback_proc.c |  2 +-
 fs/nfs/fscache.h       |  4 ++--
 fs/nfs/inode.c         | 20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index c1eda73254e1..6bed1394d748 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -59,7 +59,7 @@ __be32 nfs4_callback_getattr(void *argp, void *resp,
 	res->change_attr = delegation->change_attr;
 	if (nfs_have_writebacks(inode))
 		res->change_attr++;
-	res->ctime = inode->i_ctime;
+	res->ctime = inode_get_ctime(inode);
 	res->mtime = inode->i_mtime;
 	res->bitmap[0] = (FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE) &
 		args->bitmap[0];
diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index e1706e736c64..2dc64454492b 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -116,8 +116,8 @@ static inline void nfs_fscache_update_auxdata(struct nfs_fscache_inode_auxdata *
 	memset(auxdata, 0, sizeof(*auxdata));
 	auxdata->mtime_sec  = inode->i_mtime.tv_sec;
 	auxdata->mtime_nsec = inode->i_mtime.tv_nsec;
-	auxdata->ctime_sec  = inode->i_ctime.tv_sec;
-	auxdata->ctime_nsec = inode->i_ctime.tv_nsec;
+	auxdata->ctime_sec  = inode_get_ctime(inode).tv_sec;
+	auxdata->ctime_nsec = inode_get_ctime(inode).tv_nsec;
 
 	if (NFS_SERVER(inode)->nfs_client->rpc_ops->version == 4)
 		auxdata->change_attr = inode_peek_iversion_raw(inode);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8172dd4135a1..1283fdfa4b0a 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -514,7 +514,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 
 		memset(&inode->i_atime, 0, sizeof(inode->i_atime));
 		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
-		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
+		inode_set_ctime(inode, 0, 0);
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -535,7 +535,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		else if (fattr_supported & NFS_ATTR_FATTR_MTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
@@ -731,7 +731,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_GID) != 0)
 			inode->i_gid = attr->ia_gid;
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -749,7 +749,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -765,7 +765,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME);
 
 		if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-			inode->i_ctime = fattr->ctime;
+			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CHANGE
 					| NFS_INO_INVALID_CTIME);
@@ -1444,11 +1444,11 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
-	ts = inode->i_ctime;
+	ts = inode_get_ctime(inode);
 	if ((fattr->valid & NFS_ATTR_FATTR_PRECTIME)
 			&& (fattr->valid & NFS_ATTR_FATTR_CTIME)
 			&& timespec64_equal(&ts, &fattr->pre_ctime)) {
-		inode->i_ctime = fattr->ctime;
+		inode_set_ctime_to_ts(inode, fattr->ctime);
 	}
 
 	ts = inode->i_mtime;
@@ -1510,7 +1510,7 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
 		if ((fattr->valid & NFS_ATTR_FATTR_MTIME) && !timespec64_equal(&ts, &fattr->mtime))
 			invalid |= NFS_INO_INVALID_MTIME;
 
-		ts = inode->i_ctime;
+		ts = inode_get_ctime(inode);
 		if ((fattr->valid & NFS_ATTR_FATTR_CTIME) && !timespec64_equal(&ts, &fattr->ctime))
 			invalid |= NFS_INO_INVALID_CTIME;
 
@@ -1997,7 +1997,7 @@ int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fa
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_CTIME) != 0 &&
 			(fattr->valid & NFS_ATTR_FATTR_PRECTIME) == 0) {
-		fattr->pre_ctime = inode->i_ctime;
+		fattr->pre_ctime = inode_get_ctime(inode);
 		fattr->valid |= NFS_ATTR_FATTR_PRECTIME;
 	}
 	if ((fattr->valid & NFS_ATTR_FATTR_MTIME) != 0 &&
@@ -2190,7 +2190,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			save_cache_validity & NFS_INO_INVALID_MTIME;
 
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
-		inode->i_ctime = fattr->ctime;
+		inode_set_ctime_to_ts(inode, fattr->ctime);
 	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CTIME;
-- 
2.41.0

