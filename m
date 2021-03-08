Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17533142A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhCHRHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCHRH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:07:29 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B779C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 09:07:29 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c7so7783580qka.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 09:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=FELlWZu6ZUrIDop9zcwWE5SbsWsfE0sUJEQWoIVLbIQ=;
        b=hYb5lQauywPQTthGnoE4RKFrp2PzVO8/bodmVLivFY9uIrc0ODy++E4qhhdHSu4y6K
         dZHDkUAuYXDUShhlaRCWcxLaWDfF/E/pOwlJGCg4NTp/2bkHgnv9kIlt/QwIzwsE5+13
         bgDJ9dc0jdtWU++uQxU2xlJepDCqEdZ71TCHIn16n1euTkiJZEAY6rIwyceGqTHQsJVo
         pxRnC1ywWFrv5F3pW+s5rgk/mFLVdoHDpXSD8SAz5w09ivsHTsnN0kxuv8aB5pKCci3l
         SerOLJs2MINBSIBq5mli51VnCPCCoUm4EeNUdfeNGEmq64axFUPUpl0bKjOp6hQfVfiN
         vcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=FELlWZu6ZUrIDop9zcwWE5SbsWsfE0sUJEQWoIVLbIQ=;
        b=M27UY/rz7J3jc3BnwD+5VXnzOwrjkTJ5pJZnjUX7w6p1Bp51b5fGBVRqeSKbwwHXxd
         4JkdrID1qs43ny8377roY2ltYCmZwTxYYy4OeqFczQiYCgvkYvtw3KE7SGpyT4WVUOtl
         b6rvt0W5eJgL0s1vot2y339vBIfpI1NEjax/lkVzdBqJPTZdDwFesbhX2A66313Bz9Ht
         RMVCuBT1B8mSJyu0qnVdZn3UcVFWY1ey+l8Pa6M7pNgYzXq4soWw9seYGwa8TP9OEMM4
         a7zEY7w9dZJ3CSbn/lmGbY8ym0Q6M/NoRjhgvB9Qk7u0tgzT8XO6d6ZCbYtmJRzZb5kj
         ZC0w==
X-Gm-Message-State: AOAM532qMjJHi0lB6QOLe5/j/rNHxkxrz1ha6F2GhMYbUXJXv6i6Ww07
        YAv7d0yVS5CwwbRX+meRYKZCGKSK9x37hATchg==
X-Google-Smtp-Source: ABdhPJwQ1OG4X3NVtsMmrjf8jtl2/SSPlVWw8UmVa3aH/kv3pepByT4Cw0PoMXqlCni6TnfbCWlXnO3S2MqveaJ9Gw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:5144:: with SMTP id
 g4mr22172108qvq.26.1615223248223; Mon, 08 Mar 2021 09:07:28 -0800 (PST)
Date:   Mon,  8 Mar 2021 17:06:41 +0000
In-Reply-To: <20210308170651.919148-1-kaleshsingh@google.com>
Message-Id: <20210308170651.919148-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210308170651.919148-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [RESEND PATCH v6 2/2] procfs/dmabuf: Add inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>, Helge Deller <deller@gmx.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And 'ino' field to /proc/<pid>/fdinfo/<FD> and
/proc/<pid>/task/<tid>/fdinfo/<FD>.

The inode numbers can be used to uniquely identify DMA buffers
in user space and avoids a dependency on /proc/<pid>/fd/* when
accounting per-process DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
Hi everyone,

This a resend of the inital posting at [1].
There was no objections on the last threads, along with some positive
feedback from Randy. If there is no other concern I would like to
have this considered for mainline.

Thanks,
Kalesh

[1] https://lore.kernel.org/linux-doc/20210208155315.1367371-2-kaleshsingh@google.com/

Changes in v5:
  - Fixed tab vs spaces, per Randy
  - Renamed inode_no to ino, per Matthew
Changes in v4:
  - Add inode number as common field in fdinfo, per Christian
Changes in v3:
  - Add documentation in proc.rst, per Randy
Changes in v2:
  - Update patch description

---
 Documentation/filesystems/proc.rst | 37 +++++++++++++++++++++++++-----
 fs/proc/fd.c                       |  5 ++--
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 48fbfc336ebf..33d08fbb0022 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1909,18 +1909,20 @@ if precise results are needed.
 3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
 ---------------------------------------------------------------
 This file provides information associated with an opened file. The regular
-files have at least three fields -- 'pos', 'flags' and 'mnt_id'. The 'pos'
-represents the current offset of the opened file in decimal form [see lseek(2)
-for details], 'flags' denotes the octal O_xxx mask the file has been
-created with [see open(2) for details] and 'mnt_id' represents mount ID of
-the file system containing the opened file [see 3.5 /proc/<pid>/mountinfo
-for details].
+files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
+The 'pos' represents the current offset of the opened file in decimal
+form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
+file has been created with [see open(2) for details] and 'mnt_id' represents
+mount ID of the file system containing the opened file [see 3.5
+/proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
+the file.
 
 A typical output is::
 
 	pos:	0
 	flags:	0100002
 	mnt_id:	19
+	ino:	63107
 
 All locks associated with a file descriptor are shown in its fdinfo too::
 
@@ -1937,6 +1939,7 @@ Eventfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	ino:	63107
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1949,6 +1952,7 @@ Signalfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	ino:	63107
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1962,6 +1966,7 @@ Epoll files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1978,6 +1983,8 @@ For inotify files the format is the following::
 
 	pos:	0
 	flags:	02000000
+	mnt_id:	9
+	ino:	63107
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -2000,6 +2007,7 @@ For fanotify files the format is::
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2024,6 +2032,7 @@ Timerfd files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
 	clockid: 0
 	ticks: 0
 	settime flags: 01
@@ -2038,6 +2047,22 @@ details]. 'it_value' is remaining time until the timer expiration.
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
+	ino:	63107
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
index 6a80b40fd2fe..172c86270b31 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -54,9 +54,10 @@ static int seq_show(struct seq_file *m, void *v)
 	if (ret)
 		return ret;
 
-	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
+	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\nino:\t%lu\n",
 		   (long long)file->f_pos, f_flags,
-		   real_mount(file->f_path.mnt)->mnt_id);
+		   real_mount(file->f_path.mnt)->mnt_id,
+		   file_inode(file)->i_ino);
 
 	/* show_fd_locks() never deferences files so a stale value is safe */
 	show_fd_locks(m, file, files);
-- 
2.30.1.766.gb4fecdf3b7-goog

