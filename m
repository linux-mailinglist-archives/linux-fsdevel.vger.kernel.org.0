Return-Path: <linux-fsdevel+bounces-25615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776594E4DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 04:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA847B21274
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 02:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E568121B;
	Mon, 12 Aug 2024 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcq78NXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A881E;
	Mon, 12 Aug 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429838; cv=none; b=A7WJH9MEmODJn2OWO6aqR7WAJjQpjpXtzVdBhEf2FVfkgfugHinZYqHLaep3pQ6NuJq9r84hFG5nnatI61jZWdu1sFAXhQ9q+AStIQnEmFHfq9zmsZZEu6aNvbQX9ua65Cgx96nlbkdq0p31/jDPChFfIbQ8DC/OawBcNhBag4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429838; c=relaxed/simple;
	bh=OtCu8tCLyJLMIEL9JGTrh8+dXoRUm59kHwmUusfOtKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z57MeeZ04yDL3JPyVaHBRRipd8dOdYLtSVABZswWCZs0XF4xDtyp8phkgrDH3mOsEHY4D2JXTN7ZCSzX15yo/X4RF9leWgRx09xN9Gc9HkH96qKlrcLIgR1/NJ0dwWc4EIro0mm+Sg9mw0lVxvjyB//lT5XuF2G9i0HEjzaAxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcq78NXS; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7bb75419123so2512622a12.3;
        Sun, 11 Aug 2024 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723429836; x=1724034636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khhjXbPZMt7GBHDJwocHjgjVouiC9Zx1GPF6Kpp8feU=;
        b=Zcq78NXSk3Y2x0tkF4TVF5oppcstgDdsM1XcvIPwG5kr2OiUyNa7FKraXpdEPgSisO
         0wsI/sSVJeBHLD4nENE5Ci65L4YomaUkJ2vY69aTQL5jx+mPVbJlzd9QFExczl7lfEuk
         tggcZ930r5EPDk625vS/Gbru+c8obwW/R2LKjvuAcJD27r/jShx455hCfvLVa92eQON7
         1/iug/sq1k+aPZe3jPBOJXWr8JNC0EoLk91LdOHkznqpYfG23PyxEleyh2/zhAyYo4KN
         2wekbOXrWpI5QTmayoAkIqzFMm6lsAONOW7VxvMqLqXblWZ+rNeeqqZImw0VYh3N+z9e
         25SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429836; x=1724034636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khhjXbPZMt7GBHDJwocHjgjVouiC9Zx1GPF6Kpp8feU=;
        b=Mbgxc2iinTdP0OCnni3nkIz3Cc8SLRcZWTvjAb1io+ibR2OEtO3aIljZjtpQaFVoR/
         UI+CJCO8t4N8MBtfncKrLmIQTUBK5ZxtIa2kYOb8fRYxCFwv/0gs7L9bq8DBxQIr9M0G
         UfqkN0kpJTGUHUUU9WfOfaVglwXmhIUPIe864GtosNmOEPkxOHpFUdAS9lZ9FZiKmR+c
         4nzdR2Yyz6P5HOPK/7LvXLuWGTnsQGZloZEShRRLdXFErXAYN+G1fzl5CPfn4/CN3FEe
         hftcfvpwTBlcUIXSfb3CA7VtIMwAj6LX7HJnQr7axEces7crlizZg4ujYimDQoxD9DPq
         Y5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVlwaF7NxQAqjTC+U2nP+hYwP2Tw6VO+MZGJeTbWF39jplsek8lXfmC6wZbAJysQtqu5JKj5yv73Z6SFFxHgBPyTe65WdI1boeO5syEjJfuj15qQ7EjIn130W58dpBHIlG7EOOHcX7Hl+vyb0ixFRUbN+Vc1QJ/xXWJbz4UJZm6Ry6CmafUgkn/Igt2BileMgx1zuPYo8XDUrdaDJ5dPVqaAppFDrsxNjt9kQrfwknpxYE7Selhk0V+bzkp4cWHpl4PRTL8DZR1yjpEdpRdW5npGOlXA2eFAeFchWG9LyN6ejE5EsTvLMV94Ond8da3qMuXv7nqKA==
X-Gm-Message-State: AOJu0Yzmf1LMm702JKGqwUP4PQCu38LHUM8UuGvN/RangnnJGGoHK5/0
	SHwOU/yr4MAHPCdXUMHHe5IsKdb0oqA+RmynoJXD0tp6D++MTLdi
X-Google-Smtp-Source: AGHT+IHZ0gPVVBMqlR8AM+LuQyCNFAmVaej1h0WqXQaGCWBBgBWQLJgV4NwTDuyMDp98EgrIiW/RCQ==
X-Received: by 2002:a17:902:ce83:b0:1fb:3474:9500 with SMTP id d9443c01a7336-200ae56b418mr67022635ad.27.1723429836312;
        Sun, 11 Aug 2024 19:30:36 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb9fed69sm27884765ad.188.2024.08.11.19.30.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2024 19:30:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
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
	Alejandro Colomar <alx@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matus Jokay <matus.jokay@stuba.sk>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v6 1/9] Get rid of __get_task_comm()
Date: Mon, 12 Aug 2024 10:29:25 +0800
Message-Id: <20240812022933.69850-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240812022933.69850-1-laoar.shao@gmail.com>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
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
 include/linux/sched.h | 31 +++++++++++++++++++++++++------
 kernel/kthread.c      |  2 +-
 4 files changed, 27 insertions(+), 18 deletions(-)

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
index 33dd8d9d2b85..e0e26edbda61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1096,9 +1096,11 @@ struct task_struct {
 	/*
 	 * executable name, excluding path.
 	 *
-	 * - normally initialized setup_new_exec()
-	 * - access it with [gs]et_task_comm()
-	 * - lock it with task_lock()
+	 * - normally initialized begin_new_exec()
+	 * - set it with set_task_comm()
+	 *   - strscpy_pad() to ensure it is always NUL-terminated
+	 *   - task_lock() to ensure the operation is atomic and the name is
+	 *     fully updated.
 	 */
 	char				comm[TASK_COMM_LEN];
 
@@ -1912,10 +1914,27 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
 	__set_task_comm(tsk, from, false);
 }
 
-extern char *__get_task_comm(char *to, size_t len, struct task_struct *tsk);
+/*
+ * - Why not use task_lock()?
+ *   User space can randomly change their names anyway, so locking for readers
+ *   doesn't make sense. For writers, locking is probably necessary, as a race
+ *   condition could lead to long-term mixed results.
+ *   The strscpy_pad() in __set_task_comm() can ensure that the task comm is
+ *   always NUL-terminated. Therefore the race condition between reader and
+ *   writer is not an issue.
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


