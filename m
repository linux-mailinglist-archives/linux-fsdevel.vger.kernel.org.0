Return-Path: <linux-fsdevel+bounces-12185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3485CA34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 22:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268A31F22E29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 21:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA457152DF6;
	Tue, 20 Feb 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWwxld4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D91151CDC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465564; cv=none; b=TXaRmJEjyVEg2GpNnibehZ6KQw/FAZzSwvz7sJwOyK5kW1g2A80usOAYZ/3N2N28YJfGEPClpe+ErGoKcW/5qEYcZkFYBvtQ7OuK2+fNccNqJ7qFDZ49H3UQZS0CnYKuHZu7e1KPFN6MZHTbn9dhb2cumWKgEDVtCLxVZx4HrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465564; c=relaxed/simple;
	bh=eiMM/uI3YwCporpUQgYFZ1FqYmJ6e3TvgkTC4YyjgRY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Qu0uPoQW0tA8TdTTCezbskFyl2V1ngrymzUvUy5gyRyzUcKbLJR2Wu8KXrqIfxfTxJHiTQje2Y+5Sg1gCIshVX7uFeixG9Cec32e58xMj4PtRgdgExbk2iOjcgd+av9MVmsCOUVR7Rqpr/lzjN5FfXHqEhoquN5kGjTzPng/naM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWwxld4e; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso8950270276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 13:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708465560; x=1709070360; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V01TnE5q7SHBZ8jNobegTNpx6Z7xiHdfszo2NROYfag=;
        b=lWwxld4eq7H/ha/LYqrmPufcw9pbi7vU+W9acJeI4a22g+vkP8SSCDAXODOeHWtg2P
         1xAJXsHqwQyt0tl3s+Sr7Iw0P0trsFIashOs16YwsqdHG92DvfFS7RbWcRQxKEfxK/s8
         s+SU2RBKsPY8feNwi9K5cnkW+PiEJD8vkUndMcPXU/IV8V9bzFv8y8npw9reKk0mzTLd
         Utyv6Jay9PclnBqat+8XVjNUpbrYE+chYSFspg0jkdk8OU4RJc9+LlZYlHUybtPKXcmn
         cwADWGDOsS91YcnYBkG1+cMDv5SXX3hR7ZzbwTm4PgujRz2TDRyR+KoNTwdKoqc1jmhy
         n51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465560; x=1709070360;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V01TnE5q7SHBZ8jNobegTNpx6Z7xiHdfszo2NROYfag=;
        b=g6bcdKgYlUc0OsyP6L0CMG7ydyZy1dVFZCGhhsn+Fa+frfKaqAjJczukuo1AXL6wDg
         2RBuqF8Bsi8KUTmoL8tgnTrdfOMCb+wa8HBTAnlUFQOQpunhDCHjsjE29e8vumhrVFg0
         B63RNlHuPXjv9O1AerXaKAeqKn9/WY7hQ9afzDSuo3qM49KX3BS/06WjTTH6eJSjQcoj
         oYhoMH6PBONTQVp3BwLPgrJ6rz+Itd0o1jnED9I0ZEVbQSIvkr/adzGufyCUTLRqG6/a
         4ggpxzWrav3TC87zLZbBFLb/sDDRugScd7rHybZeOiGS6J69EgE4RQO/ylKBV6MNgPC9
         u0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXq/sVWfofKfbWcC+0tsAQIjVy2cjr/MgLilAZY/ie8X6DSDDIw6tAcqSfMZX0UDRHCv5qSp1FE+fizJj5mmwOCouqa8IeVHhSDYBx+WQ==
X-Gm-Message-State: AOJu0YwBZ7hwKNrQPs8xx+WLNz77BOQnTuI473EhczzStZE3Ey3TRj8c
	0PYdBbgFBiKJS0B3OJU7XliNjmG7sabypRChjuGXGe6zR0DrUpYLxwYMMEPicw24+XB6I/lU/ND
	0QZZfChOtvm53pTnazcVLBA==
X-Google-Smtp-Source: AGHT+IH4H1DQSgpPoUZE2eyOpZm0nIku1G5H6MYamCUomiBfTKrC+pL+XA4Rdc4IJs0x5KdY2LRkekHD7/JwALiSXw==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:908a:1ef7:e79e:3cf5])
 (user=souravpanda job=sendgmr) by 2002:a25:dbc6:0:b0:dc6:e5d3:5f03 with SMTP
 id g189-20020a25dbc6000000b00dc6e5d35f03mr4066041ybf.4.1708465559994; Tue, 20
 Feb 2024 13:45:59 -0800 (PST)
Date: Tue, 20 Feb 2024 13:45:57 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220214558.3377482-1-souravpanda@google.com>
Subject: [PATCH v9 0/1] mm: report per-page metadata information
From: Sourav Panda <souravpanda@google.com>
To: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org, 
	akpm@linux-foundation.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, souravpanda@google.com, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, hannes@cmpxchg.org, 
	shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"

Changelog:
v9: 	- Quick Fix:
		- In fs/proc/meminfo.c, replaced tabs with spaces for
		  consistent userspace parsing.
	- Patch is ready to be taken in.
v8:
	- Addressed Powerpc (Power8 LE) boot failure.
	  	- In __populate_section_memmap instead of calling
		  mod_node_page_state (unavaialable at boot for
		  powerpc), we call mod_node_early_perpage_metadata.
		  This was a helper function that was introduced
		  for arm, to combat this exact problem.
		- Since __populate_section_memmap is tagged with
		  __meminit, we also had to modify the tag of
		  mod_node_early_perpage_metadata from __init to
		  __meminit.
	- Naming Changes:
	  	- In /proc/meminfo PageMetadata --> Memmap
		- In /proc/vmstat  nr_page_metadata --> nr_memmap
		- In /proc/vmstat  nr_page_metadata_boot -->
		  nr_memmap_boot
	- Addressed clarifications requested by Andrew Morton.
	  	- Updated the commit log to include utility or
		  potential usage for userspace.
	- Declined changing  placement of metrics after attempting:
		- No changes in /proc/meminfo since it cannot be moved
		  to the end anyway. This is because we have also
		  hugetlb_report_meminfo() and arch_report_meminfo().
	- Rebased to version 6, patchlevel 8.
v7:
	- Addressed comments from David Rientjes
                - For exporting PageMetadata to /proc/meminfo,
                  utilize global_node_page_state_pages for item
                  NR_PAGE_METADATA. This is instead of iterating
                  over nodes and accumulating the output of
                  node_page_state.
v6:
	- Interface changes
	  	- Added per-node nr_page_metadata and
		  nr_page_metadata_boot fields that are exported
		  in /sys/devices/system/node/nodeN/vmstat
		- nr_page_metadata exclusively tracks buddy
		  allocations while nr_page_metadata_boot
		  exclusively tracks memblock allocations.
		- Modified PageMetadata in /proc/meminfo to only
		  include buddy allocations so that it is
		  comparable against MemTotal in /proc/meminfo
		- Removed the PageMetadata field added in
		  /sys/devices/system/node/nodeN/meminfo
	- Addressed bugs reported by the kernel test bot.
	  	- All occurences of __mod_node_page_state have
		  been replaced by mod_node_page_state.
	- Addressed comments from Muchun Song.
	  	- Removed page meta data accouting from
		  mm/hugetlb.c. When CONFIG_SPARSEMEM_VMEMMAP
		  is disabled struct pages should not be returned
		  to buddy.
	- Modified the cover letter with the results and analysis
		- From when memory_hotplug.memmap_on_memory is
		  alternated between 0 and 1.
		- To account for the new interface changes.

v5:
	- Addressed comments from Muchun Song.
		- Fixed errors introduced in v4 when
		  CONFIG_SPARSEMEM_VMEMMAP is disabled by testing
		  against FLATMEM and SPARSEMEM memory models.
		- Handled the condition wherein the allocation of
		  walk.reuse_page fails, by moving NR_PAGE_METADATA
		  update into the clause if( walk.reuse_page ).
		- Removed the usage of DIV_ROUND_UP from
		  alloc_vmemmap_page_list since "end - start" is
		  always a multiple of PAGE_SIZE.
		- Modified alloc_vmemmap_page_list to update
		  NR_PAGE_METADATA once instead of every loop.
v4:
	- Addressed comment from Matthew Wilcox.
		- Used __node_stat_sub_folio and __node_stat_add_folio
		  instead of __mod_node_page_state in mm/hugetlb.c.
		- Used page_pgdat wherever possible in the entire patch.
		- Used DIV_ROUND_UP() wherever possible in the entire
		  patch.
v3:
	- Addressed one comment from Matthew Wilcox.
	  	- In free_page_ext, page_pgdat() is now extracted
		  prior to freeing the memory.
v2:
	- Fixed the three bugs reported by kernel test robot.
	- Enhanced the commit message as recommended by David Hildenbrand.
	- Addressed comments from Matthew Wilcox:
	  	- Simplified alloc_vmemmap_page_list() and
		  free_page_ext() as recommended.
		- Used the appropriate comment style in mm/vmstat.c.
		- Replaced writeout_early_perpage_metadata() with
		  store_early_perpage_metadata() to reduce ambiguity
		  with what swap does.
	- Addressed comments from Mike Rapoport:
	  	- Simplified the loop in alloc_vmemmap_page_list().
		- Could NOT address a comment to move
		  store_early_perpage_metadata() near where nodes
		  and page allocator are initialized.
		- Included the vmalloc()ed page_ext in accounting
		  within free_page_ext().
		- Made early_perpage_metadata[MAX_NUMNODES] static.


Previous approaches and discussions
-----------------------------------
V8:
https://lore.kernel.org/all/20240214225741.403783-1-souravpanda@google.com
V7:
https://lore.kernel.org/all/20240129224204.1812062-1-souravpanda@google.com
V6:
https://lore.kernel.org/all/20231205223118.3575485-1-souravpanda@google.com
v5:
https://lore.kernel.org/all/20231101230816.1459373-1-souravpanda@google.com
v4:
https://lore.kernel.org/all/20231031223846.827173-1-souravpanda@google.com
v3:
https://lore.kernel.org/all/20231031174459.459480-1-souravpanda@google.com
v2:
https://lore.kernel.org/all/20231018005548.3505662-1-souravpanda@google.com
v1:
https://lore.kernel.org/r/20230913173000.4016218-2-souravpanda@google.com

Hi!

This patch adds two new per-node fields, namely nr_memmap and
nr_memmap_boot to /sys/devices/system/node/nodeN/vmstat and a
global Memmap field to /proc/meminfo. This information can be
used by users to see how much memory is being used by per-page
metadata, which can vary depending on build configuration, machine
architecture, and system use.

Per-page metadata is the amount of memory that Linux needs in order to
manage memory at the page granularity. The majority of such memory is
used by "struct page" and "page_ext" data structures.


Background
----------

Kernel overhead observability is missing some of the largest
allocations during runtime, including vmemmap (struct pages) and
page_ext. This patch aims to address this problem by exporting a
new metric Memmap.

On the contrary, the kernel does provide observibility for boot memory
allocations. For example, the metric reserved_pages depicts the pages
allocated by the bootmem allocator. This can be simply calculated as
present_pages - managed_pages, which are both exported in /proc/zoneinfo.
The metric reserved_pages is primarily composed of struct pages and
page_ext.

What about the struct pages (allocated by bootmem allocator) that are
free'd during hugetlbfs allocations and then allocated by buddy-allocator
once hugtlbfs pages are free'd?

/proc/meminfo MemTotal changes: MemTotal does not include memblock
allocations but includes buddy allocations. However, during runtime
memblock allocations can be shifted into buddy allocations, and therefore
become part of MemTotal.

Once the struct pages get allocated by buddy allocator, we lose track of
these struct page allocations overhead accounting. Therefore, we must
export new metrics. nr_memmap and nr_memmap_boot exclusively track the
struct page and page ext allocations made by the buddy allocator and
memblock allocator, respectively for each node. Memmap in /proc/meminfo
would report the struct page and page ext allocations made by the buddy
allocator.

Results and analysis
--------------------

Memory model: Sparsemem-vmemmap
$ echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:		   65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node1/vmstat | grep "nr_memmap"
        nr_memmap 8192
	nr_memmap_boot 65536

AFTER HUGTLBFS RESERVATION
$ echo 512 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      67584 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8448
	nr_memmap_boot  63488
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8448
	nr_memmap_boot  63488


AFTER FREEING HUGTLBFS RESERVATION
$ echo 0 > /proc/sys/vm/nr_hugepages

$ cat /proc/meminfo | grep MemTotal
        MemTotal:       32935508 kB
$ cat /proc/meminfo | grep Memmap
        Memmap:      81920 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
        nr_memmap 10240
	nr_memmap_boot  63488
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
        nr_memmap 10240
	nr_memmap_boot  63488

------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=1

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot  65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot  65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33951316 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 12800
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

--------------------------

Memory Hotplug with memory_hotplug.memmap_on_memory=0

BEFORE HOTADD
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       32919124 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      65536 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

AFTER HOTADDING 1GB
$ cat /proc/meminfo | grep MemTotal
	MemTotal:       33967700 kB
$ cat /proc/meminfo | grep Memmap
	Memmap:      83968 kB
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 12800
	nr_memmap_boot 65536
$ cat /sys/devices/system/node/node0/vmstat | grep "nr_memmap"
	nr_memmap 8192
	nr_memmap_boot 65536

Sourav Panda (1):
  mm: report per-page metadata information

 Documentation/filesystems/proc.rst |  3 +++
 fs/proc/meminfo.c                  |  4 ++++
 include/linux/mmzone.h             |  4 ++++
 include/linux/vmstat.h             |  4 ++++
 mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
 mm/mm_init.c                       |  3 +++
 mm/page_alloc.c                    |  1 +
 mm/page_ext.c                      | 32 +++++++++++++++++++++---------
 mm/sparse-vmemmap.c                |  8 ++++++++
 mm/sparse.c                        |  7 ++++++-
 mm/vmstat.c                        | 26 +++++++++++++++++++++++-
 11 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


