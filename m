Return-Path: <linux-fsdevel+bounces-47803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88869AA5A37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37953B3FC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DE7CA4E;
	Thu,  1 May 2025 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvyryrNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D521DF98D;
	Thu,  1 May 2025 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072958; cv=none; b=QZ+iG03z/rSWSOUo7zwGWfa4arRaccNbcD4qngceHcWTEetp6BMetSzyyrBA8oUPUh6RiFD7WNE4QKfDF+Z7TzF1eqA33AiPo+/Sbqgg1T8cvcl8fpxkzfX8Z7psborcHW+i+9SPrN1g2uvC1Y3FeQUebt1ETu8Y//Ngky4m8Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072958; c=relaxed/simple;
	bh=geH6V48P/zVTAmN4U2a/Rf8voMJ08N5ZCdRLj5h0yYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2ZuWa1pNPBtlr1NeIJ6rW3HvffzfIULsN7U6Cc3ceHrT/2hLKwr8Qh8/1PokMWNcp+chuEsppY/LIgkpYRS1FvF6Q6fp/zJRGHYKStruoP7rg6Ar/V1L2ZKKaQM2ynly82v+b4igaGUWoV0xKnL6qTahIWDTkKvj+cBih8WUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvyryrNj; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so395674a12.3;
        Wed, 30 Apr 2025 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072956; x=1746677756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joXCGnOLEZovFd4Cq/aH1We34Qnzyjp4Ndw1KlcoW0I=;
        b=AvyryrNjbUw7e9rMayF+poeXOP+ZsDaNkG/I/buIpLRVboJ9ee07+J02qwmUrdwdmY
         o+20dF4XaPb9NuhYFyPJR5As0z/OYxzHK0X2gtI5XacB2r6jFeWj4QMCMDoc2ydH3iHp
         Ct+TqS4IdcsYY7spRtEO8YDNxv5Al606fL6JjnoEJwHJIKiPF1/M0ohAUjn7JkYNuy7M
         WAB+5HbWHffyVzdO+rQymDvbhiWP+eaDC31cCsfSIx1bnYyJb3j2mPw3ERWhBV+SnI2T
         VWR+28EGUkOmKDb4X+Ckef2eBSeX5kIBTQMVeqh/uTOXe/7vvugTXqc28eMH1MDbN/T6
         8HjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072956; x=1746677756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joXCGnOLEZovFd4Cq/aH1We34Qnzyjp4Ndw1KlcoW0I=;
        b=RXf92qwjQ6eMginrvGh32q3foZgbVBgapLGQLnObMerQVGUGwHC3tumkhDbbBcqwGZ
         ltLJgZOoS27OoE0SIm4SP7zmbUsYpd4qpo2ro1PDUsPfzrw1YogJUlHU3Ql3zmEvktJ7
         LwK6h2udKWoCuragn5IEGJ6KqslfVIFueIqWYbP7fS2YPH+CjEA3/kd48qD7/XNrCE0J
         qwm4aCTcbWFEA/A8ieVMzQpJN3NPLOUjWfL6/VJJiWQk4NX066VJjCOv4K10yCjuSn0q
         BMHHeVudvH81sSr0k2TiY1RuTKEJ9GPUF/TkxQgtzc+LkzLWBnj8XSFHSayZ8MbWrqd8
         yezA==
X-Forwarded-Encrypted: i=1; AJvYcCW3T2rqX/IKYAxC/Se1gtn2MY6zkFSqgr9OJ97wKavQKcjDY4Pn4JznxMD638jqOJJhNNvYwrvEa2aILa5r@vger.kernel.org, AJvYcCWsaM4v31YP65mmvHmTO+OB4b/u8np9aicanwQgSV8u4eZZS6v5LCEojC5Juqz+KOFp9HI8cgcU589oyBnt@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLeDxw1qePOLFZWEcYkFiSHoDmbRkByoBB8W4i8Mny5V9hWJ4
	idilMKFlCOJGce9C/g9kWuBNwZhy52KAv4LnE6mwvtO6S08dVtP8AM75m0+o
X-Gm-Gg: ASbGnctCqeHai38syZkN1T/biqgDb/Srzj8nT9Dc+tupBCKLE1uczVsuOwyU0zuEJMd
	/8XIXf+Eub+AQweLv4gV312tTJvFjF73ZP1mZqMwRosQbAxFBgdXNfOlbB624DSqno64/URrIwE
	YlZAIGldMlZlVr5/qQvZj/Ha+HSj5uY+NRJBV2BlZ8JToY+B3OcnN0347LsWCKVkfm+cNon7L4M
	UFXOrBFDnO2+aHuep4Q4dY8L2aoU2ZifvPNM6OFDZZdPxJ2VIqvJfetRgpH1UbbXC/FI9Bfzd6o
	QGRZGohLZsTAB39QzWmi5nLphilyAiakw76HI4wfWNxnUVRd1aRxog==
X-Google-Smtp-Source: AGHT+IFrVUrrdjXtX28HF5q+Y5KrvFqxCG/XexHXBL6W9sDunZDSHv9kPRBMKLDWiJcck0lgchVi/g==
X-Received: by 2002:a17:902:f685:b0:224:abb:92c with SMTP id d9443c01a7336-22e0425a178mr22826855ad.50.1746072955794;
        Wed, 30 Apr 2025 21:15:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a3bcf1sm2571247a91.37.2025.04.30.21.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:15:55 -0700 (PDT)
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
Subject: [PATCH v2 6/9] memcontrol: add ksm_profit in cgroup/memory.ksm_stat
Date: Thu,  1 May 2025 04:15:49 +0000
Message-Id: <20250501041549.3324472-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_profit of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 76800
ksm_profit 309657600

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9569d32944e3..8ab21420ebb8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4394,6 +4394,7 @@ struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
 	unsigned long ksm_merging_pages;
+	long ksm_profit;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -4406,6 +4407,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
+		ksm_stat->ksm_profit += ksm_process_profit(mm);
 		mmput(mm);
 	}
 
@@ -4421,6 +4423,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
 	ksm_stat.ksm_merging_pages = 0;
+	ksm_stat.ksm_profit = 0;
 
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
@@ -4428,6 +4431,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
 	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);
+	seq_printf(m, "ksm_profit %ld\n", ksm_stat.ksm_profit);
 
 	return 0;
 }
-- 
2.15.2



