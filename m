Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11394240806
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgHJO7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 10:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgHJO7P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:59:15 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE24C061787;
        Mon, 10 Aug 2020 07:59:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so5006804plz.10;
        Mon, 10 Aug 2020 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9ANqD1SHthCWhjAN+oUkgPbsB9QxwwtNBqjFnceaq8=;
        b=g+tH9zFTraAvqoYMnKdnrb7hRM0x6oGDZ9FV2iYf31Fn4qA7UVi9xR8djova0Sh1W2
         02Q6zpC5GlKAw5+CLMgM1xTSmCXEy/3jynABl4DoqPT1qDGu6FAGwJqgjLTpXM7kIXj5
         eMoGKsLmQnmRoQMG8rM+/Dc5ke7QJtamjx38XFBBUJ+iNQosVIFPKZdT0i50uAFFUbeN
         YYJaRyega+Vt1Mohi0DtO1WU4SdlbUvtdscxCbRg1M0r+uKjPp9xrL1HkDpr24791Qo2
         mT43G1ewfcIyN5zf0oAhM85vX1gY8LM1yPL/7jFhu5RY+p4Jjt2plhyaxFhukoOXkZF4
         19eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9ANqD1SHthCWhjAN+oUkgPbsB9QxwwtNBqjFnceaq8=;
        b=A3fwVxJFoUZX8YGMZFpaK9K/J1H+voLMjv7e4TvWMqCKnLyuwiSbQ9kKJ+/pIHgj7Y
         ut3AK64hgGIfJjDp5E6HVzCf2/IbM2FnTAJ2efOfPO4dBW5KSN5UhwpxPNBidiwUZ838
         RwTSKdQ+PWS5VmcC5znt+MVHZhSU9xWLPPoa3YPjFQ8oyHdpHDTOte9g7xmS2J8Z4ZIp
         BIh7PkFAHmwpQogu9EeyiKbzOHpJF/cJQaqaFOIw6SkxyQc6qjfieJ0Q7KUDlPNUGcxz
         ntgt5/kn518MxoQtHWoHvv0NTLQmC79BQJHoQBeWlt1OuodbBnmLZK+O+AJPxkuozLIF
         TDCQ==
X-Gm-Message-State: AOAM533JzGRzzIb/T3f5/2RrHLGIsmeU+/wKU9OUje/Ilx6C70O3toQL
        1qoNwpWFlYXmXJGmS8yc/vVpToMHS8Y=
X-Google-Smtp-Source: ABdhPJyG1x70qGUPKTM3nyeJWwLc0QtgduyTRoBs995n1XWXNoigT0mWbpM2bEuLwWO9rF8ZpGX1YA==
X-Received: by 2002:a17:90a:640b:: with SMTP id g11mr14898731pjj.176.1597071552501;
        Mon, 10 Aug 2020 07:59:12 -0700 (PDT)
Received: from localhost.localdomain ([124.170.227.101])
        by smtp.gmail.com with ESMTPSA id o192sm25631162pfg.81.2020.08.10.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:59:12 -0700 (PDT)
From:   Eugene Lubarsky <elubarsky.linux@gmail.com>
To:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com,
        avagin@gmail.com, dsahern@gmail.com
Subject: [RFC PATCH 5/5] fs/proc: Introduce /proc/all/statx
Date:   Tue, 11 Aug 2020 00:58:52 +1000
Message-Id: <20200810145852.9330-6-elubarsky.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810145852.9330-1-elubarsky.linux@gmail.com>
References: <20200810145852.9330-1-elubarsky.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gathers info from stat, statm and io files.

The purpose is not so much to reduce syscall numbers but to help
userspace not have to store data in e.g. hashtables in order to
gather it from separate /proc/all files.

The format starts with an unchanged stat line and begins the
statm & io lines with "m" or "io", repeating these for each process.

e.g.
...
25 (cat) R 1 1 0 0 -1 4194304 185 0 16 0 2 0 0 0 20 ...
m 662 188 167 5 0 112 0
io 4292 0 12 0 0 0 0
...

Signed-off-by: Eugene Lubarsky <elubarsky.linux@gmail.com>
---
 fs/proc/base.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 03d48225b6d1..5c6010c2ea1c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3944,6 +3944,31 @@ static int proc_all_io(struct seq_file *m, void *v)
 }
 #endif
 
+static int proc_all_statx(struct seq_file *m, void *v)
+{
+	struct all_iter *iter = (struct all_iter *) v;
+	struct pid_namespace *ns = iter->ns;
+	struct pid *pid = iter->tgid_iter.task->thread_pid;
+	struct task_struct *task = iter->tgid_iter.task;
+	int err;
+
+	err = proc_tgid_stat(m, ns, pid, task);
+	if (err)
+		return err;
+
+	seq_puts(m, "m ");
+	err = proc_pid_statm(m, ns, pid, task);
+	if (err)
+		return err;
+
+#ifdef CONFIG_TASK_IO_ACCOUNTING
+	seq_puts(m, "io ");
+	err = proc_all_io_print_one(m, task);
+#endif
+
+	return err;
+}
+
 static int proc_all_status(struct seq_file *m, void *v)
 {
 	struct all_iter *iter = (struct all_iter *) v;
@@ -3960,6 +3985,7 @@ static int proc_all_status(struct seq_file *m, void *v)
 
 PROC_ALL_OPS(stat);
 PROC_ALL_OPS(statm);
+PROC_ALL_OPS(statx);
 PROC_ALL_OPS(status);
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	PROC_ALL_OPS(io);
@@ -3980,6 +4006,7 @@ void __init proc_all_init(void)
 
 	PROC_ALL_CREATE(stat);
 	PROC_ALL_CREATE(statm);
+	PROC_ALL_CREATE(statx);
 	PROC_ALL_CREATE(status);
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	PROC_ALL_CREATE(io);
-- 
2.25.1

