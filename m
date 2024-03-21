Return-Path: <linux-fsdevel+bounces-14995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A2885E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57233281DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A001386CF;
	Thu, 21 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZLKKUlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B5137936
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039071; cv=none; b=aG8rFzQ71Q88+W4d5Us7cf0AkKI9AbupNBMC25tS3iUda5RxaVdEl+hanIAsu5T4wI+rVtO9pWSDF6NLJg7GwbG/+ncD4WXPZhLwp15hLKYuaWScK8wUbqPFQqL6NUwJIzpNS//02mzdD3uDwgF1/s3Y4VEJNHtM1lMFmFo65AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039071; c=relaxed/simple;
	bh=z2eJy0t2bdkmakMZRyMHx8Zh+sPp3sJo51GJl0bffFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=seCNoDiXfn7oaP+9Iyh6fwVepHsncPW5wPNAEXogOj+uFRoexFEYKBZ9lVcxT4tKNAZm9thOGqtRsvFvCn1qQpfrWsjVyBtKXuoJ9nsfsMvN66MT2f4rfJGif+tfqxLpFwsp+d1LUS2C/+IS0jsXJBzGv7/lm1/4KV8ID3s5ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZLKKUlE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0b18e52dso14807767b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039065; x=1711643865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=UZLKKUlElHdKoVJnA/LuY9jg0NkLB6vwXGStqPA0YRImOU2pNXToNXs195ZQ14UFnE
         6onBZfh8TAgJmvp8XA/p2OGTeR/GUt/kR8bCSNWH92aBG2quY3p/Qi1ZSC8mtE6ZBO3l
         K1XRas9hGxHmr5SkJoIRnY6GEBSo4iulor1QSg5BgONy/LA8s3mCAKHtpsC5J03hx/I4
         nwK3N0U94Fg0Qb4tcU98nek/fDUhyCE5I21YMkIf4aY59K9MsfCjo0xN+JfnPhpoOgVT
         27QbJ+Ck8zsrqK4prKa0qFBd6qQdXFiUfIPyvdszYIbAtOHnH0V8/QuVgJUo4e5Pe0Gj
         Kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039065; x=1711643865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adETXft81L3mg8VeiLZhJ9Sn5YTIW37aD8rIZRQJCFY=;
        b=tECW/SZ3md1HRDGVdBrBvXbblZKCwXscVizlocdNNrclLbsHIRQHa67osALoAGqfRw
         BZ9MC0PcpmksbZAUU0bkuSsn234PwpyUPr3asKsZCYlsKTMXf/X9/CQfEIV5WV2ZxS9a
         neseRKcJp5ZP7KnxvthjOADLVqU+/oKZKWcMmo8Fsj+7hT8Qbyenehy+SDY+uKnm/YWA
         EOPgIAhm1d8N8i+qeY5acYuVMhyzGIz5W/wvYT1M28HitPl6UaD0wtEgMzo8y1h1MRSu
         dcLmAIebQDHNz9mTg8watenr0+q/ZZJjI84sx0ZvFnSUr4RZcRr1Bz94YFsMLSYXq6H5
         1fXA==
X-Forwarded-Encrypted: i=1; AJvYcCXXXV+YnyNzaSfpgrI2X8W29Vb9OwwGyPe1OcPU8y7gMFtp2l/99t8z5b2hbnL/UerpNmd+2oXga2UEK1bsYPQ9yqhsD6HCl86gmUcUMw==
X-Gm-Message-State: AOJu0YxGVEhAtzDv1Tz29zw+t99uugHoc5zQAS0huSstZn7cWENEr3U4
	yHuKsdSBC7AWuS4YMucnH0u5Ini9WYfsKfhme7nnLWNQOIr7o86XYeDPSyN0QGMBTnbLaGDVf7H
	x3w==
X-Google-Smtp-Source: AGHT+IEpbeHGmaH4ZP6HrzXLjRbRGOQFlxFrFvHpCJT+qt/SUASA+RVr+wlFFHpwWsqOIXtYDNaLSozJTUQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:690c:b06:b0:60c:cf91:53e0 with SMTP id
 cj6-20020a05690c0b0600b0060ccf9153e0mr3628ywb.1.1711039064823; Thu, 21 Mar
 2024 09:37:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:38 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-17-surenb@google.com>
Subject: [PATCH v6 16/37] mm: percpu: increase PERCPU_MODULE_RESERVE to
 accommodate allocation tags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As each allocation tag generates a per-cpu variable, more space is required
to store them. Increase PERCPU_MODULE_RESERVE to provide enough area. A
better long-term solution would be to allocate this memory dynamically.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 8c677f185901..62b5eb45bd89 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+#define PERCPU_MODULE_RESERVE		(8 << 12)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.44.0.291.gc1ea87d7ee-goog


