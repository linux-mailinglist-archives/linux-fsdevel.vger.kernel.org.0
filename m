Return-Path: <linux-fsdevel+bounces-68593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB23C60E85
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 02:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 69DDC24268
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 01:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859D1FDE01;
	Sun, 16 Nov 2025 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTrVC/za"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC73A86277
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763256749; cv=none; b=koXGNFfAgIbPHrFqEY5lttVnklkaeVHkAE5v0Vm1w/2xBJGzQ9pSI3grytGANR6bDkvi/OZ8I6I/VaQtH5I7yytne4IsyQMbGVC1iG5ZqJFrJ36Ksk3MfQHhGCI5TcwEdtKbis28DhIfpRqjj5RukHTnla9EwT3mWK/ggl41JoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763256749; c=relaxed/simple;
	bh=jKP1k2gQFB+5o1ToMqAG6WX6wVRc9oO3PV7b6RMrOLA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oC+EsxlDRkpuDv8pYIIzo8MQIOUgRyC04tBhgmdARIEmlB1zEYoFT5JypXbERfUM/HMS50En6lkN2qDn1kpipRAFANQ7Od4IIO4jJJ0qdi/1UOP1Njw5KuAk6ExpxDLV8jwkYu7Tx8ThEunO15K6JHMnNo6CgrKjgwLMswN6t9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTrVC/za; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295fbc7d4abso36759515ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 17:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763256747; x=1763861547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIrByt1VZZMaZX/NwbB12ty+E27e+8Fq3BdD+JwCmdE=;
        b=FTrVC/zaAzU0zFQcK1vUZgUYpzDeLpVhbYm7UzTFMKK6XjX/4m4gKQvAUnBrOhLXyc
         ZMdsDm+ajqeNYdZkxJBPP00z7MfnVl6I+sCnQtenuk+7555eqDEk1XpsbDw1FPdFSR7/
         FxKaUxORMyxYWqV26cGePUzTC5uR1pg89ZubnNJ4tqi713bu5z8BYzRCJDzhDcu+gisT
         ZyiRuEGC9lnWlZ5T3wu9SOFEoyeqNljzuoKCzsd01LkoTSYJsW12z5LltxBhXXk+zWRn
         iICyDGXSx3PhAHBT7KRtM3GdeZS2rC3zeiZIiw9OAf732vP1MbSnemwTJ8LTHGBUQrEH
         P4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763256747; x=1763861547;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nIrByt1VZZMaZX/NwbB12ty+E27e+8Fq3BdD+JwCmdE=;
        b=DHzuP0sm246dYXUeGoK3d8ONge6lIdGfekikbMVm7cQHBM24bBMIbilD2YkOnOOANr
         REqaHSiOh+MyL8zdmXvO93/vZ1l1OPjDxa4s4cLPLhlTgbMzIQtGsttwSYEqL3BJOn42
         e/DeFwVS8ramASdDQfGlB3WgGRTKNpCkD2+fMOT8tmhh53llzbWeDXgv7o/Y8iq8mquM
         /ifzCU1pC6UzbDDhi8xEXjWjVkeFQLWKZTofJn9NX05LqfiP9goQPyEKoXkkzpfoekJX
         5GHfQAj01kuDLrosSoRrkHQhHXzVLLQoF+Mr7bPMAF5UBcqxUuI2ogugArngDPFVOc2O
         FJLA==
X-Forwarded-Encrypted: i=1; AJvYcCV9FSvWruv1gGGcATzLlbq5JlzFtyoNKJs+Y7EaO/n6UgCME40XruwrPK4yjQjpprE7fQ8nDZaXWuaDxQyj@vger.kernel.org
X-Gm-Message-State: AOJu0Yym++0QQzOEiEmV8YFRl6KyYziVIZt3RZiqhNVL86j5IfxJXInm
	W5LrKsUmqG/XnJ2Lxicbhq8PYLBqCWgNxR5u15dM4g3RCfE6PUsOzD6JcMRzZwk2X8rV8nSMhvM
	g3ZWaOKnasoNcbw==
X-Google-Smtp-Source: AGHT+IGEId8VQV6EnjjzjhQ7E7WrfZaNer4Ithw1tScNmlwXQtjYa6DqLZ/MZlXgCrT12Tsa7zKSgYkd8XexwA==
X-Received: from plko5.prod.google.com ([2002:a17:902:6b05:b0:296:18d:ea10])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:17c6:b0:295:1aa7:edf7 with SMTP id d9443c01a7336-2986a73ba63mr89628075ad.30.1763256747026;
 Sat, 15 Nov 2025 17:32:27 -0800 (PST)
Date: Sun, 16 Nov 2025 01:32:20 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251116013223.1557158-1-jiaqiyan@google.com>
Subject: [PATCH v2 0/3] memfd-based Userspace MFR Policy for HugeTLB
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, william.roche@oracle.com, 
	harry.yoo@oracle.com
Cc: tony.luck@intel.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	jane.chu@oracle.com, akpm@linux-foundation.org, osalvador@suse.de, 
	rientjes@google.com, duenwen@google.com, jthoughton@google.com, 
	jgg@nvidia.com, ankita@nvidia.com, peterx@redhat.com, 
	sidhartha.kumar@oracle.com, ziy@nvidia.com, david@redhat.com, 
	dave.hansen@linux.intel.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Problem
=======

This patchset is a follow-up for the userspace memory failure
recovery (MFR) policy proposed in [1] and [2], but focused on
a smaller scope: HugeTLB.

To recap the problem for HugeTLB discussed in [1] and [2]:
Cloud providers like Google and Oracle usually serve capacity-
and performance-critical guest memory with 1G HugeTLB
hugepages, as this significantly reduces the overhead
associated with managing page tables and TLB misses. However,
the kernel's current MFR behavior for HugeTLB is not ideal.
Once a byte of memory in a hugepage is hardware corrupted, the
kernel discards the whole hugepage, including the healthy
portion, from the HugeTLB system. Customer workload running in
the VM can hardly recover from such a great loss of memory.

[1] and [2] proposed the idea that the decision to keep or
discard a large chunk of contiguous memory exclusively owned
by a userspace process due to a recoverable uncorrected
memory error (UE) should be controlled by userspace. What this
means in the Cloud case is that, since a virtual machine
monitor (VMM) has taken host memory to exclusively back the
guest memory for a VM, the VMM can keep holding the memory
even after memory errors occur.

MFD_MF_KEEP_UE_MAPPED for HugeTLB
=================================

[2] proposed a solution centered around the memfd associated
with the memory exclusively owned by userspace.

A userspace process must opt into the MFD_MF_KEEP_UE_MAPPED
policy when it creates a new HugeTLB-backed memfd:

  #define MFD_MF_KEEP_UE_MAPPED	0x0020U
  int memfd_create(const char *name, unsigned int flags);

For any hugepage associated with the MFD_MF_KEEP_UE_MAPPED
enabled memfd, whenever it runs into a UE, MFR doesn't hard
offline the HWPoison-ed huge folio. In other words, the
HWPoison-ed memory remains accessible via the returned memfd
or the memory mapping created with that memfd. MFR still sends
SIGBUS to the userspace process as required. MFR also still
maintains HWPoison metadata on the hugepage having the UE.

A HWPoison-ed hugepage will be immediately isolated and
prevented from future allocation once userspace truncates it
via the memfd, or the owning memfd is closed.

By default MFD_MF_KEEP_UE_MAPPED is not set, and MFR hard
offlines hugepages having UEs.

Implementation
==============

Implementation is relatively straightforward with two major parts.

Part 1: When hugepages owned by an MFD_MF_KEEP_UE_MAPPED
enabled memfd run into a UE:

* MFR defers hard offline operations, i.e., unmapping and
  dissolving. MFR still sets HWPoison flags and holds a refcount
  for every raw HWPoison-ed page. MFR still sends SIGBUS to the
  consuming thread, but si_addr_lsb will be reduced to PAGE_SHIFT.
* If the memory was not faulted in yet, the fault handler also
  needs to unblock the fault to the HWPoison-ed folio.

Part 2: When an MFD_MF_KEEP_UE_MAPPED enabled memfd is being
released, or when a userspace process truncates a range of
hugepages belonging to an MFD_MF_KEEP_UE_MAPPED enabled memfd:

* When the HugeTLB in-memory file system removes a filemap's
  folios one by one, it asks MFR to deal with HWPoison-ed folios
  on the fly, implemented by filemap_offline_hwpoison_folio().

* MFR drops the refcounts being held for the raw HWPoison-ed
  pages within the folio. Now that the HWPoison-ed folio becomes
  a free HugeTLB folio, MFR dissolves it into a set of raw pages.
  dissolve_free_hugetlb_folio() frees them all to the buddy
  allocator, including the HWPoison-ed raw pages. So MFR also
  needs to take these HWPoison-ed pages off the buddy allocator.

One thing worthy of note, as pointed out by William Roche:
During the time window between freeing to the buddy allocator
and taking off the buddy allocator, a high-order folio with
HWPoison-ed subpages can be allocated. This racing issue already
exists today, after buddy allocator reduced sanity checks [3].
With MFD_MF_KEEP_UE_MAPPED, multiple raw HWPoison-ed pages can
be allocated. Since MFD_MF_KEEP_UE_MAPPED could exaggerate the
issue, I have proposed a solution [4] based on discussion with
Harry Yoo and Miaohe Lin, and will send it out as a separately
formal patchset.

Changelog
=========

v2 -> v1 [2]
- Rebased onto commit 6da43bbeb6918 ("Merge tag 'vfio-v6.18-rc6' of
  https://github.com/awilliam/linux-vfio").
- Removed populate_memfd_hwp_folios and offline_memfd_hwp_folios so
  that no memory allocation is needed during releasing HWPoison-ed
  memfd.
- Inserted filemap_offline_hwpoison_folio into remove_inode_single_folio.
  Now dissolving and offlining HWPoison-ed huge folios is done on the fly.
- Fixed the bug pointed out by William Roche <william.roche@oracle.com>:
  call take_page_off_buddy no matter HWPoison-ed page is buddy page or not.
- Removed update_per_node_mf_stats when dissolve failed.
- Made hugetlb-mfr allocate 4 1G hugepages to cover new code introduced
  in remove_inode_hugepages.
- Made hugetlb-mfr support testing both 1GB and 2MB HugeTLB hugepages.
- Fixed some typos in documentation.

[1] https://lwn.net/Articles/991513
[2] https://lore.kernel.org/lkml/20250118231549.1652825-1-jiaqiyan@google.com
[3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
[4] https://lore.kernel.org/lkml/CACw3F51VGxg4q9nM_eQN7OXs7JaZo9K-nvDwxtZgtjFSNyjQaw@mail.gmail.com


Jiaqi Yan (3):
  mm: memfd/hugetlb: introduce memfd-based userspace MFR policy
  selftests/mm: test userspace MFR for HugeTLB hugepage
  Documentation: add documentation for MFD_MF_KEEP_UE_MAPPED

 Documentation/userspace-api/index.rst         |   1 +
 .../userspace-api/mfd_mfr_policy.rst          |  60 ++++
 fs/hugetlbfs/inode.c                          |  25 +-
 include/linux/hugetlb.h                       |   7 +
 include/linux/pagemap.h                       |  24 ++
 include/uapi/linux/memfd.h                    |   6 +
 mm/hugetlb.c                                  |  20 +-
 mm/memfd.c                                    |  15 +-
 mm/memory-failure.c                           | 124 ++++++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/hugetlb-mfr.c      | 327 ++++++++++++++++++
 12 files changed, 592 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/userspace-api/mfd_mfr_policy.rst
 create mode 100644 tools/testing/selftests/mm/hugetlb-mfr.c

-- 
2.52.0.rc1.455.g30608eb744-goog


