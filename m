Return-Path: <linux-fsdevel+bounces-22557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13C5919BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CF3B22AF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992861C01;
	Thu, 27 Jun 2024 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsHKlbmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF20717E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448831; cv=none; b=MmsE2Jk5Pm2OIBNBr8M0a5sdPulBmjZZzPHbodF9nhLLDefl4C1gsRCXE4EXQ9lBUBV2su7LtE6TTm/MiKzu6tdqXyUQEnxBCbClMpYdp60EcgWhMPS89zvoDLpGNqU9Rz6UlaSOvtlpFXCK7TqOMAqZGiGKnaYjF/xdiCEs6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448831; c=relaxed/simple;
	bh=M+89AJP+4BHwPZQEKhZwh/BZTbLPvnvJYLisjEVAUgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KBbUbz2AXksYk/FXKUWXDUHM4wlZ/XVt8LE/Ok+zYjLX01A0MrAHp7uvlBkfbm0jhlZLIBU+kVYmQbQQbeb2ODTiLT6A61MDCs29FZBFEHIR4016tziboph41y/WPTiskl2y+YfITg3EbNu1Ji3IFHiFc3cWs+bhW+e1ng+Ai/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsHKlbmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719448826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+QIhWkrUjl8A1WpLxux9DpQH/gPDsJkcYbA07a9kr98=;
	b=dsHKlbmhkUYbvJvbwljhn5O0BDqSnZDKG4p4aegDzZWh5qX84NtOdYeJ2OTy4oY+JSKBBx
	/eJzmulETbaycNQ1bTeKFLJX8PiWs6XBfEoNqQNqorbpiEwH17yz5JgfIO6Tgiv+BD9Z4j
	v8YtDdsVi7W9I0hHCTX20kQCHQAbZrg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-uJE4GfzaPu-UIWBx4SHGfQ-1; Wed,
 26 Jun 2024 20:40:25 -0400
X-MC-Unique: uJE4GfzaPu-UIWBx4SHGfQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D55B19560A2;
	Thu, 27 Jun 2024 00:40:22 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.58])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 458851956087;
	Thu, 27 Jun 2024 00:40:14 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	ryan.roberts@arm.com,
	hughd@google.com,
	william.kucharski@oracle.com,
	djwong@kernel.org,
	torvalds@linux-foundation.org,
	ddutile@redhat.com,
	zhenyzha@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 0/4] mm/filemap: Limit page cache size to that supported by xarray
Date: Thu, 27 Jun 2024 10:39:48 +1000
Message-ID: <20240627003953.1262512-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Currently, xarray can't support arbitrary page cache size. More details
can be found from the WARN_ON() statement in xas_split_alloc(). In our
test whose code is attached below, we hit the WARN_ON() on ARM64 system
where the base page size is 64KB and huge page size is 512MB. The issue
was reported long time ago and some discussions on it can be found here
[1].

[1] https://www.spinics.net/lists/linux-xfs/msg75404.html

In order to fix the issue, we need to adjust MAX_PAGECACHE_ORDER to one
supported by xarray and avoid PMD-sized page cache if needed. The code
changes are suggested by David Hildenbrand.

PATCH[1] adjusts MAX_PAGECACHE_ORDER to that supported by xarray
PATCH[2-3] avoids PMD-sized page cache in the synchronous readahead path
PATCH[4] avoids PMD-sized page cache for shmem files if needed

Test program
============
# cat test.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/syscall.h>
#include <sys/mman.h>

#define TEST_XFS_FILENAME	"/tmp/data"
#define TEST_SHMEM_FILENAME	"/dev/shm/data"
#define TEST_MEM_SIZE		0x20000000

int main(int argc, char **argv)
{
	const char *filename;
	int fd = 0;
	void *buf = (void *)-1, *p;
	int pgsize = getpagesize();
	int ret;

	if (pgsize != 0x10000) {
		fprintf(stderr, "64KB base page size is required\n");
		return -EPERM;
	}

	system("echo force > /sys/kernel/mm/transparent_hugepage/shmem_enabled");
	system("rm -fr /tmp/data");
	system("rm -fr /dev/shm/data");
	system("echo 1 > /proc/sys/vm/drop_caches");

	/* Open xfs or shmem file */
	filename = TEST_XFS_FILENAME;
	if (argc > 1 && !strcmp(argv[1], "shmem"))
		filename = TEST_SHMEM_FILENAME;

	fd = open(filename, O_CREAT | O_RDWR | O_TRUNC);
	if (fd < 0) {
		fprintf(stderr, "Unable to open <%s>\n", filename);
		return -EIO;
	}

	/* Extend file size */
	ret = ftruncate(fd, TEST_MEM_SIZE);
	if (ret) {
		fprintf(stderr, "Error %d to ftruncate()\n", ret);
		goto cleanup;
	}

	/* Create VMA */
	buf = mmap(NULL, TEST_MEM_SIZE,
		   PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (buf == (void *)-1) {
		fprintf(stderr, "Unable to mmap <%s>\n", filename);
		goto cleanup;
	}

	fprintf(stdout, "mapped buffer at 0x%p\n", buf);
	ret = madvise(buf, TEST_MEM_SIZE, MADV_HUGEPAGE);
        if (ret) {
		fprintf(stderr, "Unable to madvise(MADV_HUGEPAGE)\n");
		goto cleanup;
	}

	/* Populate VMA */
	ret = madvise(buf, TEST_MEM_SIZE, MADV_POPULATE_WRITE);
	if (ret) {
		fprintf(stderr, "Error %d to madvise(MADV_POPULATE_WRITE)\n", ret);
		goto cleanup;
	}

	/* Punch the file to enforce xarray split */
	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
        		TEST_MEM_SIZE - pgsize, pgsize);
	if (ret)
		fprintf(stderr, "Error %d to fallocate()\n", ret);

cleanup:
	if (buf != (void *)-1)
		munmap(buf, TEST_MEM_SIZE);
	if (fd > 0)
		close(fd);

	return 0;
}

# gcc test.c -o test
# cat /proc/1/smaps | grep KernelPageSize | head -n 1
KernelPageSize:       64 kB
# ./test shmem
   :
------------[ cut here ]------------
WARNING: CPU: 17 PID: 5253 at lib/xarray.c:1025 xas_split_alloc+0xf8/0x128
Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib  \
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct    \
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4    \
ip_set nf_tables rfkill nfnetlink vfat fat virtio_balloon          \
drm fuse xfs libcrc32c crct10dif_ce ghash_ce sha2_ce sha256_arm64  \
virtio_net sha1_ce net_failover failover virtio_console virtio_blk \
dimlib virtio_mmio
CPU: 17 PID: 5253 Comm: test Kdump: loaded Tainted: G W 6.10.0-rc5-gavin+ #12
Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-1.el9 05/24/2024
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : xas_split_alloc+0xf8/0x128
lr : split_huge_page_to_list_to_order+0x1c4/0x720
sp : ffff80008a92f5b0
x29: ffff80008a92f5b0 x28: ffff80008a92f610 x27: ffff80008a92f728
x26: 0000000000000cc0 x25: 000000000000000d x24: ffff0000cf00c858
x23: ffff80008a92f610 x22: ffffffdfc0600000 x21: 0000000000000000
x20: 0000000000000000 x19: ffffffdfc0600000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000018000000000 x15: 3374004000000000
x14: 0000e00000000000 x13: 0000000000002000 x12: 0000000000000020
x11: 3374000000000000 x10: 3374e1c0ffff6000 x9 : ffffb463a84c681c
x8 : 0000000000000003 x7 : 0000000000000000 x6 : ffff00011c976ce0
x5 : ffffb463aa47e378 x4 : 0000000000000000 x3 : 0000000000000cc0
x2 : 000000000000000d x1 : 000000000000000c x0 : 0000000000000000
Call trace:
 xas_split_alloc+0xf8/0x128
 split_huge_page_to_list_to_order+0x1c4/0x720
 truncate_inode_partial_folio+0xdc/0x160
 shmem_undo_range+0x2bc/0x6a8
 shmem_fallocate+0x134/0x430
 vfs_fallocate+0x124/0x2e8
 ksys_fallocate+0x4c/0xa0
 __arm64_sys_fallocate+0x24/0x38
 invoke_syscall.constprop.0+0x7c/0xd8
 do_el0_svc+0xb4/0xd0
 el0_svc+0x44/0x1d8
 el0t_64_sync_handler+0x134/0x150
 el0t_64_sync+0x17c/0x180

Changelog
=========
v2:
  * Address David's comments and pick up ack tags from him
  * Swapped PATCH[v1 2/4] and PATCH[v1 3/4] and corrected fix tags
    based on comments from Andrew, David and Matthew

Gavin Shan (4):
  mm/filemap: Make MAX_PAGECACHE_ORDER acceptable to xarray
  mm/readahead: Limit page cache size in page_cache_ra_order()
  mm/filemap: Skip to create PMD-sized page cache if needed
  mm/shmem: Disable PMD-sized page cache if needed

 include/linux/pagemap.h | 11 +++++++++--
 mm/filemap.c            |  2 +-
 mm/readahead.c          |  8 ++++----
 mm/shmem.c              | 15 +++++++++++++--
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.45.1


