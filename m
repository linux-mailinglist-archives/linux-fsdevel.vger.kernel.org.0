Return-Path: <linux-fsdevel+bounces-41092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AAA2ACE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FC1161BC1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 15:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B8B22F161;
	Thu,  6 Feb 2025 15:44:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4E228CB7;
	Thu,  6 Feb 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.104.24.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738856657; cv=none; b=qwP+uyvHaqg9Y80ywaIEPoXmPI7ppmOEeZ9fx5Ni13ML9gO8E9E0y0ehI81v3Ipb0NmxzaS/kmZCxLTDM2Auq0jxJ0mtOhrBEtJ4Qx8An+0WwR64ID8ZUKovIq5nQyLKy4V8gs/EnmiTNGXqpWwGdh0WvK1AyXj40eNvcHLs5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738856657; c=relaxed/simple;
	bh=e9J0ABv+nplFGc8ZnorETN2itYO3cmolAlVJ2yap9/A=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=gqWO1NO+1jomo44Rj3S7ueQCFpqSae8y8+EoaIQUQQLfgWbwYpo4Ll0e2hXaxcO3LV4bZ5bWaSOe26yUKP6CZr0mWdVmr+3xdWH0amwWWfQmb0pYOjYHvrEjfoTflbVU7HpukERz6L1TIhHxbJzbXTwkDaCiE6ZCmbUKjjyWAGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org; spf=pass smtp.mailfrom=stoffel.org; arc=none smtp.client-ip=172.104.24.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stoffel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stoffel.org
Received: from quad.stoffel.org (syn-097-095-183-072.res.spectrum.com [97.95.183.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.stoffel.org (Postfix) with ESMTPSA id 9782421998;
	Thu,  6 Feb 2025 10:36:07 -0500 (EST)
Received: by quad.stoffel.org (Postfix, from userid 1000)
	id E1004A0DB1; Thu,  6 Feb 2025 10:36:06 -0500 (EST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26532.55014.864941.551897@quad.stoffel.home>
Date: Thu, 6 Feb 2025 10:36:06 -0500
From: "John Stoffel" <john@stoffel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jan Kara <jack@suse.cz>,
    Linus Torvalds <torvalds@linux-foundation.org>,
    Jeff Layton <jlayton@kernel.org>,
    Dave Chinner <david@fromorbit.com>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
X-Clacks-Overhead: GNU Terry Pratchett
Subject: Re: [PATCH 00/19 v7?] RFC: Allow concurrent and async changes in a directory
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
X-Mailer: VM 8.3.x under 28.2 (x86_64-pc-linux-gnu)

>>>>> "NeilBrown" == NeilBrown  <neilb@suse.de> writes:

> This is my latest attempt at removing the requirement for an exclusive
> lock on a directory which performing updates in this.  This version,
> inspired by Dave Chinner, goes a step further and allow async updates.

This initial sentence reads poorly to me.  I think you maybe are
trying to say:

  This is my latest attempt to removing the requirement for writers to
  have an exclusive lock on a directory when performing updates on
  entries in that directory.  This allows for parallel updates by
  multiple processes (connections? hosts? clients?) to improve scaling
  of large filesystems. 

I get what you're trying to do here, and I applaud it!  I just
struggled over the intro here.  


> The inode operation still requires the inode lock, at least a shared
> lock, but may return -EINPROGRES and then continue asynchronously
> without needing any ongoing lock on the directory.

> An exclusive lock on the dentry is held across the entire operation.

> This change requires various extra checks.  rmdir must ensure there is
> no async creation still happening.  rename between directories must
> ensure non of the relevant ancestors are undergoing async rename.  There
> may be or checks that I need to consider - mounting?

> One other important change since my previous posting is that I've
> dropped the idea of taking a separate exclusive lock on the directory
> when the fs doesn't support shared locking.  This cannot work as it
> doeesn't prevent lookups and filesystems don't expect a lookup while
> they are changing a directory.  So instead we need to choose between
> exclusive or shared for the inode on a case-by-case basis.

> To make this choice we divide all ops into four groups: create, remove,
> rename, open/create.  If an inode has no operations in the group that
> require an exclusive lock, then a flag is set on the inode so that
> various code knows that a shared lock is sufficient.  If the flag is not
> set, an exclusive lock is obtained.

> I've also added rename handling and converted NFS to use all _async ops.

> The motivation for this comes from the general increase in scale of
> systems.  We can support very large directories and many-core systems
> and applications that choose to use large directories can hit
> unnecessary contention.

> NFS can easily hit this when used over a high-latency link.
> Lustre already has code to allow concurrent directory updates in the
> back-end filesystem (ldiskfs - a slightly modified ext4).
> Lustre developers believe this would also benefit the client-side
> filesystem with large core counts.

> The idea behind the async support is to eventually connect this to
> io_uring so that one process can launch several concurrent directory
> operations.  I have not looked deeply into io_uring and cannot be
> certain that the interface I've provided will be able to be used.  I
> would welcome any advice on that matter, though I hope to find time to
> explore myself.  For now if any _async op returns -EINPROGRESS we simply
> wait for the callback to indicate completion.

> Test status:  only light testing.  It doesn't easily blow up, but lockdep
> complains that repeated calls to d_update_wait() are bad, even though
> it has balanced acquire and release calls. Weird?

> Thanks,
> NeilBrown

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


