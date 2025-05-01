Return-Path: <linux-fsdevel+bounces-47801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A670AA5A31
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62BE1C00435
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE85230996;
	Thu,  1 May 2025 04:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyejidQy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA41C5F18;
	Thu,  1 May 2025 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072891; cv=none; b=UICc5AV5oqZVRcqycT3/PigBzNDJTPvg6ZALKmnPd5n7ZucsVVth1kVzL6wnX4xs7LUHQM7ANsFAjdNOSMSFILHXyQeOuYgqq9I76b0H16BaTOwkaUOVpxWk59BEbt5IdamuujBUH3o7wSzR22fBP5v02hLttP7pSqLT5cusoVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072891; c=relaxed/simple;
	bh=esfxzeKdg1MJfuXOyTZU+V6sbcqs+o0YVZAGE8mnaVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o80wopBBCI7hqkXQ10DfSkOeawOM/zqA8wK+ZvRuPp3TqgmUileCe/7HY1JOh8/uYLd8v0qu5HeXdOHmScs4ehWZIbQR+OgLJJLq+Ow9sbhyf9BMNKq1CBrxU3qfgTxIWv5L0ObuXKbfJLoZyKDgM/Cvm6BesdwkAnbwQoGIfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyejidQy; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-227b828de00so4908325ad.1;
        Wed, 30 Apr 2025 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072889; x=1746677689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SiLzuAtNq2HhU1+JMyDly4I1nWdcHwUCD3RbB6Ax1A=;
        b=HyejidQy+dvizaCZweY6S/Iz3LEFc837Tn/jXkbja8cb8QLlP+FOnIom9SDhxVROnU
         HiuO8RcAfsI6adexhq8pKGPPMWw4vN4iTehYrWAcsX5uBalONG99ZqW8fVCfFieKlKAa
         4aCo8HQsQFVIhIW3UW/3kPO/iwZqBvz7Lw24wzgf4Z3fIyTx/McMQgQ96PEBTZoNTvWX
         UWmh96p8BsX4eUD9jeJx7HTkM71otjMniTwBg2fAjkKqCeOQUE/e/kbUuLVLQM318dr7
         lSn05AVUIqkM3sgwCGbDK282Dr8GotBleiun+4ZTRSrlx0UqGleybyGrm9fq8i5qNOaE
         ybWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072889; x=1746677689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SiLzuAtNq2HhU1+JMyDly4I1nWdcHwUCD3RbB6Ax1A=;
        b=iR4LjzklNvDidKqbYmoJW9GFDefDUxlenxrlJugk9xj8aDZMWw3IVGlusu8lM/urd1
         BSCC+3XqYRfbQ2zSrIMt4rx0FmzuwK1tzWGn7XmsM2U0M9AqR9E6PWBtpRoFJz3yzYip
         r+kLYtAWks3kNbwS2kub3tgH0J3Uua2nmrOfhqfuLFZp9f/PPZM/cIA9sQMeiULF/E/n
         xhoUGV+bAnfYoGkJvOtSvLIHeK8m9mZv5tSdiLI07laUf7rFTP0KkB6XCdZ/TMAQnFt7
         O3KNt8uEUPNprmH5IF76Crl+qJXtjQcujZasnhXgf5PvpvyQ/aURfaaNkFtGIOP9cpsU
         U4TA==
X-Forwarded-Encrypted: i=1; AJvYcCUEpzQSmI64/DD41MWYIUGFKgVzxKTpJSgAaWbbOzBsRcmBzRi8u88kOfx+oU6hNdgFn9fBDxYxyJPx90F+@vger.kernel.org, AJvYcCWCZuazJPR/3wq4EQccwwdqDXE3NP4QNxftGVVI5I2OslghcAFGhKX9I5BoDW3gxq/8gFiBPFIuPesO+/Lv@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzTJWh3uxWtNho/u8PJXAyLojs7gkmeunwTwVeZYYsp1VcR8g
	NnRPsR0O+DcC2++svMIk8m6+velAhJ7edauXkfJvGKT82LZDtgd9
X-Gm-Gg: ASbGnctodf55948e7zRWtZg4BYbBvTpM1wrobCfdEzYiA2atghDOKi67hog+6xpmd6i
	pQC1s3wyfmMNF4wbMsJ3QPagqcQDQ5nZTgt+bmzsxmBq1Ax4BzhoxkfL4Er1zklgTmfg2D+SU0q
	GLE3ONPcx2fbJK+cpnDfVXvSUhqMZdu1UnwXoHMiLjXFxEJ49lQq6BrcNUfNTysFSCzllpVpVRt
	nuEAAE+toP3SW8einD+0BEpWyUFjXZDJhBRFTqZHT5fW2UbcjcLJgSLojHXXbYHcZXDvmFPDn9L
	gQjz4h/QZAGEiHvWbECQo3VEd4VNaIo9bVLcUt+TgzQ4PjXseg30LA==
X-Google-Smtp-Source: AGHT+IHn3L1NVRunvUOsShzPwp65pqL9GPzUchB1/FjcHdgqQtBcMBAJPiNtQUa/4i4/a/mJv3Ur6g==
X-Received: by 2002:a17:902:d486:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22df35bafbdmr81800625ad.42.1746072889180;
        Wed, 30 Apr 2025 21:14:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51027b3sm131092695ad.193.2025.04.30.21.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:14:48 -0700 (PDT)
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
Subject: [PATCH v2 4/9] memcontrol: add ksm_zero_pages in cgroup/memory.ksm_stat
Date: Thu,  1 May 2025 04:14:43 +0000
Message-Id: <20250501041443.3324342-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_zero_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69521a66639b..509098093bbd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/ksm.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -4391,6 +4392,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 #ifdef CONFIG_KSM
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
+	long ksm_zero_pages;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -4401,6 +4403,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	mm = get_task_mm(task);
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
+		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
 		mmput(mm);
 	}
 
@@ -4414,9 +4417,12 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 
 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
+	ksm_stat.ksm_zero_pages = 0;
+
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
+	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
 
 	return 0;
 }
-- 
2.15.2



