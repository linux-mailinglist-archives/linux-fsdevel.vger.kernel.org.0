Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97F53A45D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFKQCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 12:02:11 -0400
Received: from foss.arm.com ([217.140.110.172]:33718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhFKQCK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:02:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22723D6E;
        Fri, 11 Jun 2021 09:00:11 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB5B53F719;
        Fri, 11 Jun 2021 09:00:06 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jia He <justin.he@arm.com>
Subject: [PATCH RFCv3 0/3] make '%pD' print full path for file
Date:   Fri, 11 Jun 2021 23:59:50 +0800
Message-Id: <20210611155953.3010-1-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Background
==========
Linus suggested printing full path for file instead of printing
the components as '%pd'.

Typically, there is no need for printk specifiers to take any real locks
(ie mount_lock or rename_lock). So I introduce a new helper d_path_fast
which is similar to d_path except it doesn't take any seqlock/spinlock.

This series is based on Al Viro's d_path cleanup patches [1] which
lifted the inner lockless loop into a new helper. 

[1] https://lkml.org/lkml/2021/5/18/1260

Test
====
The cases I tested:
1. print '%pD' with full path of ext4 file
2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
   with '%pD'
5. all test_print selftests, including the new '%14pD' '%-14pD'
4. kasnprintf
   
After this set, I found many lines containing '%pD[234]' should be changed
to '%pD'. I don't want to involve those subsystems in this patch series
before the helper is stable enough.
   
You can get the lines by:
$find fs/ -name \*.[ch] | xargs grep -rn "\%pD[234"

fs/overlayfs/file.c:65: pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
fs/nfs/direct.c:453:    dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
fs/nfs/direct.c:908:    dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
fs/nfs/write.c:1371:    dprintk("NFS:       nfs_updatepage(%pD2 %d@%lld)\n",
fs/nfs/nfs4file.c:116:  dprintk("NFS: flush(%pD2)\n", file);
fs/nfs/file.c:69:       dprintk("NFS: open file(%pD2)\n", filp);
fs/nfs/file.c:83:       dprintk("NFS: release(%pD2)\n", filp);
fs/nfs/file.c:117:      dprintk("NFS: llseek file(%pD2, %lld, %d)\n",
fs/nfs/file.c:145:      dprintk("NFS: flush(%pD2)\n", file);
fs/nfs/file.c:166:      dprintk("NFS: read(%pD2, %zu@%lu)\n",
fs/nfs/file.c:188:      dprintk("NFS: mmap(%pD2)\n", file);
fs/nfs/file.c:213:      dprintk("NFS: fsync file(%pD2) datasync %d\n", file, datasync);
fs/nfs/file.c:328:      dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
fs/nfs/file.c:360:      dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
fs/nfs/file.c:551:      dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
fs/nfs/file.c:621:      dprintk("NFS: write(%pD2, %zu@%Ld)\n",
fs/nfs/file.c:803:      dprintk("NFS: lock(%pD2, t=%x, fl=%x, r=%lld:%lld)\n",
fs/nfs/file.c:841:      dprintk("NFS: flock(%pD2, t=%x, fl=%x)\n",
fs/nfs/dir.c:111:       dfprintk(FILE, "NFS: open dir(%pD2)\n", filp);
fs/nfs/dir.c:456:                                               pr_notice("NFS: directory %pD2 contains a readdir loop."
fs/nfs/dir.c:1084:      dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
fs/nfs/dir.c:1158:      dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
fs/nfs/dir.c:1166:      dfprintk(FILE, "NFS: llseek dir(%pD2, %lld, %d)\n",
fs/nfs/dir.c:1208:      dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
fs/nfsd/nfs4state.c:2439:         seq_printf(s, "filename: \"%pD2\"", f->nf_file);
fs/exec.c:817:          pr_warn_once("process '%pD4' started with executable stack\n",
fs/iomap/direct-io.c:429:               pr_warn_ratelimited("Direct I/O collision with buffered writes! File: %pD4 Comm: %.20s\n",
fs/ioctl.c:81:          pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
fs/read_write.c:425:            "kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
fs/splice.c:754:                "splice %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
fs/afs/mntpt.c:64:      _enter("%p,%p{%pD2}", inode, file, file);

Changelog:
v3:
- implement new d_path_unsafe to use [buf, end] instead of stack space for
  filling bytes (by Matthew)
- add new test cases for '%pD'
- drop patch "hmcdrv: remove the redundant directory path" before removing rfc.

v2: 
- implement new d_path_fast based on Al Viro's patches
- add check_pointer check (by Petr)
- change the max full path size to 256 in stack space
v1: https://lkml.org/lkml/2021/5/8/122

Jia He (3):
  fs: introduce helper d_path_unsafe()
  lib/vsprintf.c: make %pD print full path for file
  lib/test_printf: add test cases for '%pD'

 Documentation/core-api/printk-formats.rst |  5 +-
 fs/d_path.c                               | 82 ++++++++++++++++++++++-
 include/linux/dcache.h                    |  1 +
 lib/test_printf.c                         | 26 ++++++-
 lib/vsprintf.c                            | 47 +++++++++++--
 5 files changed, 152 insertions(+), 9 deletions(-)

-- 
2.17.1

