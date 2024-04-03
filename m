Return-Path: <linux-fsdevel+bounces-16066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429FA89780D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C161F211E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0815359C;
	Wed,  3 Apr 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+29GNYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DB1534F2;
	Wed,  3 Apr 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168423; cv=none; b=d3kIdxCAOuFa0DeSN7rvkik4XmGI0WQTEpR88mN87M9jfTqeGJH820alJhpf40W6/4gh3mOaOd5del3F4eD5IlsrjN99DmYN0+ZmlBo08dLXu3Nd7+zaXdmE+MhmdvTbypFOVOnaaGTVUgWfvqh60+IdVukcJqfzSsnTgp9/Lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168423; c=relaxed/simple;
	bh=dKvQPTXecftDT+DnIIwHEnA6Z/BLqGb2biglQSFhZeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFF09ngcyZrLXNbFYKmRaiIN5pUx8GAsiWaR/J2LlSJ+NU9IZ7ESKCQojkdKV+XDXMEDjWtmmHbCO0WWkBcPhK3tGVsVW3BCnnDOV4EhgJnnB41ZW364t+9VDLSufvs6pGmC02vXX2WfFBZNsr1WPbcjJouduXnquQUawrsnq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+29GNYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30722C433C7;
	Wed,  3 Apr 2024 18:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712168423;
	bh=dKvQPTXecftDT+DnIIwHEnA6Z/BLqGb2biglQSFhZeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+29GNYuQx0VUmcsHNAcViKqPDDq3ZFBXvXQk8i5X/Ng9rS0Nn5TR2ZFKpItLWJoz
	 AxQT8f9QGCIMrVhK1tfOsWr/ibXybNTHcuh13+EwHlmZmzl6cHhaXAIJFA2kXoY8nj
	 Eb9fEuRHhhO+5iGTBPB7lLoN0d0TNvxS1vVTWNROU6LwDNr45oZ1dar1YVARAXcn8w
	 LqRoDraupidvfHDGwIQvORPlSb6lScoO5H1ipbe0TmVYlxpqNjDw0D5fFjn1h/DyZj
	 FFLK6Xci6djMMnMU73EvCh8gOPGDnRrFucf6kgrgZvpN41PbVwUI0e2bWiNpZ+LDQT
	 6+Do0ENej/RcQ==
Date: Wed, 3 Apr 2024 11:20:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Jonathan Corbet <corbet@lwn.net>, Brian Foster <bfoster@redhat.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
Message-ID: <20240403182022.GB6375@frogsfrogsfrogs>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <vf4k3yagvb6vf3vfu7st7uj7asv4zbf5c3b2tef2g2xic5fkvj@olqxfakmkoew>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vf4k3yagvb6vf3vfu7st7uj7asv4zbf5c3b2tef2g2xic5fkvj@olqxfakmkoew>

On Wed, Apr 03, 2024 at 02:17:26PM -0400, Kent Overstreet wrote:
> On Wed, Apr 03, 2024 at 03:22:41AM -0400, Sweet Tea Dorminy wrote:
> > For many years, various btrfs users have written programs to discover
> > the actual disk space used by files, using root-only interfaces.
> > However, this information is a great fit for fiemap: it is inherently
> > tied to extent information, all filesystems can use it, and the
> > capabilities required for FIEMAP make sense for this additional
> > information also.
> > 
> > Hence, this patchset adds various additional information to fiemap,
> > and extends filesystems (but not iomap) to return it.  This uses some of
> > the reserved padding in the fiemap extent structure, so programs unaware
> > of the changes will be unaffected.
> > 
> > This is based on next-20240403. I've tested the btrfs part of this with
> > the standard btrfs testing matrix locally and manually, and done minimal
> > testing of the non-btrfs parts.
> > 
> > I'm unsure whether btrfs should be returning the entire physical extent
> > referenced by a particular logical range, or just the part of the
> > physical extent referenced by that range. The v2 thread has a discussion
> > of this.
> 
> I believe there was some talk of using the padding for a device ID, so
> that fiemap could properly support multi device filesystems. Are we sure
> this is the best use of those bytes?

We still have 5x u32 of empty space in struct fiemap after this series,
so I don't think adding the physical length is going to prohibit future
expansion.

--D

> > 
> > Changelog:
> > 
> > v3: 
> >  - Adapted all the direct users of fiemap, except iomap, to emit
> >    the new fiemap information, as far as I understand the other
> >    filesystems.
> > 
> > v2:
> >  - Adopted PHYS_LEN flag and COMPRESSED flag from the previous version,
> >    as per Andreas Dilger' comment.
> >    https://patchwork.ozlabs.org/project/linux-ext4/patch/4f8d5dc5b51a43efaf16c39398c23a6276e40a30.1386778303.git.dsterba@suse.cz/
> >  - https://lore.kernel.org/linux-fsdevel/cover.1711588701.git.sweettea-kernel@dorminy.me/T/#t
> > 
> > v1: https://lore.kernel.org/linux-fsdevel/20240315030334.GQ6184@frogsfrogsfrogs/T/#t
> > 
> > Sweet Tea Dorminy (13):
> >   fs: fiemap: add physical_length field to extents
> >   fs: fiemap: update fiemap_fill_next_extent() signature
> >   fs: fiemap: add new COMPRESSED extent state
> >   btrfs: fiemap: emit new COMPRESSED state.
> >   btrfs: fiemap: return extent physical size
> >   nilfs2: fiemap: return correct extent physical length
> >   ext4: fiemap: return correct extent physical length
> >   f2fs: fiemap: add physical length to trace_f2fs_fiemap
> >   f2fs: fiemap: return correct extent physical length
> >   ocfs2: fiemap: return correct extent physical length
> >   bcachefs: fiemap: return correct extent physical length
> >   f2fs: fiemap: emit new COMPRESSED state
> >   bcachefs: fiemap: emit new COMPRESSED state
> > 
> >  Documentation/filesystems/fiemap.rst | 35 ++++++++++----
> >  fs/bcachefs/fs.c                     | 17 +++++--
> >  fs/btrfs/extent_io.c                 | 72 ++++++++++++++++++----------
> >  fs/ext4/extents.c                    |  3 +-
> >  fs/f2fs/data.c                       | 36 +++++++++-----
> >  fs/f2fs/inline.c                     |  7 +--
> >  fs/ioctl.c                           | 11 +++--
> >  fs/iomap/fiemap.c                    |  2 +-
> >  fs/nilfs2/inode.c                    | 18 ++++---
> >  fs/ntfs3/frecord.c                   |  7 +--
> >  fs/ocfs2/extent_map.c                | 10 ++--
> >  fs/smb/client/smb2ops.c              |  1 +
> >  include/linux/fiemap.h               |  2 +-
> >  include/trace/events/f2fs.h          | 10 ++--
> >  include/uapi/linux/fiemap.h          | 34 ++++++++++---
> >  15 files changed, 178 insertions(+), 87 deletions(-)
> > 
> > 
> > base-commit: 75e31f66adc4c8d049e8aac1f079c1639294cd65
> > -- 
> > 2.43.0
> > 
> 

