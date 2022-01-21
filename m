Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF92495FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380637AbiAUNsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 08:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346435AbiAUNsc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642772912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=daa3X8S2/sB/X5eaM/oVFuqBp+vMHvnAUkni/sLTqEo=;
        b=VY3G0y/zOUpFTErNx2MvuV0n0El0yyFhkHCiMmT++zrMYsxx0sbC6hy1p/qLfpRrJFha4m
        pYr0mjMQHNhRsC7leQwd4UVVb8/DWU60g6cIkwt1t/aOCF9JljwrFDgt7pNxM/w3jbIbmK
        praoEcleAA+tWypVdNcF3AnBbb6KoVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-QmC4RKiAORGpkxSVatzj4A-1; Fri, 21 Jan 2022 08:48:28 -0500
X-MC-Unique: QmC4RKiAORGpkxSVatzj4A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54DE083DD3F;
        Fri, 21 Jan 2022 13:48:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE48C7B6FB;
        Fri, 21 Jan 2022 13:48:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        JeffleXu <jefflexu@linux.alibaba.com>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cachefiles: Split and rename S_KERNEL_FILE and extend effects
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1079105.1642772886.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 21 Jan 2022 13:48:06 +0000
Message-ID: <1079106.1642772886@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

After the recent controversy over the S_KERNEL_FILE flag, I wonder if it
should be split into two different flags with different functions and have
more appropriate names given to reflect this to make its function easier t=
o
understand.  I've put in some not particulary great suggestions as to the
naming, but something better might suggest itself to others.  I've also le=
ft
the flags generic as there's nothing specifically about them that means th=
ey
couldn't be used by other kernel drivers too.

Hopefully, I've also done a better job of explaining the issues (including=
 a
couple of races) the flags fix in the attached patch.

Amir's suggestion of moving the no-remove check into may_delete()
unfortunately doesn't work because the flag forbidding the VFS op (eg. rmd=
ir)
needs to be done with the lock held, to stop the flag from being changed u=
ntil
the VFS op is complete.

David
---
Split S_KERNEL_FILE into two separate flags to do two separate jobs and gi=
ve
them new names[1][2]:

 (1) S_INUSE.  This allows a kernel service to mark an inode as in-use by
     that kernel service.  This is then used by cachefiles to indicate tha=
t
     it is using a file or directory.  Cachefiles uses this for three
     things:

     (a) Defending against double-use of part of the cache due to bugs,
         races or misconfiguration - which could lead to data corruption.

     (b) As a fast way to tell whether a file is in use when cachefilesd
         asks to cull it (culling is offloaded to userspace).  Previously,
         the inode details were used to look up in a big tree of records -
         but doing the same job with a single bit is less expensive.

     (c) To stop a file that we've agreed cachefilesd may cull from being
         reused by the cache.  This fixes a race between the cull request
         and the object being buried because we have to drop the inode
         locks that we've taken so that we can call functions like
         vfs_unlink().

         The race gives a window in which the object can get looked up
         again - but if the file is in a cullable state, there's nowhere t=
o
         make a note that it needs to be got rid of except the backing
         inode.

 (2) S_NOREMOVE.  If this is set, the file or directory may not be removed=
,
     renamed or unlinked.  This can then be used by cachefiles to prevent
     userspace removing or renaming files and directories that the are
     being used.

     The directory layout in its cache is very important to cachefiles as
     the names are how it indexes the contents.  Removing objects can caus=
e
     cachefilesd to malfunction as it may find it can't reach bits of the
     structure that it previously created and still has dentry pointers to=
.

     This also closes a race between cachefilesd trying to cull an empty
     directory and cachefiles trying to create something in it.

     Amir Goldstein suggested that the check in vfs_rmdir() should be move=
d
     to may_delete()[1], but it really needs to be done whilst the inode
     lock is held.

Both of these flags can only be changed under the inode lock.  I would
recommend that S_NOREMOVE only be set/cleared if S_INUSE is first set.

Note that potential usage of these flags is by no means limited to
cachefiles, which is why they've been left as general.  S_INUSE, for
example, if set by one kernel service, will cause another kernel service
that uses the flag in the same way to abort that use.

Note also that S_NOREMOVE will prevent vfs_unlink() vfs_rmdir() and
vfs_rename() from operating on a file.

Also define IS_xxx() macros for the above flags[3].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/CAOQ4uxjEcvffv=3DrNXS-r+NLz+=3D6yk4abRuX_A=
Mq9v-M4nf_PtA@mail.gmail.com [1]
Link: https://lore.kernel.org/r/Ydvl8Dk8z0mF0KFl@infradead.org/ [2]
Link: https://lore.kernel.org/r/88d7f8970dcc0fd0ead891b1f42f160b8d17d60e.c=
amel@kernel.org/ [3]
---
 fs/cachefiles/namei.c |   18 ++++++++++--------
 fs/namei.c            |    8 +++++---
 include/linux/fs.h    |    5 ++++-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f256c8aff7bb..30b7b71158c4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -20,8 +20,8 @@ static bool __cachefiles_mark_inode_in_use(struct cachef=
iles_object *object,
 	struct inode *inode =3D d_backing_inode(dentry);
 	bool can_use =3D false;
 =

-	if (!(inode->i_flags & S_KERNEL_FILE)) {
-		inode->i_flags |=3D S_KERNEL_FILE;
+	if (!IS_INUSE(inode)) {
+		inode->i_flags |=3D S_INUSE | S_NOREMOVE;
 		trace_cachefiles_mark_active(object, inode);
 		can_use =3D true;
 	} else {
@@ -53,7 +53,7 @@ static void __cachefiles_unmark_inode_in_use(struct cach=
efiles_object *object,
 {
 	struct inode *inode =3D d_backing_inode(dentry);
 =

-	inode->i_flags &=3D ~S_KERNEL_FILE;
+	inode->i_flags &=3D ~(S_INUSE | S_NOREMOVE);
 	trace_cachefiles_mark_inactive(object, inode);
 }
 =

@@ -392,8 +392,10 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,
 		};
 		trace_cachefiles_rename(object, d_inode(rep)->i_ino, why);
 		ret =3D cachefiles_inject_read_error();
-		if (ret =3D=3D 0)
+		if (ret =3D=3D 0) {
+			__cachefiles_unmark_inode_in_use(object, rep);
 			ret =3D vfs_rename(&rd);
+		}
 		if (ret !=3D 0)
 			trace_cachefiles_vfs_error(object, d_inode(dir), ret,
 						   cachefiles_trace_rename_error);
@@ -402,7 +404,6 @@ int cachefiles_bury_object(struct cachefiles_cache *ca=
che,
 					    "Rename failed with error %d", ret);
 	}
 =

-	__cachefiles_unmark_inode_in_use(object, rep);
 	unlock_rename(cache->graveyard, dir);
 	dput(grave);
 	_leave(" =3D 0");
@@ -426,6 +427,7 @@ int cachefiles_delete_object(struct cachefiles_object =
*object,
 	dget(dentry);
 =

 	inode_lock_nested(d_backing_inode(fan), I_MUTEX_PARENT);
+	cachefiles_unmark_inode_in_use(object, object->file);
 	ret =3D cachefiles_unlink(volume->cache, object, fan, dentry, why);
 	inode_unlock(d_backing_inode(fan));
 	dput(dentry);
@@ -746,7 +748,7 @@ static struct dentry *cachefiles_lookup_for_cull(struc=
t cachefiles_cache *cache,
 		goto lookup_error;
 	if (d_is_negative(victim))
 		goto lookup_put;
-	if (d_inode(victim)->i_flags & S_KERNEL_FILE)
+	if (IS_INUSE(d_inode(victim)))
 		goto lookup_busy;
 	return victim;
 =

@@ -793,11 +795,11 @@ int cachefiles_cull(struct cachefiles_cache *cache, =
struct dentry *dir,
 	/* check to see if someone is using this object */
 	inode =3D d_inode(victim);
 	inode_lock(inode);
-	if (inode->i_flags & S_KERNEL_FILE) {
+	if (IS_INUSE(inode)) {
 		ret =3D -EBUSY;
 	} else {
 		/* Stop the cache from picking it back up */
-		inode->i_flags |=3D S_KERNEL_FILE;
+		inode->i_flags |=3D S_INUSE;
 		ret =3D 0;
 	}
 	inode_unlock(inode);
diff --git a/fs/namei.c b/fs/namei.c
index d81f04f8d818..99eddc41f6aa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3959,7 +3959,7 @@ int vfs_rmdir(struct user_namespace *mnt_userns, str=
uct inode *dir,
 =

 	error =3D -EBUSY;
 	if (is_local_mountpoint(dentry) ||
-	    (dentry->d_inode->i_flags & S_KERNEL_FILE))
+	    IS_NOREMOVE(dentry->d_inode))
 		goto out;
 =

 	error =3D security_inode_rmdir(dir, dentry);
@@ -4090,7 +4090,8 @@ int vfs_unlink(struct user_namespace *mnt_userns, st=
ruct inode *dir,
 	inode_lock(target);
 	if (IS_SWAPFILE(target))
 		error =3D -EPERM;
-	else if (is_local_mountpoint(dentry))
+	else if (is_local_mountpoint(dentry) ||
+		 IS_NOREMOVE(dentry->d_inode))
 		error =3D -EBUSY;
 	else {
 		error =3D security_inode_unlink(dir, dentry);
@@ -4603,7 +4604,8 @@ int vfs_rename(struct renamedata *rd)
 		goto out;
 =

 	error =3D -EBUSY;
-	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
+	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry) |=
|
+	    IS_NOREMOVE(old_dentry->d_inode))
 		goto out;
 =

 	if (max_links && new_dir !=3D old_dir) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5d3bf5b69a6..68cae4aaa6ff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2173,7 +2173,8 @@ struct super_operations {
 #define S_ENCRYPTED	(1 << 14) /* Encrypted file (using fs/crypto/) */
 #define S_CASEFOLD	(1 << 15) /* Casefolded file */
 #define S_VERITY	(1 << 16) /* Verity file (using fs/verity/) */
-#define S_KERNEL_FILE	(1 << 17) /* File is in use by the kernel (eg. fs/c=
achefiles) */
+#define S_INUSE		(1 << 17) /* File is in use by the kernel (eg. fs/cachef=
iles) */
+#define S_NOREMOVE	(1 << 18) /* File is not to be removed or renamed */
 =

 /*
  * Note that nosuid etc flags are inode-specific: setting some file-syste=
m
@@ -2216,6 +2217,8 @@ static inline bool sb_rdonly(const struct super_bloc=
k *sb) { return sb->s_flags
 #define IS_ENCRYPTED(inode)	((inode)->i_flags & S_ENCRYPTED)
 #define IS_CASEFOLDED(inode)	((inode)->i_flags & S_CASEFOLD)
 #define IS_VERITY(inode)	((inode)->i_flags & S_VERITY)
+#define IS_INUSE(inode)		((inode)->i_flags & S_INUSE)
+#define IS_NOREMOVE(inode)	((inode)->i_flags & S_NOREMOVE)
 =

 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev =3D=3D WHITEOUT_DEV)

