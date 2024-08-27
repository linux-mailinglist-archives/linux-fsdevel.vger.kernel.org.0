Return-Path: <linux-fsdevel+bounces-27415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA389614BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BCD285B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D501CDA3C;
	Tue, 27 Aug 2024 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggve4quv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0B1C27;
	Tue, 27 Aug 2024 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777804; cv=none; b=TtfMl/bCSbZ6mynXrrvhRh5HBywJj0jyk02JR2cs9NM6e7HTmJMpwqMcpc0KbjgDTZS4ksHDpnYM/FRjaU8OXuw+pdyo0Z8/CBDKG+pfS/PtHZsteAxT7lBSbPP5zbpA8n74xT2EelWr5JCPusp+khMEGXZ9PgG/ZV7eiGN6vbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777804; c=relaxed/simple;
	bh=b/axeEwU/RIkjHeSO5k7LR1slWZIaWCH+NXMzK1xRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGasRw1Rd+sqyXnMffsa39DawiPoIINtTrZ3LB+IwLWoBcyUY9ENftbtiIH7KXE+EXRQjpVs59D3/28zhFoMUoJyh6mKN4UURLBCS9J2yspX2OUfFsrMVJcWcOH5Wf6LpxYLH66Tk2/GA5clU2CQ4KW3VRini9xPS0P7Go91/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggve4quv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28D6C4DDE9;
	Tue, 27 Aug 2024 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724777804;
	bh=b/axeEwU/RIkjHeSO5k7LR1slWZIaWCH+NXMzK1xRQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ggve4quvap2JHEVy1TeHTgD33pntBKkURtsJ8J00awBmBldL5aSZx43Wb0YYtPz9m
	 /NqVDOr3uSjaERn+VCymQk3t2HQSDI0U0+4LB1aKsWgX8SKfz1gASODGsF00oAG8fH
	 /YzhO3ezUV/CiXSmFqeXr7lDyE47E12C2+M33my6cdrl3VA+WboBXH3QDxcInZjZUu
	 HC+zhAd5hgMmxpUmcJFUMQFJXpP3YFJB296b3LY/Y1Mvv1Ex9c5hyAxhUuq6/n+z8p
	 QoyB0kJ1nk99mqxC+dFJb3ILHLLbXShSWCNAX7oJMlYX2xfiMAJ7R4b7JdVAanBjQB
	 a2K8yOW1eKD1g==
Date: Tue, 27 Aug 2024 12:56:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 00/19] nfs/nfsd: add support for localio
Message-ID: <Zs4FSgwOqbqt6JYJ@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
 <ZstRwsA1AGRVzFbF@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZstRwsA1AGRVzFbF@tissot.1015granger.net>

On Sun, Aug 25, 2024 at 11:46:10AM -0400, Chuck Lever wrote:
> On Fri, Aug 23, 2024 at 02:13:58PM -0400, Mike Snitzer wrote:
> > These latest changes are available in my git tree here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > Changes since v12:
> > - Rebased to rearrange code to avoid "churn" that Jeff Layton felt
> >   distracting (biggest improvement came from folding switch from
> >   struct file to nfsd_file changes in from the start of the series)
> > - Updated relevant patch headers accordingly.
> > - Updated localio.rst to provide more performance data.
> > - Dropped v12's buggy "nfsd: fix nfsfh tracepoints to properly handle
> >   NULL rqstp" patch -- fixing localio to support fh_verify tracepoints
> >   will need more think-time and discussion, but they aren't of
> >   critical importance so fixing them doesn't need to hold things up.
> > 
> > Please also see v12's patch header for v12's extensive changes:
> > https://marc.info/?l=linux-nfs&m=172409139907981&w=2
> > 
> > Thanks,
> > Mike
> > 
> > Mike Snitzer (9):
> >   nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
> >   nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
> >   nfs: factor out {encode,decode}_opaque_fixed to nfs_xdr.h
> >   SUNRPC: remove call_allocate() BUG_ONs
> >   nfs_common: add NFS LOCALIO auxiliary protocol enablement
> >   nfsd: implement server support for NFS_LOCALIO_PROGRAM
> >   nfs: pass struct nfsd_file to nfs_init_pgio and nfs_init_commit
> >   nfs: implement client support for NFS_LOCALIO_PROGRAM
> >   nfs: add Documentation/filesystems/nfs/localio.rst
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
> > Weston Andros Adamson (3):
> >   SUNRPC: add rpcauth_map_clnt_to_svc_cred_local
> >   nfsd: add localio support
> >   nfs: add localio support
> > 
> >  Documentation/filesystems/nfs/localio.rst | 276 ++++++++
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
> >  fs/nfsd/nfsfh.c                           | 122 ++--
> >  fs/nfsd/nfsfh.h                           |   5 +
> >  fs/nfsd/nfssvc.c                          | 100 ++-
> >  fs/nfsd/trace.h                           |   3 +-
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
> >  48 files changed, 2434 insertions(+), 402 deletions(-)
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
> 
> I've looked over the NFSD changes in this patch set. Some of them
> look ready to go (I've Acked those), others still need a little TLC.
> 
> For me, the big picture questions that remain are:
> 
> * How do we ensure that export options that modify RPC user
>   translation (eg, all_squash) continue to work as expected on
>   LOCALIO mounts?
> 
> * How do we ensure that a "stolen" FH can't be exploited by an NFS
>   client running in a local container that does not have access to
>   an export (server should return NFSERR_STALE)?
> 
> * Has LOCALIO been tested with two or more NFS servers running on
>   the local system? One assumes they would be in separate
>   containers.
> 
> The scenario I'm thinking of is two tenants, Pepsi and Coke, running
> in containers on the same physical host. They might want their own
> separate NFS servers, or they might share one server with
> appropriate access controls on the exports. Both of these scenarios
> need to ensure that Pepsi and Coke cannot open each other's files
> via LOCALIO.

Each server instance is isolated in their respective nfsd_net.  And
localio was made to build on that isolation.  So all creds used, etc
are specific to each nfsd instance.

I haven't verified these scenarios "just work" as expected but localio
preserves all the same checking and upcalls of standard NFS uses.

Mike

