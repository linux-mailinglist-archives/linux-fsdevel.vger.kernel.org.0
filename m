Return-Path: <linux-fsdevel+bounces-41088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE46A2AB88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291B03A611C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A524236431;
	Thu,  6 Feb 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yaap0JMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417D236420;
	Thu,  6 Feb 2025 14:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852622; cv=none; b=XfJMSoX1/xaR+ouftgRqMI9HKvje7x1wRY1YWfQ9B7c6XvUAE6viUFoCj6TPNM+/LJlDhfHWKU6PTRtqOiDSpzt+l6OlTL5w+Et0w5gPn6PDPOgU4mS6EBCapjNX/wphQric5+TS5e5adWoq8ThTVEEM6zPOZZb9WpkC0DOurWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852622; c=relaxed/simple;
	bh=7AJr7y54UdwEPLF34nyDqrZLW6GboqPkY0gsDWO6Di4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2D9FDuUwBd5yPXq0+kXDaoX3q0mcHnwTQO8FEHC/UF2uz6VTo2NlFXKVGG9DK07RQGu4wng+VdVtPZ6U6k8X4ux/+WAw1tnquTirG/b5aWo0MWi4A0lqwsAgk4YETCJkmRg8Y/YQUgG317Tr493WH3ILNfQaiAEaZ92/OQmRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yaap0JMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD787C4CEDD;
	Thu,  6 Feb 2025 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738852621;
	bh=7AJr7y54UdwEPLF34nyDqrZLW6GboqPkY0gsDWO6Di4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yaap0JMxBVh/eIte66ar9TLFP6tXbELWJEbk7EvrKwDZtOwhLMjwQbr8FcPr1cS/V
	 e8b/kfoyOiZMELWXQHrMvT0EBF/6Ao3w/uKDoq56oJOeJ8+6ax2gpxSfNk7VOkKPPQ
	 Zs0I39Dx0KwWAIiAIECXY6gAnFPn2w3qmbT/q3NPPRBopncWy15lID+ThHWHrYjh3e
	 hIfEpJBGIUy80IRE1Zo4/T/AFP/oDVpc7KGbiwFUr9SdQ0gs6y41PbiTrGQnxrJz0A
	 Gorc93VXw9Fn5MOqVrLpPSO82b/tWBlp6/ZpigGcUzQjGm/NiSx5/GBh0ckPe19O83
	 83PhSZUUMTPSQ==
Date: Thu, 6 Feb 2025 15:36:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19 v7?] RFC: Allow concurrent and async changes in a
 directory
Message-ID: <20250206-pocken-entzwei-bd310c8d61b3@brauner>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>

On Thu, Feb 06, 2025 at 04:42:37PM +1100, NeilBrown wrote:
> This is my latest attempt at removing the requirement for an exclusive
> lock on a directory which performing updates in this.  This version,
> inspired by Dave Chinner, goes a step further and allow async updates.
> 
> The inode operation still requires the inode lock, at least a shared
> lock, but may return -EINPROGRES and then continue asynchronously
> without needing any ongoing lock on the directory.
> 
> An exclusive lock on the dentry is held across the entire operation.
> 
> This change requires various extra checks.  rmdir must ensure there is
> no async creation still happening.  rename between directories must
> ensure non of the relevant ancestors are undergoing async rename.  There
> may be or checks that I need to consider - mounting?

Mounting takes an exclusive lock on the target inode in do_lock_mount()
and finish_automount(). As long as dont_mount() can't happen
asynchronously in vfs_rmdir(), vfs_unlink() or vfs_rename() it should be
fine.

> 
> One other important change since my previous posting is that I've
> dropped the idea of taking a separate exclusive lock on the directory
> when the fs doesn't support shared locking.  This cannot work as it
> doeesn't prevent lookups and filesystems don't expect a lookup while
> they are changing a directory.  So instead we need to choose between
> exclusive or shared for the inode on a case-by-case basis.

Which is possibly fine if we do it similar to what I suggested in the
series. As it stands with the separate methods it's a no-go for me. But
that's a solvable problem, I think.

> To make this choice we divide all ops into four groups: create, remove,
> rename, open/create.  If an inode has no operations in the group that
> require an exclusive lock, then a flag is set on the inode so that
> various code knows that a shared lock is sufficient.  If the flag is not
> set, an exclusive lock is obtained.
> 
> I've also added rename handling and converted NFS to use all _async ops.
> 
> The motivation for this comes from the general increase in scale of
> systems.  We can support very large directories and many-core systems
> and applications that choose to use large directories can hit
> unnecessary contention.
> 
> NFS can easily hit this when used over a high-latency link.
> Lustre already has code to allow concurrent directory updates in the
> back-end filesystem (ldiskfs - a slightly modified ext4).
> Lustre developers believe this would also benefit the client-side
> filesystem with large core counts.
> 
> The idea behind the async support is to eventually connect this to
> io_uring so that one process can launch several concurrent directory
> operations.  I have not looked deeply into io_uring and cannot be
> certain that the interface I've provided will be able to be used.  I
> would welcome any advice on that matter, though I hope to find time to
> explore myself.  For now if any _async op returns -EINPROGRESS we simply
> wait for the callback to indicate completion.
> 
> Test status:  only light testing.  It doesn't easily blow up, but lockdep
> complains that repeated calls to d_update_wait() are bad, even though
> it has balanced acquire and release calls. Weird?
> 
> Thanks,
> NeilBrown
> 
>  [PATCH 01/19] VFS: introduce vfs_mkdir_return()
>  [PATCH 02/19] VFS: use global wait-queue table for d_alloc_parallel()
>  [PATCH 03/19] VFS: use d_alloc_parallel() in lookup_one_qstr_excl()
>  [PATCH 04/19] VFS: change kern_path_locked() and
>  [PATCH 05/19] VFS: add common error checks to lookup_one_qstr()
>  [PATCH 06/19] VFS: repack DENTRY_ flags.
>  [PATCH 07/19] VFS: repack LOOKUP_ bit flags.
>  [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
>  [PATCH 09/19] VFS: add _async versions of the various directory
>  [PATCH 10/19] VFS: introduce inode flags to report locking needs for
>  [PATCH 11/19] VFS: Add ability to exclusively lock a dentry and use
>  [PATCH 12/19] VFS: enhance d_splice_alias to accommodate shared-lock
>  [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races with
>  [PATCH 14/19] VFS: Ensure no async updates happening in directory
>  [PATCH 15/19] VFS: Change lookup_and_lock() to use shared lock when
>  [PATCH 16/19] VFS: add lookup_and_lock_rename()
>  [PATCH 17/19] nfsd: use lookup_and_lock_one() and
>  [PATCH 18/19] nfs: change mkdir inode_operation to mkdir_async
>  [PATCH 19/19] nfs: switch to _async for all directory ops.

