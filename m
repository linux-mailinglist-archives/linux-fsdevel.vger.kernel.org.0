Return-Path: <linux-fsdevel+bounces-64181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BEABDC06B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D173BB889
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34B2FC026;
	Wed, 15 Oct 2025 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="sFgm7ntW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qWXL8n7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBE2FCC1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492917; cv=none; b=fZ6d2lASRw6TBvjiX1mnDcl5RCOYjtmN4I1fwT+99k6YkRYu7P5VWFX0ReYkTXXpKK4NzgEm+HTxrggkLt0WKihTtCi7lC80xzAqQrnq88WciHEfc6k15BoFf9uXeLaa3aKkZLDgz6YlEELSUCkV8pudtxvC4qi/NukmjIywlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492917; c=relaxed/simple;
	bh=5ccGHlErJEiL1U/aKcZAMbBsFACeVcSyvza8OzAgHSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udIHftT3XnwIPxvsm6arNgAyiVLJoiDHwXta6+gw24kYIPjmmz2OaIvlDEZIGunw/V8Y4cGRb35UdHUHSy3+zG7AOETIwqBroJS23l90VoVNoREQEdv5y+H+z0OaW75VejQLjs2mWOO4t8bB4L5rVae4Dp70rc0lqzYfITiHVx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=sFgm7ntW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qWXL8n7v; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 24604EC0236;
	Tue, 14 Oct 2025 21:48:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 21:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492915;
	 x=1760579315; bh=ZAgrbaq/ub6v+rWXKj59uZmAaxqQeW6+Mxd+Zd+T3Ak=; b=
	sFgm7ntWW2g6BuI55YiL1Kvxkrf/OQnQoq6zuNzQ5sSUaBCpdJy4ESzjvbwJWNeL
	PAueyqFUUcliDw4EEveb0n2LYj2tr/EanIbsTPm8LCLi+qyYiTyaSA0aDgdoBKnf
	Nh0lBbEd3DjcYRkKSr+V6eoM5ZnGck9thUmKUS9Jzp2N6OVx9QcPxboCCxPSGzv1
	NtH1wBQXwmCY92JblRMAF9krfqf1qM3k8T7SWjki+uhXGaE5xOcx1B5GZZkZm8K2
	AfqJU6HA96SXl7DJF7x1iMJ59Qz9YotATTi+MmUOWbOKijTmQyQlD1VCbilnKgoB
	rHgEM2ljJJaHjnECudXrjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492915; x=1760579315; bh=Z
	Agrbaq/ub6v+rWXKj59uZmAaxqQeW6+Mxd+Zd+T3Ak=; b=qWXL8n7vJH41Y5JuZ
	KZ6LYj4cvrWJuJemXf0zvsCNSlEAP0a6o1BVD4UKEC/x/g23H4xrRgaClMm3NIMC
	w98R/FFi8UyCBQG/0qOVmLlSe7HLCyHF59d3/ZwPKF3Jp/9kMO5kiGRtaB/R20bt
	PrmXgJxiSjfe9AQPmVH3hNpLB3JwIF1fQ7cpGfO2rljYVuS1ba1mF3+VREi16q3I
	b7nTCmKP68GsiSCS9l4Q78WTRjECBK3WswIah8OHl9cFzt22b4dP2hwGfF/Aeu4W
	ksm7b/6Hxcftdxm4Ap8H+XKqB1sGUZzUNXjZ9WBIGlTm9AbiwgqdMaBYG8TmxNAW
	PQ9kg==
X-ME-Sender: <xms:cv3uaBi4C1wAr6JvKdFpK6geF3Xaf-Zq2S11iG5CEaP4zPviBMeGKw>
    <xme:cv3uaA8Rs80I5VFCS4WRVYgDWlMYTc16Bw9aELkJx3rhBGfoQAssWr0f_g8862VS5
    L_zo4nmeSEpJzzxf3gI_WwiOFxC_PHFIByMFsb_OQaoGudV>
X-ME-Received: <xmr:cv3uaAE0bkDytvNo3-xwnVoc4u1Jx26N55-376V79rHqmpoYcILZGMHCplkRhsFF5l5AAqeMIMH0eUp-6y-CAL_NocyI9i0bWDPISNcNREXt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cv3uaLkOXz8KnnDW_pSFNzSscn1sri0IxD9jzomroeuNj6pEm2as1g>
    <xmx:cv3uaMZWg06rIkeWn-IZMemeLjOn_wvkoswkccW6kFeV63sVUKtYxg>
    <xmx:cv3uaIFEGa9tWIPKM8Pv0RyoqVIIS-XaJTz2uByG9Q8G0mDKecNKRA>
    <xmx:cv3uaFLl7o21hrvIsZU7etVSJvKwaxHKwinpppahh5GFQr6RRJxJEA>
    <xmx:c_3uaB42cz8NAnlRf-0ulD-E08aqBR77gwj3QbcAJ33ac24KyhyJJWhC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:48:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 05/14] VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()
Date: Wed, 15 Oct 2025 12:46:57 +1100
Message-ID: <20251015014756.2073439-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251015014756.2073439-1-neilb@ownmail.net>
References: <20251015014756.2073439-1-neilb@ownmail.net>
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

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/cachefiles/namei.c    | 32 ++++++++++++++------------------
 fs/namei.c               | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfs4recover.c    | 18 +++++-------------
 fs/nfsd/vfs.c            | 26 ++++++++++----------------
 fs/overlayfs/dir.c       | 15 +++++++--------
 fs/overlayfs/overlayfs.h |  8 ++++++++
 include/linux/namei.h    | 18 ++++++++++++++++++
 7 files changed, 89 insertions(+), 55 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 0a136eb434da..c7f0c6ab9b88 100644
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
@@ -274,28 +275,30 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	_enter(",'%pd','%pd'", dir, rep);
 
+	/* end_removing() will dput() @rep but we need to keep
+	 * a ref, so take one now.  This also stops the dentry
+	 * being negated when unlinked which we need.
+	 */
+	dget(rep);
+
 	if (rep->d_parent != dir) {
-		inode_unlock(d_inode(dir));
+		end_removing(rep);
 		_leave(" = -ESTALE");
 		return -ESTALE;
 	}
 
 	/* non-directories can just be unlinked */
 	if (!d_is_dir(rep)) {
-		dget(rep); /* Stop the dentry being negated if it's only pinned
-			    * by a file struct.
-			    */
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
+	end_removing(rep);
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -749,26 +752,20 @@ static struct dentry *cachefiles_lookup_for_cull(struct cachefiles_cache *cache,
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
@@ -816,18 +813,17 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
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
index 9972b0257a4c..ae833dfa277c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3248,6 +3248,33 @@ struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 }
 EXPORT_SYMBOL(start_creating);
 
+/**
+ * start_removing - prepare to remove a given name with permission checking
+ * @idmap:  idmap of the mount
+ * @parent: directory in which to find the name
+ * @name:   the name to be removed
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
index c247a7c3291c..3eefaa2202e3 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -324,20 +324,12 @@ nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
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
index 4efd3688e081..cd64ffe12e0b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2044,7 +2044,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 {
 	struct dentry	*dentry, *rdentry;
 	struct inode	*dirp;
-	struct inode	*rinode;
+	struct inode	*rinode = NULL;
 	__be32		err;
 	int		host_err;
 
@@ -2063,24 +2063,21 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 
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
 
@@ -2102,10 +2099,10 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
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
@@ -2123,9 +2120,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err != nfs_ok ? err : nfserrno(host_err);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a8a24abee6b3..b5247c9e1903 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -866,17 +866,17 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
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
@@ -892,10 +892,9 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
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
index beeba96cfcb2..49ad65f829dc 100644
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
index 3f92c1a16878..9ee76e88f3dd 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -90,6 +90,8 @@ struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
 
 struct dentry *start_creating(struct mnt_idmap *idmap, struct dentry *parent,
 			      struct qstr *name);
+struct dentry *start_removing(struct mnt_idmap *idmap, struct dentry *parent,
+			      struct qstr *name);
 
 /**
  * end_creating - finish action started with start_creating
@@ -121,6 +123,22 @@ static inline void end_creating(struct dentry *child, struct dentry *parent)
 		end_dirop(child);
 }
 
+/**
+ * end_removing - finish action started with start_removing
+ * @child:  dentry returned by start_removing()
+ * @parent: dentry given to start_removing()
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


