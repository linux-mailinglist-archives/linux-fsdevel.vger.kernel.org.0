Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCCA427866
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhJIJ3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 05:29:01 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:44072 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231598AbhJIJ27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 05:28:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Ur5qOcb_1633771618;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0Ur5qOcb_1633771618)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 17:26:59 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, song@kernel.org,
        william.kucharski@oracle.com, hughd@google.com,
        shy828301@gmail.com, linmiaohe@huawei.com, peterx@redhat.com
Subject: [PATCH 0/3] mm, thp: introduce a new sysfs interface to facilitate file THP for .text
Date:   Sat,  9 Oct 2021 17:26:55 +0800
Message-Id: <20211009092658.59665-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, all

Recently, our team focus on huge pages of executable binary files
and share libraries, refer to these huge pages as 'hugetext' in
the next description. The hugetext indeed to improve the performance
of application, e.g. mysql. It has been shown in [1][2]. And with
the increase of the text section, the improvement will be more
obvious. Base on [1][2], we make some improvement to make file-backed
THP more usability and easy for applications.

In current kernel, ref[1] introduced READ_ONLY_THP_FOR_FS, and ref[2]
add the support for share libraries based on the previous one. However,
Until now, hugetext is not convenient to use at present. For example,
we need to explicitly madvise MADV_HUGEPAGE for .text and set
"transparent_hugepage/enabled" to always or madvise . On the other
hand, hugetext requires 2M alignment of vma->vm_start and vma->vm_pgoff,
which is not guaranteed by kernel or loader.

Our design:
To solve the drawback mentioned above of file THP in using, we have
mainly improved two points that shows below.
(1) introduce a new sysfs interface "transparent_hugepage/hugetext_enabled"
in order to automatically (i.e., transparently) enable file THP for
suitable .text vmas. The usage belows:

    to disable hugetext:
    $ echo 0 > /sys/kernel/mm/transparent_hugepage/hugetext_enabled

    to enable hugetext:
    $ echo 1 > /sys/kernel/mm/transparent_hugepage/hugetext_enabled

    to enable or disable in boot options: hugetext=1 or hugetext=0

Q: Why not add a new option, e.g., "text_always", in addition to
"always", "madvise", and "never" to "transparent_hugepage/enabled" ?

A: A new option to "transparent_hugepage/enabled" cannot handle such
scenario, where THP always for .text, and madivse/never for others
(e.g., anon vma).

The .text is usually small in size. In our production environment, at
most 10G out of 500G total memory is used as .text. The .text is also
performance critical. More important, We don't want to change the
user's default behavior too much. So we think that a new independent
sysfs interface for file THP is worthy.

(2) make vm_start of .text 2M align with vm_pgoff, especially
for PIE/PIC binaries and shared libraries.

For binaries that are compiled with '--pie -fPIC' and with LOAD
alignment smaller than 2M (typically 4K, 64K), change
maximum_alignment to 2M.

For shared libraries, ld.so seems not to consider p_align well, as
shown below.
$ readelf -l /usr/lib64/libc-2.17.so
LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
               0x00000000001c2fe8 0x00000000001c2fe8  R E    200000
$ cat /proc/1/smaps
7fecc4072000-7fecc4235000 r-xp 00000000 08:03 655802  /usr/lib64/libc-2.17.so

Finally, why this feasure is implemented in kernel, not in userspace, or
ld.so?

Userspace methods like libhugetlbfs have various disadvantages:
 * require recompiling applications;
 * the anonymous mapping cannot be shared;
 * debugging is not convenient.

To madvise MADV_HUGEPAGE for .text in ld.so has been suggested in the
glibc mailing list[3], but there was no response.

Finally, considering that this feature requires very little code and
is not too difficult to implement based on the existing file-backed
THP support, it was finally chosen to be implemented in the kernel.

Thanks!

Reference:
[1] https://patchwork.kernel.org/project/linux-mm/cover/20190801184244.3169074-1-songliubraving@fb.com/
[2] https://patchwork.kernel.org/project/linux-fsdevel/patch/20210406000930.3455850-1-cfijalkovich@google.com/
[3] https://sourceware.org/pipermail/libc-alpha/2021-February/122334.html

Rongwei Wang (3):
  mm, thp: support binaries transparent use of file THP
  mm, thp: make mapping address of libraries THP align
  mm, thp: make mapping address of PIC binaries THP align

 fs/binfmt_elf.c            |  5 +++
 include/linux/huge_mm.h    | 36 +++++++++++++++++++
 include/linux/khugepaged.h |  9 +++++
 mm/Kconfig                 | 11 ++++++
 mm/huge_memory.c           | 72 ++++++++++++++++++++++++++++++++++++++
 mm/khugepaged.c            |  4 +++
 mm/memory.c                | 12 +++++++
 mm/mmap.c                  | 18 ++++++++++
 8 files changed, 167 insertions(+)

-- 
2.27.0

