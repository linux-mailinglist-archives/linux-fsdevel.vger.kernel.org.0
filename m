Return-Path: <linux-fsdevel+bounces-46914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450BA96724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034B17A5023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EB27BF69;
	Tue, 22 Apr 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr4o2fv+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607254764;
	Tue, 22 Apr 2025 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320867; cv=none; b=CBtQogChUDuwOb3EPugMOcG93YoY8txKY3KgEE+jEcwCX7iUXDXdSfxqQkImX/XjzCzwBCXNSIwWWvuVPsnTtvobwX6umJUFlNZnSaHTzJCwziERwxvHL5DaLeGpPCMIe9/VvZ78VPn1I3qF+zr9CMTl+TP4HANB6xZhVpjzeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320867; c=relaxed/simple;
	bh=IPqThohrNrb14qg7kK50tnIgh5tqBtPfuWv5BV6ZmqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNfTU9G+RhfT3ImNyFerhImKZ+W9sGyem7MrAjkVJRGQ5i4KGwuz9bXEXZ4H0A/hTiq2K+Z5qqHtvZUMMjfzsJ//3FSk91UlHvGEfzGkR7gHSu0vEANC0KOU0jp0vNWfyWFa/48drIgpwKLvMG4CURmH6xyvkR8GZuNaxEuUIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr4o2fv+; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-af52a624283so4196552a12.0;
        Tue, 22 Apr 2025 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320865; x=1745925665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzVjEqH9gmBT7W+O25sQBmGvPMeq7/0Zax5Q2ZZ3sF0=;
        b=mr4o2fv+bvukap8ejUIOif4ssW/pT86jeEmNb5IitHfbic2qydNR5DZM3eUNXx93yi
         ZASw3kvhOjmamc8zoNjyiI57S1d7yvcvBq5L9T7jaUFpqYA9/YvNqMecifzrW5sROz3r
         GL2vQtGHVLcZ1Ch9cL9i3v6ZV7sNJm4QVrQ/VWG+EgryxIVZahWykFMiq7niIhkhKCnl
         F2W5nb5tnBqGoVYJtyD/CimUtSwmtYc1xh45KWU2+vAbwP9V3qXiTj7iSv5vKcPkSdt7
         chof5NBrqkfVdzJgfejVAY8iRmSz5VoigJewlN288XLZxbZ3NKUFDk6Z/Rqq2bJhFQdE
         96sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320865; x=1745925665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzVjEqH9gmBT7W+O25sQBmGvPMeq7/0Zax5Q2ZZ3sF0=;
        b=NXQHvmmLiu8K99mwKgcmLwT4A4n6DeFOqduE+nZvyNPwVwXggxa+ZcmeYDUDydbeRb
         umNNYhKjvj8HY3Z5TVjL7TmcEVM0LT9lyWQHqg83tDInB9u3wROKEh+vrQO6iN4FRhxg
         bHocprqK/NX8UKztJxntiJ9ua1vF+/1vthchsWsldCUUk34a0zUgFvBgLsf+S8TP1XAM
         9wR0v03417wAgNz7SmHuXHcYE+KWJziGnVpJfdwp9xRzEB64IoRPk7C+0s2tEYLkCfcU
         BNNToD1Ew1zrUCUrAs9pLXMxzgipi1ZmvhzOzFe5QX59R/ofgqtOHQU8HAHK45n+T2Ga
         3e0g==
X-Forwarded-Encrypted: i=1; AJvYcCWwjZ/zi0P4G7kijUpfM39RcUQcFQmpgIVHakY0JYV0CGwUW+bDa5rrGmZ2r22MxZafA2PwHQLwENjXcjFV@vger.kernel.org, AJvYcCXtsCO7Lu9DbiF4cbp+wZ2KMI2XMdxrXAdWGIs9ArZ2AbcZj9sM3jit7J9bIsdwxJxu9twV78mm/+vM0NuM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5gmmrT/jGxYNghdu7rD2Hcmcd1ZN3xkMkOo/YOuJexvLXXH2
	6BXZHMgDwqRjqKxX4OaKkDxyNfno+m2MmEUEdrFvnZ5KkEdmLtwJkx4Hx7vi
X-Gm-Gg: ASbGncsembfseCngOiHroz06ei9FGYSVeg4qGUi+L62iwwXw267qaqSFZay2MPmem5H
	NCRZGHRQ69VFenogj+QDnrJlKbQA/cY5kwdnidcBa9hR2pFTW+zTQ+3nr6vivAtFFdwzK0aS0cr
	XYf+R7i0HqAw2n2/XsYLyCdkLqh89O8fRkqMN56tk3T6YqkLmG29tvIwgqwVBMvqbCV0zhQl9x5
	ICI30FyfyJOIcHDXfgUmlLj44AF6Jz4oqGKv2h9v6cD5oCMm/6dTkhAA6QRsRW1zRillXO+ruV4
	FEceLCE5IVOFLkL/44Ryk4Rh6zB6UYjWaQBzEPWpOGMrOwZg41w/9w==
X-Google-Smtp-Source: AGHT+IFcLvIZAAA93Q8p9CitaCdEdVo3WX3OoJg88nczIzlRYdY9yiCqeoEyVu9YUpb/6Y/8xaEHLg==
X-Received: by 2002:a17:90b:1f89:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-30879ab03f7mr22438054a91.4.1745320864970;
        Tue, 22 Apr 2025 04:21:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4edesm81987245ad.123.2025.04.22.04.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:21:04 -0700 (PDT)
From: xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wang.yaxin@zte.com.cn,
	yang.yang29@zte.com.cn,
	Haonan Chen <chen.haonan2@zte.com.cn>
Subject: [PATCH RESEND 3/6] memcontrol-v1: introduce ksm_stat at cgroup level
Date: Tue, 22 Apr 2025 11:21:00 +0000
Message-Id: <20250422112100.3231419-1-xu.xin16@zte.com.cn>
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

With the enablement of container-level KSM (e.g., via prctl), there is a
growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related
metrics.

This patch introduces a new interface named ksm_stat
at the cgroup hierarchy level, enabling users to monitor KSM merging
statistics specifically for containers where this feature has been
activated, eliminating the need to manually inspect KSM information for
each individual process within the cgroup.

Users can obtain the KSM information of a cgroup just by:

        `cat /sys/fs/cgroup/memory.ksm_stat`

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Co-developed-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: Haonan Chen <chen.haonan2@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4a9cf27a70af..fa57a5deb28c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1821,6 +1821,40 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_NUMA */
 
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
 static const unsigned int memcg1_stats[] = {
 	NR_FILE_PAGES,
 	NR_ANON_MAPPED,
@@ -2079,6 +2113,12 @@ struct cftype mem_cgroup_legacy_files[] = {
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
-- 
2.39.3



