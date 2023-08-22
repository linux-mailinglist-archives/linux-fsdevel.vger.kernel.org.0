Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86F778493A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjHVSGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 14:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHVSGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:06:30 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3713DCF1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Aug 2023 11:06:12 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id D6D9DA9FA88E; Tue, 22 Aug 2023 11:05:42 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v4] proc/ksm: add ksm stats to /proc/pid/smaps
Date:   Tue, 22 Aug 2023 11:05:39 -0700
Message-Id: <20230822180539.1424843-1-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_PASS,SPF_NEUTRAL,TVD_RCVD_IP autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With madvise and prctl KSM can be enabled for different VMA's. Once it
is enabled we can query how effective KSM is overall. However we cannot
easily query if an individual VMA benefits from KSM.

This commit adds a KSM section to the /prod/<pid>/smaps file. It reports
how many of the pages are KSM pages. The returned value for KSM is
independent of the use of the shared zeropage.

Here is a typical output:

7f420a000000-7f421a000000 rw-p 00000000 00:00 0
Size:             262144 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:               51212 kB
Pss:                8276 kB
Shared_Clean:        172 kB
Shared_Dirty:      42996 kB
Private_Clean:       196 kB
Private_Dirty:      7848 kB
Referenced:        15388 kB
Anonymous:         51212 kB
KSM:               41376 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:             202016 kB
SwapPss:            3882 kB
Locked:                0 kB
THPeligible:    0
ProtectionKey:         0
ksm_state:          0
ksm_skip_base:      0
ksm_skip_count:     0
VmFlags: rd wr mr mw me nr mg anon

This information also helps with the following workflow:
- First enable KSM for all the VMA's of a process with prctl.
- Then analyze with the above smaps report which VMA's benefit the most
- Change the application (if possible) to add the corresponding madvise
calls for the VMA's that benefit the most

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/filesystems/proc.rst |  4 ++++
 fs/proc/task_mmu.c                 | 16 +++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
index 7897a7dafcbc..d5bdfd59f5b0 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -461,6 +461,7 @@ Memory Area, or VMA) there is a series of lines such =
as the following::
     Private_Dirty:         0 kB
     Referenced:          892 kB
     Anonymous:             0 kB
+    KSM:                   0 kB
     LazyFree:              0 kB
     AnonHugePages:         0 kB
     ShmemPmdMapped:        0 kB
@@ -501,6 +502,9 @@ accessed.
 a mapping associated with a file may contain anonymous pages: when MAP_P=
RIVATE
 and a page is modified, the file page is replaced by a private anonymous=
 copy.
=20
+"KSM" shows the amount of anonymous memory that has been de-duplicated. =
The
+value is independent of the use of shared zeropage.
+
 "LazyFree" shows the amount of memory which is marked by madvise(MADV_FR=
EE).
 The memory isn't freed immediately with madvise(). It's freed in memory
 pressure if the memory is clean. Please note that the printed value migh=
t
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 51315133cdc2..4532caa8011c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -4,6 +4,7 @@
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
+#include <linux/ksm.h>
 #include <linux/seq_file.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
@@ -396,6 +397,7 @@ struct mem_size_stats {
 	unsigned long swap;
 	unsigned long shared_hugetlb;
 	unsigned long private_hugetlb;
+	unsigned long ksm;
 	u64 pss;
 	u64 pss_anon;
 	u64 pss_file;
@@ -435,9 +437,9 @@ static void smaps_page_accumulate(struct mem_size_sta=
ts *mss,
 	}
 }
=20
-static void smaps_account(struct mem_size_stats *mss, struct page *page,
-		bool compound, bool young, bool dirty, bool locked,
-		bool migration)
+static void smaps_account(struct mem_size_stats *mss, pte_t *pte,
+		struct page *page, bool compound, bool young, bool dirty,
+		bool locked, bool migration)
 {
 	int i, nr =3D compound ? compound_nr(page) : 1;
 	unsigned long size =3D nr * PAGE_SIZE;
@@ -452,6 +454,9 @@ static void smaps_account(struct mem_size_stats *mss,=
 struct page *page,
 			mss->lazyfree +=3D size;
 	}
=20
+	if (PageKsm(page) && (!pte || !is_ksm_zero_pte(*pte)))
+		mss->ksm +=3D size;
+
 	mss->resident +=3D size;
 	/* Accumulate the size in pages that have been accessed. */
 	if (young || page_is_young(page) || PageReferenced(page))
@@ -557,7 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long=
 addr,
 	if (!page)
 		return;
=20
-	smaps_account(mss, page, false, young, dirty, locked, migration);
+	smaps_account(mss, pte, page, false, young, dirty, locked, migration);
 }
=20
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -591,7 +596,7 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long=
 addr,
 	else
 		mss->file_thp +=3D HPAGE_PMD_SIZE;
=20
-	smaps_account(mss, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
+	smaps_account(mss, NULL, page, true, pmd_young(*pmd), pmd_dirty(*pmd),
 		      locked, migration);
 }
 #else
@@ -822,6 +827,7 @@ static void __show_smap(struct seq_file *m, const str=
uct mem_size_stats *mss,
 	SEQ_PUT_DEC(" kB\nPrivate_Dirty:  ", mss->private_dirty);
 	SEQ_PUT_DEC(" kB\nReferenced:     ", mss->referenced);
 	SEQ_PUT_DEC(" kB\nAnonymous:      ", mss->anonymous);
+	SEQ_PUT_DEC(" kB\nKSM:            ", mss->ksm);
 	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
 	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
 	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);

base-commit: f4a280e5bb4a764a75d3215b61bc0f02b4c26417
--=20
2.39.3

