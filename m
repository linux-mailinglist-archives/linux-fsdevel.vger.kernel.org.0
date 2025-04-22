Return-Path: <linux-fsdevel+bounces-46917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B1A9673A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812487A59ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BB627C863;
	Tue, 22 Apr 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJeGi9p4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337B278167;
	Tue, 22 Apr 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320979; cv=none; b=s1fmy80UEbXq3FUffIG8bfuT9/z8PZtYAyM9DJB2vTKzuZ/lBKs4KR5qdG/NQtVgEa7jKsLruTh3tRMjH34qCjcq/hyUUta0YFMsuIO0VYJ7yCRhjXCX4/5iguqe2aoZR4CWVGIPCfPJ0GWFxuaL0FZkYx8CB3bw7jKZMPjU4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320979; c=relaxed/simple;
	bh=pzRMD7fDKf99WmyFQqJWme1aUHdFSU9HM/xTQzrFw7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+1/dWweA0g28AAH8VuYtgXV1ZoS853ds9st8or7Wsfq/xnyk2OyFIvoELc/ydlnVl4sdP4FXkcwFOZpANPcUtyjIGwgREDu2BWoXRQtPNxCDANEnYbpnT31aHRb9s0fs/NTwxaquGVaIyY42GV5fWI3feHPowylIQ5jtpysqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJeGi9p4; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7399838db7fso4736823b3a.0;
        Tue, 22 Apr 2025 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745320977; x=1745925777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aiGSkrm3DgewfYaP+Izlu7kFJeequ2GOc9ocYH0CLkc=;
        b=SJeGi9p4HqbQfsXOKRGSPp1jio1xxpXvcvcr59dNEMjJo+ireVqYGcwdGoE/O0Bxl/
         +IWjLDMxtPn+LCQYkxTC+LyyddLxrCFT4pHQSLdGzRLEWWjJtdb6nPK5XqSxXP2rCo9t
         HLillhaajUuJrENz32Yl0LNKTjfVKoBouEmr/PSOSYsjNOvKy3kArcXLiifF73PuqHkx
         EOarv7v9dLKtC3kInf+Us/1smD/uYrOJlRBNAvtmXUvxBz/NWqvhuz63NTZzxxT5p5xu
         SGT6EKQEnwiQiyLnF9ZXrpHW6wKbBaL/JGJboKaT8Y2dQMpTmhWbEiqg/Xnn4tsTLL1l
         wJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745320977; x=1745925777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiGSkrm3DgewfYaP+Izlu7kFJeequ2GOc9ocYH0CLkc=;
        b=h5T0ySxHdJt0fOxpeWbBeqmV+L+ddtBwpHW3n/OPdRqkX7oGTL4bGOPe7fESIcKpK3
         Foc29OF5J0dbveoN4KCe2N+YRfKbsZPbwIYNOSMZR+tNq7IdCx+75N5DlLUHtcl9dTrZ
         bJNMZ7qtPXy5lCUWUTaw9scclQF3C82dcfeauJeCrd/MjL4+0MFlcQ1soXfefcsd4neI
         MaxpQQrPpAggHapsCY7mH9/DjxXh4VKUam4JuIYqmli9C3x/rHVwGuk5VtU1Tk18n6N6
         Y6oky5vZzoEfLSdN1pGvXD/3QUfl2aKCIOE4DxPRbDZ441Bzld+oXZyAp/XECJ2T99v3
         DDEA==
X-Forwarded-Encrypted: i=1; AJvYcCXCl7Uvl5YvYOEnxhorZXCbodpm88gBOTW2hcSRvzkxX1o5AtInWSM5eMd9Hfh5Asqzo3XBdRUrWa7OGEnR@vger.kernel.org, AJvYcCXQBJDiKikQpdfPhYkLAAIbMzESXZE1VG3FPggFbSvNo3O9CNYIF69ePMfn1fgi4ZRJJi8SldCWjEgMMaQi@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdDGXzO3mr5AFeMo/cDu9vU5QjZk+bm69HDumUiXWQ3BiA7Em
	fJ12UKG21CVvwy/nnUUl05wOKLXFgCNWMa8HXVQmCsgazVjolc2P
X-Gm-Gg: ASbGncteMKK6xvfSIN2jaCvQYmNmdehUNp87GHoTwIh497K7VEuH+AmnSS3/CPv9D4/
	VefNiuSPY/OZBYTk0h2jak+r94gdREBzHWk4LAnZgnGkfi3vjvx3aDJbEjLXZTOhtm1WCEb4+Tq
	aSHca85DXpDcdzWbL0Tis28M1R6wJ3kIeyJ8O0ar2hgmbW6F9M7eUYfyGyRZUa4WVQY1sjGatxY
	nYA0Ukgkwf4RJWzb1Uog4i0qwLmQL4ouhvPiZmUGLFrZZgR7Kmo+GITnZYe1elaUU8aB0B+Fm1U
	C5cKTs5/XPiA0BoRIwhGPF9Y0RgwnJDV5wpL18YkHL1QpcMeOlhtLQ==
X-Google-Smtp-Source: AGHT+IGjecXBs7xBC0/rqoGxfRjHsEUBjW1ci/D+q51pdPyQkmzahn2l0dZlrCg3rUyHbG4WAEIaXA==
X-Received: by 2002:a05:6a00:2c86:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-73dc1b78556mr21412590b3a.11.1745320976914;
        Tue, 22 Apr 2025 04:22:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901143sm8318136b3a.73.2025.04.22.04.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:22:56 -0700 (PDT)
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
Subject: [PATCH RESEND 6/6] memcontrol-v1: add ksm_profit in cgroup/memory.ksm_stat
Date: Tue, 22 Apr 2025 11:22:51 +0000
Message-Id: <20250422112251.3231599-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_profit of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 76800
ksm_profit 309657600

Current implementation supports cgroup v1 temporarily; cgroup v2
compatibility is planned for future versions.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol-v1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 7ee38d633d85..2cf2823c5514 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1827,6 +1827,7 @@ struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
 	unsigned long ksm_merging_pages;
+	long ksm_profit;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -1839,6 +1840,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
+		ksm_stat->ksm_profit += ksm_process_profit(mm);
 		mmput(mm);
 	}
 
@@ -1854,6 +1856,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
 	ksm_stat.ksm_merging_pages = 0;
+	ksm_stat.ksm_profit = 0;
 
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
@@ -1861,6 +1864,7 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
 	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);
+	seq_printf(m, "ksm_profit %ld\n", ksm_stat.ksm_profit);
 
 	return 0;
 }
-- 
2.39.3



