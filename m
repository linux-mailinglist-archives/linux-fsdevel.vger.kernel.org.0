Return-Path: <linux-fsdevel+bounces-64740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB110BF35F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 22:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA4718977D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 20:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26942DF3FD;
	Mon, 20 Oct 2025 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+g0PzcG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34841EF39E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991704; cv=none; b=nNfsXRfrQDS6s5L9yXYLdI6IKaQKyXa66YqUkW0YXP5/FBGPuXnMsV1edFA4bkmAZKfzsSmzsz+pQ+IJ+/O4bBYTTtCvCPlNO9E0nVqZSjaWzLa0IqagIvhtlmENOK/01qSGZXqElpG8EGFdRR/l/spJpxyrynjgly5mqr57SxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991704; c=relaxed/simple;
	bh=O7ggk7Nya2Zw+h3bXNG0Q1fd+e9Ti+fQIx2OnLYhtnY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T8wp2SjyeMhDlS4wRZrna28SwI+Sa3Vyoswe+rNnh+eT2I1L+PosaTuUkeXZXtsKRdBukuhjp2BCJ86Np8Z9TNuFJBMH1lL5PfDvP+Rt0fZdcikQlmQDom0kkQBU5LJnyGCcv5bmYTHGwKXIVM35jFnvnyFogafCvYVdDZ7iXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+g0PzcG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760991701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4x/uC5ywndvfKWeWSRFra+0XOEMIfHFjLjomZb3RbvU=;
	b=F+g0PzcGroQfjesy3mF1zl6GoftZIkcZyB+WiRmdjaTtqbnfsunplo48Ul2zXnXqiZ6hMM
	Ywa5vYQcjxQHo86637o0A5SMFLCOgtXTz8hYLY6UBNMiFcE+pwVf9oWSouaPEOp8b2w6vB
	PMs6JKVzEio7KUkEa+YsMi/5Y/2bG/Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-OlYHeoF9Nr6Lhlhf9s4A1Q-1; Mon, 20 Oct 2025 16:21:40 -0400
X-MC-Unique: OlYHeoF9Nr6Lhlhf9s4A1Q-1
X-Mimecast-MFC-AGG-ID: OlYHeoF9Nr6Lhlhf9s4A1Q_1760991700
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88e2656b196so1550417385a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991699; x=1761596499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x/uC5ywndvfKWeWSRFra+0XOEMIfHFjLjomZb3RbvU=;
        b=s9+LTfQJBQubkNGwqyPEhHSLg806lXxbPLcYn90hpBr2+3vaZVKaQBvSrj08LBiCnV
         ATq4CRJs3O4XFAEcobzH56j4ShsLNJjbqldH/LIcp2OZ/9J6aZNQRpSyb9t1BcJl98YF
         jhmyylBvHzqlKeDLLI8PTXRHczJP9UKyyNrAsBjV+g2wwTSgnlfkHE72XS0QW3YvaGHA
         poQx/IBUSgLvhx2k7WW2jht66Za9+cYnl5HhgIPWXQ8L5BCd9eaHjXiXW9Ug1MJhYu4B
         5LS/yCeyvgywB52by/mYxocvX4nvUUYynoVihb67zAmJXvFSU5BHdcA8knUckVwaRIOW
         JkOA==
X-Forwarded-Encrypted: i=1; AJvYcCX9plNs/wkTw7vwrjrSqa44ELmnDGy+/Q5gcyCh/nBoW+cs+yip9AoEu1FtjO4rmFsG/4iOsD769d/6AQdc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iHyeNdH64nwkHMHl9flLewezrNvPRbITcMVGJ8R6SOeeFqH7
	84rEWod5scir4wPXixjIKcNOqL6w9nXvAWmZNRW3OEqWPmBJPZrlD9D579bXvweXDcteIj8e04X
	K5C1gXDbthkM895WTJU7Xr2GmqbLEQ1fXMcDeBazrkRSd77UvkqYeVtqag6nlDZ2MrKQ=
X-Gm-Gg: ASbGncsrl9Qx8v2U61As56WkliXGd7jTZcEcZlbp5IqqDnEyfFleN6lsVuZS6HHqBQo
	GWTMWXkoW+PzD1AsjVNFDaicG65+rr8ZVWtp/1GW1B6CAC5Rlk5GZrRrC/1VW/agyUapo316zKQ
	oJEnHBJkA9UiPNZo3t78IIMVkPZ8FvI2TEdOIb3TIKUTpYeresXanzlRG963uyOiqybVVvebdZS
	ZepLIqEsIRWUBrTdK2YU+EO6H+0530q1ccilpPXZc4kxEm+6X0xnk602rwYQsUSrPXPiyGLQL56
	K056A8TDDYEUn1XKX1rugxe/kYjle0iVg0WcnLV4OFf3g7tZ6rGTcIhtsj3ivTkNJWBnehlgM2a
	US0w2lXClH9lVKUXIdGoWspBwXOqHt9YLTN5gafJHQbYdmw==
X-Received: by 2002:a05:622a:1917:b0:4db:5202:d4c with SMTP id d75a77b69052e-4e89d297d9cmr186222761cf.23.1760991699572;
        Mon, 20 Oct 2025 13:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWyNuClL4yp5tggEpYb4T/9H2PBTt3fgPzqpjxOglETJgAfVNPI8KlxW+xaHSjXd56MMqJw==
X-Received: by 2002:a05:622a:1917:b0:4db:5202:d4c with SMTP id d75a77b69052e-4e89d297d9cmr186222281cf.23.1760991699103;
        Mon, 20 Oct 2025 13:21:39 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf8d4f6sm60534271cf.17.2025.10.20.13.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:21:38 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6967a07f-d48c-4fdf-8adc-414d5127b576@redhat.com>
Date: Mon, 20 Oct 2025 16:21:36 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: Enable full cpumask to clear user cpumask
 in sched_setaffinity()
To: David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Nico Pache <npache@redhat.com>,
 Phil Auld <pauld@redhat.com>, John Coleman <jocolema@redhat.com>
References: <20250923175447.116782-1-longman@redhat.com>
 <21ade241-76b9-4f0a-8e99-be033dcc882c@redhat.com>
Content-Language: en-US
In-Reply-To: <21ade241-76b9-4f0a-8e99-be033dcc882c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/20/25 4:13 PM, David Hildenbrand wrote:
> On 23.09.25 19:54, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
>> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
>> perserved even if the task is being moved to a different cpuset.
>> However, that affinity is also being inherited by any subsequently
>> created child processes which may not want or be aware of that affinity.
>
> So I assume setting the affinity to the full bitmap would then allow 
> any child to essentially reset to the default, correct?
Yes, that is the point.
>
>>
>> One way to solve this problem is to provide a way to back off from
>> that user provided CPU affinity.  This patch implements such a scheme
>> by using a full cpumask (a cpumask with all bits set) to signal the
>> clearing of the user cpumask to follow the default as allowed by
>> the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
>> the task behavior should be the same as with a NULL user_cpus_ptr.
>> This patch just formalizes it without causing any incompatibility and
>> discard an otherwise useless cpumask.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/sched/syscalls.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
>> index 77ae87f36e84..d68c7a4ee525 100644
>> --- a/kernel/sched/syscalls.c
>> +++ b/kernel/sched/syscalls.c
>> @@ -1229,14 +1229,22 @@ long sched_setaffinity(pid_t pid, const 
>> struct cpumask *in_mask)
>>           return retval;
>>         /*
>> -     * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
>> -     * alloc_user_cpus_ptr() returns NULL.
>> +     * If a full cpumask is passed in, clear user_cpus_ptr and reset 
>> the
>> +     * current cpu affinity to the default for the current cpuset.
>>        */
>> -    user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
>> -    if (user_mask) {
>> -        cpumask_copy(user_mask, in_mask);
>> +    if (cpumask_full(in_mask)) {
>> +        user_mask = NULL;
>>       } else {
>> -        return -ENOMEM;
>> +        /*
>> +         * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
>> +         * alloc_user_cpus_ptr() returns NULL.
>> +         */
>> +        user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
>> +        if (user_mask) {
>> +            cpumask_copy(user_mask, in_mask);
>> +        } else {
>> +            return -ENOMEM;
>> +        }
>>       }
>>         ac = (struct affinity_context){
>
> Not an expert on this code.
>
> I'm only wondering if there is somehow, some way we could be breaking 
> user space by doing that.
>
I don't think so. Setting user_cpus_ptr to a full cpumask will make the 
task strictly follow the cpumask restriction imposed by the current 
cpuset as if user_cpus_ptr isn't set.

Cheers,
Longman


