Return-Path: <linux-fsdevel+bounces-49153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4DAB89C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80BB3B7AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326D1F873B;
	Thu, 15 May 2025 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I740R50G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921C1547C9;
	Thu, 15 May 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320380; cv=none; b=gAjqUcQPQf3QV5ffkLobR5RYTg5o7MZQYB6bZoJAYLakOdI1DHchMWWPxLmPbU5EHzAgw19pbH18lx8P1AyHPM/qXyx6z9AiaM5xH7egpneApSodL2tROD4CxQ91WNajd/zHrDitRaVdP/mWoATizp4F2hJn5zA+/50p4eqCqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320380; c=relaxed/simple;
	bh=2q8M9O+S/coL565msNAQU5FurmU2HFPIfsS0Hl1/BoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTWy0TuQcJJ0ctyZCsRBFnH5rJaeB00rrYqXGCZ5tPqaJm36BifQYBR785zsw+SX+E63xLdKWWME462ukAWzdWbGYz86BEgUSfCGroxShuf0TzYUBmFQmuZ0UCPTFr4ux2bhIHCRsXQjlh285QIdLJD5n33JGLzJg51mChwcDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I740R50G; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376e311086so1365465b3a.3;
        Thu, 15 May 2025 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747320377; x=1747925177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1z36ft2Q2TSzhNT67+m6PB7OOPOom/AXqnpF4hVQ1U=;
        b=I740R50GgX1XHqkoZAVc8mSOM3BubMcWAFXdv8c7pkGPkaIKaeId0hOGoTYlc+PIpm
         ey4NgMhfWRorkqBPkuLdQdUNdtz4CCuXoEg+LP9PlLBnPubkdoYwx8MicIn0qAkOmzVA
         rt8Z6ZF5UAuhSE28DTW+b85ubpT/DqVJbBYsOWZlvoo7H970LjFcEjbylcNJKFojcexx
         qe11uLa/E1Mb/mRa8FRozVGnfSHI7xTGgVpnRBu9Goh6nbYgDNqKjcvEyYzQ6eEVQdAr
         kdVdcA8jaFKGLVZSwMeZa2H8MnFFiYhe/FQCvwaLcG/1XTskOn0NAUG7eof3L40tTija
         /sJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747320377; x=1747925177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1z36ft2Q2TSzhNT67+m6PB7OOPOom/AXqnpF4hVQ1U=;
        b=I/YexctK0h908GAfTPOGgPvH33OEpZO3h7Z3UTv0Cds4/6tyJgkLgq2QSXErxpEjlH
         WpG5dUMfAwnB9V2u45qIsad14TYAKXYo5k8C8NmHrW/Cq2+8NLD17H3+Qz5D8b5ffhS3
         ir1F58nTaEHvNAWINeI1z1PuP+XSXkmAv5qUO3NJmu70IEMCrm74AAVxik4ew6papa5X
         vrdGFTaH4POv2I8+yMcP1DBJaPxOeDxMknghf3+xt8u8nkxBCiTMZYU2oIPgv43SC/AD
         TVWvjx+IXyCfm+H+nWV+t7Cq51BHacVD+84XybetZ+b3uCvDNfO1+cJsuQ5f9pk2JoPN
         9KUg==
X-Forwarded-Encrypted: i=1; AJvYcCUxDka3vZ44ZZ6iPePiz9SWHjiYYR0SLTidnB4qJwPxXXN8syIyxdlGG09r/X548P3MluA+DuibSLhHgcoU@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZwYVds9m0MqnG1CqkNrTOEnoHTq9+6HgoAkJwueSzlvAx8oh
	fxBBpdRuq588IvcXFqduGFKMGU9PZ8Jq+d9mPysDX4b+ki/G0Ln1WyCYGQ==
X-Gm-Gg: ASbGnctZI/mvL0OEv+yVEPnPIosznTmmcNBVY6QG9BUe6JRXVCdD6wL3YHv6i2rjvpM
	OqLHdUNiM2oBwYH+GJLUdk7DhSHulJR+0H11VzhYy4xLmxLEYymL7q/DnH72kYU7v0WheZkDoK1
	cWvH+ALUeLxTo30XbxpQ6c6fPSEW9tFHTvOF1AnvrauSP4OMgzYTX9Sd/ylF8f4ufE/KHyy+MFb
	Kma2IIle1cHgqJtIivhJZwJgYTd8Zvvb9MMvBZBeZInymeZDD2mmGCNpu6qg7wzKMQMNQTHty8M
	jvZtoI0zA5DuRLoa7Wx1hjgzT0/OtXhE4ObHHG0BbjBJIHcnWiuCs9wL
X-Google-Smtp-Source: AGHT+IEpG7kHtQFWZmUxzCVQSTzf1IM3lBMGqRuENqdnIRWGG/BmY3kld04VzrFwScLr4vnj9KpdRw==
X-Received: by 2002:a05:6a21:6b16:b0:1f5:7d57:830f with SMTP id adf61e73a8af0-215ff193b73mr9088741637.33.1747320376588;
        Thu, 15 May 2025 07:46:16 -0700 (PDT)
Received: from dw-tp.in.ibm.com ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6e6a5sm3451a12.17.2025.05.15.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 07:46:15 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 7/7] ext4: Add atomic block write documentation
Date: Thu, 15 May 2025 20:15:39 +0530
Message-ID: <7afb50dbd7e6b81aa43bf5289a6248a66f0c592e.1747289779.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747289779.git.ritesh.list@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an initial documentation around atomic writes support in ext4.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../filesystems/ext4/atomic_writes.rst        | 220 ++++++++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 2 files changed, 221 insertions(+)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
new file mode 100644
index 000000000000..de54eeb6aaae
--- /dev/null
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -0,0 +1,220 @@
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
+``ext4_map_blocks_atomic()``. Only after this allocation, is the write
+operation performed by iomap.
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


