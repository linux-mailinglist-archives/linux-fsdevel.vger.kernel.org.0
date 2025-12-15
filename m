Return-Path: <linux-fsdevel+bounces-71324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F6CBDA2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40EC83019E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAC2E5D17;
	Mon, 15 Dec 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av67KzhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2772D3B8D5E;
	Mon, 15 Dec 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799717; cv=none; b=uppATOZKryempMbfNMtR5Mpuhosy8IuLTjSdfRToTuLKCOSvHkcRioxTU3s6IuhzCvC+IpN8ylI2DN+6nphUmPcry7RY6cRTVHMDcezwXXBVzNkLznD6nvHriRadzZYlrF6h9PzkKOOslJKRACb0leJHwsKzF3Qe725HNEV3dT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799717; c=relaxed/simple;
	bh=r+A2A9BnXJHgssrYOfq4/0w0ZvAC39V7qU5P/bi3rpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBemW1PQbdadUYuIkk8ldunjfcSdsdoh6WLC+FWLoSxmHFvJBfSwmFxgrdMONflgnrV1liTwg6r4LKFMDahExbL3H0SLDuQxv5iGbhPZQLAg6HGVn0hNa5B2DV+L1TUjXLVwyWLGoCA9BqAyrLFoEPPhL2z1cJQEM9Tz97v0TOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av67KzhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CACC4CEF5;
	Mon, 15 Dec 2025 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765799716;
	bh=r+A2A9BnXJHgssrYOfq4/0w0ZvAC39V7qU5P/bi3rpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=av67KzhRbMhoOdLddOyoiJwcgAMX+M+DJ/ZUq65JuBHswhGGDAhLAmJjWyCGUM5T/
	 TYwJ36R/K52dbIq2e55Tn+zrRFYrwpcKTQ/NDilfDpuuG8L9B4q4b1gCp6sMVgPHXG
	 Uocy5A2jGT0Kgy0WyRfP9pZos0J+FpawL8xvT1M6V/caYI6jn8aVrJ6enjN7sfFJZP
	 c8yz4mtcg0KxIIciT5bzwqYLgYtnNUfRFU86zdCaftmnnQn7ED6fF/bMeClxjml0sF
	 SUuHfu+EKT/LAt5SCOkPE88JlbQzz7DMzanalo6/oKBkPZI1ErGefWnISx5d/r2hiH
	 Y+NfWg2fQmjvA==
Date: Mon, 15 Dec 2025 12:55:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: me@black-desk.cn, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
Message-ID: <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
 <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>

On Mon, Dec 15, 2025 at 09:46:19AM +0100, Jan Kara wrote:
> On Sat 13-12-25 02:03:56, Chen Linxuan via B4 Relay wrote:
> > From: Chen Linxuan <me@black-desk.cn>
> > 
> > When using fsconfig(..., FSCONFIG_CMD_CREATE, ...), the filesystem
> > context is retrieved from the file descriptor. Since the file structure
> > persists across syscall restarts, the context state is preserved:
> > 
> > 	// fs/fsopen.c
> > 	SYSCALL_DEFINE5(fsconfig, ...)
> > 	{
> > 		...
> > 		fc = fd_file(f)->private_data;
> > 		...
> > 		ret = vfs_fsconfig_locked(fc, cmd, &param);
> > 		...
> > 	}
> > 
> > In vfs_cmd_create(), the context phase is transitioned to
> > FS_CONTEXT_CREATING before calling vfs_get_tree():
> > 
> > 	// fs/fsopen.c
> > 	static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
> > 	{
> > 		...
> > 		fc->phase = FS_CONTEXT_CREATING;
> > 		...
> > 		ret = vfs_get_tree(fc);
> > 		...
> > 	}
> > 
> > However, vfs_get_tree() may return -ERESTARTNOINTR if the filesystem
> > implementation needs to restart the syscall. For example, cgroup v1 does
> > this when it encounters a race condition where the root is dying:
> > 
> > 	// kernel/cgroup/cgroup-v1.c
> > 	int cgroup1_get_tree(struct fs_context *fc)
> > 	{
> > 		...
> > 		if (unlikely(ret > 0)) {
> > 			msleep(10);
> > 			return restart_syscall();
> > 		}
> > 		return ret;
> > 	}
> > 
> > If the syscall is restarted, fsconfig() is called again and retrieves
> > the *same* fs_context. However, vfs_cmd_create() rejects the call
> > because the phase was left as FS_CONTEXT_CREATING during the first
> > attempt:
> 
> Well, not quite. The phase is actually set to FS_CONTEXT_FAILED if
> vfs_get_tree() returns any error. Still the effect is the same.

Uh, I'm not sure we should do this. If this only affects cgroup v1 then
I say we should simply not care at all. It's a deprecated api and anyone
using it uses something that is inherently broken and a big portion of
userspace has already migrated. The current or upcoming systemd release
has dropped all cgroup v1 support.

Generally, making fsconfig() restartable is not as trivial as it looks
because once you called into the filesystem the config that was setup
might have already been consumed. That's definitely the case for stuff
in overlayfs and others. So no, that patch won't work and btw, I
remembered that we already had that discussion a few years ago and I was
right:

https://lore.kernel.org/20200923201958.b27ecda5a1e788fb5f472bcd@virtuozzo.com

