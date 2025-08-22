Return-Path: <linux-fsdevel+bounces-58744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8288B311B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E581CC3FD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE82EB5A6;
	Fri, 22 Aug 2025 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BVgBJakd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3021A92F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850939; cv=none; b=g0tNFjzLI9e9UYbXhmd19k2nS0PA9V68YLg+DwANrFBn6GjPOR9FXpajVV8t++1jvSCDZZb5cFjclGB4nfnJ5KkSgj1KpFZPna/Dq8dIH93QhxCO9v9j5mbRVS2z9cSbWuNsi3ZH5OHy383iwzBPm4oiCZ4ElbWVDM90XUsW07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850939; c=relaxed/simple;
	bh=9ockR9/UqGDJ7YDW+57JW/6GHiulGWCbF/dbUijcd30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPd9S59JVhD62yYFys9ibiBhR6HEaX3Q8uabK6M3H+q2Vnwrqlkbo1CyrF6BXWV4OI1dF2PDpHtDFfToMfFUNpIzUffFMRCWNqv5zAdx9nRdeW7AybVXVeavrHs3+E0amQ7yJfRZ+WKGJrHL04EAflbM7Uygq+2Dht34Ty4hsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BVgBJakd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-245f19a324bso17415985ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 01:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755850936; x=1756455736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7B+ym3G57Ia0gA7b5M2w0v/DPMFIwfx3MWwyn0oTnOk=;
        b=BVgBJakdEnYu0R+r4KHj+p+2/NGUna6XWXiHpRfP9wK8c3dn0Dv0NqE7SePPEZ9omi
         w+il8xtRs4reGoMC9ge2we84brfLGUjsHDnQdAxjd+yT4mvagVwFQ1dZj31/ykG/XavJ
         OvcS0fNSjEdRoli+Q4SohIwCAgeIJxdhF5Hdh3V1ZBLny293n8YWijCWNW34uNBDqJjb
         oKgxkkRagGVSigzeQNnxFNlqjfKtwtV9c0F9oOhBjvEw2j5n4Og8hIEiqQx8QygojFGd
         m9CKlbnqCtRb6D6KjJSYnsfambv4c/fgurXejUAwzqukq1fNrCyRxYm6oT8Nm+r/X/s2
         AkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850936; x=1756455736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7B+ym3G57Ia0gA7b5M2w0v/DPMFIwfx3MWwyn0oTnOk=;
        b=LLgtGysy9xHhZpyA/ALi/e0kw9gB9/P5zW/a2RFURVveGu1GtwNaR3z8CDZEBA8Zz7
         ROIagLo7vg28wts9rQhGcCxAQdD3/4/yq2/mOnK0NC6caVtvHsfO1SoK2l1k4LQzIjT2
         P/opLRfQhAh2I4P9ix5NNNK0RABTRT/0mnyVUos+bFEygKZHvidAsVZzhFu8EfF/rUG9
         OynepEkAOCISoLun1wGNU8XTVXiHovxVPKzJJ6605Pu12b/OCSyoxPhELelKgZduMXi1
         1n1vumYMT9kVINKAYmU48lesP+A2aok4N+YEenaDx8i+h/TRlxTBl2Q7GutNqFjwbe7g
         UDeg==
X-Gm-Message-State: AOJu0YwuTC6C6wsx23j4385xEVk9qWL8XcDVPSNbCOhgtUm7YCk8hh96
	A532WDp566a35LDgTc9TNo4i682p/tVbUfTyetOzDx74Wf9Py0CRdamkEt3zwpho/Ic=
X-Gm-Gg: ASbGncuLAlp8cafAnRm7pCQ1G/mqp7yuK4FbaSMmk0Yg+bb+aHweV87it5K41k8ISjv
	0tnoUFPi+eJJxDq1tRM7OUEjBzbmZSt55kySg4UNbzpfqrWkLu6sUe7dq6p7HmEGDTp+UiGKiNd
	BNuUl+ReLH9tidRLpenGgcoMrO1HZEcf2ThHdJd+Uhgdwh7FEcZO3mWWamZSG16aN+90oaKIsvW
	2hKPFNd2Nokeeodf5R+vItZsriqb+3xNWVoa13xto2Wn+IsHmmFoBDgMI/G3UJ/sS39vFgKZha2
	kHhbpvu3IbzlbJjKLs6pN8W5tqBAMojTLVfeFsITEIUhjT66gY7OVpk37dUcXjD/hi3mExEXbxl
	19QkPWHSi9K9pV8Te2hCXS02jEjfRIjtETYm5DBIM0nk2otHG7cn+mrh7ZxhwsvD4046NeBE=
X-Google-Smtp-Source: AGHT+IHA3KlrKcHXxuSYhV08ESuEZcmN965/xf1VGEqc9csUX32ZI75YP7zuuOvOsZxoR4o3CXJJ4A==
X-Received: by 2002:a17:902:db0c:b0:245:f2c2:650c with SMTP id d9443c01a7336-2462edeec4dmr30370225ad.18.1755850936362;
        Fri, 22 Aug 2025 01:22:16 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7489sm76648585ad.70.2025.08.22.01.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:22:15 -0700 (PDT)
Message-ID: <f1ff9656-6633-4a32-ab32-9ee60400b9b0@bytedance.com>
Date: Fri, 22 Aug 2025 16:22:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 axboe@kernel.dk
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
 <aKdQgIvZcVCJWMXl@slm.duckdns.org>
 <CAHSKhtdhj-AuApc8yw+wDNNHMRH-XNMVD=8G7Mk_=1o2FQASQg@mail.gmail.com>
 <aKds9ZMUTC8VztEt@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <aKds9ZMUTC8VztEt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 3:01 AM, Tejun Heo wrote:

Hi,

> Hello,
> 
> On Fri, Aug 22, 2025 at 02:00:10AM +0800, Julian Sun wrote:
> ...
>> Do you mean logic like this?
>>
>>      for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
>>          wb_wait_for_completion(&memcg->cgwb_frn[i].done);
>>      kfree(memcg);
>>
>> But there still exist task hang issues as long as
>> wb_wait_for_completion() exists.
> 
> Ah, right. I was just thinking about the workqueue being stalled. The
> problem is that the wait itself is too long.
> 
>> I think the scope of impact of the current changes should be
>> manageable. I have checked all the other places where wb_queue_work()
>> is called, and their free_done values are all 0, and I also tested
>> this patch with the reproducer in [1] with kasan and kmemleak enabled.
>> The test result looks fine, so this should not have a significant
>> impact.
>> What do you think?
> 
> My source of reluctance is that it's a peculiar situation where flushing of
> a cgroup takes that long due to hard throttling and the self-freeing
> mechanism isn't the prettiest thing. Do you think you can do the same thing
> through custom waitq wakeup function?

Yeah, this method looks more general if I understand correctly.

If the idea of the following code makes sense to you, I'd like to split
and convert it into formal patches.

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..10fede792178 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -172,13 +172,8 @@ static void finish_writeback_work(struct 
wb_writeback_work *work)

  	if (work->auto_free)
  		kfree(work);
-	if (done) {
-		wait_queue_head_t *waitq = done->waitq;
-
-		/* @done can't be accessed after the following dec */
-		if (atomic_dec_and_test(&done->cnt))
-			wake_up_all(waitq);
-	}
+	if (done)
+		done->wb_waitq->wb_wakeup_func(done->wb_waitq, done);
  }

  static void wb_queue_work(struct bdi_writeback *wb,
@@ -213,7 +208,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
  void wb_wait_for_completion(struct wb_completion *done)
  {
  	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(*done->waitq, !atomic_read(&done->cnt));
+	wait_event(done->wb_waitq->waitq, !atomic_read(&done->cnt));
  }

  #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/include/linux/backing-dev-defs.h 
b/include/linux/backing-dev-defs.h
index 2ad261082bba..04699458ac50 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -60,13 +60,56 @@ enum wb_reason {
  	WB_REASON_MAX,
  };

+struct wb_completion;
+typedef struct wb_wait_queue_head wb_wait_queue_head_t;
+typedef void (*wb_wait_wakeup_func_t)(wb_wait_queue_head_t *wq_waitq,
+									  struct wb_completion *done);
+struct wb_wait_queue_head {
+	wait_queue_head_t waitq;
+	wb_wait_wakeup_func_t wb_wakeup_func;
+};
+
  struct wb_completion {
  	atomic_t		cnt;
-	wait_queue_head_t	*waitq;
+	wb_wait_queue_head_t	*wb_waitq;
  };

+static inline void wb_default_wakeup_func(wb_wait_queue_head_t *wq_waitq,
+										  struct wb_completion *done)
+{
+	/* @done can't be accessed after the following dec */
+	if (atomic_dec_and_test(&done->cnt))
+		wake_up_all(&wq_waitq->waitq);
+}
+
+/* used for cgwb_frn, be careful here, @done can't be accessed */
+static inline void wb_empty_wakeup_func(wb_wait_queue_head_t *wq_waitq,
+										struct wb_completion *done)
+{
+}
+
+#define __init_wb_waitqueue_head(wb_waitq, func) 	\
+	do {											\
+		init_waitqueue_head(&wb_waitq.waitq);		\
+		wb_waitq.wb_wakeup_func = func; 			\
+	} while (0)
+
+#define init_wb_waitqueue_head(wb_waitq) 	\
+	__init_wb_waitqueue_head(wb_waitq, wb_default_wakeup_func)
+
+#define __WB_WAIT_QUEUE_HEAD_INITIALIZER(name, func) {	\
+	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(name.waitq),	\
+	.wb_wakeup_func = func, 							\
+}
+
+#define __DECLARE_WB_WAIT_QUEUE_HEAD(name, func) \
+	struct wb_wait_queue_head name = 
__WB_WAIT_QUEUE_HEAD_INITIALIZER(name, func)
+
+#define DECLARE_WB_WAIT_QUEUE_HEAD(name) \
+	__DECLARE_WB_WAIT_QUEUE_HEAD(name, wb_default_wakeup_func)
+
  #define __WB_COMPLETION_INIT(_waitq)	\
-	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
+	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .wb_waitq = (_waitq) }

  /*
   * If one wants to wait for one or more wb_writeback_works, each work's
@@ -190,7 +233,7 @@ struct backing_dev_info {
  	struct mutex cgwb_release_mutex;  /* protect shutdown of wb structs */
  	struct rw_semaphore wb_switch_rwsem; /* no cgwb switch while syncing */
  #endif
-	wait_queue_head_t wb_waitq;
+	wb_wait_queue_head_t wb_waitq;

  	struct device *dev;
  	char dev_name[64];
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..c4fec9e22978 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1008,7 +1008,7 @@ int bdi_init(struct backing_dev_info *bdi)
  	bdi->max_prop_frac = FPROP_FRAC_BASE;
  	INIT_LIST_HEAD(&bdi->bdi_list);
  	INIT_LIST_HEAD(&bdi->wb_list);
-	init_waitqueue_head(&bdi->wb_waitq);
+	init_wb_waitqueue_head(bdi->wb_waitq);
  	bdi->last_bdp_sleep = jiffies;

  	return cgwb_bdi_init(bdi);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..999624535470 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -99,7 +99,7 @@ static struct kmem_cache *memcg_cachep;
  static struct kmem_cache *memcg_pn_cachep;

  #ifdef CONFIG_CGROUP_WRITEBACK
-static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
+static __DECLARE_WB_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq, 
wb_empty_wakeup_func);
  #endif

  static inline bool task_is_dying(void)
@@ -3909,12 +3909,7 @@ static void mem_cgroup_css_released(struct 
cgroup_subsys_state *css)
  static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
  {
  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-	int __maybe_unused i;

-#ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
-		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
-#endif
  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
  		static_branch_dec(&memcg_sockets_enabled_key);



> 
> Thanks.
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

