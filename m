Return-Path: <linux-fsdevel+bounces-48523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3670AAB04FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A253D52461D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9248221284;
	Thu,  8 May 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSUJ3M8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A3212B02;
	Thu,  8 May 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737489; cv=none; b=orT0azMdpof7YBXR00g85d2ig7q6o+b4DrODOei5JJ/eg1yap3G1nfXNUBeinpWWPYYuHN0UvNwNyYlD/u8ZZIBFmvJ7enBaGA6WWtGGGgmwVlkHOdorUSkXwADR8GJGyYM5fWgJ64bABprSp1/K+wQJ9BQ7TyorFtNiOfe5HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737489; c=relaxed/simple;
	bh=XuFL4YT9X638BBAuqXcCXZCZQWERioY9o5dBCKUeSdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIP0i0ZVU/8xAKHDLw8xP6dJG2w8uK9j8BPlDEMxsBbPuRAKRrxY00TrbXhsVK9pl6xElv4/RLjUXCXvVbzPhISJYvU2Q6J2EjKfU66sbGBIG3W9vrZEnSJ9iWeS9LeSMgWcWS5oX1BiWG48YC4/HUD28uVAKHn/GFU4aJLTE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSUJ3M8j; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7396f13b750so1655126b3a.1;
        Thu, 08 May 2025 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737486; x=1747342286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZUfOdIcT3cR2wUqktyqs5qBXvZ91ZMKCsPvIRJjvRU=;
        b=ZSUJ3M8jH+44nj6M6w8yJSlDd6KkAo6G/7NvJpthWkY1dHKYbxEFequK0lBU/Rxjyx
         FI/HY1nemeOMHfANYr1Q3mSWj3f9O8r5+vJp/ry1bQ2ew8hPVX9VGv8TR3iI8PRCV1Mk
         uatVVpGa7DJc43d3gpJ3Mvz8okD32/nYB/D3XtjvDl6q4mNDfwm0bOeI2wcfbzs0d3u7
         jTSVe8LKyYrrFYmWOil72/BFx5+aJG5Lf4+3gSw5JAtiul8I9yJKD0bPxxlTrAOLhN7a
         Y7HYAdIlwoD4hWefaAZaf/ZYY8UGmJUeDGPD4OzNjn3jPXxgP+B1SzsJ7WNq3wpSj2LO
         hARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737486; x=1747342286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZUfOdIcT3cR2wUqktyqs5qBXvZ91ZMKCsPvIRJjvRU=;
        b=dwEwwXUcyKP22H1jKrUae8j9CxD3xQWyu9xC24IPsPK7RQD+6JpGf9BbKSdBDovD5R
         6Ff78jLO9SKyPxBNW65zrjvfrISdcqYIiySkGdY4xlfGgUJI89qakypPdyWLSeIfCPrx
         nDCGLitLXNkVEJ0OIZX184VuyEWJnkfBhWLjrnnPKIOpU9FeWwSW1RAn9tdM4XoQuyxy
         WOjeNR95L/04mFtorEz4Zah6X+WJNxoKnPUvjnKYsjTj1uPYb3Q8aKkxYtrpB6iwVQDQ
         mor5jAP2qpTRu8JnKmLLJj5pFWO6jtxLJI/ahGhkN0ZViZrYGx5sn47QoUadJP2nK2d8
         PMyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWho41baWY5ahaRNfOHBF+IwPsyfX9naRGbFDkQdisRyqOeNmLCJc5kpyJW5IrpdzJR6OkgLEb+sAxHGWfn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzylwb/DuBe9WHB0I/OpTIzWiOxIEc7LDFt2f1AJNmbk0LtDVUY
	y7DlFbfVrt1CooAZFFgi0Ggz4H/RB9xfY3if8QDtKBdCGIPiOz6E9ut6eQ==
X-Gm-Gg: ASbGncvJaS3i1CnCcnpdwc+LPeeL+4Ct8vdYoUhWrYHMy9EbHhnz+H1EPI40rtPPMNH
	kPBmrr3A8k3XplXI+EWS7SyWxolGZGlBMOHpmM6v+Mf/ZNn9WuqMHZ8d6g1vCw5XuBx/DGm2bBI
	5FF+/MGzjR8qYrl8WjJV1o8O1o3EGMA56QDkAQ0HVTMG509feqxHsGasfpLgJmAKzgOCPsfaYB7
	ZZVPrk9BjYLt12Rq6pdbra57fvuk6DxtFKv4kVGkH7LsNPRFiR2SKKI/PGhD3G1QTqcQsU19apz
	4ULUKIL1tYTL4AzgHDECLDoIzy725Fxf9Yq9qTR+W7yI770=
X-Google-Smtp-Source: AGHT+IFC6YQbBPA+NhywPkGJzUUJLdxNgWE4mYFu1dDaksHtEIjWf1GGxfxdlFAQ9fTiEVOaNolQpA==
X-Received: by 2002:a05:6a00:3d0f:b0:73b:71a9:a5ad with SMTP id d2e1a72fcca58-7423bfe4cecmr958766b3a.16.1746737486102;
        Thu, 08 May 2025 13:51:26 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a97de2sm463763b3a.175.2025.05.08.13.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 13:51:25 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 7/7] ext4: Add atomic block write documentation
Date: Fri,  9 May 2025 02:20:37 +0530
Message-ID: <a4726b81fbc29426e42b15cac6049ee7a0cba7e8.1746734746.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746734745.git.ritesh.list@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
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
 .../filesystems/ext4/atomic_writes.rst        | 208 ++++++++++++++++++
 Documentation/filesystems/ext4/overview.rst   |   1 +
 2 files changed, 209 insertions(+)
 create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
new file mode 100644
index 000000000000..59b03d8dbb79
--- /dev/null
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -0,0 +1,208 @@
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
+The bigalloc feature changes ext4 to use clustered allocations. With bigalloc
+each bit within block bitmap represents clusters (power of 2 number of blocks)
+rather than individual filesystem blocks. EXT4 supports atomic writes using
+bigalloc by making sure that atomic write min and max are within [blocksize,
+clustersize].
+
+Here is the block allocation strategy in bigalloc for atomic writes:
+
+ * For regions with fully mapped extents, no additional allocation is needed
+ * For append writes, a new mapped extent is allocated
+ * For regions that are entirely holes, unwritten extent is created
+ * For large unwritten extents, the extent gets split into two unwritten
+   extents of appropriate requested size
+ * For mixed mapping regions (combinations of holes, unwritten extents, or
+   mapped extents), ext4_map_blocks() is called in a loop with
+   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
+   mapped extent
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
+This new get block flag allows ``ext4_map_blocks()`` to first checks if there is
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
+ * ``stx_atomic_write_segments_max``: Upper limit for segments. Tthe number of
+   separate memory buffers that can be gathered into a write operation
+   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
+
+The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
+writes are supported.
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


