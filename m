Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FCB5BED56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiITTIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITTIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:08:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2725875495
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:08:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 207so3619166pgc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kjAnb80a/FCJUaAkcTTFLOSiKTAsM44zMnZCUQ5HAIM=;
        b=NPO/VyXuHQ9EU5GNEHDDkc0TNddFTAGtrPDH7nVOyKAbOD6CX72Xc9655HalExV6Pk
         w8l9O8UcLN8wS/n0cUkcIGr96htOdEPs+VqMvNPZjOIq5wHQGsLB6I4sGmZb/Z+hjKyM
         V0lkmEb7m/TQQEALCb6cQ4tHQMvmTWzyoVqCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kjAnb80a/FCJUaAkcTTFLOSiKTAsM44zMnZCUQ5HAIM=;
        b=MDXjI2VZd6ENUjyWZs+VNWp60AC850fgbmogltnk3V7jrVFuseL29795aIi6DuB7c3
         yZeDVXeQM1aAZVJznER8slE7AxhtgkA+1sHWgtGX6IUDjwVMvhVd/Vh/dogaTTnoC5uU
         OVtWfpFxFsjQ0Xlr8CgNnTEuCN4OQ+BpM5syCbiYQIyWRsxWR6pFezZSC1P60GPeeY6W
         Co5cSMTn+UDUbP5u9A6Q8za5QWcginEP85SSKtG3DCr0vswv+o6cHoeYLiozSmo6CtS9
         tvOqDtEHMOM+a9yWsF4+5pnDwJX8K/W0XLi6ctJjZYqcZm2nA4jjox9NdkRezA/PO2O6
         FYDA==
X-Gm-Message-State: ACrzQf1buxsnDr6li3ctxfaYNofjkDbPfpOPbFXqqfbAlfujcOdocywc
        7qLF75ov+llCBaaySPAp4dWgrK+mT5klmuhE
X-Google-Smtp-Source: AMsMyM4ncbd2awrFY8HkO18jd2o4c6wToflLi/4EpMirLjezDHPO2LhXIt9IdsOa7eaYLW+tVvcxUA==
X-Received: by 2002:a65:6e82:0:b0:41a:9b73:f0e6 with SMTP id bm2-20020a656e82000000b0041a9b73f0e6mr22297189pgb.371.1663700923474;
        Tue, 20 Sep 2022 12:08:43 -0700 (PDT)
Received: from localhost ([2601:644:200:2b2:591c:daca:2961:74f7])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090aaa9800b00203c0a1d56bsm19949pjq.35.2022.09.20.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:08:42 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Ivan Babrou <ivan@cloudflare.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH] proc: report open files as size in stat() for /proc/pid/fd
Date:   Tue, 20 Sep 2022 12:06:17 -0700
Message-Id: <20220920190617.2539-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many monitoring tools include open file count as a metric. Currently
the only way to get this number is to enumerate the files in /proc/pid/fd.

The problem with the current approach is that it does many things people
generally don't care about when they need one number for a metric.
In our tests for cadvisor, which reports open file counts per cgroup,
we observed that reading the number of open files is slow. Out of 35.23%
of CPU time spent in `proc_readfd_common`, we see 29.43% spent in
`proc_fill_cache`, which is responsible for filling dentry info.
Some of this extra time is spinlock contention, but it's a contention
for the lock we don't want to take to begin with.

We considered putting the number of open files in /proc/pid/status.
Unfortunately, counting the number of fds involves iterating the open_files
bitmap, which has a linear complexity in proportion with the number
of open files (bitmap slots really, but it's close). We don't want
to make /proc/pid/status any slower, so instead we put this info
in /proc/pid/fd as a size member of the stat syscall result.
Previously the reported number was zero, so there's very little
risk of breaking anything, while still providing a somewhat logical
way to count the open files with a fallback if it's zero.

RFC for this patch included iterating open fds under RCU. Thanks
to Frank Hofmann for the suggestion to use the bitmap instead.

Previously:

```
$ sudo stat /proc/1/fd | head -n2
  File: /proc/1/fd
  Size: 0         	Blocks: 0          IO Block: 1024   directory
```

With this patch:

```
$ sudo stat /proc/1/fd | head -n2
  File: /proc/1/fd
  Size: 65        	Blocks: 0          IO Block: 1024   directory
```

Correctness check:

```
$ sudo ls /proc/1/fd | wc -l
65
```

I added the docs for /proc/<pid>/fd while I'm at it.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
---
 Documentation/filesystems/proc.rst | 17 ++++++++++++++
 fs/proc/fd.c                       | 36 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index e7aafc82be99..394548d26187 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
+  3.13  /proc/<pid>/fd - List of symlinks to open files
 
   4	Configuring procfs
   4.1	Mount options
@@ -2145,6 +2146,22 @@ AVX512_elapsed_ms
   the task is unlikely an AVX512 user, but depends on the workload and the
   scheduling scenario, it also could be a false negative mentioned above.
 
+3.13 /proc/<pid>/fd - List of symlinks to open files
+-------------------------------------------------------
+This directory contains symbolic links which represent open files
+the process is maintaining.  Example output::
+
+  lr-x------ 1 root root 64 Sep 20 17:53 0 -> /dev/null
+  l-wx------ 1 root root 64 Sep 20 17:53 1 -> /dev/null
+  lrwx------ 1 root root 64 Sep 20 17:53 10 -> 'socket:[12539]'
+  lrwx------ 1 root root 64 Sep 20 17:53 11 -> 'socket:[12540]'
+  lrwx------ 1 root root 64 Sep 20 17:53 12 -> 'socket:[12542]'
+
+The number of open files for the process is stored in 'size' member
+of stat() output for /proc/<pid>/fd for fast access.
+-------------------------------------------------------
+
+
 Chapter 4: Configuring procfs
 =============================
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36..c3c4bf2939a7 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -279,6 +279,26 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	return 0;
 }
 
+static int proc_readfd_count(struct inode *inode)
+{
+	struct task_struct *p = get_proc_task(inode);
+	struct fdtable *fdt;
+	unsigned int i, size, open_fds = 0;
+
+	if (!p)
+		return -ENOENT;
+
+	if (p->files) {
+		fdt = files_fdtable(p->files);
+		size = fdt->max_fds;
+
+		for (i = size / BITS_PER_LONG; i > 0;)
+			open_fds += hweight64(fdt->open_fds[--i]);
+	}
+
+	return open_fds;
+}
+
 static int proc_readfd(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx, proc_fd_instantiate);
@@ -319,9 +339,25 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
 	return rv;
 }
 
+static int proc_fd_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
+			u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+
+	generic_fillattr(&init_user_ns, inode, stat);
+
+	/* If it's a directory, put the number of open fds there */
+	if (S_ISDIR(inode->i_mode))
+		stat->size = proc_readfd_count(inode);
+
+	return 0;
+}
+
 const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
+	.getattr	= proc_fd_getattr,
 	.setattr	= proc_setattr,
 };
 
-- 
2.37.2

