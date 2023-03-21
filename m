Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0386C2F93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCUKw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCUKwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:52:22 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 03:52:17 PDT
Received: from harvie.cz (harvie.cz [77.87.242.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582BB19100;
        Tue, 21 Mar 2023 03:52:16 -0700 (PDT)
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by harvie.cz (Postfix) with ESMTPSA id D37151801B5;
        Tue, 21 Mar 2023 11:35:04 +0100 (CET)
From:   Tomas Mudrunka <tomas.mudrunka@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rppt@kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tomas.mudrunka@gmail.com
Subject: [PATCH v2] Add results of early memtest to /proc/meminfo
Date:   Tue, 21 Mar 2023 11:34:30 +0100
Message-Id: <20230321103430.7130-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
References: <20230317165637.6be5414a3eb05d751da7d19f@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_PASS,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the memtest results were only presented in dmesg.
This adds /proc/meminfo entry which can be easily used by scripts.

Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
---
 Documentation/filesystems/proc.rst |  8 ++++++++
 fs/proc/meminfo.c                  | 13 +++++++++++++
 include/linux/memblock.h           |  2 ++
 mm/memtest.c                       |  6 ++++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 9d5fd9424..8740362f3 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -996,6 +996,7 @@ Example output. You may not have all of these fields.
     VmallocUsed:       40444 kB
     VmallocChunk:          0 kB
     Percpu:            29312 kB
+    EarlyMemtestBad:       0 kB
     HardwareCorrupted:     0 kB
     AnonHugePages:   4149248 kB
     ShmemHugePages:        0 kB
@@ -1146,6 +1147,13 @@ VmallocChunk
 Percpu
               Memory allocated to the percpu allocator used to back percpu
               allocations. This stat excludes the cost of metadata.
+EarlyMemtestBad
+              The amount of RAM/memory in kB, that was identified as corrupted
+              by early memtest. If memtest was not run, this field will not
+              be displayed at all. Size is never rounded down to 0 kB.
+              That means if 0 kB is reported, you can safely assume
+              there was at least one pass of memtest and none of the passes
+              found a single faulty byte of RAM.
 HardwareCorrupted
               The amount of RAM/memory in KB, the kernel identifies as
               corrupted.
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 440960110..b43d0bd42 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -6,6 +6,7 @@
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/mmzone.h>
+#include <linux/memblock.h>
 #include <linux/proc_fs.h>
 #include <linux/percpu.h>
 #include <linux/seq_file.h>
@@ -131,6 +132,18 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
 	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
+#ifdef CONFIG_MEMTEST
+	if (early_memtest_done) {
+		unsigned long early_memtest_bad_size_kb;
+
+		early_memtest_bad_size_kb = early_memtest_bad_size>>10;
+		if (early_memtest_bad_size && !early_memtest_bad_size_kb)
+			early_memtest_bad_size_kb = 1;
+		/* When 0 is reported, it means there actually was a successful test */
+		seq_printf(m, "EarlyMemtestBad:   %5lu kB\n", early_memtest_bad_size_kb);
+	}
+#endif
+
 #ifdef CONFIG_MEMORY_FAILURE
 	seq_printf(m, "HardwareCorrupted: %5lu kB\n",
 		   atomic_long_read(&num_poisoned_pages) << (PAGE_SHIFT - 10));
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662..f82ee3fac 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -597,6 +597,8 @@ extern int hashdist;		/* Distribute hashes across NUMA nodes? */
 #endif
 
 #ifdef CONFIG_MEMTEST
+extern phys_addr_t early_memtest_bad_size;	/* Size of faulty ram found by memtest */
+extern bool early_memtest_done;			/* Was early memtest done? */
 extern void early_memtest(phys_addr_t start, phys_addr_t end);
 #else
 static inline void early_memtest(phys_addr_t start, phys_addr_t end)
diff --git a/mm/memtest.c b/mm/memtest.c
index f53ace709..57149dfee 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -4,6 +4,9 @@
 #include <linux/init.h>
 #include <linux/memblock.h>
 
+bool early_memtest_done;
+phys_addr_t early_memtest_bad_size;
+
 static u64 patterns[] __initdata = {
 	/* The first entry has to be 0 to leave memtest with zeroed memory */
 	0,
@@ -30,6 +33,7 @@ static void __init reserve_bad_mem(u64 pattern, phys_addr_t start_bad, phys_addr
 	pr_info("  %016llx bad mem addr %pa - %pa reserved\n",
 		cpu_to_be64(pattern), &start_bad, &end_bad);
 	memblock_reserve(start_bad, end_bad - start_bad);
+	early_memtest_bad_size += (end_bad - start_bad);
 }
 
 static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size)
@@ -61,6 +65,8 @@ static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size
 	}
 	if (start_bad)
 		reserve_bad_mem(pattern, start_bad, last_bad + incr);
+
+	early_memtest_done = true;
 }
 
 static void __init do_one_pass(u64 pattern, phys_addr_t start, phys_addr_t end)
-- 
2.40.0

