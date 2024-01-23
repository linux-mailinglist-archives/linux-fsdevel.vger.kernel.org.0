Return-Path: <linux-fsdevel+bounces-8629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A860A839CF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A6E1C24760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4C55C11;
	Tue, 23 Jan 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2uLxQkGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9138354BC8
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706051424; cv=none; b=AvJm+8FU9bJdP80WMSSELPb13Dss5x3b+AX1nf2k6Q5CAeCMGm9CpVoZVDNLQd1huf7Qe8MUwXdeNdWlv2VBOZBdl0eD2casZfhnIXkns7L+FUDtQltRYbAVBKKr5AnQnbhC+05HT+Ts0Pv2/po0sfruZg7h5OuoRL8KfwIBnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706051424; c=relaxed/simple;
	bh=YUTCdLYl4R4AJ76ENTbaMi/xKnesbkwZdIOzekxlmgs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F1QlX0wW0KrJZEWGUlFAdjstuPBoXxcwv+B9Q0/os9sbuiVvlJ10bkAqA3pxXAFxVfTXImXM0CWJHtRh2yhUxfq2uYRBTqzHz36Ds/4hn7uO95pvnXY6pz+AxbJI00ZHick7fOoBQnHt9+aDl1mm3iVFGceLmgr5U9gEcJMIUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2uLxQkGR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6002a655cc1so28616217b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706051421; x=1706656221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOH4eD/kP+yC8NUPTXlai05Ia1nTXRgcymGMGu85eLQ=;
        b=2uLxQkGRny5uq0JvKSVj5IZPnu0tRvgnWxVQ/KqfkLMSzHx0ZXEAnwLBEvYF4IdIPO
         95/WgvX0bVIhMn3y/MgEz786ScJMFnOOkehXdTs6bHfa/6GBlzC8ZpIQbM6mrPT1g1Pp
         9awsEkYByop65jUBBX7xW0Cuiq/BA10OGB1uBS9XTZditpDvUzlUkmQ5a3J/A+FzXr/m
         gvILAGK/7Sud09K1XE5J5AYB2ktDsW/BmrafBv6mc9CZVCVvLRd8qwLhdClrTCuyjZju
         SkkZ1LwMKSi/qsvr+iscdmCxJgnrUXHOrEA8j5iEiztzOMzBVW3u45Pl5Gmy481aTr2z
         Bj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706051421; x=1706656221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOH4eD/kP+yC8NUPTXlai05Ia1nTXRgcymGMGu85eLQ=;
        b=l6tI2hdKo/EUNInBxVTnLAYy9gU4kOc6ZkvYfVRX0oESTl0xj0Cf5vHZLYnSHAv9Z0
         2V2CoE4A7Gg7jDUyGBEjgnRhHz+bXCXUc8rLrGwlhLWy0r9xNx9eUtkVbd7JOrqq994T
         n/nW4IwhtrWnVvG1ZWkD3OUvGNW7RGPkSLoSZHdSuC9qhwkA5cEUnuEbffHsWuSEQok0
         UyyXWTq9iypjxqq5JoEc3+GsBFP1bj10GCfeBg+ALCaMFOZuLNMXPJRLaDWmgKdzZeVB
         cyb9kDXlze1eSYs8jLbLAqJkZry3NTuO91W2dfYefSN+QOL1mIYFXiOwwB17+y+ca8ch
         YLYw==
X-Gm-Message-State: AOJu0Yw+VPMwOwN0JEpO6vo4sH/ATX8qFMssq61MxrsFKl9vvXZLmr8x
	Bh9oVu/1rR/vSYtDstfxzu9ehTGe3mFlF6Oh25qnrtOPxuAUssqJNTJicWAzikk1gEKigQ8eak7
	QvA==
X-Google-Smtp-Source: AGHT+IFELlpA6dr+hh0ohU9jI75g0Qo+vt9bgKXouAI4UTf2K5w/MytBcB95Yhp71v6eqOEpu4Ziung4r/A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:8fc3:c34f:d407:388])
 (user=surenb job=sendgmr) by 2002:a25:ce11:0:b0:dbd:b909:f090 with SMTP id
 x17-20020a25ce11000000b00dbdb909f090mr373700ybe.11.1706051421519; Tue, 23 Jan
 2024 15:10:21 -0800 (PST)
Date: Tue, 23 Jan 2024 15:10:14 -0800
In-Reply-To: <20240123231014.3801041-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123231014.3801041-1-surenb@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123231014.3801041-3-surenb@google.com>
Subject: [PATCH v2 3/3] mm/maps: read proc/pid/maps under RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	dchinner@redhat.com, casey@schaufler-ca.com, ben.wolsieffer@hefring.com, 
	paulmck@kernel.org, david@redhat.com, avagin@google.com, 
	usama.anjum@collabora.com, peterx@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, wangkefeng.wang@huawei.com, Liam.Howlett@Oracle.com, 
	yuzhao@google.com, axelrasmussen@google.com, lstoakes@gmail.com, 
	talumbau@google.com, willy@infradead.org, vbabka@suse.cz, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, sj@kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With maple_tree supporting vma tree traversal under RCU and per-vma locks
making vma access RCU-safe, /proc/pid/maps can be read under RCU and
without the need to read-lock mmap_lock. However vma content can change
from under us, therefore we make a copy of the vma and we pin pointer
fields used when generating the output (currently only vm_file and
anon_name). Afterwards we check for concurrent address space
modifications, wait for them to end and retry. That last check is needed
to avoid possibility of missing a vma during concurrent maple_tree
node replacement, which might report a NULL when a vma is replaced
with another one. While we take the mmap_lock for reading during such
contention, we do that momentarily only to record new mm_wr_seq counter.
This change is designed to reduce mmap_lock contention and prevent a
process reading /proc/pid/maps files (often a low priority task, such as
monitoring/data collection services) from blocking address space updates.

Note that this change has a userspace visible disadvantage: it allows for
sub-page data tearing as opposed to the previous mechanism where data
tearing could happen only between pages of generated output data.
Since current userspace considers data tearing between pages to be
acceptable, we assume is will be able to handle sub-page data tearing
as well.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v1 [1]:
- Fixed CONFIG_ANON_VMA_NAME=n build by introducing
anon_vma_name_{get|put}_if_valid, per SeongJae Park
- Fixed misspelling of get_vma_snapshot()

[1] https://lore.kernel.org/all/20240122071324.2099712-3-surenb@google.com/

 fs/proc/internal.h        |   2 +
 fs/proc/task_mmu.c        | 113 +++++++++++++++++++++++++++++++++++---
 include/linux/mm_inline.h |  18 ++++++
 3 files changed, 126 insertions(+), 7 deletions(-)

diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584..e0247225bb68 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -290,6 +290,8 @@ struct proc_maps_private {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct vma_iterator iter;
+	unsigned long mm_wr_seq;
+	struct vm_area_struct vma_copy;
 #ifdef CONFIG_NUMA
 	struct mempolicy *task_mempolicy;
 #endif
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..0d5a515156ee 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -126,11 +126,95 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
 }
 #endif
 
-static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
-						loff_t *ppos)
+#ifdef CONFIG_PER_VMA_LOCK
+
+static const struct seq_operations proc_pid_maps_op;
+
+/*
+ * Take VMA snapshot and pin vm_file and anon_name as they are used by
+ * show_map_vma.
+ */
+static int get_vma_snapshot(struct proc_maps_private *priv, struct vm_area_struct *vma)
+{
+	struct vm_area_struct *copy = &priv->vma_copy;
+	int ret = -EAGAIN;
+
+	memcpy(copy, vma, sizeof(*vma));
+	if (copy->vm_file && !get_file_rcu(&copy->vm_file))
+		goto out;
+
+	if (!anon_vma_name_get_if_valid(copy))
+		goto put_file;
+
+	if (priv->mm_wr_seq == mmap_write_seq_read(priv->mm))
+		return 0;
+
+	/* Address space got modified, vma might be stale. Wait and retry. */
+	rcu_read_unlock();
+	ret = mmap_read_lock_killable(priv->mm);
+	mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
+	mmap_read_unlock(priv->mm);
+	rcu_read_lock();
+
+	if (!ret)
+		ret = -EAGAIN; /* no other errors, ok to retry */
+
+	anon_vma_name_put_if_valid(copy);
+put_file:
+	if (copy->vm_file)
+		fput(copy->vm_file);
+out:
+	return ret;
+}
+
+static void put_vma_snapshot(struct proc_maps_private *priv)
+{
+	struct vm_area_struct *vma = &priv->vma_copy;
+
+	anon_vma_name_put_if_valid(vma);
+	if (vma->vm_file)
+		fput(vma->vm_file);
+}
+
+static inline bool needs_mmap_lock(struct seq_file *m)
+{
+	/*
+	 * smaps and numa_maps perform page table walk, therefore require
+	 * mmap_lock but maps can be read under RCU.
+	 */
+	return m->op != &proc_pid_maps_op;
+}
+
+#else /* CONFIG_PER_VMA_LOCK */
+
+/* Without per-vma locks VMA access is not RCU-safe */
+static inline bool needs_mmap_lock(struct seq_file *m) { return true; }
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
+static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 {
+	struct proc_maps_private *priv = m->private;
 	struct vm_area_struct *vma = vma_next(&priv->iter);
 
+#ifdef CONFIG_PER_VMA_LOCK
+	if (vma && !needs_mmap_lock(m)) {
+		int ret;
+
+		put_vma_snapshot(priv);
+		while ((ret = get_vma_snapshot(priv, vma)) == -EAGAIN) {
+			/* lookup the vma at the last position again */
+			vma_iter_init(&priv->iter, priv->mm, *ppos);
+			vma = vma_next(&priv->iter);
+		}
+
+		if (ret) {
+			put_vma_snapshot(priv);
+			return NULL;
+		}
+		vma = &priv->vma_copy;
+	}
+#endif
 	if (vma) {
 		*ppos = vma->vm_start;
 	} else {
@@ -169,12 +253,20 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
+	/* Drop mmap_lock if possible */
+	if (!needs_mmap_lock(m)) {
+		mmap_write_seq_record(priv->mm, &priv->mm_wr_seq);
+		mmap_read_unlock(priv->mm);
+		rcu_read_lock();
+		memset(&priv->vma_copy, 0, sizeof(priv->vma_copy));
+	}
+
 	vma_iter_init(&priv->iter, mm, last_addr);
 	hold_task_mempolicy(priv);
 	if (last_addr == -2UL)
 		return get_gate_vma(mm);
 
-	return proc_get_vma(priv, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
@@ -183,7 +275,7 @@ static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 		*ppos = -1UL;
 		return NULL;
 	}
-	return proc_get_vma(m->private, ppos);
+	return proc_get_vma(m, ppos);
 }
 
 static void m_stop(struct seq_file *m, void *v)
@@ -195,7 +287,10 @@ static void m_stop(struct seq_file *m, void *v)
 		return;
 
 	release_task_mempolicy(priv);
-	mmap_read_unlock(mm);
+	if (needs_mmap_lock(m))
+		mmap_read_unlock(mm);
+	else
+		rcu_read_unlock();
 	mmput(mm);
 	put_task_struct(priv->task);
 	priv->task = NULL;
@@ -283,8 +378,10 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	start = vma->vm_start;
 	end = vma->vm_end;
 	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
-	if (mm)
-		anon_name = anon_vma_name(vma);
+	if (mm) {
+		anon_name = needs_mmap_lock(m) ? anon_vma_name(vma) :
+				anon_vma_name_get_rcu(vma);
+	}
 
 	/*
 	 * Print the dentry name for named mappings, and a
@@ -338,6 +435,8 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		seq_puts(m, name);
 	}
 	seq_putc(m, '\n');
+	if (anon_name && !needs_mmap_lock(m))
+		anon_vma_name_put(anon_name);
 }
 
 static int show_map(struct seq_file *m, void *v)
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index bbdb0ca857f1..a4a644fe005e 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -413,6 +413,21 @@ static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 
 struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma);
 
+/*
+ * Takes a reference if anon_vma is valid and stable (has references).
+ * Fails only if anon_vma is valid but we failed to get a reference.
+ */
+static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma)
+{
+	return !vma->anon_name || anon_vma_name_get_rcu(vma);
+}
+
+static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma)
+{
+	if (vma->anon_name)
+		anon_vma_name_put(vma->anon_name);
+}
+
 #else /* CONFIG_ANON_VMA_NAME */
 static inline void anon_vma_name_get(struct anon_vma_name *anon_name) {}
 static inline void anon_vma_name_put(struct anon_vma_name *anon_name) {}
@@ -432,6 +447,9 @@ struct anon_vma_name *anon_vma_name_get_rcu(struct vm_area_struct *vma)
 	return NULL;
 }
 
+static inline bool anon_vma_name_get_if_valid(struct vm_area_struct *vma) { return true; }
+static inline void anon_vma_name_put_if_valid(struct vm_area_struct *vma) {}
+
 #endif  /* CONFIG_ANON_VMA_NAME */
 
 static inline void init_tlb_flush_pending(struct mm_struct *mm)
-- 
2.43.0.429.g432eaa2c6b-goog


