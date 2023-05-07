Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C16F96B0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEGDac (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjEGDa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:30:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5018161;
        Sat,  6 May 2023 20:30:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QDVL26yg4z4f3wRR;
        Sun,  7 May 2023 11:30:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNHG1dkjIawIw--.21328S7;
        Sun, 07 May 2023 11:30:20 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Amir Goldstein <amir73il@gmail.com>, houtao1@huawei.com
Subject: [RFC PATCH bpf-next 3/4] bpf: Introduce bpf iterator for file system mount
Date:   Sun,  7 May 2023 12:01:06 +0800
Message-Id: <20230507040107.3755166-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230507040107.3755166-1-houtao@huaweicloud.com>
References: <20230507040107.3755166-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNHG1dkjIawIw--.21328S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuw1rCFy3JF1UAr1ftw4xJFb_yoW7tr43pF
        s5ArsrCr4xX3y7Cr1vyF47uF1Fy3WS9a4UGrZ7W3yYkF4qqr1vgw1rKr1IyFyrJrW8K3sa
        qFWIk3y5CryUArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUFYFCUUUUU
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

Now the only way to query the information about a specific mount is to
parse the content of /proc/pid/mountinfo, find the specific mount and
return the needed information.

There is no way to query for a specific mount directly, so introduce bpf
iterator for fs mount to support that. By passing a fd to bpf iterator,
the bpf program will get the mount of the specific file and it can
output the necessary information for the mount in bpf iterator fd.

The following is the output from "test_progs -t bpf_iter_fs/fs_mnt"
which shows the basic information of a tmpfs mount:

  dev 0:31 id 40 parent_id 24 mnt_flags 0x1003 shared:17

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/linux/btf_ids.h        |  3 +-
 include/uapi/linux/bpf.h       |  1 +
 kernel/bpf/fs_iter.c           | 60 +++++++++++++++++++++++++++++-----
 tools/include/uapi/linux/bpf.h |  1 +
 4 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 9e036d1360e7..48537adee9fc 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -257,7 +257,8 @@ extern u32 btf_sock_ids[];
 	BTF_TRACING_TYPE(BTF_TRACING_TYPE_FILE, file)		\
 	BTF_TRACING_TYPE(BTF_TRACING_TYPE_VMA, vm_area_struct)	\
 	BTF_TRACING_TYPE(BTF_TRACING_TYPE_INODE, inode)		\
-	BTF_TRACING_TYPE(BTF_TRACING_TYPE_DENTRY, dentry)
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_DENTRY, dentry)	\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_MOUNT, mount)
 
 
 enum {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 099048ba3edc..62bed6e603a5 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -97,6 +97,7 @@ enum bpf_cgroup_iter_order {
 
 enum bpf_fs_iter_type {
 	BPF_FS_ITER_INODE = 0,	/* a specific inode */
+	BPF_FS_ITER_MNT,	/* a specific mount */
 };
 
 union bpf_iter_link_info {
diff --git a/kernel/bpf/fs_iter.c b/kernel/bpf/fs_iter.c
index cd7f10ea00ab..19f83211ccc4 100644
--- a/kernel/bpf/fs_iter.c
+++ b/kernel/bpf/fs_iter.c
@@ -9,7 +9,11 @@
 #include <linux/btf_ids.h>
 #include <linux/seq_file.h>
 
+/* TODO: move fs_iter.c to fs directory ? */
+#include "../../fs/mount.h"
+
 DEFINE_BPF_ITER_FUNC(fs_inode, struct bpf_iter_meta *meta, struct inode *inode, struct dentry *dentry);
+DEFINE_BPF_ITER_FUNC(fs_mnt, struct bpf_iter_meta *meta, struct mount *mnt);
 
 struct bpf_iter__fs_inode {
 	__bpf_md_ptr(struct bpf_iter_meta *, meta);
@@ -17,6 +21,11 @@ struct bpf_iter__fs_inode {
 	__bpf_md_ptr(struct dentry *, dentry);
 };
 
+struct bpf_iter__fs_mnt {
+	__bpf_md_ptr(struct bpf_iter_meta *, meta);
+	__bpf_md_ptr(struct mount *, mnt);
+};
+
 struct bpf_fs_iter_aux_info {
 	atomic_t count;
 	enum bpf_fs_iter_type type;
@@ -47,7 +56,7 @@ static int bpf_iter_attach_fs(struct bpf_prog *prog, union bpf_iter_link_info *l
 	struct bpf_fs_iter_aux_info *fs;
 	struct file *filp;
 
-	if (linfo->fs.type > BPF_FS_ITER_INODE)
+	if (linfo->fs.type > BPF_FS_ITER_MNT)
 		return -EINVAL;
 	/* TODO: The file-system is pinned */
 	filp = fget(linfo->fs.fd);
@@ -99,12 +108,14 @@ static void *fs_iter_seq_start(struct seq_file *m, loff_t *pos)
 	if (*pos == 0)
 		++*pos;
 
-	return file_inode(info->fs->filp);
+	if (info->fs->type == BPF_FS_ITER_INODE)
+		return file_inode(info->fs->filp);
+	return real_mount(info->fs->filp->f_path.mnt);
 }
 
 static int __fs_iter_seq_show(struct seq_file *m, void *v, bool stop)
 {
-	struct bpf_iter__fs_inode ctx;
+	struct bpf_iter_seq_fs_info *info = m->private;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int err;
@@ -114,11 +125,21 @@ static int __fs_iter_seq_show(struct seq_file *m, void *v, bool stop)
 	if (!prog)
 		return 0;
 
-	ctx.meta = &meta;
-	ctx.inode = v;
-	ctx.dentry = v ? d_find_alias(v) : NULL;
-	err = bpf_iter_run_prog(prog, &ctx);
-	dput(ctx.dentry);
+	if (info->fs->type == BPF_FS_ITER_INODE) {
+		struct bpf_iter__fs_inode ino_ctx;
+
+		ino_ctx.meta = &meta;
+		ino_ctx.inode = v;
+		ino_ctx.dentry = v ? d_find_alias(v) : NULL;
+		err = bpf_iter_run_prog(prog, &ino_ctx);
+		dput(ino_ctx.dentry);
+	} else {
+		struct bpf_iter__fs_mnt mnt_ctx;
+
+		mnt_ctx.meta = &meta;
+		mnt_ctx.mnt = v;
+		err = bpf_iter_run_prog(prog, &mnt_ctx);
+	}
 	return err;
 }
 
@@ -165,10 +186,31 @@ static struct bpf_iter_reg fs_inode_reg_info = {
 	.seq_info = &fs_iter_seq_info,
 };
 
+static struct bpf_iter_reg fs_mnt_reg_info = {
+	.target = "fs_mnt",
+	.attach_target = bpf_iter_attach_fs,
+	.detach_target = bpf_iter_detach_fs,
+	.ctx_arg_info_size = 1,
+	.ctx_arg_info = {
+		{ offsetof(struct bpf_iter__fs_mnt, mnt), PTR_TO_BTF_ID_OR_NULL },
+	},
+	.seq_info = &fs_iter_seq_info,
+};
+
 static int __init fs_iter_init(void)
 {
+	int err;
+
 	fs_inode_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_INODE];
 	fs_inode_reg_info.ctx_arg_info[1].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_DENTRY];
-	return bpf_iter_reg_target(&fs_inode_reg_info);
+	err = bpf_iter_reg_target(&fs_inode_reg_info);
+	if (err)
+		return err;
+
+	fs_mnt_reg_info.ctx_arg_info[0].btf_id = btf_tracing_ids[BTF_TRACING_TYPE_MOUNT];
+	err = bpf_iter_reg_target(&fs_mnt_reg_info);
+	if (err)
+		bpf_iter_unreg_target(&fs_inode_reg_info);
+	return err;
 }
 late_initcall(fs_iter_init);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 099048ba3edc..62bed6e603a5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -97,6 +97,7 @@ enum bpf_cgroup_iter_order {
 
 enum bpf_fs_iter_type {
 	BPF_FS_ITER_INODE = 0,	/* a specific inode */
+	BPF_FS_ITER_MNT,	/* a specific mount */
 };
 
 union bpf_iter_link_info {
-- 
2.29.2

