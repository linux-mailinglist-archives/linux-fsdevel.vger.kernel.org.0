Return-Path: <linux-fsdevel+bounces-47799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE024AA5A2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572F71C002B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9122FE06;
	Thu,  1 May 2025 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmTtlDBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04331C5F18;
	Thu,  1 May 2025 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072838; cv=none; b=nqCqPk1euV27N7Hmj44tDHnJD/1h9azrlkJ3J4NO+wc86aRKh3XLx4pX8aQdGTqPyavh3avAn/m2JT5FqRTKh0bslSRu7H7PS0wTsF2g+w2HmblsmvizQo1CK66/APuuK9yzZtID+ryTLuAsRQrRW4JC2PA7ak8YKY5Qqoccfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072838; c=relaxed/simple;
	bh=Ps6lR+ljBYMMnnb+sUxwpl0fPXuAzKc2idDDdy9QQi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MEHjxxCBhusyo1qjvbRtCEQfCnvGGs2m8QLT9beLEMXoeMNyWR6gVfYd483POBi8AUjYDRowV7AbnYQMf1dexyc8a80LUXvPNvv/nkt8VuqOG4SiEJsCIMpFBhH5kWAa6prZwBmcj9WdArJeTooDnEsXIfJOZ9/xljYSvyWp+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmTtlDBy; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2241053582dso8319355ad.1;
        Wed, 30 Apr 2025 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072835; x=1746677635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIk5P/ejsLPrdbPMn0Ve6H4xUkHSSg3SisVuP8kmDBA=;
        b=RmTtlDByxknIsdoShxX0RKoLQBCJ6u3QT3cBNjDtl5mTZAltY888TJgQg1CRKxvuAo
         BxqwotnpYYGCQx1pYg+wj9zEgc4GSGrcJJfQcWDgh0jWGDB51xlLx7BMZgYnaV3TbqUG
         aHCOYPkj9ETSFhF4t0IUfwGRaYsBSbKOn1p7qtNgIj1uqUaKEqB7L3Fc6ztpd2EUv72D
         ZRnR/bQRvaLUWjtpdLcUSu3cS+EvrHK4AKVBnrLp6v2432B8zTmgFkSbZAojhnoNlPzu
         DWosUhpv22uPB+S7DNkN0wLt9IzTU2bo1BLZh0Hsd9uuGyqUGLS7p+Dvt2dUunFUCLQJ
         3VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072835; x=1746677635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIk5P/ejsLPrdbPMn0Ve6H4xUkHSSg3SisVuP8kmDBA=;
        b=iwyoDY/ij0YgO/DwXfZ7/6hNP4bR/52Exph2G7B4M7JzpEQH+PjDYuvF+LvAQgB5QA
         GI2a1wJLbFUbdUVBszEa6aiFBI+NFRspEVutQfkl2I+ZJIOpOOKUHzNEo5XuIB+hQP+J
         YlflxufMUGBfkORCnuMtNIDnRf1Z31UDDCs9z9fN3lhPc4IGbi+vLwRcveibvtIWekMY
         58gTiWUDeeSJ08PIIFsBMuIEygDVUTFQ68CF8AVziawiOGF4JoR6R8zVvmY3UG2pWgFT
         Zc7qr0P+gBvCbNIbSje+uRtpt/vXpxUfI6FBqZvnPwixGb0/XZr8Lzx7ZmqsVEqRu9Ir
         g5Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWETnaR3SRnTS0HgSyDg9ColWLT+hdumHpNR4K4z8hCE58AVhsjqruNMLBVLA4Xk3F7BAiL1Vdk7MLrLQ2D@vger.kernel.org, AJvYcCXX9kgVmMvDIW4IVtDEOrnB0yFRLE3BajB6DwU5seE2PYxE5hP/jH7xZXOSQTA+SRi8MXIt5Z88ukldq7KH@vger.kernel.org
X-Gm-Message-State: AOJu0YxT/FxKHz/N7QNVqlKAlEpOvc6GiiKRyWVsj+ZD77UHDjczHIwC
	9TWQK8/3q0KgX3YOYRpi3SVedpZlWxYlgH/O488AuMYCtUTQ6eYj
X-Gm-Gg: ASbGncsEI++gCKs72JFVYFmSePYGPhBtGYP/UiuW6sJF3m7DnAqLw0i0kccfeayv+t0
	QPzmjH1H5vGAolpQpbQDSEmM6FKN6fxfmur1Ss5V+7x9uO09lXeCtqtCHd3Jb87dSjNsY9q0Plf
	od0MgjxrxSPd9596GY5s9qfb1HAV9hfzq//xO/EBq7iDCnL0ye0RebrLkXAfKOkfdTbibWuLy2T
	VmPoa/EhDOvP1GoUu6eBPbCTKll7kyyQm04CHCWgqyxsaHfp9L49xfIg/c4iKOPc25Z+soZ9N/F
	Wg6RpGEJA5MwDUb+rM5cGuTPTlR4f3KEtPtIHJP7SCc3/QPBSdOyJg==
X-Google-Smtp-Source: AGHT+IFSpSg6g2ApNTApEGIeTJvR6iuG7EXlp92mzkJ/HA1tiLw70I+wddiypjYWmIRDhTC+3u9n2Q==
X-Received: by 2002:a17:902:ec8e:b0:224:1781:a947 with SMTP id d9443c01a7336-22df578bce0mr78813545ad.21.1746072834969;
        Wed, 30 Apr 2025 21:13:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbdce2sm131036025ad.85.2025.04.30.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:13:54 -0700 (PDT)
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
Subject: [PATCH v2 2/9] memcontrol: introduce the new mem_cgroup_scan_tasks()
Date: Thu,  1 May 2025 04:13:50 +0000
Message-Id: <20250501041350.3324212-1-xu.xin16@zte.com.cn>
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
2.15.2



