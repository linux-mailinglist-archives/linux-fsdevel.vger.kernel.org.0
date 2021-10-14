Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26F42D7CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Oct 2021 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJNLLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 07:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhJNLK7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:10:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3385A60F23;
        Thu, 14 Oct 2021 11:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634209735;
        bh=HHKCYup8+gHVwWVOB+Bc7IT9RNl6ysJ2n6UcEXDuoY4=;
        h=From:To:Cc:Subject:Date:From;
        b=hyz8gG2uOFBcvyzceZp6eLX2XZd1QxKvaBMJyc6/73HkK5VnezFdl9r1knNnjAR3p
         Y0vf2QFqesNtP4SLw20sCnrbTk/cbbpwt8Hnb08BZs0ebceYIGTjaCYhDQHb7aY0ga
         NR/LsBZTL5NAjD2apKANMhFMZPhrn53H8uJdX7m83s43rWy+3z/ZiLzA6F3qtPKvzk
         aKrogzWNcffeZGq0kBvkjRI7xIjKfNP94iNw2vCiCEnPRVk7/y362lP5sp0KvFJyXE
         k8moUHzS3OvN8VJKdAVqINg56j5CkbwhHU1PrLe4FbwpduRT6sILNZ/piz21YzY8NT
         ZFOSSupYLGk/A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rdunlap@infradead.org, broonie@kernel.org,
        linux-next@vger.kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/vaddr: Include 'highmem.h' to fix a build failure
Date:   Thu, 14 Oct 2021 11:08:48 +0000
Message-Id: <20211014110848.5204-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 0ff28922686c ("mm/damon/vaddr: separate commonly usable
functions") in -mm tree[1] moves include of 'highmem.h' from 'vaddr.c'
to 'prmtv-common.c', though the code for the header is still in
'vaddr.c'.  As a result, build with 'CONFIG_HIGHPTE' fails as below:

    In file included from ../include/linux/mm.h:33:0,
                      from ../include/linux/kallsyms.h:13,
                      from ../include/linux/bpf.h:20,
                      from ../include/linux/bpf-cgroup.h:5,
                      from ../include/linux/cgroup-defs.h:22,
                      from ../include/linux/cgroup.h:28,
                      from ../include/linux/hugetlb.h:9,
                      from ../mm/damon/vaddr.c:11:
    ../mm/damon/vaddr.c: In function ‘damon_mkold_pmd_entry’:
    ../include/linux/pgtable.h:97:12: error: implicit declaration of function ‘kmap_atomic’; did you mean ‘mcopy_atomic’? [-Werror=implicit-function-declaration]
       ((pte_t *)kmap_atomic(pmd_page(*(dir))) +  \
                 ^
    ../include/linux/mm.h:2376:17: note: in expansion of macro ‘pte_offset_map’
       pte_t *__pte = pte_offset_map(pmd, address); \
                      ^~~~~~~~~~~~~~
    ../mm/damon/vaddr.c:387:8: note: in expansion of macro ‘pte_offset_map_lock’
       pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
             ^~~~~~~~~~~~~~~~~~~
    ../include/linux/pgtable.h:99:24: error: implicit declaration of function ‘kunmap_atomic’; did you mean ‘in_atomic’? [-Werror=implicit-function-declaration]
      #define pte_unmap(pte) kunmap_atomic((pte))
                             ^
    ../include/linux/mm.h:2384:2: note: in expansion of macro ‘pte_unmap’
       pte_unmap(pte);     \
       ^~~~~~~~~
    ../mm/damon/vaddr.c:392:2: note: in expansion of macro ‘pte_unmap_unlock’
       pte_unmap_unlock(pte, ptl);
       ^~~~~~~~~~~~~~~~

This commit fixes the issue by moving the include back to 'vaddr.c'.

[1] https://github.com/hnaz/linux-mm/commit/0ff28922686c

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/prmtv-common.c | 1 -
 mm/damon/vaddr.c        | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/prmtv-common.c b/mm/damon/prmtv-common.c
index 1768cbe1b9ff..7e62ee54fb54 100644
--- a/mm/damon/prmtv-common.c
+++ b/mm/damon/prmtv-common.c
@@ -5,7 +5,6 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
-#include <linux/highmem.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index ce7e36ca1bff..758501b8d97d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "damon-va: " fmt
 
 #include <asm-generic/mman-common.h>
+#include <linux/highmem.h>
 #include <linux/hugetlb.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
-- 
2.17.1

