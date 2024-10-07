Return-Path: <linux-fsdevel+bounces-31198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BFF992FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8631F21189
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C111D7E21;
	Mon,  7 Oct 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlzFkGkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3521D416B;
	Mon,  7 Oct 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312587; cv=none; b=CGnYxb47i6nYsaDBr95Z/k2F2I+yT+f+bZjDEOGUySL53hIa8h2LStlhhuoPy407nCSZ8KeyYy9xZ4pQkQfB0nFtrQejTad0Q184iWTOmESvPCeZ5LWqwM2x5pqU+vGAuHyC5o9ViBxO2ehgdaNtbJVYI+fuzhyiLrGezHd5bGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312587; c=relaxed/simple;
	bh=LdUzXXQ8w1cxGk6eZCeHPTjeQKYbvyuMc5IN1L2pmJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeU9+altLSeXwZWE7UrUArURfQiy+g3xrfr9eE/0BCjquCLRIo5ls1xusx2DlcpF/5owqARXC2TsFaSNrDe8ufPDT2oTmMTyPyuabZ00i2uR57VZ0f4TwvfNevqYqxb5LHYxl1qv75CXtregUyWWPFnTTXJ0moInf6ARt+Wb3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlzFkGkc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e02249621so748973b3a.1;
        Mon, 07 Oct 2024 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728312585; x=1728917385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVEk6SmaURyo42RvRGYBr53delaAcBEjfSHuuD+Cst4=;
        b=GlzFkGkcVK0yU5uGVoyoDHvqoGswNz3QeNvFmV9+B3ta2Z1Fe1+Zz37tMI8E+btu93
         DOq1Vakzmk57N7fk8V5TIFfEUAhrTqvTURA4yofAFzm9sdhi+czR7WfEX3uFHKgpaEE/
         SNzKSoE7CiRsZqD9CI0x7UoiI9AW2al0WfHhfhu6/kRAjZo+UrtX65ThklzWpQ0cM9u6
         QnlOePALakfWc8J4z4toK5JmfCPbyq4rNk7I7OyFiGMOaI4jgbykZ8LBUoHECXAKmmc2
         AdWit+UniSXgsdXKkdNoqF0Zlw4PpwJc9SLwjgok1FK4hYmrsLZoe2pFrU2T8bs+8spT
         R9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728312585; x=1728917385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVEk6SmaURyo42RvRGYBr53delaAcBEjfSHuuD+Cst4=;
        b=qjeZ67pqOXMAFwIH/H0ejCayzJshrT1bo97wIbvGY8n4J5JmsyMMFiq4VvGgjctKor
         TQdNLwja3Gas8YVlBzZOu7V699Tu1FYyugmTnt/HNz4RdryB0GO1nqXgsWG2dJu35740
         1+0ZQflmYzIErH1Dacc8HpWgw2Bx8+rAhRPxbZs66QQ9PKaz+40QDDo6WnlmfXI2lG96
         WYZ0Id0lNis9Ivp/G0TcOt+80fU4oUI7YaLllBJrZotpj4Ec/JljTtJ5RXod6MPco8m5
         jEssgLl00DOuSu7Zv6bNvoJSbpz0DOpe93+mE7YuXUG0l4KIktIyleXnc61iSVNnZkE7
         9KTA==
X-Forwarded-Encrypted: i=1; AJvYcCU40V3TXsQNomPZeLtiq9By+KEviFuxVA7SgADQRK/pNC1vEzJ00K7iLzufzT7w1JvMd55N5rwTCRH5mSUXAzovJhpMdsY3@vger.kernel.org, AJvYcCUGx+b/xyJviZs7HkGNd6jUUMd7Tf7lFeDDdeMpHrgQgyJneyACzxq5RRKLQZi+ACvcKAz9@vger.kernel.org, AJvYcCWkfeIIwON9j1Ce7nKBs7IcG/avYjB1UvMj8N0igbgvebs00PfAOM9Q4peo1/+f0+fSHsghBs+YDgw+m7E93A==@vger.kernel.org, AJvYcCWn18yoLF+XeR7AW6Z5agDT9NR9Ii8AyNGaiDEYhThGQPoVP9u87wzGspwoPtwhPWiYnT6cvg==@vger.kernel.org, AJvYcCWnZCkJpzx4BDePSfxTgIYdCDCqCAtscIv5oTRqn1g65CAxnPRUUiovSMgCmd87WRI00CbQwJyZLvbOqutpzLyq5vP4@vger.kernel.org, AJvYcCXBlwPJUNoBgBWB2LAGgNQcJZP6wkwhPTdSDJXud4Zy/za7caMTENgOrRCHUD0MTcmWdUNeBPnU@vger.kernel.org, AJvYcCXhF6Ge+2BIA3epeq0nZHC6Whf2OHn1VZohsBPQwxcM3Kh6L5+ufmHnHuEXnHHfXCuvSTZ4MEfimQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRNZG63PwcQoPl2H7AD6ylqC/X8vhQryWD/y+d7PNS3RJavzd
	utnb0PIKzI7zjroTPppZACsyylQXp2H+rG6VIitIc50VKPxotSAO
X-Google-Smtp-Source: AGHT+IFysx44ym7xeNZ29ZQx56P8LK073YLR3FEq6ZYjPgOvQStiRImQUgMUmAdR1iJQTcm5/XW64g==
X-Received: by 2002:a05:6a00:2eaa:b0:718:e162:7374 with SMTP id d2e1a72fcca58-71de239f5e6mr18318586b3a.5.1728312584814;
        Mon, 07 Oct 2024 07:49:44 -0700 (PDT)
Received: from localhost.localdomain ([223.104.210.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf82sm4466432b3a.200.2024.10.07.07.49.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:49:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org,
	keescook@chromium.org,
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
	Matus Jokay <matus.jokay@stuba.sk>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v9 1/7] Get rid of __get_task_comm()
Date: Mon,  7 Oct 2024 22:49:05 +0800
Message-Id: <20241007144911.27693-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241007144911.27693-1-laoar.shao@gmail.com>
References: <20241007144911.27693-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
Link: https://lore.kernel.org/all/CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com/
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
 include/linux/sched.h | 28 ++++++++++++++++++++++------
 kernel/kthread.c      |  2 +-
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6c53920795c2..77364806b48d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1189,16 +1189,6 @@ static int unshare_sighand(struct task_struct *me)
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
index e6ee4258169a..28f92c637abf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1121,9 +1121,12 @@ struct task_struct {
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
 
@@ -1938,10 +1941,23 @@ static inline void set_task_comm(struct task_struct *tsk, const char *from)
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
+ * - BUILD_BUG_ON() can help prevent the buf from being truncated.
+ *   Since the callers don't perform any return value checks, this safeguard is
+ *   necessary.
+ */
 #define get_task_comm(buf, tsk) ({			\
-	BUILD_BUG_ON(sizeof(buf) != TASK_COMM_LEN);	\
-	__get_task_comm(buf, sizeof(buf), tsk);		\
+	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
+	strscpy_pad(buf, (tsk)->comm);			\
+	buf;						\
 })
 
 #ifdef CONFIG_SMP
diff --git a/kernel/kthread.c b/kernel/kthread.c
index db4ceb0f503c..74d20f46fa30 100644
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


