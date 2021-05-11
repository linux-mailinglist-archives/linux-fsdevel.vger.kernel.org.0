Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C537337A80F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhEKNuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 09:50:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2700 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhEKNuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 09:50:19 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FffN84x6Hz1BKTv;
        Tue, 11 May 2021 21:46:32 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 11 May 2021
 21:49:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <hughd@google.com>, <adobriyan@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v3 0/5] Cleanup and fixup for huge_memory
Date:   Tue, 11 May 2021 21:48:52 +0800
Message-ID: <20210511134857.1581273-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,
This series contains cleanups to remove dedicated macro and remove
unnecessary tlb_remove_page_size() for huge zero pmd. Also this adds
missing read-only THP checking for transparent_hugepage_enabled() and
avoids discarding hugepage if other processes are mapping it. More
details can be found in the respective changelogs. Thanks!

v2->v3:
  collect Reviewed-by and Acked-by tag
  rename transhuge_vma_enabled to transparent_hugepage_active and
add helper file_thp_enabled per David Hildenbrand

v1->v2:
  collect Reviewed-by tag
  add missing check for read-only THP per Yang Shi

Miaohe Lin (5):
  mm/huge_memory.c: remove dedicated macro HPAGE_CACHE_INDEX_MASK
  mm/huge_memory.c: use page->deferred_list
  mm/huge_memory.c: add missing read-only THP checking in
    transparent_hugepage_enabled()
  mm/huge_memory.c: remove unnecessary tlb_remove_page_size() for huge
    zero pmd
  mm/huge_memory.c: don't discard hugepage if other processes are
    mapping it

 fs/proc/task_mmu.c      |  2 +-
 include/linux/huge_mm.h | 33 ++++++++++++++++++++++-----------
 mm/huge_memory.c        | 20 +++++++++++++-------
 mm/khugepaged.c         |  4 +---
 mm/shmem.c              |  3 +--
 5 files changed, 38 insertions(+), 24 deletions(-)

-- 
2.23.0

