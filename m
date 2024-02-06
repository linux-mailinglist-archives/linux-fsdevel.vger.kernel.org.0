Return-Path: <linux-fsdevel+bounces-10441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2C84B355
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E25B22FFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B3812EBE4;
	Tue,  6 Feb 2024 11:21:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6643AB8
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218508; cv=none; b=EGCJ+3gCMo3jWOiRHWUFozwUGDE15eCBkrXRyui2pE1TDPjrMjJDA5N9l8wLLqbgLXgWpXSd58Qt05rfX5LfvIl4rS2ojxgJKadD55quZPwHa4jCqpRrZxnp9JIGmamd0rfNFVaNhjsrTFEThOAFhUwWntl5ivmx/fBZ5UHtyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218508; c=relaxed/simple;
	bh=PPYYxet/g8YJ7tA1HCJB3VgTr7Gvgl54gRMbg1TpIPw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E58r1KOlxHxt0uoB2VWI7Y12eokXV9tY/e4n7mvZmY/UR/XOAiMRi6S3wpUQqQYdLEi8EbLKrkhrG56uy9jL/YptofaSEalfmkoZdYbQT14K2X1NvEzcGtII5YRvSNeSWv+FW4ugISHfU6t7O5lT4GOwAfK3gdVQm6vuVJi7Jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TTgkp6Hdkz29lQp;
	Tue,  6 Feb 2024 19:19:46 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EB29140412;
	Tue,  6 Feb 2024 19:21:42 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 19:21:41 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC: Tony Luck <tony.luck@intel.com>, Naoya Horiguchi
	<naoya.horiguchi@nec.com>, Miaohe Lin <linmiaohe@huawei.com>, Matthew Wilcox
	<willy@infradead.org>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfcv2 00/11] mm: migrate: support poison recover from migrate folio
Date: Tue, 6 Feb 2024 19:21:23 +0800
Message-ID: <20240206112134.1479464-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

rfcv2:
- Separate __migrate_device_pages() cleanup from patch "remove 
  migrate_folio_extra()", suggested by Matthew
- Split folio_migrate_mapping(), move refcount check/freeze out
  of folio_migrate_mapping(), suggested by Matthew
- add RB

Kefeng Wang (11):
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
  fs: aio: add explicit check for large folio in aio_migrate_folio()

 fs/aio.c                     |  15 ++--
 fs/hugetlbfs/inode.c         |   5 +-
 include/linux/migrate.h      |   3 -
 include/linux/migrate_mode.h |   5 --
 include/linux/mm.h           |   1 +
 mm/balloon_compaction.c      |   8 --
 mm/migrate.c                 | 157 +++++++++++++++++------------------
 mm/migrate_device.c          |  28 +++----
 mm/util.c                    |  20 +++++
 mm/zsmalloc.c                |   8 --
 10 files changed, 115 insertions(+), 135 deletions(-)

-- 
2.27.0


