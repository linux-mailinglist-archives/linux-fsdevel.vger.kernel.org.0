Return-Path: <linux-fsdevel+bounces-72120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04567CDEF69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 21:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14828300DC96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 20:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF52765DC;
	Fri, 26 Dec 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKOdmoOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146A1917ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766779387; cv=none; b=RTghPeeqgljqQ847MOCq9JFdRSaGVyinobgSGMBpM/8UakrC3S3kPhZ9jB0OHNqU0qjWlGawgGmScX8qHBdHQNYGIGarCFbfzIQcjq6bXBqaQBY3B+n+EulBck3m0pjvmPfCfth1g8zctOHt7Al6hElh0ZRT5NdfozBLKEK2M4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766779387; c=relaxed/simple;
	bh=A0kmk3HxGUL3/4tIIWUC/2ECisNfpkAADLaTtVUd4z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRrRn0jN/gjDqGtJ5a2ga4BgA4fsl6Qdw9fuMdU4GG13khHKnAJjAAX9aOmPEtgFR8OriuD4cxOSKq58u1bOi+qeh19LQXc/MIGlbM3j/zTLMT36vzdzoTyDnpfk+1nnLnEe18zQx6fK4ulVM02S2xYu202jsYs7ibIQIyFVAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKOdmoOC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59581e32163so8789012e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Dec 2025 12:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766779384; x=1767384184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvweSQ4BMR3eXRmaA0kn4QnkUvwNZou9C1daYWMvC/E=;
        b=lKOdmoOCp7mhL44akaXk88kfvVy4Mpx9TomJFdYKpRW+7I61j7o/5olSGhKv0yf1Y5
         TfzZ2XW81ue5uevHgey11+KPr2w7Ot6yfVjsiBOTBQCZrXlT0bS84C4IQFz6hAVnLoYI
         QgBinGyX5e9mvzEFGICIrlNKJjRaRJW/GdaAHbRf9ZO/B1f5p0tvRYRoGvhA5uQxML7k
         ZnwGO0cR2Zg8AkYMUPVUxWEStP+F29H+3ZDsNqA1Eo+dxM7I1bcEgyWeM0zW4h+E9uIc
         EEtkFvm1H5C151QAcMIgEWTREmPQUB/Idm4+6K1KsGZ+sl97OhBN4wG7bD6+atZZm9ci
         gkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766779384; x=1767384184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvweSQ4BMR3eXRmaA0kn4QnkUvwNZou9C1daYWMvC/E=;
        b=Yst7Jo+fWUN0zkfHCMRvEQHpDuaxFBVSiAsnmc5S1g8OlcayNyf69dXXbo6lGROuqj
         unIrpe8HFUms3I3HpCF2FFzXCH6RATs3Uo87rtWfgbCBq4P1jOzCTxl4bbRl7AEcTza/
         yocoQ7qyfFBQwWrSGs+XhEhQ2qhSmHxOrIywCo3TzD2T72ZZftcUQ0ewknGjR5FCuO2S
         96Fbx/Qg9BoYagqFfUKFWtMoBV/eCNQ5SfKCJcRwKF3IucdL3Pcb2o05USu0hk2nVOiY
         hVFpnJDzXs22fJB/umVG1p6tN9X5tyIcvTwEVFaXC2Jqjd1syjun5VhhC40q8gUjTePx
         5lMA==
X-Gm-Message-State: AOJu0YwcHmcvrqxizdAnauliKf59z1+01vxkiAS2tP30ENXMx6LzcspI
	FJixCvTUa4ZKl5FO6+S7yRlAQca3UEVyIq1f0xrOdp5aRA6kdqMZqlI=
X-Gm-Gg: AY/fxX7QKbF2MBo3nulbiE3gm+u+s7NgfyhlUfw9twZK6aRaeU1B2kJ0ILjxAm4PopO
	+2NfixXv8cHsNHnTpXAw1JXRcnD+bRg4uwEiIwmbhlget/IzQJ2flOMuSxnq0ffSeeOGO1IDB9N
	yH1tIct5HAhFZdvUnHCaMIdVXWmcIOf2ihKq1dwRahTgSdgakPiVc0UHBlefUzgLJ8QQk1Q+nL6
	uo/FaoG8QxZ/qiuR8KxH0WYuJcmAFP9md9bBK9zeUgpI/SOAd/baaRa7XZ9Y5vDiX3BaVRnSxP7
	BhBL3UIO00nLXihKkTLwGputEk8aA38msIwE5qxLxNuHik70w8BQmugU446yvOk2YnR5phaRwVi
	IriybUsQheh6zUZ2XC17+WE2DTd4euNHcheFvWmVYkBaUSFe0lKYZpjgDUVZIerUwO6GEjWhnwt
	w=
X-Google-Smtp-Source: AGHT+IF82v3c72c8zj3tt4YuPvh9JVzCw82RqqlQ4WugpCtYN4okdAm8ItMaZjpSDHeh5jD7k5feJA==
X-Received: by 2002:a05:6512:1189:b0:598:853e:4868 with SMTP id 2adb3069b0e04-59a17d70963mr8340049e87.53.1766779383461;
        Fri, 26 Dec 2025 12:03:03 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185dd7c8sm6705593e87.26.2025.12.26.12.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 12:03:03 -0800 (PST)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com
Subject: [PATCH v2 2/2] proc: rewrite next_tgid()
Date: Fri, 26 Dec 2025 23:03:22 +0300
Message-ID: <20251226200322.469738-2-adobriyan@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226200322.469738-1-adobriyan@gmail.com>
References: <20251226200322.469738-1-adobriyan@gmail.com>
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


