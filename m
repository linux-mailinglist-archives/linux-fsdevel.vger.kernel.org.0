Return-Path: <linux-fsdevel+bounces-46744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA77EA94A2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35663B031A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5C481B6;
	Mon, 21 Apr 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6YzoPzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0A134D4;
	Mon, 21 Apr 2025 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199237; cv=none; b=KGXoBL/OmkXgblIRp1EvCLa8rSP1FuPXs7fKv8ISWjBJHwSuSPjJUANAaZIfaOCjOUVeqRI8ePDxVNzehkia8D3TPvBsjxJDUJSEeKkJC4DKlIVQPjQ37EDoiwuQPCbPeZ6JXLSuIjk4BdweeKSDKw9KHenKE3z9V5oDs/CRY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199237; c=relaxed/simple;
	bh=iitCClRY2RZF97nMcJ7OCwKPxXVBxVjgO7CXa2LBmSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ipi39h7LX0MRWVDu21PGi5Z2UdtzUvilIkTmQEceMq0UMD/KS40CopgzXjGoXBJG2BwZOLze5eIslE2qkYz01YI4HRCu1Z4AqT2TYlpvddfjKI7ed+QMbnD0P0T4Ohc2a0Jz5pRGdseJeQDOOVnh+EmR7uIofBfPbDFaXGkCS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6YzoPzs; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72ecc0eeb8bso770189a34.0;
        Sun, 20 Apr 2025 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199234; x=1745804034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OjWuB6bvBjqoXXcsjJzpBRBCVCy6dm/LI2cgJfKzZps=;
        b=j6YzoPzsQ10JA5z2zMjPWp/LxETzaR2iaE7c5116m3gRgqDgjuCd+QAqkWXt4qt61I
         tZwULmIICiv5BCu8GpoBd8bA6WYXwWFXB3RQWzOL5OsE9hRy1nx/bbMv7qHcFjS5H7ir
         iog4N92QJjocXz/CIN7urdwNyFFzLKVeVECe+WFrxqUt18/tlQfoApYAe52VkdYPU5Bk
         mmlrijeiWprSkKCsetdal7jePNqi7foQr6H8bau3taqNEpeq/rDMcX0LcB8vuO0iNCbc
         CdXxBUBFOgeNH4IyMpuYPTWtae2vzJp3h8hZk4+UKpsZ6rClgyywBylfpfNLUHHHfpJL
         6Urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199234; x=1745804034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjWuB6bvBjqoXXcsjJzpBRBCVCy6dm/LI2cgJfKzZps=;
        b=d7mBqcbw2+lhO5MIk+wMldwqdDQJ5TUWw7ejTRTx1e6/WdQZ5jMwiCCJhP8zTbs9yh
         +pLEOYKEP6tIWdar9XfVucSS6GXYBp7FuGb6TFdpsZirQ8GpSHVx8tf6E+k0pJNstlUC
         aRxSqbQpXbKENzVUCPxl1pfoHP0rmZoVHlSQ5e4lExr9t/MRR2D0eogJXOmnzsQumNt3
         R3ukCLnnX6nwszb4S6Pha9w3A73PxV8QCUih8QResWNAmNpnw+QoGpc9MkCmwAiM6xg+
         ChQI4VoI+wh7giUbx2f/cIJ+yZz5Vr+Kx2Hq7SBgfJCP6Nd1ISZpXXS+jnypvUhgtJjw
         m+ew==
X-Forwarded-Encrypted: i=1; AJvYcCU+ntEQw36TB//D7/2dLv/BaLqGAbZp8A6TxicEcSK7N1c5BFPJyzTrH6XsDnHKTm+hsZblWvZ4lhvM5FLIfw==@vger.kernel.org, AJvYcCVDwOS7VM2un5U8SbDDpUAHkFEmzPii9KdiRnNiB8ILvK668qOwNXqAQse0LiYHTDX/GkjK90h1hKVaHH+5@vger.kernel.org, AJvYcCVQ25gD3ND+kfnnJ9xxtBD7y5ScWe5yDLG+QsPMWG+5aF6Ex6JMtr1/wuYqi4hU3tKa3IqsccisPp0h@vger.kernel.org, AJvYcCXfnfO2cNje7+mWJ/hEpIjned0YsNS3A3yWpQ2osZ9aNxjQ/ATp3TbWZVvnccUowtoo7gAQ6fX7o6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDyFepvT9v1u7G60RaYr+v1XgI/vA6oRxY2gfpUeei3nWgW3l
	MJUPWDIoVFB908G5YzeC3iaPZx0nwlH5Ievncxvf/A6zv6msMANR
X-Gm-Gg: ASbGncsDV4k/qB2mJiAre0ZNtG2SpLp0uriuI5aclX0KSs8OHZ+UI48u4nDgG624PzJ
	ngEfbGJg9gfsFAeDMNwwNuEZciWCDsJd8e7tUcQRZcc0kzpPcyDQSAJYwJ0P+pAB3+EyIXJn8fa
	Xb1QnaRmb6pVKE0cg03RHj8IcQsPH/Z/josbdedxVobJHK9jNP31m1vOTRgKkXkIshFn8bqtsXV
	dui8y/bXpqS/NOLsq8MvK0Lsn8QeCQALt3EtaXYVhGWTEVm05RhCEmUQaRb9gqcvl9gtrOUpn2d
	vDqubg60Fm4tZNJDTtoA/gy7pSmFg2dvd+sTaoYPQ4T/ZQlrAcnMG4TMQ/ILVBt3X6Fc/WFHYpt
	t3KPl
X-Google-Smtp-Source: AGHT+IH1+yBV/GECKqwdM+T+5fS8mx81YWVmDy89M3OesRg7CwGH5hzmelrPxn+63wTGww6En85fYg==
X-Received: by 2002:a05:6830:6302:b0:72b:9b1f:2e33 with SMTP id 46e09a7af769-730062f241emr5922066a34.18.1745199233976;
        Sun, 20 Apr 2025 18:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.33.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:33:53 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC PATCH 00/19] famfs: port into fuse
Date: Sun, 20 Apr 2025 20:33:27 -0500
Message-Id: <20250421013346.32530-1-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: famfs: port into fuse

This is the initial RFC for the fabric-attached memory file system (famfs)
integration into fuse. In order to function, this requires a related patch
to libfuse [1] and the famfs user space [2]. 

This RFC is mainly intended to socialize the approach and get feedback from
the fuse developers and maintainers. There is some dax work that needs to
be done before this should be merged (see the "poisoned page|folio problem"
below).

This patch set fully works with Linux 6.14 -- passing all existing famfs
smoke and unit tests -- and I encourage existing famfs users to test it.

This is really two patch sets mashed up:

* The patches with the dev_dax_iomap: prefix fill in missing functionality for
  devdax to host an fs-dax file system.
* The famfs_fuse: patches add famfs into fs/fuse/. These are effectively
  unchanged since last year.

Because this is not ready to merge yet, I have felt free to leave some debug
prints in place because we still find them useful; those will be cleaned up
in a subsequent revision.

Famfs Overview

Famfs exposes shared memory as a file system. Famfs consumes shared memory
from dax devices, and provides memory-mappable files that map directly to
the memory - no page cache involvement. Famfs differs from conventional
file systems in fs-dax mode, in that it handles in-memory metadata in a
sharable way (which begins with never caching dirty shared metadata).

Famfs started as a standalone file system [3,4], but the consensus at LSFMM
2024 [5] was that it should be ported into fuse - and this RFC is the first
public evidence that I've been working on that.

The key performance requirement is that famfs must resolve mapping faults
without upcalls. This is achieved by fully caching the file-to-devdax
metadata for all active files. This is done via two fuse client/server
message/response pairs: GET_FMAP and GET_DAXDEV.

Famfs remains the first fs-dax file system that is backed by devdax rather
than pmem in fs-dax mode (hence the need for the dev_dax_iomap fixups).

Notes

* Once the dev_dax_iomap patches land, I suspect it may make sense for
  virtiofs to update to use the improved interface.

* I'm currently maintaining compatibility between the famfs user space and
  both the standalone famfs kernel file system and this new fuse
  implementation. In the near future I'll be running performance comparisons
  and sharing them - but there is no reason to expect significant degradation
  with fuse, since famfs caches entire "fmaps" in the kernel to resolve
  faults with no upcalls. This patch has a bit too much debug turned on to
  to that testing quite yet. A branch 

* Two new fuse messages / responses are added: GET_FMAP and GET_DAXDEV.

* When a file is looked up in a famfs mount, the LOOKUP is followed by a
  GET_FMAP message and response. The "fmap" is the full file-to-dax mapping,
  allowing the fuse/famfs kernel code to handle read/write/fault without any
  upcalls.

* After each GET_FMAP, the fmap is checked for extents that reference
  previously-unknown daxdevs. Each such occurence is handled with a
  GET_DAXDEV message and response.

* Daxdevs are stored in a table (which might become an xarray at some point).
  When entries are added to the table, we acquire exclusive access to the
  daxdev via the fs_dax_get() call (modeled after how fs-dax handles this
  with pmem devices). famfs provides holder_operations to devdax, providing
  a notification path in the event of memory errors.

* If devdax notifies famfs of memory errors on a dax device, famfs currently
  bocks all subsequent accesses to data on that device. The recovery is to
  re-initialize the memory and file system. Famfs is memory, not storage...

* Because famfs uses backing (devdax) devices, only privileged mounts are
  supported.

* The famfs kernel code never accesses the memory directly - it only
  facilitates read, write and mmap on behalf of user processes. As such,
  the RAS of the shared memory affects applications, but not the kernel.

* Famfs has backing device(s), but they are devdax (char) rather than
  block. Right now there is no way to tell the vfs layer that famfs has a
  char backing device (unless we say it's block, but it's not). Currently
  we use the standard anonymous fuse fs_type - but I'm not sure that's
  ultimately optimal (thoughts?)

The "poisoned page|folio problem"

* Background: before doing a kernel mount, the famfs user space [2] validates
  the superblock and log. This is done via raw mmap of the primary devdax
  device. If valid, the file system is mounted, and the superblock and log
  get exposed through a pair of files (.meta/.superblock and .meta/.log) -
  because we can't be using raw device mmap when a file system is mounted
  on the device. But this exposes a devdax bug and warning...

* Pages that have been memory mapped via devdax are left in a permanently
  problematic state. Devdax sets page|folio->mapping when a page is accessed
  via raw devdax mmap (as famfs does before mount), but never cleans it up.
  When the pages of the famfs superblock and log are accessed via the "meta"
  files after mount, we see a WARN_ONCE() in dax_insert_entry(), which
  notices that page|folio->mapping is still set. I intend to address this
  prior to asking for the famfs patches to be merged.

* Alistair Popple's recent dax patch series [6], which has been merged
  for 6.15, addresses some dax issues, but sadly does not fix the poisoned
  page|folio problem - its enhanced refcount checking turns the warning into
  an error.

* This 6.14 patch set disables the warning; a proper fix will be required for
  famfs to work at all in 6.15. Dan W. and I are actively discussing how to do
  this properly...

* In terms of the correct functionality of famfs, the warning can be ignored.

References

[1] - https://github.com/libfuse/libfuse/pull/1200
[2] - https://github.com/cxl-micron-reskit/famfs
[3] - https://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/
[4] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/
[5] - https://lwn.net/Articles/983105/
[6] - https://lore.kernel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com/


John Groves (19):
  dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
  dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
  dev_dax_iomap: Save the kva from memremap
  dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
  dev_dax_iomap: export dax_dev_get()
  dev_dax_iomap: (ignore!) Drop poisoned page warning in fs/dax.c
  famfs_fuse: magic.h: Add famfs magic numbers
  famfs_fuse: Kconfig
  famfs_fuse: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/
  famfs_fuse: Basic fuse kernel ABI enablement for famfs
  famfs_fuse: Basic famfs mount opts
  famfs_fuse: Plumb the GET_FMAP message/response
  famfs_fuse: Create files with famfs fmaps
  famfs_fuse: GET_DAXDEV message and daxdev_table
  famfs_fuse: Plumb dax iomap and fuse read/write/mmap
  famfs_fuse: Add holder_operations for dax notify_failure()
  famfs_fuse: Add famfs metadata documentation
  famfs_fuse: Add documentation
  famfs_fuse: (ignore) debug cruft

 Documentation/filesystems/famfs.rst |  142 ++++
 Documentation/filesystems/index.rst |    1 +
 MAINTAINERS                         |   10 +
 drivers/dax/Kconfig                 |    6 +
 drivers/dax/bus.c                   |  144 +++-
 drivers/dax/dax-private.h           |    1 +
 drivers/dax/device.c                |   38 +-
 drivers/dax/super.c                 |   33 +-
 fs/dax.c                            |    1 -
 fs/fuse/Kconfig                     |   13 +
 fs/fuse/Makefile                    |    4 +-
 fs/fuse/dev.c                       |   61 ++
 fs/fuse/dir.c                       |   74 +-
 fs/fuse/famfs.c                     | 1105 +++++++++++++++++++++++++++
 fs/fuse/famfs_kfmap.h               |  166 ++++
 fs/fuse/file.c                      |   27 +-
 fs/fuse/fuse_i.h                    |   67 +-
 fs/fuse/inode.c                     |   49 +-
 fs/fuse/iomode.c                    |    2 +-
 fs/namei.c                          |    1 +
 include/linux/dax.h                 |    6 +
 include/uapi/linux/fuse.h           |   63 ++
 include/uapi/linux/magic.h          |    2 +
 23 files changed, 1973 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/filesystems/famfs.rst
 create mode 100644 fs/fuse/famfs.c
 create mode 100644 fs/fuse/famfs_kfmap.h


base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
-- 
2.49.0


