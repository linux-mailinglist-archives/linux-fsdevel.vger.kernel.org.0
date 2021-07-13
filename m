Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A353C745E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhGMQXG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 12:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGMQXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:23:05 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF29C0613DD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id f203-20020a379cd40000b02903b861bec838so6022631qke.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=HlZhn8bTk7Pd8D2oO7XiM4H58gYs+uOuZUkKviKIe5c=;
        b=lEeIFPCbZcEdLqOlxsw0keXyepK2TwJ+pvFcQgkeb5yCsCNrj1FUavWgGzJow0Dq+T
         X/DVvLiu6lIGGg2eo49DV5QV35qv6D+5YZmEdhz4ofvT31fNHeX8Dr+KGQAt7Lcf/rnm
         t94uQY+wWlF75KQlaGYuqwTCdE4cUSL2cyASo4zi0kujXLF0domFlzelG+a33rnuKH0n
         2Hi2h+U6i6YCUXTLippwJMLP/oC89zXYiD7/FOUA08KEnHf0h50KAI+n48DC6PRvm/xg
         DB5LkyFOwQThOURkX3sPo5PbPVeMU6JtwwkETYKWdxwZjmUjyWWaWLc6ItkqtQ3cBE9B
         S1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=HlZhn8bTk7Pd8D2oO7XiM4H58gYs+uOuZUkKviKIe5c=;
        b=Y8k3tsIonKLNVYuq7V0kNRoqmuHc6Hvcuth2yLHHOML7VfDUR7TtLEg2F2w3gOdBZW
         aYmVKsA5GnGI6McHtQjo7p4WY9Khzi6kdQ94iUsrZ/4/XYG5bg/h8xul70RlFLOXzK6e
         jyhkL20Lhl93ibhrJUJj/3jwBP8IW5pnbEnn9uYze9/HO/JGAIAmf+l3x0c9ub7ikh1p
         uSF2e654GUXo/NwkBiSUFmgDfjvjEbrHQ5HsgVpPuL+4Ch57CzNduyjcytUKvBY9HOo7
         2RgGrhE/10hhtKn7BNWdMBO545QkZ7ld7UowMmV8/EekOCaIGZEQlVgvuiQy6pxCaM0p
         27iA==
X-Gm-Message-State: AOAM531KVn+QO73Go5cHROWuLJjvZ01ZOHAMVPsa632Kky6vXtlRX2nA
        EZqCEdrffUhGJiU5WrMkxH4BlAg7x5vcplUUYw==
X-Google-Smtp-Source: ABdhPJwJwl1gRPx7HaxMVEbUQEMwr3jFEiYvlA0zbxFpgeI1hiPNTyGYNiacGzlsWjvdarKrouD6D1O8cvZHwKfmdQ==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:9e49:: with SMTP id
 z9mr5562386qve.52.1626193214017; Tue, 13 Jul 2021 09:20:14 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:20:04 +0000
Message-Id: <20210713162008.1056986-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] procfs: Prevent unpriveleged processes accessing fdinfo dir
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     hridya@google.com, surenb@google.com, ebiederm@xmission.com,
        christian.brauner@ubuntu.com, torvalds@linux-foundation.org,
        christian.koenig@amd.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file permissions on the fdinfo dir from were changed from
S_IRUSR|S_IXUSR to S_IRUGO|S_IXUGO, and a PTRACE_MODE_READ check was
added for opening the fdinfo files [1]. However, the ptrace permission
check was not added to the directory, allowing anyone to get the open FD
numbers by reading the fdinfo directory.

Add the missing ptrace permission check for opening the fdinfo directory.

[1] https://lkml.kernel.org/r/20210308170651.919148-1-kaleshsingh@google.com

Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
v1 of this patch was posted at:
https://lore.kernel.org/r/20210708155647.44208-1-kaleshsingh@google.com/

Changes in v2:
 - Drop the ptrace checks from read and lseek ops. The problem of accessing
   already opened files after a suid exec is pre-existing and not unique to
   fdinfo. Needs to be addressed separately in a more generic way.

 fs/proc/fd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 172c86270b31..913bef0d2a36 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -72,7 +72,7 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
+static int proc_fdinfo_access_allowed(struct inode *inode)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -86,6 +86,16 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 	if (!allowed)
 		return -EACCES;
 
+	return 0;
+}
+
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
 	return single_open(file, seq_show, inode);
 }
 
@@ -348,12 +358,23 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 				  proc_fdinfo_instantiate);
 }
 
+static int proc_open_fdinfo(struct inode *inode, struct file *file)
+{
+	int ret = proc_fdinfo_access_allowed(inode);
+
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
+	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,

base-commit: 7fef2edf7cc753b51f7ccc74993971b0a9c81eca
-- 
2.32.0.93.g670b81a890-goog

