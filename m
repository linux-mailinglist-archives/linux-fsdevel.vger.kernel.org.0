Return-Path: <linux-fsdevel+bounces-19995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49E8CBF1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 12:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCF31C21839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C06823C3;
	Wed, 22 May 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc/S/X5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD087C097;
	Wed, 22 May 2024 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372981; cv=none; b=fWBL98WJfrZ9f3hmViD29PkUOA4htLzpX1y7mQh2hy4EbRLtm9h95vkVHnYWpQz6FOH6JJhlGkzus+JpFjJmXt8z34a5F1MWE+tu5hjuNLzbfdl1OmbbT3gez+DAMRzn9Cw9tQHlehyUFCFLoWs56EABWC7wCuPZOFSXYIxjkrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372981; c=relaxed/simple;
	bh=FAVUAWEuXJC3xocw/jVzmYDvy/HjG5VjlA6XGaROGto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5DwVReDC3RYoznOCaZGjfRzfV3Ngbm+J0xLC9o5Txm5RfvEscCHEaXljxR6rlsCmF3/xiYGLfS/kfX1hImLgpTld2Ltdb1XCaoTkgIalnQU+HedB6+oTLGCnWtqtzxphUlp0zqVbw6dQK1vkSJwsps37diHYTPhCaRNY0DOgRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc/S/X5g; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61bb219737dso50794377b3.2;
        Wed, 22 May 2024 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716372978; x=1716977778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFE7goOcsig+5kjm4mwdw1ou6tsRmyL7x364k4UdXRM=;
        b=cc/S/X5gGXOzgSkt1to9TcKLa2GQXBZWYL7ruQNuxvzPJrK27r/+VZGTKY3P+IWsmy
         d5pL+W6atx6IbAGmNrl0NE1OPpD4o2F2YpMriMhplBI92pQj3EtGFpbuIUAZAPQnOd9H
         D8qJYOrJeoMI9E6hY03oqsTKUhg4pgLWAJ6EMuGPVX5iu3PZgIyq/qP+XO1SsEGWNXgm
         hI73xXwJYq5gFTe6n9EKStyb86GV0ZrGZi2ko7AVA8BbTcSey/hEq2KmKDEU5caldpxa
         1ba6iRLdpv2bn0Ff5J9MtOo5Sxaz496P/WyqcSJLL2GGwat1o2H4BJa7Hp/b17VxVq7M
         gplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372978; x=1716977778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFE7goOcsig+5kjm4mwdw1ou6tsRmyL7x364k4UdXRM=;
        b=q8JGb7HxwlFDPEyEWMCUuYndVBib3m9gXoS1N9hL1s7XtWDLxDJvazS5JIruoL9cqs
         v3IcnixVeEJurfMsUrapqhuqNBSr8xoTPtpvbofkUVAJOdTwQTrGuHCqImKqJitkLNhN
         Y9aRU7g2s11cj1t4+3F1htTzGOZODY42FufIYUi6OTZCXJ3kjJCt/ldWnyHHH91eLwtl
         UPXxW5zuvbVB05rau2g02ANxhAUanIfgVw4sh+Wmk3GxasBbLb+TF25S5bF1YTwOUEDH
         oH9xfxMfim3GlXSmA6DZYhF1N/eeUZEWIzzGrmzlKxEPLEy0sSqew4oPIzFMe1HkYy2N
         wLtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVMnLdC9PcQRIUx3vqB7Q14owQgAQ6tpIOGua1qgtkcX5to94V4Eu2k1thwEkN34Js4NgI2CUQSq+mHopOYHwVWhz5buhv0KmQoyHoUcoRIoHe+8wcuz2FVp/o9nVnvfDSxGsWNIh/oEZztCrSV+uuV5ePxLYTzucRPk0Jj/IXTU/GGOjvbbuuFsZpFxTCLNBidxMBA2jut9z8N5dFiFcPyA==
X-Gm-Message-State: AOJu0YyQEsGGV7Sc3V10IhI70ve+3rDDK9OEF8iomMiX92ksCXsa2Ye1
	RTIJD2IYbYcFgoIEWwjG+6u0y616MiUMUilmh80PtVVXxVuQ6S9VVkrtj3M+q/RTFcuZjLWgWiZ
	1GtsqEpLr20JopxKrYud19iBqENg=
X-Google-Smtp-Source: AGHT+IFb0cboVknNIZArzascsjeUHM9Scu1/6qu9TqK3yO+W2ybG/6rcbYuLHaNQn4TLwhwvpCdke7PAkk/m/Zekwfw=
X-Received: by 2002:a81:498e:0:b0:627:88fc:61c5 with SMTP id
 00721157ae682-627e46a4c40mr16091627b3.14.1716372977599; Wed, 22 May 2024
 03:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v> <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
In-Reply-To: <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 May 2024 13:16:03 +0300
Message-ID: <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:58=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Wed, 22 May 2024 at 04:05, John Groves <John@groves.net> wrote:
> > I'm happy to help with that if you care - ping me if so; getting a VM r=
unning
> > in EFI mode is not necessary if you reserve the dax memory via memmap=
=3D, or
> > via libvirt xml.
>
> Could you please give an example?
>
> I use a raw qemu command line with a -kernel option and a root fs
> image (not a disk image with a bootloader).
>
>
> > More generally, a famfs file extent is [daxdev, offset, len]; there may
> > be multiple extents per file, and in the future this definitely needs t=
o
> > generalize to multiple daxdev's.
> >
> > Disclaimer: I'm still coming up to speed on fuse (slowly and ignorantly=
,
> > I think)...
> >
> > A single backing device (daxdev) will contain extents of many famfs
> > files (plus metadata - currently a superblock and a log). I'm not sure
> > it's realistic to have a backing daxdev "open" per famfs file.
>
> That's exactly what I was saying.
>
> The passthrough interface was deliberately done in a way to separate
> the mapping into two steps:
>
>  1) registering the backing file (which could be a device)
>
>  2) mapping from a fuse file to a registered backing file
>
> Step 1 can happen at any time, while step 2 currently happens at open,
> but for various other purposes like metadata passthrough it makes
> sense to allow the mapping to happen at lookup time and be cached for
> the lifetime of the inode.
>
> > In addition there is:
> >
> > - struct dax_holder_operations - to allow a notify_failure() upcall
> >   from dax. This provides the critical capability to shut down famfs
> >   if there are memory errors. This is filesystem- (or technically daxde=
v-
> >   wide)
>
> This can be hooked into fuse_is_bad().
>
> > - The pmem or devdax iomap_ops - to allow the fsdax file system (famfs,
> >   and [soon] famfs_fuse) to call dax_iomap_rw() and dax_iomap_fault().
> >   I strongly suspect that famfs_fuse can't be correct unless it uses
> >   this path rather than just the idea of a single backing file.
>
> Agreed.
>
> > - the dev_dax_iomap portion of the famfs patchsets adds iomap_ops to
> >   character devdax.
>
> You'll need to channel those patches through the respective
> maintainers, preferably before the fuse parts are merged.
>
> > - Note that dax devices, unlike files, don't support read/write - only
> >   mmap(). I suspect (though I'm still pretty ignorant) that this means
> >   we can't just treat the dax device as an extent-based backing file.
>
> Doesn't matter, it'll use the iomap infrastructure instead of the
> passthrough infrastructure.
>
> But the interfaces for regular passthrough and fsdax could be shared.
> Conceptually they are very similar:  there's a backing store indexable
> with byte offsets.
>
> What's currently missing from the API is an extent list in
> fuse_open_out.   The format could be:
>
>   [ {backing_id, offset, length}, ... ]
>
> allowing each extent to map to a different backing device.
>
> > A dax device to famfs is a lot more like a backing device for a "filesy=
stem"
> > than a backing file for another file. And, as previously mentioned, the=
re
> > is the iomap_ops interface and the holder_ops interface that deal with
> > multiple file tenants on a dax device (plus error notification,
> > respectively)
> >
> > Probably doable, but important distinctions...
>
> Yeah, that's why I suggested to create a new source file for this
> within fs/fuse.  Alternatively we could try splitting up fuse into
> modules (core, virtiofs, cuse, fsdax) but I think that can be left as
> a cleanup step.
>
> > First question: can you suggest an example fuse file pass-through
> > file system that I might use as a jumping-off point? Something that
> > gets the basic pass-through capability from which to start hacking
> > in famfs/dax capabilities?
>
> An example is in Amir's libfuse repo at
>
>    https://github.com/libfuse/libfuse
>

That's not my repo, it's the official one ;-)
but yeh, my passthrough example got merged last week:
https://github.com/libfuse/libfuse/pull/919

> > I'm confused by the last item. I would think there would be a fuse
> > inode per famfs file, and that multiple of those would map to separate
> > extent lists of one or more backing dax devices.
>
> Yeah.
>
> > Or maybe I misunderstand the meaning of "fuse inode". Feel free to
> > assign reading...
>
> I think Amir meant that each open file could in theory have a
> different mapping.  This is allowed by the fuse interface, but is
> disallowed in practice.
>
> I'm in favor of caching the extent map so it only has to be given on
> the first open (or lookup).

Yeh, sorry, that was a bit confusing.
The statement is that because the simples plan as Miklos
suggested is to pass the extent list in reply to open
two different opens of the same inode are not allowed to
pass in different extent lists.

The new iomode.c code does something similar.
Currently fuse_inode has a reference to fuse_backing which
stores the backing file (that can be the dax device) and it also
has a reference to fuse_inode_dax with an rbtree of fuse_dax_mapping
Can we reuse fuse_inode_dax for the needs of famfs?

The first open would cache the extent list in fuse_inode and
second open would verify that the extent list matches.

Last file close could clean the cache extent list or not - that
is an API decision.

Thanks,
Amir.

