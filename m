Return-Path: <linux-fsdevel+bounces-62842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FEBA23F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 04:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475881C2259F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9621EB9E1;
	Fri, 26 Sep 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="oVwvkIFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gR4yyujR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F776246BD2
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758855051; cv=none; b=lyH+4jDxLXZhrlONTBl+UsQ4BdMI5943JKYyK6NS9Nc14mlpV955KyOePsRuXjGIOnj6Vo2SseuLwG/1QcOkK4ErromEMp9qjgRryWAKuFCo2zUI998bOXvLdqzRCkqaA80p+EP/DMbRQvc+Fd0rdOkQQpUo8Tdru9F7B2h61NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758855051; c=relaxed/simple;
	bh=6cv2zHNYas0rMMs8a8W8GTHYH2+LnyQO8U4L9ogDaXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwnlyDR4XbYJlkXBGSgrU4OaSG7kjUScmMwd1BVcK5y9DKl60Xjc48ctQwbTSibFgQs9V1ImNZaF7j5rUU8Zbx1KDFhnWfF/iB2D2gD+mlWdc3aE3WhAY9OpAt8P4xL27KUriMwDvYhZw+BwmtCzlqPU7z0w5bszteQlGF2/0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=oVwvkIFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gR4yyujR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C480BEC00C3;
	Thu, 25 Sep 2025 22:50:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 25 Sep 2025 22:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758855048;
	 x=1758941448; bh=F8W5U4G52YKGc+DluK/qVzPeNOZQgiq6qnvC7NGa+us=; b=
	oVwvkIFNArBbAvpF/n5OwOgESHl0YFpQ+dF6VtNg/191o5N+AHoZDJIIYWA7PS+V
	Fztg5SJ5mkoy3SVDdSF3ohVjXjMGWrUIt0eNMmznlBRTHkEu2YKuyATJKbvnr/Tj
	Ly3cDqc4HSLicut89AUuHqcyBet00ALBC2xi4hSU2uWH04t3h235SVLJeI72t7VL
	vzd1dGj1yb5yTiqQ8eJJrxwZii0gLeUqSJp7vQHuf5U1N9JYTKLVhrk3m8n0xE2k
	rQ7bOEP5vHx53EL/sl/yMWLrcKf3cIOTpqz+FThPC6vbjzU/mE1P1d16lvi4f5nW
	GpKA3a7mmg4yXuv3SZhLiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758855048; x=1758941448; bh=F
	8W5U4G52YKGc+DluK/qVzPeNOZQgiq6qnvC7NGa+us=; b=gR4yyujRAuqCbXeqJ
	wo/paEJrnYrxGsKJNebMCqC+EBvmxdIPwtJR4IIt1xiRvyvNetSJoAvOeoF+Q/eu
	zlZHp/yjkY/v9tdZezrlvIolTCdzXlbctDUbVGvVqth+JfVP6pz1+uPQ+iEkFfEW
	z/OSdcofieIsav9t2mjrn8XvAstvpq1C7Jkv8UvViTvtnam2T17kKKFsLmWmC3AZ
	NIdRjV4uLimfia8LOpPqwDzW6BsGjp2qFNjNZ3nVH2FZHp9xM/Rh1/9UAR8KBgR2
	AC16LC2rFUovMRgEyiFCA19evAjOM64ipRcpr/qpWFUxOG37RbOGToHN/VWz+WCQ
	cfqmg==
X-ME-Sender: <xms:iP_VaIqapjH3DKdHyXE9L2dykJJHMil0r0XQ-HD29uI_PxkXA-GTRQ>
    <xme:iP_VaJnnL4U8hmDAa6MqLi9JU0QYa2OUk4rolIhvLb91K-Cx07Xo66ndimQIjk-PB
    Rqa24ks5L55yv2Cv866N5i-KD9amRqL04p9lXf_YoNN3YSDUg>
X-ME-Received: <xmr:iP_VaMOIjfyHuE0KPXXszsHC6ag67-kUQf_CaXZz_Parn3bz_0Q5ioD3f3NohbMK-AGQnEZJ3DLo3LaQbIZNA5pgVIM93acQQhC1lu_x9TGX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:iP_VaFNxtN2qA4euqkwHITjZnfwd6l9R3BATLNcSuYimdR7w2BNoeg>
    <xmx:iP_VaFiubOHPpsAI74tcKSzBwgNcrAFa6v0kMZ1aY-Xc1Tnu4nQ3Nw>
    <xmx:iP_VaKu5uDebZtXZSv92qFDhRs2NxgaFURrBvmovxoUoDTdhyWOLjA>
    <xmx:iP_VaDSEz2vM-B0XPK9j6_g_6rRAqdsLheiaNV3FoSCW_S_sq0Jb1w>
    <xmx:iP_VaEA6yfZ3cktnYTZ2AfuFADhSs9lBgOQOP01wrPgGqj-GP35Vk-OD>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 22:50:46 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
Date: Fri, 26 Sep 2025 12:49:08 +1000
Message-ID: <20250926025015.1747294-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250926025015.1747294-1-neilb@ownmail.net>
References: <20250926025015.1747294-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

start_removing() is similar to start_creating() but will only return a
positive dentry with the expectation that it will be removed.  This is
used by nfsd, cachefiles, and overlayfs.  They are changed to also use
end_removing() to terminate the action begun by start_removing().  This
is a simple alias for end_dirop().

Apart from changes to the error paths, as we no longer need to unlock on
a lookup error, an effect on callers is that they don't need to test if
the found dentry is positive or negative - they can be sure it is
positive.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    | 25 ++++++++++---------------
 fs/namei.c               | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfs4recover.c    | 18 +++++-------------
 fs/nfsd/vfs.c            | 26 ++++++++++----------------
 fs/overlayfs/dir.c       | 15 +++++++--------
 fs/overlayfs/overlayfs.h |  8 ++++++++
 include/linux/namei.h    | 17 +++++++++++++++++
 7 files changed, 84 insertions(+), 52 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 965b22b2f58d..3064d439807b 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -260,6 +260,7 @@ static int cachefiles_unlink(struct cachefiles_cache *cache,
  * - File backed objects are unlinked
  * - Directory backed objects are stuffed into the graveyard for userspace to
  *   delete
+ * On entry dir must be locked.  It will be unlocked on exit.
  */
 int cachefiles_bury_object(struct cachefiles_cache *cache,
 			   struct cachefiles_object *object,
@@ -275,7 +276,8 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	_enter(",'%pd','%pd'", dir, rep);
 
 	if (rep->d_parent != dir) {
-		inode_unlock(d_inode(dir));
+		dget(rep);
+		end_removing(rep);
 		_leave(" = -ESTALE");
 		return -ESTALE;
 	}
@@ -286,16 +288,16 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 			    * by a file struct.
 			    */
 		ret = cachefiles_unlink(cache, object, dir, rep, why);
-		dput(rep);
+		end_removing(rep);
 
-		inode_unlock(d_inode(dir));
 		_leave(" = %d", ret);
 		return ret;
 	}
 
 	/* directories have to be moved to the graveyard */
 	_debug("move stale object to graveyard");
-	inode_unlock(d_inode(dir));
+	dget(rep);
+	end_removing(rep);
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -745,26 +747,20 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
 	struct dentry *victim;
 	int ret = -ENOENT;
 
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+	victim = start_removing(&nop_mnt_idmap, dir, &QSTR(filename));
 
-	victim = lookup_one(&nop_mnt_idmap, &QSTR(filename), dir);
 	if (IS_ERR(victim))
 		goto lookup_error;
-	if (d_is_negative(victim))
-		goto lookup_put;
 	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
 		goto lookup_busy;
 	return victim;
 
 lookup_busy:
 	ret = -EBUSY;
-lookup_put:
-	inode_unlock(d_inode(dir));
-	dput(victim);
+	end_removing(victim);
 	return ERR_PTR(ret);
 
 lookup_error:
-	inode_unlock(d_inode(dir));
 	ret = PTR_ERR(victim);
 	if (ret == -ENOENT)
 		return ERR_PTR(-ESTALE); /* Probably got retired by the netfs */
@@ -812,18 +808,17 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
+	dput(victim);
 	if (ret < 0)
 		goto error;
 
 	fscache_count_culled();
-	dput(victim);
 	_leave(" = 0");
 	return 0;
 
 error_unlock:
-	inode_unlock(d_inode(dir));
+	end_removing(victim);
 error:
-	dput(victim);
 	if (ret == -ENOENT)
 		return -ESTALE; /* Probably got retired by the netfs */
 
diff --git a/fs/namei.c b/fs/namei.c
index 064cb44a3a46..0d9e98961758 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3269,6 +3269,33 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_creating);
 
+/**
+ * start_removing - prepare to remove a given name with permission checking
+ * @idmap - idmap of the mount
+ * @parent - directory in which to find the name
+ * @name - the name to be removed
+ *
+ * Locks are taken and a lookup in performed prior to removing
+ * an object from a directory.  Permission checking (MAY_EXEC) is performed
+ * against @idmap.
+ *
+ * If the name doesn't exist, an error is returned.
+ *
+ * end_removing() should be called when removal is complete, or aborted.
+ *
+ * Returns: a positive dentry, or an error.
+ */
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name)
+{
+	int err = lookup_one_common(idmap, name, parent);
+
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, name, 0);
+}
+EXPORT_SYMBOL(start_removing);
+
 #ifdef CONFIG_UNIX98_PTYS
 int path_pts(struct path *path)
 {
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 93b2a3e764db..0f33e13a9da2 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -345,20 +345,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
 	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
 
 	dir = nn->rec_file->f_path.dentry;
-	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
-	dentry = lookup_one(&nop_mnt_idmap, &QSTR(name), dir);
-	if (IS_ERR(dentry)) {
-		status = PTR_ERR(dentry);
-		goto out_unlock;
-	}
-	status = -ENOENT;
-	if (d_really_is_negative(dentry))
-		goto out;
+	dentry = start_removing(&nop_mnt_idmap, dir, &QSTR(name));
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	status = vfs_rmdir(&nop_mnt_idmap, d_inode(dir), dentry);
-out:
-	dput(dentry);
-out_unlock:
-	inode_unlock(d_inode(dir));
+	end_removing(dentry);
 	return status;
 }
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 90c830c59c60..d5b4550fd8f6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2021,7 +2021,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
-	struct inode	*rinode;
+	struct inode	*rinode = NULL;
 	__be32		err;
 	int		host_err;
 
@@ -2040,24 +2040,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
 	dentry = fhp->fh_dentry;
 	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
 
-	rdentry = lookup_one(&nop_mnt_idmap, &QSTR_LEN(fname, flen), dentry);
+	rdentry = start_removing(&nop_mnt_idmap, dentry, &QSTR_LEN(fname, flen));
+
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_unlock;
+		goto out_drop_write;
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_unlock;
-	}
-	rinode = d_inode(rdentry);
 	err = fh_fill_pre_attrs(fhp);
 	if (err != nfs_ok)
 		goto out_unlock;
 
+	rinode = d_inode(rdentry);
+	/* Prevent truncation until after locks dropped */
 	ihold(rinode);
+
 	if (!type)
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
@@ -2079,10 +2076,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 	fh_fill_post_attrs(fhp);
 
-	inode_unlock(dirp);
-	if (!host_err)
+out_unlock:
+	end_removing(rdentry);
+	if (!err && !host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
 out_drop_write:
@@ -2100,9 +2097,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0ae79efbfce7..c4057b4a050d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -841,17 +841,17 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 			goto out;
 	}
 
-	inode_lock_nested(dir, I_MUTEX_PARENT);
-	upper = ovl_lookup_upper(ofs, dentry->d_name.name, upperdir,
-				 dentry->d_name.len);
+	upper = ovl_start_removing_upper(ofs, upperdir,
+					 &QSTR_LEN(dentry->d_name.name,
+						   dentry->d_name.len));
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
-		goto out_unlock;
+		goto out_dput;
 
 	err = -ESTALE;
 	if ((opaquedir && upper != opaquedir) ||
 	    (!opaquedir && !ovl_matches_upper(dentry, upper)))
-		goto out_dput_upper;
+		goto out_unlock;
 
 	if (is_dir)
 		err = ovl_do_rmdir(ofs, dir, upper);
@@ -867,10 +867,9 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 	 */
 	if (!err)
 		d_drop(dentry);
-out_dput_upper:
-	dput(upper);
 out_unlock:
-	inode_unlock(dir);
+	end_removing(upper);
+out_dput:
 	dput(opaquedir);
 out:
 	return err;
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c24c2da953bd..915af58459b7 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -423,6 +423,14 @@ static inline struct dentry *ovl_start_creating_upper(struct ovl_fs *ofs,
 			      parent, name);
 }
 
+static inline struct dentry *ovl_start_removing_upper(struct ovl_fs *ofs,
+						      struct dentry *parent,
+						      struct qstr *name)
+{
+	return start_removing(ovl_upper_mnt_idmap(ofs),
+			      parent, name);
+}
+
 static inline bool ovl_open_flags_need_copy_up(int flags)
 {
 	if (!flags)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 4cbe930054a1..63941fdbc23d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -90,6 +90,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 
 struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
 
 /* end_creating - finish action started with start_creating
  * @child - dentry returned by start_creating()
@@ -106,6 +108,21 @@ static inline void end_creating(struct dentry *child, struct dentry *parent)
 	end_dirop_mkdir(child, parent);
 }
 
+/* end_removing - finish action started with start_removing
+ * @child - dentry returned by start_removing()
+ * @parent - dentry given to start_removing()
+ *
+ * Unlock and release the child.
+ *
+ * This is identical to end_dirop().  It can be passed the result of
+ * start_removing() whether that was successful or not, but it not needed
+ * if start_removing() failed.
+ */
+static inline void end_removing(struct dentry *child)
+{
+	end_dirop(child);
+}
+
 extern int follow_down_one(struct path *);
 extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
-- 
2.50.0.107.gf914562f5916.dirty


