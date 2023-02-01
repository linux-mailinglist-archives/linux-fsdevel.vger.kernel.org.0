Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B96867BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBAN6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBAN60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:58:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108DA14EA7;
        Wed,  1 Feb 2023 05:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 112FEB821A2;
        Wed,  1 Feb 2023 13:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF92C4339C;
        Wed,  1 Feb 2023 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259876;
        bh=K5e4iDve4s0PwNPOjBVEL1fPWhsoZO4QpGzfxgnTdGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pL/BhnAeEPoVMghB6g8EuD67OegImMGmZlqdKM37DGTUdUe3+VC6epzOBADZgEGou
         t0NAX257+ANME19ZsslzL9A8wNMPEDs3fAPa1Etr6CdfZKe2of4jmigsOeNag9OHZo
         pZ916wTMZP46oFcVUsxAZVdrH00C2BU+sF8HipWo7etAqLa5f8jeFJK7vGYBfrdoA+
         rwlc4aruSxQ6DfucwkOmS1zp8baxmsewY5QumlCNZBU+tJfDgktTuK8gT8DF3Z8EgY
         u2+QPZ59Tl3KaGkV02uAwkZL5k9i7OFPzUMZT/krlSOlGWkSZnn8iHvVVND97jhJZK
         wSkoFCw+vN8yQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RFC 1/5] mm: Store build id in file object
Date:   Wed,  1 Feb 2023 14:57:33 +0100
Message-Id: <20230201135737.800527-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201135737.800527-1-jolsa@kernel.org>
References: <20230201135737.800527-1-jolsa@kernel.org>
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

It's hidden behind new config option CONFIG_FILE_BUILD_ID.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/file_table.c         |  3 +++
 include/linux/buildid.h | 17 ++++++++++++++++
 include/linux/fs.h      |  3 +++
 lib/buildid.c           | 44 +++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig              |  7 +++++++
 mm/mmap.c               | 15 ++++++++++++++
 6 files changed, 89 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index dd88701e54a9..d1c814cdb623 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -28,6 +28,7 @@
 #include <linux/ima.h>
 #include <linux/swap.h>
 #include <linux/kmemleak.h>
+#include <linux/buildid.h>
 
 #include <linux/atomic.h>
 
@@ -47,6 +48,7 @@ static void file_free_rcu(struct rcu_head *head)
 {
 	struct file *f = container_of(head, struct file, f_rcuhead);
 
+	file_build_id_free(f);
 	put_cred(f->f_cred);
 	kmem_cache_free(filp_cachep, f);
 }
@@ -412,6 +414,7 @@ void __init files_init(void)
 	filp_cachep = kmem_cache_create("filp", sizeof(struct file), 0,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
+	build_id_init();
 }
 
 /*
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3b7a0ff4642f..7c818085ad2c 100644
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
+int vma_get_build_id(struct vm_area_struct *vma, struct build_id **bidp);
+void file_build_id_free(struct file *f);
+#else
+static inline void __init build_id_init(void) { }
+static inline void build_id_free(struct build_id *bid) { }
+static inline void file_build_id_free(struct file *f) { }
+#endif /* CONFIG_FILE_BUILD_ID */
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..9ad5e5fbf680 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -975,6 +975,9 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+#ifdef CONFIG_FILE_BUILD_ID
+	struct build_id		*f_bid;
+#endif
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/lib/buildid.c b/lib/buildid.c
index dfc62625cae4..7f6c3ca7b257 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 
 #define BUILD_ID 3
 
@@ -189,3 +190,46 @@ void __init init_vmlinux_build_id(void)
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
 }
 #endif
+
+#ifdef CONFIG_FILE_BUILD_ID
+
+/* SLAB cache for build_id structures */
+static struct kmem_cache *build_id_cachep;
+
+int vma_get_build_id(struct vm_area_struct *vma, struct build_id **bidp)
+{
+	struct build_id *bid;
+	int err;
+
+	bid = kmem_cache_alloc(build_id_cachep, GFP_KERNEL);
+	if (!bid)
+		return -ENOMEM;
+	err = build_id_parse(vma, bid->data, &bid->sz);
+	if (err) {
+		build_id_free(bid);
+		/* ignore parsing error */
+		return 0;
+	}
+	*bidp = bid;
+	return 0;
+}
+
+void file_build_id_free(struct file *f)
+{
+	build_id_free(f->f_bid);
+}
+
+void build_id_free(struct build_id *bid)
+{
+	if (!bid)
+		return;
+	kmem_cache_free(build_id_cachep, bid);
+}
+
+void __init build_id_init(void)
+{
+	build_id_cachep = kmem_cache_create("build_id", sizeof(struct build_id), 0,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT, NULL);
+}
+
+#endif /* CONFIG_FILE_BUILD_ID */
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..68911c3780c4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,13 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config FILE_BUILD_ID
+	bool "Store build id in file object"
+	default n
+	help
+	  Store build id in file object for elf executable with build id
+	  defined. The build id is stored when file is mmaped.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/mmap.c b/mm/mmap.c
index 425a9349e610..a06f744206e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2530,6 +2530,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	struct build_id *bid = NULL;
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2626,6 +2627,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+#ifdef CONFIG_FILE_BUILD_ID
+		if (vma->vm_flags & VM_EXEC && !file->f_bid) {
+			error = vma_get_build_id(vma, &bid);
+			if (error)
+				goto close_and_free_vma;
+		}
+#endif
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
@@ -2699,6 +2707,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (vma->vm_flags & VM_SHARED)
 			mapping_allow_writable(vma->vm_file->f_mapping);
 
+#ifdef CONFIG_FILE_BUILD_ID
+		if (bid && !file->f_bid)
+			file->f_bid = bid;
+		else
+			build_id_free(bid);
+#endif
 		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
 		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
 		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
@@ -2759,6 +2773,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
+	build_id_free(bid);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-- 
2.39.1

