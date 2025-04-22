Return-Path: <linux-fsdevel+bounces-46916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364CA9672F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAE17CD5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99227BF76;
	Tue, 22 Apr 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax4LKyBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF4205AB9;
	Tue, 22 Apr 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320939; cv=none; b=ZoA0A28mWaSthwle/u0Lk/lMau4zOL+JWKRVaKmxX3xe9/fkJqBf3C59iwX3Jq35+9GVbOwqdpIvixpV6e0TwusGbAPmSN3t8XPqL1o5HJilEM35jAdNUQLpdKUedMyXtJ6Ncq6Jq2sG0rvGUOuCznqswehpFxM4kDGdgehmqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320939; c=relaxed/simple;
	bh=SndDk9lFilyFEwknU6l1kVt5eBocGlhdR/QDHNaeOc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=de4cHqOJfhtpyJG0I0wr3q51eTNOwL+OHFZznWwut8xq2PkHrawae3VEIc3hq1GWjxTOyeYr2nbmRdiDuF6N2bhwTTa2UHJtBKoMmKC5j/w2sTw/ecqNJ+kDDg0NT27TS477YG+E1bmKQwhvBb5ExqGDDZ0+QUA8jlfQYBJeIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax4LKyBU; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-225df540edcso60129715ad.0;
        Tue, 22 Apr 2025 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320937; x=1745925737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tsGpJe+O9OqTQTb4juPo3OSnKvTqZ5uffJhyh+PLhk=;
        b=Ax4LKyBUPSizR2xSLB5AGeRviAf0RAEfWon9w3KYMlqcMEo6u7XCiCD6c4B1wwdll5
         B0lsii7kvpmQm9cjIdtF+BbIzuSaDD06HYd2V0QL8C/r+q6bzU597+vZTx0HK4T15KjS
         5BqeL4MKDEi7ViZ67xKpgH7dhVxIAunHVKtfvGRYpaLvDC1nFJJ2uO4FrFoP8w0yfqjX
         w4zbijMFTWGIDZ5euUMiR8PTgqQBkIfzlCJooGNyH16T6xR+MHVzSnCUnVinLtyth6Zm
         X3zRK5Pv/xd3rMnUlS9suPu+r8nXT9hP7WcRBD6ztdtaSp/C/Yao4W3myRO2jRjsF6rc
         EjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320937; x=1745925737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tsGpJe+O9OqTQTb4juPo3OSnKvTqZ5uffJhyh+PLhk=;
        b=xGMeAwg9APrIG2YpZQR3a5E7JCKzZsHe5ZmC+iZeTqKnsBTYwmPy48j582ZWRrHUKk
         z8/n17Gy9HAlBGVYZmyPpuPYm9XUdBZS0F657mO/tEzvOH5n1XcP6DMq2qzprpYsQlEI
         ovEpO2T2bpByAH1bCLIt9A9oxnsTz9/V/DSk0AgUGgbNbFx5oM3lRsbrRk7JgQe3/GZ9
         1d6jTgyh9UVGEQzdrkzUTLyLGIPYqEoGKeQ30Cw/BlcJdXd8zPluSuko/+a2KxPyY5DH
         5UsHZR2cQRpODPT+fGXkJdgz+1Q0VZLl+KC8kj5hPme1AzgnRSjHXtl346diNDqgGwWl
         ZmDw==
X-Forwarded-Encrypted: i=1; AJvYcCUjNOIS4ffp/b5FtDMSyLaK95LM3Bu78uthgMTWiXxPhwBkVT/Gk2IkdDM7kQXlidu7pdyWvJ1ARlZdX7iB@vger.kernel.org, AJvYcCXrNiVkj7ftXf87d5qlvQsDwOTWtEqHpPmuZKIo32qgQe0bhwuCZ8RNZAklg0b9yr78/1PMyc2zg2MuW2hK@vger.kernel.org
X-Gm-Message-State: AOJu0YzASaUxNo0L2IWlD1yd4cHFMbR/CkD7V6oyZyUQp2VXp0sToBMz
	RlICc6oln2YweXXOD90rXxAcfMnMKEYMFSATzwFmrwTYOZc8YJIk
X-Gm-Gg: ASbGncsBM/z91HVjai+MwoliqrY7uAzt5mJOEuhMz2p5ij/QFs73NKmYxE7e0okKfWh
	VMv/BJgn5zH6haHttsj8oQQL7dGQZ2vK1iVtolaAVNefn2C8XI9/qdjywabctgARMm0hxDYSZZ8
	Mj9KiP9mFT6UFk992uAGnOAIhw1hzG/ync6ledws9w6vXhO2f8KgB8xX2aOSatPr5Z/s4KG3nsp
	RBZtDxsx4Xpm6MhHYyd/w0jJPySQwPrchTYZvf7DlMoc7P93JDgves/cWaKnLoaIoXO1G2QnGZe
	grNW+3b4COZw8G7Uz8VFBFKyA9BPcQccSQm2nwqsTZUFqNIPhXt1pg==
X-Google-Smtp-Source: AGHT+IHy23t8AgZCMB1Zqlq4/iHMXi+C3dmbU8ydNHYxbJB1789omuobWf3648UiCWa0uyaOf1mJmg==
X-Received: by 2002:a17:90b:5608:b0:2fa:1c09:3cee with SMTP id 98e67ed59e1d1-30879bc43b7mr22723221a91.9.1745320937116;
        Tue, 22 Apr 2025 04:22:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee8956sm9504847a91.8.2025.04.22.04.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:22:16 -0700 (PDT)
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
Subject: [PATCH RESEND 5/6] memcontrol-v1: add ksm_merging_pages in cgroup/memory.ksm_stat
Date: Tue, 22 Apr 2025 11:22:12 +0000
Message-Id: <20250422112212.3231548-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_merging_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 1092

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 9680749f4eef..7ee38d633d85 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1826,6 +1826,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
+	unsigned long ksm_merging_pages;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1837,6 +1838,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
+		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
 		mmput(mm);
 	}
 
@@ -1851,12 +1853,14 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
+	ksm_stat.ksm_merging_pages = 0;
 
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
 
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
+	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);
 
 	return 0;
 }
-- 
2.39.3



