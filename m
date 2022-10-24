Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588B560B649
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 20:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJXSyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiJXSxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:53:32 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0481937AA
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 10:34:45 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id 192so2390354pfx.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXzCZ5rm6SI2wrD2b5taRfSp+IHoN3hQXiAouJQX7ls=;
        b=kLEQVCJXkj3W9Vy4Ri0brcVSrlyZha6CYi1LpldrkhaEQsW/bjDxnvxHPTR3qOEKJ2
         uvinpGHK8cgooBRIChPLJkHNxi+M2BQkHewI0a0ohsmaLr/w9/92Gw4nwPkr0uxXvxRN
         nYoWKpxXNHDKEb6GRU0+nWm17+mbOrAfQiMgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXzCZ5rm6SI2wrD2b5taRfSp+IHoN3hQXiAouJQX7ls=;
        b=kSMqsl2/bBP68v7vTxzOBHOPvbcfb0KRVL2FKy/n4ZxuniwgqNsk26m5UZlRAqbaYL
         +WdCkEAjN58mB0xFNLwy+cWOmAeDc6wLFRFnIIKfyAw5a18mpRZriOqzRFuyB8FF2eIS
         Vr7s4aJvzbdGq4u6t70/9/ldCRq37JFtCBt1nDmnzBUqsBLmFDf6w0hwZcrN7Agjx+iZ
         qs9PkXnTrMw20XFPMOz1ZYeqeF0BoQ4wRNrHKqbGmnb44BLgNSBHcSuhS6yFxR3pWXI+
         ixUzcBDKdZ1dnYq8wMbUxD3wDEA2dVfgZeU08pARJPlRBvk/AXhIbbY/1JzUCImjSSp2
         f7Uw==
X-Gm-Message-State: ACrzQf3Jbuz2De3DS/GoVZ/CHGPOAJgLICLNcub7HbpY5u6OhxNTyzw7
        SnuedYei92ozuMBOkjVis7+9IAyl3/+tnWa1
X-Google-Smtp-Source: AMsMyM557LAedDOxn8IvNZlASjhqK4IAgEyV8ewSUdi9+UbjnPBbf5whEcxtUCIrqmds0gBw42tw6Q==
X-Received: by 2002:aa7:9212:0:b0:562:b5f6:f7d7 with SMTP id 18-20020aa79212000000b00562b5f6f7d7mr35480509pfo.70.1666632744744;
        Mon, 24 Oct 2022 10:32:24 -0700 (PDT)
Received: from localhost ([2601:644:200:2b2:c54f:5b4:9653:ba01])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001755e4278a6sm9905plg.261.2022.10.24.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:32:24 -0700 (PDT)
From:   Ivan Babrou <ivan@cloudflare.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Brian Foster <bfoster@redhat.com>,
        Ivan Babrou <ivan@cloudflare.com>
Subject: [PATCH v4] proc: report open files as size in stat() for /proc/pid/fd
Date:   Mon, 24 Oct 2022 10:31:40 -0700
Message-Id: <20221024173140.30673-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
v4: Return errno from proc_fd_getattr() instead of setting negative size.
    Added an explicit include for linux/bitmap.h.
v3: Made use of bitmap_weight() to count the bits.
v2: Added missing rcu_read_lock() / rcu_read_unlock(),
    task_lock() / task_unlock() and put_task_struct().
---
 Documentation/filesystems/proc.rst | 17 +++++++++++
 fs/proc/fd.c                       | 45 ++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 898c99eae8e4..ec6cfdf1796a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -47,6 +47,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
   3.12	/proc/<pid>/arch_status - Task architecture specific information
+  3.13  /proc/<pid>/fd - List of symlinks to open files
 
   4	Configuring procfs
   4.1	Mount options
@@ -2149,6 +2150,22 @@ AVX512_elapsed_ms
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
index 913bef0d2a36..fc46d6fe080c 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -7,6 +7,7 @@
 #include <linux/namei.h>
 #include <linux/pid.h>
 #include <linux/ptrace.h>
+#include <linux/bitmap.h>
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
@@ -279,6 +280,30 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	return 0;
 }
 
+static int proc_readfd_count(struct inode *inode, loff_t *count)
+{
+	struct task_struct *p = get_proc_task(inode);
+	struct fdtable *fdt;
+
+	if (!p)
+		return -ENOENT;
+
+	task_lock(p);
+	if (p->files) {
+		rcu_read_lock();
+
+		fdt = files_fdtable(p->files);
+		*count = bitmap_weight(fdt->open_fds, fdt->max_fds);
+
+		rcu_read_unlock();
+	}
+	task_unlock(p);
+
+	put_task_struct(p);
+
+	return 0;
+}
+
 static int proc_readfd(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx, proc_fd_instantiate);
@@ -319,9 +344,29 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
 	return rv;
 }
 
+static int proc_fd_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
+			u32 request_mask, unsigned int query_flags)
+{
+	struct inode *inode = d_inode(path->dentry);
+	int rv = 0;
+
+	generic_fillattr(&init_user_ns, inode, stat);
+
+	/* If it's a directory, put the number of open fds there */
+	if (S_ISDIR(inode->i_mode)) {
+		rv = proc_readfd_count(inode, &stat->size);
+		if (rv < 0)
+			return rv;
+	}
+
+	return rv;
+}
+
 const struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_fd_permission,
+	.getattr	= proc_fd_getattr,
 	.setattr	= proc_setattr,
 };
 
-- 
2.37.3

