Return-Path: <linux-fsdevel+bounces-61949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7453B80571
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADC964E2AE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 15:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F562BF3CA;
	Wed, 17 Sep 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="UDRF/3Sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2A350D4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121229; cv=none; b=ZKQXYkEcNHFMGhhPwmlVbUWjPvNZyPoUvt/jF63GJyqZqQ1k2RXcpiT3B1kvlyyx1gPQYeZBc4qKgqX8lbXTjRqV08DVNSCa425nDJtazjnL0+9TYmFx59xFbxzQukYDku2mBaI68J/NYpyRiqKo2PAk0Hg1l150geIvEucrvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121229; c=relaxed/simple;
	bh=kUknV5WKpxqxen6YllO7EndW/9+UBC/114j9r0F6OAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXe8ZkxO2W29xixtWAKpsX/CsyHL7IAjqHbh55/aIyC0I7FaV/pTHyz/zlozxzrVOK1PZnFcP0i12TaYFagKbtOj5pvuj3gxYst7VQWfqkGoPV8DXPqJK2wqIpJ7Y+XQyP7Q0gqQ0aAMO9Y3D//BTFrKEsLoPnl1unyhzwSoqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=UDRF/3Sf; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cRhlW6rTTzC01;
	Wed, 17 Sep 2025 17:00:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1758121223;
	bh=+45b6a8YTAEI9zyXy5cY7AS59XYHHDZqWbTvbxo1FxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDRF/3SffXxjKytOWxXm3JgK/CZgebWXr5PGhgWjJr9lLyIoQuHbCGfbv7PAXlHXP
	 FB6QX8qmHVjKGzCz4GgyR/PbQm4ioGTyyA1wkBxYqgoC0gjqSi8lL6nsbRR3JC3xoZ
	 e7bJGu2tWSKQERvIFGRqgoGtJdryMVZCZ9IWgTSc=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4cRhlW1wt0zBcl;
	Wed, 17 Sep 2025 17:00:23 +0200 (CEST)
Date: Wed, 17 Sep 2025 17:00:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>, 
	Tingmao Wang <m@maowtm.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
Message-ID: <20250917.Eip1ahj6neij@digikod.net>
References: <aMih5XYYrpP559de@codewreck.org>
 <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org>
 <3774641.iishnSSGpB@silver>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3774641.iishnSSGpB@silver>
X-Infomaniak-Routing: alpha

On Wed, Sep 17, 2025 at 11:52:35AM +0200, Christian Schoenebeck wrote:
> On Wednesday, September 17, 2025 1:59:21 AM CEST Tingmao Wang wrote:
> > On 9/16/25 20:22, Christian Schoenebeck wrote:
> > > On Tuesday, September 16, 2025 4:01:40 PM CEST Tingmao Wang wrote:
> [...]
> > > I see that you are proposing an option for your proposed qid based
> > > re-using of dentries. I don't think it should be on by default though,
> > > considering what we already discussed (e.g. inodes recycled by ext4, but
> > > also not all 9p servers handling inode collisions).
> > 
> > Just to be clear, this approach (Landlock holding a fid reference, then
> > using the qid as a key to search for rules when a Landlocked process
> > accesses the previously remembered file, possibly after the file has been
> > moved on the server) would only be in Landlock, and would only affect
> > Landlock, not 9pfs (so not sure what you meant by "re-using of dentries").
> > 
> > The idea behind holding a fid reference within Landlock is that, because
> > we have the file open, the inode would not get recycled in ext4, and thus
> > no other file will reuse the qid, until we close that reference (when the
> > Landlock domain terminates, or when the 9p filesystem is unmounted)
> 
> So far I only had a glimpse on your kernel patches and had the impression that 
> they are changing behaviour for all users, since you are touching dentry 
> lookup.

I think we should not hold dentries because:
- they reference other dentries (i.e. a file hierarchy),
- they block umount and I'm convinced the VFS (and users) are not going
  to like long-lived dentries,
- Landlock and inotify don't need dentries, just inodes.

I'm wondering why fid are referenced by dentries instead of inodes.

The need for Landlock is to be able to match an inode with a previously
seen one.  Not all LSM hooks (nor VFS internals) always have access to
dentries, but they do have access to inodes.

> 
> > > For all open FIDs QEMU retains a descriptor to the file/directory.
> > > 
> > > Which 9p message do you see sent to server, Trename or Trenameat?
> > > 
> > > Does this always happen to you or just sometimes, i.e. under heavy load?
> > 
> > Always happen, see log: (no Trename since the rename is done on the host)
> [...]
> > Somehow if I rename in the guest, it all works, even though it's using the
> > same fid 2 (and it didn't ask QEMU to walk the new path)
> 
> Got it. Even though QEMU *should* hold a file descriptor (or a DIR* stream, 

It's reasonable to assume that QEMU and other should hold opened fid In
practice, this might not always be the case, but let's move on and
consider that a 9p server bug.

Landlock and fanotify need some guarantees on opened files, and we
cannot consider every server bug.  For Landlock, inode may get an
"ephemeral tag" (with the Landlock object mechanism) to match previously
seen inodes.  In a perfect world, Landlock could keep a reference on 9p
inodes (as for other filesystems) and these inodes would always match
the same file.  In practice this is not the case, but the 9p client
requirements and the Landlock requirements are not exactly the same.

A 9p client (the kernel) wants to safely deal with duplicated qid, which
should not happen but still happen in practice as explained before.
On the other side, Landlock wants to not deny access to allowed files
(currently identified by their inodes), but I think it would be
reasonable to allow access theoretically denied (i.e. not allowed to be
precise, because of the denied by default mechanism) files because of a
9p server bug mishandling qid (e.g. mapping them to recycled ext4
inodes).

All that to say that it looks reasonable for Landlock to trust the
filesystem, and by that I mean all its dependencies, including the 9p
server, to not have bugs.

Another advantage to rely on qid and server-side opened files is that we
get (in theory) the same semantic as when Landlock is used with local
filesystems (e.g. files moved on the server should still be correctly
identified by Landlock on the client).

> which should imply a file descriptor), there is still a path string stored at 
> V9fsFidState and that path being processed at some places, probably because 
> there are path based and FID based variants (e.g Trename vs. Trenameat). Maybe 
> that clashes somewhere, not sure. So I fear you would need to debug this.

Good to know that it is not a legitimate behavior for a 9p client.

