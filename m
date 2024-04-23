Return-Path: <linux-fsdevel+bounces-17509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 592278AE839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E3F1F212A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D3E13664A;
	Tue, 23 Apr 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9/IEe2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444CF1353E0;
	Tue, 23 Apr 2024 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879073; cv=none; b=eBjBQ9eK7gObwE855AMJe78v7MSn+NdJx/xdd9boMeUNuqfot75FoxjCSmvCtIwQ/lci1BakAIpAP/USBMWPzlFhCsnQMBbocECwCZlf/ws7rjHUx5wIaZQf63F8SSoaOB/6UI25DRTgAbc8QV3Q65I51SCKpbwKwYGxe8HVQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879073; c=relaxed/simple;
	bh=IxPKUCzl68GmqyGXvxuy/DA5ZjDtg4FgIO2Z9g8hUmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tz6dM5/ztgzFUx6ocu/R4xU9Kuhf+VKdmkbXMK6lZXXOVf1E7nDVSIbnxYlr0nI03FxRuHLw/wSegNZrBw2FKiOnzXjfKi/+GwFmLPtdU6wNAyFpikBP1XPMs/SevTeO10OVnZkggD2hY803qBF5jRtbM44iO88qavEiTY3bM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9/IEe2I; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b5a87505cso22019156d6.2;
        Tue, 23 Apr 2024 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713879071; x=1714483871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlzWX69uBnN1f6I1MGifs0qgiAW4SxcxpA314BcskT4=;
        b=f9/IEe2ITqaN0Wdvsc4o3HgW7Sj2qj69zrgJ9fjx1lPQONZTGDs6JcSqb09diwuIWM
         Q4/yezWux6oHZQuNB9lUDdE2tgc5C3dJg/fB0/uUbvDLFUfnhzOzryOWHF7N2HHKd5F0
         l2A5iUDsBO6z/ByQdx/on1KG/ZvxKQGR1xoYKLkXY/jlLr9sVNL64SOLHunU/9yzovla
         PPREe/3XWAgBGQt30dkcfy85JfLG1zTi7Q5LZpb3tdTyOEX4STEwFmF+Ws9Ir62hKzNw
         B+JacLrVoNZfnJgLKdPhOWOXNOTewh2DGOb5oJ71Nk7IXzCFKI8C9cTY4/fqn2GWUvl6
         rPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713879071; x=1714483871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlzWX69uBnN1f6I1MGifs0qgiAW4SxcxpA314BcskT4=;
        b=E9SfV+daoED7v97i0FlaSKWMDTp6cJDLV5ChFsQ7NH1/FekLOV1nNMgaVcLDo3ZPXr
         obiFGrFs+KWfS/lYPS7zvS+EussLGvLKjjpqp+cKflZ6zrxaWyfMRnJAQO1/zphmoPmx
         /C8svuQpcfGXOoLCZifdSMX3GKIHJnBZmj7WoxsXO/yl4nNzWRFqyuePgK6LTsQOGd1v
         qiduI0O7/aIJ4ZvZbb8XIHiwmLanfEEChG5RgMKHYxR967hYUm6n0mGS11cogHheBoMp
         jMMQa5pSUNXDXu+OO6LVVpj2EjLJn5gx4A5Iyt4TAVFJVNsfkjdbJVrPiRMSWTtZ45eC
         cMug==
X-Forwarded-Encrypted: i=1; AJvYcCVcUNOth/neMOyeIABOu/yzo+p9cA2Ioxn6LvrHodL3fqkQOwzhOv56pDh00deSBWLVsp1ofz4nY2SusjlZ90sfFBuzWjws9Fp2nCrX+xeUnP7EmAG1hAemVw7LJ9lwn/d1pzju9urh5g==
X-Gm-Message-State: AOJu0YxwAiBdxwT/oBcll2FMacbERGN1bywEVkC8Ust1cezH5xBbr1sx
	Y1qMwn0PIcVR0vjBYsktEU49KQzhT7DHy5KTVg1uJ2EcgRFnxJ4qT1SngoqJsjV79ivUNW/rmd7
	Nj4uUcQkaBgy67YOzps0AxcVPjro=
X-Google-Smtp-Source: AGHT+IGm9PNtptdr4RC0D9B0O/GNda/2xKMhHsdXlitZa7C3oPcFsgf+fpwsTHPA9gPA2XyfPZbLeP9q4GqY5s1m4TM=
X-Received: by 2002:a0c:e909:0:b0:69b:76f7:3653 with SMTP id
 a9-20020a0ce909000000b0069b76f73653mr13626939qvo.27.1713879071065; Tue, 23
 Apr 2024 06:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229002020.85535-1-john@groves.net>
In-Reply-To: <20240229002020.85535-1-john@groves.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Apr 2024 16:30:59 +0300
Message-ID: <CAOQ4uxi83HUUmMmNs9NeeOOfVVXhpWAdeAEDq8r31p0tK1sA2A@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Famfs: shared memory file system for
 disaggregated memory [LSF/MM/BPF ATTEND]
To: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: lsf-pc@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>, 
	Jon Grimm <jon.grimm@amd.com>, Dave Chinner <david@fromorbit.com>, john@jagalactic.com, 
	Bharata B Rao <bharata@amd.com>, Jerome Glisse <jglisse@google.com>, gregory.price@memverge.com, 
	Ajay Joshi <ajayjoshi@micron.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Alistair Popple <apopple@nvidia.com>, Christoph Hellwig <hch@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	David Rientjes <rientjes@google.com>, Ravi Shankar <venkataravis@micron.com>, 
	dave.hansen@linux.intel.com, John Hubbard <jhubbard@nvidia.com>, mykolal@meta.com, 
	Brian Morris <bsmorris@google.com>, Eishan Mirakhur <emirakhur@micron.com>, Wei Xu <weixugc@google.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Srinivasulu Thanneeru <sthanneeru@micron.com>, John Groves <jgroves@micron.com>, 
	Christoph Lameter <cl@gentwo.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Aravind Ramesh <arramesh@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 2:20=E2=80=AFAM John Groves <John@groves.net> wrote=
:
>
> John Groves, Micron
>
> Micron recently released the first RFC for famfs [1]. Although famfs is n=
ot
> CXL-specific in any way, it aims to enable hosts to share data sets in sh=
ared
> memory (such as CXL) by providing a memory-mappable fs-dax file system
> interface to the memory.
>
> Sharable disaggregated memory already exists in the lab, and will be poss=
ible
> in the wild soon. Famfs aims to do the following:
>
> * Provide an access method that provides isolation between files, and doe=
s not
>   tempt developers to mmap all the memory writable on every host.
> * Provide an an access method that can be used by unmodified apps.
>
> Without something like famfs, enabling the use of sharable memory will in=
volve
> the temptation to do things that may destabilize systems, such as
> mapping large shared, writable global memory ranges and hooking allocator=
s to
> use it (potentially sacrificing isolation), and forcing the same virtual
> address ranges in every host/process (compromising security).
>
> The most obvious candidate app categories are data analytics and data lak=
es.
> Both make heavy use of "zero-copy" data frames - column oriented data tha=
t
> is laid out for efficient use via (MAP_SHARED) mmap. Moreover, these use =
case
> categories are generally driven by python code that wrangles data into
> appropriate data frames - making it straightforward to put the data frame=
s
> into famfs. Furthermore, these use cases usually involve the shared data =
being
> read-only during computation or query jobs - meaning they are often free =
of
> cache coherency concerns.
>
> Workloads such as these often deal with data sets that are too large to f=
it
> in a single server's memory, so the data gets sharded - requiring movemen=
t via
> a network. Sharded apps also sometimes have to do expensive reshuffling -
> moving data to nodes with available compute resources. Avoiding the shard=
ing
> overheads by accessing such data sets in disaggregated shared memory look=
s
> promising to make make better use of memory and compute resources, and by
> effectively de-duplicating data sets in memory.
>
> About sharable memory
>
> * Shared memory is pmem-like, in that hosts will connect in order to acce=
ss
>   pre-existing contents
> * Onlining sharable memory as system-ram is nonsense; system-ram gets zer=
oed...
> * CXL 3 provides for optionally-supported hardware-managed cache coherenc=
y
> * But "multiple-readers, no writers" use cases don't need hardware suppor=
t
>   for coherency
> * CXL 3.1 dynamic capacity devices (DCDs) should be thought of as devices=
 with
>   an allocator built in.
> * When sharable capacity is allocated, each host that has access will see=
 a
>   /dev/dax device that can be found by the "tag" of the allocation. The t=
ag is
>   just a uuid.
> * CXL 3.1 also allows the capacity associated with any allocated tag to b=
e
>   provided to each host (or host group) as either writable or read-only.
>
> About famfs
>
> Famfs is an append-only log-structured file system that places many limit=
s
> on what can be done. This allows famfs to tolerate clients with a stale c=
opy
> of metadata. All memory allocation and log maintenance is performed from =
user
> space, but file extent lists are cached in the kernel for fast fault
> resolution. The current limitations are fairly extreme, but many can be r=
elaxed
> by writing more code, managing Byzantine generals, etc. ;)
>
> A famfs-enabled kernel can be cloned at [3], and the user space repo can =
be
> cloned at [4]. Even with major functional limitations in its current form
> (e.g. famfs does not currently support deleting files), it is sufficient =
to
> use in data analytics workloads - in which you 1) create a famfs file sys=
tem,
> 2) dump data sets into it, 3) run clustered jobs that consume the shared =
data
> sets, and 4) dismount and deallocate the memory containing the file syste=
m.
>
> Famfs Open Issues
>
> * Volatile CXL memory is exposed as character dax devices; the famfs patc=
h
>   set adds the iomap API, which is required for fs-dax but until now miss=
ing
>   from character dax.
> * (/dev/pmem devices are block, and support the iomap api for fs-dax file
>   systems)
> * /dev/pmem devices can be converted to /dev/dax mode, but native /dev/da=
x
>   devices cannot be converted to pmem mode.
> * /dev/dax devices lack the iomap api that fs-dax uses with pmem, so the =
famfs
>   patch set adds that.
> * VFS layer hooks for a file system on a character device may be needed.
> * Famfs has uncovered some previously latent bugs in the /dev/dax mmap
>   machinery that probably require attention.
> * Famfs currently works with either pmem or devdax devices, but our
>   inclination is to drop pmem support to, reduce the complexity of suppor=
ting
>   two different underlying device types - particularly since famfs is not
>   intended for actual pmem.
>
>
> Required :-
> Dan Williams
> Christian Brauner
> Jonathan Cameron
> Dave Hansen
>
> [LSF/MM + BPF ATTEND]
>
> I am the author of the famfs file system. Famfs was first introduced at L=
PC
> 2023 [2]. I'm also Micron's voting member on the Software and Systems Wor=
king
> Group (SSWG) of the CXL Consortium, and a co-author of the CXL 3.1
> specification.
>
>
> References
>
> [1] https://lore.kernel.org/linux-fsdevel/cover.1708709155.git.john@grove=
s.net/#t
> [2] https://lpc.events/event/17/contributions/1455/
> [3] https://www.computeexpresslink.org/download-the-specification
> [4] https://github.com/cxl-micron-reskit/famfs-linux
>

Hi John,

Following our correspondence on your patch set [1], I am not sure that the
details of famfs file system itself are an interesting topic for the
LSFMM crowd??
What I would like to do is schedule a session on:
"Famfs: new userspace filesystem driver vs. improving FUSE/DAX"

I am hoping that Miklos and Bernd will be able to participate in this
session remotely.

You see the last time that someone tried to introduce a specialized
faster FUSE replacement [2], the comments from the community were
that FUSE protocol can and should be improved instead of introducing
another "filesystem in userspace" protocol.

Since 2019, FUSE has gained virtiofs/dax support, it recently gained
FUSE passthrough support and Bernd is working on FUSE uring [3].

My hope is that you will be able to list the needed improvements
to /dev/dax iomap and FUSE so that you could use the existing
kernel infrastructure and FUSE libraries to implement famfs.

How does that sound for a discussion?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/3jwluwrqj6rwsxdsksfvdeo5uccgmnkh7=
rgefaeyxf2gu75344@ybhwncywkftx/
[2] https://lore.kernel.org/linux-fsdevel/8d119597-4543-c6a4-917f-14f4f4a6a=
855@netapp.com/
[3] https://lore.kernel.org/linux-fsdevel/20230321011047.3425786-1-bschuber=
t@ddn.com/

