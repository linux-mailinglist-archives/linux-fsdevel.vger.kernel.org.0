Return-Path: <linux-fsdevel+bounces-50175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1751AC8ADE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B0027B5099
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7A22A7F8;
	Fri, 30 May 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UTab4Njo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F581F4E3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597461; cv=none; b=HDh4sDDcTRp/vNnAnnXDpL6etmr/8EFF0AELxC+8fa5EiiUrcxunqlWa2UllvG3/APWp8dcVEwS9hDv89O3ab6Nx/hPutSHjOT7qlHaO8tcYZYP7xcpLZW+D+RKNLPbTU0Hoqu+FHKDg7ua+XsoR9e8FLJ+eBQARa9Hnrg1FfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597461; c=relaxed/simple;
	bh=zWuwJn1AfK9f6Ju/rr0kFMON4yyaiLCS77HNg2YNluA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geD4hR6aGupV4u6KNuwtjZ1PIQn8uWtnltniK98M00LfhdCoWZBVxNJA/OU2KjYw21/CbdoJpbrNraVJxzbINZchThQQtgSWn27u+zlEUR82jySCBrpf4IklFtSkEX21LQKtH7iiojjMK1YxM6VWukMyEdEQkCaUicJIr7bmjcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UTab4Njo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4476d381so1639174a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597460; x=1749202260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZkk3bjH1sfOYp+VjBWd01Gh2LTXey//pWYFXMUcbnQ=;
        b=UTab4NjoLFxlKeL8jmboXD5UpJMWaUHx3DVCAYwZLB0nlwEIlfiWuXkN22bpxm4Vi9
         DTYrVN9yOy9VnBFeRgd2x8I5ZuuGH0WWwucVoUAv1AgR2lBacf6sTSZhDN9NNTQJoIq+
         n3v8UiML8CowCq3JUHmtMvuVFYD22l5wG/lZ7TwlFcSvwCvCiD1TKBltNVnDZClzfipx
         WdFgJsC2Qf54Z2bSF6uFlzzY/0CeWh0mm8ttBgqOtvLWFUdrFaRaSVGW7yjBXCRIWoiK
         UvmKF9rH2tUV1J9ndAicxUy3UJGVcmSqBxY7jkpzEAWmcB2KeTTE3GLIcbp0y9hjo+17
         XyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597460; x=1749202260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZkk3bjH1sfOYp+VjBWd01Gh2LTXey//pWYFXMUcbnQ=;
        b=o2YrP/Uyhv00UavIcjh+vUQcKWux8NzfQeHv3sphelGSL6IWn9vP/Y4qum96PCrg9r
         UjedIArgpIooybWJZi2mE80Nyv3m6ShVWjtslYhk6/1jZfzcKOzDhMKH5XZVOVCyNS+u
         qv5j1L5sCrpNYWWXTIlSqZiG4M48XF9nFmu1rMjITFXcYrSxuynGWWSjTqM/yrXKygjn
         YtCnILM5SZg6iidPKM1z1QIBmD9qYCIuoO9BsNFN9orzEO3w5UBRp3p4NRFvIEke9o4i
         iQBAyjbEsR25K9Xq0SLEFG8eUHo4qyjJHaPyCkrbcYGu0ouW084q00IivLV7e051iNel
         iyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqo/5CRkVG+tR7N3aKMtYjBQfFBwOLZxD4EJnttDLq3UcF8fIQYkHmLs54k0bRnTI34ZZo7QgBMP6vHVlR@vger.kernel.org
X-Gm-Message-State: AOJu0YybNcJwy0CMdSe+psSTxkr/Sk51jRFOg1j9Uh9yFOu+uVxqTyAP
	5ByJQ5OuwOYX67dUOGWvFAnhXdOHE0Qow5BQVVmTyl8zUAzqvsmNiQ9GBTjjs6GvF6M=
X-Gm-Gg: ASbGncvp6P4twaOYJUnRkq2JwX2MiSxC6CYmOV820XDusm9yxsHW49T8QV+Yz3/8tQT
	wBVQ3jpxJ9F/5NBtfUYH83cg12+RQ0eelPLST/Hrl/IQxqzOd1QtbWtsCE5cNA3+gBKCCrNVIjV
	DE7uKJ6Tt/Y0jysE7sQ+7KMUm4fnjQwJNVggozK+AlKF2vcJj0e1T+YCTiBUp4oJMh3QPT25UrK
	9AGnkrDfq7jDb/1/XnJI18qkuhUVwbnOfT17fsGqRuYFpX9WD0EuptNppgHovhv7hd1yYS0xc8M
	ZgWzM6BfgOH3Hl4hYF+UhvFMnPm/JrypH0msxHy/+6tijP7tMc59BIqPS78vXyQkIHOexcWrZRS
	i+bGNY1mGuNOGVtwVbNTIYNrWpa7Pio4=
X-Google-Smtp-Source: AGHT+IEDp+vpzbXXEsQMocz8uu8WDoupHL7dKOSkVefmCskmswDnpl1KI6oBSxmQepUxjo/3kPsGsg==
X-Received: by 2002:a17:90b:28c8:b0:30e:e9f1:8447 with SMTP id 98e67ed59e1d1-31214e11c6cmr9475340a91.4.1748597459572;
        Fri, 30 May 2025 02:30:59 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.30.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:30:59 -0700 (PDT)
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
Subject: [RFC v2 10/35] RPAL: allow service enable/disable
Date: Fri, 30 May 2025 17:27:38 +0800
Message-Id: <34c12765bcf534c5afedd10ee3e763695c6a045d.1748594840.git.libo.gcs85@bytedance.com>
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

Since RPAL involves communication between services, and services require
certain preparations (e.g., registering senders/receivers) before
communication, the kernel needs to sense whether a service is ready to
perform RPAL call-related operations.

This patch adds two interfaces: rpal_enable_service() and
rpal_disable_service(). rpal_enable_service() passes necessary information
to the kernel and marks the service as enabled. RPAL only permits
communication between services in the enabled state. rpal_disable_service()
clears the service's enabled state, thereby prohibiting communication
between the service and others via RPAL.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/internal.h |  2 ++
 arch/x86/rpal/proc.c     |  6 +++++
 arch/x86/rpal/service.c  | 50 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rpal.h     | 18 +++++++++++++++
 4 files changed, 76 insertions(+)

diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index 65f2cf4baf8f..769d3bbe5a6b 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -17,6 +17,8 @@ extern bool rpal_inited;
 /* service.c */
 int __init rpal_service_init(void);
 void __init rpal_service_exit(void);
+int rpal_enable_service(unsigned long arg);
+int rpal_disable_service(void);
 
 /* mm.c */
 static inline struct rpal_shared_page *
diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index 8a1e4a8a2271..acd814f31649 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -63,6 +63,12 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case RPAL_IOCTL_UNREGISTER_RECEIVER:
 		ret = rpal_unregister_receiver();
 		break;
+	case RPAL_IOCTL_ENABLE_SERVICE:
+		ret = rpal_enable_service(arg);
+		break;
+	case RPAL_IOCTL_DISABLE_SERVICE:
+		ret = rpal_disable_service();
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 42fb719dbb2a..8a7b679bc28b 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -177,6 +177,7 @@ struct rpal_service *rpal_register_service(void)
 	rs->nr_shared_pages = 0;
 	INIT_LIST_HEAD(&rs->shared_pages);
 	atomic_set(&rs->thread_cnt, 0);
+	rs->enabled = false;
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -228,6 +229,52 @@ void rpal_unregister_service(struct rpal_service *rs)
 	rpal_put_service(rs);
 }
 
+int rpal_enable_service(unsigned long arg)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_service_metadata rsm;
+	int ret = 0;
+
+	if (cur->bad_service) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = copy_from_user(&rsm, (void __user *)arg, sizeof(rsm));
+	if (ret) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	mutex_lock(&cur->mutex);
+	if (!cur->enabled) {
+		cur->rsm = rsm;
+		cur->enabled = true;
+	}
+	mutex_unlock(&cur->mutex);
+
+out:
+	return ret;
+}
+
+int rpal_disable_service(void)
+{
+	struct rpal_service *cur = rpal_current_service();
+	int ret = 0;
+
+	mutex_lock(&cur->mutex);
+	if (cur->enabled) {
+		cur->enabled = false;
+	} else {
+		ret = -EINVAL;
+		goto unlock_mutex;
+	}
+
+unlock_mutex:
+	mutex_unlock(&cur->mutex);
+	return ret;
+}
+
 void copy_rpal(struct task_struct *p)
 {
 	struct rpal_service *cur = rpal_current_service();
@@ -244,6 +291,9 @@ void exit_rpal(bool group_dead)
 
 	exit_rpal_thread();
 
+	if (group_dead)
+		rpal_disable_service();
+
 	current->rpal_rs = NULL;
 	rpal_put_service(rs);
 
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index c33425e896af..2e5010602177 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -84,6 +84,14 @@ enum rpal_task_flag_bits {
 	RPAL_RECEIVER_BIT,
 };
 
+/*
+ * user_meta will be sent to other service when requested.
+ */
+struct rpal_service_metadata {
+	unsigned long version;
+	void __user *user_meta;
+};
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -125,6 +133,10 @@ struct rpal_service {
 	/* sender/receiver thread count */
 	atomic_t thread_cnt;
 
+	/* service metadata */
+	bool enabled;
+	struct rpal_service_metadata rsm;
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
@@ -206,6 +218,8 @@ enum rpal_command_type {
 	RPAL_CMD_UNREGISTER_SENDER,
 	RPAL_CMD_REGISTER_RECEIVER,
 	RPAL_CMD_UNREGISTER_RECEIVER,
+	RPAL_CMD_ENABLE_SERVICE,
+	RPAL_CMD_DISABLE_SERVICE,
 	RPAL_NR_CMD,
 };
 
@@ -226,6 +240,10 @@ enum rpal_command_type {
 	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_REGISTER_RECEIVER, unsigned long)
 #define RPAL_IOCTL_UNREGISTER_RECEIVER \
 	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_UNREGISTER_RECEIVER)
+#define RPAL_IOCTL_ENABLE_SERVICE \
+	_IOWR(RPAL_IOCTL_MAGIC, RPAL_CMD_ENABLE_SERVICE, unsigned long)
+#define RPAL_IOCTL_DISABLE_SERVICE \
+	_IO(RPAL_IOCTL_MAGIC, RPAL_CMD_DISABLE_SERVICE)
 
 /**
  * @brief get new reference to a rpal service, a corresponding
-- 
2.20.1


