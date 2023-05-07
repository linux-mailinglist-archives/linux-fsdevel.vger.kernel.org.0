Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872956F96AE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEGDa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEGDa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:30:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8B41816A;
        Sat,  6 May 2023 20:30:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QDVL20hLBz4f3mWc;
        Sun,  7 May 2023 11:30:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNHG1dkjIawIw--.21328S5;
        Sun, 07 May 2023 11:30:19 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Amir Goldstein <amir73il@gmail.com>, houtao1@huawei.com
Subject: [RFC PATCH bpf-next 1/4] bpf: Introduce bpf iterator for file-system inode
Date:   Sun,  7 May 2023 12:01:04 +0800
Message-Id: <20230507040107.3755166-2-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230507040107.3755166-1-houtao@huaweicloud.com>
References: <20230507040107.3755166-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNHG1dkjIawIw--.21328S5
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1rKr47XF4rGFy5urWkXrb_yoWfKFy3pF
        s5Ar4DCr48X3y7Wr1kJa1UuFnYq3W09a4UKrZ7W3yYyrsFqr1vg3WrKr1IyFyrJrW09r92
        vFyjka4UGryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzl1vUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

The usual way to get information about a fs inode is statx(), but the
returned information is so limited and sometimes it is impossible to
get some internal information (e.g., dirty pages of one inode) through
existed syscalls.

So introduce bpf iterator for fs inode to solve the problem. By passing
one fd of the specific inode and one bpf program to the bpf file-system
inode iterator, a bpf iterator fd will be created and reading the
iterator fd will output the content customized by the provided bpf
program. Now only the bpf iterator for specific inode is supported, the
support for all inodes in a file-system could be added later if needed.

Without any inode related bpf helper, only the content of inode itself
and the typed-pointer in inode (e.g., i_sb) can be printed in a bpf
program as shown below:

  (struct inode){
   .i_mode = (umode_t)33188,
   .i_opflags = (short unsigned int)13,
   .i_flags = (unsigned int)4096,
   .i_op = (struct inode_operations *)0x000000004dd45285,
   .i_sb = (struct super_block *)0x0000000006c11996,
   .i_mapping = (struct address_space *)0x00000000333cf64b,
   .i_ino = (long unsigned int)30982996,
   (union){
    .i_nlink = ()1,
    .__i_nlink = (unsigned int)1,
   },
   .i_size = (loff_t)4095,
   ......
  (struct super_block){
   .s_list = (struct list_head){
    .next = (struct list_head *)0x000000008af29511,
    .prev = (struct list_head *)0x000000003d8c9095,
   },
   .s_dev = (dev_t)265289730,
   .s_blocksize_bits = (unsigned char)12,
   .s_blocksize = (long unsigned int)4096,
   .s_maxbytes = (loff_t)9223372036854775807,
   ......

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/bpf.h            |   2 +
 include/linux/btf_ids.h        |   5 +-
 include/uapi/linux/bpf.h       |   8 ++
 kernel/bpf/Makefile            |   1 +
 kernel/bpf/fs_iter.c           | 174 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |   8 ++
 6 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/fs_iter.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 456f33b9d205..3b2324269647 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2120,6 +2120,8 @@ struct bpf_iter_aux_info {
 		enum bpf_iter_task_type	type;
 		u32 pid;
 	} task;
+	/* for fs iter */
+	void *fs;
 };
 
 typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 00950cc03bff..9e036d1360e7 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -255,7 +255,10 @@ extern u32 btf_sock_ids[];
 #define BTF_TRACING_TYPE_xxx	\
 	BTF_TRACING_TYPE(BTF_TRACING_TYPE_TASK, task_struct)	\
 	BTF_TRACING_TYPE(BTF_TRACING_TYPE_FILE, file)		\
-	BTF_TRACING_TYPE(BTF_TRACING_TYPE_VMA, vm_area_struct)
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_VMA, vm_area_struct)	\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_INODE, inode)		\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_DENTRY, dentry)
+
 
 enum {
 #define BTF_TRACING_TYPE(name, type) name,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 1bb11a6ee667..099048ba3edc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -95,6 +95,10 @@ enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
 };
 
+enum bpf_fs_iter_type {
+	BPF_FS_ITER_INODE = 0,	/* a specific inode */
+};
+
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
@@ -116,6 +120,10 @@ union bpf_iter_link_info {
 		__u32	pid;
 		__u32	pid_fd;
 	} task;
+	struct {
+		enum bpf_fs_iter_type type;
+		__u32 fd;
+	} fs;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 1d3892168d32..e945d6e23eed 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -8,6 +8,7 @@ CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
 
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
+obj-$(CONFIG_BPF_SYSCALL) += fs_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
 obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
diff --git a/kernel/bpf/fs_iter.c b/kernel/bpf/fs_iter.c
new file mode 100644
index 000000000000..cd7f10ea00ab
--- /dev/null
+++ b/kernel/bpf/fs_iter.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023. Huawei Technologies Co., Ltd
+ */
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/seq_file.h>
+
+DEFINE_BPF_ITER_FUNC(fs_inode, struct bpf_iter_meta *meta, struct inode *inode, struct dentry *dentry);
+
+struct bpf_iter__fs_inode {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct inode *, inode);
+	__bpf_md_ptr(struct dentry *, dentry);
+};
+
+struct bpf_fs_iter_aux_info {
+	atomic_t count;
+	enum bpf_fs_iter_type type;
+	struct file *filp;
+};
+
+struct bpf_iter_seq_fs_info {
+	struct bpf_fs_iter_aux_info *fs;
+};
+
+static inline void bpf_fs_iter_get(struct bpf_fs_iter_aux_info *fs)
+{
+	atomic_inc(&fs->count);
+}
+
+static void bpf_fs_iter_put(struct bpf_fs_iter_aux_info *fs)
+{
+	if (!atomic_dec_and_test(&fs->count))
+		return;
+
+	fput(fs->filp);
+	kfree(fs);
+}
+
+static int bpf_iter_attach_fs(struct bpf_prog *prog, union bpf_iter_link_info *linfo,
+			      struct bpf_iter_aux_info *aux)
+{
+	struct bpf_fs_iter_aux_info *fs;
+	struct file *filp;
+
+	if (linfo->fs.type > BPF_FS_ITER_INODE)
+		return -EINVAL;
+	/* TODO: The file-system is pinned */
+	filp = fget(linfo->fs.fd);
+	if (!filp)
+		return -EINVAL;
+
+	fs = kmalloc(sizeof(*fs), GFP_KERNEL);
+	if (!fs) {
+		fput(filp);
+		return -ENOMEM;
+	}
+
+	atomic_set(&fs->count, 1);
+	fs->type = linfo->fs.type;
+	fs->filp = filp;
+	aux->fs = fs;
+
+	return 0;
+}
+
+static void bpf_iter_detach_fs(struct bpf_iter_aux_info *aux)
+{
+	bpf_fs_iter_put(aux->fs);
+}
+
+static int bpf_iter_init_seq_fs_priv(void *priv, struct bpf_iter_aux_info *aux)
+{
+	struct bpf_iter_seq_fs_info *info = priv;
+	struct bpf_fs_iter_aux_info *fs = aux->fs;
+
+	/* link fd is still alive, so it is OK to inc ref-count directly */
+	bpf_fs_iter_get(fs);
+	info->fs = fs;
+
+	return 0;
+}
+
+static void bpf_iter_fini_seq_fs_priv(void *priv)
+{
+	struct bpf_iter_seq_fs_info *info = priv;
+
+	bpf_fs_iter_put(info->fs);
+}
+
+static void *fs_iter_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct bpf_iter_seq_fs_info *info = m->private;
+
+	if (*pos == 0)
+		++*pos;
+
+	return file_inode(info->fs->filp);
+}
+
+static int __fs_iter_seq_show(struct seq_file *m, void *v, bool stop)
+{
+	struct bpf_iter__fs_inode ctx;
+	struct bpf_iter_meta meta;
+	struct bpf_prog *prog;
+	int err;
+
+	meta.seq = m;
+	prog = bpf_iter_get_info(&meta, stop);
+	if (!prog)
+		return 0;
+
+	ctx.meta = &meta;
+	ctx.inode = v;
+	ctx.dentry = v ? d_find_alias(v) : NULL;
+	err = bpf_iter_run_prog(prog, &ctx);
+	dput(ctx.dentry);
+	return err;
+}
+
+static void fs_iter_seq_stop(struct seq_file *m, void *v)
+{
+	if (!v)
+		__fs_iter_seq_show(m, NULL, true);
+}
+
+static void *fs_iter_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return NULL;
+}
+
+static int fs_iter_seq_show(struct seq_file *m, void *v)
+{
+	return __fs_iter_seq_show(m, v, false);
+}
+
+static const struct seq_operations fs_iter_seq_ops = {
+	.start = fs_iter_seq_start,
+	.stop = fs_iter_seq_stop,
+	.next = fs_iter_seq_next,
+	.show = fs_iter_seq_show,
+};
+
+static const struct bpf_iter_seq_info fs_iter_seq_info = {
+	.seq_ops = &fs_iter_seq_ops,
+	.init_seq_private = bpf_iter_init_seq_fs_priv,
+	.fini_seq_private = bpf_iter_fini_seq_fs_priv,
+	.seq_priv_size = sizeof(struct bpf_iter_seq_fs_info),
+};
+
+static struct bpf_iter_reg fs_inode_reg_info = {
+	.target = "fs_inode",
+	.attach_target = bpf_iter_attach_fs,
+	.detach_target = bpf_iter_detach_fs,
+	.ctx_arg_info_size = 2,
+	.ctx_arg_info = {
+		{ offsetof(struct bpf_iter__fs_inode, inode), PTR_TO_BTF_ID_OR_NULL },
+		{ offsetof(struct bpf_iter__fs_inode, dentry), PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info = &fs_iter_seq_info,
+};
+
+static int __init fs_iter_init(void)
+{
+	fs_inode_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_INODE];
+	fs_inode_reg_info.ctx_arg_info[1].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_DENTRY];
+	return bpf_iter_reg_target(&fs_inode_reg_info);
+}
+late_initcall(fs_iter_init);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 1bb11a6ee667..099048ba3edc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -95,6 +95,10 @@ enum bpf_cgroup_iter_order {
 	BPF_CGROUP_ITER_ANCESTORS_UP,		/* walk ancestors upward. */
 };
 
+enum bpf_fs_iter_type {
+	BPF_FS_ITER_INODE = 0,	/* a specific inode */
+};
+
 union bpf_iter_link_info {
 	struct {
 		__u32	map_fd;
@@ -116,6 +120,10 @@ union bpf_iter_link_info {
 		__u32	pid;
 		__u32	pid_fd;
 	} task;
+	struct {
+		enum bpf_fs_iter_type type;
+		__u32 fd;
+	} fs;
 };
 
 /* BPF syscall commands, see bpf(2) man-page for more details. */
-- 
2.29.2

