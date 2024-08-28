Return-Path: <linux-fsdevel+bounces-27493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE5961C87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E78285209
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC76813D24E;
	Wed, 28 Aug 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUBOuJ2i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A011C8BFC;
	Wed, 28 Aug 2024 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814227; cv=none; b=GxZmKVDPMmGj/rmpwqdt5pvX0HsqkVx6E8FlSDR4g64erOO0/dNzjUJQV88PFEd4YeXlRk+t5TJqPJxWQaN8GeFM9ppFCA+XwaNc+qYopV6BSO/tN3zs4NiU+yB/mmPAVaDOpV8VM0b58MP9vSO+RFLFo77uxLgG2bqgRiSWdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814227; c=relaxed/simple;
	bh=eO9Ix3cDnJp1QjWFcUiG7UEKoDBxWiAVcCPosvEyIKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxgVcqps7hac4NA9JyWNnvXuXPN/fRYWTdJC++qRvEXMvVlDzdRV5iNsh4xZbQnbffhiEAjRkGToNBmsDGY+jRd1587v4k0BMVz3dWd7GZWldyhXMnVAVM5HVbC8vJQbjmaS/7m1HdoAq4Gn29XU2C6w02AxwRn+dtfMxk3W4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUBOuJ2i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20223b5c1c0so56700165ad.2;
        Tue, 27 Aug 2024 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724814225; x=1725419025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dwC82d7KQL5pIEF6T6/bNHtBQAMogTq8DRZCJ210sw=;
        b=MUBOuJ2iO+3/ruxAgYLJpp5Lax6PhGENSOW8EZrQIxqWjCZXUYtAEpiBSzWneCdxEq
         wOHHjBgqEKhixXX1eU/5RqwniUnjWDBB5v1+6+HnIbIZTFWZP2SKrKeqQGleMNkRALOm
         IpAeTVjIcMEg1RLZjrSK3yEkwN5bBuJxo5uMpTSUTTwsDsZMiCspkCeBg/T59E0l3f3V
         yyZqi89MrCR1PEIW98XpCsK48J8vjTdHr3cTobd8CkLOs/IFta4pitILXl+JahVlPq8C
         d3NSH3liTy63UxzLTao0Sc57ghue6yeGij0RW2PQvCKLbG/+ufSkVcC7M9UO1vXZul+y
         IC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724814225; x=1725419025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dwC82d7KQL5pIEF6T6/bNHtBQAMogTq8DRZCJ210sw=;
        b=EUMJmlhpkIPvpqITsCqW4NhhSdmTlzeT6JVhqBqNX8qEUpTl6m9jXqDMNJTIT5sg4h
         W/1Z47evxf90vMgtNXHPCblldDTeOrRJk67/9k+YQDHK2eB6Qb7oZb+RFEUnufdaPCht
         aitPi1YBSgqEU5dQN1OWuSe+pYkZ4FWvgxHCLMTC9HJen+Eq5GOwF9mSk2Ry4OuoZvoY
         yx9rX+n0FnGxTobqgn0j0KS3gMfKqNVCA/Kek+ZGXTuk6aji1szGN8hyNiWh81bgsYSg
         e5GMamUTRzXDLcttYNLfQUsVPGdJkxwacKvFWr33Fw9r/vgXYs5I7RQXucz29W+DO0zn
         MeTw==
X-Forwarded-Encrypted: i=1; AJvYcCV6BlohGvgC07xann8Q0ZwPqog5V9hAJr5zt+Axu5xG6APi3FJ1QZjc405Ec+jAKUJ3TnJU@vger.kernel.org, AJvYcCVHAsbnIV7AdlAvnRQewozktlP6O2pWjSlsZrFQ9GFEWFDehD1iTxMKs/KxkGBfB4JI6Y5f0rM7tsiQMZwchcmZZP8o@vger.kernel.org, AJvYcCWSeshAYNVMcbPzyXNSr+euxWfUJah1nqNV7rX1eOrU08qqdc5tXYT25pTQyVPVMEu8sbZ/rQ3LOg==@vger.kernel.org, AJvYcCWXLaNZclytA79b5YnAsBGLZO6VEGKdf/5n4eKhDIuEp6py51NbHA2P89iGgZhM1QFOCDubmA==@vger.kernel.org, AJvYcCWbERGOA9UlFVq1zasIVjhgGY4po8rCo3NctGH0dvknDlQovE99I2IaK3IKSQz/QuJFSPXX65CC@vger.kernel.org, AJvYcCX5Z3QwHOHCw9txstSVwQc7w+7vo4UH7mTPPRUEbxbiGBc4F88oDl21jELGlx8T1kqMRkvmJvPCkTePvDbu0bA/QMZCAjCT@vger.kernel.org, AJvYcCXilUq/Yb1ImwJlgRTtHc9L2BjZSaPM7ce1bVRSHS096/OwrKB3+y0Ur/vLR4VyB8Bf4ZXw3CeviMevgSccYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1oZ10vU3dFrkSFZLjWweaVJobYB3PdrCM3iL9lHcoZ7/3hF/Q
	xL10bUwREH/XBB0IgLRnNIqzdMzBklYp4ULjgFRbzbrJYbHzrYLs
X-Google-Smtp-Source: AGHT+IEc8gy1oBP9Tt27kWFVV2/sdUfpEnu0CJVUYvciPK7kLGNgdrFqezJmS8xsximWyUWY+TcSOg==
X-Received: by 2002:a17:90a:d490:b0:2ca:7636:2217 with SMTP id 98e67ed59e1d1-2d8440a87edmr695434a91.2.1724814224691;
        Tue, 27 Aug 2024 20:03:44 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445db8f6sm317977a91.1.2024.08.27.20.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:03:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	alx@kernel.org,
	justinstitt@google.com,
	ebiederm@xmission.com,
	alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	penguin-kernel@i-love.sakura.ne.jp,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v8 1/8] Get rid of __get_task_comm()
Date: Wed, 28 Aug 2024 11:03:14 +0800
Message-Id: <20240828030321.20688-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240828030321.20688-1-laoar.shao@gmail.com>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We want to eliminate the use of __get_task_comm() for the following
reasons:

- The task_lock() is unnecessary
  Quoted from Linus [0]:
  : Since user space can randomly change their names anyway, using locking
  : was always wrong for readers (for writers it probably does make sense
  : to have some lock - although practically speaking nobody cares there
  : either, but at least for a writer some kind of race could have
  : long-term mixed results

- The BUILD_BUG_ON() doesn't add any value
  The only requirement is to ensure that the destination buffer is a valid
  array.

- Zeroing is not necessary in current use cases
  To avoid confusion, we should remove it. Moreover, not zeroing could
  potentially make it easier to uncover bugs. If the caller needs a
  zero-padded task name, it should be explicitly handled at the call site.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
Link: https://lore.kernel.org/all/CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com/
Suggested-by: Alejandro Colomar <alx@kernel.org>
Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbosf5wdo65dk4@srb3hsk72zwq
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Matus Jokay <matus.jokay@stuba.sk>
Cc: Alejandro Colomar <alx@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 fs/exec.c             | 10 ----------
 fs/proc/array.c       |  2 +-
 include/linux/sched.h | 32 ++++++++++++++++++++++++++------
 kernel/kthread.c      |  2 +-
 4 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 50e76cc633c4..8a23171bc3c3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1264,16 +1264,6 @@ static int unshare_sighand(struct task_struct *me)
 	return 0;
 }
 
-char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *tsk)
-{
-	task_lock(tsk);
-	/* Always NUL terminated and zero-padded */
-	strscpy_pad(buf, tsk->comm, buf_size);
-	task_unlock(tsk);
-	return buf;
-}
-EXPORT_SYMBOL_GPL(__get_task_comm);
-
 /*
  * These functions flushes out all traces of the currently running executable
  * so that a new one can be started
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 34a47fb0c57f..55ed3510d2bb 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_struct *p, bool escape)
 	else if (p->flags & PF_KTHREAD)
 		get_kthread_comm(tcomm, sizeof(tcomm), p);
 	else
-		__get_task_comm(tcomm, sizeof(tcomm), p);
+		get_task_comm(tcomm, p);
 
 	if (escape)
 		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8d150343d42..c40b95a79d80 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1096,9 +1096,12 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
-	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - normally initialized begin_new_exec()
+	 * - set it with set_task_comm()
+	 *   - strscpy_pad() to ensure it is always NUL-terminated and
+	 *     zero-padded
+	 *   - task_lock() to ensure the operation is atomic and the name is
+	 *     fully updated.
 	 */
 	char				comm[TASK_COMM_LEN];
 
@@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
 	__set_task_comm(tsk, from, false);
 }
 
-extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
+/*
+ * - Why not use task_lock()?
+ *   User space can randomly change their names anyway, so locking for readers
+ *   doesn't make sense. For writers, locking is probably necessary, as a race
+ *   condition could lead to long-term mixed results.
+ *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ *   always NUL-terminated and zero-padded. Therefore the race condition between
+ *   reader and writer is not an issue.
+ *
+ * - Why not use strscpy_pad()?
+ *   While strscpy_pad() prevents writing garbage past the NUL terminator, which
+ *   is useful when using the task name as a key in a hash map, most use cases
+ *   don't require this. Zero-padding might confuse users if it’s unnecessary,
+ *   and not zeroing might even make it easier to expose bugs. If you need a
+ *   zero-padded task name, please handle that explicitly at the call site.
+ *
+ * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
+ */
 #define get_task_comm(buf, tsk) ({			\
-	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
-	__get_task_comm(buf, sizeof(buf), tsk);		\
+	strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));	\
+	buf;						\
 })
 
 #ifdef CONFIG_SMP
diff --git a/kernel/kthread.c b/kernel/kthread.c
index f7be976ff88a..7d001d033cf9 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -101,7 +101,7 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
 	struct kthread *kthread = to_kthread(tsk);
 
 	if (!kthread || !kthread->full_name) {
-		__get_task_comm(buf, buf_size, tsk);
+		strscpy(buf, tsk->comm, buf_size);
 		return;
 	}
 
-- 
2.43.5


