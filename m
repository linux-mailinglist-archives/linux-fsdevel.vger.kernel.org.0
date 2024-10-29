Return-Path: <linux-fsdevel+bounces-33094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DA09B3F95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 02:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21C11F22F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20658199B8;
	Tue, 29 Oct 2024 01:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8K68zD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F36A747F;
	Tue, 29 Oct 2024 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164394; cv=none; b=dpqLw/58dw4StndTnGJLuNFpfekNkMqFx9BVeyMmQd/sHeH5hZO62qiYAdM/excZ4NKncQDhdcNTSUF0T0X7FP9c4hT0I2GM/unyWc+OnCA94SJccbfl1Cz6qWe0b06Am/eSsg5FGry71Bmit1fa7z1i5pOtBmE9rcz6ic5gvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164394; c=relaxed/simple;
	bh=Xm1qqyOubO8ovx10lzxzCMVn//qphGMlRm7MUUlAoDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5kYzVo3sOPaGQ1ZQkQV+gphboewxYisUxpxv+Im0SJB7hAArLIlwWOg2tSNIMuf0/gU/00I5XEKy/ywnKFENPrkgjdzvTGZZarkA+5cTCiI3+sq+pXi2J7rgS18WHh6/u2PPR+SJhRPLkXxCrmW9V+69E2XwADYoVR3o9wLYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8K68zD+; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7181285c7c4so2645416a34.0;
        Mon, 28 Oct 2024 18:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164390; x=1730769190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FICjtVxAbcvtdzkR4zCDN8/CuLIvkEc6tGxv4XvE8n8=;
        b=P8K68zD+zkWnOy60j92bDB/2yfyg0fFZUCkW//R78ru2iNu9J5bjFTYQ1uwBMRXBkx
         XREJgtcL2bUnyjtLtQ189oy1Jaz7ZTKFD0lzrqmsM03JOUjfQU4eHwd2YCVjbfxJFE+Y
         eQ5V367wCrK5ToDcJPItuznN2yDwc0OJa8JelLBMmmtMP0y/CBVw0Y5454aOYFZAj3AO
         q2j4UBRQV5BzQ3LhxZ9BLQEgD5sqbcRZWF1yyTpukHbKwwfLsrZumtNZB7LDMJsm62u9
         a9vHO/frITD1O4Oylwrt9QVvM94fOgDre5/9vAV0icTEPDeXQM/QGF/ljRM+p3IQhiKq
         iNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164390; x=1730769190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FICjtVxAbcvtdzkR4zCDN8/CuLIvkEc6tGxv4XvE8n8=;
        b=wb/y2REnZ4RzHsFs4Az+1V/AG5iZs8AxJLKgTqcgNJ+3lhzfNNbRZAoIjmIvjhHCI6
         rtyZjAZyrkG5CYO7cAjtMqf477UxT/2b0yOTuEhJzd3Nv5Wl+EStPBIwf9NXwIJSzmfW
         uJv1LYghCxDyZEvLmv3NUrnaic9fScZo4L4QIN8UCiXrhpGcybpfv9P4CAQtTtANUMy8
         WGWO+Dc1Hz8BA3AJx9Z99fRTYe6w/3gy25CeN5xYTjH2TfeHnCnHjzGAbCRFMdwYtlns
         tcfaAr4Wdm8jY7UpNo2L6xdcYEYN0jYjUcnGicOjejrq8urjxBSJvl45QMF29ZusaOSj
         Qy2A==
X-Forwarded-Encrypted: i=1; AJvYcCUzyApdpjUx+E/Sgfray+EzmRvLC69WWRoyA5XgmJ2ELHpriX9eTqtiCUGiGouCjJPswFNVDiiy6pbn6Q1N@vger.kernel.org
X-Gm-Message-State: AOJu0YyZPBUNGbl3PdcaB2v5kLNz2ElbDY1VPfYgTCSoq/BY9yoXZiGM
	FAzNNg75mDXPJlF9skcikNmlt43V1YvGTl/bwIoA3SRTxEL/Un57
X-Google-Smtp-Source: AGHT+IG3XS7PPqRZqKnu8xRQ0F0b8kgP5Gje9cvp6dAOs23riCI6RL1kBVLKhlClbIBy6I+nfeQ3rQ==
X-Received: by 2002:a05:6870:a450:b0:288:3193:9316 with SMTP id 586e51a60fabf-29051d59a38mr8697999fac.33.1730164390135;
        Mon, 28 Oct 2024 18:13:10 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:119:799c:4dc5:6304])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290360e7393sm2490311fac.28.2024.10.28.18.13.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Oct 2024 18:13:09 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	John Groves <John@Groves.net>
Cc: linux-cxl@vger.kernel.org,
	John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Vivek Goyal <vgoyal@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFC] [Design] Planning the famfs port into fs/fuse
Date: Mon, 28 Oct 2024 20:13:08 -0500
Message-Id: <20241029011308.24890-1-john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos et. al.:

This is the first in what will likely be a series of messages intended
to organize a discussion of how famfs should integrate into fuse.

Background

Famfs [1] stands for fabric-attached memory file system, and it is an fs-dax
file system that supports scale-out access to disaggregated shared memory.
Famfs, even as a standalone file system, manages metadata and performs
allocation from user space. But file mapping metadata is fully cached in
the kernel so that vma/mapping faults are handled in-kernel. This provides
"full memory speed" for mmap/read/write.

Famfs [1] was introduced at LPC '23 [2], released as a standalone file
system patch series in 2024 (v1/v2) [3][4], Discussed as a possible merge
into fuse at LSFMM '24 [5][6], covered in an LPC '24 talk on
shared memory [7], and discussed at some length in the fuse BOF at LPC '24.

Terminology

* fs/famfs - the standalone famfs kernel module [4]
* fs/fuse - the fuse kernel module(s)
* famfs_fused - the famfs fuse server/daemon (or any that uses these new
  features)
* famfs userspace - the union of famfs_fused plus any other famfs components
  that live in user space

Adding famfs metadata to fuse

Porting famfs into fuse requires introducing two new classes of metadata
info fs/fuse: file maps (aka fmaps - file to devdax extent lists) and devdax
devices. Caching fmaps in the kernel allows servicing vma/mapping faults
in-kernel without an up-call. Fmaps resolve to devdax memory, and fs/fuse
must get exclusive access to a devdax device before faults to it can be
handled via an fmap.

Fully caching fmaps for active files is an absolute requirement for famfs,
in order to perform at "memory speeds".

Devdax devices

Famfs file systems reside on devdax devices; fs/fuse will need to
get exclusive access to these devices, and use the dev_dax_iomap api
to resolve mapping faults for famfs files.

The first devdax device is the primary (device 0) and fs/fuse needs
exclusive access starting at mount time. This is the device where the
primary superblock and metadata log are located. Although the superblock
and log are read and written from user space, famfs exposes them as files
(.meta/.superblock and .meta/.log). This approach avoids layering problems,
as it avoids the need to concurrently access a devdax both raw (for the
superblock and log) and through famfs (for regular file data); this would
can't work because the kernel module needs exclusive access to the devdax
devices.

In addition, metadata log entries may add additional devdax devices that
will be referenced by subsequent file entries in the log. We need a way to
pass these into fs/fuse post mount.

File maps (fmaps)

Fmaps come in two flavors, and our design should assume that additional
flavors might arise in the future. The two current flavors are:

* Fmap header with a variable-length list of simple extents
* Fmap header with a variable-length list of interleaved extents
  (each interleaved extent has a header and a variable-length list of
  "strip extents", which are described by the same simple extent structure
  as above)

Passing fmaps into the kernel needs to pack the the message reply in a sane
way to transport the variable-sized simple extent list, or the compound
variable-sized interleaved extent list. If fuse already has a packing
pattern for putting variable-sized structures in reply messages, please
point me to it. 

Details on how fmaps actually work (skip if you don't care)

Note: the fs/famfs links to code on github are to a newer version of
fs/famfs than has been posted to the lists.

In fs/famfs, fmaps are passed into the kernel via the
FAMFSIOC_MAP_CREATE_V2:famfs_file_init_dax_v2() path [8]. This is a
per-file ioctl. Relevant structures are at [9]. The relevant simple and
interleaved structs come as a union after the common header in struct
famfs_ioc_fmap.

With simple extents, struct famfs_ioc_fmap is retrieved via
copy_from_user(), and then the famfs_ioc_simple_extent array is retrieved
based on famfs_ioc_fmap->fioc_nextents from the header struct. See the
SIMPLE_DAX_EXTENT case in famfs_meta_alloc_v2() at [10].

Interleaved extents are a bit more complicated, but they are reasonably
well-documented in a big comment if you scroll up from [9].

The number of interleaved extents is in famfs_ioc_fmap->fioc_niext,
but each interleaved extent has a strip count and for the array of strip
extents (the strip count is famfs_ioc_interleaved_ext->ie_nstrips).

In fuse, we need to put this amalgamation into a variable-sized message
payload. I think it's important for the method of serialization into
messages not to apply arbitrary limits to extent or strip counts - although
a total size limit of no less than 4K might be okay.

I eagerly await suggestions from Miklos or others as to how best to do this,
but I won't go further down this rathole now ;)

Using fmaps to service faults 

Of course the ABI-constrained interchange format (famfs_ioc_fmap) isn't
optimal for in-memory metadata (which should be able to evolve without
breaking the ABI), so it's transmogrified into struct famfs_file_meta
in fs/famfs, which contains a union of extent types (see [11]).

The basic dax/iomap fault handling extent type uses these structs to
translate a file offset to an offset on a daxdev.

A simple extent fault is handled in fs/famfs by famfs_meta_to_dax_offset()
([12]). If it's a the extent type is INTERLEAVED_EXTENT, that function
calls famfs_meta_to_dax_offset_v2() (scroll up from [12]), which resolves a
mapping fault via an interleaved extent.

This fault handling code will need to migrate into fuse_famfs.c (or
fuse_dax_iomap.c, whatever...) in order to handle file mapping faults
efficiently. Because we're enabling memory here - it must run at memory
speeds.

So how does the new metadata integrate into fs/fuse?

One answer would be to attach a famfs flag to files at lookup time, and have
fs/fuse send a new message to the famfs_fused to retrieve the fmap (with
the recipe for serialization of the fmap into the reply message being TBD
as of now). Stefan suggested this new message when we spoke in early
October.

That strikes me as more practical than putting the fmap thingy into the
lookup reply "if needed" - but that is also an option if it's not somehow
impractical or fubar.

OK, what about multiple devdax devices?

The first devdax device is special, in that it's needed at mount time.
The current fs/famfs gets exclusive access to the root daxdev in
famfs_get_tree(), by calling fs_dax_get(...&holder_ops). Note that
fs_dax_get() is patched in by the dev_dax_iomap portion of the fs/famfs
patch set [4], and will be needed in the famfs-fuse patch set as well,
as the iomap api has not previously been available for devdax devices.

I haven't started tackling how this will be hooked into fs/fuse, but it is
a new thing for fs/fuse. 

If we pretend that's covered, the next issue occurs is when fs/fuse
looks-up a famfs file that references a devdax device that hasn't been
referenced previously. The first such occurrence will require providing
daxdev(0) to fs/fuse, and additional instances will require providing
daxdevs 1 onward. 

In user space, daxdevs are known by their uuid's, but they are known to
fmaps by indices (0 being the primary device, and uuid/index mappings will
be managed by the famfs userspace). It seems straightforward for fs/fuse -
when it encounters an fmap that references an as-yet-unknown daxdev index -
to send a new message to famfs_fused requesting that daxdev info by index,
and receive the info in the reply. This approach would avoid the need for
famfs_fused to be stateful wrt which daxdevs are known to fs/fuse.

There are other ways this could be handled, and I'm open to input here - but
I claim it won't work to require that the full daxdev list be populated at
mount time - because adding them later is a very sane use case.

I hope I've done a decent job of framing the initial design problems.
I'm happy to answer questions if anything isn't clear - and I'm
looking forward to your feedback - the more specific the better.

Thanks,
John


[1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
[2] https://lpc.events/event/17/contributions/1455/
[3] https://lore.kernel.org/all/8bd01ff0-235f-4aa8-883d-4b71b505b74d@infradead.org/T/#m27639915e97443186b3ade9d1e94423bc58e6e22
[4] https://lore.kernel.org/linux-cxl/20240430-badeverbot-paletten-05442cfbbdf0@brauner/T/#mb75fb6522045dca2000d854cfa30de4006a96817
[5] https://www.youtube.com/watch?v=nMaZhXJJgmU
[6] https://lwn.net/Articles/983105/
[7] https://lpc.events/event/18/contributions/1827/
[8] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/fs/famfs/famfs_file.c#L482
[9] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/include/uapi/linux/famfs_ioctl.h#L102
[10] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/fs/famfs/famfs_file.c#L296
[11] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/fs/famfs/famfs_internal.h#L18
[12] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/fs/famfs/famfs_file.c#L772
[13] https://github.com/cxl-micron-reskit/famfs-linux/blob/v202410/fs/famfs/famfs_inode.c#L252

