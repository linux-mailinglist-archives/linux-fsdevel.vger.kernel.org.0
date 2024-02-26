Return-Path: <linux-fsdevel+bounces-12811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8344986767A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF551F28E69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3A128389;
	Mon, 26 Feb 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1aHH34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFE127B61;
	Mon, 26 Feb 2024 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954043; cv=none; b=tAg4xkVqsj8NNKKfSNs8ANut3ukbv+KNlVGveq0YT6HV4lum/bBL6+RImK5EGD8mdwFei/C5LyYGYPIevnTgM2JcSdgD+mffATNscJBuhoIc4Y0Ga+PVN3JHCMuFzwv/q6zs++MLlJ7o61bMutdLnZE0qLDg+jWK/6dWSEqPTG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954043; c=relaxed/simple;
	bh=JAr88YbOnyscOimOFk+MaQJwN68PDi2G4XVXJRnVApo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xww40ModqvY4rDZqkVz5U9MnFfWF1wzcwTV2YcJVgu7szzmku17yTH/NcdaYltEJWWtpGzn18ebNVk1qWoMY313GNqe8nN+QjH78jNZchQuXI08NN/KCUZB/A7Gdev9cR219zdhJyLN80mPNq4ctb+h5sk66usW3QR0KnVl6qo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO1aHH34; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-595aa5b1fe0so2097812eaf.2;
        Mon, 26 Feb 2024 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708954040; x=1709558840; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTu9hxlyjKX4XP2aC99YB9WMRIDbfk9ne3eWGGL16lc=;
        b=HO1aHH34waLCJAG0c32ivT0jLPJKxxyIpqPeOhpfPvl5/OBt9eskOooFs2fFWH3X6x
         CTuuSQ5ARG7sYWhch+Zb40psa2qXMG4gcBMm6oM/xa4QNC4MpRkqIlWgW5lOT+1vWxOo
         yZrhOgXy3T+OMXQenePkbGTwzXxa6PjqkFRj5ZOK3Ae8IyUa15Oc9E2RY6DXd7eXjMq1
         QHdt71EhSJMR8Iwogc5RNzFn/q5BuWa7jnAXSjo/2JlDagK0tvhJXXSEo2VA2I8Qo61W
         QsH/pKmRmMEMjbHiifMtR7fXTYgK0ecFrvGxNZaX4izIrBmff39fhb0Y+q+XaL43imWw
         nLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708954040; x=1709558840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTu9hxlyjKX4XP2aC99YB9WMRIDbfk9ne3eWGGL16lc=;
        b=iN6bLv50D7tJWmpnm0Ot2Gm1F3uK6GENVge8HWAQleGatgGoK1ctLej0fjtItjBmHR
         0AAns1Hv4yarZoIH6/vep4eBgeKTpnZD/X0s20I7SudRLrMsoTllBpmdYCRPN5ZmUwaK
         I++ZodwgHMp8S/5CMTpV9BuUCBSEmoorHYtK+fUJsrvarHHNBjP1PHUkDae3NPK3a4g9
         /gEqNWTL7B28Q78RJhVM55dSFD+RP4pYOSa93NtA9H41aVkQuoB+q420Qkw6Cew3UJDt
         cDTBDa9z3KY21FZLM2NIKRFYu0vCGZ3J96ST5HwI0fPUDFPYRg6tMkx6yiCBcKMrsJ+G
         iLSA==
X-Forwarded-Encrypted: i=1; AJvYcCUrSziAxi2BewqaLe8Jne0ebQpIZqmcQcvsekpT7YvUfIFjIvZytYXPWHL2JvuGaLQBgwNuzQ3SLoOARKDVab1g1+ozjD7n27lxfNvD/HyO4w3zTDUxMemwfnJ/8A0KhvTi9Vz7fPjAnYotPdlYuKv9MSefrx5UWlVScJmTvaj/+N0Slxr+Gl2UQruWIUOEvXDdILN6GyNSySBH6xQ89yUczQ==
X-Gm-Message-State: AOJu0YxdxfhDhjpfLWEnHBj+85t3yPQGCnkzmMuUiJtxs9Ez8kTW3I48
	pxp1jVp1cRZ61aU/pxGqjnwv2jZf6SADqN27eSrdBgQC7sQ093Dc
X-Google-Smtp-Source: AGHT+IFr3lEZlkGkDaohz993b/y6atZT9IPCq/zNFIU/CcynuPGNAqhVuaqGPHgoZbA1JbjdMI4Xlg==
X-Received: by 2002:a4a:c81a:0:b0:5a0:9915:222f with SMTP id s26-20020a4ac81a000000b005a09915222fmr1338074ooq.4.1708954040379;
        Mon, 26 Feb 2024 05:27:20 -0800 (PST)
Received: from Borg-9 (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id e30-20020a4a91de000000b005a04afb627fsm1246489ooh.24.2024.02.26.05.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:27:19 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 07:27:18 -0600
From: John Groves <John@groves.net>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
References: <cover.1708709155.git.john@groves.net>
 <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZdkzJM6sze-p3EWP@bombadil.infradead.org>

On 24/02/23 04:07PM, Luis Chamberlain wrote:
> On Fri, Feb 23, 2024 at 11:41:44AM -0600, John Groves wrote:
> > This patch set introduces famfs[1] - a special-purpose fs-dax file syst=
em
> > for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> > CXL-specific in anyway way.
> >=20
> > * Famfs creates a simple access method for storing and sharing data in
> >   sharable memory. The memory is exposed and accessed as memory-mappable
> >   dax files.
> > * Famfs supports multiple hosts mounting the same file system from the
> >   same memory (something existing fs-dax file systems don't do).
> > * A famfs file system can be created on either a /dev/pmem device in fs=
-dax
> >   mode, or a /dev/dax device in devdax mode (the latter depending on
> >   patches 2-6 of this series).
> >=20
> > The famfs kernel file system is part the famfs framework; additional
> > components in user space[2] handle metadata and direct the famfs kernel
> > module to instantiate files that map to specific memory. The famfs user
> > space has documentation and a reasonably thorough test suite.
> >=20
> > The famfs kernel module never accesses the shared memory directly (eith=
er
> > data or metadata). Because of this, shared memory managed by the famfs
> > framework does not create a RAS "blast radius" problem that should be a=
ble
> > to crash or de-stabilize the kernel. Poison or timeouts in famfs memory
> > can be expected to kill apps via SIGBUS and cause mounts to be disabled
> > due to memory failure notifications.
> >=20
> > Famfs does not attempt to solve concurrency or coherency problems for a=
pps,
> > although it does solve these problems in regard to its own data structu=
res.
> > Apps may encounter hard concurrency problems, but there are use cases t=
hat
> > are imminently useful and uncomplicated from a concurrency perspective:
> > serial sharing is one (only one host at a time has access), and read-on=
ly
> > concurrent sharing is another (all hosts can read-cache without worry).
>=20
> Can you do me a favor, curious if you can run a test like this:
>=20
> fio -name=3Dten-1g-per-thread --nrfiles=3D10 -bs=3D2M -ioengine=3Dio_urin=
g                                                                          =
                                                 =20
> -direct=3D1                                                              =
                                                                           =
                                          =20
> --group_reporting=3D1 --alloc-size=3D1048576 --filesize=3D1GiB           =
                                                                           =
                                               =20
> --readwrite=3Dwrite --fallocate=3Dnone --numjobs=3D$(nproc) --create_on_o=
pen=3D1                                                                    =
                                                 =20
> --directory=3D/mnt=20
>=20
> What do you get for throughput?
>=20
> The absolute large the system an capacity the better.
>=20
>   Luis

Luis,

First, thanks for paying attention. I think I need to clarify a few things
about famfs and then check how that modifies your ask; apologies if some
are obvious. You should tell me whether this is still interesting given
these clarifications and limitations, or if there is something else you'd
like to see tested instead. But read on, I have run the closest tests I
can.

Famfs files just map to dax memory; they don't have a backing store. So the
io_uring and direct=3D1 options don't work. The coolness is that the files &
memory can be shared, and that apps can deal with files rather than having
to learn new abstractions.

Famfs files are never allocate-on-write, so (--fallocate=3Dnone is ok, but
"actual" fallocate doesn't work - and --create_on_open desn't work). But it
seems to be happy if I preallocate the files for the test.

I don't currently have custody of a really beefy system (can get one, just
need to plan ahead). My primary dev system is a 48 HT core E5-2690 v3 @
2.60G (around 10 years old).

I have a 128GB dax device that is backed by ddr4 via efi_fake_mem. So I
can't do 48 x 10 x 1G, but I can do 48 x 10 x 256M. I ran this on
ddr4-backed famfs, and xfs backed by a sata ssd. Probably not fair, but
it's what I have on a Sunday evening.

I can get access to a beefy system with real cxl memory, though don't
assume 100% I can report performance on that - will check into that. But
think about what you're looking for in light of the fact that famfs is just
a shared-memory file system, so no O_DIRECT or io_uring. Basically just
(hopefully efficient) vma fault handling and metadata distribution.

###

Here is famfs. I had to drop the io_uring and script up alloc/creation
of the files (sudo famfs creat -s 256M /mnt/famfs/foo)

$ fio -name=3Dten-256m-per-thread --nrfiles=3D10 -bs=3D2M --group_reporting=
=3D1 --alloc-size=3D1048576 --filesize=3D100MiB --readwrite=3Dwrite --fallo=
cate=3Dnone --numjobs=3D48 --create_on_open=3D0 --directory=3D/mnt/famfs
ten-256m-per-thread: (g=3D0): rw=3Dwrite, bs=3D(R) 2048KiB-2048KiB, (W) 204=
8KiB-2048KiB, (T) 2048KiB-2048KiB, ioengine=3Dpsync, iodepth=3D1
=2E..
fio-3.33
Starting 48 processes
Jobs: 40 (f=3D400)
ten-256m-per-thread: (groupid=3D0, jobs=3D48): err=3D 0: pid=3D201738: Mon =
Feb 26 06:48:21 2024
  write: IOPS=3D15.2k, BW=3D29.6GiB/s (31.8GB/s)(44.7GiB/1511msec); 0 zone =
resets
    clat (usec): min=3D156, max=3D54645, avg=3D2077.40, stdev=3D1730.77
     lat (usec): min=3D171, max=3D54686, avg=3D2404.87, stdev=3D2056.50
    clat percentiles (usec):
     |  1.00th=3D[  196],  5.00th=3D[  243], 10.00th=3D[  367], 20.00th=3D[=
  644],
     | 30.00th=3D[  857], 40.00th=3D[ 1352], 50.00th=3D[ 1876], 60.00th=3D[=
 2442],
     | 70.00th=3D[ 2868], 80.00th=3D[ 3228], 90.00th=3D[ 3884], 95.00th=3D[=
 4555],
     | 99.00th=3D[ 6390], 99.50th=3D[ 7439], 99.90th=3D[16450], 99.95th=3D[=
23987],
     | 99.99th=3D[46924]
   bw (  MiB/s): min=3D21544, max=3D28034, per=3D81.80%, avg=3D24789.35, st=
dev=3D130.16, samples=3D81
   iops        : min=3D10756, max=3D14000, avg=3D12378.00, stdev=3D65.06, s=
amples=3D81
  lat (usec)   : 250=3D5.42%, 500=3D9.67%, 750=3D8.07%, 1000=3D11.77%
  lat (msec)   : 2=3D16.87%, 4=3D39.59%, 10=3D8.37%, 20=3D0.17%, 50=3D0.07%
  lat (msec)   : 100=3D0.01%
  cpu          : usr=3D13.26%, sys=3D81.62%, ctx=3D2075, majf=3D0, minf=3D1=
8159
  IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D0,22896,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1

Run status group 0 (all jobs):
  WRITE: bw=3D29.6GiB/s (31.8GB/s), 29.6GiB/s-29.6GiB/s (31.8GB/s-31.8GB/s)=
, io=3D44.7GiB (48.0GB), run=3D1511-1511msec

$ sudo famfs fsck -h /mnt/famfs
Famfs Superblock:
  Filesystem UUID: 591f3f62-0a79-4543-9ab5-e02dc807c76c
  System UUID:     00000000-0000-0000-0000-0cc47aaaa734
  sizeof superblock: 168
  num_daxdevs:              1
  primary: /dev/dax1.0   137438953472

Log stats:
  # of log entriesi in use: 480 of 25575
  Log size in use:          157488
  No allocation errors found

Capacity:
  Device capacity:        128.00G
  Bitmap capacity:        127.99G
  Sum of file sizes:      120.00G
  Allocated space:        120.00G
  Free space:             7.99G
  Space amplification:     1.00
  Percent used:            93.8%

Famfs log:
  480 of 25575 entries used
  480 files
  0 directories

###

Here is the same fio command, plus --ioengine=3Dio_uring and --direct=3D1. =
It's
apples and oranges, since famfs is a memory interface and not a storage
interface. This is run on an xfs file system on a SATA ssd.

Note units are msec here, usec above.

fio -name=3Dten-256m-per-thread --nrfiles=3D10 -bs=3D2M --group_reporting=
=3D1 --alloc-size=3D1048576 --filesize=3D256MiB --readwrite=3Dwrite --fallo=
cate=3Dnone --numjobs=3D48 --create_on_open=3D0 --ioengine=3Dio_uring --dir=
ect=3D1 --directory=3D/home/jmg/t1
ten-256m-per-thread: (g=3D0): rw=3Dwrite, bs=3D(R) 2048KiB-2048KiB, (W) 204=
8KiB-2048KiB, (T) 2048KiB-2048KiB, ioengine=3Dio_uring, iodepth=3D1
=2E..
fio-3.33
Starting 48 processes
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
ten-256m-per-thread: Laying out IO files (10 files / total 2441MiB)
Jobs: 37 (f=3D370): [W(1),_(2),W(2),_(1),W(1),_(1),W(6),_(1),W(1),_(1),W(1)=
,_(1),W(1),_(1),W(1),_(1),W(13),_(1),W(5),_(1),W(5)][72.1%][w=3D454MiB/s][w=
=3D227 IOPS][eta 01m:32sJobs: 37 (f=3D370): [W(1),_(2),W(2),_(1),W(1),_(1),=
W(6),_(1),W(1),_(1),W(1),_(1),W(1),_(1),W(1),_(1),W(13),_(1),W(5),_(1),W(5)=
][72.4%][w=3D456MiB/s][w=3D228 IOPS][eta 01m:31sJobs: 36 (f=3D360): [W(1),_=
(2),W(2),_(1),W(1),_(1),W(6),_(1),W(1),_(1),W(1),_(1),W(1),_(3),W(13),_(1),=
W(5),_(1),W(5)][72.9%][w=3D454MiB/s][w=3D227 IOPS][eta 01m:29s]         Job=
s: 33 (f=3D330): [_(3),W(2),_(1),W(1),_(1),W(1),_(1),W(4),_(1),W(1),_(1),W(=
1),_(1),W(1),_(3),W(13),_(1),W(5),_(1),W(2),_(1),W(2)][73.0%][w=3D458MiB/s]=
[w=3D229 IOPS][eta 01Jobs: 30 (f=3D300): [_(3),W(2),_(1),W(1),_(1),W(1),_(2=
),W(3),_(1),W(1),_(3),W(1),_(3),W(7),_(1),W(5),_(1),W(5),_(1),W(2),_(1),W(2=
)][73.6%][w=3D462MiB/s][w=3D231 IOPS][eta 01mJobs: 28 (f=3D280): [_(3),W(2)=
,_(1),W(1),_(1),W(1),_(2),W(3),_(5),W(1),_(3),W(7),_(1),W(5),_(1),W(5),_(1)=
,W(2),_(2),W(1)][74.1%][w=3D456MiB/s][w=3D228 IOPS][eta 01m:25s]     Jobs: =
25 (f=3D250): [_(3),W(2),_(1),W(1),_(1),W(1),_(2),W(1),_(1),W(1),_(5),W(1),=
_(3),W(2),_(1),W(4),_(1),W(5),_(1),W(5),_(2),W(1),_(2),W(1)][75.1%][w=3D458=
MiB/s][w=3D229 IOPJobs: 24 (f=3D240): [_(3),W(2),_(1),W(1),_(1),W(1),_(2),W=
(1),_(1),W(1),_(5),W(1),_(3),W(2),_(1),W(3),_(2),W(5),_(1),W(5),_(2),W(1),_=
(2),W(1)][75.6%][w=3D456MiB/s][w=3D228 IOPJobs: 23 (f=3D230): [_(3),W(2),_(=
1),W(1),_(1),W(1),_(2),W(1),_(1),W(1),_(5),E(1),_(3),W(2),_(1),W(3),_(2),W(=
5),_(1),W(5),_(2),W(1),_(2),W(1)][76.2%][w=3D452MiB/s][w=3D226 IOPJobs: 20 =
(f=3D200): [_(3),W(2),_(1),W(1),_(1),W(1),_(2),W(1),_(11),W(2),_(1),W(3),_(=
2),W(5),_(1),W(3),_(1),W(1),_(2),W(1),_(3)][76.7%][w=3D448MiB/s][w=3D224 IO=
PS][eta 01m:15sJobs: 19 (f=3D190): [_(3),W(2),_(1),W(1),_(1),W(1),_(2),W(1)=
,_(11),W(2),_(1),W(3),_(2),W(5),_(2),W(2),_(1),W(1),_(2),W(1),_(3)][77.5%][=
w=3D464MiB/s][w=3D232 IOPS][eta 01m:12sJobs: 18 (f=3D180): [_(3),W(2),_(3),=
W(1),_(2),W(1),_(11),W(2),_(1),W(3),_(2),W(5),_(2),W(2),_(1),W(1),_(2),W(1)=
,_(3)][78.8%][w=3D478MiB/s][w=3D239 IOPS][eta 01m:07s]         Jobs: 4 (f=
=3D40): [_(3),W(1),_(22),W(1),_(12),W(1),_(4),W(1),_(3)][92.4%][w=3D462MiB/=
s][w=3D231 IOPS][eta 00m:21s]                                              =
    =20
ten-256m-per-thread: (groupid=3D0, jobs=3D48): err=3D 0: pid=3D210709: Mon =
Feb 26 07:20:51 2024
  write: IOPS=3D228, BW=3D458MiB/s (480MB/s)(114GiB/255942msec); 0 zone res=
ets
    slat (usec): min=3D39, max=3D776, avg=3D186.65, stdev=3D49.13
    clat (msec): min=3D4, max=3D6718, avg=3D199.27, stdev=3D324.82
     lat (msec): min=3D4, max=3D6718, avg=3D199.45, stdev=3D324.82
    clat percentiles (msec):
     |  1.00th=3D[   30],  5.00th=3D[   47], 10.00th=3D[   60], 20.00th=3D[=
   69],
     | 30.00th=3D[   78], 40.00th=3D[   85], 50.00th=3D[   95], 60.00th=3D[=
  114],
     | 70.00th=3D[  142], 80.00th=3D[  194], 90.00th=3D[  409], 95.00th=3D[=
  810],
     | 99.00th=3D[ 1703], 99.50th=3D[ 2140], 99.90th=3D[ 3037], 99.95th=3D[=
 3440],
     | 99.99th=3D[ 4665]
   bw (  KiB/s): min=3D195570, max=3D2422953, per=3D100.00%, avg=3D653513.5=
3, stdev=3D8137.30, samples=3D17556
   iops        : min=3D   60, max=3D 1180, avg=3D314.22, stdev=3D 3.98, sam=
ples=3D17556
  lat (msec)   : 10=3D0.11%, 20=3D0.37%, 50=3D5.35%, 100=3D47.30%, 250=3D32=
=2E22%
  lat (msec)   : 500=3D6.11%, 750=3D2.98%, 1000=3D1.98%, 2000=3D2.97%, >=3D=
2000=3D0.60%
  cpu          : usr=3D0.10%, sys=3D0.01%, ctx=3D58709, majf=3D0, minf=3D669
  IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%, 32=3D=
0.0%, >=3D64=3D0.0%
     submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0%, 64=
=3D0.0%, >=3D64=3D0.0%
     issued rwts: total=3D0,58560,0,0 short=3D0,0,0,0 dropped=3D0,0,0,0
     latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=3D1

Run status group 0 (all jobs):
  WRITE: bw=3D458MiB/s (480MB/s), 458MiB/s-458MiB/s (480MB/s-480MB/s), io=
=3D114GiB (123GB), run=3D255942-255942msec

Disk stats (read/write):
    dm-2: ios=3D11/82263, merge=3D0/0, ticks=3D270/13403617, in_queue=3D134=
03887, util=3D97.10%, aggrios=3D11/152359, aggrmerge=3D0/5087, aggrticks=3D=
271/11493029, aggrin_queue=3D11494994, aggrutil=3D100.00%
  sdb: ios=3D11/152359, merge=3D0/5087, ticks=3D271/11493029, in_queue=3D11=
494994, util=3D100.00%

###

Let me know what else you'd like to see tried.

Regards,
John


