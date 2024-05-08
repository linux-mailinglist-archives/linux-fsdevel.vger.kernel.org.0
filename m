Return-Path: <linux-fsdevel+bounces-19147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A18C0A8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 06:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C288A1C21169
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 04:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4598C148FE1;
	Thu,  9 May 2024 04:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZHZiXpi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083110E5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230032; cv=none; b=j8Zi1TEScgGrJV8KLTGUAGDMnpcenmwHWEvLgxH504DcmUKnHJUkB186n6FjuyRTBCRYtTkwlINz+u/v8zZ1J6Rt3a0GgubpRf3zKWFBn9QnEWN2oT6Trne6B7qpiVxXZggFe5wEAgnUJdQig8einCve7piiAFGb8DT3cZitCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230032; c=relaxed/simple;
	bh=buoPxiUYl4Q0c2MkWof6PRlmVIB+2DTKwveRiixfmSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkS67KrV9Xm87xZrP8Kamamp4bNhHadQkj9YbJiJnQb+rNi/IWew5KhPuYLgnYDruLjJlIzjVe7jHGVNHcv0G16BDmUaEzV+6y5WTCUMUBSroa1mwhantkXryOZBmHJ/R7tO9vlElEL0tCXsye2KAHpjcMg7SoN9zvTzwOBgIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZHZiXpi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715230030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiDkouuHBxEQ48cCxAAxKmsT/M+EhKgEfBASxmW5rGA=;
	b=hZHZiXpim9xsMXgv8pfV1hGA0eBILi5vFzShg7jKQRU+WU83LrytbJDpHf9qOwpwDRxJmC
	AY3gwoWeppquG78Lud3qSvueMpv/xnFAltv0wb0HFcPWfEYdyLf3mSFGSyoOlByoNkYWuN
	/1koHjqfFKGhvrxvNTZQLAlc9dqSE2U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-W2BasM1vOn6Wfduln_v98Q-1; Thu, 09 May 2024 00:47:04 -0400
X-MC-Unique: W2BasM1vOn6Wfduln_v98Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C613A8007BC;
	Thu,  9 May 2024 04:47:03 +0000 (UTC)
Received: from [10.22.32.103] (unknown [10.22.32.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E8F7492CAB;
	Thu,  9 May 2024 04:47:02 +0000 (UTC)
Message-ID: <e7701346-6134-4bdc-8ccc-530be314a517@redhat.com>
Date: Wed, 8 May 2024 13:01:58 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/proc: Print user_cpus_ptr for task status
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Xuewen Yan
 <xuewen.yan@unisoc.com>, akpm@linux-foundation.org, oleg@redhat.com,
 dylanbhatch@google.com, rick.p.edgecombe@intel.com, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240429084633.9800-1-xuewen.yan@unisoc.com>
 <20240429121000.GA40213@noisy.programming.kicks-ass.net>
 <CAB8ipk831xtAW2+sm-evm-oOsFspL=xSp6hFYYq1uKmWA+porQ@mail.gmail.com>
 <e402d623-1875-47a2-9db3-8299a54502ef@redhat.com>
 <CAB8ipk-yz+6X2E7BsJmNqVgZDjE8NkJFNdqFU+WLieKVhFaCuA@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAB8ipk-yz+6X2E7BsJmNqVgZDjE8NkJFNdqFU+WLieKVhFaCuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


On 5/7/24 02:57, Xuewen Yan wrote:
>> These changes essentially reverts commit 851a723e45d1c("sched: Always
>> clear user_cpus_ptr in do_set_cpus_allowed()") except the additional
>> caller in the cpuset code.
>>
>> How about the following less invasive change?
>>
>>    diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 7019a40457a6..646837eab70c 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p,
>> struct affinity_context *ctx)
>>    }
>>
>>    /*
>> - * Used for kthread_bind() and select_fallback_rq(), in both cases the user
>> - * affinity (if any) should be destroyed too.
>> + * Used for kthread_bind() and select_fallback_rq(). Destroy user affinity
>> + * if no intersection with the new mask.
>>     */
>>    void do_set_cpus_allowed(struct task_struct *p, const struct cpumask
>> *new_mask)
>>    {
>>           struct affinity_context ac = {
>>                   .new_mask  = new_mask,
>>                   .user_mask = NULL,
>> -               .flags     = SCA_USER,  /* clear the user requested mask */
>> +               .flags     = 0,
>>           };
>>           union cpumask_rcuhead {
>>                   cpumask_t cpumask;
>>                   struct rcu_head rcu;
>>           };
>>
>> +       if (current->user_cpus_ptr &&
>> !cpumask_intersects(current->user_cpus_ptr, new_mask))
> Thanks for your suggestion, and I try it and as for me, it works well,
> but I change the "current" to p.
> I think “current” is inappropriate because what is changed here is the
> mask of p.
> It is possible that “p” and “current” are not equal.
>
> I would send the next patch later and add your Suggested-by. Thanks
> again for your advice!

You are right. It should be "p" instead of "current".

Thanks,
Longman


