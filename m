Return-Path: <linux-fsdevel+bounces-48540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922EAB0BCD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114FA9E754A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE2C270ED1;
	Fri,  9 May 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YRtuTAzl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240526A1DA;
	Fri,  9 May 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776073; cv=none; b=SciF11Jz2SY2D6Y4G6DaNFvgQ5ZvdDmlEjiHHcDOT9mQG2XWw0Tgtw7UQLmSX+9JmwaZYn1rFKLogl2jmQk0vknH1Xbc+iLPRYXA20XPG1NTQaKxUCPiiAb547thKu1uCLUqNwoV2cXVCti/VCGkEychoMl/pdpHlDmFC6lICQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776073; c=relaxed/simple;
	bh=YfjpD0+AJ7BKmiCUua4cSoIYiiaPSn2mUE5aXqAE3I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuauxBn2EvgvyOUJqMZnT8J3rqGFKtYYtZTmO3K+l6mkgL6RcB9wdvTPVxzvWUz3jvp1zkAvHE0qNTWDgv+4fnsZraCU9CUnR95Bxq6xkDCZH7/BZ6bmWCeNzP2IL66rDnZi/H/QV2WsifbFPbnQ4kaaUB0Bk5eLjDe+bXW/Wo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YRtuTAzl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvDW012184;
	Fri, 9 May 2025 07:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1/jRKD
	xjUa8eocs0Y21zvtzLDLtzQvQv33+vDQc/ji4=; b=YRtuTAzlv1MuUFvjM61ETM
	iRdhFqxhQ/F29JpddfE8a7K9yyXRoIcU6byPlnv5+dzNQviKo5sbSceytf7JKu3B
	+RiD9Z1jk1Q/UbwdXE30+bIsqSoZLz1izbE1KXV0M+IG8Z/OvaJJrk0Dz7SWoden
	J4cGN+sQ/gYXG32WaqC9sMd3xnNm08IsURqoCH7wewflDoc6g19GkbszvEEhgNWU
	IX+P8ka8ShbYYjXXJodbcZOVrLWeeyEmW9Y38dDm0Q86zV8WJejL7OrCeWlhM38C
	r7V5nOYWe6bIgj/CDUjjHF0iDfSRaPxIFBCpJk1nMqUaVvnjJk/iZVl51vOzMOUA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8tayu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 07:34:15 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5497YFLQ026258;
	Fri, 9 May 2025 07:34:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8tayh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 07:34:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54952KrN004235;
	Fri, 9 May 2025 07:34:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2eshh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 07:34:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5497YBHQ41615722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 07:34:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A3192006F;
	Fri,  9 May 2025 07:34:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52DCE2005A;
	Fri,  9 May 2025 07:34:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 07:34:08 +0000 (GMT)
Date: Fri, 9 May 2025 13:04:05 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] ext4: Add atomic block write documentation
Message-ID: <aB2v7TKtQv-Kch09@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <a4726b81fbc29426e42b15cac6049ee7a0cba7e8.1746734746.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4726b81fbc29426e42b15cac6049ee7a0cba7e8.1746734746.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N6spF39B c=1 sm=1 tr=0 ts=681daff7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=07d9gI8wAAAA:8 a=pGLkceISAAAA:8 a=a3gGzQcNYAkQN_H1Us0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-GUID: 674CjJyzVCo_5PKZ02ytaAp13pOyFtWm
X-Proofpoint-ORIG-GUID: 97suNKnxDUodypempBmBG7RigbYHyl-J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2NyBTYWx0ZWRfX8Y95L1HmQp3o blvoAz2UDjuBW3tTVcSBrG5oqCtYxnHe3epH1CUbMCOeMmMaf5i7acLyf7gWtVIhhXg5klXKcI3 w5zM6o+Q6/OJHAKHF5SAan5yLH8RjsO9Ttugb8dF1MmA3V0WkLCcRrWRwqhVlr4u9LS74MN9wNe
 bmxzOSnXFeqVTgF8dUR44YXZLFJUWr8IqTdJCMB9g2cF5feX9tE1COtk+mNsnNtX+W3eiF5fDWZ lolspO+8YrIkDNsZ7x9SzY3vYpzOz8JoCfo62xBheCGXBq9ExUsxSCfcY9D3ruJ57dykcFhZwUW 1eFsFM2qys9BL1YPCF8Y9vGtvDCHQT+FsDolPpx3xXi+h4NUVoFxu3GNt72b2XOp2zt3P6Ed8Vx
 suuJv2lAFRjHmak51M86elrEsSGu0m+zbV+OCKf2/eCCh3ZiXn7EMGN7RlVSqRcM3tL/2LW4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090067

On Fri, May 09, 2025 at 02:20:37AM +0530, Ritesh Harjani (IBM) wrote:
> Add an initial documentation around atomic writes support in ext4.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Hi Ritesh,

THe docs look mostly good. I'll add some feedback below:
> ---
>  .../filesystems/ext4/atomic_writes.rst        | 208 ++++++++++++++++++
>  Documentation/filesystems/ext4/overview.rst   |   1 +
>  2 files changed, 209 insertions(+)
>  create mode 100644 Documentation/filesystems/ext4/atomic_writes.rst
> 
> diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
> new file mode 100644
> index 000000000000..59b03d8dbb79
> --- /dev/null
> +++ b/Documentation/filesystems/ext4/atomic_writes.rst
> @@ -0,0 +1,208 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. _atomic_writes:
> +
> +Atomic Block Writes
> +-------------------------
> +
> +Introduction
> +~~~~~~~~~~~~
> +
> +Atomic (untorn) block writes ensure that either the entire write is committed
> +to disk or none of it is. This prevents "torn writes" during power loss or
> +system crashes. The ext4 filesystem supports atomic writes (only with Direct
> +I/O) on regular files with extents, provided the underlying storage device
> +supports hardware atomic writes. This is supported in the following two ways:
> +
> +1. **Single-fsblock Atomic Writes**:
> +   EXT4's supports atomic write operations with a single filesystem block since
> +   v6.13. In this the atomic write unit minimum and maximum sizes are both set
> +   to filesystem blocksize.
> +   e.g. doing atomic write of 16KB with 16KB filesystem blocksize on 64KB
> +   pagesize system is possible.
> +
> +2. **Multi-fsblock Atomic Writes with Bigalloc**:
> +   EXT4 now also supports atomic writes spanning multiple filesystem blocks
> +   using a feature known as bigalloc. The atomic write unit's minimum and
> +   maximum sizes are determined by the filesystem block size and cluster size,
> +   based on the underlying device’s supported atomic write unit limits.
> +
> +Requirements
> +~~~~~~~~~~~~
> +
> +Basic requirements for atomic writes in ext4:
> +
> + 1. The extents feature must be enabled (default for ext4)
> + 2. The underlying block device must support atomic writes
> + 3. For single-fsblock atomic writes:
> +
> +    1. A filesystem with appropriate block size (up to the page size)
> + 4. For multi-fsblock atomic writes:
> +
> +    1. The bigalloc feature must be enabled
> +    2. The cluster size must be appropriately configured
> +
> +NOTE: EXT4 does not support software or COW based atomic write, which means
> +atomic writes on ext4 are only supported if underlying storage device supports
> +it.
> +
> +Multi-fsblock Implementation Details
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The bigalloc feature changes ext4 to use clustered allocations. With bigalloc
> +each bit within block bitmap represents clusters (power of 2 number of blocks)
> +rather than individual filesystem blocks. EXT4 supports atomic writes using
> +bigalloc by making sure that atomic write min and max are within [blocksize,
> +clustersize].

Should we add a line like:

Atomic write max unit is capped to the max supported by the underlying
device, incase it is less than the clustersize.

Also, maybe we can have a line wiht something like "With bigalloc's
clustered allocation we can be sure that an atomic write will always
be allocated aligned blocks. The only thing we need to ensure is that
we have a continuous mapping in the write rang."
	
> +
> +Here is the block allocation strategy in bigalloc for atomic writes:
> +
> + * For regions with fully mapped extents, no additional allocation is needed
> + * For append writes, a new mapped extent is allocated
> + * For regions that are entirely holes, unwritten extent is created
> + * For large unwritten extents, the extent gets split into two unwritten
> +   extents of appropriate requested size

Are the above 4 points needed explicitly? Maybe we can have:

Append writes, and writes on regions that are fully mapped,
unwritten or hole follow the same flow as non atomic writes.

> + * For mixed mapping regions (combinations of holes, unwritten extents, or
> +   mapped extents), ext4_map_blocks() is called in a loop with
> +   EXT4_GET_BLOCKS_ZERO flag to convert the region into a single contiguous
> +   mapped extent
Maybe:

... single continuous mapped extents by writing zeroes to it 

So that we explicitly mention what we are doing and not rely on people
knowing the meaning of EXT4_GET_BLOCKS_ZERO flag.

> +
> +Note: Writing on a single contiguous underlying extent, whether mapped or
> +unwritten, is not inherently problematic. However, writing to a mixed mapping
> +region (i.e. one containing a combination of mapped and unwritten extents)
> +must be avoided when performing atomic writes.
> +
> +The reason is that, atomic writes when issued via pwritev2() with the RWF_ATOMIC
> +flag, requires that either all data is written or none at all. In the event of
> +a system crash or unexpected power loss during the write operation, the affected
> +region (when later read) must reflect either the complete old data or the
> +complete new data, but never a mix of both.
> +
> +To enforce this guarantee, we ensure that the write target is backed by
> +a single, contiguous extent before any data is written. This is critical because
> +ext4 defers the conversion of unwritten extents to written extents until the I/O
> +completion path (typically in ->end_io()). If a write is allowed to proceed over
> +a mixed mapping region (with mapped and unwritten extents) and a failure occurs
> +mid-write, the system could observe partially updated regions after reboot, i.e.
> +new data over mapped areas, and stale (old) data over unwritten extents that
> +were never marked written. This violates the atomicity and/or torn write
> +prevention guarantee.
> +
> +To prevent such torn writes, ext4 proactively allocates a single contiguous
> +extent for the entire requested region in ``ext4_iomap_alloc`` via
> +``ext4_map_blocks_atomic()``. Only after this allocation, is the write
> +operation performed by iomap.
> +
> +Handling Split Extents Across Leaf Blocks
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +There can be a special edge case where we have logically and physically
> +contiguous extents stored in separate leaf nodes of the on-disk extent tree.
> +This occurs because on-disk extent tree merges only happens within the leaf
> +blocks except for a case where we have 2-level tree which can get merged and
> +collapsed entirely into the inode.
> +If such a layout exists and, in the worst case, the extent status cache entries
> +are reclaimed due to memory pressure, ``ext4_map_blocks()`` may never return
> +a single contiguous extent for these split leaf extents.
> +
> +To address this edge case, a new get block flag
> +``EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS flag`` is added to enhance the
> +``ext4_map_query_blocks()`` lookup behavior.
> +
> +This new get block flag allows ``ext4_map_blocks()`` to first checks if there is

s/checks/check

> +an entry in the extent status cache for the full range.
> +If not present, it consults the on-disk extent tree using
> +``ext4_map_query_blocks()``.
> +If the located extent is at the end of a leaf node, it probes the next logical
> +block (lblk) to detect a contiguous extent in the adjacent leaf.
> +
> +For now only one additional leaf block is queried to maintain efficiency, as
> +atomic writes are typically constrained to small sizes
> +(e.g. [blocksize, clustersize]).
> +
> +
> +Handling Journal transactions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To support multi-fsblock atomic writes, we ensure enough journal credits are
> +reserved during:
> +
> + 1. Block allocation time in ``ext4_iomap_alloc()``. We first query if there
> +    could be a mixed mapping for the underlying requested range. If yes, then we
> +    reserve credits of up to ``m_len``, assuming every alternate block can be
> +    an unwritten extent followed by a hole.
> +
> + 2. During ``->end_io()`` call, we make sure a single transaction is started for
> +    doing unwritten-to-written conversion. The loop for conversion is mainly
> +    only required to handle a split extent across leaf blocks.
> +
> +How to
> +------
> +
> +Creating Filesystems with Atomic Write Support
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +For single-fsblock atomic writes with a larger block size
> +(on systems with block size < page size):
> +
> +.. code-block:: bash
> +
> +    # Create an ext4 filesystem with a 16KB block size
> +    # (requires page size >= 16KB)
> +    mkfs.ext4 -b 16384 /dev/device
> +
> +For multi-fsblock atomic writes with bigalloc:
> +
> +.. code-block:: bash
> +
> +    # Create an ext4 filesystem with bigalloc and 64KB cluster size
> +    mkfs.ext4 -F -O bigalloc -b 4096 -C 65536 /dev/device
> +
> +Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in bytes,
> +and ``-O bigalloc`` enables the bigalloc feature.
> +
> +Application Interface
> +~~~~~~~~~~~~~~~~~~~~~
> +
> +Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
> +to perform atomic writes:
> +
> +.. code-block:: c
> +
> +    pwritev2(fd, iov, iovcnt, offset, RWF_ATOMIC);
> +
> +The write must be aligned to the filesystem's block size and not exceed the
> +filesystem's maximum atomic write unit size.
> +See ``generic_atomic_write_valid()`` for more details.
> +
> +``statx()`` system call with ``STATX_WRITE_ATOMIC`` flag can provides following
> +details:
> +
> + * ``stx_atomic_write_unit_min``: Minimum size of an atomic write request.
> + * ``stx_atomic_write_unit_max``: Maximum size of an atomic write request.
> + * ``stx_atomic_write_segments_max``: Upper limit for segments. Tthe number of
> +   separate memory buffers that can be gathered into a write operation
> +   (e.g., the iovcnt parameter for IOV_ITER). Currently, this is always set to one.
> +
> +The STATX_ATTR_WRITE_ATOMIC flag in ``statx->attributes`` is set if atomic
> +writes are supported.
> +
> +Hardware Support
> +----------------
> +
> +The underlying storage device must support atomic write operations.
> +Modern NVMe and SCSI devices often provide this capability.
> +The Linux kernel exposes this information through sysfs:
> +
> +* ``/sys/block/<device>/queue/atomic_write_unit_min`` - Minimum atomic write size
> +* ``/sys/block/<device>/queue/atomic_write_unit_max`` - Maximum atomic write size
> +
> +Nonzero values for these attributes indicate that the device supports
> +atomic writes.
> +
> +See Also
> +--------
> +
> +* :doc:`bigalloc` - Documentation on the bigalloc feature
> +* :doc:`allocators` - Documentation on block allocation in ext4
> +* Support for atomic block writes in 6.13:
> +  https://lwn.net/Articles/1009298/
> diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
> index 0fad6eda6e15..9d4054c17ecb 100644
> --- a/Documentation/filesystems/ext4/overview.rst
> +++ b/Documentation/filesystems/ext4/overview.rst
> @@ -25,3 +25,4 @@ order.
>  .. include:: inlinedata.rst
>  .. include:: eainode.rst
>  .. include:: verity.rst
> +.. include:: atomic_writes.rst
> -- 
> 2.49.0
> 

