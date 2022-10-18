Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6AE602395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJRFAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 01:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiJRE7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:59:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96051A2840
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 21:59:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h2so5398370plb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Oct 2022 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wROmiozKsMZ06owOelq8upB2FpRZ/Dvboacs1txIL8g=;
        b=BX8pbM76LitaK+51gGUGV/PR/relSeCBal5bI5My9tz4L1g8M/CiCGomHD1Ao+WqwG
         N+ihqVdZLlP3KTwT8ICrz2buhlxMazIzp3egNbGW3pT7QQ1rHKZrRG7O9Gkq4b/8EWE5
         vQpAPjjadkCkp2KZggbcug1SmsBs+rA+y1RT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wROmiozKsMZ06owOelq8upB2FpRZ/Dvboacs1txIL8g=;
        b=V7evMU2BMwu+dNCDyayW67rPfCFr/qgwdsUoNWyy9s6rZpNDVPEFGaGG14jdW0rclY
         z/X0QsYZ6JhXDTgLL33ptfSkgtoGpKXF4cyrZbZoIUUT8TAcy2B6WAVJekEveQB3/V1T
         izfTn/eX4gYyQSGA1fdLQAk0PYybX5MtDU91JPPgxZ7e42eIfc18X3OfwcrFy03O96sI
         HIiu6MmSqLPIHQUggy8kv+bTqBh3AmIg7MCfU1v99nAQIILoCwWgVI9wRyZXAHYXMZdT
         S7Sg3ps+HJOhy7DSNQf5KiOefUm4eqsMTfxcMOG7obcOqWmZQPotSZhKfORKQFmMYnsV
         wfEA==
X-Gm-Message-State: ACrzQf0OIQjIJ/qnNOeD4qTLnHm46lvvpP3AqX2RT1gfJV1dgyc3RuWu
        BxuQHsr02X2w40A9ggc5KB3GlZvFyqBLVfcA
X-Google-Smtp-Source: AMsMyM6j8Ez8vvzoXtDqjhzlQLnTnj13ON52i0RIohYVUUltmmasGXAcZSNG/h8kZjbu1rJLxQbSWQ==
X-Received: by 2002:a17:90b:3a8b:b0:20d:b254:e30e with SMTP id om11-20020a17090b3a8b00b0020db254e30emr1529815pjb.206.1666069141861;
        Mon, 17 Oct 2022 21:59:01 -0700 (PDT)
Received: from localhost ([2601:644:200:2b2:39ea:fa9e:7fbd:8a64])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902a3cb00b00176d347e9a7sm7449431plb.233.2022.10.17.21.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:59:01 -0700 (PDT)
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
        Ivan Babrou <ivan@cloudflare.com>
Subject: [PATCH v3] proc: report open files as size in stat() for /proc/pid/fd
Date:   Mon, 17 Oct 2022 21:58:44 -0700
Message-Id: <20221018045844.37697-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.37.3
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
v3: Made use of bitmap_weight() to count the bits.
v2: Added missing rcu_read_lock() / rcu_read_unlock(),
    task_lock() / task_unlock() and put_task_struct().
---
 Documentation/filesystems/proc.rst | 17 +++++++++++++
 fs/proc/fd.c                       | 41 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index 913bef0d2a36..439a62c59381 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -279,6 +279,31 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	return 0;
 }
 
+static int proc_readfd_count(struct inode *inode)
+{
+	struct task_struct *p = get_proc_task(inode);
+	struct fdtable *fdt;
+	unsigned int open_fds = 0;
+
+	if (!p)
+		return -ENOENT;
+
+	task_lock(p);
+	if (p->files) {
+		rcu_read_lock();
+
+		fdt = files_fdtable(p->files);
+		open_fds = bitmap_weight(fdt->open_fds, fdt->max_fds);
+
+		rcu_read_unlock();
+	}
+	task_unlock(p);
+
+	put_task_struct(p);
+
+	return open_fds;
+}
+
 static int proc_readfd(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx, proc_fd_instantiate);
@@ -319,9 +344,25 @@ int proc_fd_permission(struct user_namespace *mnt_userns,
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
2.37.3

