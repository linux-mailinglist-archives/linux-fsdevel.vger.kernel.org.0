Return-Path: <linux-fsdevel+bounces-54832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F3B03BDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 12:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F201B189C4BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF1244667;
	Mon, 14 Jul 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL2vxDOK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B5F4A1A;
	Mon, 14 Jul 2025 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488862; cv=none; b=g7E9J3fv6tSsV5LRWRqWf8Nv/Tkpx4mFGSLDH1uXefbbZ2Cg6Y0yd4EckgzQGbBZ/7f1Ork6ICcMihxv6fkyGWRTHRgWXmZ21mgii6KZbebKZj7QU761UGgqFwkZkYRO8NgY6Y1AdxZ8eInxih5L5Nb96zYhyoMpUHw6+b+4lsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488862; c=relaxed/simple;
	bh=8pnulw2w69eNPwxKofFgHjfyhjx9TXzhxDdMt3XR+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp91+3giHIrLbiNkVliCcaL+acdLIlLfkJ5cUea+Wz89gEPd0rcB5asD/+EG+XFbqSQjaoLzt5psR4JoYBNFJ/wgR/jtcmhpoUsi0nMCWc0NwbQ8bVBDH+HDqrz2VdoTjllR6IwMhJHavXfd3gDxIZvTgSQn4+e3wPXrts71b8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL2vxDOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8722AC4CEF4;
	Mon, 14 Jul 2025 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752488861;
	bh=8pnulw2w69eNPwxKofFgHjfyhjx9TXzhxDdMt3XR+20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jL2vxDOKTgDrwVIvHruyOZqor1dAJ/DSJ5cpwbyF9kvMpohyh5vt7UQa8BXxvFEDL
	 rpM9N+HEahSJrLLD0PICs2Gi2aFDugrqKJPsGapJXJjM7KvE2Zb96AFBHxWU0SS8Gw
	 Bzfu/BsP2o5Og6EYEIqoFtNgmnCVPqrUQ9tVkVUzT9wdLL87IJBq8fmy02Zk+wFVbj
	 0v1E6gLrAnT10adfsLV37bqZ3ReAhig1m590i8cP+yrbhwlVKMq1abAXCXVpkpwT4F
	 MnjM3H3hNjt7y4g1qubDH5ay6KurxiUNbsavxha+kfZpxE+X3g5JOw4dI/h6fhVle0
	 N/KfbxoJEDg8g==
Date: Mon, 14 Jul 2025 12:27:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org, wqu@suse.com, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
Message-ID: <20250714-bahnfahren-bergregion-3491c6f304a4@brauner>
References: <20250708132540.28285-1-dsterba@suse.com>
 <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
 <20250711191521.GF22472@twin.jikos.cz>
 <6bb8c4f4-bf17-471a-aa5f-ce26c8566a17@gmx.com>
 <a90a8a32-ea3a-4915-b98b-f52c51444aa5@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a90a8a32-ea3a-4915-b98b-f52c51444aa5@gmx.com>

On Sat, Jul 12, 2025 at 08:39:51AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/12 08:21, Qu Wenruo 写道:
> > 
> > 
> > 在 2025/7/12 04:45, David Sterba 写道:
> > > On Wed, Jul 09, 2025 at 07:33:56AM +0930, Qu Wenruo wrote:
> > > > 
> > > > 
> > > > 在 2025/7/8 22:55, David Sterba 写道:
> > > > > Implement sb->freeze_super that can instruct our threads to pause
> > > > > themselves. In case of (read-write) scrub this means to undo
> > > > > mnt_want_write, implemented as sb_start_write()/sb_end_write().
> > > > > The freeze_super callback is necessary otherwise the call
> > > > > sb_want_write() inside the generic implementation hangs.
> > > > 
> > > > I don't this this is really going to work.
> > > > 
> > > > The main problem is out of btrfs, it's all about the s_writer.rw_sem.
> > > > 
> > > > If we have a running scrub, it holds the mnt_want_write_file(), which is
> > > > a read lock on the rw_sem.
> > > > 
> > > > Then we start freezing, which will call sb_wait_write(), which will do a
> > > > write lock on the rw_sem, waiting for the scrub to finish.
> > > > 
> > > > However the ->freeze() callback is only called when freeze_super() got
> > > > the write lock on the rw_sem.
> > > 
> > > Note there are 2 callbacks for freeze, sb::freeze_super and
> > > sb::freeze_fs.
> > > 
> > > ioctl_fsfreeze
> > >    if fs->freeze_super
> > >      call fs_freeze_super()
> > 
> > Oh I forgot you implemented a new callback, ->freeze_super() to do the
> > extra btrfs specific handling.
> > 
> > But this means, we're exposing ourselves to all the extra VFS handling,
> > I'm not sure if this is the preferred way, nor if the extra btrfs
> > handling is good enough to cover what's done inside freeze_super()
> > function (I guess not though).
> 
> My bad, it's calling back into freeze_super() function, so it's fine.

You have to expose yourself to all the VFS handling and you must call
freeze_super() at some point. You can't just do freeze on your own. You
have roughly the following classes of freeze calls:

(1) initiated from userspace
    (1.1) initiated from the block layer => upcall into the filesystem
    (1.2) initiated from the filesystem
(2) initiated from the kernel
    (2.1) initiated from the filesystem
    (2.2) suspend/hibernation

All of that requires synchronization and you cannot do this without
going through the VFS layer's locking safely. At least not without
causing royal pain for yourself and the block and VFS layer.

(Fwiw, I would still really like to see support for fs_holder_ops so
btrfs freezing works correctly when called from the block layer.)

> 
> The remaining concern is just should we do this by using
> ->freeze_super() callback, or do the f2fs' way by poking into
> s_writer.frozen.
> 
> I'd prefer the later one, as that's already exposed to filesystems and we do
> not need extra callback functions especially when it's not widely used.

This would be simpler. You should probably add a helper that you can
share with gfs2 to sample the state instead of raw accesses to
s_writers->frozen. I find the latter a bit ugly and error prone if we
ever change this. I'd rather have it encapsulated in the VFS layer as
best as we can.

