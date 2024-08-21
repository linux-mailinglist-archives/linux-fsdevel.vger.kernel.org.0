Return-Path: <linux-fsdevel+bounces-26550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D2B95A5AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 22:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9BAB220E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3B216F297;
	Wed, 21 Aug 2024 20:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHSVkXIX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82261D12F4;
	Wed, 21 Aug 2024 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271055; cv=none; b=f1aiCFZGM+PjAajKroPRhW4RhYElshylr9+3t2tPcGK+1Di032CwJtoHVtRfo0BrtPgCGWgHeRgjTY8Y0OizktEG7Q6EouteQvfXdsXmm4vcpQjxCmxwu5QPiJIA5nC0o+OuHwO1uIWKskyU7R9VMV4NDwF9DK8UQsw6iy8CRGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271055; c=relaxed/simple;
	bh=uznEO9VPTqxrZSTYBH/KwgeyrNt7jCcRBuhzGGO5QAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENroydL+p/vf68S8PRqe/Mul0HPT0Qbtl477WZC1hsW1eTyuOWdTd9LHhBI98wigWbhRWxScGTS9OFDVLacAh41mYqdrsZs+LprytaL4GqyP6HniJQ1k83m47ek/K2DvAaa3CRr+8ZfXYF+RQlBurGvXKp5a5YXPoonAZgSabnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHSVkXIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4ECC32781;
	Wed, 21 Aug 2024 20:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724271055;
	bh=uznEO9VPTqxrZSTYBH/KwgeyrNt7jCcRBuhzGGO5QAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHSVkXIXN2upfsAMXeN4Hp6OSRgsw9mD2pYxEGlWUSFr8Xim8zqcFH1AFklqP+VbD
	 8KOK0RRR0BR+bdFikcz+lnAA/lQKOYCpE8NmMG3LcmIjmM7rj51jHNQaNZgc9Rurvn
	 WXNgnJkBDg20RUvJxvOtY4LmdyXQ7LsQAwfGGKQxgMSTzYl633oHhmZ6TpWR9ZqsZ9
	 XdsDd767+rFwCMcVhhA/Q9O3Daa+njFps8hZyX5lVTxmUCoM8oXa31H60buHMJHOq1
	 DuIrQDYQWlKbX6UBQwllfMAuaqVS7sjc+pbmp7ITcSyP5USul4mTd3gM+7o9ORw2Vg
	 uiELqQrv0zrDQ==
Date: Wed, 21 Aug 2024 16:10:54 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 00/24] nfs/nfsd: add support for localio
Message-ID: <ZsZJznvKy1_TP5AS@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
 <ZsZGfNj0QOhIFtiV@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZGfNj0QOhIFtiV@tissot.1015granger.net>

On Wed, Aug 21, 2024 at 03:56:44PM -0400, Chuck Lever wrote:
> On Mon, Aug 19, 2024 at 02:17:05PM -0400, Mike Snitzer wrote:
> > These latest changes are available in my git tree here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > Significant progress was made on the entire series, I implemented all
> > 3 changes NeilBrown suggested here:
> > https://marc.info/?l=linux-nfs&m=172004547710968&w=2
> > 
> > And Neil kindly provided review of a preliminary v12 that I then used
> > to refine this final v12 further.  Neil found the series much cleaner
> > and approachable.
> > 
> > This v12 also switches the NFS client's localio code over to driving
> > IO in terms of nfsd's nfsd_file (rather than a simple file pointer).
> > I checked with Jeff Layton and he likes the switch to using nfsd_file
> > (Jeff did suggest I make sure to keep struct nfsd_file completely
> > opaque to the client).  Proper use of nfsd_file provides a solid
> > performance improvement (as detailed in the last patch's commit
> > header) thanks especially to the nfsd filecache's GC feature (which
> > localio now makes use of).
> > 
> > Testing:
> > - Chuck's kdevops NFS testing has been operating against the
> >   nfs-localio-for-next branch for a while now (not sure if LOCALIO is
> >   enabled or if Chuck is just verifying the branch works with LOCALIO
> >   disabled).
> > - Verified all of Hammerspace's various sanity tests pass (this
> >   includes numerous pNFS and flexfiles tests).
> > 
> > Please review, I'm hopeful I've addressed any outstanding issues and
> > that these changes worthy of being merged for v6.12.  If you see
> > something, say something ;)
> > 
> > Changes since v11:
> > - The required localio specific changes in fs/nfsd/ are much simpler
> >   (thanks to the prelim patches that update common code to support the
> >    the localio case, fs/nfsd/localio.c in particular is now very lean)
> > - Improved the localio protocol to address NeilBrown's issue #1.
> >   Replaced GETUUID with UUID_IS_LOCAL RPC, which inverts protocol such
> >   that client generates a nonce (shortlived single-use UUID) and
> >   proceeds to verify the server sees it in nfs_common.
> >   - this eliminated the need to add 'struct nfsd_uuid' to nfsd_net
> > - Finished the RFC series NeilBrown started to introduce
> >   nfsd_file_acquire_local(), enables the use of a "fake" svc_rqst to
> >   be eliminated: https://marc.info/?l=linux-nfs&m=171980269529965&w=2 
> >   (uses auth_domain as suggested, addresses NeilBrown's issue #2)
> > - rpcauth_map_clnt_to_svc_cred_local now uses userns of client and
> >   from_{kuid,kgid}_munged (hopefully addresses NeilBrown's issue #3)
> > - Updated nfs_local_call_write() to override_creds() with the cred
> >   used by the client to open the localio file.
> > - To avoid localio hitting writeback deadlock (same as is done for
> >   existing loopback NFSD support in nfsd_vfs_write() function): set
> >   PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO in nfs_local_call_write() and
> >   restore current->flags before return.
> > - Factored nfs_stat_to_errno and nfs4_stat_to_errno out to nfs_common
> >   to eliminate localio code creating yet another copy of them.
> >   (eliminates existing duplication between fs/nfs/nfs[23]xdr.c)
> > - Simplified Kconfig so that NFS_LOCALIO depends on NFS_FS and
> >   NFSD_LOCALIO depends on NFSD.
> > - Only support localio if UNIX Authentication (AUTH_UNIX) is used.
> > - Improved workqueue patch to not use wait_for_completion().
> > - Dropped 2 prelim fs/nfs/ patches that weren't actually needed.
> > - Updated localio.rst to reflect the various changes listed above,
> >   also added a new "FAQ" section from Trond (which was informed by an
> >   in-person discussion about localio that Trond had with Christoph).
> > - Fixed "nfsd: add nfsd_file_acquire_local()" commit to work with
> >   NFSv3 (had been testing with NFSv4.2 and the fact that NFSv3
> >   regressed due to 'nfs_ver' not being properly initialized for
> >   non-LOCALIO callers was missed.
> > - Fixed issue Neil reported where "When using localio, if I open,
> >   read, don't close, then try to stop the server and umount the
> >   exported filesystem I get EBUSY for the umount."
> >   - fix by removing refcount on localio file (no longer cache open
> >     localio file in the client).
> > - Fixed nfsd tracepoints that were impacted by the possibility they'd
> >   be passed a NULL rqstp when using localio.
> > - Rebased on cel/nfsd-next (based on v6.11-rc4) to layer upon Neil's
> >   various changes that were originally motivated by LOCALIO, reduces
> >   footprint of this patchset.
> > - Exported nfsd_file interfaces needed to switch the nfs client's
> >   localio code over to using it.
> > - Switched the the nfs client's localio code over to using nfsd_file.
> > 
> > Thanks,
> > Mike
> > 
> > Mike Snitzer (13):
> >   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
> >   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
> >   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
> >   nfsd: fix nfsfh tracepoints to properly handle NULL rqstp
> >   SUNRPC: remove call_allocate() BUG_ONs
> >   nfs_common: add NFS LOCALIO auxiliary protocol enablement
> >   nfsd: implement server support for NFS_LOCALIO_PROGRAM
> >   nfs: implement client support for NFS_LOCALIO_PROGRAM
> >   nfs: add Documentation/filesystems/nfs/localio.rst
> >   nfsd: use GC for nfsd_file returned by nfsd_file_acquire_local
> >   nfs_common: expose localio's required nfsd symbols to nfs client
> >   nfs: push localio nfsd_file_put call out to client
> >   nfs: switch client to use nfsd_file for localio
> > 
> > NeilBrown (3):
> >   nfsd: factor out __fh_verify to allow NULL rqstp to be passed
> >   nfsd: add nfsd_file_acquire_local()
> >   SUNRPC: replace program list with program array
> > 
> > Trond Myklebust (4):
> >   nfs: enable localio for non-pNFS IO
> >   pnfs/flexfiles: enable localio support
> >   nfs/localio: use dedicated workqueues for filesystem read and write
> >   nfs: add FAQ section to Documentation/filesystems/nfs/localio.rst
> > 
> > Weston Andros Adamson (4):
> >   SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
> >   nfsd: add localio support
> >   nfs: pass struct file to nfs_init_pgio and nfs_init_commit
> >   nfs: add localio support
> > 
> >  Documentation/filesystems/nfs/localio.rst | 255 +++++++
> >  fs/Kconfig                                |   3 +
> >  fs/nfs/Kconfig                            |  15 +
> >  fs/nfs/Makefile                           |   1 +
> >  fs/nfs/client.c                           |  15 +-
> >  fs/nfs/filelayout/filelayout.c            |   6 +-
> >  fs/nfs/flexfilelayout/flexfilelayout.c    | 142 +++-
> >  fs/nfs/flexfilelayout/flexfilelayout.h    |   2 +
> >  fs/nfs/flexfilelayout/flexfilelayoutdev.c |   6 +
> >  fs/nfs/inode.c                            |  57 +-
> >  fs/nfs/internal.h                         |  61 +-
> >  fs/nfs/localio.c                          | 784 ++++++++++++++++++++++
> >  fs/nfs/nfs2xdr.c                          |  70 +-
> >  fs/nfs/nfs3xdr.c                          | 108 +--
> >  fs/nfs/nfs4xdr.c                          |  84 +--
> >  fs/nfs/nfstrace.h                         |  61 ++
> >  fs/nfs/pagelist.c                         |  16 +-
> >  fs/nfs/pnfs_nfs.c                         |   2 +-
> >  fs/nfs/write.c                            |  12 +-
> >  fs/nfs_common/Makefile                    |   5 +
> >  fs/nfs_common/common.c                    | 134 ++++
> >  fs/nfs_common/nfslocalio.c                | 194 ++++++
> >  fs/nfsd/Kconfig                           |  15 +
> >  fs/nfsd/Makefile                          |   1 +
> >  fs/nfsd/export.c                          |   8 +-
> >  fs/nfsd/filecache.c                       |  90 ++-
> >  fs/nfsd/filecache.h                       |   5 +
> >  fs/nfsd/localio.c                         | 183 +++++
> >  fs/nfsd/netns.h                           |   8 +-
> >  fs/nfsd/nfsctl.c                          |   2 +-
> >  fs/nfsd/nfsd.h                            |   6 +-
> >  fs/nfsd/nfsfh.c                           | 114 ++--
> >  fs/nfsd/nfsfh.h                           |   5 +
> >  fs/nfsd/nfssvc.c                          | 100 ++-
> >  fs/nfsd/trace.h                           |  39 +-
> >  fs/nfsd/vfs.h                             |  10 +
> >  include/linux/nfs.h                       |   9 +
> >  include/linux/nfs_common.h                |  17 +
> >  include/linux/nfs_fs_sb.h                 |  10 +
> >  include/linux/nfs_xdr.h                   |  20 +-
> >  include/linux/nfslocalio.h                |  56 ++
> >  include/linux/sunrpc/auth.h               |   4 +
> >  include/linux/sunrpc/svc.h                |   7 +-
> >  net/sunrpc/auth.c                         |  22 +
> >  net/sunrpc/clnt.c                         |   6 -
> >  net/sunrpc/svc.c                          |  68 +-
> >  net/sunrpc/svc_xprt.c                     |   2 +-
> >  net/sunrpc/svcauth_unix.c                 |   3 +-
> >  48 files changed, 2428 insertions(+), 415 deletions(-)
> >  create mode 100644 Documentation/filesystems/nfs/localio.rst
> >  create mode 100644 fs/nfs/localio.c
> >  create mode 100644 fs/nfs_common/common.c
> >  create mode 100644 fs/nfs_common/nfslocalio.c
> >  create mode 100644 fs/nfsd/localio.c
> >  create mode 100644 include/linux/nfs_common.h
> >  create mode 100644 include/linux/nfslocalio.h
> > 
> > -- 
> > 2.44.0
> > 
> > 
> 
> Hi Mike-
> 
> I've started familiarizing myself with v12. I'm happy to see that
> the fake svc_rqst code is gone, and I thank you, Neil, and Trond
> for your effort replacing that code.
> 
> I think I understand why we have to use an ephemeral garbage-
> collected nfsd_file rather than having the client hold one open
> while it has an open file descriptor for that file.
> 
> Next I want to start auditing the client's open path for security
> issues. I will hold any specific comments until I've done that.

Sounds good, thanks.

> It's great that Jeff has reviewed these already! I concur that a
> little patch re-organization will be helpful.

Sure, I just replied to Jeff.  I can do the work to rebase the use of
nfsd_file so that the series has it from the start if you agree it
best that way.  Please advise if you've noticed anything else that
stands out for me to handle at the same time.

Thanks,
Mike

