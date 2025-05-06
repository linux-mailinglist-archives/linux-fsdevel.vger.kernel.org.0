Return-Path: <linux-fsdevel+bounces-48279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F73AACCF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC31C04125
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B9286888;
	Tue,  6 May 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qrWIK9g8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA6221FBC;
	Tue,  6 May 2025 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746555371; cv=none; b=ZZLDdyR+E/OfApZ/3GN7PQQEI6tpXDrtZcKfKEshapLcjYZhfq4jvLpLXHeP9+x0mF9KBWbyXcCuk/8qKsZSecyxnMSMxyO9KFgIGswTkSqFtXYEBFyVr4xbln/GdEf/Hk2Lnz2JxVwxvSNhaPELsfFhr9MixwlMm+9floC+3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746555371; c=relaxed/simple;
	bh=nu7sB6KIhyYYAshkLXr01OixMLPfCVVWGamY4gpkfIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW66j3Q0IsgMCqwKMADzTSh7VtF5NrKwfxRn3ezBtCGuM34L33nQ/wiSH4tC2y9NVEasO/Tdyzmm3+JpNNaGtRpFApOx9WnRoBzk+htQhVMcyRnF89jMhUdIE3NuNuhlb+OOqUHzwZtrkqM4Iy4ar/RdOyYM5pxpdCZmfjUsN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qrWIK9g8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOHlJCcq/Cai5TplIIcvhfBFp6DOMO5wvBu/ooYKMfo=; b=qrWIK9g83iL2YXiKq38lakKS9Q
	qjhwLiGvrqHydXoIO8aD2wFKjQltU5ngXX0BIK01mPezxKueLon95p89fSws5UoQWzuTDmUqnp+up
	AqLVQznttm392QF2iJCr4qzQkzqCvJTCLufYRz22QSSeMoRdFXuMXTJP3OeRh6Rr7iIWNQSDu1SlD
	QFDoBxPnOndqOzeojd1oafoUwjvn/8q2uYG9P03TzSPjyxoSIFQSk+/qiESEtEDxmXpZ8W02pI/Vq
	YlAafMsekmPTUvyJUG1XOv+ZMOokPjpyis+99a56EeuVqvevESpwr51a1e0ug9Q+dI+rZZJw97ay5
	3BpuzV1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCMpp-0000000Bz1c-06cW;
	Tue, 06 May 2025 18:16:05 +0000
Date: Tue, 6 May 2025 19:16:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506181604.GP2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 07:54:32PM +0200, Klara Modin wrote:

> > > Though now I hit another issue which I don't know if it's related or
> > > not. I'm using an overlay mount with squashfs as lower and btrfs as
> > > upper. The mount fails with invalid argument and I see this in the log:
> > > 
> > > overlayfs: failed to clone upperpath
> > 
> > Seeing that you already have a kernel with that thing reverted, could
> > you check if the problem exists there?
> 
> Yeah, it works fine with the revert instead.

Interesting...  That message means that you've got clone_private_mount()
returning an error; the thing is, mount passed to it has come from
pathname lookup - it is *not* the mount created by that fc_mount() of
vfs_create_mount() in the modified code.  That one gets passed to
mount_subvol() and consumed there (by mount_subtree()).  All that is returned
is root dentry; the mount passed to clone_private_mount() is created
from scratch using dentry left by btrfs_get_tree_subvol() in its fc->root -
see
        dentry = mount_subvol(ctx->subvol_name, ctx->subvol_objectid, mnt);
        ctx->subvol_name = NULL;
        if (IS_ERR(dentry))
                return PTR_ERR(dentry);

        fc->root = dentry;
        return 0;
in the end of btrfs_get_tree_subvol().

What's more, on the overlayfs side we managed to get to
        upper_mnt = clone_private_mount(upperpath);
        err = PTR_ERR(upper_mnt);
        if (IS_ERR(upper_mnt)) {
                pr_err("failed to clone upperpath\n");
                goto out;
so the upper path had been resolved...

OK, let's try to see what clone_private_mount() is unhappy about...
Could you try the following on top of -next + braino fix and see
what shows up?  Another interesting thing, assuming you can get
to shell after overlayfs mount failure, would be /proc/self/mountinfo
contents and stat(1) output for upper path of your overlayfs mount...

diff --git a/fs/namespace.c b/fs/namespace.c
index eb990e9a668a..f7ce53f437dd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2480,31 +2480,45 @@ struct vfsmount *clone_private_mount(const struct path *path)
 
 	guard(rwsem_read)(&namespace_sem);
 
-	if (IS_MNT_UNBINDABLE(old_mnt))
+	if (IS_MNT_UNBINDABLE(old_mnt)) {
+		pr_err("unbindable");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (mnt_has_parent(old_mnt)) {
-		if (!check_mnt(old_mnt))
+		if (!check_mnt(old_mnt)) {
+			pr_err("mounted, but not in our namespace");
 			return ERR_PTR(-EINVAL);
+		}
 	} else {
-		if (!is_mounted(&old_mnt->mnt))
+		if (!is_mounted(&old_mnt->mnt)) {
+			pr_err("not mounted");
 			return ERR_PTR(-EINVAL);
+		}
 
 		/* Make sure this isn't something purely kernel internal. */
-		if (!is_anon_ns(old_mnt->mnt_ns))
+		if (!is_anon_ns(old_mnt->mnt_ns)) {
+			pr_err("kern_mount?");
 			return ERR_PTR(-EINVAL);
+		}
 
 		/* Make sure we don't create mount namespace loops. */
-		if (!check_for_nsfs_mounts(old_mnt))
+		if (!check_for_nsfs_mounts(old_mnt)) {
+			pr_err("shite with nsfs");
 			return ERR_PTR(-EINVAL);
+		}
 	}
 
-	if (has_locked_children(old_mnt, path->dentry))
+	if (has_locked_children(old_mnt, path->dentry)) {
+		pr_err("has locked children");
 		return ERR_PTR(-EINVAL);
+	}
 
 	new_mnt = clone_mnt(old_mnt, path->dentry, CL_PRIVATE);
-	if (IS_ERR(new_mnt))
+	if (IS_ERR(new_mnt)) {
+		pr_err("clone_mnt failed (%ld)", PTR_ERR(new_mnt));
 		return ERR_PTR(-EINVAL);
+	}
 
 	/* Longterm mount to be removed by kern_unmount*() */
 	new_mnt->mnt_ns = MNT_NS_INTERNAL;

