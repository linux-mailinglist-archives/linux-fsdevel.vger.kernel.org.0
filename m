Return-Path: <linux-fsdevel+bounces-72950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3FD06654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 23:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E10303A0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 22:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E269A3242C8;
	Thu,  8 Jan 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6alr+YA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nk7GSvtb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6alr+YA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nk7GSvtb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BA2D7810
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767909914; cv=none; b=GvuMQJhtMveGm08PfKjodW7/ZmyUUcgnj5jkqbLlhA8G6IYR+ovsfYX1cINDRTJwi2xkeYri62I7LVGmxhR5RzrF0s9ExeGu8ktOXdLQy+kI6BeZJPSh7JDarniTVVKeKl3s6bFSPSRkwoa/qy4hTqaXXIf8smoK0jO8mEGY1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767909914; c=relaxed/simple;
	bh=JpMj0Enyqo3N1wgHhyPEb0vCI3JGY9jvwTrlqlr4cbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N80JUCz+JxKAmnWw25tQ8ccgPyTfQeztnQ3azP3VRk8rZ6c33SzTwisvn5QpDCknWH+ewEynyTR6zLD1hsrxd5bhpc+mvdFkmSJwxI8VAsmPx1mrPd3kxq/ARGMsgQAvU4FI6s8w4Oey9w/d+FH+w8P1Libovaz+T5BJjael/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6alr+YA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nk7GSvtb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6alr+YA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nk7GSvtb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1951A34711;
	Thu,  8 Jan 2026 22:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767909911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzODhxSWiuT5h/IEW/FzPUqkh8JX2HC/lbTmyoiAA1I=;
	b=G6alr+YAmQ03PSz+TwsylkRWEVGYxG8DObcZQpY8sAxSk9tOkj97qeI3qvYMNbujcVGBgn
	/qat6uVZE9ACP22gLX/VXejij7KVjXwU3aEUFVna9C+dFsG/wVP0HIrj6/8NhTA+7ncDhc
	hVHPIosq3v4NMqoqWY323hWFaV5QkxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767909911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzODhxSWiuT5h/IEW/FzPUqkh8JX2HC/lbTmyoiAA1I=;
	b=Nk7GSvtb7AF8yTFlkGGsCrT9MvGpEzdbPuPv3I199CUVMsRbSFQtScomJDlzsinTAko4VU
	ErdD5XabX0pOYyDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767909911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzODhxSWiuT5h/IEW/FzPUqkh8JX2HC/lbTmyoiAA1I=;
	b=G6alr+YAmQ03PSz+TwsylkRWEVGYxG8DObcZQpY8sAxSk9tOkj97qeI3qvYMNbujcVGBgn
	/qat6uVZE9ACP22gLX/VXejij7KVjXwU3aEUFVna9C+dFsG/wVP0HIrj6/8NhTA+7ncDhc
	hVHPIosq3v4NMqoqWY323hWFaV5QkxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767909911;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzODhxSWiuT5h/IEW/FzPUqkh8JX2HC/lbTmyoiAA1I=;
	b=Nk7GSvtb7AF8yTFlkGGsCrT9MvGpEzdbPuPv3I199CUVMsRbSFQtScomJDlzsinTAko4VU
	ErdD5XabX0pOYyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8053EA63;
	Thu,  8 Jan 2026 22:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7RCMORYqYGlffwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 08 Jan 2026 22:05:10 +0000
Date: Thu, 8 Jan 2026 23:05:05 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 3/4] btrfs: use may_delete_dentry() in
 btrfs_ioctl_snap_destroy()
Message-ID: <20260108220505.GP21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1767801889.git.fdmanana@suse.com>
 <46b13dc5c957deb72a7f085916757a20878a8e73.1767801889.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46b13dc5c957deb72a7f085916757a20878a8e73.1767801889.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Thu, Jan 08, 2026 at 01:35:33PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is no longer the need to use btrfs_may_delete(), which was a copy
> of the VFS private function may_delete(), since now that functionality
> is exported by the VFS as a function named may_delete_dentry(). In fact
> our local copy of may_delete() lacks an update that happened to that
> function which is point number 7 in that function's comment:
> 
>   "7. If the victim has an unknown uid or gid we can't change the inode."
> 
> which corresponds to this code:
> 
> 	/* Inode writeback is not safe when the uid or gid are invalid. */
> 	if (!vfsuid_valid(i_uid_into_vfsuid(idmap, inode)) ||
> 	    !vfsgid_valid(i_gid_into_vfsgid(idmap, inode)))
> 		return -EOVERFLOW;
> 
> As long as we keep a separate copy, duplicating code, we are also prone
> to updates to the VFS being missed in our local copy.
> 
> So change btrfs_ioctl_snap_destroy() to use the VFS function and remove
> btrfs_may_delete().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/ioctl.c | 58 +-----------------------------------------------
>  1 file changed, 1 insertion(+), 57 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index d9e7dd317670..0cb3cd3d05a5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -815,62 +815,6 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
>  	return ret;
>  }
>  
> -/*  copy of may_delete in fs/namei.c()
> - *	Check whether we can remove a link victim from directory dir, check
> - *  whether the type of victim is right.
> - *  1. We can't do it if dir is read-only (done in permission())
> - *  2. We should have write and exec permissions on dir
> - *  3. We can't remove anything from append-only dir
> - *  4. We can't do anything with immutable dir (done in permission())
> - *  5. If the sticky bit on dir is set we should either
> - *	a. be owner of dir, or
> - *	b. be owner of victim, or
> - *	c. have CAP_FOWNER capability
> - *  6. If the victim is append-only or immutable we can't do anything with
> - *     links pointing to it.
> - *  7. If we were asked to remove a directory and victim isn't one - ENOTDIR.
> - *  8. If we were asked to remove a non-directory and victim isn't one - EISDIR.
> - *  9. We can't remove a root or mountpoint.
> - * 10. We don't allow removal of NFS sillyrenamed files; it's handled by
> - *     nfs_async_unlink().
> - */
> -
> -static int btrfs_may_delete(struct mnt_idmap *idmap,
> -			    struct inode *dir, struct dentry *victim, int isdir)
> -{
> -	int ret;

There are some differences in VFS may_delete that I don't know if are
significant, they seem to be releated to stacked filesystems.

For example the associated inode of the victim dentry is obtained as
d_backing_inode() vs our simple d_inode().

> -
> -	if (d_really_is_negative(victim))

VFS does d_is_negative() which does not check for NULL pointer but some
other internal state.

> -		return -ENOENT;
> -
> -	/* The @victim is not inside @dir. */
> -	if (d_inode(victim->d_parent) != dir)
> -		return -EINVAL;

We handle that properly, while VFS does BUG_ON, so this can be fixed
separeately in the VFS version.

There are no changes in the rest of the function (other than the
different way how inode is obtained).

The original commit 4260f7c7516f4c ("Btrfs: allow subvol deletion by
unprivileged user with -o user_subvol_rm_allowed") adding this helper
says something about adding the write and exec checks and size checks
but I don't see what it's referring to, neither in the current nor in
the old code.

> -	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
> -
> -	ret = inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
> -	if (ret)
> -		return ret;
> -	if (IS_APPEND(dir))
> -		return -EPERM;
> -	if (check_sticky(idmap, dir, d_inode(victim)) ||
> -	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
> -	    IS_SWAPFILE(d_inode(victim)))
> -		return -EPERM;
> -	if (isdir) {
> -		if (!d_is_dir(victim))
> -			return -ENOTDIR;
> -		if (IS_ROOT(victim))
> -			return -EBUSY;
> -	} else if (d_is_dir(victim))
> -		return -EISDIR;
> -	if (IS_DEADDIR(dir))
> -		return -ENOENT;
> -	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
> -		return -EBUSY;
> -	return 0;
> -}

