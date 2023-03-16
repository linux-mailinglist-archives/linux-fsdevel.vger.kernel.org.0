Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B5D6BD697
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCPRCT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCPRCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:02:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCF9E6DB2;
        Thu, 16 Mar 2023 10:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAFCFB820AD;
        Thu, 16 Mar 2023 17:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DD7C433EF;
        Thu, 16 Mar 2023 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986129;
        bh=rlnHUcArwM6SIvbHJnlNQfqpKxk+RvN2l+D5fdKLMa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mko2AyIGWCfuAb/notSpksldx+wnHyuJJ4/SEak6IfxwljXnE+r8/+kMT7THTFZQ5
         Wncxf77aMXc3FbAfZfDb08GQs5sdSXxJP/oxSMw5mFt26kNKx9/5wT/iIghXvWGrPt
         p/shHWVxwdSZ8CaChz7D04gE4GZtpXAlZNM9LhqY6aE2MbZAGy6rv+Yt6siwcFcTvz
         fMFLw05Y8JJ7ka5JyaIx/wptVp0ilYP5XRMB4WqQlNarQsTWdfLNtGysPEqe5mNwBC
         eGb6hOm37AxCLhqGwPJ7Uf6WZevagTDZ0Lmk5+qQ9EwJwNKT5AqiCYBFavWZH5OdJw
         czU9fH4Y2iLaw==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 1/9] mm: Store build id in file object
Date:   Thu, 16 Mar 2023 18:01:41 +0100
Message-Id: <20230316170149.4106586-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316170149.4106586-1-jolsa@kernel.org>
References: <20230316170149.4106586-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Storing build id in file object for elf executable with build
id defined. The build id is stored when file is mmaped.

The build id object assignment to the file is locked with existing
file->f_mapping semaphore.

The f_build_id pointer points either build id object or carries
the error the build id retrieval failed on.

It's hidden behind new config option CONFIG_FILE_BUILD_ID.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/file_table.c         |  3 +++
 include/linux/buildid.h | 17 +++++++++++++++++
 include/linux/fs.h      |  7 +++++++
 lib/buildid.c           | 42 +++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig              |  9 +++++++++
 mm/mmap.c               | 18 ++++++++++++++++++
 6 files changed, 96 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 372653b92617..d72f72503268 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -29,6 +29,7 @@
 #include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/buildid.h>
 
 #include <linux/atomic.h>
 
@@ -48,6 +49,7 @@ static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);
 
+	file_build_id_free(f);
 	put_cred(f->f_cred);
 	kmem_cache_free(filp_cachep, f);
 }
@@ -413,6 +415,7 @@ void __init files_init(void)
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
+	build_id_init();
 }
 
 /*
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3b7a0ff4642f..b8b2e00420d6 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -3,9 +3,15 @@
 #define _LINUX_BUILDID_H
 
 #include <linux/mm_types.h>
+#include <linux/slab.h>
 
 #define BUILD_ID_SIZE_MAX 20
 
+struct build_id {
+	u32 sz;
+	char data[BUILD_ID_SIZE_MAX];
+};
+
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 		   __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
@@ -17,4 +23,15 @@ void init_vmlinux_build_id(void);
 static inline void init_vmlinux_build_id(void) { }
 #endif
 
+#ifdef CONFIG_FILE_BUILD_ID
+void __init build_id_init(void);
+void build_id_free(struct build_id *bid);
+void file_build_id_free(struct file *f);
+void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bidp);
+#else
+static inline void __init build_id_init(void) { }
+static inline void build_id_free(struct build_id *bid) { }
+static inline void file_build_id_free(struct file *f) { }
+#endif /* CONFIG_FILE_BUILD_ID */
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..ce03fd965cdb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -977,6 +977,13 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+#ifdef CONFIG_FILE_BUILD_ID
+	/*
+	 * Initialized when the file is mmaped (mmap_region),
+	 * guarded by f_mapping lock.
+	 */
+	struct build_id		*f_build_id;
+#endif
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/lib/buildid.c b/lib/buildid.c
index dfc62625cae4..04181c0b7c21 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 
 #define BUILD_ID 3
 
@@ -189,3 +190,44 @@ void __init init_vmlinux_build_id(void)
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
 }
 #endif
+
+#ifdef CONFIG_FILE_BUILD_ID
+
+/* SLAB cache for build_id structures */
+static struct kmem_cache *build_id_cachep;
+
+void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bidp)
+{
+	struct build_id *bid = ERR_PTR(-ENOMEM);
+	int err;
+
+	bid = kmem_cache_alloc(build_id_cachep, GFP_KERNEL);
+	if (!bid)
+		goto out;
+	err = build_id_parse(vma, bid->data, &bid->sz);
+	if (err) {
+		build_id_free(bid);
+		bid = ERR_PTR(err);
+	}
+out:
+	*bidp = bid;
+}
+
+void file_build_id_free(struct file *f)
+{
+	build_id_free(f->f_build_id);
+}
+
+void build_id_free(struct build_id *bid)
+{
+	if (IS_ERR_OR_NULL(bid))
+		return;
+	kmem_cache_free(build_id_cachep, bid);
+}
+
+void __init build_id_init(void)
+{
+	build_id_cachep = kmem_cache_create("build_id", sizeof(struct build_id), 0,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
+}
+#endif /* CONFIG_FILE_BUILD_ID */
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..5e9f48962703 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,15 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config FILE_BUILD_ID
+	bool "Store build id in file object"
+	default n
+	help
+	  Store build id in file object for elf executable with build id
+	  defined. The build id is stored when file is mmaped.
+
+	  It's typically used by eBPF programs and perf subsystem.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/mmap.c b/mm/mmap.c
index 20f21f0949dd..1c14e8c84d3a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2480,6 +2480,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
+	struct build_id *bid = NULL;
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2575,6 +2576,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+#ifdef CONFIG_FILE_BUILD_ID
+		if (vma->vm_flags & VM_EXEC && !file->f_build_id)
+			vma_read_build_id(vma, &bid);
+#endif
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
@@ -2647,6 +2652,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
+#ifdef CONFIG_FILE_BUILD_ID
+		if (bid && !file->f_build_id) {
+			file->f_build_id = bid;
+			bid = NULL;
+		}
+#endif
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
 		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
 		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
@@ -2667,6 +2678,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/*
+	 * File can already have f_build_id assigned, so we need to release
+	 * the build id we just read and did not assign.
+	 */
+	build_id_free(bid);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -2711,6 +2728,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
+	build_id_free(bid);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-- 
2.39.2

