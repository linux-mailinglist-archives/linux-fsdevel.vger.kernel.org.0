Return-Path: <linux-fsdevel+bounces-75366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGW1IRckdWnZBAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:57:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8247EC7F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A34B7300E617
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099F27A907;
	Sat, 24 Jan 2026 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pciKRYg9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF221E087;
	Sat, 24 Jan 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284614; cv=none; b=fVNFieZ8qCGlce3pvEeMgCS1dEqTXFAN+htznoMyFf0MqjnRKvd3yx/FsnYTKRkkjoeWqD9m5G7KsHtUjOMOEpCMAQKxKVDUGmWzHH3ILGUYn4PKVvnpscqydlC5fSuHztFuNo9i89zxXuBe5T17mEA+3rcVNxC8brxxNoayk2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284614; c=relaxed/simple;
	bh=2AhmNxlKYyEz7NdtUEtG+V0aFgRFNQJLkeoMAvdc78E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h2wxWk67i44++pnxYYPZ8SL9owhmvXQeTcaV3kjKACtfE/nFNhRcWPdk/s+iJJ1yET9//ZGYN0AbXewxr+btB3UHLY34f5W8pqyxd9fUzrm2eUUepCkhrCYLrZOvAm0e7XR1zDyKcG49i5hd49UDAa5J0Y/5WJ/aU47Vde1qnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pciKRYg9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iGiLW5CaWRd2qfdlJfXCe7h5yLiWyAefKYeW3bPegVI=; b=pciKRYg9h8NYU1EY56CKpvVcRg
	rHB/YPg5Wyon2MFL2WPZyF1ki+7HpTAsXt7CWyusKcREWBXEYJEP/7uqmjBr/yS0i+gOD5c+pJylg
	pUbA9i/HGthpxDV8dMQdca+hUafNRyrujtgghOgvKxymvXuY3bX0ShImLsvB4HE44oJeyFwTLLOCd
	WT+O4STF0wgQIMHNGJZWPgOafPibMF9Gb2jetNP4oR/Losit0iTcntEmWck/NAaXJpwDqtd0+q5vq
	r0pio0h/fI+061MFlKyJrOrc9bVz1x7DXV4VG2Y3E06j0MC3uNkPYDcpNi7LURKhpcr9ifNygrPVI
	FS7bMMXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjjmD-00000004Pzv-2hN4;
	Sat, 24 Jan 2026 19:58:34 +0000
Date: Sat, 24 Jan 2026 19:58:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: [RFC][PATCH] get rid of weirdness around NFS dummy root dentries
Message-ID: <20260124195833.GN3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75366-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 0B8247EC7F
X-Rspamd-Action: no action

	These days (starting from 2013, actually) dcache_shrink_for_umount() is not
bothered by having ->s_root spliced onto one of the secondary trees, so the reason
for having a weird alias for root directory (manually removed from the alias list
of directory inode, which violates all kinds of assumptions) no longer applies.

	Just use the dentry we are about to return as ->s_root, if it hasn't been
set already.  And don't bother with manual security_d_instantiate(), while we are
at it - d_obtain_root() has already done that.

	NOTE: if root of the first mount does get spliced onto the bigger subtree
of subsequent mount, it will keep the resulting chain of ancestors pinned in dcache
for as long as any of mounts exist.  That won't affect the "is the filesystem busy"
logics, though; just that after
	mount foo:/bar/baz/barf /path1
	mount foo:/bar/ /path2
	ls /path2/baz/barf
	umount /path1
we'll get the dentries of /path2/baz and /path2/baz/barf stay in dcache (unhashed
if invalidated, etc.) until /path2 is also unmounted, rather than having only the
dummy root pinned.

	AFAICS, it works and unless there are other reasons why need it, it would
be nice to get rid of that wart.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index f13d25d95b85..2ac8404e1a15 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -32,35 +32,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
-/*
- * Set the superblock root dentry.
- * Note that this function frees the inode in case of error.
- */
-static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *inode)
-{
-	/* The mntroot acts as the dummy root dentry for this superblock */
-	if (sb->s_root == NULL) {
-		sb->s_root = d_make_root(inode);
-		if (sb->s_root == NULL)
-			return -ENOMEM;
-		ihold(inode);
-		/*
-		 * Ensure that this dentry is invisible to d_find_alias().
-		 * Otherwise, it may be spliced into the tree by
-		 * d_splice_alias if a parent directory from the same
-		 * filesystem gets mounted at a later time.
-		 * This again causes shrink_dcache_for_umount_subtree() to
-		 * Oops, since the test for IS_ROOT() will fail.
-		 */
-		spin_lock(&d_inode(sb->s_root)->i_lock);
-		spin_lock(&sb->s_root->d_lock);
-		hlist_del_init(&sb->s_root->d_u.d_alias);
-		spin_unlock(&sb->s_root->d_lock);
-		spin_unlock(&d_inode(sb->s_root)->i_lock);
-	}
-	return 0;
-}
-
 /*
  * get a root dentry from the root filehandle
  */
@@ -99,10 +70,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	error = nfs_superblock_set_dummy_root(s, inode);
-	if (error != 0)
-		goto out_fattr;
-
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
@@ -115,7 +82,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	security_d_instantiate(root, inode);
 	spin_lock(&root->d_lock);
 	if (IS_ROOT(root) && !root->d_fsdata &&
 	    !(root->d_flags & DCACHE_NFSFS_RENAMED)) {
@@ -123,6 +89,8 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		name = NULL;
 	}
 	spin_unlock(&root->d_lock);
+	if (!s->s_root)
+		s->s_root = dget(root);
 	fc->root = root;
 	if (server->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;

