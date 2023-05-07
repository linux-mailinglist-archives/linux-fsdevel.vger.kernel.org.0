Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C446F96AF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjEGDae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjEGDa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:30:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4231816B;
        Sat,  6 May 2023 20:30:24 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QDVL32bfkz4f3wRT;
        Sun,  7 May 2023 11:30:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNHG1dkjIawIw--.21328S8;
        Sun, 07 May 2023 11:30:20 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Amir Goldstein <amir73il@gmail.com>, houtao1@huawei.com
Subject: [RFC PATCH bpf-next 4/4] selftests/bpf: Add test cases for bpf file-system iterator
Date:   Sun,  7 May 2023 12:01:07 +0800
Message-Id: <20230507040107.3755166-5-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230507040107.3755166-1-houtao@huaweicloud.com>
References: <20230507040107.3755166-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNHG1dkjIawIw--.21328S8
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1rWF15Gr43Xw4xKw15Jwb_yoWDJr15pa
        yrX345Cr4fX3y7Wr4ktF43uryYva1UWa4xGrZ7WF1rAr4kZr929F1xKry2vFnxJrZ09a1I
        v3yaka48Jr18XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
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

Add three test cases to demonstrate the basic functionalities of bpf
file-system iterator:
1) dump_raw_inode. Use bpf_seq_printf_btf to dump the content of the
   passed inode and its super_block
2) dump_inode. Use bpf_filemap_{cachestat,find_present,get_order} to
   dump the details of the inode page cache.
3) dump_mnt. Dump the basic information of the passed mount.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 .../selftests/bpf/prog_tests/bpf_iter_fs.c    | 184 ++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_iter_fs.c | 122 ++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_iter_fs.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_fs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter_fs.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter_fs.c
new file mode 100644
index 000000000000..e26d736001b4
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter_fs.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include <test_progs.h>
+#include "bpf_iter_fs.skel.h"
+
+static void test_bpf_iter_raw_inode(void)
+{
+	const char *fpath = "/tmp/raw_inode.test";
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int ino_fd, iter_fd, err;
+	struct bpf_iter_fs *skel;
+	struct bpf_link *link;
+	char buf[8192];
+	ssize_t nr;
+
+	ino_fd = open(fpath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (!ASSERT_GE(ino_fd, 0, "open file"))
+		return;
+	ftruncate(ino_fd, 4095);
+
+	skel = bpf_iter_fs__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto close_ino;
+
+	bpf_program__set_autoload(skel->progs.dump_raw_inode, true);
+
+	err = bpf_iter_fs__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto free_skel;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.fs.type = BPF_FS_ITER_INODE;
+	linfo.fs.fd = ino_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.dump_raw_inode, &opts);
+	if (!ASSERT_OK_PTR(link, "attach iter"))
+		goto free_skel;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create iter"))
+		goto free_link;
+
+	nr = read(iter_fd, buf, sizeof(buf));
+	if (!ASSERT_GT(nr, 0, "read iter"))
+		goto close_iter;
+
+	buf[nr - 1] = 0;
+	puts(buf);
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+free_skel:
+	bpf_iter_fs__destroy(skel);
+close_ino:
+	close(ino_fd);
+}
+
+static void test_bpf_iter_inode(void)
+{
+	const char *fpath = "/tmp/inode.test";
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int ino_fd, iter_fd, err;
+	struct bpf_iter_fs *skel;
+	struct bpf_link *link;
+	char buf[8192];
+	ssize_t nr;
+
+	/* Close fd after reading iterator completes */
+	ino_fd = open(fpath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (!ASSERT_GE(ino_fd, 0, "open file"))
+		return;
+	pwrite(ino_fd, buf, sizeof(buf), 0);
+	pwrite(ino_fd, buf, sizeof(buf), sizeof(buf) * 2);
+
+	skel = bpf_iter_fs__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto close_ino;
+
+	bpf_program__set_autoload(skel->progs.dump_inode, true);
+
+	err = bpf_iter_fs__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto free_skel;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.fs.type = BPF_FS_ITER_INODE;
+	linfo.fs.fd = ino_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.dump_inode, &opts);
+	if (!ASSERT_OK_PTR(link, "attach iter"))
+		goto free_skel;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create iter"))
+		goto free_link;
+
+	nr = read(iter_fd, buf, sizeof(buf));
+	if (!ASSERT_GT(nr, 0, "read iter"))
+		goto close_iter;
+
+	buf[nr - 1] = 0;
+	puts(buf);
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+free_skel:
+	bpf_iter_fs__destroy(skel);
+close_ino:
+	close(ino_fd);
+}
+
+static void test_bpf_iter_mnt(void)
+{
+	const char *fpath = "/tmp/mnt.test";
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo;
+	int mnt_fd, iter_fd, err;
+	struct bpf_iter_fs *skel;
+	struct bpf_link *link;
+	char buf[8192];
+	ssize_t nr;
+
+	/* Close fd after reading iterator completes */
+	mnt_fd = open(fpath, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	if (!ASSERT_GE(mnt_fd, 0, "open file"))
+		return;
+
+	skel = bpf_iter_fs__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		goto close_ino;
+
+	bpf_program__set_autoload(skel->progs.dump_mnt, true);
+
+	err = bpf_iter_fs__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto free_skel;
+
+	memset(&linfo, 0, sizeof(linfo));
+	linfo.fs.type = BPF_FS_ITER_MNT;
+	linfo.fs.fd = mnt_fd;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(skel->progs.dump_mnt, &opts);
+	if (!ASSERT_OK_PTR(link, "attach iter"))
+		goto free_skel;
+
+	iter_fd = bpf_iter_create(bpf_link__fd(link));
+	if (!ASSERT_GE(iter_fd, 0, "create iter"))
+		goto free_link;
+
+	nr = read(iter_fd, buf, sizeof(buf));
+	if (!ASSERT_GT(nr, 0, "read iter"))
+		goto close_iter;
+
+	buf[nr - 1] = 0;
+	puts(buf);
+
+close_iter:
+	close(iter_fd);
+free_link:
+	bpf_link__destroy(link);
+free_skel:
+	bpf_iter_fs__destroy(skel);
+close_ino:
+	close(mnt_fd);
+}
+
+void test_bpf_iter_fs(void)
+{
+	if (test__start_subtest("dump_raw_inode"))
+		test_bpf_iter_raw_inode();
+	if (test__start_subtest("dump_inode"))
+		test_bpf_iter_inode();
+	if (test__start_subtest("dump_mnt"))
+		test_bpf_iter_mnt();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_fs.c b/tools/testing/selftests/bpf/progs/bpf_iter_fs.c
new file mode 100644
index 000000000000..e238446b6ddf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_fs.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023. Huawei Technologies Co., Ltd */
+#include "bpf_iter.h"
+#include <string.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct dump_ctx {
+	struct seq_file *seq;
+	struct inode *inode;
+	unsigned long from;
+	unsigned long max;
+};
+
+void bpf_filemap_cachestat(struct inode *inode, unsigned long from, unsigned long last,
+		           struct cachestat *cs) __ksym;
+long bpf_filemap_find_present(struct inode *inode, unsigned long from, unsigned long last) __ksym;
+long bpf_filemap_get_order(struct inode *inode, unsigned long index) __ksym;
+
+static u64 dump_page_order(unsigned int i, void *ctx)
+{
+        struct dump_ctx *dump = ctx;
+	unsigned long index;
+	unsigned int order;
+
+	index = bpf_filemap_find_present(dump->inode, dump->from, dump->max);
+	if (index == -1UL)
+		return 1;
+	order = bpf_filemap_get_order(dump->inode, index);
+
+        BPF_SEQ_PRINTF(dump->seq, "  page offset %lu order %u\n", index, order);
+	dump->from = index + (1 << order);
+        return 0;
+}
+
+SEC("?iter/fs_inode")
+int dump_raw_inode(struct bpf_iter__fs_inode *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct inode *inode = ctx->inode;
+	struct btf_ptr ptr;
+
+	if (inode == NULL)
+		return 0;
+
+	memset(&ptr, 0, sizeof(ptr));
+	ptr.type_id = bpf_core_type_id_kernel(struct inode);
+	ptr.ptr = inode;
+	bpf_seq_printf_btf(seq, &ptr, sizeof(ptr), 0);
+
+	memset(&ptr, 0, sizeof(ptr));
+	ptr.type_id = bpf_core_type_id_kernel(struct super_block);
+	ptr.ptr = inode->i_sb;
+	bpf_seq_printf_btf(seq, &ptr, sizeof(ptr), 0);
+
+	return 0;
+}
+
+SEC("?iter/fs_inode")
+int dump_inode(struct bpf_iter__fs_inode *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct inode *inode = ctx->inode;
+	struct cachestat cs = {};
+	struct super_block *sb;
+	struct dentry *dentry;
+	struct dump_ctx dump;
+
+	if (inode == NULL)
+		return 0;
+
+	sb = inode->i_sb;
+	BPF_SEQ_PRINTF(seq, "sb: bsize %lu s_op %ps s_type %ps name %s\n",
+		       sb->s_blocksize, sb->s_op, sb->s_type, sb->s_type->name);
+
+	BPF_SEQ_PRINTF(seq, "ino: inode nlink %d inum %lu size %llu",
+			inode->i_nlink, inode->i_ino, inode->i_size);
+	dentry = ctx->dentry;
+	if (dentry)
+		BPF_SEQ_PRINTF(seq, ", name %s\n", dentry->d_name.name);
+	else
+		BPF_SEQ_PRINTF(seq, "\n");
+
+	bpf_filemap_cachestat(inode, 0, ~0UL, &cs);
+	BPF_SEQ_PRINTF(seq, "cache: cached %llu dirty %llu wb %llu evicted %llu\n",
+			cs.nr_cache, cs.nr_dirty, cs.nr_writeback, cs.nr_evicted);
+
+	dump.seq = seq;
+	dump.inode = inode;
+	dump.from = 0;
+	/* TODO: handle BPF_MAX_LOOPS */
+	dump.max = ((unsigned long)inode->i_size + 4095) / 4096;
+	BPF_SEQ_PRINTF(seq, "orders:\n");
+	bpf_loop(dump.max, dump_page_order, &dump, 0);
+
+	return 0;
+}
+
+SEC("?iter/fs_mnt")
+int dump_mnt(struct bpf_iter__fs_mnt *ctx)
+{
+	struct seq_file *seq = ctx->meta->seq;
+	struct mount *mnt = ctx->mnt;
+	struct super_block *sb;
+
+	if (mnt == NULL)
+		return 0;
+
+	sb = mnt->mnt.mnt_sb;
+	BPF_SEQ_PRINTF(seq, "dev %u:%u ",
+		       sb->s_dev >> 20, sb->s_dev & ((1 << 20) - 1));
+
+	BPF_SEQ_PRINTF(seq, "id %d parent_id %d mnt_flags 0x%x",
+		       mnt->mnt_id, mnt->mnt_parent->mnt_id, mnt->mnt.mnt_flags);
+	if (mnt->mnt.mnt_flags & 0x1000)
+		BPF_SEQ_PRINTF(seq, " shared:%d", mnt->mnt_group_id);
+	BPF_SEQ_PRINTF(seq, "\n");
+
+	return 0;
+}
-- 
2.29.2

