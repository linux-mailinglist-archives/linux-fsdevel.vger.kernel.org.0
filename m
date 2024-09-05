Return-Path: <linux-fsdevel+bounces-28787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42D96E350
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CFB1C23FD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE218FDDC;
	Thu,  5 Sep 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzyzhkte"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FF18A6B0;
	Thu,  5 Sep 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725565083; cv=none; b=V1/hXLm2FwqEakd32GSoprYoIEygz7jhJgdQrnW4Vl74BRWiSEEeunuYi5fnZJPel/2hT84aIPW5n7T106YIoZfdB57Dcl1fB9FSIXCjeI1PDAytwCtKTQHtetMb6gX+XAI0Ymt1gmAPNN/YLkiNJ7ZEi9KYVf1bLlVTt8kcjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725565083; c=relaxed/simple;
	bh=lVx2FJzKGyCjMvdz8i5WRQMWkAvE1xq/AnkA2cTn4nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+QxJenP/bk0LqvFfgR6JGtna5TZxuYIOl4wwA+Z/ZoOr3wBpWb+EC5E+wuxaPb712MD1X+gs7KRm1JcpjwCGg2zw668AraRw+ybwTeUQOLkYMFvvjgu70LiqyKHjoeMMUHUTLF7OBdEbGYVwHNlFo37FlUzU1jmFDnMeLvFQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzyzhkte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE9AC4CEC3;
	Thu,  5 Sep 2024 19:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725565083;
	bh=lVx2FJzKGyCjMvdz8i5WRQMWkAvE1xq/AnkA2cTn4nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bzyzhktefi/fppyPGoJRwD/yFYBzCDvaNf/zgFK3Gldq4o8uiWDErOe9twJ2ORFrz
	 nCjpx0EC8/cSq4xybK7DL2xeQvy59PEOKcnXIJ5/tvVM5Qlj7fCD949z+9BPwC/RKV
	 IhseQNph/Ieq3gGS3lwxnpf5X/yQtIiZgHjzDZBeGSMb5p3JYOEweqz2pR8Sjkgpbl
	 lTD11lKuVvIVhSzxx0+ZLnT1atS0b9Tpp387ibTEn69Cvi7jBzwoCw7yOuYmbkG0Nv
	 Xfx1lvyV3MleMKsaVTzxCEcGNPSbL5+2GJOJKqQoe2e9BmEem7pJcvKZtevjp/BOZX
	 5CVaQlPHKfRRQ==
Date: Thu, 5 Sep 2024 15:38:01 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 14/26] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
Message-ID: <ZtoImdAHDdm6PQ-v@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <20240831223755.8569-15-snitzer@kernel.org>
 <CAFX2Jf=chLdC-eip0JFbtjE+2pDq7G1vbRunB4OD2ZRd2=sDVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2Jf=chLdC-eip0JFbtjE+2pDq7G1vbRunB4OD2ZRd2=sDVQ@mail.gmail.com>

On Thu, Sep 05, 2024 at 03:24:06PM -0400, Anna Schumaker wrote:
> On Sat, Aug 31, 2024 at 6:38 PM Mike Snitzer <snitzer@kernel.org> wrote:
> >
> > fs/nfs_common/nfslocalio.c provides interfaces that enable an NFS
> > client to generate a nonce (single-use UUID) and associated
> > short-lived nfs_uuid_t struct, register it with nfs_common for
> > subsequent lookup and verification by the NFS server and if matched
> > the NFS server populates members in the nfs_uuid_t struct.
> >
> > nfs_common's nfs_uuids list is the basis for localio enablement, as
> > such it has members that point to nfsd memory for direct use by the
> > client (e.g. 'net' is the server's network namespace, through it the
> > client can access nn->nfsd_serv).
> >
> > This commit also provides the base nfs_uuid_t interfaces to allow
> > proper net namespace refcounting for the LOCALIO use case.
> >
> > CONFIG_NFS_LOCALIO controls the nfs_common, NFS server and NFS client
> > enablement for LOCALIO. If both NFS_FS=m and NFSD=m then
> > NFS_COMMON_LOCALIO_SUPPORT=m and nfs_localio.ko is built (and provides
> > nfs_common's LOCALIO support).
> >
> >   # lsmod | grep nfs_localio
> >   nfs_localio            12288  2 nfsd,nfs
> >   sunrpc                745472  35 nfs_localio,nfsd,auth_rpcgss,lockd,nfsv3,nfs
> >
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Co-developed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/Kconfig                 |  23 ++++++++
> >  fs/nfs_common/Makefile     |   3 +
> >  fs/nfs_common/nfslocalio.c | 116 +++++++++++++++++++++++++++++++++++++
> >  include/linux/nfslocalio.h |  36 ++++++++++++
> >  4 files changed, 178 insertions(+)
> >  create mode 100644 fs/nfs_common/nfslocalio.c
> >  create mode 100644 include/linux/nfslocalio.h
> >
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index a46b0cbc4d8f..24d4e4b419d1 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -382,6 +382,29 @@ config NFS_COMMON
> >         depends on NFSD || NFS_FS || LOCKD
> >         default y
> >
> > +config NFS_COMMON_LOCALIO_SUPPORT
> > +       tristate
> > +       default n
> > +       default y if NFSD=y || NFS_FS=y
> > +       default m if NFSD=m && NFS_FS=m
> > +       select SUNRPC
> > +
> > +config NFS_LOCALIO
> > +       bool "NFS client and server support for LOCALIO auxiliary protocol"
> > +       depends on NFSD && NFS_FS
> > +       select NFS_COMMON_LOCALIO_SUPPORT
> > +       default n
> > +       help
> > +         Some NFS servers support an auxiliary NFS LOCALIO protocol
> > +         that is not an official part of the NFS protocol.
> > +
> > +         This option enables support for the LOCALIO protocol in the
> > +         kernel's NFS server and client. Enable this to permit local
> > +         NFS clients to bypass the network when issuing reads and
> > +         writes to the local NFS server.
> > +
> > +         If unsure, say N.
> > +
> 
> I'm wondering if it would make sense to create a fs/nfs_common/Kconfig
> file at some point (not as part of this patchset!) to hold this group
> of nfs_common options and to tidy up this section of the fs/Kconfig
> file.
> 
> Thoughts?
> Anna

Yes, I think that makes sense.

Mike

