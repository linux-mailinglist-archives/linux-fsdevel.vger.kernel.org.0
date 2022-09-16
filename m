Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA05BA6A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 08:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIPGNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 02:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPGNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:13:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC74FA1D5D
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 23:13:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8509A3389A;
        Fri, 16 Sep 2022 06:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663308818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5GXe9vUqt+1UZ4q+/F3nx5Z5U5Uq7mDoX2V3REVxJU=;
        b=nNWUllJt2gSnfHpeI/T2oNXt2MpsPJWnTqae8cnwI+bP0+PmHe1d1ztKYpaM0Pcr0J7rvj
        HozF/HlmmG3gn/CCKKS8pYSAQj1LqL9HPDl3uyGtvQFmRgTEIOlqfSpehofj0XUD6PeVX6
        Jy+ZjOjL9AcvaI4HgDs7dDxsY5ohMuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663308818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5GXe9vUqt+1UZ4q+/F3nx5Z5U5Uq7mDoX2V3REVxJU=;
        b=P7aQRxjqMxjHzFgTSDDnbfBnz2YOSYXHor6caiMK3/Jehmcj4HyGzcVascOsMIBJuSlph/
        RN4fICsYTQEGrQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4AA11346B;
        Fri, 16 Sep 2022 06:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w273HhAUJGO5EAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 16 Sep 2022 06:13:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Al Viro" <viro@zeniv.linux.org.uk>
Cc:     "Miklos Szeredi" <mszeredi@redhat.com>,
        "Xavier Roche" <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC] VFS: lock source directory for link to avoid rename race.
In-reply-to: <YyEcqxthoso9SGI2@ZenIV>
References: <20220221082002.508392-1-mszeredi@redhat.com>,
 <166304411168.30452.12018495245762529070@noble.neil.brown.name>,
 <YyATCgxi9Ovi8mYv@ZenIV>,
 <166311315747.20483.5039023553379547679@noble.neil.brown.name>,
 <YyEcqxthoso9SGI2@ZenIV>
Date:   Fri, 16 Sep 2022 16:13:31 +1000
Message-id: <166330881189.15759.13499931397891560275@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


rename(2) is documented as

       If newpath already exists, it will be atomically replaced, so
       that there is no point at which another process attempting to
       access newpath will find it missing.

However link(2) from a given path can race with rename renaming to that
path so that link gets -ENOENT because the path has already been unlinked
by rename, and creating a link to an unlinked file is not permitted.

This can be fixed by locking the source directory before performing the
lookup of the final component.  The lock blocks rename from changing
that component.

We already lock the target directory, so when they are different we need
to be careful about deadlocks.  In the worst case we can use the same
strategy as lock_rename() however the cost of s_vfs_rename_mutex is not
always needed and is best avoided.

Firstly we lock the target and if the source is different we try-lock
that.  This cannot deadlock as we never block while holding a lock.  If
the trylock fails, we drop the first lock, take s_vfs_rename_mutex, and
follow the same pattern as rename_lock().  We only take a shared lock on
the source directory.

->link() functions cannot expect the source directory to be locked as
some callers of vfs_link() already have a dentry and do not perform the
lookup that can race with rename.  nfsd is a clear example - if there is
a race it can happen on the client or between clients, and NFS as
specified cannot avoid that.

The handling of AT_EMPTY_PATH is a little inelegant.

Reported-by: Xavier Roche <xavier.roche@algolia.com>
Link: https://lore.kernel.org/all/20220214210708.GA2167841@xavier-xps/
Fixes: aae8a97d3ec3 ("fs: Don't allow to create hardlink for deleted file")
Reported-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 .../filesystems/directory-locking.rst         |  25 +++-
 Documentation/filesystems/locking.rst         |   6 +-
 fs/namei.c                                    | 119 ++++++++++++++----
 3 files changed, 124 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/=
filesystems/directory-locking.rst
index 504ba940c36c..da6fa5eff81d 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -11,7 +11,7 @@ When taking the i_rwsem on multiple non-directory objects, =
we
 always acquire the locks in order by increasing address.  We'll call
 that "inode pointer" order in the following.
=20
-For our purposes all operations fall in 5 classes:
+For our purposes all operations fall in 7 classes:
=20
 1) read access.  Locking rules: caller locks directory we are accessing.
 The lock is taken shared.
@@ -31,9 +31,9 @@ Then call the method.  All locks are exclusive.
 NB: we might get away with locking the source (and target in exchange
 case) shared.
=20
-5) link creation.  Locking rules:
+5) link creation - source and target in name directory.  Locking rules:
=20
-	* lock parent
+	* lock parent before looking up base names
 	* check that source is not a directory
 	* lock source
 	* call the method.
@@ -58,6 +58,22 @@ rules:
 All ->i_rwsem are taken exclusive.  Again, we might get away with locking
 the source (and target in exchange case) shared.
=20
+7) cross-directory link.  This requires the source directory to be locked
+so the source cannot be the target of a rename and so be unlinked before
+the link happens (creating a link to an unlinked file is illegal).
+
+Same rules as cross-directory rename can be used (with different errors).
+Locking the filesystem is expensive and often unnecessary so we have a=20
+fast path that avoids it.  Locking rules:
+
+	* lock target parent
+	* trylock source parent.  If this fails we unlock target parent
+	  and fall back to full rename locking, then unlock filesystem once
+          directory locks are held.
+	* lookup base names
+
+Lock on source may be shared.
+
 The rules above obviously guarantee that all directories that are going to be
 read, modified or removed by method will be locked by caller.
=20
@@ -101,6 +117,9 @@ non-directory objects are not included in the set of cont=
ended locks.
 Thus link creation can't be a part of deadlock - it can't be
 blocked on source and it means that it doesn't hold any locks.
=20
+The fast-path in link create cannot deadlock as it never blocks while=20
+holding a lock.
+
 Any contended object is either held by cross-directory rename or
 has a child that is also contended.  Indeed, suppose that it is held by
 operation other than cross-directory rename.  Then the lock this operation
diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystem=
s/locking.rst
index 4bb2627026ec..3190bb18f1c2 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -92,7 +92,7 @@ ops		i_rwsem(inode)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
 lookup:		shared
 create:		exclusive
-link:		exclusive (both)
+link:		exclusive (both) possibly shared on source dir
 mknod:		exclusive
 symlink:	exclusive
 mkdir:		exclusive
@@ -117,7 +117,11 @@ fileattr_set:	exclusive
=20
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_rwsem
 	exclusive on victim.
+	->rename() has ->i_rwsem on target if it exists, and also on
+        source if it is a non-directory.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->link() may have shared ->i_rwsem on source directory if it is
+	different from target directory.
=20
 See Documentation/filesystems/directory-locking.rst for more detailed discus=
sion
 of the locking scheme for directory operations.
diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..877cac4e2e63 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4518,6 +4518,39 @@ int vfs_link(struct dentry *old_dentry, struct user_na=
mespace *mnt_userns,
 }
 EXPORT_SYMBOL(vfs_link);
=20
+static void lock_link(struct dentry *dest, struct dentry *source, int flags)
+{
+	inode_lock_nested(dest->d_inode, I_MUTEX_PARENT);
+	if (dest =3D=3D source || (flags & AT_EMPTY_PATH))
+		return;
+	if (inode_trylock_shared(source->d_inode))
+		return;
+
+	/* Need rename mutex */
+	inode_unlock(dest->d_inode);
+
+	mutex_lock(&dest->d_sb->s_vfs_rename_mutex);
+
+	if (d_ancestor(dest, source)) {
+		inode_lock_nested(dest->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(source->d_inode, I_MUTEX_CHILD);
+	} else if (d_ancestor(source, dest)) {
+		inode_lock_shared_nested(source->d_inode, I_MUTEX_PARENT);
+		inode_lock_nested(dest->d_inode, I_MUTEX_CHILD);
+	} else {
+		inode_lock_nested(dest->d_inode, I_MUTEX_PARENT);
+		inode_lock_shared_nested(source->d_inode, I_MUTEX_PARENT2);
+	}
+	mutex_unlock(&dest->d_sb->s_vfs_rename_mutex);
+}
+
+static void unlock_link(struct dentry *dest, struct dentry *source, int flag=
s)
+{
+	if (source !=3D dest && !(flags & AT_EMPTY_PATH))
+		inode_unlock_shared(source->d_inode);
+	inode_unlock(dest->d_inode);
+}
+
 /*
  * Hardlinks are often used in delicate situations.  We avoid
  * security-related surprises by not following symlinks on the
@@ -4531,11 +4564,14 @@ int do_linkat(int olddfd, struct filename *old, int n=
ewdfd,
 	      struct filename *new, int flags)
 {
 	struct user_namespace *mnt_userns;
-	struct dentry *new_dentry;
-	struct path old_path, new_path;
+	struct dentry *old_dentry, *new_dentry;
+	struct path old_path, new_path, link_path;
+	struct qstr old_last, new_last;
+	int old_type, new_type;
 	struct inode *delegated_inode =3D NULL;
 	int how =3D 0;
 	int error;
+	int err2;
=20
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) !=3D 0) {
 		error =3D -EINVAL;
@@ -4554,44 +4590,83 @@ int do_linkat(int olddfd, struct filename *old, int n=
ewdfd,
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |=3D LOOKUP_FOLLOW;
 retry:
-	error =3D filename_lookup(olddfd, old, how, &old_path, NULL);
+	err2 =3D 0;
+	error =3D filename_parentat(olddfd, old, how, &old_path,
+				  &old_last, &old_type);
 	if (error)
 		goto out_putnames;
+	error =3D -EISDIR;
+	if (old_type !=3D LAST_NORM && !(flags & AT_EMPTY_PATH))
+		goto out_putnames;
+	error =3D filename_parentat(newdfd, new, (how & LOOKUP_REVAL), &new_path,
+				  &new_last, &new_type);
+	if (error)
+		goto out_putoldpath;
=20
-	new_dentry =3D filename_create(newdfd, new, &new_path,
-					(how & LOOKUP_REVAL));
-	error =3D PTR_ERR(new_dentry);
-	if (IS_ERR(new_dentry))
-		goto out_putpath;
+	err2 =3D mnt_want_write(new_path.mnt);
=20
 	error =3D -EXDEV;
 	if (old_path.mnt !=3D new_path.mnt)
-		goto out_dput;
+		goto out_putnewpath;
+	lock_link(new_path.dentry, old_path.dentry, flags);
+
+	new_dentry =3D __lookup_hash(&new_last, new_path.dentry, how & LOOKUP_REVAL=
);
+	error =3D PTR_ERR(new_dentry);
+	if (IS_ERR(new_dentry))
+		goto out_unlock;
+	error =3D -EEXIST;
+	if (d_is_positive(new_dentry))
+		goto out_dput_new;
+	if (new_type !=3D LAST_NORM)
+		goto out_dput_new;
+
+	error =3D err2;
+	if (error)
+		goto out_dput_new;
+
+	if (flags & AT_EMPTY_PATH)
+		old_dentry =3D dget(old_path.dentry);
+	else
+		old_dentry =3D __lookup_hash(&old_last, old_path.dentry, how);
+	error =3D PTR_ERR(old_dentry);
+	if (IS_ERR(old_dentry))
+		goto out_dput_new;
+	error =3D -ENOENT;
+	if (d_is_negative(old_dentry))
+		goto out_dput_old;
+
 	mnt_userns =3D mnt_user_ns(new_path.mnt);
-	error =3D may_linkat(mnt_userns, &old_path);
+	link_path.mnt =3D old_path.mnt;
+	link_path.dentry =3D old_dentry;
+	error =3D may_linkat(mnt_userns, &link_path);
 	if (unlikely(error))
-		goto out_dput;
-	error =3D security_path_link(old_path.dentry, &new_path, new_dentry);
+		goto out_dput_old;
+	error =3D security_path_link(old_dentry, &new_path, new_dentry);
 	if (error)
-		goto out_dput;
-	error =3D vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+		goto out_dput_old;
+	error =3D vfs_link(old_dentry, mnt_userns, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
-out_dput:
-	done_path_create(&new_path, new_dentry);
+out_dput_old:
+	dput(old_dentry);
+out_dput_new:
+	dput(new_dentry);
+out_unlock:
+	unlock_link(new_path.dentry, old_path.dentry, flags);
+out_putnewpath:
+	if (!err2)
+		mnt_drop_write(new_path.mnt);
+	path_put(&new_path);
+out_putoldpath:
+	path_put(&old_path);
 	if (delegated_inode) {
 		error =3D break_deleg_wait(&delegated_inode);
-		if (!error) {
-			path_put(&old_path);
+		if (!error)
 			goto retry;
-		}
 	}
 	if (retry_estale(error, how)) {
-		path_put(&old_path);
 		how |=3D LOOKUP_REVAL;
 		goto retry;
 	}
-out_putpath:
-	path_put(&old_path);
 out_putnames:
 	putname(old);
 	putname(new);
--=20
2.37.1

