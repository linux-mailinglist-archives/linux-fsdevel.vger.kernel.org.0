Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7C6A55D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjB1Jca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjB1Jca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:32:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3AC206AC;
        Tue, 28 Feb 2023 01:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF7461032;
        Tue, 28 Feb 2023 09:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8407EC433D2;
        Tue, 28 Feb 2023 09:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576746;
        bh=ExAvqANCMBI4PJSTQpy4LAwvnp3ITxAWpaClUl88RVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCMhUpnpGksEEGVwFsSBWIiWR6/jhTz7gdAOMW0XGAqCW3Bj+m2xAKRd9R9cLhyyD
         5nj4PTeCALb7EP0oVbdT2lZO8R5OoWY2pU4XyhJKQrR750OurrWAt6wFFfIPh/GJqs
         E2L10wJ4+1R9tZStJIeiEGieR1XBKD672vDnq1DfOwnFKn07MZnHG7gCRyiMOphPko
         4HXjhf791ZOX7ETRh/arEojsyBYj9l+o8/hkKURTDV79DYqNbPuUVYTJyNcoVfgARB
         LI98PEm/Bzwd/vEcVwUnqcSMsuj12i6ceHqusdn0iyCKLSmyjumomrLC86d8o3nAm0
         4h3ddy6Zn981A==
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
        Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH RFC v2 bpf-next 1/9] mm: Store build id in inode object
Date:   Tue, 28 Feb 2023 10:31:58 +0100
Message-Id: <20230228093206.821563-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228093206.821563-1-jolsa@kernel.org>
References: <20230228093206.821563-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Storing build id in file's inode object for elf executable with build
id defined. The build id is stored when file is mmaped.

This is enabled with new config option CONFIG_INODE_BUILD_ID.

The build id is valid only when the file with given inode is mmap-ed.

We store either the build id itself or the error we hit during
the retrieval.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 fs/inode.c              | 12 ++++++++++++
 include/linux/buildid.h | 15 +++++++++++++++
 include/linux/fs.h      |  7 +++++++
 lib/buildid.c           | 40 ++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig              |  8 ++++++++
 mm/mmap.c               | 23 +++++++++++++++++++++++
 6 files changed, 105 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..e56593e3c301 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,7 @@
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
 #include <trace/events/writeback.h>
+#include <linux/buildid.h>
 #include "internal.h"
 
 /*
@@ -228,6 +229,10 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 #endif
 	inode->i_flctx = NULL;
 
+#ifdef CONFIG_INODE_BUILD_ID
+	inode->i_build_id = NULL;
+	spin_lock_init(&inode->i_build_id_lock);
+#endif
 	if (unlikely(security_inode_alloc(inode)))
 		return -ENOMEM;
 	this_cpu_inc(nr_inodes);
@@ -296,6 +301,11 @@ void __destroy_inode(struct inode *inode)
 	if (inode->i_default_acl && !is_uncached_acl(inode->i_default_acl))
 		posix_acl_release(inode->i_default_acl);
 #endif
+#ifdef CONFIG_INODE_BUILD_ID
+	build_id_free(inode->i_build_id);
+	inode->i_build_id = NULL;
+#endif
+
 	this_cpu_dec(nr_inodes);
 }
 EXPORT_SYMBOL(__destroy_inode);
@@ -2242,6 +2252,8 @@ void __init inode_init(void)
 					 SLAB_MEM_SPREAD|SLAB_ACCOUNT),
 					 init_once);
 
+	build_id_init();
+
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
 		return;
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3b7a0ff4642f..485640da9393 100644
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
@@ -17,4 +23,13 @@ void init_vmlinux_build_id(void);
 static inline void init_vmlinux_build_id(void) { }
 #endif
 
+#ifdef CONFIG_INODE_BUILD_ID
+void __init build_id_init(void);
+void build_id_free(struct build_id *bid);
+void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bidp);
+#else
+static inline void __init build_id_init(void) { }
+static inline void build_id_free(struct build_id *bid) { }
+#endif /* CONFIG_INODE_BUILD_ID */
+
 #endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2acc46fb5f97..72e63dcf86a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/buildid.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -699,6 +700,12 @@ struct inode {
 	struct fsverity_info	*i_verity_info;
 #endif
 
+#ifdef CONFIG_INODE_BUILD_ID
+	/* Initialized and valid for executable elf files when mmap-ed. */
+	struct build_id		*i_build_id;
+	spinlock_t		i_build_id_lock;
+#endif
+
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
diff --git a/lib/buildid.c b/lib/buildid.c
index dfc62625cae4..2c824e3dcc29 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/slab.h>
 
 #define BUILD_ID 3
 
@@ -189,3 +190,42 @@ void __init init_vmlinux_build_id(void)
 	build_id_parse_buf(&__start_notes, vmlinux_build_id, size);
 }
 #endif
+
+#ifdef CONFIG_INODE_BUILD_ID
+
+/* SLAB cache for build_id structures */
+static struct kmem_cache *build_id_cachep;
+
+void vma_read_build_id(struct vm_area_struct *vma, struct build_id **bidp)
+{
+	struct build_id *bid = ERR_PTR(-ENOMEM);
+	int err;
+
+	if (!build_id_cachep)
+		goto out;
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
+
+#endif /* CONFIG_INODE_BUILD_ID */
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..02f40d58ff74 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,14 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config INODE_BUILD_ID
+	bool "Store build id in inode object"
+	default n
+	help
+	  Store build id in iinode object for elf executable with build id
+	  defined. The build id is stored when file for the given inode is
+	  mmap-ed.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/mmap.c b/mm/mmap.c
index 425a9349e610..e6c8ec05804f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2530,6 +2530,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+	struct build_id *bid = NULL;
 
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -2626,6 +2627,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto unmap_and_free_vma;
 
+#ifdef CONFIG_INODE_BUILD_ID
+		if (vma->vm_flags & VM_EXEC)
+			vma_read_build_id(vma, &bid);
+#endif
 		/*
 		 * Expansion is handled above, merging is handled below.
 		 * Drivers should not alter the address of the VMA.
@@ -2690,6 +2695,23 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			goto free_vma;
 	}
 
+#ifdef CONFIG_INODE_BUILD_ID
+	if (bid) {
+		struct inode *inode = file_inode(file);
+
+		spin_lock(&inode->i_build_id_lock);
+		/*
+		 * If there's already valid build_id in inode, release it
+		 * and use the new one.
+		 */
+		if (inode->i_build_id)
+			build_id_free(inode->i_build_id);
+
+		inode->i_build_id = bid;
+		spin_unlock(&inode->i_build_id_lock);
+	}
+#endif
+
 	if (vma->vm_file)
 		i_mmap_lock_write(vma->vm_file->f_mapping);
 
@@ -2759,6 +2781,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
+	build_id_free(bid);
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-- 
2.39.2

