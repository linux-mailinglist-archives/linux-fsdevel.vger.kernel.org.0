Return-Path: <linux-fsdevel+bounces-47800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B408AA5A30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FF71C00415
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB6522FF35;
	Thu,  1 May 2025 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMyHOVne"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE322F749;
	Thu,  1 May 2025 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072867; cv=none; b=gzB3hqQSjNyaZyXPH0OGwqHUgt9dcpjQZRtvIVKKFmxDW+bSwqXkajVROkGEPx1RA8PRCSlCFRW0lHBwH7v928RftWmsdzp/WoKNMKdY6RRxI/kmmLf20jTJfbvBWtqfEGQKPDbYr3r8TLZNghxgivsOYEIktvrcRDAn7/ipDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072867; c=relaxed/simple;
	bh=tIrJAgCP68nCudViWm5qwZYmcNHoXqmvQI6Qg0l4gBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FG47zOuc/Bx5AyAmxcw5pchOpkFO9sb4drjpsphxUMhHu9eB9GIjRyLRBqAChZQjBBd3Q/DEqD1wENvPK200Ij70xlIKMEpwA4cun/rHIE/xcv4S2Dmg5DqbvdLgka0vGRMjCOTQd9noXt3sIrU/paKJ6C1ZL5dNqUn9EnM6xUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMyHOVne; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7370a2d1981so483287b3a.2;
        Wed, 30 Apr 2025 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072865; x=1746677665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRsldxeP3L7LcldfEvyCBZ645cQKKVexyC6xDBrpilg=;
        b=MMyHOVnerGBIeWIEOvKhYlLarJk8xenSLf4hOJYlNjiWENjEfCGHXlr9S3tSyz05rZ
         xG2s4ROmwCyOPpRx2LY2KLJzNrgeAb1WrIiuFgMOAL6n0KF5mDQTfJUx7/HahgIJGhxQ
         YFQSNmnZ7+ACewnnoqh3xHDfG45My1F2scLecjI7uVJ69bn5Ec2NAoB0kAx19jFrEpsr
         PdMY5wfgr5LDSMnfPSqv2eIblJnAgfagxojUIYRdMOWC5jgLqZuFDAbE6tFUbqhXklrB
         bK6dWW1zOZPhuFL5ZztdyUJRWzZBU3ZtgV+boat3vUMj00rC9+PDNVXV2q0eswHjs7vu
         6RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072865; x=1746677665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRsldxeP3L7LcldfEvyCBZ645cQKKVexyC6xDBrpilg=;
        b=BiGiBD7O6qcYcFH1wgDvW/6uF374aqub441xqzrsW/PbPGYioZ/UAZghQ19g6TXBic
         ksB/MQiIBvDrTc18ZEt8xFsRt5+4UFaiNED1wy9VjDMxB/uTIP4eMwLYbOB3UMYc3Wqt
         1Q4w++v3J1SrgVX/6jTQX3luOUb7X54HZfnBGA2QZwvI+J2QcqPNf1kSNhQkN0Jf1SqZ
         kr5ZPyrjVWX55nkbrPLPrbCK6FiqwK6ucZLNt3985gES/p3dr86fTGgeWkjQ5S2pV13o
         wYLiD4ZllBPs0YNkmGvU7yRtr7wOF8b0UKdkgssh4Y4oWl5WYDBah9YM6gppDesD5rf6
         OmDA==
X-Forwarded-Encrypted: i=1; AJvYcCUAZNVQpt2B3fXxSOYs3mBPugEXNnipx9bYgdNIknG5PuXXs5i8Gh0E98Bs7BFB1hVUgaJ/qlMxdoYvKWQJ@vger.kernel.org, AJvYcCX+sfQ8gQoWCULbaimTcJHGtHwfwZfmAI50/FBUKyFNfwDOk/lTpahKTF8m/x7TpDDKvEWAG2rTLjyEI4Io@vger.kernel.org
X-Gm-Message-State: AOJu0YzXH8GkxjJkFtN0tISNwz/as+Pmpu/7R+e76rqs5DsMJ7KV9ncE
	KpZHk77I0wNqfMUNhEFnu2NIQlU+4xiJnmPh05vTPNmmcDCdiDXx
X-Gm-Gg: ASbGncupKoJytCrmUVHxI5Gy7VVUS88D9JESZv3wNGs6agbRco6a/RoDae3536SAcek
	5vmSqalaQju8P2Zi8lUMYOwnW3R3bHxkg3bU37pKLv3TGdGfeUlwlx3INCfg/YVNtuzA//Zti1T
	dKAtS5aKe/2kXzora4LrVbjbzvwFLVDSkbVnkCz/0Kro10flChnWE6moRd67gnWnZp8LruTA9hz
	OWSvitoxI7O9tr+WI/DCv6+DMkxKe698WBhYa/WBCRb1vsC+NGNf+UeXoxOPYhj8Mx3gB52kPW1
	Ry0ZQpbS2b2j4isnTQA880ZHWnCcZvGmYpbaQOSZiJ/BIIdum51HPw==
X-Google-Smtp-Source: AGHT+IFY/cCkGicCkAIMvgxbCrgAAD6LUmISXFDWa/nrZSZ7OZtQqHaWxeuAu+qJqAIisyQhhXqtSw==
X-Received: by 2002:a05:6a00:3e1d:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-740477650ddmr2394745b3a.2.1746072864580;
        Wed, 30 Apr 2025 21:14:24 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7403991f046sm2571637b3a.41.2025.04.30.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:14:24 -0700 (PDT)
From: xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn,
	Haonan Chen <chen.haonan2@zte.com.cn>
Subject: [PATCH v2 3/9] memcontrol: introduce ksm_stat at memcg-v2
Date: Thu,  1 May 2025 04:14:18 +0000
Message-Id: <20250501041418.3324279-1-xu.xin16@zte.com.cn>
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
each individual process within the memcg-v2.

Users can obtain the KSM information of a cgroup just by:

        `cat /sys/fs/cgroup/memory.ksm_stat`

Co-developed-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 629e2ce2d830..69521a66639b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4388,6 +4388,40 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 }
 #endif
 
+#ifdef CONFIG_KSM
+struct memcg_ksm_stat {
+	unsigned long ksm_rmap_items;
+};
+
+static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
+{
+	struct mm_struct *mm;
+	struct memcg_ksm_stat *ksm_stat = arg;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		mmput(mm);
+	}
+
+	return 0;
+}
+
+static int memcg_ksm_stat_show(struct seq_file *m, void *v)
+{
+	struct memcg_ksm_stat ksm_stat;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	/* Initialization */
+	ksm_stat.ksm_rmap_items = 0;
+	/* summing all processes'ksm statistic items of this cgroup hierarchy */
+	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+
+	return 0;
+}
+#endif
+
 static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -4554,6 +4588,12 @@ static struct cftype memory_files[] = {
 		.name = "numa_stat",
 		.seq_show = memory_numa_stat_show,
 	},
+#endif
+#ifdef CONFIG_KSM
+	{
+		.name = "ksm_stat",
+		.seq_show = memcg_ksm_stat_show,
+	},
 #endif
 	{
 		.name = "oom.group",
-- 
2.15.2



