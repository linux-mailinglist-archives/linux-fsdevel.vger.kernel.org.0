Return-Path: <linux-fsdevel+bounces-72117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B4CDEF44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0C2A3001BDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 19:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39222BEC2E;
	Fri, 26 Dec 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ctCUZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE152749CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766778925; cv=none; b=MZJ5O9yrQobicbBG7wnzXJqxw1CUjktE9TJgzgSnC4Of3p+llpBjgRhi2+Af2Mi9yRlsA83ge5J4BmGyB0l3r0nTe8LgsCxwNm+xeJBd8FPRiHe0MztoR1G4pYag4gHN+tJyanNQmIxtlAUr7TZvJpukmYhK8T8gR05enaGBURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766778925; c=relaxed/simple;
	bh=A0kmk3HxGUL3/4tIIWUC/2ECisNfpkAADLaTtVUd4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8GAD3FakK5FG3S0sopjHbZOYUpJnEdX2/1BYbSXT3fEjGmlJs8rcwhK6Uej/RBRf6iwa8YKAUqFmJS1bhQr/ggxR1JHzcSc1OhSUthrntXVOUYqxS+aGoZzaAZQSW5Gz1gvI9tzPtnsOFpmHsUhiOpfPTyaLrDzg+6/u/iqS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9ctCUZC; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-596ba05aaecso7988748e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 11:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766778922; x=1767383722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvweSQ4BMR3eXRmaA0kn4QnkUvwNZou9C1daYWMvC/E=;
        b=C9ctCUZC3zjOt5Aybg0XLoe5tK+2rh/X8g0p1Hlw2iMTA5tSHdtUje/m17zRqDQIf8
         TFifGpSREFRaYUrjsbieTJqgicb5/25D13g5WRucmtZm1HeUNirpiNlfYdnUi9CsOwSR
         DCJCiLHKCKaq/KQxVjgWAESGgG+VhVxbIkFcJIaoOoZbOn3mWs22XVpjB/XlDZEc3QXH
         1UOqP3Viw3yMpTJapcwnQZJkbR96ZY1AkulEWrxSSU7jZByeuuQZloi4Kxcby/taUeTr
         CKraDBTJJo0Wjn6U4zgqSEDM1jmJoaPFhGQsvMYiaYXVBykWVKaRMK2fmow/+WcdOEbs
         H+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766778922; x=1767383722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvweSQ4BMR3eXRmaA0kn4QnkUvwNZou9C1daYWMvC/E=;
        b=AJ68pAXiLkZvYCeR/eSfBeI8mCD+YI0kk8sBcdRUaQx9SNH4SFMb1u+m/sCgihyqMu
         E1r/r4UrjcDOPcLGfkkblQWuC/oarUXIBsdDlrk1iTBjZVp7aWP9SrNsOfkzSqShRzGH
         Gb7SJ9R80eTDvh+2lvfP3WhucLOJDYiQG49xp+YOz/tXYrxIPpLMNnF9UIy1xsmOLnmx
         xT/p7aCgUKIzQVoXT+UOxLfAnkVVG55VjMlZThk3LQp7M7tRlSGKybmRMX5zwjUDnMLa
         h664KMQXk2lJqojFE1HhWXud2fUbs+DxmrZ37y0M95cqNAN2U4jt2+T0uwTlous6kKjZ
         wnDw==
X-Gm-Message-State: AOJu0YxCIxPlgBZ9a+sOchGBOpPY/XYej78NbxkZ7AGz+UrUiV258mU+
	tw/Eo/xwJc5GUJ1/QnpdUVxfoKfhpbUWXcV2/sAONUOzC7MBz2Rmu5391A5A
X-Gm-Gg: AY/fxX527Jo+AmZDLzqunHLWV8xSN4mf06rz2xLdEFizQ0Odz9Cyn7VUeHAN2z3uAr9
	FnrNz4foYzZJbafwXZZXxoWKV3yBK+C7/UTMLGhSsERKUIQIwaKw5IgK0+KvRxPsq9fn7k3jKQ6
	6xIjSX5D4TSCo0uxqj80/q1DDxN9pCI9gcBiZFSrbBHr9/vgHZ2ienK9e3vqzhlIurqamiqkYin
	BeWvsw5G17nro0fbAm3/49IvtqnQa9LgFSHbVvYTF+/D0hmD7OegzgfJRk3kElguXp2jgOWWd1g
	TQGUMUnwtQnxwiI+4QNzvDc6a03zU2yV95S1LO8lBIyAfvBGJeu1Xe0OiY9mJS87L37PjqMZlAE
	8WnHZ4zEsz3UFHGQ6777A2scdoha02EmUF6rxKDE+CnZN/16ms59MWsfqhybgxrjpsxWnwwSGpY
	M=
X-Google-Smtp-Source: AGHT+IEHyV8aBI08nSBinQ1Bcdups9vXCh4r/yM6qYWQVtr7mQOBxTq26+B4SXbAa/PQAGXrv7Rrug==
X-Received: by 2002:a05:6512:b8d:b0:599:ce8:24a8 with SMTP id 2adb3069b0e04-59a17d579e7mr7092376e87.40.1766778921560;
        Fri, 26 Dec 2025 11:55:21 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3812251cfffsm63088951fa.19.2025.12.26.11.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 11:55:21 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH 2/2] proc: rewrite next_tgid()
Date: Fri, 26 Dec 2025 22:55:36 +0300
Message-ID: <20251226195536.468978-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226195536.468978-1-adobriyan@gmail.com>
References: <20251226195536.468978-1-adobriyan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* deduplicate "iter.tgid += 1" line,
  it is done once inside next_tgid() itself and second time inside
  "for" loop

* deduplicate next_tgid() call itself with different loop style:

	auto it = make_xxx_iter();
	while (next_xxx(&it)) {
	}

  gcc seems to inline it twice in the original code:

  	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/1 grow/shrink: 1/0 up/down: 100/-245 (-145)
	Function                                     old     new   delta
	proc_pid_readdir                             531     631    +100
	next_tgid                                    245       -    -245

But if there is only one call, it doesn't matter if it is inlined or not!

* make tgid_iter.pid_ns const
  it never changes during readdir, returning instance + C99 initializer
  make it possible,

* rename "iter" to "it", this is what another language seems to be doing.

* limit declaration scope to prevent problems (in general).
---
 fs/proc/base.c | 69 ++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7c1089226a47..ddf5e16c795b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3535,35 +3535,48 @@ struct dentry *proc_pid_lookup(struct dentry *dentry, unsigned int flags)
 
 /*
  * Find the first task with tgid >= tgid
- *
  */
 struct tgid_iter {
 	unsigned int tgid;
 	struct task_struct *task;
-	struct pid_namespace *pid_ns;
+	struct pid_namespace *const pid_ns;
 };
 
-static struct tgid_iter next_tgid(struct tgid_iter iter)
+static
+struct tgid_iter
+make_tgid_iter(unsigned int init_tgid, struct pid_namespace *pid_ns)
 {
-	struct pid *pid;
+	return (struct tgid_iter){
+		/* See preincrement below. */
+		.tgid = init_tgid - 1,
+		.pid_ns = pid_ns,
+	};
+}
+
+static bool next_tgid(struct tgid_iter *it)
+{
+	if (it->task) {
+		put_task_struct(it->task);
+		it->task = NULL;
+	}
 
-	if (iter.task)
-		put_task_struct(iter.task);
 	rcu_read_lock();
-retry:
-	iter.task = NULL;
-	pid = find_ge_pid(iter.tgid, iter.pid_ns);
-	if (pid) {
-		iter.tgid = pid_nr_ns(pid, iter.pid_ns);
-		iter.task = pid_task(pid, PIDTYPE_TGID);
-		if (!iter.task) {
-			iter.tgid += 1;
-			goto retry;
+	while (1) {
+		it->tgid += 1;
+		struct pid *pid = find_ge_pid(it->tgid, it->pid_ns);
+		if (pid) {
+			it->tgid = pid_nr_ns(pid, it->pid_ns);
+			it->task = pid_task(pid, PIDTYPE_TGID);
+			if (it->task) {
+				get_task_struct(it->task);
+				rcu_read_unlock();
+				return true;
+			}
+		} else {
+			rcu_read_unlock();
+			return false;
 		}
-		get_task_struct(iter.task);
 	}
-	rcu_read_unlock();
-	return iter;
 }
 
 #define TGID_OFFSET (FIRST_PROCESS_ENTRY + 2)
@@ -3571,7 +3584,6 @@ static struct tgid_iter next_tgid(struct tgid_iter iter)
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
-	struct tgid_iter iter;
 	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
 	struct pid_namespace *pid_ns = proc_pid_ns(file_inode(file)->i_sb);
 	loff_t pos = ctx->pos;
@@ -3589,24 +3601,21 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
-	iter.tgid = pos - TGID_OFFSET;
-	iter.task = NULL;
-	iter.pid_ns = pid_ns;
-	for (iter = next_tgid(iter);
-	     iter.task;
-	     iter.tgid += 1, iter = next_tgid(iter)) {
+
+	auto it = make_tgid_iter(pos - TGID_OFFSET, pid_ns);
+	while (next_tgid(&it)) {
 		char name[10 + 1];
 		unsigned int len;
 
 		cond_resched();
-		if (!has_pid_permissions(fs_info, iter.task, HIDEPID_INVISIBLE))
+		if (!has_pid_permissions(fs_info, it.task, HIDEPID_INVISIBLE))
 			continue;
 
-		len = snprintf(name, sizeof(name), "%u", iter.tgid);
-		ctx->pos = iter.tgid + TGID_OFFSET;
+		len = snprintf(name, sizeof(name), "%u", it.tgid);
+		ctx->pos = it.tgid + TGID_OFFSET;
 		if (!proc_fill_cache(file, ctx, name, len,
-				     proc_pid_instantiate, iter.task, NULL)) {
-			put_task_struct(iter.task);
+				     proc_pid_instantiate, it.task, NULL)) {
+			put_task_struct(it.task);
 			return 0;
 		}
 	}
-- 
2.51.2


