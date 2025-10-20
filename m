Return-Path: <linux-fsdevel+bounces-64736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11665BF352B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B578F3BAD0F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F52D061C;
	Mon, 20 Oct 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQMAf1Xj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624CE7D07D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990826; cv=none; b=eX5U4DBy1MxgJGLiJTOokAfHZyzIIj77/FpdR1Opfgg9EJPzK4FmlBlIzWdZmyus1ZS715zKDsjMfysux8mMvBycSt81xpXArywbDjqVrQO4CB11JtAAT6EsZKPZbRSIVvlcnF+QBsSphufjEE6ZHDcaNQWaWECL2xHcEy8BWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990826; c=relaxed/simple;
	bh=TepVpHg8AVpSrg+5W+IoBXQqQu1WmaltNqJVHkqahjw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n1JNv1FGWCQGy6js/2P/JQx5hVg0Tn94+L90bGtsYL4DvdTl+GBMnAZ9LfnytER4T1LziCvhlzvtUnUgPooDdGcmK/BsQ2rlBnZYzTPANLdvpWtizmJOWrPwfkrdPVZc9BGYhIvZFw1+JGiib7VCo+f1TJ2AKnVlfCyCy5JdiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQMAf1Xj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760990823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKh7G80lkv2sTBwVQW8NOrlVTbOZbgJeWVR4B2ZVux0=;
	b=iQMAf1XjXQoxRsXQ+eRBD5dPHNF0bGEZpuzO5t8sOMoT52E5GWVywnX0r4Ghv18dffiqlb
	KgJ2rwrQ1gHaPjgXEW60CelQs1G73p+DsS4PxhamXVJL5WCRYtNHOnEP6NeedWdmxpJVYY
	fM3X6v1L3szaHvXr6VclBHnKIqBQT7k=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-AdZ9_daoOn2LnPLwU-qrKQ-1; Mon, 20 Oct 2025 16:07:02 -0400
X-MC-Unique: AdZ9_daoOn2LnPLwU-qrKQ-1
X-Mimecast-MFC-AGG-ID: AdZ9_daoOn2LnPLwU-qrKQ_1760990821
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6325a95e44so3999873a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990821; x=1761595621;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKh7G80lkv2sTBwVQW8NOrlVTbOZbgJeWVR4B2ZVux0=;
        b=OQQf4uirAGUWOeAVpJgT+x/Kerq5iCi1IBtthVuJalV+y/r33u320wmQYiEYZ/pFHW
         Q1ITC/O+CszjGpE3Mn8d73DCsFfTK2FT8cQmtVBZZ93VDcwP9J4gpHNQXxG/V8WHTmVT
         mLPm2fSGPMGn+qRirga/Tt1PowNQwEHiyxKjVk/T8m+8j/hpQUq36LzbkCg2BDgGOSR/
         IXxp/TO3H3FoTKtb/T5l30hFnuF3pc7tdszWGxp9kloFCzNqmq2caVDs+yeOYtFBlJ63
         XPdv8blAJaDQfPeJ5qpTL8/n6Q8oo0vEeov23qHBlm/w+eYHQN/RfPSFwvotUbg9nxul
         3eiw==
X-Forwarded-Encrypted: i=1; AJvYcCWk2PR3+yKd89P9uQWnqG29x/wi4oqSs/Ch6qJ5PYj1x1yBR84xCRseL7tczvGbv8mGNzsdPsmi/DRbqIhr@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWhSl9/YXpp7IBp4tkuXWvd1Ir+kPLH6hKIa3YgtrnU1VTSzv
	eHaFj2DllVjN5H0lZ9P9llegsCN4myjckcXrFgfAnPSIhhPOsOAVGdWTTJ0ctCXUwiAOAcMdjen
	bIDY8MKrd1bgc7ljq7w/OzIw72ln2vldZBRjXsdd8XTeA6F602qRG6kLTvy+9F+pwjG0=
X-Gm-Gg: ASbGnct0UsYgtezlf/W8zjZbBkCGDoI4HjL9wgqBPYv3Rd7LxUfZ1jeQxS30ROqRdJ4
	JDNx3Px33pJp+iiX0UpqV+72BbCXeM2pmuOGYDBlaBolkR+EeEECpToQBM4btwTLlbvqtdJCqLZ
	CWVVRC0dC7rDlwLS/Y6A3Ut0oknJZVrnefBxTKtjPWLUUHOK0eaU1vAGUG/7RmEWSYsVOUJJquV
	Uy4E9k0QWvozpt1z/RGkyEAFTeYsllxdM9FyStIOQk+l7is0L9x0p8HNmx1UdzR6zJ5csAb+dpR
	Y3T3Z69X9zS6TJY+NVxbCp9xkSd0awj1nNaOTVbFQZ78HgUv9qYURR6SKtHAMt8kqqhWyahuxQR
	rJe+B1OmDXYEIp3M6iZhSb0h3PrEdB95wCaaLdkmQDJi5Vg==
X-Received: by 2002:a05:6a20:2443:b0:334:92ac:602e with SMTP id adf61e73a8af0-334a7a5ff7dmr20340276637.30.1760990820900;
        Mon, 20 Oct 2025 13:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfTrmFc6qObTq7RgTaOXi9eaIyZMYW7lgC66KaADWOu31BdOjK1L/BD4LajKA4fu+SbfJTg==
X-Received: by 2002:a05:6a20:2443:b0:334:92ac:602e with SMTP id adf61e73a8af0-334a7a5ff7dmr20340236637.30.1760990820374;
        Mon, 20 Oct 2025 13:07:00 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39442sm9136114b3a.20.2025.10.20.13.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:06:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9160740c-a56f-4fb0-bda7-bbdaa04f1d3d@redhat.com>
Date: Mon, 20 Oct 2025 16:06:58 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: Enable full cpumask to clear user cpumask
 in sched_setaffinity()
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Nico Pache <npache@redhat.com>,
 Phil Auld <pauld@redhat.com>, John Coleman <jocolema@redhat.com>
References: <20250923175447.116782-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250923175447.116782-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 1:54 PM, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset.
> However, that affinity is also being inherited by any subsequently
> created child processes which may not want or be aware of that affinity.
>
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using a full cpumask (a cpumask with all bits set) to signal the
> clearing of the user cpumask to follow the default as allowed by
> the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
> the task behavior should be the same as with a NULL user_cpus_ptr.
> This patch just formalizes it without causing any incompatibility and
> discard an otherwise useless cpumask.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/sched/syscalls.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 77ae87f36e84..d68c7a4ee525 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1229,14 +1229,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>   		return retval;
>   
>   	/*
> -	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> -	 * alloc_user_cpus_ptr() returns NULL.
> +	 * If a full cpumask is passed in, clear user_cpus_ptr and reset the
> +	 * current cpu affinity to the default for the current cpuset.
>   	 */
> -	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> -	if (user_mask) {
> -		cpumask_copy(user_mask, in_mask);
> +	if (cpumask_full(in_mask)) {
> +		user_mask = NULL;
>   	} else {
> -		return -ENOMEM;
> +		/*
> +		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> +		 * alloc_user_cpus_ptr() returns NULL.
> +		 */
> +		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> +		if (user_mask) {
> +			cpumask_copy(user_mask, in_mask);
> +		} else {
> +			return -ENOMEM;
> +		}
>   	}
>   
>   	ac = (struct affinity_context){

Any comment or suggested improvement on this patch and the following one?

Thanks,
Longman


