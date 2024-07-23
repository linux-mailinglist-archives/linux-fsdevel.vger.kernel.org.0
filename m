Return-Path: <linux-fsdevel+bounces-24144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63593A3D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA741C227B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB64157499;
	Tue, 23 Jul 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZI2pMRUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865FF157485;
	Tue, 23 Jul 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749206; cv=none; b=Xowl3gmUJyHXxYdB/oUMN2pN4bSrBKJXTM1yLPyYrsXSlmlfpjY65xPVcNOhVQUgxipPf+XVfg1LVlEjEq4o0xfR48xO+ywp0YT0MfodQ7e/ECOJqkJ0ItOYu2jZElpodu/Bu+iqlVvIfYF/0jO3awJU2QJuWWnYxle/WCZDVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749206; c=relaxed/simple;
	bh=pdNtJGZOwdwwwqNEnYAKscd6b0OBbgp4ThhTP20dDB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3X7QLU3Cuoqpve3+1yOhHPa+Su26BCQz8FkeWm6oKWIiutcUqGLV9n4AJktuKVZKST/7RJ1nQzYWW1EQMYMBLF9wyQL5XRdyjGbONrHn/oHHduGSbcnxS4mAztRVuXXw2EyRYYIY6Zk2GU4d+XVUGHVZBvqR60B6r+fDI6NPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZI2pMRUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B804C4AF09;
	Tue, 23 Jul 2024 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749206;
	bh=pdNtJGZOwdwwwqNEnYAKscd6b0OBbgp4ThhTP20dDB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZI2pMRUdwA+zyoldntdMG/Q+22peaYEb1xHj/FTwbOYtN+hPclD84DmDewKnAR6Me
	 y1IC3r8TN2GlBfOr3KNfqAw2n0BGZMgSPTXUz9sJqXF7Q+dEQgj0YMPn83wyWx05qF
	 HoSk9wzWreurnU2i2Pz7ogV/6PwhE6rjdX1fseXQ1ryhgNCoU2dP1D7gI7jwMLx9lC
	 K4agbpg5yFH2oXettcjO/kfD40jrRoPR5mvsb6yvnvm5LSzLiALWlpPonmr6uETWIg
	 Gf5HUwk3EUWL1S7DyMj2BOYfkGWUSt1l/Btv7HJt8eyhnurWY4rOywytkSkRRCF4Dv
	 NokieRmfKx3MQ==
Date: Tue, 23 Jul 2024 17:40:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Gao Xiang <xiang@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Fix potential circular locking through setxattr()
 and removexattr()
Message-ID: <20240723-fracksausen-absehbar-033713f1e9b5@brauner>
References: <20240723104533.mznf3svde36w6izp@quack3>
 <2136178.1721725194@warthog.procyon.org.uk>
 <2147168.1721743066@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2147168.1721743066@warthog.procyon.org.uk>

On Tue, Jul 23, 2024 at 02:57:46PM GMT, David Howells wrote:
> Jan Kara <jack@suse.cz> wrote:
> 
> > Well, it seems like you are trying to get rid of the dependency
> > sb_writers->mmap_sem. But there are other places where this dependency is
> > created, in particular write(2) path is a place where it would be very
> > difficult to get rid of it (you take sb_writers, then do all the work
> > preparing the write and then you copy user data into page cache which
> > may require mmap_sem).
> >
> > ...
> > 
> > This is the problematic step - from quite deep in the locking chain holding
> > invalidate_lock and having PG_Writeback set you suddently jump to very outer
> > locking context grabbing sb_writers. Now AFAICT this is not a real deadlock
> > problem because the locks are actually on different filesystems, just
> > lockdep isn't able to see this. So I don't think you will get rid of these
> > lockdep splats unless you somehow manage to convey to lockdep that there's
> > the "upper" fs (AFS in this case) and the "lower" fs (the one behind
> > cachefiles) and their locks are different.
> 
> I'm not sure you're correct about that.  If you look at the lockdep splat:
> 
> >  -> #2 (sb_writers#14){.+.+}-{0:0}:
> 
> The sb_writers lock is "personalised" to the filesystem type (the "#14"
> annotation) which is set here:
> 
> 	for (i = 0; i < SB_FREEZE_LEVELS; i++) {
> 		if (__percpu_init_rwsem(&s->s_writers.rw_sem[i],
> 					sb_writers_name[i],
> 					&type->s_writers_key[i]))  <----
> 			goto fail;
> 	}
> 
> in fs/super.c.
> 
> I think the problem is (1) that on one side, you've got, say, sys_setxattr()
> taking an sb_writers lock and then accessing a userspace buffer, which (a) may
> take mm->mmap_lock and vma->vm_lock and (b) may cause reading or writeback
> from the netfs-based filesystem via an mmapped xattr name buffer].
> 
> Then (2) on the other side, you have a read or a write to the network
> filesystem through netfslib which may invoke the cache, which may require
> cachefiles to check the xattr on the cache file and maybe set/remove it -
> which requires the sb_writers lock on the cache filesystem.
> 
> So if ->read_folio(), ->readahead() or ->writepages() can ever be called with
> mm->mmap_lock or vma->vm_lock held, netfslib may call down to cachefiles and
> ultimately, it should[*] then take the sb_writers lock on the backing
> filesystem to perform xattr manipulation.
> 
> [*] I say "should" because at the moment cachefiles calls vfs_set/removexattr
>     functions which *don't* take this lock (which is a bug).  Is this an error
>     on the part of vfs_set/removexattr()?  Should they take this lock
>     analogously with vfs_truncate() and vfs_iocb_iter_write()?

It's not bug per se. We have a few vfs_*() functions that don't take
write access iirc. The reason often is that e.g., callers like overlayfs
call vfs_*() helpers in various locations where write access to the
underlying and overlayfs layer is taken some time before calling into
vs_*() helper (see ovl_do_setxattr() during various copy up operation
iirc.).

Fwiw, I suspect that e.g., ecryptfs doesn't claim write access at all to
the underlying filesystem - not just xattrs.

(What would probably be good is if we could add lockdep asserts so that
we get warnings about missing locks taken.)

> 
> However, as it doesn't it manages to construct a locking chain via the
> mapping.invalidate_lock, the afs vnode->validate_lock and something in execve
> that I don't exactly follow.
> 
> 
> I wonder if this is might be deadlockable by a multithreaded process (ie. so
> they share the mm locks) where one thread is writing to a cached file whilst
> another thread is trying to set/remove the xattr on that file.
> 
> David
> 

