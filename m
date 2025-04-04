Return-Path: <linux-fsdevel+bounces-45803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D1A7C67E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 01:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046323B5D24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8E1D7E47;
	Fri,  4 Apr 2025 23:00:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2715990C;
	Fri,  4 Apr 2025 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807638; cv=none; b=gTd7M+g9PeWuW9RCJYCNPcKDPQAzpBlb72E5Kaf48IJtdpg7Rinte081AEsC7odBHoiBDPRKXxmQ6MBJKZMIdi8vWKaHOfbBHTvoT/cZ1/bKuBwA/Ueg0RuIICfYzIsRjW5SIlTvapQM/1PeuQovT8vTQM6D3/zWvfDZixhaQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807638; c=relaxed/simple;
	bh=N2umlV1EAqLgdOh0zDjcSp6hhZaosk19TwRhPJ5icBk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=usymLsBZrdJCkl/uQUC1nNw2rIUS0N/pYdZak5nNI33v6YFsag46QPWanBN+pOM7PuyYp2ECKciZXEuTf8ZADeH1Vcai/9S+7h86C2YqM3ZpcoDBfTr0gwRwabdjU2txWJAtgAn/mldQ1giZ1NdKf2CYwRe3LEJXln8bkcvgW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1u0q1U-005Zsl-Qs;
	Fri, 04 Apr 2025 23:00:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
In-reply-to: <20250404-waldarbeiten-entern-d0ae4513ee41@brauner>
References: <>, <20250404-waldarbeiten-entern-d0ae4513ee41@brauner>
Date: Sat, 05 Apr 2025 10:00:28 +1100
Message-id: <174380762838.9342.7614757812120907834@noble.neil.brown.name>

On Sat, 05 Apr 2025, Christian Brauner wrote:
> On Fri, Apr 04, 2025 at 03:41:01PM +0200, Christian Brauner wrote:
> > On Fri, Mar 28, 2025 at 12:18:16PM +1100, NeilBrown wrote:
> > > On Fri, 21 Mar 2025, David Howells wrote:
> > > > NeilBrown <neil@brown.name> wrote:
> > > >=20
> > > > > Also the path component name is passed as "name" and "len" which are
> > > > > (confusingly?) separate by the "base".  In some cases the len in si=
mply
> > > > > "strlen" and so passing a qstr using QSTR() would make the calling
> > > > > clearer.
> > > > > Other callers do pass separate name and len which are stored in a
> > > > > struct.  Sometimes these are already stored in a qstr, other times =
it
> > > > > easily could be.
> > > > >=20
> > > > > So this patch changes these three functions to receive a 'struct qs=
tr',
> > > > > and improves the documentation.
> > > >=20
> > > > You did want 'struct qstr' not 'struct qstr *' right?  I think there =
are
> > > > arches where this will cause the compiler to skip a register argument=
 or two
> > > > if it's the second argument or third argument - i386 for example.  Pl=
us you
> > > > have an 8-byte alignment requirement because of the u64 in it that ma=
y suck if
> > > > passed through several layers of function.
> > >=20
> > > I don't think it is passed through several layers - except where the
> > > intermediate are inlined.
> > > And gcc enforces 16 byte alignment of the stack on function calls for
> > > i386, so I don't think alignment will be an issue.
> > >=20
> > > I thought 'struct qstr' would result in slightly cleaner calling.  But I
> > > cannot make a strong argument in favour of it so I'm willing to change
> > > if there are concerns.
> >=20
> > Fwiw, I massaged the whole series to pass struct qstr * instead of
> > struct qstr. I just forgot to finish that rebase and push.
> > /me doing so now.
>=20
> Fwiw, there were a bunch of build failures for me when I built the
> individual commits that I fixed up. I generally do:
>=20
> git rebase -i HEAD~XXXXX -x "make -j512"

Thanks for the fix-up! I'll have a look and compare with what I have.
I generally do something similar to the above - though my hardware
wouldn't handle -j512.

>=20
> with an allmodconfig to make sure that it cleanly builds at each commit.
>=20
Part of the code I'm changing is in arch/s390.  I'd need to get a
cross-compiler to build that.... maybe I should.

Thanks again.  I have a few more small cleanup (probably post on Monday)
and then a large batch which changes all the code which locks
directories for create/remove/rename.

One awkwardness which you might have an opinion on:
 In the final state we will be locking just the dentry, not the
 directory.  So the unlock only needs to be given the dentry.
 Something like "dentry_unlock(de);".

 Today we can implement that as "inode_unlock(de->d_parent->d_inode)"
 because d_parent is stable until the unlock happens.  After the switch
 it will involves clearing a bit and a possible wakeup.

 However:  vfs_mkdir() consumes the dentry on failure so there won't be
 any dentry to unlock - unless the caller keeps a copy, which would be
 clumsy.
 In the case where vfs_mkdir() returns a different dentry it will have
 to transfer the lock to that dentry (I don't see a problem there) so it
 will need to know about locking.  So I'm planing to have vfs_mkdir()
 drop the lock as well as put the dentry on failure.

 This ends up being quite an intrusive change.  Several other functions
 (in nfsd and particularly overlayfs) need to be changed to also drop
 the lock on failure.

 Do you think this is an acceptable API or should I explore other
 approaches?

 I've included my current draft patch so you can see the extent of the
 changes.  overlayfs is particularly interesting - it sometimes holds a
 rename lock across vfs_mkdir(), so we need to unlock the "other"
 directory after failure.  I think it will get cleaner later but I don't
 have code to prove it yet.

Thanks,
NeilBrown




Author: NeilBrown <neil@brown.name>
Date:   Fri Apr 4 16:43:25 2025 +1100

    Change vfs_mkdir() to unlock on failure.
   =20
    Proposed changes to directory-op locking will lock the dentry rather
    than the whole directory.  So the dentry will need to be unlocked.
   =20
    vfs_mkdir() consumes the dentry on error, so there will be no dentry to
    be unlocked.
   =20
    So change vfs_mkdir() to unlock on error.  This requires various other
    functions in various callers to also unlock on error.
   =20
    At present this results in some clumsy code.  Once the transition to
    dentry locking is complete the clumsiness will be gone.
   =20
    overlays looks particularly clumsy as in some cases a double-directory
    rename lock is taken, and a mkdir is then performed in one of the
    directories.  If that fails the other directory must be unlocked.
   =20
    Signed-off-by: NeilBrown <neil@brown.name>

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 14d0cc894000..1a5905c313f1 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -131,8 +131,11 @@ struct dentry *cachefiles_get_directory(struct cachefile=
s_cache *cache,
 		ret =3D cachefiles_inject_write_error();
 		if (ret =3D=3D 0)
 			subdir =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
-		else
+		else {
+			/* vfs_mkdir() unlocks on failure */
+			inode_unlock(d_inode(dir));
 			subdir =3D ERR_PTR(ret);
+		}
 		if (IS_ERR(subdir)) {
 			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
 						   cachefiles_trace_mkdir_error);
@@ -196,9 +199,10 @@ struct dentry *cachefiles_get_directory(struct cachefile=
s_cache *cache,
 	return ERR_PTR(-EBUSY);
=20
 mkdir_error:
-	inode_unlock(d_inode(dir));
-	if (!IS_ERR(subdir))
+	if (!IS_ERR(subdir)) {
+		inode_unlock(d_inode(dir));
 		dput(subdir);
+	}
 	pr_err("mkdir %s failed with error %d\n", dirname, ret);
 	return ERR_PTR(ret);
=20
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 51a5c54eb740..31e8abfff490 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -518,7 +518,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *id=
map, struct inode *dir,
 				 lower_dentry, mode);
 	rc =3D PTR_ERR(lower_dentry);
 	if (IS_ERR(lower_dentry))
-		goto out;
+		goto out_unlocked;
 	rc =3D 0;
 	if (d_unhashed(lower_dentry))
 		goto out;
@@ -530,6 +530,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap *id=
map, struct inode *dir,
 	set_nlink(dir, lower_dir->i_nlink);
 out:
 	inode_unlock(lower_dir);
+out_unlocked:
 	if (d_really_is_negative(dentry))
 		d_drop(dentry);
 	return ERR_PTR(rc);
diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..ba36883dd70a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4130,9 +4130,10 @@ EXPORT_SYMBOL(kern_path_create);
=20
 void done_path_create(struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
+	if (!IS_ERR(dentry)) {
 		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+		inode_unlock(path->dentry->d_inode);
+	}
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4295,7 +4296,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, u=
mode_t, mode, unsigned, d
  * negative or unhashes it and possibly splices a different one returning it,
  * the original dentry is dput() and the alternate is returned.
  *
- * In case of an error the dentry is dput() and an ERR_PTR() is returned.
+ * In case of an error the dentry is dput(), the parent is unlocked, and
+ * an ERR_PTR() is returned.
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
@@ -4333,6 +4335,8 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struc=
t inode *dir,
 	return dentry;
=20
 err:
+	/* Caller only needs to unlock if dentry is not an error */
+	inode_unlock(dir);
 	dput(dentry);
 	return ERR_PTR(error);
 }
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c1d9bd07285f..8907967135c6 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -221,7 +221,8 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	dentry =3D lookup_one_len(dname, dir, HEXDIR_LEN-1);
 	if (IS_ERR(dentry)) {
 		status =3D PTR_ERR(dentry);
-		goto out_unlock;
+		inode_unlock(d_inode(dir));
+		goto out;
 	}
 	if (d_really_is_positive(dentry))
 		/*
@@ -234,13 +235,14 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 		 */
 		goto out_put;
 	dentry =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), dentry, S_IRWXU);
-	if (IS_ERR(dentry))
+	if (IS_ERR(dentry)) {
 		status =3D PTR_ERR(dentry);
+		goto out;
+	}
 out_put:
-	if (!status)
-		dput(dentry);
-out_unlock:
+	dput(dentry);
 	inode_unlock(d_inode(dir));
+out:
 	if (status =3D=3D 0) {
 		if (nn->in_grace)
 			__nfsd4_create_reclaim_record_grace(clp, dname,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9abdc4b75813..0e935be8c2c1 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1450,7 +1450,9 @@ nfsd_check_ignore_resizing(struct iattr *iap)
 		iap->ia_valid &=3D ~ATTR_SIZE;
 }
=20
-/* The parent directory should already be locked: */
+/* The parent directory should already be locked.  The lock
+ * will be dropped on error.
+ */
 __be32
 nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   struct nfsd_attrs *attrs,
@@ -1516,8 +1518,11 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
 	err =3D nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
=20
 out:
-	if (!IS_ERR(dchild))
+	if (!IS_ERR(dchild)) {
+		if (err)
+			inode_unlock(dirp);
 		dput(dchild);
+	}
 	return err;
=20
 out_nfserr:
@@ -1572,6 +1577,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err !=3D nfs_ok)
 		goto out_unlock;
 	err =3D nfsd_create_locked(rqstp, fhp, attrs, type, rdev, resfhp);
+	if (err)
+		/* lock will have been dropped */
+		return err;
 	fh_fill_post_attrs(fhp);
 out_unlock:
 	inode_unlock(dentry->d_inode);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d7310fcf3888..324429d02569 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -518,7 +518,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct de=
ntry *upper,
 /*
  * Create and install index entry.
  *
- * Caller must hold i_mutex on indexdir.
+ * Caller must hold i_mutex on indexdir.  It will be unlocked on error.
  */
 static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 			    struct dentry *upper)
@@ -539,16 +539,22 @@ static int ovl_create_index(struct dentry *dentry, cons=
t struct ovl_fh *fh,
 	 * TODO: implement create index for non-dir, so we can call it when
 	 * encoding file handle for non-dir in case index does not exist.
 	 */
-	if (WARN_ON(!d_is_dir(dentry)))
+	if (WARN_ON(!d_is_dir(dentry))) {
+		inode_unlock(dir);
 		return -EIO;
+	}
=20
 	/* Directory not expected to be indexed before copy up */
-	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry))))
+	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry)))) {
+		inode_unlock(dir);
 		return -EIO;
+	}
=20
 	err =3D ovl_get_index_name_fh(fh, &name);
-	if (err)
+	if (err) {
+		inode_unlock(dir);
 		return err;
+	}
=20
 	temp =3D ovl_create_temp(ofs, indexdir, OVL_CATTR(S_IFDIR | 0));
 	err =3D PTR_ERR(temp);
@@ -567,8 +573,10 @@ static int ovl_create_index(struct dentry *dentry, const=
 struct ovl_fh *fh,
 		dput(index);
 	}
 out:
-	if (err)
+	if (err) {
 		ovl_cleanup(ofs, dir, temp);
+		inode_unlock(dir);
+	}
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -781,7 +789,8 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_start_write(c->dentry);
 	inode_lock(wdir);
 	temp =3D ovl_create_temp(ofs, c->workdir, &cattr);
-	inode_unlock(wdir);
+	if (!IS_ERR(wdir))
+		inode_unlock(wdir);
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
=20
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fe493f3ed6b6..b4d92b51b63f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -138,13 +138,16 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct=
 inode *dir,
 	goto out;
 }
=20
+/* dir will be unlocked on failure */
 struct dentry *ovl_create_real(struct ovl_fs *ofs, struct inode *dir,
 			       struct dentry *newdentry, struct ovl_cattr *attr)
 {
 	int err;
=20
-	if (IS_ERR(newdentry))
+	if (IS_ERR(newdentry)) {
+		inode_unlock(dir);
 		return newdentry;
+	}
=20
 	err =3D -ESTALE;
 	if (newdentry->d_inode)
@@ -189,13 +192,16 @@ struct dentry *ovl_create_real(struct ovl_fs *ofs, stru=
ct inode *dir,
 	}
 out:
 	if (err) {
-		if (!IS_ERR(newdentry))
+		if (!IS_ERR(newdentry)) {
+			inode_unlock(dir);
 			dput(newdentry);
+		}
 		return ERR_PTR(err);
 	}
 	return newdentry;
 }
=20
+/* Note workdir will be unlocked on failure */
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr)
 {
@@ -309,7 +315,7 @@ static int ovl_create_upper(struct dentry *dentry, struct=
 inode *inode,
 				    attr);
 	err =3D PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
-		goto out_unlock;
+		goto out;
=20
 	if (ovl_type_merge(dentry->d_parent) && d_is_dir(newdentry) &&
 	    !ovl_allow_offline_changes(ofs)) {
@@ -323,6 +329,7 @@ static int ovl_create_upper(struct dentry *dentry, struct=
 inode *inode,
 		goto out_cleanup;
 out_unlock:
 	inode_unlock(udir);
+out:
 	return err;
=20
 out_cleanup:
@@ -367,9 +374,12 @@ static struct dentry *ovl_clear_empty(struct dentry *den=
try,
=20
 	opaquedir =3D ovl_create_temp(ofs, workdir, OVL_CATTR(stat.mode));
 	err =3D PTR_ERR(opaquedir);
-	if (IS_ERR(opaquedir))
-		goto out_unlock;
-
+	if (IS_ERR(opaquedir)) {
+		/* workdir was unlocked, no upperdir */
+		inode_unlock(upperdir->d_inode);
+		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
+		return ERR_PTR(err);
+	}
 	err =3D ovl_copy_xattr(dentry->d_sb, &upperpath, opaquedir);
 	if (err)
 		goto out_cleanup;
@@ -455,8 +465,13 @@ static int ovl_create_over_whiteout(struct dentry *dentr=
y, struct inode *inode,
=20
 	newdentry =3D ovl_create_temp(ofs, workdir, cattr);
 	err =3D PTR_ERR(newdentry);
-	if (IS_ERR(newdentry))
-		goto out_dput;
+	if (IS_ERR(newdentry)) {
+		/* workdir was unlocked, not upperdir */
+		inode_unlock(upperdir->d_inode);
+		mutex_unlock(&upperdir->d_sb->s_vfs_rename_mutex);
+		dput(upper);
+		goto out;
+	}
=20
 	/*
 	 * mode could have been mutilated due to umask (e.g. sgid directory)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6f2f8f4cfbbc..f7f7c3d1ad63 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -248,6 +248,7 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *=
ofs,
 {
 	dentry =3D vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) =3D %i\n", dentry, mode, PTR_ERR_OR_ZERO(dentry)=
);
+	/* Note: dir will have been unlocked on failure */
 	return dentry;
 }
=20
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index b63474d1b064..56055c70f200 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -366,14 +366,17 @@ static struct dentry *ovl_workdir_create(struct ovl_fs =
*ofs,
 			goto out_dput;
 	} else {
 		err =3D PTR_ERR(work);
+		inode_unlock(dir);
 		goto out_err;
 	}
 out_unlock:
-	inode_unlock(dir);
+	if (work && !IS_ERR(work))
+		inode_unlock(dir);
 	return work;
=20
 out_dput:
 	dput(work);
+	inode_unlock(dir);
 out_err:
 	pr_warn("failed to create directory %s/%s (errno: %i); mounting read-only\n=
",
 		ofs->config.workdir, name, -err);
@@ -569,7 +572,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 	temp =3D ovl_create_temp(ofs, workdir, OVL_CATTR(S_IFREG | 0));
 	err =3D PTR_ERR(temp);
 	if (IS_ERR(temp))
-		goto out_unlock;
+		return err;
=20
 	dest =3D ovl_lookup_temp(ofs, workdir);
 	err =3D PTR_ERR(dest);
@@ -620,10 +623,13 @@ static struct dentry *ovl_lookup_or_create(struct ovl_f=
s *ofs,
=20
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
 	child =3D ovl_lookup_upper(ofs, name, parent, len);
-	if (!IS_ERR(child) && !child->d_inode)
+	if (!IS_ERR(child) && !child->d_inode) {
 		child =3D ovl_create_real(ofs, parent->d_inode, child,
 					OVL_CATTR(mode));
-	inode_unlock(parent->d_inode);
+		if (!IS_ERR(child))
+			inode_unlock(parent->d_inode);
+	} else
+		inode_unlock(parent->d_inode);
 	dput(parent);
=20
 	return child;
diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 3537f3cca6d5..af59183374ae 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -171,7 +171,7 @@ xrep_orphanage_create(
 					     orphanage_dentry, 0750);
 		error =3D PTR_ERR(orphanage_dentry);
 		if (IS_ERR(orphanage_dentry))
-			goto out_unlock_root;
+			goto out_dput_root;
 	}
=20
 	/* Not a directory? Bail out. */




