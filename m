Return-Path: <linux-fsdevel+bounces-68603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CEAC610BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 07:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 567BE4E308D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 06:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD13423ABBD;
	Sun, 16 Nov 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v87ep+8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230E21465B4;
	Sun, 16 Nov 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763274663; cv=none; b=Cg6D7IwYGX8JsBi6ZeZS6FU4/21APdNs9XT3XDyAz4W6cUrE/lFsXmjDgZ7EYJJ0w6d6+Swr3dMpCcVDSrZSqWkxTWW/VbnYdkKsXgED4Y1dH6QBDTj0E0LvWBO7ns2JIT46XFohuGUshJfu5hqMjESm7gHV1mh6a9gt25KcG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763274663; c=relaxed/simple;
	bh=dLIBx9wnRf4ju6UVlPQmOJFWndyfpiiKv2OWpaEs5rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k10FFZqhYIMrGhit8AR2qarqyMQNHvZSZTVvKQoVKYv1tzAlRgOF2vD9V6TkmjRD7W6bARQQhfEO31X8N8ZsDU44aNcpld1ouLNY3U0MYc4tHHsinnTIbhEQxPF/mZL/+6zn6qQPuXG5U7A+J3NvYyuhJoPp3KdjtoYV8xYpPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v87ep+8s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=CSaTv+g6iTeyfNwAPb2UZSBv3rc0hQYoL1YvQs/TGcA=; b=v87ep+8sGAj47MEf8Vt4uadQZk
	43mSG/U79MDARH/6bYNHWYEijJCkGJlTApHxDreiHLLZkq2qjparHOIa8lh4alzW34fB6LARDpvoq
	a0tzMldguNQi01Y3KE+ZamiC2CGY+r1XBlYwAhZvQT42pRdi83POrqpQ/KgmCrP2H9U6V/h9J+URe
	7TZKT/6AEJtzbW1csZg/Nf9SbWs9D/NPnstDd2Jkzk2xyIjQO+HzNXWvKJIhrZhTAqyNMImpj9WXS
	2UDAdfdak31c1xzZAJF2F3bpuo5eTczIsPAO7ceypi0uEUZb4ZieasuxVGFqwzwJDx4l0egDgHhP7
	bvKKdfyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWHj-0000000Ccfr-1WoW;
	Sun, 16 Nov 2025 06:30:51 +0000
Date: Sun, 16 Nov 2025 06:30:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <20251116063051.GA2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025111555-spoon-backslid-8d1f@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 15, 2025 at 08:21:34AM -0500, Greg Kroah-Hartman wrote:

> Ugh, messy.  But yes, this does look better, thanks for that.  Want me
> to take it through the USB tree, or will you take it through one of
> yours? (I don't remember what started this thread...)

I'll carve it up in several chunks and push to #work.functionfs; will post
tomorrow morning.  Minimal fix for ffs_epfiles_destroy() bug folded into #36
in #work.persistency - replacement for that commit below; are you OK with
that one?  It's orthogonal to the rest of the mess in there.

commit b9c24b7499916a1dbee50a4429fc04ebf7e21f03
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Sep 17 22:55:33 2025 -0400

    functionfs: switch to simple_remove_by_name()
    
    No need to return dentry from ffs_sb_create_file() or keep it around
    afterwards.
    
    To avoid subtle issues with getting to ffs from epfiles in
    ffs_epfiles_destroy(), pass the superblock as explicit argument.
    Callers have it anyway.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 47cfbe41fdff..6e6933a9fe45 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -160,8 +160,6 @@ struct ffs_epfile {
 	struct ffs_data			*ffs;
 	struct ffs_ep			*ep;	/* P: ffs->eps_lock */
 
-	struct dentry			*dentry;
-
 	/*
 	 * Buffer for holding data from partial reads which may happen since
 	 * we’re rounding user read requests to a multiple of a max packet size.
@@ -271,11 +269,11 @@ struct ffs_desc_helper {
 };
 
 static int  __must_check ffs_epfiles_create(struct ffs_data *ffs);
-static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count);
+static void ffs_epfiles_destroy(struct super_block *sb,
+				struct ffs_epfile *epfiles, unsigned count);
 
-static struct dentry *
-ffs_sb_create_file(struct super_block *sb, const char *name, void *data,
-		   const struct file_operations *fops);
+static int ffs_sb_create_file(struct super_block *sb, const char *name,
+			      void *data, const struct file_operations *fops);
 
 /* Devices management *******************************************************/
 
@@ -1866,9 +1864,8 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 }
 
 /* Create "regular" file */
-static struct dentry *ffs_sb_create_file(struct super_block *sb,
-					const char *name, void *data,
-					const struct file_operations *fops)
+static int ffs_sb_create_file(struct super_block *sb, const char *name,
+			      void *data, const struct file_operations *fops)
 {
 	struct ffs_data	*ffs = sb->s_fs_info;
 	struct dentry	*dentry;
@@ -1876,16 +1873,16 @@ static struct dentry *ffs_sb_create_file(struct super_block *sb,
 
 	dentry = d_alloc_name(sb->s_root, name);
 	if (!dentry)
-		return NULL;
+		return -ENOMEM;
 
 	inode = ffs_sb_make_inode(sb, data, fops, NULL, &ffs->file_perms);
 	if (!inode) {
 		dput(dentry);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	d_add(dentry, inode);
-	return dentry;
+	return 0;
 }
 
 /* Super block */
@@ -1928,10 +1925,7 @@ static int ffs_sb_fill(struct super_block *sb, struct fs_context *fc)
 		return -ENOMEM;
 
 	/* EP0 file */
-	if (!ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations))
-		return -ENOMEM;
-
-	return 0;
+	return ffs_sb_create_file(sb, "ep0", ffs, &ffs_ep0_operations);
 }
 
 enum {
@@ -2161,7 +2155,7 @@ static void ffs_data_closed(struct ffs_data *ffs)
 							flags);
 
 			if (epfiles)
-				ffs_epfiles_destroy(epfiles,
+				ffs_epfiles_destroy(ffs->sb, epfiles,
 						 ffs->eps_count);
 
 			if (ffs->setup_state == FFS_SETUP_PENDING)
@@ -2226,7 +2220,7 @@ static void ffs_data_clear(struct ffs_data *ffs)
 	 * copy of epfile will save us from use-after-free.
 	 */
 	if (epfiles) {
-		ffs_epfiles_destroy(epfiles, ffs->eps_count);
+		ffs_epfiles_destroy(ffs->sb, epfiles, ffs->eps_count);
 		ffs->epfiles = NULL;
 	}
 
@@ -2323,6 +2317,7 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 {
 	struct ffs_epfile *epfile, *epfiles;
 	unsigned i, count;
+	int err;
 
 	count = ffs->eps_count;
 	epfiles = kcalloc(count, sizeof(*epfiles), GFP_KERNEL);
@@ -2339,12 +2334,11 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
 		else
 			sprintf(epfile->name, "ep%u", i);
-		epfile->dentry = ffs_sb_create_file(ffs->sb, epfile->name,
-						 epfile,
-						 &ffs_epfile_operations);
-		if (!epfile->dentry) {
-			ffs_epfiles_destroy(epfiles, i - 1);
-			return -ENOMEM;
+		err = ffs_sb_create_file(ffs->sb, epfile->name,
+					 epfile, &ffs_epfile_operations);
+		if (err) {
+			ffs_epfiles_destroy(ffs->sb, epfiles, i - 1);
+			return err;
 		}
 	}
 
@@ -2352,16 +2346,15 @@ static int ffs_epfiles_create(struct ffs_data *ffs)
 	return 0;
 }
 
-static void ffs_epfiles_destroy(struct ffs_epfile *epfiles, unsigned count)
+static void ffs_epfiles_destroy(struct super_block *sb,
+				struct ffs_epfile *epfiles, unsigned count)
 {
 	struct ffs_epfile *epfile = epfiles;
+	struct dentry *root = sb->s_root;
 
 	for (; count; --count, ++epfile) {
 		BUG_ON(mutex_is_locked(&epfile->mutex));
-		if (epfile->dentry) {
-			simple_recursive_removal(epfile->dentry, NULL);
-			epfile->dentry = NULL;
-		}
+		simple_remove_by_name(root, epfile->name, NULL);
 	}
 
 	kfree(epfiles);

