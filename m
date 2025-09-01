Return-Path: <linux-fsdevel+bounces-59809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B877B3E1C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E941A8197F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074BF31A063;
	Mon,  1 Sep 2025 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWmJe+9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40F3148A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726676; cv=none; b=CrGW/CSlKJQREVAffHK2eWfi1+42rl4Pb8ZHuPCXG+PsRpj4JwZ5xtUPq+bT7RteOkcyABkpBzUuITCozPXq7sKBgaYwmVE7VjC/c7OtokEGLXCiGVrRu5//2+bJCFNkRTYfWnYsximvWTil9cTiB9L72OSo7wPM1ndpRhB3aWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726676; c=relaxed/simple;
	bh=WGBqhaMirsAr7f3Df+58k27oKnLEA1BXnBv66sYeOaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3j5m7+PszUkS5shMobEeA1fSUwalCEdRNTYU2/bbshTYLsqdw6Iy4lAqz8qWzzzj6JijT8HZYNtt82t6FbxyZX/f2A9Pz1uxDI0Ls/7peBQPINHLgehxXoP01yQaGagr55L4FxlI2/Getw7rrylt+G447F3BqgPnU70GcPbJuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWmJe+9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB4EC4CEF0;
	Mon,  1 Sep 2025 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756726675;
	bh=WGBqhaMirsAr7f3Df+58k27oKnLEA1BXnBv66sYeOaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dWmJe+9W4bkyQLZxANzx9KBOYIbaQJXRHK8zl/qFJ70AQRqDRQzUN0MNVt+by2swq
	 UixSaer3dW+jUYEJq4duWgdJtcRb3ZzUQTHq5oJzjpyZli1XIpgRRIYlaWCsPxIO4m
	 YpPwsKwyGMuTa8edTNp86p8RxUtsi9FTf2VnwISaSLJJaUF31YRzFdot7sRKsSqghL
	 0K2/tHIY3t4bBYxX791/GXx1LdQcPVDWyz0p124frnPh2t3NTyNsGJI3fSTp7xiO9g
	 gDeM8unkXry1uywGJl4PD34jYs2iOhbtljoW771uCU3ujMYTXLwIR0PP/EwRrtGBi2
	 Yq2Q2PNFfZeIw==
Date: Mon, 1 Sep 2025 13:37:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v2 28/63] change calling conventions for lock_mount()
 et.al.
Message-ID: <20250901-vulkan-sputen-6b99c8f279a0@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-28-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828230806.3582485-28-viro@zeniv.linux.org.uk>

On Fri, Aug 29, 2025 at 12:07:31AM +0100, Al Viro wrote:
> 1) pinned_mountpoint gets a new member - struct mount *parent.
> Set only if we locked the sucker; ERR_PTR() - on failed attempt.
> 
> 2) do_lock_mount() et.al. return void and set ->parent to
> 	* on success with !beneath - mount corresponding to path->mnt
> 	* on success with beneath - the parent of mount corresponding
> to path->mnt
> 	* in case of error - ERR_PTR(-E...).
> IOW, we get the mount we will be actually mounting upon or ERR_PTR().
> 
> 3) we can't use CLASS, since the pinned_mountpoint is placed on
> hlist during initialization, so we define local macros:
> 	LOCK_MOUNT(mp, path)
> 	LOCK_MOUNT_MAYBE_BENEATH(mp, path, beneath)
> 	LOCK_MOUNT_EXACT(mp, path)
> All of them declare and initialize struct pinned_mountpoint mp,
> with unlock_mount done via __cleanup().
> 
> Users converted.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

This is nice! Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

