Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EAE46321F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 12:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhK3LU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 06:20:28 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:52850 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235674AbhK3LU1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:20:27 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id DCD63C01AF;
        Tue, 30 Nov 2021 13:17:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638271023; bh=ox0oF6RresLUTP2rT28UzFMENVQVHDTEF9p61VuoVho=;
        h=Date:From:To:Cc:Subject;
        b=rdOl6dbKZfQqhC5m8RL+3o57aURnBfQENq0Q3YwsW0iEJx9zfmoslvs9QA0hG4RU8
         Uh6chFIIRr8rvrWVQPT3GxXSshg3hiOlxMWbV2Pj2RfpI3yu1+e71eNTNHbR99538n
         df3s9hHNJtGYq1Qlx9XkKxWHOIEwW/MMDiNgX934=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id BE5A5C01AA;
        Tue, 30 Nov 2021 13:17:03 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Qmfkse0NcGJL; Tue, 30 Nov 2021 13:17:02 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id BB828C019B;
        Tue, 30 Nov 2021 13:17:02 +0200 (EET)
Date:   Tue, 30 Nov 2021 20:16:52 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        iam@valdikss.org.ru, hakavlad@inbox.lv, hakavlad@gmail.com
Subject: [PATCH] mm/vmscan: add sysctl knobs for protecting the working set
Message-ID: <20211130201652.2218636d@mail.inbox.lv>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: G4mERXADmHlDpsG9Ippu5OH4pKK+V1wivi79xrsz7G4qyL6B7J5pAxyYeeHze3G0c2bD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel does not provide a way to protect the working set under memory
pressure. A certain amount of anonymous and clean file pages is required by
the userspace for normal operation. First of all, the userspace needs a
cache of shared libraries and executable binaries. If the amount of the
clean file pages falls below a certain level, then thrashing and even
livelock can take place.

The patch provides sysctl knobs for protecting the working set (anonymous
and clean file pages) under memory pressure.

The vm.anon_min_kbytes sysctl knob provides *hard* protection of anonymous
pages. The anonymous pages on the current node won't be reclaimed under any
conditions when their amount is below vm.anon_min_kbytes. This knob may be
used to prevent excessive swap thrashing when anonymous memory is low (for
example, when memory is going to be overfilled by compressed data of zram
module). The default value is defined by CONFIG_ANON_MIN_KBYTES (suggested
0 in Kconfig).

The vm.clean_low_kbytes sysctl knob provides *best-effort* protection of
clean file pages. The file pages on the current node won't be reclaimed
under memory pressure when the amount of clean file pages is below
vm.clean_low_kbytes *unless* we threaten to OOM. Protection of clean file
pages using this knob may be used when swapping is still possible to
  - prevent disk I/O thrashing under memory pressure;
  - improve performance in disk cache-bound tasks under memory pressure.
The default value is defined by CONFIG_CLEAN_LOW_KBYTES (suggested 0 in
Kconfig).

The vm.clean_min_kbytes sysctl knob provides *hard* protection of clean
file pages. The file pages on the current node won't be reclaimed under
memory pressure when the amount of clean file pages is below
vm.clean_min_kbytes. Hard protection of clean file pages using this knob
may be used to
  - prevent disk I/O thrashing under memory pressure even with no free swap
    space;
  - improve performance in disk cache-bound tasks under memory pressure;
  - avoid high latency and prevent livelock in near-OOM conditions.
The default value is defined by CONFIG_CLEAN_MIN_KBYTES (suggested 0 in
Kconfig).

Signed-off-by: Alexey Avramov <hakavlad@inbox.lv>
Reported-by: Artem S. Tashkinov <aros@gmx.com>
---
 Repo:
 https://github.com/hakavlad/le9-patch

 Documentation/admin-guide/sysctl/vm.rst | 66 ++++++++++++++++++++++++
 include/linux/mm.h                      |  4 ++
 kernel/sysctl.c                         | 21 ++++++++
 mm/Kconfig                              | 63 +++++++++++++++++++++++
 mm/vmscan.c                             | 91 +++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 5e7952021..2f606e23b 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -25,6 +25,9 @@ files can be found in mm/swap.c.
 Currently, these files are in /proc/sys/vm:

 - admin_reserve_kbytes
+- anon_min_kbytes
+- clean_low_kbytes
+- clean_min_kbytes
 - compact_memory
 - compaction_proactiveness
 - compact_unevictable_allowed
@@ -105,6 +108,61 @@ On x86_64 this is about 128MB.
 Changing this takes effect whenever an application requests memory.


+anon_min_kbytes
+===============
+
+This knob provides *hard* protection of anonymous pages. The anonymous pages
+on the current node won't be reclaimed under any conditions when their amount
+is below vm.anon_min_kbytes.
+
+This knob may be used to prevent excessive swap thrashing when anonymous
+memory is low (for example, when memory is going to be overfilled by
+compressed data of zram module).
+
+Setting this value too high (close to MemTotal) can result in inability to
+swap and can lead to early OOM under memory pressure.
+
+The default value is defined by CONFIG_ANON_MIN_KBYTES.
+
+
+clean_low_kbytes
+================
+
+This knob provides *best-effort* protection of clean file pages. The file pages
+on the current node won't be reclaimed under memory pressure when the amount of
+clean file pages is below vm.clean_low_kbytes *unless* we threaten to OOM.
+
+Protection of clean file pages using this knob may be used when swapping is
+still possible to
+  - prevent disk I/O thrashing under memory pressure;
+  - improve performance in disk cache-bound tasks under memory pressure.
+
+Setting it to a high value may result in a early eviction of anonymous pages
+into the swap space by attempting to hold the protected amount of clean file
+pages in memory.
+
+The default value is defined by CONFIG_CLEAN_LOW_KBYTES.
+
+
+clean_min_kbytes
+================
+
+This knob provides *hard* protection of clean file pages. The file pages on the
+current node won't be reclaimed under memory pressure when the amount of clean
+file pages is below vm.clean_min_kbytes.
+
+Hard protection of clean file pages using this knob may be used to
+  - prevent disk I/O thrashing under memory pressure even with no free swap space;
+  - improve performance in disk cache-bound tasks under memory pressure;
+  - avoid high latency and prevent livelock in near-OOM conditions.
+
+Setting it to a high value may result in a early out-of-memory condition due to
+the inability to reclaim the protected amount of clean file pages when other
+types of pages cannot be reclaimed.
+
+The default value is defined by CONFIG_CLEAN_MIN_KBYTES.
+
+
 compact_memory
 ==============

@@ -864,6 +922,14 @@ be 133 (x + 2x = 200, 2x = 133.33).
 At 0, the kernel will not initiate swap until the amount of free and
 file-backed pages is less than the high watermark in a zone.

+This knob has no effect if the amount of clean file pages on the current
+node is below vm.clean_low_kbytes or vm.clean_min_kbytes. In this case,
+only anonymous pages can be reclaimed.
+
+If the number of anonymous pages on the current node is below
+vm.anon_min_kbytes, then only file pages can be reclaimed with
+any vm.swappiness value.
+

 unprivileged_userfaultfd
 ========================
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d..bee9807d5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -200,6 +200,10 @@ static inline void __mm_zero_struct_page(struct page *page)

 extern int sysctl_max_map_count;

+extern unsigned long sysctl_anon_min_kbytes;
+extern unsigned long sysctl_clean_low_kbytes;
+extern unsigned long sysctl_clean_min_kbytes;
+
 extern unsigned long sysctl_user_reserve_kbytes;
 extern unsigned long sysctl_admin_reserve_kbytes;

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 083be6af2..65fc38756 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3132,6 +3132,27 @@ static struct ctl_table vm_table[] = {
 	},
 #endif
 	{
+		.procname	= "anon_min_kbytes",
+		.data		= &sysctl_anon_min_kbytes,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "clean_low_kbytes",
+		.data		= &sysctl_clean_low_kbytes,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
+		.procname	= "clean_min_kbytes",
+		.data		= &sysctl_clean_min_kbytes,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
+	{
 		.procname	= "user_reserve_kbytes",
 		.data		= &sysctl_user_reserve_kbytes,
 		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
diff --git a/mm/Kconfig b/mm/Kconfig
index 28edafc82..dea0806d7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -89,6 +89,69 @@ config SPARSEMEM_VMEMMAP
 	  pfn_to_page and page_to_pfn operations.  This is the most
 	  efficient option when sufficient kernel resources are available.

+config ANON_MIN_KBYTES
+	int "Default value for vm.anon_min_kbytes"
+	depends on SYSCTL
+	range 0 4294967295
+	default 0
+	help
+	  This option sets the default value for vm.anon_min_kbytes sysctl knob.
+
+	  The vm.anon_min_kbytes sysctl knob provides *hard* protection of
+	  anonymous pages. The anonymous pages on the current node won't be
+	  reclaimed under any conditions when their amount is below
+	  vm.anon_min_kbytes. This knob may be used to prevent excessive swap
+	  thrashing when anonymous memory is low (for example, when memory is
+	  going to be overfilled by compressed data of zram module).
+
+	  Setting this value too high (close to MemTotal) can result in
+	  inability to swap and can lead to early OOM under memory pressure.
+
+config CLEAN_LOW_KBYTES
+	int "Default value for vm.clean_low_kbytes"
+	depends on SYSCTL
+	range 0 4294967295
+	default 0
+	help
+	  This option sets the default value for vm.clean_low_kbytes sysctl knob.
+
+	  The vm.clean_low_kbytes sysctl knob provides *best-effort*
+	  protection of clean file pages. The file pages on the current node
+	  won't be reclaimed under memory pressure when the amount of clean file
+	  pages is below vm.clean_low_kbytes *unless* we threaten to OOM.
+	  Protection of clean file pages using this knob may be used when
+	  swapping is still possible to
+	    - prevent disk I/O thrashing under memory pressure;
+	    - improve performance in disk cache-bound tasks under memory
+	      pressure.
+
+	  Setting it to a high value may result in a early eviction of anonymous
+	  pages into the swap space by attempting to hold the protected amount
+	  of clean file pages in memory.
+
+config CLEAN_MIN_KBYTES
+	int "Default value for vm.clean_min_kbytes"
+	depends on SYSCTL
+	range 0 4294967295
+	default 0
+	help
+	  This option sets the default value for vm.clean_min_kbytes sysctl knob.
+
+	  The vm.clean_min_kbytes sysctl knob provides *hard* protection of
+	  clean file pages. The file pages on the current node won't be
+	  reclaimed under memory pressure when the amount of clean file pages is
+	  below vm.clean_min_kbytes. Hard protection of clean file pages using
+	  this knob may be used to
+	    - prevent disk I/O thrashing under memory pressure even with no free
+	      swap space;
+	    - improve performance in disk cache-bound tasks under memory
+	      pressure;
+	    - avoid high latency and prevent livelock in near-OOM conditions.
+
+	  Setting it to a high value may result in a early out-of-memory condition
+	  due to the inability to reclaim the protected amount of clean file pages
+	  when other types of pages cannot be reclaimed.
+
 config HAVE_MEMBLOCK_PHYS_MAP
 	bool

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641..928f3371d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -122,6 +122,15 @@ struct scan_control {
 	/* The file pages on the current node are dangerously low */
 	unsigned int file_is_tiny:1;

+	/* The anonymous pages on the current node are below vm.anon_min_kbytes */
+	unsigned int anon_below_min:1;
+
+	/* The clean file pages on the current node are below vm.clean_low_kbytes */
+	unsigned int clean_below_low:1;
+
+	/* The clean file pages on the current node are below vm.clean_min_kbytes */
+	unsigned int clean_below_min:1;
+
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;

@@ -171,6 +180,10 @@ struct scan_control {
 #define prefetchw_prev_lru_page(_page, _base, _field) do { } while (0)
 #endif

+unsigned long sysctl_anon_min_kbytes __read_mostly = CONFIG_ANON_MIN_KBYTES;
+unsigned long sysctl_clean_low_kbytes __read_mostly = CONFIG_CLEAN_LOW_KBYTES;
+unsigned long sysctl_clean_min_kbytes __read_mostly = CONFIG_CLEAN_MIN_KBYTES;
+
 /*
  * From 0 .. 200.  Higher means more swappy.
  */
@@ -2734,6 +2747,15 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	}

 	/*
+	 * Force-scan anon if clean file pages is under vm.clean_low_kbytes
+	 * or vm.clean_min_kbytes.
+	 */
+	if (sc->clean_below_low || sc->clean_below_min) {
+		scan_balance = SCAN_ANON;
+		goto out;
+	}
+
+	/*
 	 * If there is enough inactive page cache, we do not reclaim
 	 * anything from the anonymous working right now.
 	 */
@@ -2877,6 +2899,25 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 			BUG();
 		}

+		/*
+		 * Hard protection of the working set.
+		 */
+		if (file) {
+			/*
+			 * Don't reclaim file pages when the amount of
+			 * clean file pages is below vm.clean_min_kbytes.
+			 */
+			if (sc->clean_below_min)
+				scan = 0;
+		} else {
+			/*
+			 * Don't reclaim anonymous pages when their
+			 * amount is below vm.anon_min_kbytes.
+			 */
+			if (sc->anon_below_min)
+				scan = 0;
+		}
+
 		nr[lru] = scan;
 	}
 }
@@ -3082,6 +3123,54 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }

+static void prepare_workingset_protection(pg_data_t *pgdat, struct scan_control *sc)
+{
+	/*
+	 * Check the number of anonymous pages to protect them from
+	 * reclaiming if their amount is below the specified.
+	 */
+	if (sysctl_anon_min_kbytes) {
+		unsigned long reclaimable_anon;
+
+		reclaimable_anon =
+			node_page_state(pgdat, NR_ACTIVE_ANON) +
+			node_page_state(pgdat, NR_INACTIVE_ANON) +
+			node_page_state(pgdat, NR_ISOLATED_ANON);
+		reclaimable_anon <<= (PAGE_SHIFT - 10);
+
+		sc->anon_below_min = reclaimable_anon < sysctl_anon_min_kbytes;
+	} else
+		sc->anon_below_min = 0;
+
+	/*
+	 * Check the number of clean file pages to protect them from
+	 * reclaiming if their amount is below the specified.
+	 */
+	if (sysctl_clean_low_kbytes || sysctl_clean_min_kbytes) {
+		unsigned long reclaimable_file, dirty, clean;
+
+		reclaimable_file =
+			node_page_state(pgdat, NR_ACTIVE_FILE) +
+			node_page_state(pgdat, NR_INACTIVE_FILE) +
+			node_page_state(pgdat, NR_ISOLATED_FILE);
+		dirty = node_page_state(pgdat, NR_FILE_DIRTY);
+		/*
+		 * node_page_state() sum can go out of sync since
+		 * all the values are not read at once.
+		 */
+		if (likely(reclaimable_file > dirty))
+			clean = (reclaimable_file - dirty) << (PAGE_SHIFT - 10);
+		else
+			clean = 0;
+
+		sc->clean_below_low = clean < sysctl_clean_low_kbytes;
+		sc->clean_below_min = clean < sysctl_clean_min_kbytes;
+	} else {
+		sc->clean_below_low = 0;
+		sc->clean_below_min = 0;
+	}
+}
+
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
@@ -3249,6 +3338,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			anon >> sc->priority;
 	}

+	prepare_workingset_protection(pgdat, sc);
+
 	shrink_node_memcgs(pgdat, sc);

 	if (reclaim_state) {

base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
--
2.11.0
