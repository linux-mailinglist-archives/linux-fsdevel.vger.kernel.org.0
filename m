Return-Path: <linux-fsdevel+bounces-61687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63EB58D50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 06:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E72324E2973
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 04:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17CB26FA60;
	Tue, 16 Sep 2025 04:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Xjumc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F62225761
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998150; cv=none; b=mEWveKhf4QBNPQ/0cSnmLIAU6awaID0T33kBZPlpBqN7+/LrWVVBQPDCirtVWYoZ44Gn5pf6j1A1/YKQLbM9dONn5t3X2ixmZ6jtZ7Gup0KjpUe0QCy9gySDd3SGE5ll6m7kqqRRue2ZPpyvPpdnYw64YzTfcLLUmTGCmln42rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998150; c=relaxed/simple;
	bh=A1DaGpRAAYNdE/JnkBcpbGGz1TWyQSRA1+c5fRETaCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z2mWvMni9phuqD23cmDtaKLfeTNH1bH1XPFEfT7P1FE9aEEP6uPBI6lGIZtp2/ZxB1Ghshom0Z4oe+wlPHGTulv9m8YmsdW9S4GdQke2S50Oe5oATTn09JRU+NC9VAZGwjzIymb04d/BjDtl4G1oM+CQtUIGmbHh1dzNyFNI2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Xjumc0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32e11a1401bso2297337a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998147; x=1758602947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=K4Xjumc0nBcco5KyK7TayYg1GVB3J8fMW7YfmCjhgTTUc/fPIDKia1bI2dpOo4Dlpx
         o0oYiCFoIl/qnLukCt0JaKCTycIs9+9f38sOAgldyz8tQIGpDGM4I5xSF1yz9foe5Y+0
         2p4TuTz/xI8E76jU6e6NUTzqr4tF4KFkj0cyt03nQJvtbqEvTMv5/6XrYgnXmNQLeb+O
         sDFNMQP/6B3RWiK8Q1KWu4oWPdcxqbwd7gQ0AyvjLj19qMjmrrjdeeVtI4h+aCXWk442
         XnCfLw3QPsQeRmrhv0yiLaCyo05omJolYFv4x6BgsEMJUeoyH1rHSkFxKz1mCDro3W3Y
         TL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998147; x=1758602947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gp+N7RFYdL+M8U5Aod5ZJl4PoDAFL89oD30EaW4MsNY=;
        b=m91bNke+UY3wRQEMWExVRxEQRR2Zv2b+0BAJdB8Hxf5QXmCryJB5la2aRj5Jgmx6pW
         F99yAFnM1XWTMIPhc+MQIoYo5+Tt5fVmpa7xonzPMGi/Iuut2NV2kNWmFH0/1mLn7pxv
         GZ7+uVGR7VVInGeC1x0lCIIwO1IAvIChdTTVZKZB0si9ZY9zR01xD8ytlXXIGj/Uiefn
         nWtHsxI9CYot2OA5ECDpYKGTV1lxVjNjvOFjI/v8vR0gD8r/4NAxIAje9Id9Q/8aN+E/
         zXY6iy9dOf8UquYqkVMWdi0tzBfRRwyD4Ikqk6OIWsimMy/SU6lrcDyx6+RIYG0HYFq1
         MCRA==
X-Forwarded-Encrypted: i=1; AJvYcCV4hLxg9dgSP+uJvCpPVqT6idO69yQaXZOGi0Aa1tLy4oMSirAOgAkz8A0aNcxj9P8SJlIrMRlexKC7DPFm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jpuk/gQpcrAivT7msyNS1jdkBgKLyA1MdmEDvJ9nJr1RjDAn
	Jy1Tw5GD4kgDSnSYTa8UOofw4T3rJR71eeY3qF8VsctvNNZG6w3nZqUG
X-Gm-Gg: ASbGncuDtDKzy3h+LMAUMNgzP+k3fl8ySS4bsa9fBd6vORAdsCXoHdv6+EY+cXV4fyV
	Iru4TXEQx6xdysdhkCAMhbK6CDZiPAy1KehqGgRa9H7V3VmRCyAb5XlwyYVLCdf96whnqQpcH/5
	vrFAj4pUFGbn3/jEO11tVTKjfRPejIzCaghQS8Gl2rHMJukFNkAes2yUP+y5OIayCBVVQtQ3dKm
	J5qZTMaY4NFiJmgf90SXPBNR16Kc+4YWpmVN98YQES+xMTrPEeGVUt2p0ggF4YX6a2xFemN/Ymo
	KF4qeLVTyjlEQ/EBQQ1uTR2tlmWRnpqGr837TfXqv0DZDRL7Km8LFOGD10y5fRVRFrKpI1bH+6O
	SoNAHSpUWrSbjGnV1nfCs1yeD1vOioU6ohBS/ysA=
X-Google-Smtp-Source: AGHT+IFqD7sgMgos1nHHN1tffY5PC8RBagTW/SlAHYpHIH6iPNz9WSa7pJxkI6T7wvTsG+plknRS6A==
X-Received: by 2002:a17:902:f70e:b0:266:120a:29c7 with SMTP id d9443c01a7336-266120a3078mr75581275ad.6.1757998147150;
        Mon, 15 Sep 2025 21:49:07 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:06 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 08/14] cgroup: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:29 +0800
Message-Id: <20250916044735.2316171-9-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cgroup.c | 2 --
 kernel/cgroup/debug.c  | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..db9e00a559df 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..81ea38dd6f9d 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -49,7 +49,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		return -ENODEV;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
@@ -67,7 +66,6 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
 			  css, css->id);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	cgroup_kn_unlock(of->kn);
 	return 0;
@@ -95,7 +93,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		return -ENOMEM;
 
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	cset = task_css_set(current);
 	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
 		struct cgroup *c = link->cgrp;
@@ -104,7 +101,6 @@ static int current_css_set_cg_links_read(struct seq_file *seq, void *v)
 		seq_printf(seq, "Root %d group %s\n",
 			   c->root->hierarchy_id, name_buf);
 	}
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 	kfree(name_buf);
 	return 0;
-- 
2.34.1


