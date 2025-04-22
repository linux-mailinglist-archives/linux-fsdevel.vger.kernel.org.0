Return-Path: <linux-fsdevel+bounces-46913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292AFA96721
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E7217B98D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBEA27BF6E;
	Tue, 22 Apr 2025 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCW4Nfk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCBC277007;
	Tue, 22 Apr 2025 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320841; cv=none; b=urXbRWGoBw5aiRJvx4xMzXOnpq7Y/uN5UkVbJ850funXrZ0+bUOSHwj3alF6Cef5J6DrSwWGm3PpGCmJITXeP24WjsIOV9nkq6CRkJiqjyOfGn8WtmOgisuFzQQ25cdzWIu00SxeTyvVvjmIAZBnjCZedJ7t3rg6zfNSNAQGGYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320841; c=relaxed/simple;
	bh=v79tuUzJsknYOjVLB6BsZ+WcPRCljmPtyO+yNb7By9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtmR6P64mkLOW5xySGSOKU3nlRzPVAzlbcktuGa2nCHuMQBe8ms+z5/1F/X7X5XQNfvHwzi+rvWTVR4QW4jbtk/LvbbtIkOcxJK+JarVykdmGeFvJtGyS1WiIt97qjoFcF7f2O7Uair314YeZEKImlrW8l4bWSRh4dglLgsiQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCW4Nfk+; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-736b0c68092so4141027b3a.0;
        Tue, 22 Apr 2025 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320839; x=1745925639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+51UIMj/tAmyUWH2Kok4OXqnacHZS1pAn+uExxikWCA=;
        b=aCW4Nfk+buzmGu8NgFMBPnkuYcBkqPd3hW+Ripkt44l7qFTbPcwTQiX6KBL+eiydPL
         TNkqlFA1gQtNhEtAClWxVYj72mKVBG7laRjEnrem8cJUSohZPU3IRfL39mUa8jdN+gi0
         fG4IsFcVOoxLkOTbr87ERRYFYz2gL1Lj8Fq/qMNCrrP1/F4qEzUEHwLnh7VRy3ozZTis
         OrEBfyiLC/jQJSi4x0IAdHYXGI1lWkmXqdiWKhb/a8jXeG8hMZPCsvQ0r3uT1NuiFkkl
         pyxG0EDxzWs7zkc/hPFbNFlECS4EhUIA2wacE+CWaIoyXO8DFLDLVxdWxM01zFFADPno
         zKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320839; x=1745925639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+51UIMj/tAmyUWH2Kok4OXqnacHZS1pAn+uExxikWCA=;
        b=rLNnEKrdzOPbVXLkdKhVzt81X8a0LyPAnnJDV0G+tocIbrcqy9dXoZdefOAeit/sMg
         7Uca8ekK3GhgmnHt79bp7parCB7bisdO38a0zq2Mpp2x2WT8Jf+p1vJJWapEgu4jrqb/
         pQ604kxkm2JH6Wq1URt4Ze+82LRoIjkARPliM/yFEMuIPXt+u1J/Jk5to7xCz751D4+k
         mRkBzj3JjMKN+i0EQ01TQoMmFPugZbfmhtd+0Kfou/g7kV5cpIJjGBqEfRhyRmhvccLP
         XOYV9nbzO+ed5UWEzJ2tYyGiLQnuhEVrOt4sgtF8XnoUztsGjX6NUqlCcMLivb3z+jrY
         o+/w==
X-Forwarded-Encrypted: i=1; AJvYcCUozUSYxEPNblYADTLK2w4IX5WNdEvLilcCHxUnHzABfKKHzWTFQal0ERbFvh1wVhvGYOquChgq9jPMswhw@vger.kernel.org, AJvYcCV0ONdEnPxORfcD23luQbKH8nW1pXj6oBDwJPtI0jUV17QOyxc81vkvOEyegMOHisSUGGaC6P3Ra8djdR8T@vger.kernel.org
X-Gm-Message-State: AOJu0YxbOvtw7PVT0p9dm9dcpMaLsGsrI6VOqRMJE/Vwl0DoxWi8I9M9
	Ron9NwnB0szkY4Eo26XPrWZlCTtPJ9oRFavUk0EVV1szv9RhgCx2bUAIKito
X-Gm-Gg: ASbGncvyfiAzMKa7Qiut0FToiOYxhcFSGhrG59agvankFjNMEYCHirk5VXrHJRCsjyP
	HS9R+L138YqvjFwLR6iFVqzMWiKQLqZ3W4CrPU6MJ0PoclHzntuFs61PVmcuduQy6rOAdZpb71Y
	A1uqR2PsvnnNlaKnrl2SRAES7cIjXEmkcyHnZ03/ARJnBQ9/0gkduRUa8avbNZpHyK8gz8nhGJn
	scS9Mnyfou8SWmFdmeQSXap4HzjZABW0S7ycM2c4WkY9NeCOTkez1NJ7ykFQgbaZcbYymcHJtxB
	0iYngEuJS2kmrwy6eLaR6uFuv63DHCLMg9dqcUQ/sKY8fhztkMD03w==
X-Google-Smtp-Source: AGHT+IHeBJWaKOspaVUlGPQwNmJ508mM1B9cKn79/KVY6fMHxm5j0xrib3BJO9F3wvdIJACOnil1mg==
X-Received: by 2002:a05:6a00:91d1:b0:73e:595:eb69 with SMTP id d2e1a72fcca58-73e0595f5f1mr1856372b3a.10.1745320839439;
        Tue, 22 Apr 2025 04:20:39 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e07a36e85sm771034b3a.61.2025.04.22.04.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:20:39 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: [PATCH RESEND 2/6] memcontrol: introduce the new mem_cgroup_scan_tasks()
Date: Tue, 22 Apr 2025 11:20:34 +0000
Message-Id: <20250422112034.3231352-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new mem_cgroup_scan_tasks function that strictly iterates
processes only within the current memcgroup, aligning its behavior with
its name.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1c1ce25fae4c..f9d663a7ccde 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -795,6 +795,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
 				   struct mem_cgroup_reclaim_cookie *);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
+void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+			   int (*)(struct task_struct *, void *), void *arg);
 void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);
 
@@ -1289,6 +1291,11 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 {
 }
 
+static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *), void *arg)
+{
+}
+
 static inline void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 		int (*fn)(struct task_struct *, void *), void *arg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3baf0a4e0674..629e2ce2d830 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1163,6 +1163,30 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 						dead_memcg);
 }
 
+/* *
+ * mem_cgroup_scan_tasks - iterate over tasks of only this memory cgroup.
+ * @memcg: the specified memory cgroup.
+ * @fn: function to call for each task
+ * @arg: argument passed to @fn
+ *
+ * Unlike mem_cgroup_tree_scan_tasks(), this function only iterate over
+ * these tasks attached to @memcg, not including any of its descendants
+ * memcg. And this could be called for the root memory cgroup.
+ */
+void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+			  int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&memcg->css, CSS_TASK_ITER_PROCS, &it);
+	while (!ret && (task = css_task_iter_next(&it)))
+		ret = fn(task, arg);
+
+	css_task_iter_end(&it);
+}
+
 /**
  * mem_cgroup_tree_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
-- 
2.39.3



