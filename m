Return-Path: <linux-fsdevel+bounces-11619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F4855665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38E328A679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26C365191;
	Wed, 14 Feb 2024 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8yUxgNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76E2511E
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951466; cv=none; b=HCmY7DxNRq0HSc05Fbu2xR7N86BJ3z1CKHIHtZfB3RDwnD+xHcNa9TDOsVTWGQ6HSwPZXNR+2/KABEo1b4WkKGkTslpYvzFdeRrATXo7cJ2GXt9ba5PP+3sdBZ1lP8vLgjQvCyvZ/xG7Qro5ibmsTIXyJJCLrKT3UxcyZcjj4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951466; c=relaxed/simple;
	bh=omDxOFUdQAytJ00R1OxBhkCDUc7XsQHnbed2qK7jLsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=LmysBgXQP+3vNwQ5l8kXql1RQZ+KLwsKg8y6h4KiSf7gWDleQlJYk7DjZL178vt8zkVZ6r4/r9M8sJzQtj6T7XMmlWiFVQes+bjQIe4XYjeHIzbontLSdq62Y6MZ0Tz2FusBxMldApuzk2RccQgqoZ84eEp4GDkEh8EC3psHX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8yUxgNr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607ac7dbd61so4475497b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 14:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707951463; x=1708556263; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ER/kDDF0VbhJ9fY0LYS6Jm2lqhCgvi5b8hhyOiCuUPM=;
        b=E8yUxgNrnMmpgucnbwoNjgTmw14t0eFYsbB9clhjSNwG4emKimBu6MkDkK8PK6le8U
         h7T9G3wl9bvZljYVZSm5YO6LY6Xm4mEeH2oqMB4Q4dVW8LNYMmc7IIhSCEiuzoq532Q8
         A7xFPz0XpCO48xqYgHM3lpxoj8+eRCEfDWzOSGEge191ZwZ98xqRDMb6wzhZAwR+5ega
         p9P9zikzLkTBN00k5g9Xouu/FxGELtVK32zKseo/634Ao0oVzveIm3j0gxidnU6NTMOA
         oaHVU6BH7AWHgWEtryZMVbPtZTsC6VfeNVXjAionGf+tSwrcGnGWvMwTtfqXozZHYjj4
         n2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951463; x=1708556263;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ER/kDDF0VbhJ9fY0LYS6Jm2lqhCgvi5b8hhyOiCuUPM=;
        b=SHarieVU/5qqWKa5R3DJNp8BcgMm4sO0rvpMEU2+lPpNOkbUodnV9m9QRFTVj04xku
         wZYCg10SwfXE1HFmEVjBzw3gYnxP0wAjrg887rOlde8bXRZONncQKFCH7CeLl/rPk9yz
         61TZPRel0SnFy2HdQf/O/8wEQt20Cyof3fOW/35/hR1Des6I0nfnvIscYXHcr9G8x/tL
         ZBSgsG8h8qKNgd4XBYT6QGGMdb6wGPeA9bXgYSVNCJLXGshGxSErWY+cXHpb04+Lap25
         LrL4V6uXE6YvaDL3RE9B8tOQX1jKjhxdFvs0wlILtknxNLANkR4KBK80s++9iSw2PV8q
         1OGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTFg/ZJZ0b0QFJMZiOdZAmx+amHqBqo9c9pqe42V1W9UB3kwGCUywElXe+tuW5+oN8mD+OWuDYotfBcRPzjMBnHyDNISgBjtTdPYVSMA==
X-Gm-Message-State: AOJu0Yww+DmFEMWpMz4sEIr8wlTnlAO/KIWIOxYcb9ZB8oSSX3XJMQiP
	wSG9snfyaTCv9/oLKt4b528Z4kQfX7hdvlqkZbLS4oL2WQ2tcsZH1tlOuD89ofwRg36rFjVC1BO
	D05VbzGTY79hdqbdSrsLgWg==
X-Google-Smtp-Source: AGHT+IFTRjt4DJhFCr9j1PqFgRtUHJFi+z87oKy8C90T3jT3GR3k+j/v65obVYtWfG5q0k1nva8mC1JT1TFc5nVKFg==
X-Received: from souravpanda.svl.corp.google.com ([2620:15c:2a3:200:b4ba:86fe:7d36:2fb0])
 (user=souravpanda job=sendgmr) by 2002:a81:99d5:0:b0:607:75af:8006 with SMTP
 id q204-20020a8199d5000000b0060775af8006mr3707ywg.0.1707951462771; Wed, 14
 Feb 2024 14:57:42 -0800 (PST)
Date: Wed, 14 Feb 2024 14:57:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240214225741.403783-1-souravpanda@google.com>
Subject: [PATCH v8 0/1] mm: report per-page metadata information
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
2.43.0.687.g38aa6559b0-goog


