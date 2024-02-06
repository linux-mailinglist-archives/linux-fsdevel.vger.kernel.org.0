Return-Path: <linux-fsdevel+bounces-10461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3A84B612
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEC228669D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C070113172E;
	Tue,  6 Feb 2024 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvxHEA8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256EF12FF6C;
	Tue,  6 Feb 2024 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225165; cv=none; b=D0RUNnUO0gp/JaAK/UIqwWJomKEJgtfWPSur7usFe/PdMij76WNIgbu9fCFt6dFEqnmhJGaise7RD49qD8dXT8VjRzd/kqY+Xbk+2HoH+10nX53zxpVdS+GnpeUapez75tcyf3yekRXg/w45nc/nP6Ql2i087JVPcsJZoYHKcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225165; c=relaxed/simple;
	bh=gLkNDwNsAdKLU1ngiauV0VNNKQmAGTKBSOrqgV1zYB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkbBVC+6jzHjqR5fVgkkgseK0hSkNgpIUEFVu/1lmHUq57D7a4C9FG2aurPnUrmYqGKtBweRDcVHx36CcMQ35ZzWyDiUpg7kiBLj86rrp4awbtYTlF3olGcy01yCsWV9cbSd54NyoPDTbxaXVER8+BIbvR8wwFwHJtmjCOPtIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvxHEA8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E86C433C7;
	Tue,  6 Feb 2024 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707225164;
	bh=gLkNDwNsAdKLU1ngiauV0VNNKQmAGTKBSOrqgV1zYB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvxHEA8WFxQcnTKLhYJxiB1XBborVcIhIqvoTb6Ey9y+Hq8w3ZjVRKtzCJ4oNsdDv
	 bOOXtSmbXj0OgjvSDNbIpMg4m+xdY6yEdJGmMWHNLKYGLHgJqexd+1CZqwkBTQnXJ/
	 qKniecy6I8IgbEQCaAPIyIz/uzhcjGtBVAClvPu36lRky+qKBqkmZs84zSAJfTY6AE
	 fy7rCLe4BkbwupcVad/a289tLEJcCnYwJCAmPbqn4RV3dPiPOu9pBxMC4/ovQXC3+j
	 GBTFHGA26PrgGCDI0EOyeNq3t74xgdxiNPU6pRbrsyClpisYVRf5+uoIbsp1LS96WQ
	 VYaBTr0iWVhuQ==
Date: Tue, 6 Feb 2024 14:12:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, Zdenek Pytela <zpytela@redhat.com>
Subject: Re: [PATCH] filelock: don't do security checks on nfsd setlease calls
Message-ID: <20240206-gewaschen-bauen-f7932047a1be@brauner>
References: <20240205-bz2248830-v1-1-d0ec0daecba1@kernel.org>
 <170716318935.13976.13465352731929804157@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170716318935.13976.13465352731929804157@noble.neil.brown.name>

On Tue, Feb 06, 2024 at 06:59:49AM +1100, NeilBrown wrote:
> On Mon, 05 Feb 2024, Jeff Layton wrote:
> > Zdenek reported seeing some AVC denials due to nfsd trying to set
> > delegations:
> > 
> >     type=AVC msg=audit(09.11.2023 09:03:46.411:496) : avc:  denied  { lease } for  pid=5127 comm=rpc.nfsd capability=lease  scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:nfsd_t:s0 tclass=capability permissive=0
> > 
> > When setting delegations on behalf of nfsd, we don't want to do all of
> > the normal capabilty and LSM checks. nfsd is a kernel thread and runs
> > with CAP_LEASE set, so the uid checks end up being a no-op in most cases
> > anyway.
> > 
> > Some nfsd functions can end up running in normal process context when
> > tearing down the server. At that point, the CAP_LEASE check can fail and
> > cause the client to not tear down delegations when expected.
> > 
> > Also, the way the per-fs ->setlease handlers work today is a little
> > convoluted. The non-trivial ones are wrappers around generic_setlease,
> > so when they fail due to permission problems they usually they end up
> > doing a little extra work only to determine that they can't set the
> > lease anyway. It would be more efficient to do those checks earlier.
> > 
> > Transplant the permission checking from generic_setlease to
> > vfs_setlease, which will make the permission checking happen earlier on
> > filesystems that have a ->setlease operation. Add a new kernel_setlease
> > function that bypasses these checks, and switch nfsd to use that instead
> > of vfs_setlease.
> > 
> > There is one behavioral change here: prior this patch the
> > setlease_notifier would fire even if the lease attempt was going to fail
> > the security checks later. With this change, it doesn't fire until the
> > caller has passed them. I think this is a desirable change overall. nfsd
> > is the only user of the setlease_notifier and it doesn't benefit from
> > being notified about failed attempts.
> > 
> > Cc: Ondrej Mosnáček <omosnacek@gmail.com>
> > Reported-by: Zdenek Pytela <zpytela@redhat.com>
> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2248830
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> 
> It definitely nice to move all the security and sanity check early.
> This patch allows a minor clean-up in cifs which could possibly be
> included:
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 2a4a4e3a8751..0f142d1ec64f 100644
> 
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct file_lock **lease, void **priv)
>  	struct inode *inode = file_inode(file);
>  	struct cifsFileInfo *cfile = file->private_data;
>  
> -	if (!(S_ISREG(inode->i_mode)))
> -		return -EINVAL;
> -
>  	/* Check if file is oplocked if this is request for new lease */
>  	if (arg == F_UNLCK ||
>  	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
> 
> 
> as ->setlease() is now never called for non-ISREG files.

I've added the following on top. I've made you author and added your
SoB. Please tell me if you have any problems with this:

From d30e52329760873bf0d7984a442cace3a4b5f39d Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Tue, 6 Feb 2024 14:08:57 +0100
Subject: [PATCH] smb: remove redundant check

->setlease() is never called on non-regular files now. So remove the
check from cifs_setlease().

Link: https://lore.kernel.org/r/170716318935.13976.13465352731929804157@noble.neil.brown.name
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifsfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5eee5b00547f..cbcb98d5f2d7 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1094,9 +1094,6 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
-	if (!(S_ISREG(inode->i_mode)))
-		return -EINVAL;
-
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||
-- 
2.43.0


