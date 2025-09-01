Return-Path: <linux-fsdevel+bounces-59802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3CB3E150
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA46B7AD249
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93820DD48;
	Mon,  1 Sep 2025 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJzVedkf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F462F37
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725432; cv=none; b=awmwUNHvPmS/IjFOCJ84xcrK+XQRsMDDKycdYL61xH10MB/GXydjh4Zc/LTPOgzYJX/nROEo347iU13qhtL9tK10nifAcBBoExfdEtyNrwBmer6beOBP0oHTRa5aiD8fWB4QGESZ4WcUcC/UucveZ0OQcH/qPS1Wrsh97iHWfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725432; c=relaxed/simple;
	bh=tkz6IOZfVNOh7GhhnKtKA2BsrqtGIgXsUDqUP0KNAI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw4I9ueE9FAFlv5yUCgIofJMcDJY4zMQ2tC2PojDXNEHCY06vUuQWUGS3Omw6+16jO6JfdXZzGHIyub7VWTsHYJ4gFA/9/34JGjduz1fdT2mP8tG8A6Dce9EDz3+zn+EsVD9VUesKNi88KE1tUdB8RPhi12xxzCDlPNGDgiwzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJzVedkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68030C4CEF0;
	Mon,  1 Sep 2025 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756725431;
	bh=tkz6IOZfVNOh7GhhnKtKA2BsrqtGIgXsUDqUP0KNAI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJzVedkfuawaZUbioDX9pfzKk6JacRqTUJBIE27MTfnNV01IEcBSPFiXbwtLRQN/p
	 CChh8Br78RJSm459xVd8eIB1EO7s7j0N3NGvLxiy1uI1HtWypXWpKfMIA52J0XAiQN
	 Oe7RnVpRDI0BfPjLLuLUuKRVnSLFY5mz7ktJvY2Nhs9JTKjvBMQ8qyVK0vATuJDlS9
	 JAlwdzMOn/Hd6FG59+F9PiM23upCE+1Xfjqhv9fFfKNpNgbFEb40LYpr0lWaCwLs7N
	 DqlJGs6ge7L3mvXA9DXer9TgwiJoS7ijo/srT/KGq1RhfPgB4RwK4WsrzLeNUhzU6/
	 pdR/KHjv8Wq3A==
Date: Mon, 1 Sep 2025 13:17:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: [60/63] setup_mnt(): primitive for connecting a mount to
 filesystem
Message-ID: <20250901-maler-hinweisen-8621e226a3c5@brauner>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
 <20250829060522.GB659926@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829060522.GB659926@ZenIV>

On Fri, Aug 29, 2025 at 07:05:22AM +0100, Al Viro wrote:
> Take the identical logics in vfs_create_mount() and clone_mnt() into
> a new helper that takes an empty struct mount and attaches it to
> given dentry (sub)tree.
> 
> Should be called once in the lifetime of every mount, prior to making
> it visible in any data structures.
> 
> After that point ->mnt_root and ->mnt_sb never change; ->mnt_root
> is a counting reference to dentry and ->mnt_sb - an active reference
> to superblock.
> 
> Mount remains associated with that dentry tree all the way until
> the call of cleanup_mnt(), when the refcount eventually drops
> to zero.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

