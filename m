Return-Path: <linux-fsdevel+bounces-39868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E3DA19A5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B863AC9A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45531C5F2B;
	Wed, 22 Jan 2025 21:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f4Z7PTLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B625A1C5D64;
	Wed, 22 Jan 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737581101; cv=none; b=Cl6P4Xdx7hhKOQ/Au1JyA/MiJQovKdyHT6scUVMfpx6T68SFZNdx4Soe6Picu59ws8Tn03a+uNj8LzKA0RMmjNtl2DzEIDx9gD0ijSNPPetcFz6xYD9TU1gC0QNblGT65i4uGQfIwMrPOIuopXNvs/f24gnn1+ybZ58Ub6H/SL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737581101; c=relaxed/simple;
	bh=L3wby2Xc3JR89MSoGfqjJ+nhKa/cuxN3/wba+ayzDL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSEL7u4lGGTgPkgQR2RoSHdx8qspjoBe38B+v2vNT6d+Big/4z6qMoKwdUDonAGplPVesyfbDjsHG1+r6AJ+/TNSWaJyEEsHDihiXvpOq27Yd+xL0WS5exkIA7ABT24ijiZN/d0B0JAO52TMjcBbpGIPXKrMHkKgYk6sXm+u5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f4Z7PTLA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E1gx7IlX9hOJkDbodUVnN+t8TR6bvMTWZysQxuIIuyM=; b=f4Z7PTLADs6J8ANoVJhizUEkH3
	OPXw4JGYqin406HnRrzc0uhUlrY/lh7E32hzDhLaqCF1TNTPTWJL86qDNCM8UDT04ol2qkh2RNzY3
	s9dWNK8QiQBc78FfPvuA/K1teqX2mWe8iaPOqcbBBskeRiVzRh+vE9aThtzQINk9vtEvhg10SwIAk
	6pI8Rd+UARItDeG5oVZP2ypHlj0ktCkZSyJi8uMjYFTKlAHCKLly5To7F4kOb82zClxG9HTUI27B1
	/zDeigQByDdVGIYuazQma94I1iNy+fELNqwYqpIEoaoCZP/zy4rEYerr6asynwo+t7PLKDjSKo5e8
	HiTg9SJQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1taiDY-000000082zQ-1lcY;
	Wed, 22 Jan 2025 21:24:56 +0000
Date: Wed, 22 Jan 2025 21:24:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, agruenba@redhat.com, amir73il@gmail.com,
	brauner@kernel.org, ceph-devel@vger.kernel.org, hubcap@omnibond.com,
	jack@suse.cz, krisman@kernel.org, linux-nfs@vger.kernel.org,
	miklos@szeredi.hu, torvalds@linux-foundation.org
Subject: Re: [PATCH v2 08/20] afs_d_revalidate(): use stable name and parent
 inode passed by caller
Message-ID: <20250122212456.GA1977892@ZenIV>
References: <20250116052317.485356-8-viro@zeniv.linux.org.uk>
 <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
 <2066311.1737577661@warthog.procyon.org.uk>
 <20250122210124.GZ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122210124.GZ1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 22, 2025 at 09:01:24PM +0000, Al Viro wrote:
> On Wed, Jan 22, 2025 at 08:27:41PM +0000, David Howells wrote:
> > Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > > -	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
> > > +	_enter("{%lu},{%s},", dir->i_ino, name->name);
> > 
> > I don't think that name->name is guaranteed to be NUL-terminated after
> > name->len characters.  The following:
> > 
> > 	_enter("{%lu},{%*s},", dir->i_ino, name->len, name->name);
> > 
> > might be better, though:
> > 
> > 	_enter("{%lu},{%*.*s},", dir->i_ino, name->len, name->len, name->name);
> > 
> > might be necessary.
> 
> Good catch (and that definitely needs to be documented in previous commit),
> but what's wrong with
> 	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);

IOW, are you OK with the following?

commit bf61e4013ab1cb9a819303faca018e7b7cbaf3e7
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri Jan 3 00:27:27 2025 -0500

    afs_d_revalidate(): use stable name and parent inode passed by caller
    
    No need to bother with boilerplate for obtaining the latter and for
    the former we really should not count upon ->d_name.name remaining
    stable under us.
    
    Reviewed-by: Jeff Layton <jlayton@kernel.org>
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9780013cd83a..e04cffe4beb1 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -607,19 +607,19 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name,
  * Do a lookup of a single name in a directory
  * - just returns the FID the dentry name maps to if found
  */
-static int afs_do_lookup_one(struct inode *dir, struct dentry *dentry,
+static int afs_do_lookup_one(struct inode *dir, const struct qstr *name,
 			     struct afs_fid *fid, struct key *key,
 			     afs_dataversion_t *_dir_version)
 {
 	struct afs_super_info *as = dir->i_sb->s_fs_info;
 	struct afs_lookup_one_cookie cookie = {
 		.ctx.actor = afs_lookup_one_filldir,
-		.name = dentry->d_name,
+		.name = *name,
 		.fid.vid = as->volume->vid
 	};
 	int ret;
 
-	_enter("{%lu},%p{%pd},", dir->i_ino, dentry, dentry);
+	_enter("{%lu},{%.*s},", dir->i_ino, name->len, name->name);
 
 	/* search the directory */
 	ret = afs_dir_iterate(dir, &cookie.ctx, key, _dir_version);
@@ -1052,21 +1052,12 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 /*
  * Check the validity of a dentry under RCU conditions.
  */
-static int afs_d_revalidate_rcu(struct dentry *dentry)
+static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 {
-	struct afs_vnode *dvnode;
-	struct dentry *parent;
-	struct inode *dir;
 	long dir_version, de_version;
 
 	_enter("%p", dentry);
 
-	/* Check the parent directory is still valid first. */
-	parent = READ_ONCE(dentry->d_parent);
-	dir = d_inode_rcu(parent);
-	if (!dir)
-		return -ECHILD;
-	dvnode = AFS_FS_I(dir);
 	if (test_bit(AFS_VNODE_DELETED, &dvnode->flags))
 		return -ECHILD;
 
@@ -1097,9 +1088,8 @@ static int afs_d_revalidate_rcu(struct dentry *dentry)
 static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 			    struct dentry *dentry, unsigned int flags)
 {
-	struct afs_vnode *vnode, *dir;
+	struct afs_vnode *vnode, *dir = AFS_FS_I(parent_dir);
 	struct afs_fid fid;
-	struct dentry *parent;
 	struct inode *inode;
 	struct key *key;
 	afs_dataversion_t dir_version, invalid_before;
@@ -1107,7 +1097,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	int ret;
 
 	if (flags & LOOKUP_RCU)
-		return afs_d_revalidate_rcu(dentry);
+		return afs_d_revalidate_rcu(dir, dentry);
 
 	if (d_really_is_positive(dentry)) {
 		vnode = AFS_FS_I(d_inode(dentry));
@@ -1122,14 +1112,9 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	if (IS_ERR(key))
 		key = NULL;
 
-	/* Hold the parent dentry so we can peer at it */
-	parent = dget_parent(dentry);
-	dir = AFS_FS_I(d_inode(parent));
-
 	/* validate the parent directory */
 	ret = afs_validate(dir, key);
 	if (ret == -ERESTARTSYS) {
-		dput(parent);
 		key_put(key);
 		return ret;
 	}
@@ -1157,7 +1142,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	afs_stat_v(dir, n_reval);
 
 	/* search the directory for this vnode */
-	ret = afs_do_lookup_one(&dir->netfs.inode, dentry, &fid, key, &dir_version);
+	ret = afs_do_lookup_one(&dir->netfs.inode, name, &fid, key, &dir_version);
 	switch (ret) {
 	case 0:
 		/* the filename maps to something */
@@ -1201,22 +1186,19 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 		goto out_valid;
 
 	default:
-		_debug("failed to iterate dir %pd: %d",
-		       parent, ret);
+		_debug("failed to iterate parent %pd2: %d", dentry, ret);
 		goto not_found;
 	}
 
 out_valid:
 	dentry->d_fsdata = (void *)(unsigned long)dir_version;
 out_valid_noupdate:
-	dput(parent);
 	key_put(key);
 	_leave(" = 1 [valid]");
 	return 1;
 
 not_found:
 	_debug("dropping dentry %pd2", dentry);
-	dput(parent);
 	key_put(key);
 
 	_leave(" = 0 [bad]");

