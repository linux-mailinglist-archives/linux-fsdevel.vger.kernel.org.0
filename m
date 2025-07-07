Return-Path: <linux-fsdevel+bounces-54080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAACAFB13A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E1B7A4D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2521CC4E;
	Mon,  7 Jul 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZB9MQr0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E931C84D6;
	Mon,  7 Jul 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751884213; cv=none; b=oq5EpKUZ+g0qJeM2v5VTAdxF9wcrRlCCI8unPmNjuyWKBw5dQ/ExaQnaEwNYqkJpS8U47sliEZ2MIto/SPToUdEEdk4ZYDQeEHz5tEVM7zDOGXmdkTIPnIAx4Oywpo5Z8Iwyldnv8IsZYCvPqQPyHT4Pdv1jK6dCJPth12n78/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751884213; c=relaxed/simple;
	bh=B0m1cnX7soEB3Tc5DaTGtWLvW27XUVBd3WdqLit+2/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFDyE60KIY6UkoJbf1n/P0WmC71Sn+YvMaDY5F8RrWeBU6n3ZsDH57Z7J64lobRKGeeoQw6GtHfo8haGqeH9crr1c9dFvRla9o2HqqELHSw9sfQFJT3+FtWT+bODeNf9EixLNb9CTiWExOhJQW0k2FI7FpmlxzGMec6YdtpG8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZB9MQr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D1FC4CEE3;
	Mon,  7 Jul 2025 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751884213;
	bh=B0m1cnX7soEB3Tc5DaTGtWLvW27XUVBd3WdqLit+2/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZB9MQr0S7HbxqgwUglP2mwIk9teBS3l+aywp4pf6J9KTs0BNrauxE/OtI4s78Q2u
	 WlOTrivPjHZ7v3svHvbCy8+ghaGYcCcdEXaGyMVOGaiSuGbTx7RpJRVElwKrwXh/3Q
	 3zp6R6T3ZMIAGe/OF+AoBl9fIq3KofFGeNseiUYuxz5HzH0zlx6d9oZNXllF9ofH7T
	 8dakFY/umg67nLyOvF3939E97lqAdhPS686qS1k+SaVyyGGQhEur0cJ89X/qE7MUYw
	 60j7ahgtEYuiY+VldD+Wd7ML6gxIbBgf8U3yjVKG0s68tBX382m7iJAU7IDdxHoGt9
	 /WFue3+pMVfww==
Date: Mon, 7 Jul 2025 12:30:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, NeilBrown <neil@brown.name>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Xu <jeffxu@google.com>, Ben Scarlato <akhna@google.com>, 
	Paul Moore <paul@paul-moore.com>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Song Liu <song@kernel.org>, Tingmao Wang <m@maowtm.org>
Subject: Re: [RFC PATCH v1 1/2] landlock: Fix handling of disconnected
 directories
Message-ID: <20250707-gerede-deckung-ca71581c3322@brauner>
References: <20250701183812.3201231-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701183812.3201231-1-mic@digikod.net>

On Tue, Jul 01, 2025 at 08:38:07PM +0200, Mickaël Salaün wrote:
> We can get disconnected files or directories when they are visible and
> opened from a bind mount, before being renamed/moved from the source of
> the bind mount in a way that makes them inaccessible from the mount
> point (i.e. out of scope).
> 
> Until now, access rights tied to files or directories opened through a
> disconnected directory were collected by walking the related hierarchy
> down to the root of this filesystem because the mount point couldn't be
> found.  This could lead to inconsistent access results, and
> hard-to-debug renames, especially because such paths cannot be printed.
> 
> For a sandboxed task to create a disconnected directory, it needs to
> have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
> the underlying source of the bind mount, and read access to the related
> mount point.  Because a sandboxed task cannot get more access than those
> defined by its Landlock domain, this could only lead to inconsistent
> access rights because of missing those that should be inherited from the
> mount point hierarchy and inheriting from the hierarchy of the mounted
> filesystem instead.
> 
> Landlock now handles files/directories opened from disconnected
> directories like the mount point these disconnected directories were
> opened from.  This gives the guarantee that access rights on a
> file/directory cannot be more than those at open time.  The rationale is
> that disconnected hierarchies might not be visible nor accessible to a
> sandboxed task, and relying on the collected access rights from them
> could introduce unexpected results, especially for rename actions
> because of the access right comparison between the source and the
> destination (see LANDLOCK_ACCESS_FS_REFER).  This new behavior is much
> less surprising to users and safer from an access point of view.
> 
> Unlike follow_dotdot(), we don't need to check for each directory if it
> is part of the mount's root, but instead this is only checked when we
> reached a root dentry (not a mount point), or when the access
> request is about to be allowed.  This limits the number of calls to
> is_subdir() which walks down the hierarchy (again).  This also avoids
> checking path connection at the beginning of the walk for each mount
> point, which would be racy.
> 
> Make path_connected() public to stay consistent with the VFS.  This
> helper is used when we are about to allowed an access.
> 
> This change increases the stack size with two Landlock layer masks
> backups that are needed to reset the collected access rights to the
> latest mount point.
> 
> Because opened files have their access rights stored in the related file
> security properties, their is no impact for disconnected or unlinked
> files.
> 
> A following commit will document handling of disconnected files and
> directories.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Song Liu <song@kernel.org>
> Reported-by: Tingmao Wang <m@maowtm.org>
> Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> This replaces this patch:
> landlock: Remove warning in collect_domain_accesses()
> https://lore.kernel.org/r/20250618134734.1673254-1-mic@digikod.net
> 
> I'll probably split this commit into two to ease backport (same for
> tests).
> 
> This patch series applies on top of my next branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
> 
> TODO: Add documentation
> 
> TODO: Add Landlock erratum
> ---
>  fs/namei.c             |   2 +-
>  include/linux/fs.h     |   1 +
>  security/landlock/fs.c | 121 +++++++++++++++++++++++++++++++++++------
>  3 files changed, 105 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..7853a876fc1c 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -716,7 +716,7 @@ static bool nd_alloc_stack(struct nameidata *nd)
>   * Rename can sometimes move a file or directory outside of a bind
>   * mount, path_connected allows those cases to be detected.
>   */
> -static bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
> +bool path_connected(struct vfsmount *mnt, struct dentry *dentry)
>  {
>  	struct super_block *sb = mnt->mnt_sb;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4ec77da65f14..3c0e324a9272 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3252,6 +3252,7 @@ extern struct file * open_exec(const char *);
>  /* fs/dcache.c -- generic fs support functions */
>  extern bool is_subdir(struct dentry *, struct dentry *);
>  extern bool path_is_under(const struct path *, const struct path *);
> +extern bool path_connected(struct vfsmount *mnt, struct dentry *dentry);

Drop the "extern" please. We generally don't do that anymore for new
additions. Otherwise,

Acked-by: Christian Brauner <brauner@kernel.org>

