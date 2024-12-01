Return-Path: <linux-fsdevel+bounces-36196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C60C9DF506
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 09:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A50DB2128D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104580C09;
	Sun,  1 Dec 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovew2DYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A62E40B;
	Sun,  1 Dec 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733042618; cv=none; b=jZv6quuh/sDz2t1LFXrOxWZRRaVl44veoYKC4h/RWsDq1T+NLjtT8DqXMlAIVuvgLlV1cnIxe+rRf7F2M5xR2bIydC7hnp4vbsjWUy8fLsCE2gdyDziWHDSVRTfa5gAWSKyP/RLN3UcaFqJgAFcvSPuGxPmOmrUiUJ5rybodOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733042618; c=relaxed/simple;
	bh=8VENiXlv73ozid2HjMLr+tXbk6AVzqo55p3RfWHrlUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDzNKypydpNgW84/ysnteCNSzJz9d2uEQiYpvm4pbC08FqbCEUEgJD8bI43XDokI082A/fQsRAEveIuSPqU1aMfBomskW0pnz6WuQfRb/LTBnoxOqpFWPMjmJmQSjsIDHLYoJwOomK6iGlbree+6NHqDFZzNsHkCvVq8WbM0Fvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovew2DYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB67C4CECF;
	Sun,  1 Dec 2024 08:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733042617;
	bh=8VENiXlv73ozid2HjMLr+tXbk6AVzqo55p3RfWHrlUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ovew2DYhtQtGcJKL+uEimeAREv5QtTnE4QCOzBuFXrTELv6Awda8TI/p2fcMBhu3z
	 YB50ByT6G6qNT3T6zoGRQmDtnNJh01KZjvJfx5HW7xtcuNwMYUAfOepooXaPbxSye3
	 tLSXWqQ1AQROB1m4i5m4tb63ooM/ZeGnAsARqxpLvOEDYgxN+oVHzsjPszLBhVdH6G
	 QeJwGPnHy5G93L7tG6nBePPeyQJaLIwiZD0Fah55x0X898AM2JYmVj3gWBTQynkZXF
	 wP7t0bTiJvCeiaPJVdtjxc/GwiUOHdqB/B5Fm8TDblgEfaojjBw/Il0Wm6Q29vnoNM
	 suGxFgn+yHGtw==
Date: Sun, 1 Dec 2024 09:43:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Erin Shepherd <erin.shepherd@e43.eu>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH RFC 0/6] pidfs: implement file handle support
Message-ID: <20241130-witzbold-beiwagen-9b14358b7b17@brauner>
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org>
 <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <CAOQ4uxhKVkaWm_Vv=0zsytmvT0jCq1pZ84dmrQ_buhxXi2KEhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhKVkaWm_Vv=0zsytmvT0jCq1pZ84dmrQ_buhxXi2KEhw@mail.gmail.com>

On Sat, Nov 30, 2024 at 01:22:05PM +0100, Amir Goldstein wrote:
> On Fri, Nov 29, 2024 at 2:39 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Hey,
> >
> > Now that we have the preliminaries to lookup struct pid based on its
> > inode number alone we can implement file handle support.
> >
> > This is based on custom export operation methods which allows pidfs to
> > implement permission checking and opening of pidfs file handles cleanly
> > without hacking around in the core file handle code too much.
> >
> > This is lightly tested.
> 
> With my comments addressed as you pushed to vfs-6.14.pidfs branch
> in your tree, you may add to the patches posted:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> HOWEVER,
> IMO there is still one thing that has to be addressed before merge -
> We must make sure that nfsd cannot export pidfs.
> 
> In principal, SB_NOUSER filesystems should not be accessible to
> userspace paths, so exportfs should not be able to configure nfsd
> export of pidfs, but maybe this limitation can be worked around by
> using magic link paths?

I don't see how. I might be missing details.

> I think it may be worth explicitly disallowing nfsd export of SB_NOUSER
> filesystems and we could also consider blocking SB_KERNMOUNT,
> but may there are users exporting ramfs?

No need to restrict it if it's safe, I guess.

> Jeff has mentioned that he thinks we are blocking export of cgroupfs
> by nfsd, but I really don't see where that is being enforced.
> The requirement for FS_REQUIRES_DEV in check_export() is weak
> because user can overrule it with manual fsid argument to exportfs.
> So maybe we disallow nfsd export of kernfs and backport to stable kernels
> to be on the safe side?

File handles and nfs export have become two distinct things and there
filesystems based on kernfs, and pidfs want to support file handles
without support nfs export.

So I think instead of having nfs check what filesystems may be exported
we should let the filesystems indicate that they cannot be exported and
make nfs honour that.

So something like the untested sketch:

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1..a5c75cb1c812 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -154,6 +154,7 @@ static const struct export_operations kernfs_export_ops = {
 	.fh_to_dentry	= kernfs_fh_to_dentry,
 	.fh_to_parent	= kernfs_fh_to_parent,
 	.get_parent	= kernfs_get_parent_dentry,
+	.flags		= EXPORT_OP_FILE_HANDLE,
 };
 
 /**
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index eacafe46e3b6..170c5729e7f2 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -417,6 +417,7 @@ static struct svc_export *svc_export_lookup(struct svc_export *);
 static int check_export(struct path *path, int *flags, unsigned char *uuid)
 {
 	struct inode *inode = d_inode(path->dentry);
+	const struct export_operations *nop;
 
 	/*
 	 * We currently export only dirs, regular files, and (for v4
@@ -449,11 +450,16 @@ static int check_export(struct path *path, int *flags, unsigned char *uuid)
 		return -EINVAL;
 	}
 
-	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
+	if (!exportfs_can_decode_fh(nop)) {
 		dprintk("exp_export: export of invalid fs type.\n");
 		return -EINVAL;
 	}
 
+	if (nop && nop->flags & EXPORT_OP_FILE_HANDLE) {
+		dprintk("exp_export: filesystem only supports non-exportable file handles.\n");
+		return -EINVAL;
+	}
+
 	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 9aa7493b1e10..d1646c0789e1 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -83,10 +83,15 @@ void ovl_revert_creds(const struct cred *old_cred)
  */
 int ovl_can_decode_fh(struct super_block *sb)
 {
+	const struct export_operations *nop = sb->s_export_op;
+
 	if (!capable(CAP_DAC_READ_SEARCH))
 		return 0;
 
-	if (!exportfs_can_decode_fh(sb->s_export_op))
+	if (!exportfs_can_decode_fh(nop))
+		return 0;
+
+	if (nop && nop->flags & EXPORT_OP_FILE_HANDLE)
 		return 0;
 
 	return sb->s_export_op->encode_fh ? -1 : FILEID_INO32_GEN;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index dde3e4e90ea9..9d98b5461dc7 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -570,6 +570,7 @@ static const struct export_operations pidfs_export_operations = {
 	.fh_to_dentry	= pidfs_fh_to_dentry,
 	.open		= pidfs_export_open,
 	.permission	= pidfs_export_permission,
+	.flags          = EXPORT_OP_FILE_HANDLE,
 };
 
 static int pidfs_init_inode(struct inode *inode, void *data)
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index a087606ace19..98f7cb17abee 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -280,6 +280,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
+#define EXPORT_OP_FILE_HANDLE		(0x80) /* fs only supports file handles, no proper export */
 	unsigned long	flags;
 };

> On top of that, we may also want to reject nfsd export of any fs
> with custom ->open() or ->permission() export ops, on the grounds
> that nfsd does not call these ops?
> 
> Regarding the two other kernel users of exportfs, namely,
> overlayfs and fanotify -
> 
> For overlayfs, I think that in ovl_can_decode_fh() we can safely
> opt-out of SB_NOUSER and SB_KERNMOUNT filesystems,
> to not allow nfs exporting of overlayfs over those lower fs.
> 
> For fanotify, there is already a check in fanotify_events_supported()
> to disallow sb/mount marks on SB_NOUSER and a comment that
> questions the value of allowing them for SB_KERNMOUNT.
> So for pidfs there is no risk wrt fanotify and it does not look like pidfs
> is going to generate any fanotify events anyway.

