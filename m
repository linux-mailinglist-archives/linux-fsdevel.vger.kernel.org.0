Return-Path: <linux-fsdevel+bounces-47804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F9CAA5A3A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F34E06DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84021B9E7;
	Thu,  1 May 2025 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le6O0VMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292ACA4E;
	Thu,  1 May 2025 04:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073016; cv=none; b=n6pIND0nR0Ft4v6H5MYGbRfsmfCopCyYQ8gj014dQrTJ1lvZ/6t9s4WIu406VxTre8bpCZ9XGqKLvgt+zWMdJWeyGAeVcHVpkXXNHe7ATnMn4/T0BomtEYgNjSMpyiBQFQabzdKxcR8Ycv7CBS0OwXoZevfiwfUu9dSrc6YUtO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073016; c=relaxed/simple;
	bh=lUs8EJiyEGr6p/1PLbJmdNja3jVSs8zbcMfVO1RsAVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E/119aw/+0gjghjcaH8dATiwS2FAYzQ427bj2Pm1MtzykYvesfQD0CKNFOI52WE0HOvwRAz0IFOBUUCkMpeecgb/gGePnAc6YuH6KF8V7YOyfiJSpwVad3KpAntXkIQ5fUf+CmghWuY+Yb55mTl7Uzhxm/VtOOUySNgY9Y4ll+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le6O0VMa; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3015001f862so441839a91.3;
        Wed, 30 Apr 2025 21:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746073013; x=1746677813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e267ZtJ1ZkJztGP0++gAXgcgqqIPPYKaOinMj59fXW0=;
        b=Le6O0VMaNHRzlM0EKXVMIoTNzyDxh0SGer5OAqWpuBcjDTDIheOcItXFi5F0+YcoU2
         A0/bsTzaBbUX8YSxeimmP5NyKhzPWUR08LJFRioV1sBV0OUxvFhZO3ZhDxEJnqqsZmE2
         lm3Xlk0i9/lKgs/b0GNJy48kWPcDVjZaNIFGh/yYtxtULT/u5aU1O0sLaoa2dPh5XsUi
         KBAZLz92DaxXSLS1MXkfLsA1PIvQvyFSl2uUpuyoxoFvA30HyJ+w9iexarSy0UXlP+0E
         V5v4xYn3GJZrHQzLwR2G3K6cPCdPrzX0uLJ1AKeIga+3N3S+0lEMDk4czHS0sXffvh4L
         o5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746073013; x=1746677813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e267ZtJ1ZkJztGP0++gAXgcgqqIPPYKaOinMj59fXW0=;
        b=wbOyLUbqi33ak86XRY7pIOWbVfCMKkSEdYEbj1ks996o3rZtFvN/RQk7BN4HKhLmWs
         JV/5vVfTmnPhUWDv1DLzJRp8OZmBzAv7br5UFdiN4tAgAAUdiLW65zv4yF8MgcvTX4au
         Ga1CZNskTOCpQ6RQiWGPPHjWvMpDJpvJ/Nl/2NdkJRIsSlygcEgogLxRcJW5eMjJJtrw
         muLwXiGY4dTvosQQZIVP7Hvn3xi/xcClS+/Z0eHWZTDYTsUpVDTaM9GcopFmGNe/pPqM
         EskF53wjJiFvpp7L7jJn7+iqH6XNRAlCqLJPc2hUuu48O4Qazs+4V2POmthsG/JOdSHG
         g1sg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/gmHCdP+C1JdJJTCAZjmH8EQ8p7oH6hOkUfnNFSO3gB1SAO4QL39kvxYyJIDsoC0kXFgkzBzZxnRyB3Y@vger.kernel.org, AJvYcCXxxP6eDSAhsvYVlUUNDBw4djY1+cZvDMNShw6FW3DG88HPpuDSYR/bnemjM+QxMWK/PVo9vasdzHdUvtKr@vger.kernel.org
X-Gm-Message-State: AOJu0YzonIafSbCFKR5ZJPahypuyx+5ql4PRTfBhKaZ0Mkjl1eJYazIe
	LSYQDTbIkxXFpruVvUNDnP/07WydfsT0U8drxI90KCm8rppLS90t
X-Gm-Gg: ASbGncvK5OEQl+Ql1yZOrNmo0o1zXBqMncST2Pavy6YjFBZcSkt8XzB9yP1lIjJvQFP
	KopaSZeV1tc+AhuHcZKUjB74mbEqhiYl5tWtciDlCmzPDtJq8ebNrCTtu+umSyZgEQTZNWpvuWm
	oTqrvnI5or/aHUovOYh117Q0o1FPHVp4RQ/LWYCp/3RchmN3TRh93aHkUhe4CvK+8EwRRaowhZv
	SNFpVKL21l6GZdj4sn3Vm+MAPYTYHjW9FrUPLil6iGbOWmT3kTWlE/jd4Yo76dq7LiHALzuQDsK
	v+rX5rGvWfuUoMT73uqH9iX0tqSAcrKntK2sOtidfUJTNaav+A8u+A==
X-Google-Smtp-Source: AGHT+IEzY5R3iNEkJoRaDyBSxa6xzJCwxk54f9/TLZvds2D37t+5BVfn97oR4mhD0+7nW44TJvp8Fg==
X-Received: by 2002:a17:90b:57eb:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-30a332df61fmr8763348a91.2.1746073012942;
        Wed, 30 Apr 2025 21:16:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a385f613dsm1911678a91.40.2025.04.30.21.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:16:52 -0700 (PDT)
From: xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH v2 7/9] memcontrol-v1: add ksm_stat at memcg-v1
Date: Thu,  1 May 2025 04:16:47 +0000
Message-Id: <20250501041647.3324541-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
References: <20250501120854885LyBCW0syCGojqnJ8crLVl@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xu xin <xu.xin16@zte.com.cn>

With the enablement of container-level KSM (e.g., via prctl), there is a
growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related
metrics.

This patch introduces a new interface named ksm_stat
at the cgroup hierarchy level, enabling users to monitor KSM merging
statistics specifically for containers where this feature has been
activated, eliminating the need to manually inspect KSM information for
each individual process within the cgroup-v1.

Since the implementation of ksm_stat has been added into memcg-v2, this
just add it back to memcg-v1 with the same function of traversing the
process of the memcg.

Users can obtain the KSM information of a cgroup just by:

        `cat /sys/fs/cgroup/memory.ksm_stat`

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/memcontrol.h | 7 +++++++
 mm/memcontrol-v1.c         | 6 ++++++
 mm/memcontrol.c            | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f9d663a7ccde..880ed3619f57 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -939,6 +939,8 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
 
+int memcg_ksm_stat_show(struct seq_file *m, void *v);
+
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
@@ -1415,6 +1417,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline int memcg_ksm_stat_show(struct seq_file *m, void *v)
+{
+	return 0;
+}
+
 static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4a9cf27a70af..0891ae3dae78 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2079,6 +2079,12 @@ struct cftype mem_cgroup_legacy_files[] = {
 		.name = "numa_stat",
 		.seq_show = memcg_numa_stat_show,
 	},
+#endif
+#ifdef CONFIG_KSM
+	{
+		.name = "ksm_stat",
+		.seq_show = memcg_ksm_stat_show,
+	},
 #endif
 	{
 		.name = "kmem.limit_in_bytes",
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8ab21420ebb8..cf4e9d47bb40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4414,7 +4414,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	return 0;
 }
 
-static int memcg_ksm_stat_show(struct seq_file *m, void *v)
+int memcg_ksm_stat_show(struct seq_file *m, void *v)
 {
 	struct memcg_ksm_stat ksm_stat;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-- 
2.15.2



