Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38761A714
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Nov 2022 03:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKECxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 22:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKECxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 22:53:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2E32B6
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 19:53:48 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so4655675qvs.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JI7cKRM4RTeKDI0t+IERL0YBj1fl9UNNUZ2PEs6yEiQ=;
        b=ALcOaOI5wQpNzPdzX6C0J9yppvP0ccW968P93F3xPK/ILN9f/tNC/6Aa3TIUD4K0jb
         xKV1I/oxjRwjvyKCqQFFjdXqHJSjjx3pT0g6zaDXSB6wJZzhqXBx3S/1jc8dixzJ079T
         FmY5qGOcBzieXybXTxvsdbxXokCqfXdoL4dG38cUSErnMt8LB+3X8Q+u70GgyPQ1w6nD
         3k4htwqXL+atV1bum/28BbgEEOBS9aRmWIB1AIkVUTROjq2VtKxw6NF372krxH5i8MvX
         ABPyU61i90apijPchAj8F9HzmfBSkwJmJ/uFv8kHdjtAGj/uI3AsJCrC8lclmluKB4Sk
         yZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JI7cKRM4RTeKDI0t+IERL0YBj1fl9UNNUZ2PEs6yEiQ=;
        b=RO530nbfbDj83J/zBbG5+KkqULtzfK9D1Tk/q9IvV1jba20484fHyYyfDRvx542JZl
         nbkqpIYhg37P+bM49YftSRU/pF8kFvYzkBE0IiyJuIlbaS+b+ea2Lt8ukn8IxTouGgIq
         q9HyI53RlZr/LREWW1jngm/mcDB7fm+anDfVbGX1/7JI3UQtulHBjUVT4wi2DMMZ/UjS
         4iz4b8Hfz+en1HTVRYh1QdrTcI10mnl/SaIgny/3xRNDhychJ133RcuLoAHD29VrADWo
         p8PP/RbOlPbNT8nqgOeK/oAMWTYjlt3cuPzbPbRqzsWL276YQfXp9V0CvytN4U84C/Tb
         xhHQ==
X-Gm-Message-State: ACrzQf1WbFk1ve+iKpckUyz5w727osCWjAmRdAk8H2x2ffX0CxC0OD7Y
        zEy2jxJ9xdwXdskWLONV3QZPlQ==
X-Google-Smtp-Source: AMsMyM6sgg5HHp6alxMy0i4ndmBRmwHO85L4PUB1mVFu83X+//FOx5lNTiXxK/gwh4tSxcIKdH7WTQ==
X-Received: by 2002:ad4:5c4e:0:b0:4bb:9fea:f52e with SMTP id a14-20020ad45c4e000000b004bb9feaf52emr35407214qva.51.1667616827460;
        Fri, 04 Nov 2022 19:53:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id g10-20020a05620a40ca00b006fa12a74c53sm773373qko.61.2022.11.04.19.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 19:53:46 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, hughd@google.com,
        hannes@cmpxchg.org, david@redhat.com, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: anonymous shared memory naming
Date:   Sat,  5 Nov 2022 02:53:42 +0000
Message-Id: <20221105025342.3130038-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since:
commit 9a10064f5625 ("mm: add a field to store names for private anonymous
memory")

We can set names for private anonymous memory but not for shared
anonymous memory. However, naming shared anonymous memory just as
useful for tracking purposes.

Extend the functionality to be able to set names for shared anon.

/ [anon_shmem:<name>]      an anonymous shared memory mapping that has
                           been named by userspace

Sample output:
        share = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
                     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
        rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
                   share, SIZE, "shared anon");

/proc/<pid>/maps (and smaps):
7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024
/dev/zero (deleted) [anon_shmem:shared anon]

pmap $(pgrep a.out)
254:   pub/a.out
000056093fab2000      4K r---- a.out
000056093fab3000      4K r-x-- a.out
000056093fab4000      4K r---- a.out
000056093fab5000      4K r---- a.out
000056093fab6000      4K rw--- a.out
000056093fdeb000    132K rw---   [ anon ]
00007fc8e2b4c000 262144K rw-s- zero (deleted) [anon_shmem:shared anon]

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/filesystems/proc.rst |  4 +++-
 fs/proc/task_mmu.c                 |  7 ++++---
 include/linux/mm.h                 |  2 ++
 include/linux/mm_types.h           | 27 +++++++++++++--------------
 mm/madvise.c                       |  7 ++-----
 mm/shmem.c                         | 13 +++++++++++--
 6 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 898c99eae8e4..8f1e68460da5 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -431,8 +431,10 @@ is not associated with a file:
  [stack]                    the stack of the main process
  [vdso]                     the "virtual dynamic shared object",
                             the kernel system call handler
- [anon:<name>]              an anonymous mapping that has been
+ [anon:<name>]              a private anonymous mapping that has been
                             named by userspace
+ path [anon_shmem:<name>]   an anonymous shared memory mapping that has
+                            been named by userspace
  =============              ====================================
 
  or if empty, the mapping is anonymous.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..d6ae75ed81ca 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -277,6 +277,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
 	vm_flags_t flags = vma->vm_flags;
+	struct anon_vma_name *anon_name;
 	unsigned long ino = 0;
 	unsigned long long pgoff = 0;
 	unsigned long start, end;
@@ -293,6 +294,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
+	anon_name = anon_vma_name(vma);
 
 	/*
 	 * Print the dentry name for named mappings, and a
@@ -301,6 +303,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	if (file) {
 		seq_pad(m, ' ');
 		seq_file_path(m, file, "\n");
+		if (anon_name)
+			seq_printf(m, " [anon_shmem:%s]", anon_name->name);
 		goto done;
 	}
 
@@ -312,8 +316,6 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 
 	name = arch_vma_name(vma);
 	if (!name) {
-		struct anon_vma_name *anon_name;
-
 		if (!mm) {
 			name = "[vdso]";
 			goto done;
@@ -330,7 +332,6 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 			goto done;
 		}
 
-		anon_name = anon_vma_name(vma);
 		if (anon_name) {
 			seq_pad(m, ' ');
 			seq_printf(m, "[anon:%s]", anon_name->name);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..06b6fb3277ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -699,8 +699,10 @@ static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
  * paths in userfault.
  */
 bool vma_is_shmem(struct vm_area_struct *vma);
+bool vma_is_anon_shmem(struct vm_area_struct *vma);
 #else
 static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
 #endif
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..08d8b973fb60 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -461,21 +461,11 @@ struct vm_area_struct {
 	 * For areas with an address space and backing store,
 	 * linkage into the address_space->i_mmap interval tree.
 	 *
-	 * For private anonymous mappings, a pointer to a null terminated string
-	 * containing the name given to the vma, or NULL if unnamed.
 	 */
-
-	union {
-		struct {
-			struct rb_node rb;
-			unsigned long rb_subtree_last;
-		} shared;
-		/*
-		 * Serialized by mmap_sem. Never use directly because it is
-		 * valid only when vm_file is NULL. Use anon_vma_name instead.
-		 */
-		struct anon_vma_name *anon_name;
-	};
+	struct {
+		struct rb_node rb;
+		unsigned long rb_subtree_last;
+	} shared;
 
 	/*
 	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
@@ -485,6 +475,7 @@ struct vm_area_struct {
 	 */
 	struct list_head anon_vma_chain; /* Serialized by mmap_lock &
 					  * page_table_lock */
+
 	struct anon_vma *anon_vma;	/* Serialized by page_table_lock */
 
 	/* Function pointers to deal with this struct. */
@@ -496,6 +487,14 @@ struct vm_area_struct {
 	struct file * vm_file;		/* File we map to (can be NULL). */
 	void * vm_private_data;		/* was vm_pte (shared mem) */
 
+#ifdef CONFIG_ANON_VMA_NAME
+	/*
+	 * For private and shared anonymous mappings, a pointer to a null
+	 * terminated string containing the name given to the vma, or NULL if
+	 * unnamed. Serialized by mmap_sem. Use anon_vma_name to access.
+	 */
+	struct anon_vma_name *anon_name;
+#endif
 #ifdef CONFIG_SWAP
 	atomic_long_t swap_readahead_info;
 #endif
diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec6d08c..255d5b485432 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -95,9 +95,6 @@ struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
 
-	if (vma->vm_file)
-		return NULL;
-
 	return vma->anon_name;
 }
 
@@ -183,7 +180,7 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	 * vm_flags is protected by the mmap_lock held in write mode.
 	 */
 	vma->vm_flags = new_flags;
-	if (!vma->vm_file) {
+	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
 		error = replace_anon_vma_name(vma, anon_name);
 		if (error)
 			return error;
@@ -1273,7 +1270,7 @@ static int madvise_vma_anon_name(struct vm_area_struct *vma,
 	int error;
 
 	/* Only anonymous mappings can be named */
-	if (vma->vm_file)
+	if (vma->vm_file && !vma_is_anon_shmem(vma))
 		return -EBADF;
 
 	error = madvise_update_vma(vma, prev, start, end, vma->vm_flags,
diff --git a/mm/shmem.c b/mm/shmem.c
index c1d8b8a1aa3b..638bcb3d26bd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -237,11 +237,17 @@ static const struct inode_operations shmem_inode_operations;
 static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
+static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
+bool vma_is_anon_shmem(struct vm_area_struct *vma)
+{
+	return vma->vm_ops == &shmem_anon_vm_ops;
+}
+
 bool vma_is_shmem(struct vm_area_struct *vma)
 {
-	return vma->vm_ops == &shmem_vm_ops;
+	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
 
 static LIST_HEAD(shmem_swaplist);
@@ -3995,6 +4001,8 @@ static const struct vm_operations_struct shmem_vm_ops = {
 #endif
 };
 
+static const struct vm_operations_struct shmem_anon_vm_ops = shmem_vm_ops;
+
 int shmem_init_fs_context(struct fs_context *fc)
 {
 	struct shmem_options *ctx;
@@ -4170,6 +4178,7 @@ void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
 #define shmem_vm_ops				generic_file_vm_ops
+#define shmem_anon_vm_ops			generic_file_vm_ops
 #define shmem_file_operations			ramfs_file_operations
 #define shmem_get_inode(sb, dir, mode, dev, flags)	ramfs_get_inode(sb, dir, mode, dev)
 #define shmem_acct_size(flags, size)		0
@@ -4275,7 +4284,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	vma->vm_file = file;
-	vma->vm_ops = &shmem_vm_ops;
+	vma->vm_ops = &shmem_anon_vm_ops;
 
 	return 0;
 }
-- 
2.38.1.431.g37b22c650d-goog

