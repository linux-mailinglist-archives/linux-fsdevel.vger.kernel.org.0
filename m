Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451133DB12E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 04:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhG3Cgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 22:36:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43036 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3Cgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:36:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F7501FD9A;
        Fri, 30 Jul 2021 02:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627612598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWUcvHlwusRZYuqr62Cexf1wHC01k6ATksIHt0UTG40=;
        b=UhW+Hbjx8tuF8MjAQ9iMxsBOeOKr3PYAuzL4ld/oKJ4MHstFmCHTrngccPItHLfOyno9At
        NrKtIX6JNIizMqL+I72Rm7PRtceMjU9jMPrsngFG0aE1ZBC3E6zR16XxcwKf1c1GIoRgqQ
        uCjZ/JiIOBKbmIZdykI9Dgk0bSue8Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627612598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWUcvHlwusRZYuqr62Cexf1wHC01k6ATksIHt0UTG40=;
        b=5Y+gQU01MyCUiSEbZGelJ/ftp0KpZFMwwFnKFr2Wc97x86J2PFseXrU7DryK5pLhRPf28R
        lUuDPz0thr9tyRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DFC813BF9;
        Fri, 30 Jul 2021 02:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iXzyBrJlA2FFUwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 02:36:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "Neal Gompa" <ngompa13@gmail.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <20210729232017.GE10106@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>,
 <20210729023751.GL10170@hungrycats.org>,
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>,
 <20210729232017.GE10106@hungrycats.org>
Date:   Fri, 30 Jul 2021 12:36:31 +1000
Message-id: <162761259105.21659.4838403432058511846@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I've been pondering all the excellent feedback, and what I have learnt
from examining the code in btrfs, and I have developed a different
perspective.

Maybe "subvol" is a poor choice of name because it conjures up
connections with the Volumes in LVM, and btrfs subvols are very different
things.  Btrfs subvols are really just subtrees that can be treated as a
unit for operations like "clone" or "destroy".

As such, they don't really deserve separate st_dev numbers.

Maybe the different st_dev numbers were introduced as a "cheap" way to
extend to size of the inode-number space.  Like many "cheap" things, it
has hidden costs.

Maybe objects in different subvols should still be given different inode
numbers.  This would be problematic on 32bit systems, but much less so on
64bit systems.

The patch below, which is just a proof-of-concept, changes btrfs to
report a uniform st_dev, and different (64bit) st_ino in different subvols.

It has problems:
 - it will break any 32bit readdir and 32bit stat.  I don't know how big
   a problem that is these days (ino_t in the kernel is "unsigned long",
   not "unsigned long long). That surprised me).
 - It might break some user-space expectations.  One thing I have learnt
   is not to make any assumption about what other people might expect.

However, it would be quite easy to make this opt-in (or opt-out) with a
mount option, so that people who need the current inode numbers and will
accept the current breakage can keep working.

I think this approach would be a net-win for NFS export, whether BTRFS
supports it directly or not.  I might post a patch which modifies NFS to
intuit improved inode numbers for btrfs exports....

So: how would this break your use-case??

Thanks,
NeilBrown

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0117d867ecf8..8dc58c848502 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6020,6 +6020,37 @@ static int btrfs_opendir(struct inode *inode, struct f=
ile *file)
 	return 0;
 }
=20
+static u64 btrfs_make_inum(struct btrfs_key *root, struct btrfs_key *ino)
+{
+	u64 rootid =3D root->objectid;
+	u64 inoid =3D ino->objectid;
+	int shift =3D 64-8;
+
+	if (ino->type =3D=3D BTRFS_ROOT_ITEM_KEY) {
+		/* This is a subvol root found during readdir. */
+		rootid =3D inoid;
+		inoid =3D BTRFS_FIRST_FREE_OBJECTID;
+	}
+	if (rootid =3D=3D BTRFS_FS_TREE_OBJECTID)
+		/* this is main vol, not subvol (I think) */
+		return inoid;
+	/* store the rootid in the high bits of the inum.  This
+	 * will break if 32bit inums are required - we cannot know
+	 */
+	while (rootid) {
+		inoid ^=3D (rootid & 0xff) << shift;
+		rootid >>=3D 8;
+		shift -=3D 8;
+	}
+	return inoid;
+}
+
+static inline u64 btrfs_ino_to_inum(struct inode *inode)
+{
+	return btrfs_make_inum(&BTRFS_I(inode)->root->root_key,
+			       &BTRFS_I(inode)->location);
+}
+
 struct dir_entry {
 	u64 ino;
 	u64 offset;
@@ -6045,6 +6076,49 @@ static int btrfs_filldir(void *addr, int entries, stru=
ct dir_context *ctx)
 	return 0;
 }
=20
+static inline bool btrfs_dir_emit_dot(struct file *file,
+				      struct dir_context *ctx)
+{
+	return ctx->actor(ctx, ".", 1, ctx->pos,
+			  btrfs_ino_to_inum(file->f_path.dentry->d_inode),
+			  DT_DIR) =3D=3D 0;
+}
+
+static inline ino_t btrfs_parent_ino(struct dentry *dentry)
+{
+	ino_t res;
+
+	/*
+	 * Don't strictly need d_lock here? If the parent ino could change
+	 * then surely we'd have a deeper race in the caller?
+	 */
+	spin_lock(&dentry->d_lock);
+	res =3D btrfs_ino_to_inum(dentry->d_parent->d_inode);
+	spin_unlock(&dentry->d_lock);
+	return res;
+}
+
+static inline bool btrfs_dir_emit_dotdot(struct file *file,
+					 struct dir_context *ctx)
+{
+	return ctx->actor(ctx, "..", 2, ctx->pos,
+			  btrfs_parent_ino(file->f_path.dentry), DT_DIR) =3D=3D 0;
+}
+static inline bool btrfs_dir_emit_dots(struct file *file,
+				       struct dir_context *ctx)
+{
+	if (ctx->pos =3D=3D 0) {
+		if (!btrfs_dir_emit_dot(file, ctx))
+			return false;
+		ctx->pos =3D 1;
+	}
+	if (ctx->pos =3D=3D 1) {
+		if (!btrfs_dir_emit_dotdot(file, ctx))
+			return false;
+		ctx->pos =3D 2;
+	}
+	return true;
+}
 static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode =3D file_inode(file);
@@ -6067,7 +6141,7 @@ static int btrfs_real_readdir(struct file *file, struct=
 dir_context *ctx)
 	bool put =3D false;
 	struct btrfs_key location;
=20
-	if (!dir_emit_dots(file, ctx))
+	if (!btrfs_dir_emit_dots(file, ctx))
 		return 0;
=20
 	path =3D btrfs_alloc_path();
@@ -6136,7 +6210,8 @@ static int btrfs_real_readdir(struct file *file, struct=
 dir_context *ctx)
 		put_unaligned(fs_ftype_to_dtype(btrfs_dir_type(leaf, di)),
 				&entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
-		put_unaligned(location.objectid, &entry->ino);
+		put_unaligned(btrfs_make_inum(&root->root_key, &location),
+			      &entry->ino);
 		put_unaligned(found_key.offset, &entry->offset);
 		entries++;
 		addr +=3D sizeof(struct dir_entry) + name_len;
@@ -9193,7 +9268,7 @@ static int btrfs_getattr(struct user_namespace *mnt_use=
rns,
 				  STATX_ATTR_NODUMP);
=20
 	generic_fillattr(&init_user_ns, inode, stat);
-	stat->dev =3D BTRFS_I(inode)->root->anon_dev;
+	stat->ino =3D btrfs_ino_to_inum(inode);
=20
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes =3D BTRFS_I(inode)->new_delalloc_bytes;
