Return-Path: <linux-fsdevel+bounces-51612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B753AD9590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EA81BC3E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256A23F429;
	Fri, 13 Jun 2025 19:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZerIyK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE12A38DD1;
	Fri, 13 Jun 2025 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843149; cv=none; b=fB6VbH+RajXX042Ub4N67Uu3GHxmPaJ/+XsvhJYw9UQ6/gyx7YoFSu7NhSwcxOnVN9++U3H4p2A+Lvsn9RnyAV0n8ujZmacbOMrfq6G9pErMbqqcsc6lcXWVDrydjqcWpyX2osCv3ri+CZYp6paDvq9rPWGtvPU/vncmU5XV9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843149; c=relaxed/simple;
	bh=wCIFiasx5TiBVQfMuc1lC5s7UlatRp3ZA6rjHwuBunY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2w1J2I/FC1gxSydFOWC2M7bF8YZu8berGk2Ln/0m8XBPsXxvP0du1Mk+KQ/ZMMNQvf83/weaJ9H3T0DxWgo37d3ZTkS/z9jhUdjTYkVo9bewSDdl0uRHDA2rhJAcjE490YDSePCmtogdOpUFYixc8TGkeSTDpI8IsNjBDuPOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZerIyK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07831C4CEE3;
	Fri, 13 Jun 2025 19:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749843149;
	bh=wCIFiasx5TiBVQfMuc1lC5s7UlatRp3ZA6rjHwuBunY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uZerIyK+aJPgsnOwm9qMys8QpUC9h3RS/nRLY3do0uIgEydGWcSCvXcNcegDyDNpo
	 D0o0mZaujPLyjrDoRLXT0naZq8P8rKU/s8JOFK7W+2IwaScF1k81QkqY0cDhbAXhDt
	 XbjZ9gNC+L3sAdzv3FTBOVakbgVMWJr/pC1WSWiDl+JUukOWtOHFBTEzSlBOCFUOvU
	 EJ5qGS/pOpISHRpiyfC1xq4syXbrEwW4daRSjaPNK4YWj7NSx6mbieXyXCxh2CtKmF
	 PTY4X2j/A0+81ZUXCykCf3MEZ03BV8PuzrEvR6LQQCq5rSQaUcWuTIK+NWDrrcXra0
	 a2KOyyg/6MFgA==
Message-ID: <5de18b23238aa2056f56ad541737788af615be62.camel@kernel.org>
Subject: Re: [PATCHES][RFC][CFT] rpc_pipefs cleanups
From: Jeff Layton <jlayton@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 NeilBrown	 <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>, Linus
 Torvalds	 <torvalds@linux-foundation.org>
Date: Fri, 13 Jun 2025 15:32:27 -0400
In-Reply-To: <20250613073149.GI1647736@ZenIV>
References: <20250613073149.GI1647736@ZenIV>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-06-13 at 08:31 +0100, Al Viro wrote:
> 	Another series pulled out of tree-in-dcache pile; it massages
> rpc_pipefs to use saner primitives.  Lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.rpc_pipe
> 6.16-rc1-based, 17 commits, -314 lines of code...
>=20
> Individual patches in followups.
>=20
> Folks, please test and review.  In various forms this has sat in my tree
> for more than a year and I'd rather get that logjam dealt with.
>=20
> Overview:
>=20
> 	Prep/infrastructure (#1 is shared with #work.simple_recursive_removal)
>=20
> 1) simple_recursive_removal(): saner interaction with fsnotify
> 	fsnotify events are triggered before the callback, unlike in real
> unlink(2)/rmdir(2) syscalls.  Obviously matters only in case when callbac=
k
> is non-empty, which excludes most of the current users in the kernel.
>=20
> 2) new helper: simple_start_creating()
> 	Set the things up for kernel-initiated creation of object in a
> tree-in-dcache filesystem.  With respect to locking it's an equivalent of
> filename_create() - we either get a negative dentry with locked parent,
> or ERR_PTR() and no locks taken.
> 	tracefs and debugfs had that open-coded as part of their object
> creation machinery; switched to calling new helper.
>=20
>       rpc_pipefs proper:
>=20
> 3) rpc_pipe: clean failure exits in fill_super
> 	->kill_sb() will be called immediately after a failure
> return anyway, so we don't need to bother with notifier chain and
> rpc_gssd_dummy_depopulate().  What's more, rpc_gssd_dummy_populate()
> failure exits do not need to bother with __rpc_depopulate() - anything
> added to the tree will be taken out by ->kill_sb().
>=20
> 4) rpc_{rmdir_,}depopulate(): use simple_recursive_removal() instead
> 	no need to give an exact list of objects to be remove when it's
> simply every child of the victim directory.
>=20
> 5) rpc_unlink(): use simple_recursive_removal()
> 	Previous commit was dealing with directories; this one is for
> named pipes (i.e. the thing rpc_pipefs is used for).  Note that the
> callback of simple_recursive_removal() is called with the parent locked;
> the victim isn't locked by the caller.
>=20
> 6) rpc_populate(): lift cleanup into callers
> 	rpc_populate() is called either from fill_super (where we
> don't need to remove any files on failure - rpc_kill_sb() will take
> them all out anyway) or from rpc_mkdir_populate(), where we need to
> remove the directory we'd been trying to populate along with whatever
> we'd put into it before we failed.  Simpler to combine that into
> simple_recursive_removal() there.
>=20
> 7) rpc_unlink(): saner calling conventions
> 	* pass it pipe instead of pipe->dentry
> 	* zero pipe->dentry afterwards
> 	* it always returns 0; why bother?
> =09
> 8) rpc_mkpipe_dentry(): saner calling conventions
> 	Instead of returning a dentry or ERR_PTR(-E...), return 0 and
> store dentry into pipe->dentry on success and return -E... on failure.
> Callers are happier that way...
>=20
> 9) rpc_pipe: don't overdo directory locking
> 	Don't try to hold directories locked more than VFS requires;
> lock just before getting a child to be made positive (using
> simple_start_creating()) and unlock as soon as the child is created.
> There's no benefit in keeping the parent locked while populating the
> child - it won't stop dcache lookups anyway.
>=20
> 10) rpc_pipe: saner primitive for creating subdirectories
> 	All users of __rpc_mkdir() have the same form - start_creating(),
> followed, in case of success, by __rpc_mkdir() and unlocking parent.
> Combine that into a single helper, expanding __rpc_mkdir() into it, along
> with the call of __rpc_create_common() in it.
> 	Don't mess with d_drop() + d_add() - just d_instantiate()
> and be done with that.	The reason __rpc_create_common() goes for that
> dance is that dentry it gets might or might not be hashed; here we know
> it's hashed.
>=20
> 11) rpc_pipe: saner primitive for creating regular files
> 	rpc_new_file(); similar to rpc_new_dir(), except that here we
> pass file_operations as well.  Callers don't care about dentry, just
> return 0 or -E...
>=20
> 12) rpc_mkpipe_dentry(): switch to start_creating()
> 	... and make sure we set the rpc_pipe-private part of inode up
> before attaching it to dentry.
>=20
> 13) rpc_gssd_dummy_populate(): don't bother with rpc_populate()
> 	Just have it create gssd (in root), clntXX in gssd, then info
> and gssd in clntXX - all with explicit
> rpc_new_dir()/rpc_new_file()/rpc_mkpipe_dentry().
>=20
> 14) rpc_pipe: expand the calls of rpc_mkdir_populate()
> 	... and get rid of convoluted callbacks.
>=20
> 15) rpc_new_dir(): the last argument is always NULL
> 	All callers except the one in rpc_populate() pass explicit NULL
> there; rpc_populate() passes its last argument ('private') instead,
> but in the only call of rpc_populate() that creates any subdirectories
> (when creating fixed subdirectories of root) private itself is NULL.
>=20
> 16) rpc_create_client_dir(): don't bother with rpc_populate()
> 	not for a single file...
>=20
> 17) rpc_create_client_dir(): return 0 or -E...
> 	Callers couldn't care less which dentry did we get - anything
> valid is treated as success.

Aside from a couple of minor nits, this all looks great, Al.

Pity you don't use git format-patch --cover-letter or we'd have the
aggregate diffstat! I imagine this shrinks the rpc_pipefs code
significantly.

You can add this to the pile.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

