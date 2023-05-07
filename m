Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816196F96B1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 05:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjEGDa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEGDaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 23:30:24 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D311607;
        Sat,  6 May 2023 20:30:22 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QDVL11gRwz4f3nqq;
        Sun,  7 May 2023 11:30:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNHG1dkjIawIw--.21328S4;
        Sun, 07 May 2023 11:30:16 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Amir Goldstein <amir73il@gmail.com>, houtao1@huawei.com
Subject: [RFC PATCH bpf-next 0/4] Introduce bpf iterators for file-system
Date:   Sun,  7 May 2023 12:01:03 +0800
Message-Id: <20230507040107.3755166-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNHG1dkjIawIw--.21328S4
X-Coremail-Antispam: 1UD129KBjvJXoWxArykAr13CryUuFW5AFykuFg_yoW5XFW5pF
        Z5J3yayr1xAFW7Arn3Can3u34rt3ykJFW5GasrXry5u3yYvr929w10kr15u3sxAryUAr1S
        vr42k3s09a4kZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset is in a hurry and far from complete, but it is better to
provide some code/demo first for disussion in LSF/MM/BPF.

The patchset attempts to provide more observability for the file-system
as proposed in [0]. Compared to drgn [1], the bpf iterator for file-system
has fewer dependencies (e.g., no need for vmlinux) and more accurate
results.

Two types of file-system iterator are provided: fs_inode and fs_mnt.
fs_inode is for a specific inode and fs_mnt is for a specifc mount. More
type (e.g., all inodes in a file-system) could be added if in need. Both
of these two iterators work by getting a file-description and a bpf
program as the input. BPF iterator will pass the fd-related inode or
mount to the bpf program, the bpf program can dump the needed
information of the inode or mount to a seq_file owned by iterator fd
by using all kinds of bpf helpers and the user can read the iterator fd
to get the final information. The following is an example when trying to
dump the detailed information of a XFS inode:

  sb: bsize 4096 s_op xfs_super_operations s_type xfs_fs_type name xfs
  ino: inode nlink 1 inum 131 size 10485760, name inode.test
  cache: cached 2560 dirty 0 wb 0 evicted 0
  orders:
    page offset 0 order 2
    page offset 4 order 2
    page offset 8 order 2
    page offset 12 order 2
    page offset 16 order 4
    page offset 32 order 4
    page offset 48 order 4
    page offset 64 order 5
    page offset 96 order 4
    page offset 112 order 4
    page offset 128 order 5
    page offset 160 order 4
    page offset 176 order 0
    ...

More details can be found in the individual patches. And suggestions and
comments are always welcome.

[0]: https://lore.kernel.org/bpf/0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com
[1]: https://github.com/osandov/drgn

Hou Tao (4):
  bpf: Introduce bpf iterator for file-system inode
  bpf: Add three kfunc helpers for bpf fs inode iterator
  bpf: Introduce bpf iterator for file system mount
  selftests/bpf: Add test cases for bpf file-system iterator

 include/linux/bpf.h                           |   2 +
 include/linux/btf_ids.h                       |   6 +-
 include/linux/fs.h                            |   4 +
 include/uapi/linux/bpf.h                      |   9 +
 include/uapi/linux/mman.h                     |   8 +
 kernel/bpf/Makefile                           |   1 +
 kernel/bpf/fs_iter.c                          | 216 ++++++++++++++++++
 kernel/bpf/helpers.c                          |  26 +++
 mm/filemap.c                                  |  77 +++++++
 tools/include/uapi/linux/bpf.h                |   9 +
 .../selftests/bpf/prog_tests/bpf_iter_fs.c    | 184 +++++++++++++++
 .../testing/selftests/bpf/progs/bpf_iter_fs.c | 122 ++++++++++
 12 files changed, 663 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/fs_iter.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_iter_fs.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_fs.c

-- 
2.29.2

