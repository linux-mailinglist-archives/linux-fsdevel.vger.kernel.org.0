Return-Path: <linux-fsdevel+bounces-49082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B5AB7B65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 04:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CE37B0CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 02:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60CB288516;
	Thu, 15 May 2025 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxm1PjfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4E64B1E44;
	Thu, 15 May 2025 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747274786; cv=none; b=LmbXApBD0lc60L15jfGdhSru6+Olk7kojD2qHNHqzXME4NhUzjVGga4rSC2rNuTKovYm1D7adetctWgm4JbnICR/wDTxQ2XaghDuYtOksVwUkKrW90vRBdohPgOf9tea+7Eyc1NzkqeXH1tvIVjYK5MYl6L6tArCpXYJKaVczuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747274786; c=relaxed/simple;
	bh=0s4aP+GUXSooXukpZbwoYjCRRnKU1I3gEARrmJir8Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obrOdxbltJIKMybUVwax4Bfy/KyIg18++zMpXGMPiChW1AJE1oowE6O8jNudqt5KVSNRB7X16KsvjiwGrW3duHVOTSKuOEDLtx0puEyHu7ifwtwPPZ9zJSomY9w8AGB2sHNTrIVQNmHhyWapZwowVELo/H5hC+tDVOL9EWhRDVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxm1PjfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85924C4CEE3;
	Thu, 15 May 2025 02:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747274785;
	bh=0s4aP+GUXSooXukpZbwoYjCRRnKU1I3gEARrmJir8Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxm1PjfWlSxmPpIXMVfETaA8OuYRSur6Ps9dBWi2N9q2pRj6enIo2XEBzRmoohzhn
	 cVA1Ud8dka8UNRuu5gc27gUmAEooIrqmlSHsvpDchkhy42rX/M12Ekb4nrlSmQlkqt
	 YFXjwBKS/5BFGB41NEIwpQCzl6NoMh5JFST9Gzra80W7wC+Yhw6KzLC54vEn+2Os09
	 KbvBUP325JH5Iyg6se3TA5IYgvmjD4k/IM79iSA3+EHKPV53v6DEMSWb3XC2BXfS3M
	 R3AUE/BYHwqSR04VjJaRl+WIDwDbW4ictpm8FuMJbpzVVjFIPfGfbb8x209cJ+qFA8
	 7bumzqpOSKidw==
Date: Wed, 14 May 2025 19:06:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <20250515020624.GP1035866@frogsfrogsfrogs>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
 <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
 <20250508155644.GM1035866@frogsfrogsfrogs>
 <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>

On Tue, May 13, 2025 at 11:14:55AM +0200, Miklos Szeredi wrote:
> On Thu, 8 May 2025 at 17:56, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Well right now my barely functional prototype exposes this interface
> > for communicating mappings to the kernel.  I've only gotten as far as
> > exposing the ->iomap_{begin,end} and ->iomap_ioend calls to the fuse
> > server with no caching, because the only functions I've implemented so
> > far are FIEMAP, SEEK_{DATA,HOLE}, and directio.
> >
> > So basically the kernel sends a FUSE_IOMAP_BEGIN command with the
> > desired (pos, count) file range to the fuse server, which responds with
> > a struct fuse_iomap_begin_out object that is translated into a struct
> > iomap.
> >
> > The fuse server then responds with a read mapping and a write mapping,
> > which tell the kernel from where to read data, and where to write data.
> 
> So far so good.
> 
> The iomap layer is non-caching, right?   This means that e.g. a
> direct_io request spanning two extents will result in two separate
> requests, since one FUSE_IOMAP_BEGIN can only return one extent.

Originally it wasn't supposed to be cached at all.  Then history taught
us a lesson. :P

In hindsight, there needs to be coordination of the space mapping
manipulations that go on between pagecache writes and reclaim writeback.
Pagecache write can get an unwritten iomap, then go to sleep while it
tries to get a folio.  In the meantime, writeback can find the folio for
that range, write it back to the disk (which converts unwritten to
written) and reclaim the folio.  Now the first process wakes up and
grabs a new folio.  Because its unwritten mapping is now stale, it must
not start zeroing that folio; it needs to go get a new mapping.

So iomap still doesn't need caching per se, but it needs writer threads
to revalidate the mapping after locking a folio.  The reason for caching
iomaps under the fuse_inode somewhere is that I don't want the
revalidations to have to jump all the way out to userspace with a folio
lock held.

That said, on a VM on this 12 year old workstation, I can get about
2.0GB/s direct writes in fuse2fs and 2.2GB/s in kernel ext4, and that's
with initiating iomap_begin/end/ioends with no caching of the mappings.
Pagecache writes run at about 1.9GB/s through fuse2fs and 1.5GB/s
through the kernel, but only if I tweak fuse to use large folios and a
relatively unconstrained bdi.  2GB/s might be enough IO for anyone. ;)

> And the next direct_io request may need to repeat the query for the
> same extent as the previous one if the I/O boundary wasn't on the
> extent boundary (which is likely).
> 
> So some sort of caching would make sense, but seeing the multitude of
> FUSE_IOMAP_OP_ types I'm not clearly seeing how that would look.

Yeah, it's confusing.  The design doc tries to clarify this, but this is
roughly what we need for fuse:

FUSE_IOMAP_OP_WRITE being set means we're writing to the file.
FUSE_IOMAP_OP_ZERO being set means we're zeroing the file.
Neither of those being set means we're reading the file.

(3 different operations)

FUSE_IOMAP_OP_DIRECT being set means directio, and it not being set
means pagecache.

(and one flag, for 6 different types of IO)

FUSE_IOMAP_OP_REPORT is set all by itself for things like FIEMAP and
SEEK_DATA/HOLE.

> > I'm a little confused, are you talking about FUSE_NOTIFY_INVAL_INODE?
> > If so, then I think that's the wrong layer -- INVAL_INODE invalidates
> > the page cache, whereas I'm talking about caching the file space
> > mappings that iomap uses to construct bios for disk IO, and possibly
> > wanting to invalidate parts of that cache to force the kernel to upcall
> > the fuse server for a new mapping.
> 
> Maybe I'm confused, as the layering is not very clear in my head yet.
> 
> But in your example you did say that invalidation of data as well as
> mapping needs to be invalidated, so I thought that the simplest thing
> to do is to just invalidate the cached mapping from
> FUSE_NOTIFY_INVAL_INODE as well.

For now I want to keep the two invalidation types separate while I build
out more of the prototype so that I can be more sure that I haven't
broken any existing code. :)

The mapping invalidation might be more useful for things like FICLONE on
weird filesystems where the file allocation unit size is larger than the
block size and we actually need to invalidate more mappings than the vfs
knows about.

But I'm only 80% sure of that, as I'm still figuring out how to create a
notification and send it from fuse2fs and haven't gotten to the caching
layer yet.

--D

> Thanks,
> Miklos
> 

