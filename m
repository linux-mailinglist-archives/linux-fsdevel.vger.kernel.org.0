Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA15398BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348059AbiEaV0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 17:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347928AbiEaVZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 17:25:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B09E9D3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so12969669ybp.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=SHwRUtvrT0NdcbhIAR6+q8dVHlt/noH6zImMf2T6bN4=;
        b=T42lyMTLciKl9Rv8/akmQtqV6uQQ3E9lX3jWMAM9W82MEwX1WhMSTKgLZRje/MNn+N
         eaMz6KMZQvtrz0QjRD+AfcH6yPO8ZF657CajRVWMHR5EbQcU2E6dqGuctCFu/kMyHUxC
         vToGcV2W3eMszf/c30QX9yL1UALQwfojoCr5x6IchvuVjlav1j/iJta6sr8IMsKGUQ/k
         S2lgestauhqAsjGB/Juetw8217qZvtYbVZ17ECFylI8CcKlrM+cJ4qS560kzTM6Q62wT
         BQSEHpmzBUsOIEvFHF7bCoEe17s+9mMpHlx8aLBwTl+dueknacj39X5zbJHYt5zxLrPZ
         gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=SHwRUtvrT0NdcbhIAR6+q8dVHlt/noH6zImMf2T6bN4=;
        b=UCqIv9iT1yyMI3Y/JJt1TU3DZ5j/Rk6kHw4uWQvJRpKUQLswyPxlpOXxEUIoY019Um
         U6h0hct4HVZHvPJuEzB+5OmvryDGq3wDLklmRa0QQGbS4mFkAuPBcpIzPyCo5LJC/EY2
         RZmcl+7RvhlbMXswym+WrF00J3nL157g+mWKvJs7FujuXYdOH/Dk8/b0Ta5akYaFqyuN
         4YYG+F31K2ryGJR4oQCQYF9Wj9fbRFfM0t28CmkYrbOwPFXgZ4CREqYu1K+5y/zBuezO
         Zb62+dRRtbFg1Foao4xGfEo30h4OGUlQYQod+KDlwj3FObluHxpiiLa/P7FSbDO28gG4
         wT5w==
X-Gm-Message-State: AOAM531iKRQJgOf7zOfhvpwc6ysEVtPmTo6ET7CJXAZBcDjlPf3opq4g
        FZcxi6gSsbm1iikGeCXID35CDYt8Un2AS35m4A==
X-Google-Smtp-Source: ABdhPJyG9PJC9moHZn+WxEZeqsj3bqG2VefQDfTTJGrPdN9BgwqI20Tqbfa0K86skPf8JTa8S1yG0V0nozkYxpHBng==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:a3c0:2a66:b25c:16df])
 (user=kaleshsingh job=sendgmr) by 2002:a0d:ea44:0:b0:30c:2902:dd96 with SMTP
 id t65-20020a0dea44000000b0030c2902dd96mr17812893ywe.115.1654032347582; Tue,
 31 May 2022 14:25:47 -0700 (PDT)
Date:   Tue, 31 May 2022 14:25:15 -0700
In-Reply-To: <20220531212521.1231133-1-kaleshsingh@google.com>
Message-Id: <20220531212521.1231133-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220531212521.1231133-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 2/2] procfs: Add 'path' to /proc/<pid>/fdinfo/
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Colin Cross <ccross@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to identify the type of memory a process has pinned through
its open fds, add the file path to fdinfo output. This allows
identifying memory types based on common prefixes. e.g. "/memfd...",
"/dmabuf...", "/dev/ashmem...".

Access to /proc/<pid>/fdinfo is governed by PTRACE_MODE_READ_FSCREDS
the same as /proc/<pid>/maps which also exposes the file path of
mappings; so the security permissions for accessing path is consistent
with that of /proc/<pid>/maps.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes from rfc:
  - Split adding 'size' and 'path' into a separate patches, per Christian
  - Fix indentation (use tabs) in documentaion, per Randy

 Documentation/filesystems/proc.rst | 14 ++++++++++++--
 fs/proc/fd.c                       |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 779c05528e87..591f12d30d97 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1886,14 +1886,16 @@ if precise results are needed.
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
+files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
+and 'path'.
 
 The 'pos' represents the current offset of the opened file in decimal
 form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
 file has been created with [see open(2) for details] and 'mnt_id' represents
 mount ID of the file system containing the opened file [see 3.5
 /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
-the file, and 'size' represents the size of the file in bytes.
+the file, 'size' represents the size of the file in bytes, and 'path'
+represents the file path.
 
 A typical output is::
 
@@ -1902,6 +1904,7 @@ A typical output is::
 	mnt_id:	19
 	ino:	63107
 	size:	0
+	path:	/dev/null
 
 All locks associated with a file descriptor are shown in its fdinfo too::
 
@@ -1920,6 +1923,7 @@ Eventfd files
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:[eventfd]
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1934,6 +1938,7 @@ Signalfd files
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:[signalfd]
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1949,6 +1954,7 @@ Epoll files
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:[eventpoll]
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1968,6 +1974,7 @@ For inotify files the format is the following::
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:inotify
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -1992,6 +1999,7 @@ For fanotify files the format is::
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:[fanotify]
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2018,6 +2026,7 @@ Timerfd files
 	mnt_id:	9
 	ino:	63107
 	size:   0
+	path:	anon_inode:[timerfd]
 	clockid: 0
 	ticks: 0
 	settime flags: 01
@@ -2042,6 +2051,7 @@ DMA Buffer files
 	mnt_id:	9
 	ino:	63107
 	size:   32768
+	path:	/dmabuf:
 	count:  2
 	exp_name:  system-heap
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 464bc3f55759..8889a8ba09d4 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -60,6 +60,10 @@ static int seq_show(struct seq_file *m, void *v)
 	seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
 	seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
 
+	seq_puts(m, "path:\t");
+	seq_file_path(m, file, "\n");
+	seq_putc(m, '\n');
+
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
-- 
2.36.1.255.ge46751e96f-goog

