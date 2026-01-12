Return-Path: <linux-fsdevel+bounces-73196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0DD11717
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 391D030445C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9A33D6F3;
	Mon, 12 Jan 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO65Rnk1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A51EFF8D;
	Mon, 12 Jan 2026 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209400; cv=none; b=ErK9H6xGaUAUIcMs+thJm1C3V3TrBFgYLOlZowvX9O7ToQ/T4GvMzQ3/CyTEPZvN7IdM2O4S9H522nywKZwTLORZZ4xGWHnyg0ChwnWei52LK1wJysMLDmHjsFx3wox8DeJ0n39lKqzOQkSF7k/ETlsU6ibl3XFCnbVydqSrNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209400; c=relaxed/simple;
	bh=tpZiTcuz6/W4E9iE47Iuw7ikyjLo2PWr+A2gR3LlTt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+5I4EuQssycnP64LDCdlp3wNAWMq8PpplM7TOyuVM80jkeH3FMlZ3aexp593QFqrdsqjegsQWkGqLHoYcFqJLcOniaq9afDPKjkU7jkD6eVtdMBKIqyEvpHbD2zvnrt+1oMWQVRQALJLyq8QezYif4v8/GFbROm50geu5Cjht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO65Rnk1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A79AC19422;
	Mon, 12 Jan 2026 09:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209400;
	bh=tpZiTcuz6/W4E9iE47Iuw7ikyjLo2PWr+A2gR3LlTt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lO65Rnk1QtpqVP950zcXgvleKH2xUB8PWt+Dv17Nc62coxReuSivmUDxAhj7CR4xN
	 w9/zWQXUspmbx7mOzFjSMopYRXV3VFqoS69PCIz/Dzlz6VWsoDymjw7D6IIz5gT+E9
	 02l0U4vZZ8hjsjBXTcChw7tSI5mL6baRz04/6M7sXzbHH6RID/i7zH+0GVhFQz4dTE
	 9V6lz3XSf7sLPniiKUM7pg3q2BurC+8eDa5gpdKjFarepU1YKS+QFVgYJ+egKy7qaE
	 nADPkIfTU35H0ZfwEnawhYOH/tN0LBX+3RZ3pgTWplzEL4eEmgpggF4NsKMrBHu8vD
	 Tvgda8DX89zBg==
Date: Mon, 12 Jan 2026 10:16:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 0/6] Automatic NFSv4 state revocation on filesystem
 unmount
Message-ID: <20260112-dingo-aufwuchs-a118f763554a@brauner>
References: <20260108004016.3907158-1-cel@kernel.org>
 <206cb47d470bb06b26175755adec013cfac759d7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <206cb47d470bb06b26175755adec013cfac759d7.camel@kernel.org>

On Fri, Jan 09, 2026 at 11:25:30AM -0500, Jeff Layton wrote:
> On Wed, 2026-01-07 at 19:40 -0500, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > When an NFS server exports a filesystem and clients hold NFSv4 state
> > (opens, locks, delegations), unmounting the underlying filesystem
> > fails with EBUSY. The /proc/fs/nfsd/unlock_fs interface exists for
> > administrators to manually revoke state before retrying the unmount,
> > but this approach has significant operational drawbacks.
> > 
> > Manual intervention breaks automation workflows. Containerized NFS
> > servers, orchestration systems, and unattended maintenance scripts
> > cannot reliably unmount exported filesystems without implementing
> > custom logic to detect the failure and invoke unlock_fs. System
> > administrators managing many exports face tedious, error-prone
> > procedures when decommissioning storage.
> > 
> > This series enables the NFS server to detect filesystem unmount
> > events and automatically revoke associated state. The mechanism
> > uses the kernel's existing fs_pin infrastructure, which provides
> > callbacks during mount lifecycle transitions.
> > 
> 
> (cc'ing the vfs maintainers)
> 
> One thing I want to point out here is that the only user of fs_pin is
> the BSD process accounting subsystem, which would be really nice to get
> rid of at some point:
> 
> https://lore.kernel.org/linux-fsdevel/20260106-bsd-acct-v1-1-d15564b52c83@kernel.org/
> 
> I suspect the VFS maintainers might want you to use something different
> here so fs_pin can eventually go away too.

git rm -rf ?

> An alternate idea might be to plumb an srcu notifier chain into the
> umount codepath, similar to the lease_notifier_chain in fs/locks.c.
> Then nfsd could register to be notified when there is a umount attempt
> and do the right thing to tear down state.

Doesn't sound too bad.

> 
> 
> > When a filesystem
> > is unmounted, all NFSv4 opens, locks, and delegations referencing
> > it are revoked, async COPY operations are cancelled with
> > NFS4ERR_ADMIN_REVOKED sent to clients, NLM locks are released,
> > and cached file handles are closed.
> > 
> > With automatic revocation, unmount operations complete without
> > administrator intervention once the brief state cleanup finishes.
> > Clients receive immediate notification of state loss through
> > standard NFSv4 error codes, allowing applications to handle the
> > situation appropriately rather than encountering silent failures.
> > 
> > Based on the nfsd-testing branch of:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/
> > 
> > Changes since v1:
> > - Explain why drop_client() is being renamed
> > - Finish implementing revocation on umount
> > - Rename pin_insert_group
> > - Clarified log output and code comments
> > - Hold nfsd_mutex while closing nfsd_files
> > 
> > Chuck Lever (6):
> >   nfsd: cancel async COPY operations when admin revokes filesystem state
> >   fs: export pin_insert and pin_remove for modular filesystems
> >   fs: add pin_insert_sb() for superblock-only pins
> >   fs: invoke group_pin_kill() during mount teardown
> >   nfsd: revoke NFSv4 state when filesystem is unmounted
> >   nfsd: close cached files on filesystem unmount
> > 
> >  fs/fs_pin.c            |  50 ++++++++
> >  fs/namespace.c         |   2 +
> >  fs/nfsd/Makefile       |   2 +-
> >  fs/nfsd/filecache.c    |  44 +++++++
> >  fs/nfsd/filecache.h    |   1 +
> >  fs/nfsd/netns.h        |   4 +
> >  fs/nfsd/nfs4proc.c     | 124 +++++++++++++++++--
> >  fs/nfsd/nfs4state.c    |  46 +++++--
> >  fs/nfsd/nfsctl.c       |  11 +-
> >  fs/nfsd/pin.c          | 274 +++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/state.h        |   9 ++
> >  fs/nfsd/xdr4.h         |   1 +
> >  include/linux/fs_pin.h |   1 +
> >  13 files changed, 548 insertions(+), 21 deletions(-)
> >  create mode 100644 fs/nfsd/pin.c
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

