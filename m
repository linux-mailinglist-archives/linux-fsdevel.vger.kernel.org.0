Return-Path: <linux-fsdevel+bounces-45724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B24FCA7B7E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F632189CC1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92018BC3D;
	Fri,  4 Apr 2025 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UVXvNaRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AD155316;
	Fri,  4 Apr 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748751; cv=none; b=p19rQB3Jf91qb01J87D/4YHa20w8Lu8F5gxEL4LSkxwGrFmxllQpHhLLU999LwVE+iTyrAFAzZ53jnK9U7hiqN843FDLJpJNd/9wYr8LT/pm3xs5Jru1z1j4ndVSrAj3r+5Lv9yQGKLYCKYBjkMN1N9mtVf4pgp6EUeeAyYkR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748751; c=relaxed/simple;
	bh=IfIl8FE43pGx+uQUjFgWd8RZQmiuKxZdD9ewBzSoVio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZR+L5iaGNRUZFC1SjAgEt96S3wn+tKY8ucufLryoFZvlvSKiYurf4Fm7wlS9+eoVOX7UUKJj3l0ldsCfgE+/IFN2ZgHk83xVhQaMuvbodg42llB0TcTp+wHG9yIvjg7Nu/evLAEDcMU+L3n+yOi6Q6pxYAuXao6zBpkWT51Jp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UVXvNaRv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uXwHVhIQiwQ3uewZeyB4MHzXT2Md9jRYI048JFRNUHo=; b=UVXvNaRvohlIod85Wo7r6eTwEA
	eaQFuyGce9TLEyIIkuWx6dA8epXQXo5zR91aSQsoUMN2mFXvENJz8wmC2LWbgZnp5YblZXkBOXmoy
	1tJLQ2Gp9QU7iNaxP5VMd8mN9iRAaWTQ28+kIDY20WM98OfYfhpM2pmGhz5kIUXV1z5mI1lcTMdXi
	0hC5CUXpWhq16z4Pk47YCNXFcCVzPJjXZjXjYULxjvEuvwvFGOEPXCgmM/XfszU+o0ms42YD4Rp/S
	vHd//uyxeQ8qE0DAfUPVMOJ7GVblx8/yJZEkVlq+rBAz6aSwQHlA++xcueVcPf2C29ihSZUB1I+1A
	liG80V1Q==;
Received: from [223.233.74.223] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u0ahf-00BDfn-Mg; Fri, 04 Apr 2025 08:38:59 +0200
Message-ID: <ce03ac93-c8ee-4803-acdc-597dd432207b@igalia.com>
Date: Fri, 4 Apr 2025 12:08:55 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] kthread: Use 'task_struct->full_name' to store
 kthread's full name
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-4-bhupesh@igalia.com> <202504030923.1FE7874F@keescook>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202504030923.1FE7874F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kees,

On 4/3/25 9:54 PM, Kees Cook wrote:
> On Mon, Mar 31, 2025 at 05:48:20PM +0530, Bhupesh wrote:
>> Commit 6986ce24fc00 ("kthread: dynamically allocate memory to store
>> kthread's full name"), added 'full_name' in parallel to 'comm' for
>> kthread names.
>>
>> Now that we have added 'full_name' added to 'task_struct' itself,
>> drop the additional 'full_name' entry from 'struct kthread' and also
>> its usage.
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> I'd like to see this patch be the first patch in the series. This show
> the existing use for "full_name". (And as such it'll probably need bits
> from patch 1.)

Sure, I will fix this in v3.

Thanks,
Bhupesh

>
>> ---
>>   kernel/kthread.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 5dc5b0d7238e..46fe19b7ef76 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -66,8 +66,6 @@ struct kthread {
>>   #ifdef CONFIG_BLK_CGROUP
>>   	struct cgroup_subsys_state *blkcg_css;
>>   #endif
>> -	/* To store the full name if task comm is truncated. */
>> -	char *full_name;
>>   	struct task_struct *task;
>>   	struct list_head hotplug_node;
>>   	struct cpumask *preferred_affinity;
>> @@ -108,12 +106,12 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
>>   {
>>   	struct kthread *kthread = to_kthread(tsk);
>>   
>> -	if (!kthread || !kthread->full_name) {
>> +	if (!kthread || !tsk->full_name) {
>>   		strscpy(buf, tsk->comm, buf_size);
>>   		return;
>>   	}
>>   
>> -	strscpy_pad(buf, kthread->full_name, buf_size);
>> +	strscpy_pad(buf, tsk->full_name, buf_size);
>>   }
>>   
>>   bool set_kthread_struct(struct task_struct *p)
>> @@ -153,7 +151,6 @@ void free_kthread_struct(struct task_struct *k)
>>   	WARN_ON_ONCE(kthread->blkcg_css);
>>   #endif
>>   	k->worker_private = NULL;
>> -	kfree(kthread->full_name);
>>   	kfree(kthread);
>>   }
>>   
>> @@ -430,7 +427,7 @@ static int kthread(void *_create)
>>   		kthread_exit(-EINTR);
>>   	}
>>   
>> -	self->full_name = create->full_name;
>> +	self->task->full_name = create->full_name;
>>   	self->threadfn = threadfn;
>>   	self->data = data;
>>   
>> -- 
>> 2.38.1
>>


