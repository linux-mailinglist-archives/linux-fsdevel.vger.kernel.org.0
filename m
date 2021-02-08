Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A431389E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhBHPzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhBHPym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:54:42 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF977C061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 07:53:29 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id h185so2839834qkd.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=VNkssNQYUElZc56HZgHGuABEHCbKr0AEJNaGESsvZEs=;
        b=H+4JBdFy/5t4gOFYNbXNEDf501AK8VEP8sQR7gQWwKdaNYjC4Q0guRWbyS9dF+fCmv
         0xV/bunq8nlf0zuHa0KBuh8FjTveHknGX8+GAhRxwNuMf0yBUJhwlFHlVPj6zavXLwDZ
         EHrBgWITz9Jtjeq1/zVDaoaz2TLgHPrt7wJ6rbKhBp2pyM0iXOVGXheCTOZyqAvKXykH
         voIUv1NPNrQ2EhzjWZnDr0LXQ5VKsFut7HIn5bG3706T7GZaHIJh1cyVC/yrwZnUcfKw
         E3KRvrZb+n5TznzCe7ey+Yuug5BV9wEIYu8NQ1Iw/nZB7lbeqUFy2lWbv8NnjpCzvHeA
         0ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=VNkssNQYUElZc56HZgHGuABEHCbKr0AEJNaGESsvZEs=;
        b=Fh0xj+auOnUVB9MRctI8Na3G932Atba63CMFeecB2wGts4OIY016p4VCJUxyDCdrVh
         WHyILpzg7/zHDyBubrSozANyPi5SuioUvHsk5tZYxmRenjNLn0K+QJ4gjysMYA8lzX2E
         +TvIt/pDIj00QWxkdpOdvTnN+38yhDzfq2nHlwuVEDUh9XQAafICMrYiWS9bH/oj4boi
         5MmCfqabq0krcP4AgWo86q/J9Wp5LzkyTZyjRGV+56wrTRWo1FW1+tbYM5Fi5zJ6ULSj
         rInmU/2IJp/ib5HzGZWnxkuHzTfCs/jJ3cmPVCJq3MrHfsfp5KWBcT37micY4Fz28QWN
         RW+Q==
X-Gm-Message-State: AOAM533/PbNOszpHYArFJ+k0/A/x9+/lvo5Ux3GKFTtWoNfKH1mkG37I
        Qh1VSNFptvU3otchanjHYDZaKRhgIgeS+1fm5g==
X-Google-Smtp-Source: ABdhPJwju86cKM910it9Ni+O0XsvDOKiYv9le9dIGYsPnhL4wFUvPSedku+WxXAN+XhtB3VU93yjgtMoNm8NPNE/ig==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:c687:: with SMTP id
 d7mr16336589qvj.17.1612799608742; Mon, 08 Feb 2021 07:53:28 -0800 (PST)
Date:   Mon,  8 Feb 2021 15:53:07 +0000
In-Reply-To: <20210208155315.1367371-1-kaleshsingh@google.com>
Message-Id: <20210208155315.1367371-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210208155315.1367371-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v6 2/2] procfs/dmabuf: Add inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        rdunlap@infradead.org, christian.koenig@amd.com,
        willy@infradead.org, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Anand K Mistry <amistry@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
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
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
Changes in v5:
  - Fixed tab vs spaces, per Randy
  - Renamed inode_no to ino, per Matthew
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
index 2fa69f710e2a..7730d1c120e8 100644
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
 
@@ -1930,6 +1932,7 @@ Eventfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	ino:	63107
 	eventfd-count:	5a
 
 where 'eventfd-count' is hex value of a counter.
@@ -1942,6 +1945,7 @@ Signalfd files
 	pos:	0
 	flags:	04002
 	mnt_id:	9
+	ino:	63107
 	sigmask:	0000000000000200
 
 where 'sigmask' is hex value of the signal mask associated
@@ -1955,6 +1959,7 @@ Epoll files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
 	tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
 
 where 'tfd' is a target file descriptor number in decimal form,
@@ -1971,6 +1976,8 @@ For inotify files the format is the following::
 
 	pos:	0
 	flags:	02000000
+	mnt_id:	9
+	ino:	63107
 	inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
 
 where 'wd' is a watch descriptor in decimal form, i.e. a target file
@@ -1993,6 +2000,7 @@ For fanotify files the format is::
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
 	fanotify flags:10 event-flags:0
 	fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
 	fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
@@ -2017,6 +2025,7 @@ Timerfd files
 	pos:	0
 	flags:	02
 	mnt_id:	9
+	ino:	63107
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
index 585e213301f9..822efd20b922 100644
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
2.30.0.478.g8a0d178c01-goog

