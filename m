Return-Path: <linux-fsdevel+bounces-50189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7BDAC8B0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA93A404A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDBE221DA7;
	Fri, 30 May 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MzMp1xwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B69521FF28
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597663; cv=none; b=P8QqNabCpJHycgFDlNhSWM145sYajNLxwkvKBQnculaM5oq6kytXNUfAuxdunTFb51wve7DMCwxsO/6fuHuHJ5msKQ/NWNsz6SU//067tb0gx2RsntdOJE6qz54QcGCRv+svKLXGotbpN8Y7NMD5q1dEMsj2qNryNZEkL8HoaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597663; c=relaxed/simple;
	bh=OoRqkHVJJA6Fnn08xoi8Z+2+DiJAYYu6EEBieJEgtFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ujOPWKgFEUUMUXbzbl6FGjNvd+Lsm0kmssLH/x6/3FjibhwRB98OHVkNHlXSWZlMzye/7HkXAMIFtOaxjbxpB51qn55+ap1hjEEtCgHrMuXf14EP4TY2pBq97dHPXtVCuRSPnFtU+USTLjWsA6rU+620I5Jjqb+XDeZ/GmGwRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MzMp1xwL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234b9dfb842so17473415ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597660; x=1749202460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8WmlWSYokiEZq8ImcTa9QlYOraa+eQKx+5TbFt2hGQ=;
        b=MzMp1xwLobGJ+PxhL9U31NFiYdW2e6Es6/fKGhgS9fdx/3RJIOx6Z7xgtAlekeM4OF
         w2FHcZiGe/oaeAj4agy4q2T6ro7WHZAS1OUnyEjYeoN/KU3T2pJlXdCXQth147r09gg1
         upJOCi/JaVg7pKSz9GEHtge688GgY5m+rOiNcbvLzR+b48C5+zHCu0ZzGAMHIY0AOGyC
         ne70J2lkOTTmg/LXAciIlOeaD09k81C+JOCe78G+aFeCLKaqvXAoR5kvpqJHHEp/Nwhn
         iauXi4dGeW6dZOMk+imu/OBgrpZdQKC1ZZcmC0ljhNIEhpfxQnUphQIRRg6qOjrfu/Kt
         Dsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597660; x=1749202460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J8WmlWSYokiEZq8ImcTa9QlYOraa+eQKx+5TbFt2hGQ=;
        b=kIkVgIogi9TxHM0cnDQ+AhUtw3VYbi1p5/hRUopogJxTlMs/sn+jV+bXFAQgV7YZo+
         Mwbt0LYlPai7QJgrnQH8YtYm+ned3vnOnCxqOQggScjUeyINaywfh96HqIQKMNYHUjYj
         022xkMfXmZ2LAAjIOep9wSPNEx0unKQHCvGg5PWqdIniZOSxnSzbL2H40RM9vVoeKFlx
         sCwvL7z0KIybvSP8AqQzoIsCW6vpelLBPh4p0bwiD+cTUD4qLWafOa8/dIO7vp4VBCz4
         UgMMi1X4GDCfCalunEoIPApZQp3zThvHzRQZ1ZdqZJQZCaJGESZbKuOOg5TApI1d8K54
         /xhw==
X-Forwarded-Encrypted: i=1; AJvYcCUINl8PIU3b15QV4C1yiGQi1Ir71GgqFntYMzeAKy9C7IeLh+/T8SsdtFfHPdZ8BcKiC89GjEMoKsRxDMet@vger.kernel.org
X-Gm-Message-State: AOJu0YxXG4Bxv30aokYkS1MiS1g3By7clLDgSCLmld6yGJWaSLHvF34G
	uR7mP+cFGdmXFkOTLsACRqHn3Qg/na1mSEVibr5hx7TQUJKgZgqRdBwd0/do5CjBLkk=
X-Gm-Gg: ASbGncugRwXxmzM69mA6aylTfZdrnnpJSIY+R3BwG86M92lF/inBgSzLfQ7yB14WHlC
	qTLOZ/Q2m7kiRqoa7YWLZ2y5u5kwILZnamT3dvpS+a/bX2OosqYAvc0ebBmrH0MMck4VlZ1dv2A
	KcMeDWeUJlbV/e8+/WUnyw4Fk2NqB962QpFs+h3zMZob+TZgDbBHsW+6Stoj83RSu5V675TtW4B
	V1BYawGKIA+cdcRCDHePs1w2mopyXbkbhgcE3cXcPnz89E99crodIdtX+14xKohrCdySE8iePdo
	Yz7WjTnWJ0tKJvRr2tlnsChnFadGL1e9XY2jO9c+sRfZzsDCZrHZPghNXVBs2YlJUVj4e5ghO3b
	rvnBrX87eMg==
X-Google-Smtp-Source: AGHT+IF4zFLLKAk8uepZIGBZM+3fXRB/hltSj95jGD1vqbYt83ikw4yeQ1JJHBQBbftK0SQTg3CQlA==
X-Received: by 2002:a17:90a:d2cf:b0:311:a314:c2c7 with SMTP id 98e67ed59e1d1-3124150e346mr4368890a91.2.1748597660011;
        Fri, 30 May 2025 02:34:20 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.34.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:34:19 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 23/35] RPAL: resume cpumask when fork
Date: Fri, 30 May 2025 17:27:51 +0800
Message-Id: <45c1884aaf21256ed6fc66b4a4a716bffebb54e1.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a lazy switch occurs, RPAL locks the receiver to the current CPU by
modifying its cpumask. If the receiver performs a fork operation at this
point, the kernel will copy the modified cpumask to the new task, causing
the new task to be permanently locked on the current CPU.

This patch addresses this issue by detecting whether the original task is
locked to the current CPU by RPAL during fork. If locked, assigning the
cpumask that existed before the lazy switch to the new task. This ensures
the new task will not be locked to the current CPU.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/kernel/process.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c1d2dac72b9c..be8845e2ca4d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -29,6 +29,7 @@
 #include <trace/events/power.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/entry-common.h>
+#include <linux/rpal.h>
 #include <asm/cpu.h>
 #include <asm/cpuid/api.h>
 #include <asm/apic.h>
@@ -88,6 +89,19 @@ EXPORT_PER_CPU_SYMBOL(cpu_tss_rw);
 DEFINE_PER_CPU(bool, __tss_limit_invalid);
 EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
 
+#ifdef CONFIG_RPAL
+static void rpal_fix_task_dump(struct task_struct *dst,
+			      struct task_struct *src)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&src->pi_lock, flags);
+	if (rpal_test_task_thread_flag(src, RPAL_CPU_LOCKED_BIT))
+		cpumask_copy(&dst->cpus_mask, &src->rpal_cd->old_mask);
+	raw_spin_unlock_irqrestore(&src->pi_lock, flags);
+}
+#endif
+
 /*
  * this gets called so that we can store lazy state into memory and copy the
  * current task into the new thread.
@@ -100,6 +114,10 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #ifdef CONFIG_VM86
 	dst->thread.vm86 = NULL;
 #endif
+#ifdef CONFIG_RPAL
+	if (src->rpal_rs)
+		rpal_fix_task_dump(dst, src);
+#endif
 
 	return 0;
 }
-- 
2.20.1


