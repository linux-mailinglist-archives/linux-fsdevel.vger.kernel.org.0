Return-Path: <linux-fsdevel+bounces-12595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15091861A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384881C25402
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1812DD85;
	Fri, 23 Feb 2024 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDYy67E4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8591182D88;
	Fri, 23 Feb 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710138; cv=none; b=n3IX/r1Jh5f6qg1pE+8mBNkMvmBQ4kfU4yh3SZnBfPGCk79H4wtssOelP5E04/QO2yBGjUK70BJTOxfxnEY+POeDn3xO++8UJIhSIUJvIruWAZ+Szv0+XAImHkAoIONVcvqOWRyGRCrEOkybl7dTzJsmRQlRZLM+mpgJ9/Ef+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710138; c=relaxed/simple;
	bh=45CIggrvbSYXKvaHY7KGJdhor7+F12S8822hZaZDFdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fn+8VhyMaRi4VKtaScJM8lUooi86w/4xfVx/7nCsXHYomjc0x1N6XM8WwHWxP+Ulq/rfkjeDh+B1YBGXnHIFq4HmToNzZ3dxuG3rH5RVWTYLYgizhfARcVEKTX7IGwj+E3Gdufwe/mJKd1jmfWFi2O405gCSk3dYmA7qq4GD+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDYy67E4; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2196dd318f5so278091fac.3;
        Fri, 23 Feb 2024 09:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710134; x=1709314934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VOs0M9nkS0yzOTKfq4PGZx2H6M6L00AxFyaF8Fjn/Y4=;
        b=LDYy67E4S8c1+CEtjb3naM09tuYFilP34XnLZkXV0cR5cMa4etzxx6qHvWVfXsJiJ6
         zwTGtwORS3hhvwzhaCDsGEPU5hE+LGf9+gWeSmeI6TIAV+zLlYCBudQdY2MYvy4++Iyw
         tSQ4zdzMj1bAAzhhtwr2YoVA2iLnAioKQBYqJXw451a7HdUf+xj+eh81VwzmQjeOrhlf
         jnhXQDQSy69/Zy3Bcbn33yGLk5GqkosJ32Q9FFYUGsEaz5Qnr81PHNiL30p/nrHmHgcd
         pDSbj2OD1p4oHXeUOEROuT/7WMgDjuYgjx7sNvWDa1XL1S7I5Jb32APiqGdTbatU7W76
         rMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710134; x=1709314934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOs0M9nkS0yzOTKfq4PGZx2H6M6L00AxFyaF8Fjn/Y4=;
        b=dmT0XqljdComo3BDr42vdLgy+/NAJ0t79n5nUuYiMsycmFcqIP50OKvze8RvQJsOSt
         H+tL5yTf6ZsCCL7Fo3jM4DSDzCaBDrDNA1m1y9RycU+iO+4i5HQcfs3+/bevfBjwTLxJ
         pIobjoR+dmsoV1SgonSBs5MibnSznq7NjFXrfHPWjQ+VuYf0gOcTXzXWX20enm+WuKYZ
         aNETDRZHlK1j4kIbObmgwAx8CK1+RbqrZu0k09Wd2K4Rk10o6XaUfHdpeHJGAMCO2vhJ
         Axs+mU0erdGV4pA5/2pSXqjnH+AsHVmdChM+haxCw3hxgoMcYug0SM9trQoJaFnMIlQE
         1l1w==
X-Forwarded-Encrypted: i=1; AJvYcCXye4baCnFXXA/at6ZCn+SAA5ddqKPeUEMY2RWXk5SDPDyM2/KLBSUVuF/NK8PhnyKttMjmUvIVrPg9i1DG7T3H5OcfUtct6S0EQ+nClHFR3unvug9RrK/6KEuHEyCQ9YYjdJ0T7sqwCG5blHOmZOaSryQII4y/sz7Qfirg4cxSC7K0fNtzA0sqHmZ3r+qOr8yzYeQ1g4N4LSgFD4wF1GUfLA==
X-Gm-Message-State: AOJu0YwT2tf/t9vQ5pR4Han7IeQtLb1umekXVfgtjL1Zo1TucYw6c5f3
	f1gu+u2EYQ3Wx0iIVwWPmc5dY+DEL8DkA/OO/4o2WKqCr+hE1MFW
X-Google-Smtp-Source: AGHT+IFjkMsWuD7PTo/uBIUU5wtpFXzJXrQ7iZqi+uG1xICJciQ29IolMBBzTuVPJbUg68dI2tS2nw==
X-Received: by 2002:a05:6870:918c:b0:21e:a839:d807 with SMTP id b12-20020a056870918c00b0021ea839d807mr594280oaf.54.1708710134348;
        Fri, 23 Feb 2024 09:42:14 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:14 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Date: Fri, 23 Feb 2024 11:41:44 -0600
Message-Id: <cover.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set introduces famfs[1] - a special-purpose fs-dax file system
for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
CXL-specific in anyway way.

* Famfs creates a simple access method for storing and sharing data in
  sharable memory. The memory is exposed and accessed as memory-mappable
  dax files.
* Famfs supports multiple hosts mounting the same file system from the
  same memory (something existing fs-dax file systems don't do).
* A famfs file system can be created on either a /dev/pmem device in fs-dax
  mode, or a /dev/dax device in devdax mode (the latter depending on
  patches 2-6 of this series).

The famfs kernel file system is part the famfs framework; additional
components in user space[2] handle metadata and direct the famfs kernel
module to instantiate files that map to specific memory. The famfs user
space has documentation and a reasonably thorough test suite.

The famfs kernel module never accesses the shared memory directly (either
data or metadata). Because of this, shared memory managed by the famfs
framework does not create a RAS "blast radius" problem that should be able
to crash or de-stabilize the kernel. Poison or timeouts in famfs memory
can be expected to kill apps via SIGBUS and cause mounts to be disabled
due to memory failure notifications.

Famfs does not attempt to solve concurrency or coherency problems for apps,
although it does solve these problems in regard to its own data structures.
Apps may encounter hard concurrency problems, but there are use cases that
are imminently useful and uncomplicated from a concurrency perspective:
serial sharing is one (only one host at a time has access), and read-only
concurrent sharing is another (all hosts can read-cache without worry).

Contents:

* famfs kernel documentation [patch 1]. Note that evolving famfs user
  documentation is at [2]
* dev_dax_iomap patchset [patches 2-6] - This enables fs-dax to use the
  iomap interface via a character /dev/dax device (e.g. /dev/dax0.0). For
  historical reasons the iomap infrastructure was enabled only for
  /dev/pmem devices (which are dax block devices). As famfs is the first
  fs-dax file system that works on /dev/dax, this patch series fills in
  the bare minimum infrastructure to enable iomap api usage with /dev/dax.
* famfs patchset [patches 7-20] - this introduces the kernel component of
  famfs.

IMPORTANT NOTE: There is a developing consensus that /dev/dax requires
some fundamental re-factoring (e.g. [3]) that is related but outside the
scope of this series.

Some observations about using sharable memory

* It does not make sense to online sharable memory as system-ram.
  System-ram gets zeroed when it is onlined, so sharing is basically
  nonsense.
* It does not make sense to put struct page's in sharable memory, because
  those can't be shared. However, separately providing non-sharable
  capacity to be used for struct page's might be a sensible approach if the
  size of struct page array for sharable memory is too large to put in
  conventional system-ram (albeit with possible RAS implications).
* Sharable memory is pmem-like, in that a host is likely to connect in
  order to gain access to data that is already in the memory. Moreover
  the power domain for shared memory is separate for that of the server.
  Having observed that, famfs is not intended for persistent storage. It is
  intended for sharing data sets in memory during a time frame where the
  memory and the compute nodes are expected to remain operational - such
  as during a clustered data analytics job.

Could we do this with FUSE?

The key performance requirement for famfs is efficient handling of VMA
faults. This requires caching the complete dax extent lists for all active
files so faults can be handled without upcalls, which FUSE does not do.
It would probably be possible to put this capability FUSE, but we think
that keeping famfs separate from FUSE is the simpler approach.

This patch set is available as a branch at [5]

References

[1] https://lpc.events/event/17/contributions/1455/
[2] https://github.com/cxl-micron-reskit/famfs
[3] https://lore.kernel.org/all/166630293549.1017198.3833687373550679565.stgit@dwillia2-xfh.jf.intel.com/
[4] https://www.computeexpresslink.org/download-the-specification
[5] https://github.com/cxl-micron-reskit/famfs-linux

John Groves (20):
  famfs: Documentation
  dev_dax_iomap: Add fs_dax_get() func to prepare dax for fs-dax usage
  dev_dax_iomap: Move dax_pgoff_to_phys from device.c to bus.c since
    both need it now
  dev_dax_iomap: Save the kva from memremap
  dev_dax_iomap: Add dax_operations for use by fs-dax on devdax
  dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel build parameter
  famfs: Add include/linux/famfs_ioctl.h
  famfs: Add famfs_internal.h
  famfs: Add super_operations
  famfs: famfs_open_device() & dax_holder_operations
  famfs: Add fs_context_operations
  famfs: Add inode_operations and file_system_type
  famfs: Add iomap_ops
  famfs: Add struct file_operations
  famfs: Add ioctl to file_operations
  famfs: Add fault counters
  famfs: Add module stuff
  famfs: Support character dax via the dev_dax_iomap patch
  famfs: Update MAINTAINERS file
  famfs: Add Kconfig and Makefile plumbing

 Documentation/filesystems/famfs.rst | 124 +++++
 MAINTAINERS                         |  11 +
 drivers/dax/Kconfig                 |   6 +
 drivers/dax/bus.c                   | 131 ++++++
 drivers/dax/dax-private.h           |   1 +
 drivers/dax/device.c                |  38 +-
 drivers/dax/super.c                 |  38 ++
 fs/Kconfig                          |   2 +
 fs/Makefile                         |   1 +
 fs/famfs/Kconfig                    |  10 +
 fs/famfs/Makefile                   |   5 +
 fs/famfs/famfs_file.c               | 704 ++++++++++++++++++++++++++++
 fs/famfs/famfs_inode.c              | 586 +++++++++++++++++++++++
 fs/famfs/famfs_internal.h           | 126 +++++
 include/linux/dax.h                 |   5 +
 include/uapi/linux/famfs_ioctl.h    |  56 +++
 16 files changed, 1821 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/filesystems/famfs.rst
 create mode 100644 fs/famfs/Kconfig
 create mode 100644 fs/famfs/Makefile
 create mode 100644 fs/famfs/famfs_file.c
 create mode 100644 fs/famfs/famfs_inode.c
 create mode 100644 fs/famfs/famfs_internal.h
 create mode 100644 include/uapi/linux/famfs_ioctl.h


base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.43.0


