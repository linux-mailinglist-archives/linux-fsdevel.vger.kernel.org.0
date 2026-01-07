Return-Path: <linux-fsdevel+bounces-72609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D111CFD45A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 11:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71EBA30591DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E78B308F23;
	Wed,  7 Jan 2026 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVAQkziR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0383303C9F
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767783137; cv=none; b=dfEXQTzT3N2k22bgwrhvVYki8e5SbsUr92EvnTC4QECHBPWF4A0cxuXUGQyshhDmKKJ9/feRJdERvgZACUlT/AUqjbo+xn4Hoi52skA8hxBPRv6sYZvIo7eTMmtcOBbNm/5oswAb4sHVI0Zox78FXI6izM+PG2nW4wco9ToH/CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767783137; c=relaxed/simple;
	bh=Cn8Rk0GjKOeLhHXjdbAcojuS2I6S2QoWVpxATlRtoKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZpDVpjT7IkDwUUBmayLpXLG6BhAhQ7WdK7ZurUj7xjCQr++4oE6LrXu579jKPvARo2s+jV75BLc0pMDXwl3V8xGhUSyLGYdkct1QaLlBeaPmf80cfZ8i4DkZrDnriACJWcHxzfT0741NDa9jx5nchYcLBR2MTPCg2oZQ0ecvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVAQkziR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F015C4CEF7;
	Wed,  7 Jan 2026 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767783137;
	bh=Cn8Rk0GjKOeLhHXjdbAcojuS2I6S2QoWVpxATlRtoKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVAQkziRPuqNqbkt/u0KU6/yBq+dLyHowLIDacohNZWvtZG2aNAGuM7pTRGpK5nzR
	 2WVE6Jita/UI3DTemSGMB7Z3LduwK0uK+/dr8OaV81ZqWfcVE7Eu6wDxoxiAK6b44w
	 tI7nf1LgqZ4x87H5y3rhVNHjPqrUC7a3/4GgcDOsK2h9/Xi63jTkrJtblZ+K1Tw7FK
	 7sHoIIEkCOx7k2NHklShxgIWGtVMmOD/UOftfUn9Suer9C3GfAWDD+c3P/aCoy0sXX
	 3LIjkwNA/M9Q9jGkKDLZURt0YUD1mHQawuBAebgiRGOz04mnwAdcxtPwU9RabDx2xz
	 V5x+LRpViblqw==
Date: Wed, 7 Jan 2026 11:52:11 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260107-gebahnt-hinfort-4f6bde731e0e@brauner>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
 <20260107024727.GM1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260107024727.GM1712166@ZenIV>

On Wed, Jan 07, 2026 at 02:47:27AM +0000, Al Viro wrote:
> On Wed, Jan 07, 2026 at 10:28:23AM +0800, Gao Xiang wrote:
> 
> > Just one random suggestion.  Regardless of Al's comments,
> > if we really would like to expose a new visible type to
> > userspace,   how about giving it a meaningful name like
> > emptyfs or nullfs (I know it could have other meanings
> > in other OSes) from its tree hierarchy to avoid the
> > ambiguous "rootfs" naming, especially if it may be
> > considered for mounting by users in future potential use
> > cases?
> 
> *boggle*
> 
> _what_ potential use cases?  "This here directory is empty and
> it'll stay empty and anyone trying to create stuff in it will
> get an error; oh, and we want it to be a mount boundary, for
> some reason"?
> 
> IDGI...

It's not a completely crazy idea. I thought about this as well. You
could e.g. use it to overmount and hide other directories - like procfs
overmounting or sysfs overmounting or hiding stuff in /etc where
currently tmpfs is used. But tmpfs is not ideal because you don't get
the reliable immutability guarantees.

