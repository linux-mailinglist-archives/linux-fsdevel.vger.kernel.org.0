Return-Path: <linux-fsdevel+bounces-48984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DD4AB719A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546DB1B64DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE5527CCF6;
	Wed, 14 May 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6USmFF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEF27C15A;
	Wed, 14 May 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240703; cv=none; b=Bf3sFW7M/e571Sa/Rms3eG9hl2c4H3JjjjBTnXHUp/4u2cUP+yK2iv7Kmr2VmzRrcLMqhpvhV0NzpLu2KuRoZ4NDzX67TEA6ECW/W1j/kvIQ0lwFJAAy0pmNX6fTC3YGwlU8aoftNlYfTTg/9oZNt0Zpv3z5wlvN61+6Xj6ffjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240703; c=relaxed/simple;
	bh=Jy3If074Z32HkSPesE5b+unod6LK+aqu+1ALcMzadoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9ZzY2/OZ7ec91AGdBupIEVV8BMOSWsa7i8qSaxMkec+EpERzTrB8J6WMY3oe/eVqV6sfmpayc5IZ/GLsYHeJbc8eLK+UcHgdNZSWYW50tmUMkBAJE8FmnHWBQrVjMlyLGCcFTMy7DzBD6c20ZkOPwpdvKfadTR+zB5CAsG6uOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6USmFF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB73C4CEEF;
	Wed, 14 May 2025 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747240703;
	bh=Jy3If074Z32HkSPesE5b+unod6LK+aqu+1ALcMzadoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6USmFF3SZnCWugStjEkz9biom/qWxG4CXugg95NyLWG5nG2548CPPLP7/hpYZlYp
	 Iy6muTII8iTZzaWn5OGbcVtOz4mrYRFD/dqDJccd3Y1qynipOzGYbusOCOUtX811sz
	 xTGLJ0YjNNE80Ja6QFau1+WDs/wKyBpmeYDgUY8iN3D7zV9OaOK6GV2bnQEYq3zajM
	 fvpGZ4w+AHqeY+Agdc+O/99nP6K3b3wKlvX/bPmkhU7eYYKJNtaEuZIRs4fivUdxUJ
	 i5zEBBmWSOgYUyOPNtdAkTgSGBqZfGBj/LpA/5HH587OOzA2INvmqziiSTUClbYPuW
	 pP7dbdL68w3oA==
Date: Wed, 14 May 2025 09:38:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ext4: Add atomic block write documentation
Message-ID: <20250514163822.GM25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <a4726b81fbc29426e42b15cac6049ee7a0cba7e8.1746734746.git.ritesh.list@gmail.com>
 <aB2v7TKtQv-Kch09@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aB2v7TKtQv-Kch09@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, May 09, 2025 at 01:04:05PM +0530, Ojaswin Mujoo wrote:
> On Fri, May 09, 2025 at 02:20:37AM +0530, Ritesh Harjani (IBM) wrote:
> > Add an initial documentation around atomic writes support in ext4.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> Hi Ritesh,
> 
> THe docs look mostly good. I'll add some feedback below:
> > ---
> >  .../filesystems/ext4/atomic_writes.rst        | 208 ++++++++++++++++++
> >  Documentation/filesystems/ext4/overview.rst   |   1 +
> >  2 files changed, 209 insertions(+)
> >  create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst
> > 
> > diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
> > new file mode 100644
> > index 000000000000..59b03d8dbb79
> > --- /dev/null
> > +++ b/Documentation/filesystems/ext4/atomic_writes.rst
> > @@ -0,0 +1,208 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. _atomic_writes:
> > +
> > +Atomic Block Writes
> > +-------------------------
> > +
> > +Introduction
> > +~~~~~~~~~~~~
> > +
> > +Atomic (untorn) block writes ensure that either the entire write is committed
> > +to disk or none of it is. This prevents "torn writes" during power loss or
> > +system crashes. The ext4 filesystem supports atomic writes (only with Direct
> > +I/O) on regular files with extents, provided the underlying storage device
> > +supports hardware atomic writes. This is supported in the following two ways:
> > +
> > +1. **Single-fsblock Atomic Writes**:
> > +   EXT4's supports atomic write operations with a single filesystem block since
> > +   v6.13. In this the atomic write unit minimum and maximum sizes are both set
> > +   to filesystem blocksize.
> > +   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
> > +   pagesize system is possible.
> > +
> > +2. **Multi-fsblock Atomic Writes with Bigalloc**:
> > +   EXT4 now also supports atomic writes spanning multiple filesystem blocks
> > +   using a feature known as bigalloc. The atomic write unit's minimum and
> > +   maximum sizes are determined by the filesystem block size and cluster size,
> > +   based on the underlying device’s supported atomic write unit limits.
> > +
> > +Requirements
> > +~~~~~~~~~~~~
> > +
> > +Basic requirements for atomic writes in ext4:
> > +
> > + 1. The extents feature must be enabled (default for ext4)
> > + 2. The underlying block device must support atomic writes
> > + 3. For single-fsblock atomic writes:
> > +
> > +    1. A filesystem with appropriate block size (up to the page size)
> > + 4. For multi-fsblock atomic writes:
> > +
> > +    1. The bigalloc feature must be enabled
> > +    2. The cluster size must be appropriately configured
> > +
> > +NOTE: EXT4 does not support software or COW based atomic write, which means
> > +atomic writes on ext4 are only supported if underlying storage device supports
> > +it.
> > +
> > +Multi-fsblock Implementation Details
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The bigalloc feature changes ext4 to use clustered allocations. With bigalloc

I would say "...changes ext4 to allocate in units of multiple fs blocks,
also known as clusters." so that the definition of a cluster is right
there in the first sentence instead of the second.

> > +each bit within block bitmap represents clusters (power of 2 number of blocks)
> > +rather than individual filesystem blocks. EXT4 supports atomic writes using
> > +bigalloc by making sure that atomic write min and max are within [blocksize,
> > +clustersize].
> 
> Should we add a line like:
> 
> Atomic write max unit is capped to the max supported by the underlying
> device, incase it is less than the clustersize.

I think the documentation should say exactly what the untorn write
geometry is constrained to:

"EXT4 supports multi-fsblock atomic writes with bigalloc, subject to the
following constraints: The minimum atomic write size is the larger of
the fs block size and the minimum hardware atomic write unit; and the
maximum atomic write size is smaller of the bigalloc cluster size and
the maximum hardware atomic write unit.  Bigalloc ensures that all
allocations are aligned to the cluster size, which satisfies the LBA
alignment requirements of the hardware device if the start of the
partition/logical volume is itself aligned correctly."

> Also, maybe we can have a line wiht something like "With bigalloc's
> clustered allocation we can be sure that an atomic write will always
> be allocated aligned blocks. The only thing we need to ensure is that
> we have a continuous mapping in the write rang."
> 	
> > +
> > +Here is the block allocation strategy in bigalloc for atomic writes:
> > +
> > + * For regions with fully mapped extents, no additional allocation is needed

"No additional work is needed" ?

> > + * For append writes, a new mapped extent is allocated
> > + * For regions that are entirely holes, unwritten extent is created
> > + * For large unwritten extents, the extent gets split into two unwritten
> > +   extents of appropriate requested size
> 
> Are the above 4 points needed explicitly? Maybe we can have:
> 
> Append writes, and writes on regions that are fully mapped,
> unwritten or hole follow the same flow as non atomic writes.
> 
> > + * For mixed mapping regions (combinations of holes, unwritten extents, or
> > +   mapped extents), ext4_map_blocks() is called in a loop with
> > +   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
> > +   mapped extent
> Maybe:
> 
> ... single continuous mapped extents by writing zeroes to it 
> 
> So that we explicitly mention what we are doing and not rely on people
> knowing the meaning of EXT4_GET_BLOCKS_ZERO flag.

(Yeah.)

> > +Note: Writing on a single contiguous underlying extent, whether mapped or
> > +unwritten, is not inherently problematic. However, writing to a mixed mapping
> > +region (i.e. one containing a combination of mapped and unwritten extents)
> > +must be avoided when performing atomic writes.
> > +
> > +The reason is that, atomic writes when issued via pwritev2() with the RWF_ATOMIC
> > +flag, requires that either all data is written or none at all. In the event of
> > +a system crash or unexpected power loss during the write operation, the affected
> > +region (when later read) must reflect either the complete old data or the
> > +complete new data, but never a mix of both.
> > +
> > +To enforce this guarantee, we ensure that the write target is backed by
> > +a single, contiguous extent before any data is written. This is critical because
> > +ext4 defers the conversion of unwritten extents to written extents until the I/O
> > +completion path (typically in ->end_io()). If a write is allowed to proceed over
> > +a mixed mapping region (with mapped and unwritten extents) and a failure occurs
> > +mid-write, the system could observe partially updated regions after reboot, i.e.
> > +new data over mapped areas, and stale (old) data over unwritten extents that
> > +were never marked written. This violates the atomicity and/or torn write
> > +prevention guarantee.
> > +
> > +To prevent such torn writes, ext4 proactively allocates a single contiguous
> > +extent for the entire requested region in ``ext4_iomap_alloc`` via
> > +``ext4_map_blocks_atomic()``. Only after this allocation, is the write
> > +operation performed by iomap.
> > +
> > +Handling Split Extents Across Leaf Blocks
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +There can be a special edge case where we have logically and physically
> > +contiguous extents stored in separate leaf nodes of the on-disk extent tree.
> > +This occurs because on-disk extent tree merges only happens within the leaf
> > +blocks except for a case where we have 2-level tree which can get merged and
> > +collapsed entirely into the inode.

Aha, I guess this is the answer to my earlier question. :)

> > +If such a layout exists and, in the worst case, the extent status cache entries
> > +are reclaimed due to memory pressure, ``ext4_map_blocks()`` may never return
> > +a single contiguous extent for these split leaf extents.
> > +
> > +To address this edge case, a new get block flag
> > +``EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS flag`` is added to enhance the
> > +``ext4_map_query_blocks()`` lookup behavior.
> > +
> > +This new get block flag allows ``ext4_map_blocks()`` to first checks if there is
> 
> s/checks/check
> 
> > +an entry in the extent status cache for the full range.
> > +If not present, it consults the on-disk extent tree using
> > +``ext4_map_query_blocks()``.
> > +If the located extent is at the end of a leaf node, it probes the next logical
> > +block (lblk) to detect a contiguous extent in the adjacent leaf.
> > +
> > +For now only one additional leaf block is queried to maintain efficiency, as
> > +atomic writes are typically constrained to small sizes
> > +(e.g. [blocksize, clustersize]).
> > +
> > +
> > +Handling Journal transactions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +To support multi-fsblock atomic writes, we ensure enough journal credits are
> > +reserved during:
> > +
> > + 1. Block allocation time in ``ext4_iomap_alloc()``. We first query if there
> > +    could be a mixed mapping for the underlying requested range. If yes, then we
> > +    reserve credits of up to ``m_len``, assuming every alternate block can be
> > +    an unwritten extent followed by a hole.
> > +
> > + 2. During ``->end_io()`` call, we make sure a single transaction is started for
> > +    doing unwritten-to-written conversion. The loop for conversion is mainly
> > +    only required to handle a split extent across leaf blocks.
> > +
> > +How to
> > +------
> > +
> > +Creating Filesystems with Atomic Write Support
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For single-fsblock atomic writes with a larger block size
> > +(on systems with block size < page size):
> > +
> > +.. code-block:: bash
> > +
> > +    # Create an ext4 filesystem with a 16KB block size
> > +    # (requires page size >= 16KB)
> > +    mkfs.ext4 -b 16384 /dev/device
> > +
> > +For multi-fsblock atomic writes with bigalloc:
> > +
> > +.. code-block:: bash
> > +
> > +    # Create an ext4 filesystem with bigalloc and 64KB cluster size
> > +    mkfs.ext4 -F -O bigalloc -b 4096 -C 65536 /dev/device
> > +
> > +Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in bytes,
> > +and ``-O bigalloc`` enables the bigalloc feature.

Might want to add at least a sentence about "figure out what atomic
write unit your application needs by querying statx of the block device
or whatever.  Or refer them to the "Hardware Support" section. :)

> > +
> > +Application Interface
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
> > +to perform atomic writes:
> > +
> > +.. code-block:: c
> > +
> > +    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
> > +
> > +The write must be aligned to the filesystem's block size and not exceed the
> > +filesystem's maximum atomic write unit size.
> > +See ``generic_atomic_write_valid()`` for more details.
> > +
> > +``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
> > +details:
> > +
> > + * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
> > + * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
> > + * ``stx_atomic_write_segments_max``: Upper limit for segments. Tthe number of

s/Tthe/The/

> > +   separate memory buffers that can be gathered into a write operation
> > +   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
> > +
> > +The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
> > +writes are supported.
> > +
> > +Hardware Support
> > +----------------
> > +
> > +The underlying storage device must support atomic write operations.
> > +Modern NVMe and SCSI devices often provide this capability.
> > +The Linux kernel exposes this information through sysfs:
> > +
> > +* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
> > +* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
> > +
> > +Nonzero values for these attributes indicate that the device supports
> > +atomic writes.

The rest fits with my understanding of atomic untorn writes.

--D

> > +
> > +See Also
> > +--------
> > +
> > +* :doc:`bigalloc` - Documentation on the bigalloc feature
> > +* :doc:`allocators` - Documentation on block allocation in ext4
> > +* Support for atomic block writes in 6.13:
> > +  https://lwn.net/Articles/1009298/
> > diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
> > index 0fad6eda6e15..9d4054c17ecb 100644
> > --- a/Documentation/filesystems/ext4/overview.rst
> > +++ b/Documentation/filesystems/ext4/overview.rst
> > @@ -25,3 +25,4 @@ order.
> >  .. include:: inlinedata.rst
> >  .. include:: eainode.rst
> >  .. include:: verity.rst
> > +.. include:: atomic_writes.rst
> > -- 
> > 2.49.0
> > 
> 

