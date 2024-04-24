Return-Path: <linux-fsdevel+bounces-17635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAF28B0BBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347E91F26C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A6A15DBC3;
	Wed, 24 Apr 2024 13:59:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A52415CD7F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967180; cv=none; b=pEKUul+oQvYdJAERnoT5DFvI+kSQTIPFVXCG0BRNmFr4Tczv4fgiacc4JImBvNvn2Pc3GpQRBMjqEp//Mf3MHEKS7A95LlYaZugr7hNwbNn5tn7GB9z6SDZoPHXCkRRTl5wjKCIsN0LwYWhdFszZOsEuTHLSPY3CFMo94wbG3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967180; c=relaxed/simple;
	bh=ILYTkdyyOFKC/LDbfJwPDprJRLXf8w9VhX/Yj+HJUfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FYUbIHJCEjexO1K5448L0RJdmDWEF3XB62pzi3kiZX7f9uyX+kL+5ceO89gvABzlhIbujR7mG54g/3XXOdHO88sqyZj0h+/DkxYn6f6KjfZsPZHgOC4iPXQAleDLKucyacjXUdrs4fqpu4X5FMdYIiEqkuXoMEc3cNEeeEYxDu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VPgW76fqgzXlLD;
	Wed, 24 Apr 2024 21:56:03 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 96A00140156;
	Wed, 24 Apr 2024 21:59:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:59:32 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Miaohe Lin <linmiaohe@huawei.com>, Naoya
 Horiguchi <nao.horiguchi@gmail.com>, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>, Muchun Song <muchun.song@linux.dev>,
	Benjamin LaHaise <bcrl@kvack.org>, <jglisse@redhat.com>,
	<linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Zi Yan
	<ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>, Vishal Moola <vishal.moola@gmail.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 00/10] mm: migrate: support poison recover from migrate folio
Date: Wed, 24 Apr 2024 21:59:19 +0800
Message-ID: <20240424135929.2847185-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

The folio migration is widely used in kernel, memory compaction, memory
hotplug, soft offline page, numa balance, memory demote/promotion, etc,
but once access a poisoned source folio when migrating, the kerenl will
panic.

There is a mechanism in the kernel to recover from uncorrectable memory
errors, ARCH_HAS_COPY_MC(Machine Check Safe Memory Copy), which is already
used in NVDIMM or core-mm paths(eg, CoW, khugepaged, coredump, ksm copy),
see copy_mc_to_{user,kernel}, copy_mc_{user_}highpage callers.

This series of patches provide the recovery mechanism from folio copy for
the widely used folio migration. Please note, because folio migration is
no guarantee of success, so we could chose to make folio migration tolerant
of memory failures, adding folio_mc_copy() which is a #MC versions of
folio_copy(), once accessing a poisoned source folio, we could return error
and make the folio migration fail, and this could avoid the similar panic
shown below.

  CPU: 1 PID: 88343 Comm: test_softofflin Kdump: loaded Not tainted 6.6.0
  pc : copy_page+0x10/0xc0
  lr : copy_highpage+0x38/0x50
  ...
  Call trace:
   copy_page+0x10/0xc0
   folio_copy+0x78/0x90
   migrate_folio_extra+0x54/0xa0
   move_to_new_folio+0xd8/0x1f0
   migrate_folio_move+0xb8/0x300
   migrate_pages_batch+0x528/0x788
   migrate_pages_sync+0x8c/0x258
   migrate_pages+0x440/0x528
   soft_offline_in_use_page+0x2ec/0x3c0
   soft_offline_page+0x238/0x310
   soft_offline_page_store+0x6c/0xc0
   dev_attr_store+0x20/0x40
   sysfs_kf_write+0x4c/0x68
   kernfs_fop_write_iter+0x130/0x1c8
   new_sync_write+0xa4/0x138
   vfs_write+0x238/0x2d8
   ksys_write+0x74/0x110

v2:
- remove patch11 since fio don't support large folio
- add RB
- rebased on next-20240424

v1:
- no change, resend and rebased on 6.9-rc1

rfcv2:
- Separate __migrate_device_pages() cleanup from patch "remove 
  migrate_folio_extra()", suggested by Matthew
- Split folio_migrate_mapping(), move refcount check/freeze out
  of folio_migrate_mapping(), suggested by Matthew
- add RB

Kefeng Wang (10):
  mm: migrate: simplify __buffer_migrate_folio()
  mm: migrate_device: use more folio in __migrate_device_pages()
  mm: migrate_device: unify migrate folio for MIGRATE_SYNC_NO_COPY
  mm: migrate: remove migrate_folio_extra()
  mm: remove MIGRATE_SYNC_NO_COPY mode
  mm: migrate: split folio_migrate_mapping()
  mm: add folio_mc_copy()
  mm: migrate: support poisoned recover from migrate folio
  fs: hugetlbfs: support poison recover from hugetlbfs_migrate_folio()
  mm: migrate: remove folio_migrate_copy()

 fs/aio.c                     |  15 +---
 fs/hugetlbfs/inode.c         |   5 +-
 include/linux/migrate.h      |   3 -
 include/linux/migrate_mode.h |   5 --
 include/linux/mm.h           |   1 +
 mm/balloon_compaction.c      |   8 --
 mm/migrate.c                 | 157 +++++++++++++++++------------------
 mm/migrate_device.c          |  28 +++----
 mm/util.c                    |  20 +++++
 mm/zsmalloc.c                |   8 --
 10 files changed, 113 insertions(+), 137 deletions(-)

-- 
2.27.0


