Return-Path: <linux-fsdevel+bounces-49187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F44AB902E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4043B4A725A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D642828136E;
	Thu, 15 May 2025 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df27wEl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3021E480;
	Thu, 15 May 2025 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338706; cv=none; b=ncrMpjf1ILW71WnGl5yECLVFtVqbqvN/Q4BfKJ/M+uIX5n4Cerw5LV41ZJMkRJ2dyEKGVJFHMm+GjmmWptpF6yvssnENC3q6k7MKGSii7iWZJY9NQFLCilyHlPqijHPp+P9La0Q8nfZMmHfZ3OAnVknr9zf0LAxiulKJoYuhm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338706; c=relaxed/simple;
	bh=7p5RK2K+s7GpOSw9KOOVm2GPG+XSpmDQyxfaPwvhJtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXQ1MlC+kbDLeVI3QhUTS+1kV0iyBMD6MRtKsslKsppuxh09k2DkXI5YjK/4jsMFM+ekssNishlGKuCZ9MwMoSUVyIZHnPHpDpNPghjypzQfNIORMKrNN8+B2kDPZPbV5hKdCvjA2STeYBU5K35W1pENa4ueOnIxI/2ko1LI8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df27wEl3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74237a74f15so1954842b3a.0;
        Thu, 15 May 2025 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338703; x=1747943503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdwbWKXK4Q0aJ8LFb4lfGZ8vu51DssaOSoSPDam9uW8=;
        b=df27wEl3tGnW7a68/5xPS6kjiOXpZmoqwY/Z9S/Xyaen5e8Q4bNcepE86xevTR0Fur
         Ytprggs3oxvOBIgXZVKlrF5qHevdXxxudsmia8DcJtECf4xfnSotBfBVduXUFmt2xy0M
         853ehjKiQxhJfhH8s164k5i7VygPXQpRboL6Ai7Of3uZFSw2QnZQY8oi3CLDIdIzIuLN
         3/qWgPk6cN49Hr/14lBCI6w71QoT6PPn/G4WaqMsjTF++QhdaJ6jBWy5lNrvHF8mXe8q
         F+kievUG36rbPCl3JS7gpxG7tETgJb0rv5KZE3lEcU1JrjHyBUCzgzl1CJzWQwGxEgla
         52Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338703; x=1747943503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdwbWKXK4Q0aJ8LFb4lfGZ8vu51DssaOSoSPDam9uW8=;
        b=YwG4Y25p701icQfX88Db9vamy1AiS2nE5OJZMJcG/cQ8Z2pRiEuMuB2HzffJIhUtD2
         Uke6Gv6oub3U+q7HltfSzkF28mKMsrKdna7wZCVi8z3w/t5T/OLAumCbg5P2tR0tuPDq
         WlqNcRZCE+Jy0+hoT2r6ehET42EzxZM0Co7UbUL9BDDq83IxGBNli8YpUsnmM6GE/jsx
         2yGI3OQaRryZLGJnpVCv4sLFgmqrRzbeUH8RCXoctikUDnrFdyCpPaeBXJFRUoiySWkT
         6dpvGjMoBQXzvkSBoVxFnvsMPsEOy18tk0ilN0Pvs1Nk5qzdpKqZeiU8UBayWwhvLSik
         Nwqg==
X-Forwarded-Encrypted: i=1; AJvYcCUuesGyYGbRCrGVV3PyzjQR1A3BL5OOdG4mfiFU9VPBt3K3wvHVLMD9pM5YBftZg1v5vIOd3UYKaFwYjWVj@vger.kernel.org
X-Gm-Message-State: AOJu0YyRf5xJK0jbBA1Zprp+tKpKI5Isihrn8GzfIQt4SRum7SKvdYnh
	RCs2L0/GKC1UnfNSHV2yAwTHOGGNOc+/tlDQBWvGwGegtwpH/31HKlFTF5b4tg==
X-Gm-Gg: ASbGnct6CCPQY0bqx2/e1oJD7qwHGn7cRXK143PwVEx3TnF+xvJeI2s2bMu6CIHzy6Z
	z9/K9YaZVlC+uSQTeW1MDYHcMhOEaTTAGM0m0vylCeOnNVDV5NIL02+xHBLaGsGRBRe9yMNmYgX
	HSWQF5/+A/cxTIIh+0rG6IsSbZpdcEBzPgFrdlORou1MQtxUlU/NjV6At/YW89855+A3mNXrUdU
	xQwLSNqQ/10dzB/C3f4u1MR0H+/l6yGKF245MnA/vhEpwvhzbujTo/3ANQaHckd32RfTcAaeT9P
	oRH1Az3l2rasoa8D/gAvQ7PqkxQfQPNvzKt4iTNQzhdUOSgZhGbaWudL6g==
X-Google-Smtp-Source: AGHT+IFMFj+hFwjc99EFtOalsN0UPwU1gzJiChceDafiFQCpguvOA/cR4i/h50JrOICiNwsXky/OpQ==
X-Received: by 2002:a05:6a00:91d4:b0:736:457b:9858 with SMTP id d2e1a72fcca58-742a97c9d2bmr717278b3a.10.1747338692570;
        Thu, 15 May 2025 12:51:32 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:32 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 7/7] ext4: Add atomic block write documentation
Date: Fri, 16 May 2025 01:20:55 +0530
Message-ID: <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an initial documentation around atomic writes support in ext4.

Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../filesystems/ext4/atomic_writes.rst        | 225 ++++++++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 2 files changed, 226 insertions(+)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
new file mode 100644
index 000000000000..f65767df3620
--- /dev/null
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -0,0 +1,225 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _atomic_writes:
+
+Atomic Block Writes
+-------------------------
+
+Introduction
+~~~~~~~~~~~~
+
+Atomic (untorn) block writes ensure that either the entire write is committed
+to disk or none of it is. This prevents "torn writes" during power loss or
+system crashes. The ext4 filesystem supports atomic writes (only with Direct
+I/O) on regular files with extents, provided the underlying storage device
+supports hardware atomic writes. This is supported in the following two ways:
+
+1. **Single-fsblock Atomic Writes**:
+   EXT4's supports atomic write operations with a single filesystem block since
+   v6.13. In this the atomic write unit minimum and maximum sizes are both set
+   to filesystem blocksize.
+   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
+   pagesize system is possible.
+
+2. **Multi-fsblock Atomic Writes with Bigalloc**:
+   EXT4 now also supports atomic writes spanning multiple filesystem blocks
+   using a feature known as bigalloc. The atomic write unit's minimum and
+   maximum sizes are determined by the filesystem block size and cluster size,
+   based on the underlying device’s supported atomic write unit limits.
+
+Requirements
+~~~~~~~~~~~~
+
+Basic requirements for atomic writes in ext4:
+
+ 1. The extents feature must be enabled (default for ext4)
+ 2. The underlying block device must support atomic writes
+ 3. For single-fsblock atomic writes:
+
+    1. A filesystem with appropriate block size (up to the page size)
+ 4. For multi-fsblock atomic writes:
+
+    1. The bigalloc feature must be enabled
+    2. The cluster size must be appropriately configured
+
+NOTE: EXT4 does not support software or COW based atomic write, which means
+atomic writes on ext4 are only supported if underlying storage device supports
+it.
+
+Multi-fsblock Implementation Details
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The bigalloc feature changes ext4 to allocate in units of multiple filesystem
+blocks, also known as clusters. With bigalloc each bit within block bitmap
+represents cluster (power of 2 number of blocks) rather than individual
+filesystem blocks.
+EXT4 supports multi-fsblock atomic writes with bigalloc, subject to the
+following constraints. The minimum atomic write size is the larger of the fs
+block size and the minimum hardware atomic write unit; and the maximum atomic
+write size is smaller of the bigalloc cluster size and the maximum hardware
+atomic write unit.  Bigalloc ensures that all allocations are aligned to the
+cluster size, which satisfies the LBA alignment requirements of the hardware
+device if the start of the partition/logical volume is itself aligned correctly.
+
+Here is the block allocation strategy in bigalloc for atomic writes:
+
+ * For regions with fully mapped extents, no additional work is needed
+ * For append writes, a new mapped extent is allocated
+ * For regions that are entirely holes, unwritten extent is created
+ * For large unwritten extents, the extent gets split into two unwritten
+   extents of appropriate requested size
+ * For mixed mapping regions (combinations of holes, unwritten extents, or
+   mapped extents), ext4_map_blocks() is called in a loop with
+   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
+   mapped extent by writing zeroes to it and converting any unwritten extents to
+   written, if found within the range.
+
+Note: Writing on a single contiguous underlying extent, whether mapped or
+unwritten, is not inherently problematic. However, writing to a mixed mapping
+region (i.e. one containing a combination of mapped and unwritten extents)
+must be avoided when performing atomic writes.
+
+The reason is that, atomic writes when issued via pwritev2() with the RWF_ATOMIC
+flag, requires that either all data is written or none at all. In the event of
+a system crash or unexpected power loss during the write operation, the affected
+region (when later read) must reflect either the complete old data or the
+complete new data, but never a mix of both.
+
+To enforce this guarantee, we ensure that the write target is backed by
+a single, contiguous extent before any data is written. This is critical because
+ext4 defers the conversion of unwritten extents to written extents until the I/O
+completion path (typically in ->end_io()). If a write is allowed to proceed over
+a mixed mapping region (with mapped and unwritten extents) and a failure occurs
+mid-write, the system could observe partially updated regions after reboot, i.e.
+new data over mapped areas, and stale (old) data over unwritten extents that
+were never marked written. This violates the atomicity and/or torn write
+prevention guarantee.
+
+To prevent such torn writes, ext4 proactively allocates a single contiguous
+extent for the entire requested region in ``ext4_iomap_alloc`` via
+``ext4_map_blocks_atomic()``. EXT4 also force commits the current journalling
+transaction in case if allocation is done over mixed mapping. This ensures any
+pending metadata updates (like unwritten to written extents conversion) in this
+range are in consistent state with the file data blocks, before performing the
+actual write I/O. If the commit fails, the whole I/O must be aborted to prevent
+from any possible torn writes.
+Only after this step, the actual data write operation is performed by the iomap.
+
+Handling Split Extents Across Leaf Blocks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+There can be a special edge case where we have logically and physically
+contiguous extents stored in separate leaf nodes of the on-disk extent tree.
+This occurs because on-disk extent tree merges only happens within the leaf
+blocks except for a case where we have 2-level tree which can get merged and
+collapsed entirely into the inode.
+If such a layout exists and, in the worst case, the extent status cache entries
+are reclaimed due to memory pressure, ``ext4_map_blocks()`` may never return
+a single contiguous extent for these split leaf extents.
+
+To address this edge case, a new get block flag
+``EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS flag`` is added to enhance the
+``ext4_map_query_blocks()`` lookup behavior.
+
+This new get block flag allows ``ext4_map_blocks()`` to first check if there is
+an entry in the extent status cache for the full range.
+If not present, it consults the on-disk extent tree using
+``ext4_map_query_blocks()``.
+If the located extent is at the end of a leaf node, it probes the next logical
+block (lblk) to detect a contiguous extent in the adjacent leaf.
+
+For now only one additional leaf block is queried to maintain efficiency, as
+atomic writes are typically constrained to small sizes
+(e.g. [blocksize, clustersize]).
+
+
+Handling Journal transactions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To support multi-fsblock atomic writes, we ensure enough journal credits are
+reserved during:
+
+ 1. Block allocation time in ``ext4_iomap_alloc()``. We first query if there
+    could be a mixed mapping for the underlying requested range. If yes, then we
+    reserve credits of up to ``m_len``, assuming every alternate block can be
+    an unwritten extent followed by a hole.
+
+ 2. During ``->end_io()`` call, we make sure a single transaction is started for
+    doing unwritten-to-written conversion. The loop for conversion is mainly
+    only required to handle a split extent across leaf blocks.
+
+How to
+------
+
+Creating Filesystems with Atomic Write Support
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+First check the atomic write units supported by block device.
+See :ref:`atomic_write_bdev_support` for more details.
+
+For single-fsblock atomic writes with a larger block size
+(on systems with block size < page size):
+
+.. code-block:: bash
+
+    # Create an ext4 filesystem with a 16KB block size
+    # (requires page size >= 16KB)
+    mkfs.ext4 -b 16384 /dev/device
+
+For multi-fsblock atomic writes with bigalloc:
+
+.. code-block:: bash
+
+    # Create an ext4 filesystem with bigalloc and 64KB cluster size
+    mkfs.ext4 -F -O bigalloc -b 4096 -C 65536 /dev/device
+
+Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in bytes,
+and ``-O bigalloc`` enables the bigalloc feature.
+
+Application Interface
+~~~~~~~~~~~~~~~~~~~~~
+
+Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
+to perform atomic writes:
+
+.. code-block:: c
+
+    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
+
+The write must be aligned to the filesystem's block size and not exceed the
+filesystem's maximum atomic write unit size.
+See ``generic_atomic_write_valid()`` for more details.
+
+``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
+details:
+
+ * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
+ * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
+ * ``stx_atomic_write_segments_max``: Upper limit for segments. The number of
+   separate memory buffers that can be gathered into a write operation
+   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
+
+The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
+writes are supported.
+
+.. _atomic_write_bdev_support:
+
+Hardware Support
+----------------
+
+The underlying storage device must support atomic write operations.
+Modern NVMe and SCSI devices often provide this capability.
+The Linux kernel exposes this information through sysfs:
+
+* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
+* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
+
+Nonzero values for these attributes indicate that the device supports
+atomic writes.
+
+See Also
+--------
+
+* :doc:`bigalloc` - Documentation on the bigalloc feature
+* :doc:`allocators` - Documentation on block allocation in ext4
+* Support for atomic block writes in 6.13:
+  https://lwn.net/Articles/1009298/
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index 0fad6eda6e15..9d4054c17ecb 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -25,3 +25,4 @@ order.
 .. include:: inlinedata.rst
 .. include:: eainode.rst
 .. include:: verity.rst
+.. include:: atomic_writes.rst
-- 
2.49.0


