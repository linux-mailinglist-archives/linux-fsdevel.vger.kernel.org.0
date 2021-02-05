Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8173C3113A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 22:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBEVf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 16:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBEVex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:34:53 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4532C061794
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 13:34:09 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id ew14so5987744qvb.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 13:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=8MAy8AaN6ZS5Avy4E0Q7L68GZ02PGsx9JgCkTgKoHNQ=;
        b=WnliLim5ZvWL9ZBmepw0MTbma5fCSUQs19cvbXGTo+LnqW1tu36qu/K4HvniKmFTjd
         o/nv5QHpFhvC1eCslPC0jr1VAqkMPdVYGLNyfvhw7JiuBUz0u4i6PkS0c67rvgIQYiBO
         g5+n6GO294I+aASt6Okdy9Y9hDftPtnxffwm4veUH2aPdEe1/mbXdiZO0+1PytM4wtcZ
         4SBS8PoKpJ2a5KG8d3InFVtCAvi162x32ueOqd1DR2iJ9rUXtXQWvryG0yK/b9Gg8CUZ
         F9LvfX+RVQiieanUmyi8TtjNs5RuLFq2g/8ltJvxdZrRvjYSm0t4RNN5SN+xVXeIeXlV
         d4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=8MAy8AaN6ZS5Avy4E0Q7L68GZ02PGsx9JgCkTgKoHNQ=;
        b=haGpAfWmV7REO9pByO03ZIM1bKS9FkCeNoJ+HzbbwZwc3VF45SQZ7adQiEl6efbEYy
         6HlbE2AQlwitX50HzGW5qK4Rg/mDW/BBjMFHGdbDZlOXuaYRUry6HFhlPiul8uZFRZa8
         O0r4fAgLZ5V8naVvYwyiqYekIrZLfBb0lMFcJVaoLmuXvYmDt8Yyz3p754fo1QsR8hoT
         8QVqRh3Y+hZavMSNb/HgtkhV0VTyGMEGTUqgr5eQZb/RoWCWIjqQPQwNNt6LYQAv1oGV
         EUhxpRyHBm41KJbbXNJpkiSCApeuo180ZpQajww2GgPi/Ws6ijkszK2g3CAS1EbYbqrI
         g2ig==
X-Gm-Message-State: AOAM532NmNSrcUbn15jqoy8S72U1FvzFKIQD76CxbxD0G6Tsf5GmM17Q
        9uBxif5TOWy6YFl71mUp5CosYvf42XktsXM3hw==
X-Google-Smtp-Source: ABdhPJy5Phpkm8UmSoQT/cka7X8jy/KGgS1Wrb3leZpBdapsYf0YaqsduncqfY+tg1G+WZk5ym5FvVPgD1lNua+NiA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:486c:: with SMTP id
 u12mr6427106qvy.5.1612560848833; Fri, 05 Feb 2021 13:34:08 -0800 (PST)
Date:   Fri,  5 Feb 2021 21:33:44 +0000
In-Reply-To: <20210205213353.669122-1-kaleshsingh@google.com>
Message-Id: <20210205213353.669122-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210205213353.669122-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And 'inode_no' field to /proc/<pid>/fdinfo/<FD> and
/proc/<pid>/task/<tid>/fdinfo/<FD>.

The inode numbers can be used to uniquely identify DMA buffers
in user space and avoids a dependency on /proc/<pid>/fd/* when
accounting per-process DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v4:
  - Add inode number as common field in fdinfo, per Christian
Changes in v3:
  - Add documentation in proc.rst, per Randy
Changes in v2:
  - Update patch description

 Documentation/filesystems/proc.rst | 37 +++++++++++++++++++++++++-----
 fs/proc/fd.c                       |  5 ++--
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..db46da32230c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1902,18 +1902,20 @@ if precise results are needed.
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least three fields -- 'pos', 'flags' and 'mnt_id'. The 'pos'
-represents the current offset of the opened file in decimal form [see lseek(2)
-for details], 'flags' denotes the octal O_xxx mask the file has been
-created with [see open(2) for details] and 'mnt_id' represents mount ID of
-the file system containing the opened file [see 3.5 /proc/<pid>/mountinfo
-for details].
+files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'inode_no'.
+The 'pos' represents the current offset of the opened file in decimal
+form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
+file has been created with [see open(2) for details] and 'mnt_id' represents
+mount ID of the file system containing the opened file [see 3.5
+/proc/<pid>/mountinfo for details]. 'inode_no' represents the inode number
+of the file.
 
 A typical output is::
 
 	pos:	0
 	flags:	0100002
 	mnt_id:	19
+	inode_no:       63107
 
 All locks associated with a file descriptor are shown in its fdinfo too::
 
@@ -1930,6 +1932,7 @@ Eventfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	inode_no:       63107
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1942,6 +1945,7 @@ Signalfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	inode_no:       63107
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1955,6 +1959,7 @@ Epoll files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1971,6 +1976,8 @@ For inotify files the format is the following::
 
 	pos:	0
 	flags:	02000000
+	mnt_id:	9
+	inode_no:       63107
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -1993,6 +2000,7 @@ For fanotify files the format is::
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2017,6 +2025,7 @@ Timerfd files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	inode_no:       63107
 	clockid: 0
 	ticks: 0
 	settime flags: 01
@@ -2031,6 +2040,22 @@ details]. 'it_value' is remaining time until the timer expiration.
 with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
 still exhibits timer's remaining time.
 
+DMA Buffer files
+~~~~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	04002
+	mnt_id:	9
+	inode_no:       63107
+	size:   32768
+	count:  2
+	exp_name:  system-heap
+
+where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
+the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 585e213301f9..2c25909bf9d1 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -54,9 +54,10 @@ static int seq_show(struct seq_file *m, void *v)
 	if (ret)
 		return ret;
 
-	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
+	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\ninode_no:\t%lu\n",
 		   (long long)file->f_pos, f_flags,
-		   real_mount(file->f_path.mnt)->mnt_id);
+		   real_mount(file->f_path.mnt)->mnt_id,
+		   file_inode(file)->i_ino);
 
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
-- 
2.30.0.478.g8a0d178c01-goog

