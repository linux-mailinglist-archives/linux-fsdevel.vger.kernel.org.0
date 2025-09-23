Return-Path: <linux-fsdevel+bounces-62469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB77B9401B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 04:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC54C18A5C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64862580ED;
	Tue, 23 Sep 2025 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bd65Eu2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44237082F
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594653; cv=none; b=gWzb8E3CXGT3ukkiDN4y6YK22QljV/LYV5oUXuzrDJIRYcXzUBsfTeKdlGqnLcUnm8edZCsdD95Q28gXMoNcVSZm6OOI0u20lHwB9cewCgqmzA/FsWvaQzYm1Z0nZd6CyTZON3xVk0HKPh8234UQElEola7amxXbEBJZax7zs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594653; c=relaxed/simple;
	bh=zVsvfzF7l8S37V68K7yE59UBHuIy/MHh6e3O4SFcG5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2ppdU02E/ec6nVXvUs6cuQwIC3h4DYwwLZPyhFim1ED/uJXSDQJZ22Q7fJEcyGGfoXz6pEDJhRZY0cOtxQ2SY9VMAYqqqSU1yu2w3vDQAq+Lw6OL4c1U+MQSSfm+RNeBt7W+KzxeBjF15vNKqKp7dvWll2Vs1QVF2v9wrxjWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bd65Eu2S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9665ff9f-3e1d-4c39-8c8f-b9e12fb4d5f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758594636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4s0MlcnpZmVcg3BNEOPRfxUXtgBs293LEDa79kz3gE=;
	b=bd65Eu2SXHriQjtws44NJSLp1oJPai+UtRQ7VryME04ujiEP6HgCMkmlwobwmV1bjMTnev
	E+L5ob/VfdXPCUXd0pmX46qini5ReYfjp3lVQJ6TV1EKSH1RD5ayZ1z1P8pGUF8tkQzjQr
	dYDZyuJayMK6+FV8rxxpi931IMeak5Y=
Date: Tue, 23 Sep 2025 10:30:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Content-Language: en-US
To: Julian Sun <sunjunchao@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: mhiramat@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 agruenba@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
 <20250922145754.31890092257495f70db3909d@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250922145754.31890092257495f70db3909d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/23 05:57, Andrew Morton wrote:
> On Mon, 22 Sep 2025 19:38:21 +0800 Lance Yang <lance.yang@linux.dev> wrote:
> 
>> On 2025/9/22 17:41, Julian Sun wrote:
>>> As suggested by Andrew Morton in [1], we need a general mechanism
>>> that allows the hung task detector to ignore unnecessary hung
>>
>> Yep, I understand the goal is to suppress what can be a benign hung task
>> warning during memcg teardown.
>>
>>> tasks. This patch set implements this functionality.
>>>
>>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
>>> ignores all tasks that have the PF_DONT_HUNG flag set.
>>
>> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
>> and might mask real, underlying hangs.
> 
> I think that's OK if the calling task is discriminating about it.  Just
> set PF_DONT_HUNG (unpleasing name!) around those bits of code where
> it's needed, clear it otherwise.

Makes sense to me :)

> 
> Julian, did you take a look at what a touch_hung_task_detector() would
> involve?  It's a bit of an interface inconsistency - our various other
> timeout detectors (softlockup, NMI, rcu) each have a touch_ function.

On second thought, I agree that a touch_hung_task_detector() would be a
much better approach for interface consistency.

We could implement touch_hung_task_detector() to grant the task temporary
immunity from hung task checks for as long as it remains uninterruptible.
Once the task becomes runnable again, the immunity is automatically revoked.

Something like this:

---
diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index c4403eeb7144..fac92039dce0 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -98,4 +98,9 @@ static inline void *hung_task_blocker_to_lock(unsigned 
long blocker)
  }
  #endif

+void touch_hung_task_detector(struct task_struct *t)
+{
+	t->last_switch_count = ULONG_MAX;
+}
+
  #endif /* __LINUX_HUNG_TASK_H */
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..094a277b3b39 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -203,6 +203,9 @@ static void check_hung_task(struct task_struct *t, 
unsigned long timeout)
  	if (unlikely(!switch_count))
  		return;

+	if (t->last_switch_count == ULONG_MAX)
+		return;
+
  	if (switch_count != t->last_switch_count) {
  		t->last_switch_count = switch_count;
  		t->last_switch_time = jiffies;
@@ -317,6 +320,9 @@ static void 
check_hung_uninterruptible_tasks(unsigned long timeout)
  		    !(state & TASK_WAKEKILL) &&
  		    !(state & TASK_NOLOAD))
  			check_hung_task(t, timeout);
+		else if (t->last_switch_count == ULONG_MAX)
+			t->last_switch_count = t->nvcsw + t->nivcsw;
+
  	}
   unlock:
  	rcu_read_unlock();
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dc470aa6c3c..3d5f36455b74 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3910,8 +3910,10 @@ static void mem_cgroup_css_free(struct 
cgroup_subsys_state *css)
  	int __maybe_unused i;

  #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		touch_hung_task_detector(current);
  		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	}
  #endif
  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
  		static_branch_dec(&memcg_sockets_enabled_key);
---

Using ULONG_MAX as a marker to grant this immunity. As long as the task
remains in state D, check_hung_task() sees the marker and bails out.

