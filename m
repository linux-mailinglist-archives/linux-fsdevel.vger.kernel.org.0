Return-Path: <linux-fsdevel+bounces-71502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FACC5A7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B5A63030748
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 01:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F11F790F;
	Wed, 17 Dec 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM+YJTKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B203A1E7F;
	Wed, 17 Dec 2025 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765933249; cv=none; b=G2pn9DFfjAquaG/7T5nu4eemngGU8QocmaWFQLeg/X1VpIbPQllY5Uiw65sHxSuhM2ndHoU1/tpcQFGvKrggpkl5QKQ9AWKq/UqVBmMShu2JFKtlOamOWgh2XeHsaPPgqCzfbO3ZZbnWgn5tT3iLHSKqZZz9lh6HeyIPqcJhZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765933249; c=relaxed/simple;
	bh=dgggENlKh4mJ53gpBBwYNHiyOTvO3dQG5j5ykHQWCQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB+lF8VW9mcTGn75zXhfGn2snZPkgwkM6rEOQOI4+cAQbfmpz1QpnqNISjn2E+lN4PkNLlyApsJpCFvIMD1Bi0y2fMRiQxhOyq0x1e4ISxfefzLJcfmyaMYTA3JPUZ2+08FXgwra3xF/dV75pl+N3YoZZcJi1Vh+hLBbGvjUA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM+YJTKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF592C4CEF1;
	Wed, 17 Dec 2025 01:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765933246;
	bh=dgggENlKh4mJ53gpBBwYNHiyOTvO3dQG5j5ykHQWCQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RM+YJTKTtbI8oJ85RTKIddkYtBkzz5O7T7hFk+AZUwt5y77oiPm8ZhueIfehgtfMZ
	 utCDYohL2Hjij3rDSY0iXe1e9Lqz6qHHJhXtoluSk2ePV8k3r5vsZTsLAFbkvzOcyM
	 ICRy3c+z97MexmiCCgXqjnBN0GFnGmt1X4Q+UlnZyNW5vrkWQcb+PhTKMPT93tunq6
	 vE12LnFO3VHIH1vmuyRaEZSyeYe42GhCXUZRd+AYg4AwES3Z9/I/je01WTYM3RdXnc
	 fdPeUHTEjFPHLGyWw91V0x/G3ZiD7sc/taYOndZagwxXneIG/NdAJTRUHH+aPQqhDx
	 EW24kJlujiBsQ==
Date: Tue, 16 Dec 2025 17:00:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Matt Harvey <mharvey@jumptrading.com>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
Message-ID: <20251217010046.GC7705@frogsfrogsfrogs>
References: <20251212181254.59365-1-luis@igalia.com>
 <20251212181254.59365-5-luis@igalia.com>
 <CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
 <0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
 <CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>

On Wed, Dec 17, 2025 at 08:32:02AM +0800, Joanne Koong wrote:
> On Tue, Dec 16, 2025 at 4:54 PM Bernd Schubert <bschubert@ddn.com> wrote:
> >
> > On 12/16/25 09:49, Joanne Koong wrote:
> > > On Sat, Dec 13, 2025 at 2:14 AM Luis Henriques <luis@igalia.com> wrote:
> > >>
> > >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to include
> > >> an extra inarg: the file handle for the parent directory (if it is
> > >> available).  Also, because fuse_entry_out now has a extra variable size
> > >> struct (the actual handle), it also sets the out_argvar flag to true.
> > >>
> > >> Most of the other modifications in this patch are a fallout from these
> > >> changes: because fuse_entry_out has been modified to include a variable size
> > >> struct, every operation that receives such a parameter have to take this
> > >> into account:
> > >>
> > >>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFILE
> > >>
> > >> Signed-off-by: Luis Henriques <luis@igalia.com>
> > >> ---
> > >>  fs/fuse/dev.c             | 16 +++++++
> > >>  fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++---------
> > >>  fs/fuse/fuse_i.h          | 34 +++++++++++++--
> > >>  fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
> > >>  fs/fuse/readdir.c         | 10 ++---
> > >>  include/uapi/linux/fuse.h |  8 ++++
> > >>  6 files changed, 189 insertions(+), 35 deletions(-)
> > >>
> > >
> > > Could you explain why the file handle size needs to be dynamically set
> > > by the server instead of just from the kernel-side stipulating that
> > > the file handle size is FUSE_HANDLE_SZ (eg 128 bytes)? It seems to me
> > > like that would simplify a lot of the code logic here.
> >
> > It would be quite a waste if one only needs something like 12 or 16
> > bytes, wouldn't it? 128 is the upper limit, but most file systems won't
> > need that much.
> 
> Ah, I was looking at patch 5 + 6 and thought the use of the lookup
> handle was for servers that want to pass it to NFS. But just read
> through the previous threads and see now it's for adding server
> restart. That makes sense, thanks for clarifying.

<-- wakes up from his long slumber

Why wouldn't you use the same handle format for NFS and for fuse server
restarts?  I would think that having separate formats would cause type
confusion and friction.

But that said, the fs implementation (fuse server) gets to decide the
handle format it uses, because they're just binary blobcookies to the
clients.  I think that's why the size is variable.

(Also I might be missing some context, if fuse handles aren't used in
the same places as nfs handles...)

--D

> Thanks,
> Joanne
> 
> >
> >
> > Thanks,
> > Bernd
> 

