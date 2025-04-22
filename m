Return-Path: <linux-fsdevel+bounces-46915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D08A9672D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EDE87A9C9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588F27C150;
	Tue, 22 Apr 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3s4GwlH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD4278155;
	Tue, 22 Apr 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320917; cv=none; b=OsuptOec+JdqrvYO1zFa+rOiEnKTVAlGS6c3W5X4MWhC5dTsiRl/02ZPnxVlhF84TWeoITv0Kx/GJkDhFGNMtstfLVRt3WiQ/G038K8aHC99IAP1mgJuw1crut+HgEHLuFlfgUAj16cWuYA9jT6FnwdvSqaB2RcziYaM24o+BMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320917; c=relaxed/simple;
	bh=TNRSUrc5TE9XXI3xP8fPvpIyV+t/AfWY9OXp4kzcbJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtegIhsn2QjoYQH8E8ChW06m8sP3u5q1JcnziRyJFH0La3rGQ0xEigQiY/hKB/7qAZ0E8Wh23l0vbLWnplQE/TQnzgcTxUh9uvgdlLjqpAVF2WIi+Ec7FP79tpg1kbzm3lkMx5Q9TNug0NNjVokSmrbl4oncsiiiqb5CQlEjWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3s4GwlH; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7399838db7fso4735947b3a.0;
        Tue, 22 Apr 2025 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320915; x=1745925715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay6j05mfURnqC8saoeMr6ogRVsWqq76E2aDXfyh7ZmE=;
        b=Y3s4GwlH4S3rl4+Vet1dT0ofu3r46W0/rhdxISXj1Myut9LxV0cdrKqmy3XtQZLH+m
         un4NBVyvGkz4ffPdK0IkdHP1UozODMz1pmry5ziMesFHrKSlI6Kn3WyBKRaPskQFw3ti
         w/AqdpRiuI1AVniI6ijkLZMclHz7gY6GnvxZrq8xjXTSThQ7iBXxcTASC5UXnn3fkW//
         EHhEzXYPXu8GeHG8LSgUwL2YPVTKvL4FTlvEn7Th4Zgue5B/DlnYschcT3TRGxSjwJjS
         0b3Qqxq3HlOHuhSVu7dixFzq8DVWm4TrKU5UinVv2pevqc3BbBv22wKIpZQ1cK53vSdH
         oZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320915; x=1745925715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay6j05mfURnqC8saoeMr6ogRVsWqq76E2aDXfyh7ZmE=;
        b=OEE8eDdBMVc32/RASuRG0ErL7B4q4N+4i95tB8YNA0hRbA0pANBgcKZgFWG7+mzuUi
         9H+xGZHvPWw6V6t6nryWHZ63vsIkq3qdQrNfkaShabblR2gVUPDQHSJdm+JBq4gMqrQ8
         FTelQpu5rO5c26MdCDfe5fqpaIAawCJDPHUSfta5Mo0yw0UEQvcdftsSpxbdwQoi0V95
         lTTqEr9obkzsrv1ODlnEzzbR2h8zn6DlYiR8oisSCZw+w3OTAchN1VUsRVrA9cwYiWMQ
         0zwkVDxPaOL3MnvwaEG+x6xNnQS4l8Sac+hQ/2yvnA5L/ktDMrQLTrOVkw3Y2qt3qXFT
         NeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/oGORL56HULADHySaBmGlwanTky5QnK7t5UvHrDQ964vwKfcvoa+PxoMJLbBGiEweBvgJ4DVEWLo63jE@vger.kernel.org, AJvYcCWazQmigkX4Y9iQSY2O5c7X3zAfBW3YQwf8tu3uIx/a474v/KXPVWRL9wHsRjO+LD9F1Vv9tKARWnb8Skhc@vger.kernel.org
X-Gm-Message-State: AOJu0YwJukqRR53UZ9BeMNXb7V8hrf2iWUe6miMd9QtVZyMQIkmi0Hzl
	mKYIvU8kSy2SYPpQhk+SuNO1jl3XfvdF/wMxiCvpPwmmEG3yIcof
X-Gm-Gg: ASbGncurn+zon+LGcOq1p5a5I5XS9wrUdkWReTm5hvVgZwEYaKZt5IAFRcftlhWdbWL
	3D3y21+Bcrj60iejJNL/hxeVBK5y1bsVvwmyuYDaIqrcZVXb3s9ypnMWpKaubjkEs42Y8/1IdoK
	a/SmlqAHrGiSr40xDej5eIdcFuHMtXxygvVvDTxxyYhQ2fJqOQvQurd8E9r+AFtEqwtC3W7xHcw
	m3QR6TqlNA64/hsahq0M9+TXg5tgR2K8MjK4wC7yeboCNPCYh9zhC44CMXJTwtm9rAmDPUveqPJ
	trsEDWXhuaj3P/zS7if7saKHdxBQAqvXxXu3lKo7BsPoIDo9arSF9A==
X-Google-Smtp-Source: AGHT+IElSNYl0pqZodwt89usz0QznAvphdRaPmB4R7NXi4Ccq2spidwCw2TN/zF+md2MEsHlG+yqBA==
X-Received: by 2002:a05:6a00:6c92:b0:732:56a7:a935 with SMTP id d2e1a72fcca58-73dbe638b2bmr25405958b3a.12.1745320914872;
        Tue, 22 Apr 2025 04:21:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db145a6e5sm7117508a12.57.2025.04.22.04.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:21:54 -0700 (PDT)
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
Subject: [PATCH RESEND 4/6] memcontrol-v1: add ksm_zero_pages in cgroup/memory.ksm_stat
Date: Tue, 22 Apr 2025 11:21:49 +0000
Message-Id: <20250422112149.3231488-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_zero_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index fa57a5deb28c..9680749f4eef 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -11,6 +11,7 @@
 #include <linux/sort.h>
 #include <linux/file.h>
 #include <linux/seq_buf.h>
+#include <linux/ksm.h>
 
 #include "internal.h"
 #include "swap.h"
@@ -1824,6 +1825,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_KSM
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
+	long ksm_zero_pages;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1834,6 +1836,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	mm = get_task_mm(task);
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		mmput(mm);
 	}
 
@@ -1847,9 +1850,13 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 
 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
+	ksm_stat.ksm_zero_pages = 0;
+
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
 
 	return 0;
 }
-- 
2.39.3



