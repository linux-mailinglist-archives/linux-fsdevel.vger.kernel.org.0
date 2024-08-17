Return-Path: <linux-fsdevel+bounces-26161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B22955501
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627721F22C06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F806F067;
	Sat, 17 Aug 2024 02:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Ha9Omc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E050271;
	Sat, 17 Aug 2024 02:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723863420; cv=none; b=J6BpkllxqmYxjTnnBGlM5KVDi3TzTpJM0JPvOmgn9kXASfkyZnklxY90TB0aK5ugnqIoIqVpY1dTLsoEcuu0VZedlxO3IcjEtEIIJOaGhlGiQ27OuhpX89WT/GxKfHIbukBVu95cnDhrSo84BotwRknj0+BgERNdK+vSgbgi9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723863420; c=relaxed/simple;
	bh=Xc48Dtsjc3B8gzJAbU2ndnDycZyc8K+FcRb6CqedFFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RriKg4XF4l4CJ6pshP6vsse2tJNO+zaeb7WeBbW7KZ98ajklR865XEz/ITJw/VMOYOi79K2J1mWtgi5GXRuPbaQK5sqiwg8x2eppS6PatiLqMEsQRo45TH6q2EJpHqJftXqJft6IjpZrzywdUemf2BKSv+XFFI0Bss5zREkbYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Ha9Omc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd9e6189d5so23703725ad.3;
        Fri, 16 Aug 2024 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723863418; x=1724468218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSXeW14jggb39wKxD5hCG2hdCk95xYh67NieDdymzHU=;
        b=k/Ha9OmcEQJjfEn1YJQHe0NoH1aoZSpWmFs8uYVaKjpN4j9KdLKLKXFZB9vFx31Pc1
         JMvpvayCKdWn23oZv0BHI+NQIikyQphSzWoqpV36OSG7PtvWfKcXztxRfAenXDic5P7e
         Fsqsr8nW78aWiJE7T5d44OkUxkinl4gjh2KFaLiKP++8SGe0o4VEAVLyEdRVJWbqVI8J
         WNuy0EYOz4jg2EXY0rmHgox9Mtng4wuA76ZGnJMxYFUbi1KeXfGTZvRQ6IIm5GBuIqA3
         Cns+/R8MiRPVHnZVznC2vJHnLlGk/pH5gaiXm2NzMs0255mVkXHnqTlb4hHpEbuCJOqr
         FrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723863418; x=1724468218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSXeW14jggb39wKxD5hCG2hdCk95xYh67NieDdymzHU=;
        b=lzgcw+E+afR07zLJdfrg+qw88pUwS1GmIq+E17bQG1BZPbQNcAgC63+X78ReoOaBOl
         0t4L1rZaCIdaOCA7qQ7z/1BX/mb1CHgjp0bw3uHDb4H/mbXoLp+Q6zPmh0LtYeu4eGbk
         Xv3rInujCIDMNzgEuVRpf5pm9YLE5ClUNjQA0GOjfwFDz7WtPgVltshOwV9Yjom5JM06
         RzlcSofzU+rBtZ0X0rgo66ndh+qR1eSmSLfgO7aAGY15QwK+/i2WtsfJqmAbgnha08A6
         T0DINdfwblMlZ9DI1jSnuT0J6/muuDpiVzqwbetezGAm2h9FmzAQLhBxbBSdshiI9FjD
         cFbg==
X-Forwarded-Encrypted: i=1; AJvYcCUSDQBVt5kZN1IuZjeJMIjBCvXOWWJfUXenz0UydK7HV02IXuNtJL3+S05yQf0kKR0kXGGud9no4K+sAH9bLJIplVLZ6Z8oRwEm1VXR0ynn8Ax5XmZPsvFm8CugdjA+KJLiuC4keSao3kLC5R6VE0kp5AtHVmxFH0TW+/Ts8OQKkrVbmMt9YhbHFhH3DPzH52X0rAc/IultOlTRFZy8VOHYNP4R3MQ+sAoY0psjKbujWc2eBMg0FviLH2wiUgzfVBa6NC1FmoRvuiEjM9GAJg6p5inP+nOtn+pc6uIaCBrDKmrLK4SpZZE6naJcdvtvvtZnqFLwLw==
X-Gm-Message-State: AOJu0Yye5EUvF3DfnDRRNl7GdKdvngB+Ar6YB/SXONHe1taHsRJXWSY+
	okcBdyQL+XBLq0K3GLjAWjTKKrbfOGjcJUnkRin4tp6FHytpbuTx
X-Google-Smtp-Source: AGHT+IFVf7h2xaEBLW2CupHL7L7C8Pe40CvC/Mw6eEkJQnE3Swhf1+Ors/i9DDP0sM5dBvy2264FSw==
X-Received: by 2002:a17:902:f54b:b0:202:37:f721 with SMTP id d9443c01a7336-20203f454fbmr48859335ad.57.1723863418122;
        Fri, 16 Aug 2024 19:56:58 -0700 (PDT)
Received: from localhost.localdomain ([183.193.177.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm31801785ad.94.2024.08.16.19.56.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:56:57 -0700 (PDT)
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
Subject: [PATCH v7 1/8] Get rid of __get_task_comm()
Date: Sat, 17 Aug 2024 10:56:17 +0800
Message-Id: <20240817025624.13157-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240817025624.13157-1-laoar.shao@gmail.com>
References: <20240817025624.13157-1-laoar.shao@gmail.com>
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
index a47d0e4c54f6..2e468ddd203a 100644
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
index 33dd8d9d2b85..5f1c8a58bb76 100644
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
 
@@ -1912,10 +1915,27 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
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


