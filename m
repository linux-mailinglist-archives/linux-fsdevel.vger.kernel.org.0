Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA07B3C6F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhGMLSZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 07:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235390AbhGMLSZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 135B36023F;
        Tue, 13 Jul 2021 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626174935;
        bh=9qvYGFFvCFJdEJtArvHjO2+pUJ+InQnuNkHlgbKL7sY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4EshPL4vnyNryZlpd83w3q6SqWS1Ar2uYDYsruyvLxSCU9a2EvLIxgPoobSAB0mj
         AvtdwDdXu4v8OQxuyjp9GdHAkdeEFGojkWE9POUAwP4RwUW0QNhyCps9BGQXHG6otS
         5TLiFJpkBlAngDxY2DlwiVGYZ1DcCotAjJ5twJ7vvEKY96brMXNQ2kiFPRF/zrVdPE
         GWgVN5vV5n1UqyUxMPilJWbrOmabtq7kuafw97xvh1f93Zdlw3zYAIVgx/a7lW2t4d
         fuVrEKN2GyjYc5e+4yWeBPHtT8PzjK1p47Ule2Ynn3uoXLhFQ/Q1eNcKyNs97NZzkx
         2ekR1OGVrnISw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 03/24] namei: handle mappings in lookup_positive_unlocked()
Date:   Tue, 13 Jul 2021 13:13:23 +0200
Message-Id: <20210713111344.1149376-4-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713111344.1149376-1-brauner@kernel.org>
References: <20210713111344.1149376-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6848; h=from:subject; bh=/iZaQudmGJtAMTQgRcbLJUCNcpqUKhwGKbfR410yXTc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSS8LY34aWi0YjKXn94+x6dKF97NeX+pZu46RXWbniZR36dB kTvfdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk+2uG/5miZVy5TNm7pC2uWnvc+n jydU7VlfP+j6VOcvKvmWq09jbD/9gq9vV8QjzPJI9HOX46t/luZ7Yr02sLi4An0Tzz1iy/yA8A
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Various filesystems use the lookup_positive_unlocked() helper to lookup a
single path component relative to a well-known starting point. Allow such
filesystems to support idmapped mounts by enabling lookup_positive_unlocked()
to take the idmap into account when calling inode_permission(). This change is
a required to let btrfs (and other filesystems) support idmapped mounts.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/cifs/cifsfs.c      |  3 ++-
 fs/debugfs/inode.c    |  3 ++-
 fs/kernfs/mount.c     |  4 ++--
 fs/namei.c            |  7 ++++---
 fs/nfsd/nfs3xdr.c     |  3 ++-
 fs/nfsd/nfs4xdr.c     |  3 ++-
 fs/overlayfs/namei.c  | 10 ++++++----
 fs/quota/dquot.c      |  3 ++-
 include/linux/namei.h |  3 ++-
 9 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 64b71c4e2a9d..b61643427e46 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -804,7 +804,8 @@ cifs_get_root(struct smb3_fs_context *ctx, struct super_block *sb)
 		while (*s && *s != sep)
 			s++;
 
-		child = lookup_positive_unlocked(p, dentry, s - p);
+		child = lookup_positive_unlocked(&init_user_ns, p,
+						 dentry, s - p);
 		dput(dentry);
 		dentry = child;
 	} while (!IS_ERR(dentry));
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 92db343f35f4..eda31d0966a5 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -307,7 +307,8 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 	if (!parent)
 		parent = debugfs_mount->mnt_root;
 
-	dentry = lookup_positive_unlocked(name, parent, strlen(name));
+	dentry = lookup_positive_unlocked(&init_user_ns, name,
+					  parent, strlen(name));
 	if (IS_ERR(dentry))
 		return NULL;
 	return dentry;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 9dc7e7a64e10..20b8617e619b 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -223,8 +223,8 @@ struct dentry *kernfs_node_dentry(struct kernfs_node *kn,
 			dput(dentry);
 			return ERR_PTR(-EINVAL);
 		}
-		dtmp = lookup_positive_unlocked(kntmp->name, dentry,
-					       strlen(kntmp->name));
+		dtmp = lookup_positive_unlocked(&init_user_ns, kntmp->name,
+						dentry, strlen(kntmp->name));
 		dput(dentry);
 		if (IS_ERR(dtmp))
 			return dtmp;
diff --git a/fs/namei.c b/fs/namei.c
index 53561311b492..68489c23bc44 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2706,10 +2706,11 @@ EXPORT_SYMBOL(lookup_one_len_unlocked);
  * need to be very careful; pinned positives have ->d_inode stable, so
  * this one avoids such problems.
  */
-struct dentry *lookup_positive_unlocked(const char *name,
-				       struct dentry *base, int len)
+struct dentry *lookup_positive_unlocked(struct user_namespace *mnt_userns,
+					const char *name, struct dentry *base,
+					int len)
 {
-	struct dentry *ret = lookup_one_len_unlocked(&init_user_ns, name, base, len);
+	struct dentry *ret = lookup_one_len_unlocked(mnt_userns, name, base, len);
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		dput(ret);
 		ret = ERR_PTR(-ENOENT);
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..0fad12be94cd 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1109,7 +1109,8 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		} else
 			dchild = dget(dparent);
 	} else
-		dchild = lookup_positive_unlocked(name, dparent, namlen);
+		dchild = lookup_positive_unlocked(&init_user_ns, name,
+						  dparent, namlen);
 	if (IS_ERR(dchild))
 		return rv;
 	if (d_mountpoint(dchild))
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..a0425d120e6a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3413,7 +3413,8 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
+	dentry = lookup_positive_unlocked(&init_user_ns, name,
+					  cd->rd_fhp->fh_dentry, namlen);
 	if (IS_ERR(dentry))
 		return nfserrno(PTR_ERR(dentry));
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 291985b79a6d..52721af35dcf 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -673,7 +673,8 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(&init_user_ns, name.name,
+					 ofs->indexdir, name.len);
 	kfree(name.name);
 	if (IS_ERR(index)) {
 		if (PTR_ERR(index) == -ENOENT)
@@ -705,7 +706,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_unlocked(&init_user_ns, name.name,
+					 ofs->indexdir, name.len);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 		if (err == -ENOENT) {
@@ -1164,8 +1166,8 @@ bool ovl_lower_positive(struct dentry *dentry)
 		struct dentry *this;
 		struct dentry *lowerdir = poe->lowerstack[i].dentry;
 
-		this = lookup_positive_unlocked(name->name, lowerdir,
-					       name->len);
+		this = lookup_positive_unlocked(&init_user_ns, name->name,
+						lowerdir, name->len);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
 			case -ENOENT:
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 22d904bde6ab..8cdd6df7597a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2487,7 +2487,8 @@ int dquot_quota_on_mount(struct super_block *sb, char *qf_name,
 	struct dentry *dentry;
 	int error;
 
-	dentry = lookup_positive_unlocked(qf_name, sb->s_root, strlen(qf_name));
+	dentry = lookup_positive_unlocked(&init_user_ns, qf_name,
+					  sb->s_root, strlen(qf_name));
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index b4073e36450a..c177edfb2364 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -69,7 +69,8 @@ extern struct dentry *lookup_one_len(struct user_namespace *mnt_userns,
 				     const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len_unlocked(struct user_namespace *,
 					      const char *, struct dentry *, int);
-extern struct dentry *lookup_positive_unlocked(const char *, struct dentry *, int);
+extern struct dentry *lookup_positive_unlocked(struct user_namespace *,
+					       const char *, struct dentry *, int);
 
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *);
-- 
2.30.2

