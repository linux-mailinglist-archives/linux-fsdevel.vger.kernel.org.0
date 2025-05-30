Return-Path: <linux-fsdevel+bounces-50173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366B2AC8AD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F516AEDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF352236E1;
	Fri, 30 May 2025 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ihzlDemt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904221E082
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597431; cv=none; b=OGYjxKB5V/xDfYD3ufkYlz5cBFPI1DoGBOL0JzocRLy0inZefftxA3sbdbArBtN1f3SzLkHZFEAukxSq+LaTqNz/VURBitsKkXvHjw2gpsQPyq47eMpVsNKPuuNuHjBh6cl4Cs0pZ+6pAQeP39LCMs5XZItQ3XfA/XdnOSpUIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597431; c=relaxed/simple;
	bh=DFUGROHVCTniD49Ozv49pSZ2hICpYueXEA09N4l6CVc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZ8MppoZkipq8W37vxO5a6irtjwKfdAtijHHh6DhuuK7I7xFLr73qbOPKwJtZ/F4tI2rmWLHfzvg2YtbocnZC8NCW0IMZNPebIlmjjbf6g3FA4jZbH4heZRa/RupSYEddB9IG2ur2aFU0Fc3knTrOu9dscmPDIqIN4m/G0s3btY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ihzlDemt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3119822df05so1883345a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597429; x=1749202229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It0nagCB2dMHz+A5VnrcLdhvjSzG9DfFTU//7hpwVEI=;
        b=ihzlDemthbTov5PXhPgH3PlMpPQsHOe4zKAOJCRsWUntI5rjURuIxsST5IrMwsmZXr
         cMDEeCqiJd11fkseRgWWyviZqSJkK90CiEOQCi+63DZPZGAwHHbVuNqC/asOl1MrlB+U
         B9XEHrLdr001jKPVuSAEHq2+C6XfUM/p8jWCMM4aE2JCGwafNiP5n7tD2YKVlCgT72A2
         +YQ9G7z8HD8tX/VLki2z6cgf2nB9c3s2CKVZG0bq3TQqvrfq6HxAW6Vi6S1ieVoG/m0h
         jJyF82BmP7J2fnlAb4gZu5bAYyrwIZ9M2HKGl+A/8fnY7L3tu3ITXC0hQjFrT7os80aw
         jvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597429; x=1749202229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It0nagCB2dMHz+A5VnrcLdhvjSzG9DfFTU//7hpwVEI=;
        b=IN3tLIeTnD98m+bnjGqR5HzRhi8ihvgkJtGMRpMhAZ4cc276RBHvwxtDnQIX4T2/eU
         nWPWA/cjvwDJoKmqpqGpwxBeakIs/hg3g+Y2aCwbWMZDKbqMcwY5AVBKJO5nczS1IBKz
         LAk/TOpPoV2C6xy/gXuWUI1S+EK9znRYHTFgIq2FeC9spZITaMBjuDeWcIWeQuMuYOcG
         6uq7oj1DGVC9bZ+PdepTYCLtk4uu3aFmXp6tn+1nlZ7Ef2HSTxB7grGGBzJ8AU57og9T
         Md7XjYS/Om5/A9rrEsNoCVur4MKRCaWn3gJUztk1X2AwpHZSe5+O9b7En4rWRFBTfbAj
         pNGw==
X-Forwarded-Encrypted: i=1; AJvYcCWrJgWD/SjJKiU619gozDD5QasRb2voYB7gG2LR9yeD55cUW0K3PGRm6EXwrwuWhCmkZqyIxn6DJ1ONxAux@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dIgJxn/cxxniIfO5f2KA+51C8/lZw+bAP70W63XK4x23aeBt
	1L1Ov+a9QWOsMoHKfD1ZKNw7vbJ5BBWWuTFqn08SUEeXXUN4Q0OHBnyeiYZYy+gu+n0=
X-Gm-Gg: ASbGncvFaKWXt4MjpDocoQs6ziQJbIqxOBXEAG+TLHM8AMKVRG6rpm/nZIfPKQNF557
	SpFk7fgxEJJ1MrebWWNCNQQu6jJKhx+uTgDR9kOLa3t0TN2jpyuY6e6QuKQJrlxJsLRGGdpvs4W
	VacOMOhpXho6SdF2ZjJpBwvvzOdW7zje3uQScjBbkFRkzyv8qVnJSEBJxVz1R5V/vDn/FpSinxE
	e+w5RjuzqObWu5tDzBemKin+go2FIOwngsjjKWZZJF+YX6XDkzWJL085iIjSzskWUWGaSZhzcUl
	Ub3c/skgKB4NFDHCcCB7DgWNnimu0Ac2mujJYR5XZObbb8y4LsmpJO7pnCTiuMhKP1QyPe9X4Cq
	kthvjhEhRbBzYc/dJpFu+
X-Google-Smtp-Source: AGHT+IHhFP+YSRyY0vGcXgga6NhFTtrcJFFIO4OfIe90gNYiOLxgktzPA73bwtmVpC1QBkXNF+uurw==
X-Received: by 2002:a17:90b:4fd2:b0:311:f99e:7f4a with SMTP id 98e67ed59e1d1-31250427d15mr1963416a91.26.1748597428884;
        Fri, 30 May 2025 02:30:28 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:30:28 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 08/35] RPAL: enable sender/receiver registration
Date: Fri, 30 May 2025 17:27:36 +0800
Message-Id: <a999df69234df38638909f3503d99bd6d8e54a84.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RPAL, there are two roles: the sender (caller) and the receiver (
callee). This patch provides an interface for threads to register as
a sender or a receiver with the kernel. Each sender and receiver has
its own data structure, along with a block of memory shared between the
user space and the kernel space, which is allocated through rpal_mmap().

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/Makefile   |   2 +-
 arch/x86/rpal/internal.h |   7 ++
 arch/x86/rpal/proc.c     |  12 +++
 arch/x86/rpal/service.c  |   6 ++
 arch/x86/rpal/thread.c   | 165 +++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h     |  79 +++++++++++++++++++
 include/linux/sched.h    |  15 ++++
 init/init_task.c         |   2 +
 kernel/fork.c            |   2 +
 9 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/rpal/thread.c

diff --git a/arch/x86/rpal/Makefile b/arch/x86/rpal/Makefile
index a5926fc19334..89f745382c51 100644
--- a/arch/x86/rpal/Makefile
+++ b/arch/x86/rpal/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_RPAL)		+= rpal.o
 
-rpal-y := service.o core.o mm.o proc.o
+rpal-y := service.o core.o mm.o proc.o thread.o
diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 65fd14a26f0e..3559c9c6e868 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -34,3 +34,10 @@ static inline void rpal_put_shared_page(struct rpal_shared_page *rsp)
 int rpal_mmap(struct file *filp, struct vm_area_struct *vma);
 struct rpal_shared_page *rpal_find_shared_page(struct rpal_service *rs,
 					       unsigned long addr);
+
+/* thread.c */
+int rpal_register_sender(unsigned long addr);
+int rpal_unregister_sender(void);
+int rpal_register_receiver(unsigned long addr);
+int rpal_unregister_receiver(void);
+void exit_rpal_thread(void);
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index 86947dc233d0..8a1e4a8a2271 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -51,6 +51,18 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case RPAL_IOCTL_GET_SERVICE_ID:
 		ret = put_user(cur->id, (int __user *)arg);
 		break;
+	case RPAL_IOCTL_REGISTER_SENDER:
+		ret = rpal_register_sender(arg);
+		break;
+	case RPAL_IOCTL_UNREGISTER_SENDER:
+		ret = rpal_unregister_sender();
+		break;
+	case RPAL_IOCTL_REGISTER_RECEIVER:
+		ret = rpal_register_receiver(arg);
+		break;
+	case RPAL_IOCTL_UNREGISTER_RECEIVER:
+		ret = rpal_unregister_receiver();
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index f29a046fc22f..42fb719dbb2a 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -176,6 +176,7 @@ struct rpal_service *rpal_register_service(void)
 	mutex_init(&rs->mutex);
 	rs->nr_shared_pages = 0;
 	INIT_LIST_HEAD(&rs->shared_pages);
+	atomic_set(&rs->thread_cnt, 0);
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -216,6 +217,9 @@ void rpal_unregister_service(struct rpal_service *rs)
 	if (!rs)
 		return;
 
+	while (atomic_read(&rs->thread_cnt) != 0)
+		schedule();
+
 	delete_service(rs);
 
 	pr_debug("rpal: unregister service, id: %d, tgid: %d\n", rs->id,
@@ -238,6 +242,8 @@ void exit_rpal(bool group_dead)
 	if (!rs)
 		return;
 
+	exit_rpal_thread();
+
 	current->rpal_rs = NULL;
 	rpal_put_service(rs);
 
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
new file mode 100644
index 000000000000..7550ad94b63f
--- /dev/null
+++ b/arch/x86/rpal/thread.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RPAL service level operations
+ * Copyright (c) 2025, ByteDance. All rights reserved.
+ *
+ *     Author: Jiadong Sun <sunjiadong.lff@bytedance.com>
+ */
+
+#include <linux/rpal.h>
+
+#include "internal.h"
+
+static void rpal_common_data_init(struct rpal_common_data *rcd)
+{
+	rcd->bp_task = current;
+	rcd->service_id = rpal_current_service()->id;
+}
+
+int rpal_register_sender(unsigned long addr)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_shared_page *rsp;
+	struct rpal_sender_data *rsd;
+	long ret = 0;
+
+	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rsp = rpal_find_shared_page(cur, addr);
+	if (!rsp) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (addr + sizeof(struct rpal_sender_call_context) >
+	    rsp->user_start + rsp->npage * PAGE_SIZE) {
+		ret = -EINVAL;
+		goto put_shared_page;
+	}
+
+	rsd = kzalloc(sizeof(*rsd), GFP_KERNEL);
+	if (rsd == NULL) {
+		ret = -ENOMEM;
+		goto put_shared_page;
+	}
+
+	rpal_common_data_init(&rsd->rcd);
+	rsd->rsp = rsp;
+	rsd->scc = (struct rpal_sender_call_context *)(addr - rsp->user_start +
+						       rsp->kernel_start);
+
+	current->rpal_sd = rsd;
+	rpal_set_current_thread_flag(RPAL_SENDER_BIT);
+
+	atomic_inc(&cur->thread_cnt);
+
+	return 0;
+
+put_shared_page:
+	rpal_put_shared_page(rsp);
+out:
+	return ret;
+}
+
+int rpal_unregister_sender(void)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_sender_data *rsd = current->rpal_sd;
+	long ret = 0;
+
+	if (!rpal_test_current_thread_flag(RPAL_SENDER_BIT)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rpal_put_shared_page(rsd->rsp);
+	rpal_clear_current_thread_flag(RPAL_SENDER_BIT);
+	kfree(rsd);
+
+	atomic_dec(&cur->thread_cnt);
+
+out:
+	return ret;
+}
+
+int rpal_register_receiver(unsigned long addr)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_receiver_data *rrd;
+	struct rpal_shared_page *rsp;
+	long ret = 0;
+
+	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rsp = rpal_find_shared_page(cur, addr);
+	if (!rsp) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (addr + sizeof(struct rpal_receiver_call_context) >
+	    rsp->user_start + rsp->npage * PAGE_SIZE) {
+		ret = -EINVAL;
+		goto put_shared_page;
+	}
+
+	rrd = kzalloc(sizeof(*rrd), GFP_KERNEL);
+	if (rrd == NULL) {
+		ret = -ENOMEM;
+		goto put_shared_page;
+	}
+
+	rpal_common_data_init(&rrd->rcd);
+	rrd->rsp = rsp;
+	rrd->rcc =
+		(struct rpal_receiver_call_context *)(addr - rsp->user_start +
+						      rsp->kernel_start);
+
+	current->rpal_rd = rrd;
+	rpal_set_current_thread_flag(RPAL_RECEIVER_BIT);
+
+	atomic_inc(&cur->thread_cnt);
+
+	return 0;
+
+put_shared_page:
+	rpal_put_shared_page(rsp);
+out:
+	return ret;
+}
+
+int rpal_unregister_receiver(void)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_receiver_data *rrd = current->rpal_rd;
+	long ret = 0;
+
+	if (!rpal_test_current_thread_flag(RPAL_RECEIVER_BIT)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rpal_put_shared_page(rrd->rsp);
+	rpal_clear_current_thread_flag(RPAL_RECEIVER_BIT);
+	kfree(rrd);
+
+	atomic_dec(&cur->thread_cnt);
+
+out:
+	return ret;
+}
+
+void exit_rpal_thread(void)
+{
+	if (rpal_test_current_thread_flag(RPAL_SENDER_BIT))
+		rpal_unregister_sender();
+
+	if (rpal_test_current_thread_flag(RPAL_RECEIVER_BIT))
+		rpal_unregister_receiver();
+}
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 986dfbd16fc9..c33425e896af 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -79,6 +79,11 @@
 
 extern unsigned long rpal_cap;
 
+enum rpal_task_flag_bits {
+	RPAL_SENDER_BIT,
+	RPAL_RECEIVER_BIT,
+};
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -117,6 +122,9 @@ struct rpal_service {
 	int nr_shared_pages;
 	struct list_head shared_pages;
 
+	/* sender/receiver thread count */
+	atomic_t thread_cnt;
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
@@ -149,10 +157,55 @@ struct rpal_shared_page {
 	struct list_head list;
 };
 
+struct rpal_common_data {
+	/* back pointer to task_struct */
+	struct task_struct *bp_task;
+	/* service id of rpal_service */
+	int service_id;
+};
+
+/* User registers state */
+struct rpal_task_context {
+	u64 r15;
+	u64 r14;
+	u64 r13;
+	u64 r12;
+	u64 rbx;
+	u64 rbp;
+	u64 rip;
+	u64 rsp;
+};
+
+struct rpal_receiver_call_context {
+	struct rpal_task_context rtc;
+	int receiver_id;
+};
+
+struct rpal_receiver_data {
+	struct rpal_common_data rcd;
+	struct rpal_shared_page *rsp;
+	struct rpal_receiver_call_context *rcc;
+};
+
+struct rpal_sender_call_context {
+	struct rpal_task_context rtc;
+	int sender_id;
+};
+
+struct rpal_sender_data {
+	struct rpal_common_data rcd;
+	struct rpal_shared_page *rsp;
+	struct rpal_sender_call_context *scc;
+};
+
 enum rpal_command_type {
 	RPAL_CMD_GET_API_VERSION_AND_CAP,
 	RPAL_CMD_GET_SERVICE_KEY,
 	RPAL_CMD_GET_SERVICE_ID,
+	RPAL_CMD_REGISTER_SENDER,
+	RPAL_CMD_UNREGISTER_SENDER,
+	RPAL_CMD_REGISTER_RECEIVER,
+	RPAL_CMD_UNREGISTER_RECEIVER,
 	RPAL_NR_CMD,
 };
 
@@ -165,6 +218,14 @@ enum rpal_command_type {
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_KEY, u64 *)
 #define RPAL_IOCTL_GET_SERVICE_ID \
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_GET_SERVICE_ID, int *)
+#define RPAL_IOCTL_REGISTER_SENDER \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REGISTER_SENDER, unsigned long)
+#define RPAL_IOCTL_UNREGISTER_SENDER \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_UNREGISTER_SENDER)
+#define RPAL_IOCTL_REGISTER_RECEIVER \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REGISTER_RECEIVER, unsigned long)
+#define RPAL_IOCTL_UNREGISTER_RECEIVER \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_UNREGISTER_RECEIVER)
 
 /**
  * @brief get new reference to a rpal service, a corresponding
@@ -200,8 +261,26 @@ static inline struct rpal_service *rpal_current_service(void)
 {
 	return current->rpal_rs;
 }
+
+static inline void rpal_set_current_thread_flag(unsigned long bit)
+{
+	set_bit(bit, &current->rpal_flag);
+}
+
+static inline void rpal_clear_current_thread_flag(unsigned long bit)
+{
+	clear_bit(bit, &current->rpal_flag);
+}
+
+static inline bool rpal_test_current_thread_flag(unsigned long bit)
+{
+	return test_bit(bit, &current->rpal_flag);
+}
 #else
 static inline struct rpal_service *rpal_current_service(void) { return NULL; }
+static inline void rpal_set_current_thread_flag(unsigned long bit) { }
+static inline void rpal_clear_current_thread_flag(unsigned long bit) { }
+static inline bool rpal_test_current_thread_flag(unsigned long bit) { return false; }
 #endif
 
 void rpal_unregister_service(struct rpal_service *rs);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ad35b197543c..5f25cc09fb71 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -72,6 +72,9 @@ struct rcu_node;
 struct reclaim_state;
 struct robust_list_head;
 struct root_domain;
+struct rpal_common_data;
+struct rpal_receiver_data;
+struct rpal_sender_data;
 struct rpal_service;
 struct rq;
 struct sched_attr;
@@ -1648,6 +1651,18 @@ struct task_struct {
 
 #ifdef CONFIG_RPAL
 	struct rpal_service			*rpal_rs;
+	unsigned long				rpal_flag;
+	/*
+	 * The first member of both rpal_sd and rpal_rd has a type
+	 * of struct rpal_common_data. So if we do not care whether
+	 * it is a struct rpal_sender_data or a struct rpal_receiver_data,
+	 * use rpal_cd instead of rpal_sd or rpal_rd.
+	 */
+	union {
+		struct rpal_common_data *rpal_cd;
+		struct rpal_sender_data *rpal_sd;
+		struct rpal_receiver_data *rpal_rd;
+	};
 #endif
 
 	/* CPU-specific state of this task: */
diff --git a/init/init_task.c b/init/init_task.c
index 0c5b1927da41..2eb08b96e66b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -222,6 +222,8 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_RPAL
 	.rpal_rs = NULL,
+	.rpal_flag = 0,
+	.rpal_cd = NULL,
 #endif
 };
 EXPORT_SYMBOL(init_task);
diff --git a/kernel/fork.c b/kernel/fork.c
index 1d1c8484a8f2..01cd48eadf68 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1220,6 +1220,8 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_RPAL
 	tsk->rpal_rs = NULL;
+	tsk->rpal_flag = 0;
+	tsk->rpal_cd = NULL;
 #endif
 	return tsk;
 
-- 
2.20.1


