Return-Path: <linux-fsdevel+bounces-62400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7898B91569
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF0B7A99D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792E30F80A;
	Mon, 22 Sep 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dK/u7QIz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166C30AD18
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546806; cv=none; b=NtdKnbiucLGgOzCzjxh3BspD1YeMYVzIDJKcycMwgh1H57kvwSFPcc7Q8/3zdbr22JsplsKpZ+pjcNVgtla99kMvZ7Vv8rxKW2hYYQJkU98GfS2mQ9wg5W/SGHazcu/FHq3ghbWo76sa14U/Oqz1mKFx6NMyXWBcAeLy6h/uPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546806; c=relaxed/simple;
	bh=5zHMOFXhLYcGYpuGqUAIQTZp9YNferhptwJkMmePypA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7jkMXZL6qPvENjPBi8CIxEWqC5tde1pF6s0mMyGbvJLNB5o0NvRJ2JnXxRAc9N2nAh2VW+18rMjuyQdr35NlVtG466OZQkuHBcKS65dgUDHWGiI2CV0ry65pI6ofrWM1DGX7+WccGY2z8iAEwXZRtxE0ACWpLUgPtcIOpUl5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dK/u7QIz; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9425363e-944f-4f37-bc5b-2586e44a5c5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758546791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=raKb65psehcLkkOZdhfWHFNT0u/LqjfCnelD8FHHqRU=;
	b=dK/u7QIzJQnY76REVPpeCUeC2oWFVGq323Sul50DUh0txZybhqW77dSdnDRqK/Zml0/844
	QA70X3tulKj6HcRtdlmGpwmTopt7FkmyMWJ035Lu1mMDriOZG5p/w01OFM/a58ok9ppd2y
	vPmMQcjAi2MHWJVWGkIsrZIbjT6GZbI=
Date: Mon, 22 Sep 2025 21:12:44 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
Content-Language: en-US
To: Julian Sun <sunjunchao@bytedance.com>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
 <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/22 20:40, Julian Sun wrote:
> On 9/22/25 7:38 PM, Lance Yang wrote:
> 
> Hi, Lance
> 
> Thanks for your review and comments.
> 
>> Hi Julian
>>
>> Thanks for the patch series!
>>
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
> The flag takes effect only when wait_event_no_hung() or 
> wb_wait_for_completion_no_hung() is called, and its effect is limited to 
> a single wait event, without affecting subsequent wait events. So AFAICS 
> it will not mask real hang warnings.>

Emm... the risk of future misuse is what worries me. I would rather have
call sites actively "pet the watchdog" by periodically calling a helper
like touch_hung_task_detector(), instead of passively ignoring the detector.

>>>
>>> Patch 2 introduces wait_event_no_hung() and 
>>> wb_wait_for_completion_no_hung(),
>>> which enable the hung task detector to ignore hung tasks caused by these
>>> wait events.
>>
>> Instead of making the detector ignore the task, what if we just change
>> the waiting mechanism? Looking at wb_wait_for_completion(), we could
>> introduce a new helper that internally uses wait_event_timeout() in a
>> loop.
>>
>> Something simple like this:
>>
>> void wb_wait_for_completion_no_hung(struct wb_completion *done)
>> {
>>          atomic_dec(&done->cnt);
>>          while (atomic_read(&done->cnt))
>>                  wait_event_timeout(*done->waitq, !atomic_read(&done- 
>>  >cnt), timeout);
>> }
>>
>> The periodic wake-ups from wait_event_timeout() would naturally prevent
>> the detector from complaining about slow but eventually completing 
>> writeback.
> 
> Yeah, this could definitely eliminate the hung task warning complained 
> here.
> However what I aim to provide is a general mechanism for waiting on 
> events. Of course, we could use code similar to the following, but this 
> would introduce additional overhead from waking tasks and multiple 
> operations on wq_head—something I don't want to introduce.

Yeah, I agree there's some overhead with a polling approach, but
mem_cgroup_css_free() should be an infrequent operation. So, I think it's
an acceptable trade-off :)

> 
> +#define wait_event_no_hung(wq_head, condition) \
> +do {                   \
> +       while (!(condition))    \
> +               wait_event_timeout(wq_head, condition, timeout); \
> +}
> 
> But I can try this approach or do not introcude wait_event_no_hung() if 
> you want.>

Well, let's see what other folks think ;)

Cheers,
Lance

>>>
>>> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of 
>>> memcg
>>> teardown to eliminate the hung task warning.
>>>
>>> Julian Sun (3):
>>>    sched: Introduce a new flag PF_DONT_HUNG.
>>>    writeback: Introduce wb_wait_for_completion_no_hung().
>>>    memcg: Don't trigger hung task when memcg is releasing.
>>>
>>>   fs/fs-writeback.c           | 15 +++++++++++++++
>>>   include/linux/backing-dev.h |  1 +
>>>   include/linux/sched.h       | 12 +++++++++++-
>>>   include/linux/wait.h        | 15 +++++++++++++++
>>>   kernel/hung_task.c          |  6 ++++++
>>>   mm/memcontrol.c             |  2 +-
>>>   6 files changed, 49 insertions(+), 2 deletions(-)
>>>
>>
> 
> Thanks,


