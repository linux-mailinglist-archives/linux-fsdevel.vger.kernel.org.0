Return-Path: <linux-fsdevel+bounces-50200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C75AC8B2F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6057188C6BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADD2221578;
	Fri, 30 May 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wwt4uAd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D81227E8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597798; cv=none; b=G9PJ03H9dIj2g2u0czS0Iisx7o8V8rPu3NId/Fw7YdaZUtqgs+Njd9GGpb6Tg9w1fzulqoxlbdJnPgqxnLfM1siSxoOjReHqQkjnYm2tZy8WMAJbd+KWBftOo3C+gLs+O/R3Zm99alXnibpPenrPC2VHQDESZfYvKIh61Xv4kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597798; c=relaxed/simple;
	bh=Dtz1Aet7apWTXhLd7VJWKFnNYwGISZ8LO5wYY32y+Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DR0V2asj6G4A4L74X37Wbi19zynE6PiW626m0SyZ+Y2NQZd5zWwytNx1pW44RpZcPiOtQGD9/UjENO/fGe8qsk3lwV6snsrfExRLSR6Rs6cCFNGTUFx9iXsMnAWoPt08nvRsiRmazV4OS6N615/R8C8pKnYGuULEozr6cph+R5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wwt4uAd8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af5085f7861so1107349a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597796; x=1749202596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ/D1sjhfYHEwDTh2b+Qyte458RPTLSFlphr3fZumJQ=;
        b=Wwt4uAd8KbjRRSsRvich6T35PFHgOUS+Fouykni2GzUkaA8t/k3UTaCOLNa7A6hdWF
         x1RPblBdLzzWC1AE4v87JHrM61KF9DVGbUK8DEpp1cUP/DUuDeLidudvWGuW07fFBQvo
         XsLAUvimfdP6y7CO6hHio+NKe/+P42z+xBNiOHIBXkeee2PwtArHHOplLnjsJ9wNosUg
         E01vyFZb748GdrTlxKUnbJTyKS8Zn6JhcvT8DxNNlYF0w5Z0r+UmrF7gj63i7iDyBOhz
         BIAKWOhEjVr7wQQv+6F9Rr1vj4Y9ZuEuEEYS6k3Lpgm8CNT6pPZaykrXHWBUNyJ1Bb5e
         7sXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597796; x=1749202596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQ/D1sjhfYHEwDTh2b+Qyte458RPTLSFlphr3fZumJQ=;
        b=escNo9+Ib+6w6kr4pzlK0UmcO2JSCie9gqv3neUTT3ivukfSW5iFtEN0jmskYuF53y
         N8ffjH6gAwSvz5kQYy7qlYf2g3gq49Sg0HN/sA6R48rEmGZJYc+SmkSXeH8nPdtaPwVf
         b+dx9hi3MVRKBEXH2u2QpRdXiuejQJdZx6cQ0V1FD8KCFG9kKSbJUOgCGlKlandS1Lmr
         OiUzNaDVRafgDl3391ogYFZLxh4/AMRa/TbBrE4qAP9Vg39sYopD9QBc6+aD241vMH2b
         WWNLECTsscfh87+AokUtbNfGU6+RRer1BO7nefIt9X38bAh8wp8R4EH1aGhwPmqQj7Md
         OZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeTg642k7YO00iMwsRos4h0cG3GtaOSWjkhcTBxpEnXoUHJUi0kJtoxt0YC088wlgAIXJXjcPH18yTmitc@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDzs+I1p1mEmdSBrMYXUxV81PsxgWVxpPZ7OwsjCxUB2nr4sC
	ezEGZM0V5Zhq2jH0sc0CR8vzG9KcqlurjrXwQkY1Wbc5L+CrX7i+f0mN59UcC9x5FR4=
X-Gm-Gg: ASbGncsr60hSsPalYqyVlKeIuN6mLw8pijt65P7EUmalCppmaPyy0gLJGIeZJ8W29P/
	kqq2SY7RxXsnfAWTY9Ht+1jLBbCLIaWxy58+B25I56ErfV5IabukPOvV9+GnCljNgMxhkQGYVqo
	RDorgzWIK6nK61yjyOEbUQbBf30oraQsYFyjD4MOJdTI06XH71vMyJnYp1YAYRSjIuwu7zLv6Tq
	hVQHzptyR2pvRmmGedd63MQoZVVySZ5nDlEg0cg7cke9kVUJZBDkTTHUo6XV8/Yb571tXk0vXkA
	iCx43v91HWTCgP335yCFcMJW5luti89KHWQqFArNpnDZ8uJrAI8PtGREOnlnzFPUEpQmOi0lFYH
	gr5197uIsSsC042pC5P+f
X-Google-Smtp-Source: AGHT+IE1J4YJ6wHA6b9CUB/dnKICEd+OlMDbXuOs/bJjQ/NWJ3rv4Cxh7kWsPUyPIoUfIb7mzNdLsw==
X-Received: by 2002:a17:90b:4f4d:b0:312:1cd7:b337 with SMTP id 98e67ed59e1d1-3125034a47amr1876977a91.5.1748597796457;
        Fri, 30 May 2025 02:36:36 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.36.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:36:36 -0700 (PDT)
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
Subject: [RFC v2 32/35] RPAL: fix unknown nmi on AMD CPU
Date: Fri, 30 May 2025 17:28:00 +0800
Message-Id: <fc9a95163b055235b1a5007753a131a7250a409b.1748594841.git.libo.gcs85@bytedance.com>
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

In Lazy switch, the function event_sched_out() will be called. This
function deletes the perf event of the task being scheduled out, causing
the active_mask in cpu_hw_events to be cleared. In AMD's NMI handler, if
the bit corresponding to active_mask is not set, the CPU will not handle
the NMI event, ultimately triggering an unknown NMI error. Additionally,
event_sched_out() may call amd_pmu_wait_on_overflow(), leading to a busy
wait of up to 50us during lazy switch.

This patch adds two per_cpu variables. rpal_nmi_handle is set when an NMI
occurs. When encountering an unknown NMI, this NMI is skipped. rpal_nmi is
set before lazy switch and cleared after lazy switch, preventing the busy
wait caused by amd_pmu_wait_on_overflow().

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/events/amd/core.c | 14 ++++++++++++++
 arch/x86/kernel/nmi.c      | 20 ++++++++++++++++++++
 arch/x86/rpal/core.c       | 17 ++++++++++++++++-
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b20661b8621d..633a9ac4e77c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -719,6 +719,10 @@ static void amd_pmu_wait_on_overflow(int idx)
 	}
 }
 
+#ifdef CONFIG_RPAL
+DEFINE_PER_CPU(bool, rpal_nmi);
+#endif
+
 static void amd_pmu_check_overflow(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -732,6 +736,11 @@ static void amd_pmu_check_overflow(void)
 	if (in_nmi())
 		return;
 
+#ifdef CONFIG_RPAL
+	if (this_cpu_read(rpal_nmi))
+		return;
+#endif
+
 	/*
 	 * Check each counter for overflow and wait for it to be reset by the
 	 * NMI if it has overflowed. This relies on the fact that all active
@@ -807,6 +816,11 @@ static void amd_pmu_disable_event(struct perf_event *event)
 	if (in_nmi())
 		return;
 
+#ifdef CONFIG_RPAL
+	if (this_cpu_read(rpal_nmi))
+		return;
+#endif
+
 	amd_pmu_wait_on_overflow(event->hw.idx);
 }
 
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index be93ec7255bf..dd72b6d1c7f9 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -351,12 +351,23 @@ NOKPROBE_SYMBOL(unknown_nmi_error);
 
 static DEFINE_PER_CPU(bool, swallow_nmi);
 static DEFINE_PER_CPU(unsigned long, last_nmi_rip);
+#ifdef CONFIG_RPAL
+DEFINE_PER_CPU(bool, rpal_nmi_handle);
+#endif
 
 static noinstr void default_do_nmi(struct pt_regs *regs)
 {
 	unsigned char reason = 0;
 	int handled;
 	bool b2b = false;
+#ifdef CONFIG_RPAL
+	bool rpal_handle = false;
+
+	if (__this_cpu_read(rpal_nmi_handle)) {
+		__this_cpu_write(rpal_nmi_handle, false);
+		rpal_handle = true;
+	}
+#endif
 
 	/*
 	 * Back-to-back NMIs are detected by comparing the RIP of the
@@ -471,6 +482,15 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	 */
 	if (b2b && __this_cpu_read(swallow_nmi))
 		__this_cpu_add(nmi_stats.swallow, 1);
+#ifdef CONFIG_RPAL
+	/*
+	 * Lazy switch may clear the bit in active_mask, causing
+	 * nmi event not handled. This will lead to unknown nmi,
+	 * try to avoid this.
+	 */
+	else if (rpal_handle)
+		goto out;
+#endif
 	else
 		unknown_nmi_error(reason, regs);
 
diff --git a/arch/x86/rpal/core.c b/arch/x86/rpal/core.c
index 6a22b9faa100..92281b557a6c 100644
--- a/arch/x86/rpal/core.c
+++ b/arch/x86/rpal/core.c
@@ -376,11 +376,26 @@ rpal_exception_context_switch(struct pt_regs *regs)
 	return next;
 }
 
+DECLARE_PER_CPU(bool, rpal_nmi_handle);
+DECLARE_PER_CPU(bool, rpal_nmi);
 __visible struct task_struct *rpal_nmi_context_switch(struct pt_regs *regs)
 {
 	struct task_struct *next;
 
-	next = rpal_kernel_context_switch(regs);
+	if (rpal_test_current_thread_flag(RPAL_LAZY_SWITCHED_BIT))
+		rpal_update_fsbase(regs);
+
+	next = rpal_misidentify();
+	if (unlikely(next != NULL)) {
+		next = rpal_fix_critical_section(next, regs);
+		if (next) {
+			__this_cpu_write(rpal_nmi_handle, true);
+			/* avoid wait in amd_pmu_check_overflow */
+			__this_cpu_write(rpal_nmi, true);
+			next = rpal_do_kernel_context_switch(next, regs);
+			__this_cpu_write(rpal_nmi, false);
+		}
+	}
 
 	return next;
 }
-- 
2.20.1


