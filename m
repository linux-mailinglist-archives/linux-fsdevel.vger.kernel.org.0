Return-Path: <linux-fsdevel+bounces-51286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE76AD52D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51261BC550A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45352C325D;
	Wed, 11 Jun 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A02pY1+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395242C2AD8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638992; cv=none; b=MyEAN671nmxILY1OReEy6Og6qPmNc9Vw1jbutG8A2ng5Rgfpm9x3YJ1Kkw6JDtJImb3IESXKguN9TER+d+AlhiUE515TSTmtUZEboTPpOzK1D/U0vhyuJJ7rzX55FR+IkqK9Ki6ivn89MFskGRv6F1FaKn0C0YtOqhoP/guJTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638992; c=relaxed/simple;
	bh=V/3ucQd8Zb4d+XOrZM+YK8ippnwzodOaZRQLhQJIrmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QT484YLo6/bLKV0n6F81CftrHM4IDZCaWJjbrMA65mMw43dcmKEzaXkQ1FCcMw2q5nnTfh47GKwz0OuBZ0qrcIzoUEV84L6W0e5QHvv0M2SpEXLIE6TQIoXMkl6eCmAhjjNHZkDcZc/R9GGtccYspLIyMVfMHHp6u54bTsG22Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A02pY1+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F40CC4CEEE;
	Wed, 11 Jun 2025 10:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638991;
	bh=V/3ucQd8Zb4d+XOrZM+YK8ippnwzodOaZRQLhQJIrmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A02pY1+ntF36Ya0FSJhgTu+vt19uq9SXY4abfJEHkjMzvgOw+37WWGKfkVHonPzpt
	 9b5Leucxdeq2k8ev80q07l+JhYPUFSPv9ApOiDQXyeC+Qyd7pWyyvStKkXRzHy/Fws
	 4gfS+xWethglGRXTb3gs/pVfziuYtPECx987QYbRLzAIfhqs+iyK6KMlBtcX3c4J+C
	 bnqo63fFLvdBBwwfrYbYgXoIbZvg0VIKlZ0XtKTmXGHhcSeTSr38AzZH7DZmiC+ocx
	 0Unlrhmgp0imSQXygNa/4YesKje2Czn7uTIl19cyEuW4k1D2yAkxDvQKS4NIRlhl+S
	 d11O1+/HhoZTQ==
Date: Wed, 11 Jun 2025 12:49:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 08/26] don't set MNT_LOCKED on parentless mounts
Message-ID: <20250611-flossen-abblitzen-ea2cb9cf4b9d@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-8-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:30AM +0100, Al Viro wrote:
> Originally MNT_LOCKED meant only one thing - "don't let this mount to
> be peeled off its parent, we don't want to have its mountpoint exposed".
> Accordingly, it had only been set on mounts that *do* have a parent.
> Later it got overloaded with another use - setting it on the absolute
> root had given free protection against umount(2) of absolute root
> (was possible to trigger, oopsed).  Not a bad trick, but it ended
> up costing more than it bought us.  Unfortunately, the cost included
> both hard-to-reason-about logics and a subtle race between
> mount -o remount,ro and mount --[r]bind - lockless &= ~MNT_LOCKED in
> the end of __do_loopback() could race with sb_prepare_remount_readonly()
> setting and clearing MNT_HOLD_WRITE (under mount_lock, as it should
> be).  The race wouldn't be much of a problem (there are other ways to
> deal with it), but the subtlety is.
> 
> Turns out that nobody except umount(2) had ever made use of having
> MNT_LOCKED set on absolute root.  So let's give up on that trick,
> clever as it had been, add an explicit check in do_umount() and
> return to using MNT_LOCKED only for mounts that have a parent.
> 
> It means that
> 	* clone_mnt() no longer copies MNT_LOCKED
> 	* copy_tree() sets it on submounts if their counterparts had
> been marked such, and does that right next to attach_mnt() in there,
> in the same mount_lock scope.
> 	* __do_loopback() no longer needs to strip MNT_LOCKED off the
> root of subtree it's about to return; no store, no race.
> 	* init_mount_tree() doesn't bother setting MNT_LOCKED on absolute
> root.
> 	* lock_mnt_tree() does not set MNT_LOCKED on the subtree's root;
> accordingly, its caller (loop in attach_recursive_mnt()) does not need to
> bother stripping that MNT_LOCKED on root.  Note that lock_mnt_tree() setting
> MNT_LOCKED on submounts happens in the same mount_lock scope as __attach_mnt()
> (from commit_tree()) that makes them reachable.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/namespace.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e783eb801060..d6c81eab6a11 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1349,7 +1349,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
>  	}
>  
>  	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
> -	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
> +	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
>  
>  	atomic_inc(&sb->s_active);
>  	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
> @@ -2024,6 +2024,9 @@ static int do_umount(struct mount *mnt, int flags)
>  	if (mnt->mnt.mnt_flags & MNT_LOCKED)
>  		goto out;
>  

This deserves a comment imho.

> +	if (!mnt_has_parent(mnt))
> +		goto out;

