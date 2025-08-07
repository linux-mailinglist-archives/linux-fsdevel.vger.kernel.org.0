Return-Path: <linux-fsdevel+bounces-57024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDB1B1DFC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 01:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A0B626770
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A845262FD0;
	Thu,  7 Aug 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVi5/6r1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4174221F38;
	Thu,  7 Aug 2025 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754608820; cv=none; b=Q90BObowIDj9rt3yu++RL4xlx3Cp81W6tGIbpeV1LOe7rQ+7Gck0G7DR1jZjoCiW92qtdzOO/mqJVYfhnfH2q/wqpzHr8RFCCCbV1UtfjICx7eiK2pwdp3w37dTkp84XqzjoeLcYhR7F4FVv+MfSIGw6tRZrhqmnrNHRjkeWs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754608820; c=relaxed/simple;
	bh=i6U0VjQ7FE0W9Kkc4FWNsCpy0F3UDMweKAt+yL9s2BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPHRe7lZAarKsLMe58PbiqN2KIQtyoW9e5yN45+MD+xEhBEvlzz6VPmkcBGIfjHml3nfXkt28qeHPJ4nZE2mV2o3rW1MppP0hy92Hinf3bLHXRe6CjVMjBWN9X/C1oXU7Ga6jl6C6I/lymT9n6Y8BK0HvTc9tJ1WCwyIVYvK4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVi5/6r1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3318C4CEEB;
	Thu,  7 Aug 2025 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754608820;
	bh=i6U0VjQ7FE0W9Kkc4FWNsCpy0F3UDMweKAt+yL9s2BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVi5/6r1xf5B5uqRk37Yq1EicfGmSCr5x9xOeniWEbyypDJylIqIwwzXBrERqsq3X
	 qmXHu0fHMvheY16TEAWFGgasjH0NYNdqw4ggC9E/8WQLCK6medy18YXAW15kXFIqOQ
	 o4SD1Az2YTKOkGCZhW04X7bsjQEwnXrScjH8PE/y8za9oMhTQ45chAkSFQo10I/Fs7
	 WEHCZ5XvRc9ha3/vSo8mv6/49VokmEoufq1OBQA+68JOwDRtYbX7MVFe2Pm1ymn+04
	 EuSwX1qrM8OkEmUdtYvCQ5z+qHg534KlmAG5C3aJZxYCQdDiWmK7x8fFht2n/EnKCk
	 Vrdo0ahjcnvkw==
Date: Thu, 7 Aug 2025 17:20:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org
Subject: Re: [PATCHv2 0/7] direct-io: even more flexible io vectors
Message-ID: <aJU0scj_dR8_37S8@kbusch-mbp>
References: <20250805141123.332298-1-kbusch@meta.com>
 <aJNr9svJav0DgZ-E@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJNr9svJav0DgZ-E@infradead.org>

On Wed, Aug 06, 2025 at 07:51:34AM -0700, Christoph Hellwig wrote:
> So this needs to come with an xfstests to actually hit the alignment
> errors, including something that is not the first bio submitted.

Sure. I wrote up some for blktest, and the same test works as-is for
filesystems too. Potential question: where do such programs go
(xfstests, blktests, both, or some common place)?

Anyway, the followig are diffs for xfstest then blktests, then last is
the test file itself that works for both.

I tested on loop, nvme, and virtio-blk, both raw block (blktests) and
xfs (fstests). Seems fine.

It should fail on current Linus upstream; it needs my patches to
succeed because only that one can use 'dio' length aligned vectors.  So
far, user space doesn't have a way to know if that is supported.

These tests caught a bug in "PATCH 2/7" from my series, specifically
that it needs check bv_len in addition to bv_offset against the
dma_alignment. I've a fix ready for that ready for the next version.


For 'xfstests':


---
diff --git a/.gitignore b/.gitignore
index 58dc2a63..0f5f57cc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -77,6 +77,7 @@ tags
 /src/dio-buf-fault
 /src/dio-interleaved
 /src/dio-invalidate-cache
+/src/dio-offsets
 /src/dio-write-fsync-same-fd
 /src/dirhash_collide
 /src/dirperf
diff --git a/src/Makefile b/src/Makefile
index 2cc1fb40..49a7c0c7 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race
+	dio-writeback-race dio-offsets
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/tests/generic/771 b/tests/generic/771
new file mode 100755
index 00000000..3100a4b8
--- /dev/null
+++ b/tests/generic/771
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Keith Busch.  All Rights Reserved.
+#
+# FS QA Test 771
+#
+# Test direct IO boundaries
+#
+
+. ./common/preamble
+. ./common/rc
+_begin_fstest auto quick
+
+_require_scratch
+_require_odirect
+_require_test
+_require_test_program dio-offsets
+
+# Modify as appropriate.
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+sys_max_segments=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/max_segments")
+sys_dma_alignment=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/dma_alignment")
+sys_virt_boundary_mask=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/virt_boundary_mask")
+sys_logical_block_size=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size")
+sys_max_sectors_kb=$(cat "/sys/block/$(_short_dev $SCRATCH_DEV)/queue/max_sectors_kb")
+
+echo "max_segments=$sys_max_segments dma_alignment=$sys_dma_alignment virt_boundary_mask=$sys_virt_boundary_mask logical_block_size=$sys_logical_block_size max_sectors_kb=$sys_max_sectors_kb" >> $seqres.full
+
+$here/src/dio-offsets $SCRATCH_MNT/foobar $sys_max_segments $sys_max_sectors_kb $sys_dma_alignment $sys_virt_boundary_mask $sys_logical_block_size
+
+cat $SCRATCH_MNT/foobar > /dev/null
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/771.out b/tests/generic/771.out
new file mode 100644
index 00000000..c2345c7b
--- /dev/null
+++ b/tests/generic/771.out
@@ -0,0 +1,2 @@
+QA output created by 771
+Silence is golden
--


For 'blktests'


---
diff --git a/src/.gitignore b/src/.gitignore
index 399a046..eb34474 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,3 +1,4 @@
+/dio-offsets
 /discontiguous-io
 /loblksize
 /loop_change_fd
diff --git a/src/Makefile b/src/Makefile
index f91ac62..7a20e46 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -9,6 +9,7 @@ HAVE_C_MACRO = $(shell if echo "$(H)include <$(1)>" |	\
 		then echo 1;else echo 0; fi)
 
 C_TARGETS := \
+	dio-offsets \
 	loblksize \
 	loop_change_fd \
 	loop_get_status_null \
diff --git a/tests/block/041 b/tests/block/041
new file mode 100755
index 0000000..714e1bb
--- /dev/null
+++ b/tests/block/041
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+. tests/block/rc
+
+DESCRIPTION="Test unusual direct-io offsets"
+QUICK=1
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	sys_max_segments=$(cat "${TEST_DEV_SYSFS}/queue/max_segments")
+	sys_dma_alignment=$(cat "${TEST_DEV_SYSFS}/queue/dma_alignment")
+	sys_virt_boundary_mask=$(cat "${TEST_DEV_SYSFS}/queue/virt_boundary_mask")
+	sys_logical_block_size=$(cat "${TEST_DEV_SYSFS}/queue/logical_block_size")
+	sys_max_sectors_kb=$(cat "${TEST_DEV_SYSFS}/queue/max_sectors_kb")
+
+	if ! src/dio-offsets ${TEST_DEV} $sys_max_segments $sys_max_sectors_kb $sys_dma_alignment $sys_virt_boundary_mask $sys_logical_block_size ; then
+		echo "src/dio-offsets failed"
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/block/041.out b/tests/block/041.out
new file mode 100644
index 0000000..6706a76
--- /dev/null
+++ b/tests/block/041.out
@@ -0,0 +1,2 @@
+Running block/041
+Test complete
--


And regardless of which you're running, drop this file, 'dio-offsets.c'
into the src/ directory:


---
#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif

#include <sys/uio.h>

#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>

#define power_of_2(x) ((x) && !((x) & ((x) - 1)))

static unsigned long logical_block_size;
static unsigned long dma_alignment;
static unsigned long virt_boundary;
static unsigned long max_segments;
static unsigned long max_bytes;
static size_t buf_size;
static long pagesize;
static void *out_buf;
static void *in_buf;
static int test_fd;

static void init_args(char **argv)
{
        test_fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_DIRECT);
        if (test_fd < 0)
		err(errno, "%s: failed to open %s", __func__, argv[1]);

	max_segments = strtoul(argv[2], NULL, 0);
	max_bytes = strtoul(argv[3], NULL, 0) * 1024;
	dma_alignment = strtoul(argv[4], NULL, 0) + 1;
	virt_boundary = strtoul(argv[5], NULL, 0) + 1;
	logical_block_size = strtoul(argv[6], NULL, 0);

	if (!power_of_2(virt_boundary) ||
	    !power_of_2(dma_alignment) ||
	    !power_of_2(logical_block_size)) {
		errno = EINVAL;
		err(1, "%s: bad parameters", __func__);
	}

	if (virt_boundary > 1 && virt_boundary < logical_block_size) {
		errno = EINVAL;
		err(1, "%s: virt_boundary:%lu logical_block_size:%lu", __func__,
			virt_boundary, logical_block_size);
	}

	if (dma_alignment > logical_block_size) {
		errno = EINVAL;
		err(1, "%s: dma_alignment:%lu logical_block_size:%lu", __func__,
			dma_alignment, logical_block_size);
	}


	if (max_segments > 4096)
		max_segments = 4096;
	if (max_bytes > 16384 * 1024)
		max_bytes = 16384 * 1024;
	if (max_bytes & (logical_block_size - 1))
		max_bytes -= max_bytes & (logical_block_size - 1);
	pagesize = sysconf(_SC_PAGE_SIZE);
}

static void init_buffers()
{
	unsigned long lb_mask = logical_block_size - 1;
	int fd, ret;

	buf_size = max_bytes * max_segments * 2;
	if (buf_size < logical_block_size * max_segments) {
		errno = EINVAL;
		err(1, "%s: logical block size is too big", __func__);
	}

	if (buf_size < logical_block_size * 1024 * 4)
		buf_size = logical_block_size * 1024 * 4;

	if (buf_size & lb_mask)
		buf_size = (buf_size + lb_mask) & ~(lb_mask);

        ret = posix_memalign((void **)&in_buf, pagesize, buf_size);
        if (ret)
		err(1, "%s: failed to allocate in-buf", __func__);

        ret = posix_memalign((void **)&out_buf, pagesize, buf_size);
        if (ret)
		err(1, "%s: failed to allocate out-buf", __func__);

	fd = open("/dev/urandom", O_RDONLY);
	if (fd < 0)
		err(1, "%s: failed to open urandom", __func__);

	ret = read(fd, out_buf, buf_size);
	if (ret < 0)
		err(1, "%s: failed to read from urandom", __func__);

	close(fd);
}

/*
 * Test using page aligned buffers, single source
 *
 * Total size is aligned to a logical block size and exceeds the max transfer
 * size as well as the max segments. This should test the kernel's split bio
 * construction and bio splitting for exceeding these limits.
 */
static void test_1()
{
	int ret;

	memset(in_buf, 0, buf_size);
	ret = pwrite(test_fd, out_buf, buf_size, 0);
	if (ret < 0)
		err(1, "%s: failed to write buf", __func__);

	ret = pread(test_fd, in_buf, buf_size, 0);
	if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	if (memcmp(out_buf, in_buf, buf_size)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

/*
 * Test using dma aligned buffers, single source
 *
 * This tests the kernel's dio memory alignment
 */
static void test_2()
{
	int ret;

	memset(in_buf, 0, buf_size);
	ret = pwrite(test_fd, out_buf + dma_alignment, max_bytes, 0);
	if (ret < 0)
		err(1, "%s: failed to write buf", __func__);

	ret = pread(test_fd, in_buf + dma_alignment, max_bytes, 0);
	if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	if (memcmp(out_buf + dma_alignment, in_buf + dma_alignment, max_bytes)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

/*
 * Test using page aligned buffers + logicaly block sized vectored source
 *
 * This tests discontiguous vectored sources
 */
static void test_3()
{
	const int vecs = 4;

	int i, ret, offset;
	struct iovec iov[vecs];

	memset(in_buf, 0, buf_size);
	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 4;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size * 2;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to write buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 4;
		iov[i].iov_base = in_buf + offset;
		iov[i].iov_len = logical_block_size * 2;
	}

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 4;
		if (memcmp(in_buf + offset, out_buf + offset, logical_block_size * 2)) {
			errno = EIO;
			err(1, "%s: data corruption", __func__);
		}
	}
}

/*
 * Test using dma aligned buffers, vectored source
 *
 * This tests discontiguous vectored sources with incrementing dma aligned
 * offsets
 */
static void test_4()
{
	const int vecs = 4;

	int i, ret, offset;
	struct iovec iov[vecs];

	memset(in_buf, 0, buf_size);
	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8 + dma_alignment * (i + 1);
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size * 2;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to write buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8 + dma_alignment * (i + 1);
		iov[i].iov_base = in_buf + offset;
		iov[i].iov_len = logical_block_size * 2;
	}

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8 + dma_alignment * (i + 1);
		if (memcmp(in_buf + offset, out_buf + offset, logical_block_size * 2)) {
			errno = EIO;
			err(1, "%s: data corruption", __func__);
		}
	}
}

/*
 * Test vectored read with a total size aligned to a block, but individual
 * vectors will not be; however, all the middle vectors start and end on page
 * boundaries which should satisify any virt_boundary condition.
 */
static void test_5()
{
	const int vecs = 4;

	int i, ret, offset, mult;
	struct iovec iov[vecs];

	i = 0;
	memset(in_buf, 0, buf_size);
	mult = pagesize / logical_block_size;
	if (mult < 2)
		mult = 2;

	offset = pagesize - (logical_block_size / 4);
	if (offset & (dma_alignment - 1))
		offset = pagesize - dma_alignment;

	iov[i].iov_base = out_buf + offset;
	iov[i].iov_len = pagesize - offset;

	for (i = 1; i < vecs - 1; i++) {
		offset = logical_block_size * i * 8 * mult;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size * mult;
	}

	offset = logical_block_size * i * 8 * mult;
	iov[i].iov_base = out_buf + offset;
	iov[i].iov_len = logical_block_size * mult - iov[0].iov_len;

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to write buf len:%zu", __func__,
			iov[0].iov_len + iov[1].iov_len + iov[2].iov_len + iov[3].iov_len);

	i = 0;
	offset = pagesize - (logical_block_size / 4);
	if (offset & (dma_alignment - 1))
		offset = pagesize - dma_alignment;

	iov[i].iov_base = in_buf + offset;
	iov[i].iov_len = pagesize - offset;

	for (i = 1; i < vecs - 1; i++) {
		offset = logical_block_size * i * 8 * mult;
		iov[i].iov_base = in_buf + offset;
		iov[i].iov_len = logical_block_size * mult;
	}

	offset = logical_block_size * i * 8 * mult;
	iov[i].iov_base = in_buf + offset;
	iov[i].iov_len = logical_block_size * mult - iov[0].iov_len;

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf len:%zu", __func__,
			iov[0].iov_len + iov[1].iov_len + iov[2].iov_len + iov[3].iov_len);

	i = 0;
	offset = pagesize - (logical_block_size / 4);
	if (offset & (dma_alignment - 1))
		offset = pagesize - dma_alignment;

	if (memcmp(in_buf + offset, out_buf + offset, iov[i].iov_len)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
	for (i = 1; i < vecs - 1; i++) {
		offset = logical_block_size * i * 8 * mult;
		if (memcmp(in_buf + offset, out_buf + offset, iov[i].iov_len)) {
			errno = EIO;
			err(1, "%s: data corruption", __func__);
		}
	}
	offset = logical_block_size * i * 8 * mult;
	if (memcmp(in_buf + offset, out_buf + offset, iov[i].iov_len)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

/*
 * Total size is a logical block size multiple, but none of the vectors are.
 * Total vectors will be less than the max. The vectors will be dma aligned. If
 * a virtual boundary exists, this should fail, otherwise it should succceed.
 */
static void test_6()
{
	const int vecs = 4;

	int i, ret, offset;
	struct iovec iov[vecs];
	bool should_fail = virt_boundary > 1;

	memset(in_buf, 0, buf_size);
	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size / 2;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0) {
		if (should_fail)
			return;
		err(1, "%s: failed to write buf", __func__);
	} else if (should_fail) {
		errno = ENOTSUP;
		err(1, "%s: write buf unexpectedly succeeded(?)", __func__);
	}

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8;
		iov[i].iov_base = in_buf + offset;
		iov[i].iov_len = logical_block_size / 2;
	}

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = logical_block_size * i * 8;
		if (memcmp(in_buf + offset, out_buf + offset, logical_block_size / 2)) {
			errno = EIO;
			err(1, "%s: data corruption", __func__);
		}
	}
}

/*
 * Provide an invalid iov_base at the beginning to test the kernel catching it
 * while building a bio.
 */
static void test_7()
{
	const int vecs = 4;

	int i, ret, offset;
	struct iovec iov[vecs];

	i = 0;
	iov[i].iov_base = 0;
	iov[i].iov_len = logical_block_size;

	for (i = 1; i < vecs; i++) {
		offset = logical_block_size * i * 8;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		return;

	errno = ENOTSUP;
	err(1, "%s: write buf unexpectedly succeeded with NULL address(?)", __func__);
}

/*
 * Provide an invalid iov_base in the middle to test the kernel catching it
 * while building split bios. Ensure it is split by sending enough vectors to
 * exceed bio's MAX_VEC; this should cause part of the io to dispatch.
 */
static void test_8()
{
	const int vecs = 1024;

	int i, ret, offset;
	struct iovec iov[vecs];

	for (i = 0; i < vecs / 2 + 1; i++) {
		offset = logical_block_size * i * 2;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size;
	}

	offset = logical_block_size * i * 2;
	iov[i].iov_base = 0;
	iov[i].iov_len = logical_block_size;

	for (++i; i < vecs; i++) {
		offset = logical_block_size * i * 2;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = logical_block_size;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		return;

	errno = ENOTSUP;
	err(1, "%s: write buf unexpectedly succeeded with NULL address(?)", __func__);
}

/*
 * Test with an invalid DMA address. Should get caught early when splitting. If
 * the device supports byte aligned memory (which is unusual), then this should
 * be successful.
 */
static void test_9()
{
	int ret, offset;
	size_t size;
	bool should_fail = dma_alignment > 1;

	memset(in_buf, 0, buf_size);
	offset = 2 * dma_alignment - 1;
	size = logical_block_size * 256;
	ret = pwrite(test_fd, out_buf + offset, size, 0);
	if (ret < 0) {
		if (should_fail)
			return
		err(1, "%s: failed to write buf", __func__);
	} else if (should_fail) {
		errno = ENOTSUP;
		err(1, "%s: write buf unexpectedly succeeded with invalid DMA offset address(?)",
			__func__);
	}

	ret = pread(test_fd, in_buf + offset, size, 0);
	if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	if (memcmp(out_buf + offset, in_buf + offset, size)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

/*
 * Test with invalid DMA alignment in the middle. This should get split with
 * the first part being dispatched, and the 2nd one failing without dispatch.
 */
static void test_10()
{
	const int vecs = 5;

	bool should_fail = dma_alignment > 1;
	struct iovec iov[vecs];
	int ret, offset;

	offset = dma_alignment * 2 - 1;
	memset(in_buf, 0, buf_size);

	iov[0].iov_base = out_buf;
	iov[0].iov_len = max_bytes;

	iov[1].iov_base = out_buf + max_bytes * 2;
	iov[1].iov_len = max_bytes;

	iov[2].iov_base = out_buf + max_bytes * 4 + offset;
	iov[2].iov_len = max_bytes;

	iov[3].iov_base = out_buf + max_bytes * 6;
	iov[3].iov_len = max_bytes;

	iov[4].iov_base = out_buf + max_bytes * 8;
	iov[4].iov_len = max_bytes;

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0) {
		if (should_fail)
			return;
		err(1, "%s: failed to write buf", __func__);
	} else if (should_fail) {
		errno = ENOTSUP;
		err(1, "%s: write buf unexpectedly succeeded with invalid DMA offset address(?)", __func__);
	}

	iov[0].iov_base = in_buf;
	iov[0].iov_len = max_bytes;

	iov[1].iov_base = in_buf + max_bytes * 2;
	iov[1].iov_len = max_bytes;

	iov[2].iov_base = in_buf + max_bytes * 4 + offset;
	iov[2].iov_len = max_bytes;

	iov[3].iov_base = in_buf + max_bytes * 6;
	iov[3].iov_len = max_bytes;

	iov[4].iov_base = in_buf + max_bytes * 8;
	iov[4].iov_len = max_bytes;

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	if (memcmp(out_buf, in_buf, max_bytes) ||
	    memcmp(out_buf + max_bytes * 2, in_buf + max_bytes * 2, max_bytes) ||
	    memcmp(out_buf + max_bytes * 4 + offset, in_buf + max_bytes * 4 + offset, max_bytes) ||
	    memcmp(out_buf + max_bytes * 6, in_buf + max_bytes * 6, max_bytes) ||
	    memcmp(out_buf + max_bytes * 8, in_buf + max_bytes * 8, max_bytes)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

/*
 * Test a bunch of small vectors if the device dma alignemnt allows it. We'll
 * try to force a MAX_IOV split that can't form a valid IO so expect a failure.
 */
static void test_11()
{
	const int vecs = 320;

	int ret, i, offset, iovpb, iov_size;
	bool should_fail = true;
	struct iovec iov[vecs];

	memset(in_buf, 0, buf_size);
	iovpb = logical_block_size / dma_alignment;
	iov_size = logical_block_size / iovpb;

	if ((pagesize  / iov_size) < 256 &&
	    iov_size >= virt_boundary)
		should_fail = false;

	for (i = 0; i < vecs; i++) {
		offset = i * iov_size * 2;
		iov[i].iov_base = out_buf + offset;
		iov[i].iov_len = iov_size;
	}

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0) {
		if (should_fail)
			return;
		err(1, "%s: failed to write buf", __func__);
	} else if (should_fail) {
		errno = ENOTSUP;
		err(1, "%s: write buf unexpectedly succeeded(?)", __func__);
	}

	for (i = 0; i < vecs; i++) {
		offset = i * iov_size * 2;
		iov[i].iov_base = in_buf + offset;
		iov[i].iov_len = iov_size;
	}

        ret = preadv(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	for (i = 0; i < vecs; i++) {
		offset = i * iov_size * 2;
		if (memcmp(in_buf + offset, out_buf + offset, logical_block_size / 2)) {
			errno = EIO;
			err(1, "%s: data corruption", __func__);
		}
	}
}

/*
 * Start with a valid vector that can be split into a dispatched IO, but poison
 * the rest with an invalid DMA offset testing the kernel's late catch.
 */
static void test_12()
{
	const int vecs = 4;

	struct iovec iov[vecs];
	int i, ret;

	i = 0;
	iov[i].iov_base = out_buf;
	iov[i].iov_len = max_bytes - logical_block_size;

	i++;
	iov[i].iov_base = out_buf + max_bytes + logical_block_size;
	iov[i].iov_len = logical_block_size;

	i++;
	iov[i].iov_base = iov[1].iov_base + pagesize * 2 + (dma_alignment - 1);
	iov[i].iov_len = logical_block_size;

	i++;
	iov[i].iov_base = out_buf + max_bytes * 8;
	iov[i].iov_len = logical_block_size;

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		return;

	errno = ENOTSUP;
	err(1, "%s: write buf unexpectedly succeeded with NULL address(?)", __func__);
}

/*
 * Total size is block aligned, addresses are dma aligned, but invidual vector
 * sizes may not be dma aligned. If device has byte sized dma alignment, this
 * should succeed. If not, part of this should get dispatched, and the other
 * part should fail.
 */
static void test_13()
{
	const int vecs = 4;

	bool should_fail = dma_alignment > 1;
	struct iovec iov[vecs];
	int ret;

	iov[0].iov_base = out_buf;
	iov[0].iov_len = max_bytes * 2 - max_bytes / 2;

	iov[1].iov_base = out_buf + max_bytes * 4;
	iov[1].iov_len = logical_block_size * 2 - (dma_alignment + 1);

	iov[2].iov_base = out_buf + max_bytes * 8;
	iov[2].iov_len = logical_block_size * 2 + (dma_alignment + 1);

	iov[3].iov_base = out_buf + max_bytes * 12;
	iov[3].iov_len = max_bytes - max_bytes / 2;

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0) {
		if (should_fail)
			return;
		err(1, "%s: failed to write buf", __func__);
	} else if (should_fail) {
		errno = ENOTSUP;
		err(1, "%s: write buf unexpectedly succeeded with invalid DMA offset address(?)", __func__);
	}

	iov[0].iov_base = in_buf;
	iov[0].iov_len = max_bytes * 2 - max_bytes / 2;

	iov[1].iov_base = in_buf + max_bytes * 4;
	iov[1].iov_len = logical_block_size * 2 - (dma_alignment + 1);

	iov[2].iov_base = in_buf + max_bytes * 8;
	iov[2].iov_len = logical_block_size * 2 + (dma_alignment + 1);

	iov[3].iov_base = in_buf + max_bytes * 12;
	iov[3].iov_len = max_bytes - max_bytes / 2;

        ret = pwritev(test_fd, iov, vecs, 0);
        if (ret < 0)
		err(1, "%s: failed to read buf", __func__);

	if (memcmp(out_buf, in_buf, iov[0].iov_len) ||
	    memcmp(out_buf + max_bytes * 4, in_buf + max_bytes * 4, iov[1].iov_len) ||
	    memcmp(out_buf + max_bytes * 8, in_buf + max_bytes * 8, iov[2].iov_len) ||
	    memcmp(out_buf + max_bytes * 12, in_buf + max_bytes * 12, iov[3].iov_len)) {
		errno = EIO;
		err(1, "%s: data corruption", __func__);
	}
}

static void run_tests()
{
	test_1();
	test_2();
	test_3();
	test_4();
	test_5();
	test_6();
	test_7();
	test_8();
	test_9();
	test_10();
	test_11();
	test_12();
	test_13();
}

/* ./$prog-name file max_segments max_sectors_kb dma_alignment virt_boundary logical_block_size */
int main(int argc, char **argv)
{
        if (argc < 7)
                errx(1, "expect argments: file max_segments max_sectors_kb dma_alignment virt_boundary logical_block_size");

	init_args(argv);
	init_buffers();
	run_tests();

	close(test_fd);
	free(out_buf);
	free(in_buf);

	return 0;
}
--

