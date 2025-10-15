Return-Path: <linux-fsdevel+bounces-64189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F5BDC083
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB8E19271BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192492FAC18;
	Wed, 15 Oct 2025 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CxS/iuCh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uAvWZKFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C82F7478
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Oct 2025 01:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492953; cv=none; b=AY7/rq0u2gqKsmuhIaRFecvTZS49gfxDDNhG+fRTq4/S5fp2Dg0UBCRpNu3gXytRDCgO2PldFi8qwzlC6BYWk/PHzTTis/enqAwbaMoOc5+h8RhVGjG2kesv8VkSPrY/pnhzXimOfNElo9jMsfGIct1kZgqVzLWBRDBSvZwsZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492953; c=relaxed/simple;
	bh=xMwFMrZIsmX4qf68OOqkxC5UA7vz3ioWc31sGBi9mbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmftlE/8zd7i5q3IgIUSPs4Z0lgkY17cx47t9UzF5OJk3jEchXSZGZQ2b4GcYbawkD0sIIRUHviT76kTJLMmMLlXk2Qtk4rNf5f4VHQ7AeC6mr2Of5Xu6hlfX5KEtBiWU+7JS3EPtlUjvCmJ7kB5b05Ystso5QtB6HdWUjxPV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CxS/iuCh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uAvWZKFG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B8C4314000DE;
	Tue, 14 Oct 2025 21:49:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 14 Oct 2025 21:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1760492950;
	 x=1760579350; bh=ODRnFUSuGxemKArkjpBICfKSm7dadW+QpEVN09aQVLw=; b=
	CxS/iuCh3XCWaaoS0e5UJjv+OdoaadWFLlTrxNJ2ysnZiq7wR1bUUSWGw9FtaoOZ
	ShgLEsWYIgCHu/OYoEYtgDN5VMs3aomBd+ShIiX/sVg3gjbY61+xsyqIN/GuYAY5
	te7rxQ5xZyje4nNmamwOsJIK/TQ2A2UGLxHvR7oGv+A+3MeNTZ3RRDFoI+HQad/2
	sh2ddcVo9xOfkM1iLYn5bWwbbyG/uOOvbvjgXcUR2+rpoeNLsm5Nm3WuS4E/ygY3
	FQMoj98iTjicnhoFpZ5wb7LXFxXrnYmidZmJv35QCXCoAcMFQ3YeWPwRW6nRK7TF
	NI1Bb24kfLuJplxMQQ13uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760492950; x=1760579350; bh=O
	DRnFUSuGxemKArkjpBICfKSm7dadW+QpEVN09aQVLw=; b=uAvWZKFGVZzfpprIV
	SILloooetOhk7buyNlmf64dlrjEtcHDM0Y1phYpJx3mAsVcBclCvcfEUuxW9GLg4
	b7MPf5yhwVTDvWw9X2QUxa1qc/6MH5V/5Zp+pAOuVnU/NraDWJiPVwArKme4wR2/
	pSa05XpwdFLeTEyJxDvhMC1yj7wOK2pWEGt3p2q+bqCUtYPGQVv5BDC+u+RuH0ke
	XWmfL1/t9WCK+Tj4ZZaYyVjBuG0sCZVwoKnW/JbNGQN4eKAy05NUtmRuxZTxlQrK
	5S+AIYkAm4+AV2kIVZrWxvm3D3fJ56hsGYd9iZvAJdPqv/b+ri+A8j2Q4St2yxF6
	HQcXA==
X-ME-Sender: <xms:lv3uaPSqkyrYG9n_kq4RcyG-mRfR4vjaIVoBD-6mcn3GtTK30Empqw>
    <xme:lv3uaLsgl4zZa2AQEkaYAVOZSypaFaZyYdGOasdolV8C7ONfmE-QUJcoOS_1g7BQh
    pRR2MVh2yPmSCvLtuk_YHnKYMa7vcj30MTiZZqV0hRvbPTH8w>
X-ME-Received: <xmr:lv3uaD1oLQjBo5aDPxqhekShW7pSfrt-a4GNUqI2jQhKe6FG9YSrBqgCGzKvErlmGEYWTRHvodvH07owoIk-EL_78Femt8hy3zx2vLaUHET9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddvudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:lv3uaEU0BkT2vEN2-cIK4-5LPg0cn6HbpPN-yKjy_TkQd75VVzPtag>
    <xmx:lv3uaGIbenqlW4mR06t0YWuSdBptN-42xZewB4bWWR8P5cpL9wNtIw>
    <xmx:lv3uaO0in6P_aGbOvoomdQ3ggAHVED135n2h45NCwV_3nljrxC0EZA>
    <xmx:lv3uaE6hU6QU6AJ_J462MSch0AB8iOp1sAQtwDY-RD5TljdSWEjCcw>
    <xmx:lv3uaJo_7uD5Fa9ExjG-Z9du8qm1KkB73A1XyzsknaRMzfl2epBoDNGM>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 21:49:08 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/14] VFS: change vfs_mkdir() to unlock on failure.
Date: Wed, 15 Oct 2025 12:47:05 +1100
Message-ID: <20251015014756.2073439-14-neilb@ownmail.net>
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

vfs_mkdir() already drops the reference to the dentry on failure but it
leaves the parent locked.
This complicates end_creating() which needs to unlock the parent even
though the dentry is no longer available.

If we change vfs_mkdir() to unlock on failure as well as releasing the
dentry, we can remove the "parent" arg from end_creating() and simplify
the rules for calling it.

Note that cachefiles_get_directory() can choose to substitute an error
instead of actually calling vfs_mkdir(), for fault injection.  In that
case it needs to call end_creating(), just as vfs_mkdir() now does on
error.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/btrfs/ioctl.c         |  2 +-
 fs/cachefiles/namei.c    | 14 ++++++++------
 fs/ecryptfs/inode.c      |  8 ++++----
 fs/namei.c               |  4 ++--
 fs/nfsd/nfs3proc.c       |  2 +-
 fs/nfsd/nfs4proc.c       |  2 +-
 fs/nfsd/nfs4recover.c    |  2 +-
 fs/nfsd/nfsproc.c        |  2 +-
 fs/nfsd/vfs.c            |  8 ++++----
 fs/overlayfs/copy_up.c   |  4 ++--
 fs/overlayfs/dir.c       | 13 ++++++-------
 fs/overlayfs/super.c     |  6 +++---
 fs/xfs/scrub/orphanage.c |  2 +-
 include/linux/namei.h    | 28 +++++++++-------------------
 ipc/mqueue.c             |  2 +-
 15 files changed, 45 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4fbfdd8faf6a..90ef777eae25 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -935,7 +935,7 @@ static noinline int btrfs_mksubvol(struct dentry *parent,
 out_up_read:
 	up_read(&fs_info->subvol_sem);
 out_dput:
-	end_creating(dentry, parent);
+	end_creating(dentry);
 	return ret;
 }
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index b97a40917a32..10f010dc9946 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -130,8 +130,10 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		ret = cachefiles_inject_write_error();
 		if (ret == 0)
 			subdir = vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		else
+		else {
+			end_creating(subdir);
 			subdir = ERR_PTR(ret);
+		}
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -140,7 +142,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 		trace_cachefiles_mkdir(dir, subdir);
 
 		if (unlikely(d_unhashed(subdir) || d_is_negative(subdir))) {
-			end_creating(subdir, dir);
+			end_creating(subdir);
 			goto retry;
 		}
 		ASSERT(d_backing_inode(subdir));
@@ -154,7 +156,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	/* Tell rmdir() it's not allowed to delete the subdir */
 	inode_lock(d_inode(subdir));
 	dget(subdir);
-	end_creating(subdir, dir);
+	end_creating(subdir);
 
 	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
 		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
@@ -196,7 +198,7 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	return ERR_PTR(-EBUSY);
 
 mkdir_error:
-	end_creating(subdir, dir);
+	end_creating(subdir);
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
 
@@ -705,7 +707,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 		if (ret < 0)
 			goto out_end;
 
-		end_creating(dentry, fan);
+		end_creating(dentry);
 
 		ret = cachefiles_inject_read_error();
 		if (ret == 0)
@@ -739,7 +741,7 @@ bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
 	}
 
 out_end:
-	end_creating(dentry, fan);
+	end_creating(dentry);
 out:
 	_leave(" = %u", success);
 	return success;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index b3702105d236..90d74ecc5028 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -211,7 +211,7 @@ ecryptfs_do_create(struct inode *directory_inode,
 	fsstack_copy_attr_times(directory_inode, lower_dir);
 	fsstack_copy_inode_size(directory_inode, lower_dir);
 out_lock:
-	end_creating(lower_dentry, NULL);
+	end_creating(lower_dentry);
 	return inode;
 }
 
@@ -456,7 +456,7 @@ static int ecryptfs_link(struct dentry *old_dentry, struct inode *dir,
 		  ecryptfs_inode_to_lower(d_inode(old_dentry))->i_nlink);
 	i_size_write(d_inode(new_dentry), file_size_save);
 out_lock:
-	end_creating(lower_new_dentry, NULL);
+	end_creating(lower_new_dentry);
 	return rc;
 }
 
@@ -500,7 +500,7 @@ static int ecryptfs_symlink(struct mnt_idmap *idmap,
 	fsstack_copy_attr_times(dir, lower_dir);
 	fsstack_copy_inode_size(dir, lower_dir);
 out_lock:
-	end_creating(lower_dentry, NULL);
+	end_creating(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return rc;
@@ -534,7 +534,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	fsstack_copy_inode_size(dir, lower_dir);
 	set_nlink(dir, lower_dir->i_nlink);
 out:
-	end_creating(lower_dentry, lower_dir_dentry);
+	end_creating(lower_dentry);
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
diff --git a/fs/namei.c b/fs/namei.c
index 91e484dbc239..ba831fc6cce8 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4832,7 +4832,7 @@ EXPORT_SYMBOL(start_creating_path);
  */
 void end_creating_path(const struct path *path, struct dentry *dentry)
 {
-	end_creating(dentry, path->dentry);
+	end_creating(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -5034,7 +5034,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	return dentry;
 
 err:
-	dput(dentry);
+	end_creating(dentry);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(vfs_mkdir);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e2aac0def2cb..6b39e4aff959 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -364,7 +364,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	end_creating(child, parent);
+	end_creating(child);
 out_write:
 	fh_drop_write(fhp);
 	return status;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b2c95e8e7c68..524cb07a477c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -376,7 +376,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	end_creating(child, parent);
+	end_creating(child);
 	nfsd_attrs_free(&attrs);
 out_write:
 	fh_drop_write(fhp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 3eefaa2202e3..18c08395b273 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -215,7 +215,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	if (IS_ERR(dentry))
 		status = PTR_ERR(dentry);
 out_end:
-	end_creating(dentry, dir);
+	end_creating(dentry);
 out:
 	if (status == 0) {
 		if (nn->in_grace)
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index ee1b16e921fd..28f03a6a3cc3 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -421,7 +421,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	}
 
 out_unlock:
-	end_creating(dchild, dirfhp->fh_dentry);
+	end_creating(dchild);
 out_write:
 	fh_drop_write(dirfhp);
 done:
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 62109885d4db..6e9a57863904 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1589,7 +1589,7 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	if (!err)
 		fh_fill_post_attrs(fhp);
-	end_creating(dchild, dentry);
+	end_creating(dchild);
 	return err;
 
 out_nfserr:
@@ -1646,7 +1646,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 
 out_unlock:
-	end_creating(dchild, dentry);
+	end_creating(dchild);
 	return err;
 }
 
@@ -1747,7 +1747,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
 out_unlock:
-	end_creating(dnew, dentry);
+	end_creating(dnew);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
 	if (!err)
@@ -1824,7 +1824,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	host_err = vfs_link(dold, &nop_mnt_idmap, dirp, dnew, NULL);
 	fh_fill_post_attrs(ffhp);
 out_unlock:
-	end_creating(dnew, ddir);
+	end_creating(dnew);
 	if (!host_err) {
 		host_err = commit_metadata(ffhp);
 		if (!host_err)
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 27014ada11c7..36949856ddea 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -624,7 +624,7 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 			ovl_dentry_set_upper_alias(c->dentry);
 			ovl_dentry_update_reval(c->dentry, upper);
 		}
-		end_creating(upper, upperdir);
+		end_creating(upper);
 	}
 	if (err)
 		goto out;
@@ -891,7 +891,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
-		end_creating(upper, c->destdir);
+		end_creating(upper);
 	}
 
 	if (err)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index dfd1d4b48948..00dc797f2da7 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -91,7 +91,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 		err = ovl_do_whiteout(ofs, wdir, whiteout);
 		if (!err)
 			ofs->whiteout = dget(whiteout);
-		end_creating(whiteout, workdir);
+		end_creating(whiteout);
 		if (err)
 			return ERR_PTR(err);
 	}
@@ -103,7 +103,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 		err = ovl_do_link(ofs, ofs->whiteout, wdir, link);
 		if (!err)
 			whiteout = dget(link);
-		end_creating(link, workdir);
+		end_creating(link);
 		if (!err)
 			return whiteout;;
 
@@ -253,7 +253,7 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 	ret = ovl_create_real(ofs, workdir, ret, attr);
 	if (!IS_ERR(ret))
 		dget(ret);
-	end_creating(ret, workdir);
+	end_creating(ret);
 	return ret;
 }
 
@@ -361,12 +361,11 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
 	newdentry = ovl_create_real(ofs, upperdir, newdentry, attr);
-	if (IS_ERR(newdentry)) {
-		end_creating(newdentry, upperdir);
+	if (IS_ERR(newdentry))
 		return PTR_ERR(newdentry);
-	}
+
 	dget(newdentry);
-	end_creating(newdentry, upperdir);
+	end_creating(newdentry);
 
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index a721ef2b90e8..3acda985c8a3 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -320,7 +320,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		if (work->d_inode) {
 			dget(work);
-			end_creating(work, ofs->workbasedir);
+			end_creating(work);
 			if (persist)
 				return work;
 			err = -EEXIST;
@@ -338,7 +338,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		work = ovl_do_mkdir(ofs, dir, work, attr.ia_mode);
 		if (!IS_ERR(work))
 			dget(work);
-		end_creating(work, ofs->workbasedir);
+		end_creating(work);
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -632,7 +632,7 @@ static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 						OVL_CATTR(mode));
 		if (!IS_ERR(child))
 			dget(child);
-		end_creating(child, parent);
+		end_creating(child);
 	}
 	dput(parent);
 
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index e732605924a1..b77c2b6b6d44 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -199,7 +199,7 @@ xrep_orphanage_create(
 	sc->orphanage_ilock_flags = 0;
 
 out_dput_orphanage:
-	end_creating(orphanage_dentry, root_dentry);
+	end_creating(orphanage_dentry);
 out_dput_root:
 	dput(root_dentry);
 out:
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 208aed1d6728..0ef73d739a31 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -105,34 +105,24 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
-/**
- * end_creating - finish action started with start_creating
- * @child:  dentry returned by start_creating() or vfs_mkdir()
- * @parent: dentry given to start_creating(),
- *
- * Unlock and release the child.
+/* end_creating - finish action started with start_creating
+ * @child: dentry returned by start_creating() or vfs_mkdir()
  *
- * Unlike end_dirop() this can only be called if start_creating() succeeded.
- * It handles @child being and error as vfs_mkdir() might have converted the
- * dentry to an error - in that case the parent still needs to be unlocked.
+ * Unlock and release the child. This can be called after
+ * start_creating() whether that function succeeded or not,
+ * but it is not needed on failure.
  *
  * If vfs_mkdir() was called then the value returned from that function
  * should be given for @child rather than the original dentry, as vfs_mkdir()
- * may have provided a new dentry.  Even if vfs_mkdir() returns an error
- * it must be given to end_creating().
+ * may have provided a new dentry.
+ *
  *
  * If vfs_mkdir() was not called, then @child will be a valid dentry and
  * @parent will be ignored.
  */
-static inline void end_creating(struct dentry *child, struct dentry *parent)
+static inline void end_creating(struct dentry *child)
 {
-	if (IS_ERR(child))
-		/* The parent is still locked despite the error from
-		 * vfs_mkdir() - must unlock it.
-		 */
-		inode_unlock(parent->d_inode);
-	else
-		end_dirop(child);
+	end_dirop(child);
 }
 
 /**
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 060e8e9c4f59..7713a61aa431 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -931,7 +931,7 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		put_unused_fd(fd);
 		fd = error;
 	}
-	end_creating(path.dentry, root);
+	end_creating(path.dentry);
 	if (!ro)
 		mnt_drop_write(mnt);
 out_putname:
-- 
2.50.0.107.gf914562f5916.dirty


