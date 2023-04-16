Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484DF6E3CBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 01:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjDPXOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 19:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPXOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 19:14:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2163C2116;
        Sun, 16 Apr 2023 16:14:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAD36219D3;
        Sun, 16 Apr 2023 23:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681686846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8DKA8509LHQxSlYzEhSziVDmqQKZXLWw9DF/3aJfuc=;
        b=VUjyirxqot9R4W4wuLD6TSP4odC6E+a8NFBFZlltfSe1PyQmdJTwiJZBaFkxDDW1W3prET
        hGrKnDOWOi48S3rc8/9kL8vYaiua8W1+agGZaQBNP2LwAZUX/rmrh79MIYlOpR01lxg1iW
        NjS7xhssr0a4Lcs0hE7vABxx103JOwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681686846;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V8DKA8509LHQxSlYzEhSziVDmqQKZXLWw9DF/3aJfuc=;
        b=o6hooudXI2clAK8AqcJZUU6icNrC/ZF7wBV7RzkyzOXdSmACUi1we7JtdsSzZ0vBkr1pYG
        OsdRXFqotWMRJfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E11E913498;
        Sun, 16 Apr 2023 23:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ra+lJTuBPGSMeAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 16 Apr 2023 23:14:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Dave Wysochanski" <dwysocha@redhat.com>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs" <linux-nfs@vger.kernel.org>,
        "David Howells" <dhowells@redhat.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: [PATCH/RFC] VFS: LOOKUP_MOUNTPOINT should used cached info whenever possible.
In-reply-to: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
Date:   Mon, 17 Apr 2023 09:13:52 +1000
Message-id: <168168683217.24821.6260957092725278201@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


When performing a LOOKUP_MOUNTPOINT lookup we don't really want to
engage with underlying systems at all.  Any mount point MUST be in the
dcache with a complete direct path from the root to the mountpoint.
That should be sufficient to find the mountpoint given a path name.

This becomes an issue when the filesystem changes unexpected, such as
when a NFS server is changed to reject all access.  It then becomes
impossible to unmount anything mounted on the filesystem which has
changed.  We could simply lazy-unmount the changed filesystem and that
will often be sufficient.  However if the target filesystem needs
"umount -f" to complete the unmount properly, then the lazy unmount will
leave it incompletely unmounted.  When "-f" is needed, we really need to
be able to name the target filesystem.

We NEVER want to revalidate anything.  We already avoid the revalidation
of the mountpoint itself, be we won't need to revalidate anything on the
path either as thay might affect the cache, and the cache is what we are
really looking in.

Permission checks are a little less clear.  We currently allow any user
to make the umount syscall and perform the path lookup and only reject
unprivileged users once the target mount point has been found.  If we
completely relax permission checks then an unprivileged user could probe
inaccessible parts of the name space by examining the error returned
from umount().

So we only relax permission check when the user has CAP_SYS_ADMIN
(may_mount() succeeds).

Note that if the path given is not direct and for example uses symlinks
or "..", then dentries or symlink content may not be cached and a remote
server could cause problem.  We can only be certain of a safe unmount if
a direct path is used.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccaef..f2df1adae7c5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -498,8 +498,8 @@ static int sb_permission(struct super_block *sb, struct i=
node *inode, int mask)
  *
  * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
  */
-int inode_permission(struct mnt_idmap *idmap,
-		     struct inode *inode, int mask)
+int inode_permission_mp(struct mnt_idmap *idmap,
+			struct inode *inode, int mask, bool mp)
 {
 	int retval;
=20
@@ -523,7 +523,14 @@ int inode_permission(struct mnt_idmap *idmap,
 			return -EACCES;
 	}
=20
-	retval =3D do_inode_permission(idmap, inode, mask);
+	if (mp)
+		/* We are looking for a mountpoint and so don't
+		 * want to interact with the filesystem at all, just
+		 * the dcache and icache.
+		 */
+		retval =3D generic_permission(idmap, inode, mask);
+	else
+		retval =3D do_inode_permission(idmap, inode, mask);
 	if (retval)
 		return retval;
=20
@@ -533,6 +540,24 @@ int inode_permission(struct mnt_idmap *idmap,
=20
 	return security_inode_permission(inode, mask);
 }
+
+/**
+ * inode_permission - Check for access rights to a given inode
+ * @idmap:	idmap of the mount the inode was found from
+ * @inode:	Inode to check permission on
+ * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ *
+ * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
+ * this, letting us set arbitrary permissions for filesystem access without
+ * changing the "normal" UIDs which are used for other things.
+ *
+ * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
+ */
+int inode_permission(struct mnt_idmap *idmap,
+		     struct inode *inode, int mask)
+{
+	return inode_permission_mp(idmap, inode, mask, false);
+}
 EXPORT_SYMBOL(inode_permission);
=20
 /**
@@ -589,6 +614,7 @@ struct nameidata {
 #define ND_ROOT_PRESET 1
 #define ND_ROOT_GRABBED 2
 #define ND_JUMPED 4
+#define ND_SYS_ADMIN 8
=20
 static void __set_nameidata(struct nameidata *p, int dfd, struct filename *n=
ame)
 {
@@ -853,7 +879,8 @@ static bool try_to_unlazy_next(struct nameidata *nd, stru=
ct dentry *dentry)
=20
 static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 {
-	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
+	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE) &&
+	    likely(!(flags & LOOKUP_MOUNTPOINT)))
 		return dentry->d_op->d_revalidate(dentry, flags);
 	else
 		return 1;
@@ -1708,12 +1735,17 @@ static struct dentry *lookup_slow(const struct qstr *=
name,
 static inline int may_lookup(struct mnt_idmap *idmap,
 			     struct nameidata *nd)
 {
+	/* If we are looking for a mountpoint and we have the SYS_ADMIN
+	 * capability, then we will by-pass the filesys for permission checks
+	 * and just use generic_permission().
+	 */
+	bool mp =3D (nd->flags & LOOKUP_MOUNTPOINT) && (nd->state & ND_SYS_ADMIN);
 	if (nd->flags & LOOKUP_RCU) {
-		int err =3D inode_permission(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
+		int err =3D inode_permission_mp(idmap, nd->inode, MAY_EXEC|MAY_NOT_BLOCK, =
mp);
 		if (err !=3D -ECHILD || !try_to_unlazy(nd))
 			return err;
 	}
-	return inode_permission(idmap, nd->inode, MAY_EXEC);
+	return inode_permission_mp(idmap, nd->inode, MAY_EXEC, mp);
 }
=20
 static int reserve_stack(struct nameidata *nd, struct path *link)
@@ -2501,6 +2533,8 @@ int filename_lookup(int dfd, struct filename *name, uns=
igned flags,
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 	set_nameidata(&nd, dfd, name, root);
+	if ((flags & LOOKUP_MOUNTPOINT) && may_mount())
+		nd.state =3D ND_SYS_ADMIN;
 	retval =3D path_lookupat(&nd, flags | LOOKUP_RCU, path);
 	if (unlikely(retval =3D=3D -ECHILD))
 		retval =3D path_lookupat(&nd, flags, path);
--=20
2.40.0

