Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9145B2477
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiIHRZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiIHRZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:25:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF927FE6;
        Thu,  8 Sep 2022 10:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9635B61DC6;
        Thu,  8 Sep 2022 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C01C433D6;
        Thu,  8 Sep 2022 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657908;
        bh=1d8SlxiMee3v30kC+qO7G0LMkoymE6ghnC1k8q+hGZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFMQp/LTTlCkDlKn92/X3tfHWOHHfgkDXgI9vgEevBM+ryfq0bKMd5IMFdYVEMtwF
         lxBsO0vEg4FONnL1EgdARB3RgAY/FxboaNFZSa/w8GPguBAdb+Cna3jUv0PfCR5BXH
         gZzf3hrJoAwmsuKcHjHFD8VMyVWKUbRyJg7/DhT4wJT10i7Nm3/bKDznP5BbbQb4ju
         ovKASAgfb4fhpKWB6Y+ysHICiwz0dumpzMsoIodw4dgt3WyxgeBi9forfqP7lGw5Xf
         k8ZMRZhv1OxfWXwfy7DZVgsMjKEM/Pg/Bln7i8esqC0sghpOz7OMsFV10EDAr3UMhY
         y6HTT7AU8JLlg==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 7/8] nfsd: use the getattr operation to fetch i_version
Date:   Thu,  8 Sep 2022 13:24:47 -0400
Message-Id: <20220908172448.208585-8-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908172448.208585-1-jlayton@kernel.org>
References: <20220908172448.208585-1-jlayton@kernel.org>
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

Now that we can call into vfs_getattr to get the i_version field, use
that facility to fetch it instead of doing it in nfsd4_change_attribute.

Set the STATX_INO_VERSION (and BTIME) bits in the request when we're
dealing with a v4 request. Then, instead of looking at IS_I_VERSION
when generating the change attr, look at the result mask and only use
it if STATX_INO_VERSION is set.

With this change, we can drop the fetch_iversion export operation as
well.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/export.c          | 7 -------
 fs/nfsd/nfs4xdr.c        | 4 +++-
 fs/nfsd/nfsfh.c          | 6 ++++++
 fs/nfsd/nfsfh.h          | 9 ++++-----
 fs/nfsd/vfs.h            | 7 ++++++-
 include/linux/exportfs.h | 1 -
 6 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 01596f2d0a1e..1a9d5aa51dfb 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -145,17 +145,10 @@ nfs_get_parent(struct dentry *dentry)
 	return parent;
 }
 
-static u64 nfs_fetch_iversion(struct inode *inode)
-{
-	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
-	return inode_peek_iversion_raw(inode);
-}
-
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
 		EXPORT_OP_NOATOMIC_ATTR,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5980df859c3a..4eec2ce05e7e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2872,7 +2872,9 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = vfs_getattr(&path, &stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
+	err = vfs_getattr(&path, &stat,
+			  STATX_BASIC_STATS | STATX_BTIME | STATX_INO_VERSION,
+			  AT_STATX_SYNC_AS_STAT);
 	if (err)
 		goto out_nfserr;
 	if (!(stat.result_mask & STATX_BTIME))
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index a5b71526cee0..798f5d8d2055 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -634,6 +634,10 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 		stat.mtime = inode->i_mtime;
 		stat.ctime = inode->i_ctime;
 		stat.size  = inode->i_size;
+		if (v4 && IS_I_VERSION(inode)) {
+			stat.ino_version = inode_query_iversion(inode);
+			stat.result_mask |= STATX_INO_VERSION;
+		}
 	}
 	if (v4)
 		fhp->fh_pre_change = nfsd4_change_attribute(&stat, inode);
@@ -665,6 +669,8 @@ void fh_fill_post_attrs(struct svc_fh *fhp)
 	if (err) {
 		fhp->fh_post_saved = false;
 		fhp->fh_post_attr.ctime = inode->i_ctime;
+		if (v4 && IS_I_VERSION(inode))
+			fhp->fh_post_attr.ino_version = inode_query_iversion(inode);
 	} else
 		fhp->fh_post_saved = true;
 	if (v4)
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index c3ae6414fc5c..3786b181d5ce 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -305,18 +305,17 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 static inline u64 nfsd4_change_attribute(struct kstat *stat,
 					 struct inode *inode)
 {
-	if (inode->i_sb->s_export_op->fetch_iversion)
-		return inode->i_sb->s_export_op->fetch_iversion(inode);
-	else if (IS_I_VERSION(inode)) {
+	if (stat->result_mask & STATX_INO_VERSION) {
 		u64 chattr;
 
 		chattr =  stat->ctime.tv_sec;
 		chattr <<= 30;
 		chattr += stat->ctime.tv_nsec;
-		chattr += inode_query_iversion(inode);
+		chattr += stat->ino_version;
 		return chattr;
-	} else
+	} else {
 		return time_to_chattr(&stat->ctime);
+	}
 }
 
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c95cd414b4bb..8a3a5dbde5fa 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -168,9 +168,14 @@ static inline void fh_drop_write(struct svc_fh *fh)
 
 static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
+	u32 request_mask = STATX_BASIC_STATS;
 	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
 			 .dentry = fh->fh_dentry};
-	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
+
+	if (fh->fh_maxsize == NFS4_FHSIZE)
+		request_mask |= (STATX_BTIME | STATX_INO_VERSION);
+
+	return nfserrno(vfs_getattr(&p, stat, request_mask,
 				    AT_STATX_SYNC_AS_STAT));
 }
 
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index fe848901fcc3..9f4d4bcbf251 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -213,7 +213,6 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
-	u64 (*fetch_iversion)(struct inode *);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
-- 
2.37.3

