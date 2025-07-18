Return-Path: <linux-fsdevel+bounces-55458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF2B0AA14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 20:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F8B1C80A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154728850F;
	Fri, 18 Jul 2025 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C35Fft2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5D17A2F5
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752862935; cv=none; b=Ik7lxNr97FdULxgG5SIwEAz2xIc7W6Qq16DRMcSqs7mvXSHfaZSx4hLamcXi+TCGH3tOwCrhgSbdAc5vffL2q0AwH3uEzcJ0MNfV8W+1nQS/ODnP0SxNv360uoZqJNePm/h7wNb3u+1T9iWRV8vCY4SeSHhm1722cBL5pes93RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752862935; c=relaxed/simple;
	bh=7rozM/Gsq1+akY/amRVUS0dgp/o6STB4pcYIXJM5x80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6vri3iT2Tc2lM55lJJEN0TJenS2N4U4sTB4RlMSAn8BqWccECnmwVyZHJ3yvHySWWsBvCueDQXNEgJDgAzLwmHhDEtXzuJmqzyy/BpTRSjcFLYkf5gfOnr7h9QMpIH4z0bO9PW6X1bvO6je4dkB9fy0HxbIQGf/wHddA/7Wxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C35Fft2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7284CC4CEEB;
	Fri, 18 Jul 2025 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752862934;
	bh=7rozM/Gsq1+akY/amRVUS0dgp/o6STB4pcYIXJM5x80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C35Fft2TqL4uWDhl5zDMTGNUI1bcnWscJ4B+jS+8AO4zQlafF7jNrNJ87NpqRuVGx
	 2b99yRjXX3PfQWVm00VN480vhHLkr4ciD1ztDup+98b7EyVTZNJYsjcAwZs5aMq5X4
	 rGV965vV5WsPvjICQvJI1iGGq/S3OOGev3aUhP2iOo1/tNpKMRzNCB4fd7zw/ntink
	 DXnwtYBjYXb8VtlJzisnxJ3eawQJph56q/2YvkqnnZjjwRImy6MLU2Y39X5HFCVbRH
	 giUmq7f9aiYM1N2J98x5RViSugVHqZu3FlLFdxfnIRoFP1sI9bD5KrNoMM0o9BJos4
	 Z0F2B2RQGUTLw==
Date: Fri, 18 Jul 2025 11:22:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: "John@groves.net" <John@groves.net>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>
Subject: Re: [PATCH 1/1] libfuse: enable iomap cache management
Message-ID: <20250718182213.GX2672029@frogsfrogsfrogs>
References: <175279460162.714730.17358082513177016895.stgit@frogsfrogsfrogs>
 <175279460180.714730.8674508220056498050.stgit@frogsfrogsfrogs>
 <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573af180-296d-4d75-a43d-eb0825ed9af8@ddn.com>

On Fri, Jul 18, 2025 at 04:16:28PM +0000, Bernd Schubert wrote:
> On 7/18/25 01:38, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add the library methods so that fuse servers can manage an in-kernel
> > iomap cache.  This enables better performance on small IOs and is
> > required if the filesystem needs synchronization between pagecache
> > writes and writeback.
> 
> Sorry, if this ready to be merged? I don't see in linux master? Or part
> of your other patches (will take some to go through these).

No, everything you see in here is all RFC status and not for merging.
We're past -rc6, it's far too late to be trying to get anything new
merged in the kernel.

Though I say that as a former iomap maintainer who wouldn't take big
core code changes after -rc4 or XFS changes after -rc6.  I think I was
much more conservative about that than most maintainers. :)

(The cover letter yells very loudly about do not merge any of this,
btw.)

> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_common.h   |    9 +++++
> >  include/fuse_kernel.h   |   34 +++++++++++++++++++
> >  include/fuse_lowlevel.h |   39 ++++++++++++++++++++++
> >  lib/fuse_lowlevel.c     |   82 +++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/fuse_versionscript  |    2 +
> >  5 files changed, 166 insertions(+)
> > 
> > 
> > diff --git a/include/fuse_common.h b/include/fuse_common.h
> > index 98cb8f656efd13..1237cc2656b9c4 100644
> > --- a/include/fuse_common.h
> > +++ b/include/fuse_common.h
> > @@ -1164,6 +1164,7 @@ int fuse_convert_to_conn_want_ext(struct fuse_conn_info *conn);
> >   */
> >  #if FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 18)
> >  #define FUSE_IOMAP_TYPE_PURE_OVERWRITE	(0xFFFF) /* use read mapping data */
> > +#define FUSE_IOMAP_TYPE_NULL		(0xFFFE) /* no mapping here */
> >  #define FUSE_IOMAP_TYPE_HOLE		0	/* no blocks allocated, need allocation */
> >  #define FUSE_IOMAP_TYPE_DELALLOC	1	/* delayed allocation blocks */
> >  #define FUSE_IOMAP_TYPE_MAPPED		2	/* blocks allocated at @addr */
> > @@ -1208,6 +1209,11 @@ struct fuse_iomap {
> >  	uint32_t dev;		/* device cookie */
> >  };
> >  
> > +struct fuse_iomap_inval {
> > +	uint64_t offset;	/* file offset to invalidate, bytes */
> > +	uint64_t length;	/* length to invalidate, bytes */
> > +};
> > +
> >  /* out of place write extent */
> >  #define FUSE_IOMAP_IOEND_SHARED		(1U << 0)
> >  /* unwritten extent */
> > @@ -1258,6 +1264,9 @@ struct fuse_iomap_config{
> >  	int64_t s_maxbytes;	/* max file size */
> >  };
> >  
> > +/* invalidate to end of file */
> > +#define FUSE_IOMAP_INVAL_TO_EOF		(~0ULL)
> > +
> >  #endif /* FUSE_USE_VERSION >= 318 */
> >  
> >  /* ----------------------------------------------------------- *
> > diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> > index 3c704f03434693..f1a93dbd1ff443 100644
> > --- a/include/fuse_kernel.h
> > +++ b/include/fuse_kernel.h
> > @@ -243,6 +243,8 @@
> >   *  - add FUSE_IOMAP_DIRECTIO/FUSE_ATTR_IOMAP_DIRECTIO for direct I/O support
> >   *  - add FUSE_IOMAP_FILEIO/FUSE_ATTR_IOMAP_FILEIO for buffered I/O support
> >   *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
> > + *  - add FUSE_NOTIFY_IOMAP_UPSERT and FUSE_NOTIFY_IOMAP_INVAL so fuse servers
> > + *    can cache iomappings in the kernel
> 
> 
> Personally I prefer a preparation patch, that just syncs the entire
> fuse_kernel.h from linux-<version>.

<nod>

>                                     Also this file might get renamed to
> fuse_kernel_linux.h, there seems to be interest from BSD and OSX to have
> their own headers.

That's a good idea.

> >   */
> >  
> >  #ifndef _LINUX_FUSE_H
> > @@ -699,6 +701,8 @@ enum fuse_notify_code {
> >  	FUSE_NOTIFY_DELETE = 6,
> >  	FUSE_NOTIFY_RESEND = 7,
> >  	FUSE_NOTIFY_INC_EPOCH = 8,
> > +	FUSE_NOTIFY_IOMAP_UPSERT = 9,
> > +	FUSE_NOTIFY_IOMAP_INVAL = 10,
> >  	FUSE_NOTIFY_CODE_MAX,
> >  };
> >  
> > @@ -1406,4 +1410,34 @@ struct fuse_iomap_config_out {
> >  	int64_t s_maxbytes;	/* max file size */
> >  };
> >  
> > +struct fuse_iomap_upsert_out {
> > +	uint64_t nodeid;	/* Inode ID */
> > +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> > +
> > +	uint64_t read_offset;	/* file offset of mapping, bytes */
> > +	uint64_t read_length;	/* length of mapping, bytes */
> > +	uint64_t read_addr;	/* disk offset of mapping, bytes */
> > +	uint16_t read_type;	/* FUSE_IOMAP_TYPE_* */
> > +	uint16_t read_flags;	/* FUSE_IOMAP_F_* */
> > +	uint32_t read_dev;	/* device cookie */
> > +
> > +	uint64_t write_offset;	/* file offset of mapping, bytes */
> > +	uint64_t write_length;	/* length of mapping, bytes */
> > +	uint64_t write_addr;	/* disk offset of mapping, bytes */
> > +	uint16_t write_type;	/* FUSE_IOMAP_TYPE_* */
> > +	uint16_t write_flags;	/* FUSE_IOMAP_F_* */
> > +	uint32_t write_dev;	/* device cookie * */
> > +};
> > +
> > +struct fuse_iomap_inval_out {
> > +	uint64_t nodeid;	/* Inode ID */
> > +	uint64_t attr_ino;	/* matches fuse_attr:ino */
> > +
> > +	uint64_t read_offset;	/* range to invalidate read iomaps, bytes */
> > +	uint64_t read_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
> > +
> > +	uint64_t write_offset;	/* range to invalidate write iomaps, bytes */
> > +	uint64_t write_length;	/* can be FUSE_IOMAP_INVAL_TO_EOF */
> > +};
> > +
> >  #endif /* _LINUX_FUSE_H */
> > diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
> > index fd7df5c2c11e16..f690c62fcdd61c 100644
> > --- a/include/fuse_lowlevel.h
> > +++ b/include/fuse_lowlevel.h
> > @@ -2101,6 +2101,45 @@ int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
> >   * @return positive device id for success, zero for failure
> >   */
> >  int fuse_iomap_add_device(struct fuse_session *se, int fd, unsigned int flags);
> > +
> > +/**
> > + * Upsert some file mapping information into the kernel.  This is necessary
> > + * for filesystems that require coordination of mapping state changes between
> > + * buffered writes and writeback, and desirable for better performance
> > + * elsewhere.
> > + *
> > + * Added in FUSE protocol version 7.99. If the kernel does not support
> 
> 7.99?

I set the minor versions to 99 and just today did the same thing for
libfuse itself ("3.99") to make it obvious where all the code changes
lie.  When these patches are ready for merging I'll rework them to pick
up whatever version of libfuse is current.

Doing so reduces rebasing collisions when others' ABI changes get merged
upstream.  I've found it a useful trick/crutch for a patchset that I
think is going to take a long time to get integrated.  See previous
comments about being a former XFS maintainer. ;)

--D

> 
> 
> Thanks,
> Bernd

