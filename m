Return-Path: <linux-fsdevel+bounces-48285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B97AACDBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCFC1C056DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 19:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1791F3FDC;
	Tue,  6 May 2025 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Pt/LKtZW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BB15A864;
	Tue,  6 May 2025 19:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558319; cv=none; b=E4q9vWZlngRGrtsL6y5g5RLlkYdm8wzlteV2iywfXz7wmRfYfX5nMoHM/lOjY9Bx6m0KmiDUdlW+XfVH67pL5bBLMKe1JXbpLe5FTdVt+gp+HmAFPjBEf5cmS6NMJZhjAcSkWvOxeNFDyBw+QehFIfg3DlX/MOVcg2cs7puFZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558319; c=relaxed/simple;
	bh=uAQ15w330im6aLssqx+KuKQqOGxi/pZ/S61LGAzQwgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qgw3nYQB1wydhpry9KNVwPdqImN/DM6nhYM4qooWIeJik5qQI2YalO3ZO7dgJB954xyRZlSUu0lto/MawQ9G5KqDQWTQI/IKkgYDu70HJcJYFCGPd98bTVNiDxj602lcjtrhrp8FqwIK7rerkTQp5BsExZXgjd8x1esTQAHEiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Pt/LKtZW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i0jiH1VTmbgJbHbY2FLJRMvr9+b6XERO5SPbUrpbMWY=; b=Pt/LKtZW4RgNoQaMZS8+YEFEV5
	fizSmsXXIUCUJDsOM7/VQF7uLoxEJDMDo8NwbooLKCmgl07Ndw4Pr9m1SOXQTOPyarpiaDBTnlHfR
	GJScBmJhjW0SoV198jXpEB6xZU2bgkbCO88Tl/QxQRqMrnD3zR/1QREtwA9GKs2BKuj+1YiSRMvHQ
	DIAsb5azrjB1W7cSjvnCixpgFIWimkZUehdTSgUoyg8LOJXR1Gd3gELNkiGrQo52ARHwY9A7TQ8dc
	AV5yQDuXQpd599AmjUEqzS80RzBr7RN9POHoIKt/BHILOuaG4p9H/5Ib5M76SaIxtsnb2VE05ZJji
	JqqFiALw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNbN-0000000CDLf-2dvo;
	Tue, 06 May 2025 19:05:13 +0000
Date: Tue, 6 May 2025 20:05:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506190513.GQ2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <3qdz7ntes5ufac7ldgfsrnvotk4izalmtdf7opqox5mk3kpxus@gabtxt27uwah>
 <20250506172539.GN2023217@ZenIV>
 <j2tom2y6562wa7r6wjsxwgc25t3uoine45ills367o4y2booxr@3jdyomwkvt6w>
 <20250506175104.GO2023217@ZenIV>
 <4pg5rjsoxzxjgcx2wzucw2wr7uvaxws423stdlv75t2udfkash@jff3ci54z35u>
 <20250506181604.GP2023217@ZenIV>
 <juv6ldm6i53onsz355znrhcivf6bmog25spdkvnlvydhansmao@bpzxifunwl2n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <juv6ldm6i53onsz355znrhcivf6bmog25spdkvnlvydhansmao@bpzxifunwl2n>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 08:34:27PM +0200, Klara Modin wrote:

> > What's more, on the overlayfs side we managed to get to
> >         upper_mnt = clone_private_mount(upperpath);
> >         err = PTR_ERR(upper_mnt);
> >         if (IS_ERR(upper_mnt)) {
> >                 pr_err("failed to clone upperpath\n");
> >                 goto out;
> > so the upper path had been resolved...
> > 
> > OK, let's try to see what clone_private_mount() is unhappy about...
> > Could you try the following on top of -next + braino fix and see
> > what shows up?  Another interesting thing, assuming you can get
> > to shell after overlayfs mount failure, would be /proc/self/mountinfo
> > contents and stat(1) output for upper path of your overlayfs mount...
> 
> It looks like the mount never succeded in the first place? It doesn't
> appear in /proc/self/mountinfo at all:
> 
> 2 2 0:2 / / rw - rootfs rootfs rw
> 24 2 0:22 / /proc rw,relatime - proc proc rw
> 25 2 0:23 / /sys rw,relatime - sysfs sys rw
> 26 2 0:6 / /dev rw,relatime - devtmpfs dev rw,size=481992k,nr_inodes=120498,mode=755
> 27 2 259:1 / /mnt/root-ro ro,relatime - squashfs /dev/nvme0n1 ro,errors=continue
> 
> I get the "kern_mount?" message.

What the... actually, the comment in front of that thing makes no
sense whatsoever - it's *not* something kernel-internal; we get
there for mounts that are absolute roots of some non-anonymous
namespace; kernel-internal ones fail on if (!is_mounted(...))
just above that.

OK, the comment came from db04662e2f4f "fs: allow detached mounts
in clone_private_mount()" and it does point in an interesting
direction - commit message there speaks of overlayfs and use of
descriptors to specify layers.

Not that check_for_nsfs_mounts() (from the same commit) made any sense
there - we don't *care* about anything mounted somewhere in that mount,
since whatever's mounted on top of it does not follow into the copy
(which is what has_locked_children() call is about - in effect, in copy
you see all mountpoints that had been covered in the original)...

Oh, well - so we are seeing an absolute root of some non-anonymous
namespace there.  Or a weird detached mount claimed to belong to
some namespace, anyway.

Let's see if that's the way upperpath comes to be (and get a bit more
information on that weird mount):

diff --git a/fs/namespace.c b/fs/namespace.c
index eb990e9a668a..9b4c4afa2b29 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2480,31 +2480,52 @@ struct vfsmount *clone_private_mount(const struct path *path)
 
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
+			if (old_mnt == old_mnt->mnt_ns->root)
+				pr_err("absolute root");
+			else
+				pr_err("detached, but claimed to be in some ns");
+			if (check_mnt(old_mnt))
+				pr_err("our namespace, at that");
+			else
+				pr_err("some other non-anon namespace");
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

