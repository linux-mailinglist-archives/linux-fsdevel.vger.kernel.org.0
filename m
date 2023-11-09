Return-Path: <linux-fsdevel+bounces-2462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5587E62AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 04:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55EAB281279
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 03:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AC63CC;
	Thu,  9 Nov 2023 03:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lC6jPaOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98D15663
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 03:31:32 +0000 (UTC)
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Nov 2023 19:31:31 PST
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE726AF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 19:31:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699500345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gu5twFrMv47CRElWeRfjdpNr3xzfCNgqZ1DcNPuQzlQ=;
	b=lC6jPaOToUpyq9XV9DeC3ick0P8VXhsgWhhQN/i1/mnYmKHcTOHLuLGuKIFQmlWdWWRmIj
	i3WrcF95BbdVEu1YjUGd9lexWgKtx77AY470eu8OwALXRsMmbK+7A+JjM4qu0bDAolwHG5
	XAmJoh1zAfxsOKe7+qdTIbS2gc6dYpw=
From: Jeff Xie <jeff.xie@linux.dev>
To: akpm@linux-foundation.org,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chensong_2000@189.cn,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [RFC][PATCH 0/4] mm, page_owner: make the owner in page owner clearer 
Date: Thu,  9 Nov 2023 11:25:17 +0800
Message-Id: <20231109032521.392217-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The current page_owner function can display the allocate and free process of
a page, but there is no accurate information corresponding to the page.

This patchset can make the slab page to know which kmem cache the page is
requested from.

For the file page, it can know the corresponding file inode,
if this file page is mapped to the process address space, we can know the virtual
address corresponding to a certain process.

For the anon page, since it must be mapped to the process address space, at this
time, we can also know the virtual address corresponding to a certain process.

To implement it, we only need to add a callback function in the struct page_owner,
this let the slab layer or the anon/file handler layer or any other memory-allocated 
layers to implement what they would like to tell.

For example, for slab page, a line is added to the result of page_owner

added: "SLAB_PAGE slab_name:kmalloc-32"

Page allocated via order 0, mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 340615384 ns
SLAB_PAGE slab_name:kmalloc-32
PFN 0x4be0 type Unmovable Block 37 type Unmovable Flags 0x1fffc0000000800(slab|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 allocate_slab+0x31f/0x410
 ___slab_alloc+0x3e8/0x850
 __kmem_cache_alloc_node+0x111/0x2b0
 kmalloc_trace+0x29/0x90
 iommu_setup_dma_ops+0x299/0x470
 bus_iommu_probe+0xe1/0x150
 iommu_device_register+0xad/0x120
 intel_iommu_init+0xe3a/0x1260
 pci_iommu_init+0x12/0x40
 do_one_initcall+0x45/0x210
 kernel_init_freeable+0x1a4/0x2e0
 kernel_init+0x1a/0x1c0

added: "SLAB_PAGE slab_name:mm_struct"

Page allocated via order 3, mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), \
pid 86, tgid 86 (linuxrc), ts 1121118666 ns 
SLAB_PAGE slab_name:mm_struct
PFN 0x6388 type Unmovable Block 49 type Unmovable Flags 0x1fffc0000000840(slab|head|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 allocate_slab+0x31f/0x410
 ___slab_alloc+0x3e8/0x850
 kmem_cache_alloc+0x2b8/0x2f0
 mm_alloc+0x1a/0x50
 alloc_bprm+0x8a/0x300
 do_execveat_common.isra.0+0x68/0x240
 __x64_sys_execve+0x37/0x50
 do_syscall_64+0x42/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76

For the pid 98:
[root@JeffXie ]# cat /proc/98/maps 
00400000-00401000 r--p 00000000 fd:00 1954	/test/mm/a.out
00401000-00499000 r-xp 00001000 fd:00 1954      /test/mm/a.out
00499000-004c2000 r--p 00099000 fd:00 1954      /test/mm/a.out
004c2000-004c6000 r--p 000c1000 fd:00 1954      /test/mm/a.out
004c6000-004c9000 rw-p 000c5000 fd:00 1954      /test/mm/a.out
004c9000-004ce000 rw-p 00000000 00:00 0 
01d97000-01db9000 rw-p 00000000 00:00 0                 [heap]
7f1588fc8000-7f1588fc9000 rw-p 00000000 fd:00 1945      /a.txt
7ffda207a000-7ffda209b000 rw-p 00000000 00:00 0         [stack]
7ffda2152000-7ffda2156000 r--p 00000000 00:00 0         [vvar]
7ffda2156000-7ffda2158000 r-xp 00000000 00:00 0         [vdso]
ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0 [vsyscall]

For file page:

added: "FILE_PAGE dev 253:0 ino:1954 index:0xc1 mapcount:1 refcount:2 0x4c2000 - 0x4c3000"

Page allocated via order 0, mask 0x152c4a(GFP_NOFS|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE),\
 pid 98, tgid 98 (a.out), ts 28441476044 ns
FILE_PAGE dev 253:0 ino:1954 index:0xc1 mapcount:1 refcount:2 0x4c2000 - 0x4c3000
PFN 0x5be8e type Movable Block 735 type Movable Flags 0x1fffc0000020028(uptodate|lru|mappedtodisk|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 folio_alloc+0x18/0x50
 page_cache_ra_unbounded+0x9b/0x1a0
 filemap_fault+0x5f7/0xc20
 __do_fault+0x31/0xc0
 __handle_mm_fault+0x1333/0x1760
 handle_mm_fault+0xbc/0x2f0
 do_user_addr_fault+0x1f8/0x5e0
 exc_page_fault+0x73/0x170
 asm_exc_page_fault+0x26/0x30
Charged to memcg / 

For anon page:

added: "ANON_PAGE address 0x4c4000"

Page allocated via order 0, mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 98, tgid 98 (a.out), ts 28442066180 ns
ANON_PAGE address 0x4c4000
PFN 0x2c3db type Movable Block 353 type Movable Flags 0x1fffc00000a0028(uptodate|lru|mappedtodisk|swapbacked|node=0|zone=1|lastcpupid=0x3fff)
 post_alloc_hook+0x77/0xf0
 get_page_from_freelist+0x58d/0x14e0
 __alloc_pages+0x1b2/0x380
 alloc_pages_mpol+0x97/0x1f0
 vma_alloc_folio+0x5c/0xd0
 do_wp_page+0x288/0xe30
 __handle_mm_fault+0x8ca/0x1760
 handle_mm_fault+0xbc/0x2f0
 do_user_addr_fault+0x158/0x5e0
 exc_page_fault+0x73/0x170
 asm_exc_page_fault+0x26/0x30
Charged to memcg / 

Jeff Xie (4):
  mm, page_owner: add folio allocate post callback for struct page_owner
    to make the owner clearer
  mm, slub: implement slub allocate post callback for page_owner
  filemap: implement filemap allocate post callback for page_owner
  mm/rmap: implement anonmap allocate post callback for page_owner

 include/linux/page_owner.h |  9 ++++++++
 include/linux/pagemap.h    |  7 ++++++
 include/linux/rmap.h       |  7 ++++++
 include/linux/slab.h       |  8 ++++++-
 mm/filemap.c               | 44 ++++++++++++++++++++++++++++++++++++++
 mm/page_owner.c            | 36 +++++++++++++++++++++++++++++++
 mm/rmap.c                  | 15 ++++++++++++-
 mm/slub.c                  | 15 +++++++++++++
 8 files changed, 139 insertions(+), 2 deletions(-)

based on mm-stable commit: be3ca57cfb77
-- 
2.34.1


