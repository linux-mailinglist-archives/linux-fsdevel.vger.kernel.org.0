Return-Path: <linux-fsdevel+bounces-46946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FAA96D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892607AAE1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE7E28151D;
	Tue, 22 Apr 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFiPisrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DD27F4EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329260; cv=none; b=u+EonvNCtpDzKobEqtmGWUGUfVD6q9jnIkIOxamVsjyRLEtkl/8D8Dt647A2IwcqrJgaj1m4pHuv0MGX6hzwI7fbFzE0nDjFanAj12DfNjFm640/F/m47FS86XOFKspYM8jolChkKXtvDInWnsghaaRJLMYKT/lOtlMZcB0bRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329260; c=relaxed/simple;
	bh=3qVXQVnV2m6kx/5EONS3s5PDMPQrDRM4+J18gsiUNZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcNfAIfsX3LiMgm81BGJ46ms8IWuS/HRlR3IQNN8MgU5K0ZCjFu/60kPzQ3Ph/zOyBdLjDIMh6eAVS6puLeHUbf/hxl/HbTsjsqmLX4nAZrh2IZ8zuPjOlj1bbxGgjZE3Qmwb/dOiKws8jjBK7fa70Mqp7pfWZlbyBtAyPGitHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFiPisrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A208DC4CEE9;
	Tue, 22 Apr 2025 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745329259;
	bh=3qVXQVnV2m6kx/5EONS3s5PDMPQrDRM4+J18gsiUNZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFiPisrnhbamAPbuoOYjhvfafJJk8WDqFnuCO8iJPIXdx4ueByPvXqym1Fk/KjMLn
	 yPUw6VdBmpM9w2f9bXDwSNZ/CMKx6aDHBvODsIpDnChyFNZZZnsoI5TF22NmGKAB7h
	 0QSSN/iYUKKwh9RKPQStwzfKqulGhDff5RnRQhNiz0rxFBmuWLlvUOTINJ0hyJMX+b
	 r6N1UNJVHqb4tooucZfc3KwEMvFn6g7BTK3kcMLo9PuwS7opDj5hZXJaXJeA9gbjKH
	 zpnZ1ooVyyuUmIp+GrXY/yJTYA++7DBmYOdRNI6MdeVAQrH9b2mfEuo+ne05bk6HVo
	 7Qh3nTiJmd13A==
Date: Tue, 22 Apr 2025 15:40:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] ->mnt_devname is never NULL
Message-ID: <20250422-schindel-windig-686c05171b43@brauner>
References: <20250421033509.GV2023217@ZenIV>
 <20250421-annehmbar-fotoband-eb32f31f6124@brauner>
 <20250421162947.GW2023217@ZenIV>
 <20250422-erbeten-ambiente-f6b13eab8a29@brauner>
 <20250422122514.GZ2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422122514.GZ2023217@ZenIV>

> Consider the following setup:
> 
> mkdir foo
> mkdir bar
> mkdir splat
> mount -t tmpfs none foo		# mount 1
> mount -t tmpfs none bar		# mount 2
> mkdir bar/baz
> mount -t tmpfs none bar/baz	# mount 3
> 
> then
> 
> A: move_mount(AT_FDCWD, "foo", AT_FDCWD, "bar/baz", MOVE_MOUNT_BENEATH)
> gets to do_move_mount() and into do_lock_mount() called by it.
> 
> path->mnt points to mount 3, path->dentry - to its root.  Both are pinned.
> do_lock_mount() goes into the first iteration of loop.  beneath is true,
> so it picks dentry - that of #3 mountpoint, i.e. "/baz" on #2 tmpfs instance.
> 
> At that point refcount of that dentry is 3 - one from being a positive on
> tmpfs, one from being a mountpoint and one more just grabbed by do_lock_mount().
> 
> Now we enter inode_lock(dentry->d_inode).  Note that at that point A is not
> holding any locks.  Suppose it gets preempted at this moment for whatever reason.
> 
> B: mount --move bar/baz splat
> Proceeds without any problems, mount #3 gets moved to "splat".  Now refcount
> of mount #2 is not pinned by anything and refcount of "/baz" on it is 2, since
> it's no longer a mountpoint.
> 
> B: umount bar
> ... and now it hits the fan, since the refcount of mount #2 is not elevated by
> anything, so we do not hit -EBUSY and proceed through umount(2) all the way to

Ok, what you want to say is that we're not keeping a refcount on
path->mnt where the mountpoint is located that we're looking up in the
beneath case.

First iteration, @path->mnt_3 will hold a reference to mount 3. We now
get a reference to @m->mnt_mountpoint that resides on mnt_2 but
we're not holding a reference to mnt_2.

> As for the second issue...  Normal callers of unlock_mount() do have a struct path
> somewhere that pins the location we are dealing with.  However, 'beneath' case
> of do_move_mount() does not - it relies upon the sucker being a mountpoint all
> along.  Which is fine until you drop namespace_sem.  As soon as namespace_unlock()
> has been called, there's no warranty that it will _stay_ a mountpoint.  Moving
> that inode_unlock() before the namespace_unlock() avoids that scenario.

Right.

Thanks for the details, that helped!

Can you resend your changes as a proper commit, please? I have a set of
fixes for -rc4 already and ideally I'd like to include and backport this
right away (We also should really have at least a test with exactly that
layout you're describing.).

It'd be nice if we had infra to force context switches so things like
that were reliably testable...

