Return-Path: <linux-fsdevel+bounces-72550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3E1CFB341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877943015847
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 22:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D7627E056;
	Tue,  6 Jan 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrLbuHtr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCC23D2A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737257; cv=none; b=UUBY1khZ68dg/xNTIhkurRnz6hmDoCZbHFcgDgNTulEa56X+aN2k3446Yvcezx223yKx0+GqvKJa2Evbw2FUwkX94cNfiqaLfBBtT0dwyJRm23Nc2Ssu6reNeYQlYxOZscIf7NkJpczGY3zqVh1XpI7TZR0niq7ekG1SVcpRdFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737257; c=relaxed/simple;
	bh=VyXinrQ+DQyD+2JZgnbVfYqZaWRl1if3ttXE4rRdUxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLWRtAhB/iEpq1A30e/u+ooQasaIavp2q1n0Wh8gVtKYaNbqY9DmoG8j85Gir4uq6vQ+2uwjg3l34af6/CEpN+OU1q1muvOwLCyeJVlFycjUkA8YZQxwmZ7pledldRZ5RyCOlGU9oknERGzs2iNHT7AolNLYuvb2REeTj16U1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrLbuHtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E34C19422;
	Tue,  6 Jan 2026 22:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767737256;
	bh=VyXinrQ+DQyD+2JZgnbVfYqZaWRl1if3ttXE4rRdUxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrLbuHtr1QX24cBTuH+3zsHKNtWLZbNWBk/Ekp9s+Vu0x4/UTask+E42xPjMJu4Ii
	 60zpw+tbXA2MvzebowfWol5l4ZubQXFhHmErFR1on/8RyN12HHAbr+dNPUq4aKZPqt
	 /SD/7nP4rZsYYA9+Oml5Oubp8dIWX1Y9kOA94kdeFiL1eX8GLoAmGRGWjpqRdAhcmX
	 Gq4N57iGRVW33RlxOSWr0Gql/+a+orpAx1FmVSWyZWwp/RuPZq0AYtiukHx/+DHpOD
	 gG63mMaCDCfJF25xeRNXeSqoyl9UgVIJwdUaK1RDxTu+4AwMhJuWyr+IJN3Mkb5cWJ
	 /TdolFkTsEQmQ==
Date: Tue, 6 Jan 2026 23:07:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Message-ID: <20260106-verpachten-antrag-5b610d1ec4d0@brauner>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <20260104072743.GI1712166@ZenIV>
 <20260104074145.GJ1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260104074145.GJ1712166@ZenIV>

On Sun, Jan 04, 2026 at 07:41:45AM +0000, Al Viro wrote:
> On Sun, Jan 04, 2026 at 07:27:43AM +0000, Al Viro wrote:
> > On Fri, Jan 02, 2026 at 03:36:24PM +0100, Christian Brauner wrote:
> > 
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> > > +#include <linux/fs/super_types.h>
> > > +#include <linux/fs_context.h>
> > > +#include <linux/magic.h>
> > 
> > [snip]
> > 
> > What does it give you compared to an empty ramfs?  Or tmpfs, for that
> > matter...
> > 
> > Why bother with a separate fs type?
> 
> Make that "empty ramfs" and as soon as you've got the mount have
> 	mnt->mnt_root->d_inode->i_flags |= S_IMMUTABLE;
> done.  No concurrent accesses at that point, no way to clear that
> flag for ramfs inodes afterwards and ramfs is always built in...
> 
> What am I missing here?

Good point.

Afaict, FS_IMMUTABLE_FL can be cleared by a sufficiently privileged
process breaking the promise that this is a permanently immutable
rootfs. The guarantee is that nothing will ever exist in it and all it
ever does is to serve as a parent mount to the point where we can just
hand out an empty namespace to unprivileged namespaces without ever
having to worry that anything sensitive is exposed.

I also dislike that the real rootfs should be a tmpfs or ramfs in the
first place. It just shouldn't serve any purpose other than as a marker
that we reached a dead-end. Userspace has terrible code to parse for
"rootfs" and then stat whether it's a ramfs or tmpfs to figure out
whether it is the real rootfs. By making it a really dead-simple
filesystem and giving it its own magic number userspace can just stat
for it.

