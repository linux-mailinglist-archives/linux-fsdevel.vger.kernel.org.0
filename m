Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E75398B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiEaVZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 17:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348008AbiEaVZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 17:25:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54AF9D4E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 70-20020a250249000000b0065cbf886b23so6014349ybc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 14:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=px4+ZpXbHsure7vaViwll/H2EGv0zUZueEOXuxtocqM=;
        b=ZaARQ8d9PxwUFkeye+orr7uFPd1EQEtmzE+s6UR1ux+FcJbmTHiZMJ7e1JzoYbWBUl
         MmsmGGcDUWwDl++YBLF/jGBcZ9lqmCmJqOXTlaS/R3d6UBNhxWaNMjeHc5eGTbvGLUe8
         SkmOziIw6AkAwq76+XInYclaLp6vw+FNuXhy2Jq5VMAFaIlILl3AKWGm3vccd/4/2RDZ
         HPtlQ8x4ydXT7SRAuKi6Uou21GfFqKbCfvEpfPM4kJojTYN93ydf8Mcw6YmEpoOEzdQ3
         p97exnTro1SyD5LgslZm6/+TUMSKAEZrVnMkRAoxLIKYgxyjsusMw/gYicG9vpaLMIkN
         XEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=px4+ZpXbHsure7vaViwll/H2EGv0zUZueEOXuxtocqM=;
        b=SYsBxW9ykUrD+Llw8qeKwDSzB8wRtOsORdKIeEO837RuZPKDNnw//9XfTzwVueYWmF
         VUlQQi/OiyW+e4nCAJkuI6NEXcCaHcSY5jDouwBsOulcnHxhK6T7qv/gM/kCJ009Lp7r
         wEK6ZsBRXpUVP/7Zw4NK73arbFM1Tiyd0Qtaf+6LOwoflfVBMNPIpCSUCsgIr0V2k3rz
         WRw5+XuCmSVZ4+1uIHCO8/ESu/X/3JtjB2o5mC4JLyIuOPoCixx9mH5XfuuyyNpXxo/6
         SX+HroJKxRV3S8/GF64S8O1AhgLAE4Q9ReS9GNS0HGYbIQNJYLuYHbmRy1Zlhn7oNtZd
         HwHQ==
X-Gm-Message-State: AOAM532HcHXtqeoLE3yqNWs5+T0h6w7xE4tSofaYTNI6XAoKHaRxJigi
        1y9FIvHXTFt1bRXUK3wittx5yYfNB8sf+YhaRw==
X-Google-Smtp-Source: ABdhPJwZ/c83nZu7U03w4uDCuA9LC5io7QSRjyjVxQZqwDEDunG479HIBUW6hUZDhFjJsLb9bhLsnieTrpx2EYlm+Q==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:a3c0:2a66:b25c:16df])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:1d1:b0:65c:ea47:8ea1 with
 SMTP id u17-20020a05690201d100b0065cea478ea1mr11260576ybh.400.1654032337918;
 Tue, 31 May 2022 14:25:37 -0700 (PDT)
Date:   Tue, 31 May 2022 14:25:14 -0700
In-Reply-To: <20220531212521.1231133-1-kaleshsingh@google.com>
Message-Id: <20220531212521.1231133-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220531212521.1231133-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 1/2] procfs: Add 'size' to /proc/<pid>/fdinfo/
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     ilkos@google.com, tjmercier@google.com, surenb@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Mike Rapoport <rppt@kernel.org>,
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

To be able to account the amount of memory a process is keeping pinned
by open file descriptors add a 'size' field to fdinfo output.

dmabufs fds already expose a 'size' field for this reason, remove this
and make it a common field for all fds. This allows tracking of
other types of memory (e.g. memfd and ashmem in Android).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes from rfc:
  - Split adding 'size' and 'path' into a separate patches, per Christian
  - Split fdinfo seq_printf into separate lines, per Christian
  - Fix indentation (use tabs) in documentaion, per Randy

 Documentation/filesystems/proc.rst | 12 ++++++++++--
 drivers/dma-buf/dma-buf.c          |  1 -
 fs/proc/fd.c                       |  9 +++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321..779c05528e87 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1886,13 +1886,14 @@ if precise results are needed.
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
+files have at least five fields -- 'pos', 'flags', 'mnt_id', 'ino', and 'size'.
+
 The 'pos' represents the current offset of the opened file in decimal
 form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
 file has been created with [see open(2) for details] and 'mnt_id' represents
 mount ID of the file system containing the opened file [see 3.5
 /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
-the file.
+the file, and 'size' represents the size of the file in bytes.
 
 A typical output is::
 
@@ -1900,6 +1901,7 @@ A typical output is::
 	flags:	0100002
 	mnt_id:	19
 	ino:	63107
+	size:	0
 
 All locks associated with a file descriptor are shown in its fdinfo too::
 
@@ -1917,6 +1919,7 @@ Eventfd files
 	flags:	04002
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1930,6 +1933,7 @@ Signalfd files
 	flags:	04002
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1944,6 +1948,7 @@ Epoll files
 	flags:	02
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1962,6 +1967,7 @@ For inotify files the format is the following::
 	flags:	02000000
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -1985,6 +1991,7 @@ For fanotify files the format is::
 	flags:	02
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2010,6 +2017,7 @@ Timerfd files
 	flags:	02
 	mnt_id:	9
 	ino:	63107
+	size:   0
 	clockid: 0
 	ticks: 0
 	settime flags: 01
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 32f55640890c..5f2ae38c960f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -378,7 +378,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 {
 	struct dma_buf *dmabuf = file->private_data;
 
-	seq_printf(m, "size:\t%zu\n", dmabuf->size);
 	/* Don't count the temporary reference taken inside procfs seq_show */
 	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
 	seq_printf(m, "exp_name:\t%s\n", dmabuf->exp_name);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36..464bc3f55759 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -54,10 +54,11 @@ static int seq_show(struct seq_file *m, void *v)
 	if (ret)
 		return ret;
 
-	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
-		   (long long)file->f_pos, f_flags,
-		   real_mount(file->f_path.mnt)->mnt_id,
-		   file_inode(file)->i_ino);
+	seq_printf(m, "pos:\t%lli\n", (long long)file->f_pos);
+	seq_printf(m, "flags:\t0%o\n", f_flags);
+	seq_printf(m, "mnt_id:\t%i\n", real_mount(file->f_path.mnt)->mnt_id);
+	seq_printf(m, "ino:\t%lu\n", file_inode(file)->i_ino);
+	seq_printf(m, "size:\t%lli\n", (long long)file_inode(file)->i_size);
 
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
-- 
2.36.1.255.ge46751e96f-goog

