Return-Path: <linux-fsdevel+bounces-47802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE1AA5A33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 06:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7322F1C005BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 04:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36A21B9E7;
	Thu,  1 May 2025 04:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9dIIJS0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D2D1C173C;
	Thu,  1 May 2025 04:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746072922; cv=none; b=FoRBxmAumCtUoLVXrLINL+adu396iKVBovcTufjmcHFRE1OzqiQlvXsDAv+EXPb5SWKN+eZXNoREk8PkasfaA03EUrRzJxGQzt4swbL2CtslHjat+r1zvSCDpRKJWcEGd8Izk+/4NPJtFIwukkpJcnNZxqtqDDMnvfN6SH78dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746072922; c=relaxed/simple;
	bh=ZKmzZnpvSfthMX2tW23l//Fng96C3b5QOXQpZr5pAPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdhhnFNCXHv4Cyay73RbNejBxICDi0zsZKjGOOPdMbDapSi+SW66t4u/UXg4xHXoXY0r5UswaWUwHSgoaCG2NpsJzlrhF093N5k1+f+MofPRDJafv4SZri7rIBTm0U9MFQXwhiW7oJ7tA0i85udKvy41fz+bdT9+pRa68z9m6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9dIIJS0; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-227b828de00so4909985ad.1;
        Wed, 30 Apr 2025 21:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746072920; x=1746677720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRs/vax7mlMaNylMGZ6U5l76qcaA00w4PhyK68LX5sI=;
        b=B9dIIJS0r7Fou3De5GNPY1qtQf9zL7y7AB34g4w22Ac5g8NoVprhbKB7Cg3x98TMLP
         MU0qGlHEI03tHEMolv/cXE66SgfqqP90WRQoFkQpPb5DIWkXNJhQqpEqxG1EI6l6vOGE
         AoYmuPUe6PUPEK21Z0Chy1smzyKb+nfdDtEC6t1pgApPShtkngZsqB7glufgWkLYD1oJ
         emLfosNVWbNGhv1XmmDwMd9d5f9wHUKfS4mxv9sKI52WY5VwvVHxDWMEYR5xezQPiapx
         swuN/4kau/JYKk15YdjoDyo8COLPfasmnbeA0iQgEwEWsJHX62KN/k3g9by+D3N9iQcu
         pQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746072920; x=1746677720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRs/vax7mlMaNylMGZ6U5l76qcaA00w4PhyK68LX5sI=;
        b=aVxBkUvOvWqviAp/5bUc5oKtW0u1k/qpbuK/zRAvl4w/n1pRhjFGn6jT+jOmbdfkZv
         z0AW0wkvoTrp2FN8Y3mTx1LAqdPVpJF6ETIp05R2TIqPTviDhQsy5z4ICp0hknRTbqtR
         BIdNsQYegi3jAXqgyXmtexLzUCn0cm67/A7g0BFCaExlSSr9xzkq9ccM1yWl2xvG9aG8
         g0vOwCG1ikMfDKHdgCgvo+L5P9JMXbAMbAvfJn2u+aLRv2x094AClNass11fDiKG2cYe
         n9oi9mOLZ+qpditscmyfyokTeQ7HrEtz2ONLTMUWmCVWANn4aG3fnEXwf7z0PeLwaoaQ
         4niQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgcaGNAIy9q/mpe93HYRn4B9G2FirLTKx6dBo9Ph80AZG8gEHWQLTK0ODgDf1PKGN3fT3OjW+WPucfou4g@vger.kernel.org, AJvYcCWPxsXu6CtXLw057Ag9AbkIve1ezl9XBSMCSEPSRQqxrM9Eu/3a7zA0fhUaVnKgXZjtL6ljTqQ/0uAfp36Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXthGXARn+GTLWcnMXVhaG6U2248+7TYppuUNrXQNwCn+hC6j
	o4ZADZC9htFy1/KPCdRMhJwK1Pigwba8O6Hq5P8VnHlqj3JblMqb7f86SsZ/
X-Gm-Gg: ASbGncs8Zag1RvG4D8Q+FWHmFUq16FmvP0yhOhLHiCd0U7sZBvhsmsIC9PU9pIDxtcw
	wRk9+Wxn55hjOeTA+86mOCW0vloOukfiYzs92bHv3coY54kwzI4D9IWE/EM3UKfZVQfEg1tgHzq
	cwbatTgyI+hycIIJa7Fq6hRi42GqaIxEcat17XhIOzTYW4ZjV/kC3Qe0uU+RQk60xRMA3pz7c/E
	KvdZQW2VZdbDcs0BsFQH+rOsz//1bWDrBonGcW2POEZvjcm1OnmoNOzkFzYZ+acY36jNj4MrZaT
	V6Us52hcbxau81yQ9QPOq59TdI9lVVIbmxhbjk/uLHzbtlbSTg6Nog==
X-Google-Smtp-Source: AGHT+IHLGOPK6GlKYXpa9eMiXP9ZUHpWY23bd3bSe/+/AL8m63px6IxjXr31QO77R9u59/2K/Ahprw==
X-Received: by 2002:a17:903:1cf:b0:224:1220:7f40 with SMTP id d9443c01a7336-22df34aa13emr93717335ad.3.1746072920537;
        Wed, 30 Apr 2025 21:15:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51017b2sm130975015ad.176.2025.04.30.21.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 21:15:20 -0700 (PDT)
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
Subject: [PATCH v2 5/9] memcontrol: add ksm_merging_pages in cgroup/memory.ksm_stat
Date: Thu,  1 May 2025 04:15:14 +0000
Message-Id: <20250501041514.3324403-1-xu.xin16@zte.com.cn>
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

Users can obtain ksm_merging_pages of a cgroup just by:

/ # cat /sys/fs/cgroup/memory.ksm_stat
ksm_rmap_items 76800
ksm_zero_pages 0
ksm_merging_pages 1092

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 509098093bbd..9569d32944e3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4393,6 +4393,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 struct memcg_ksm_stat {
 	unsigned long ksm_rmap_items;
 	long ksm_zero_pages;
+	unsigned long ksm_merging_pages;
 };
 
 static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
@@ -4404,6 +4405,7 @@ static int evaluate_memcg_ksm_stat(struct task_struct *task, void *arg)
 	if (mm) {
 		ksm_stat->ksm_rmap_items += mm->ksm_rmap_items;
 		ksm_stat->ksm_zero_pages += mm_ksm_zero_pages(mm);
+		ksm_stat->ksm_merging_pages += mm->ksm_merging_pages;
 		mmput(mm);
 	}
 
@@ -4418,11 +4420,14 @@ static int memcg_ksm_stat_show(struct seq_file *m, void *v)
 	/* Initialization */
 	ksm_stat.ksm_rmap_items = 0;
 	ksm_stat.ksm_zero_pages = 0;
+	ksm_stat.ksm_merging_pages = 0;
 
 	/* summing all processes'ksm statistic items of this cgroup hierarchy */
 	mem_cgroup_scan_tasks(memcg, evaluate_memcg_ksm_stat, &ksm_stat);
+
 	seq_printf(m, "ksm_rmap_items %lu\n", ksm_stat.ksm_rmap_items);
 	seq_printf(m, "ksm_zero_pages %ld\n", ksm_stat.ksm_zero_pages);
+	seq_printf(m, "ksm_merging_pages %ld\n", ksm_stat.ksm_merging_pages);
 
 	return 0;
 }
-- 
2.15.2



