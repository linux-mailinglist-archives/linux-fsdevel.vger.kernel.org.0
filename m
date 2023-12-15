Return-Path: <linux-fsdevel+bounces-6193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A2814A8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 15:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F641C228CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B60364B9;
	Fri, 15 Dec 2023 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kq4UbYwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E61856
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Dec 2023 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4865347-110f-4648-a16e-2d453d849323@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702650676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qe4Vv2WCEvd4ouMbR/Hft2N+D0eJgtFU87sk0W4t3gI=;
	b=Kq4UbYwLOU0kjnanSGnEYL9yQST4aXjg2RXUgAgjJd73Pkm5str2CvQlKZPVjFJp2aFNrS
	xBRgtIGGSoCQK4Og5hngQcM4GQhvJqgqCaH13M3d/T9GENasLYbcCezlZLIhdpRF/wAuEq
	E6OHe8GWPuieH0LVb29wuPwsIcmbVdk=
Date: Fri, 15 Dec 2023 06:31:08 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v3 1/3] bpf: cgroup: Introduce helper
 cgroup_bpf_current_enabled()
Content-Language: en-GB
To: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexei Starovoitov <ast@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Quentin Monnet <quentin@isovalent.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi
 <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-2-michael.weiss@aisec.fraunhofer.de>
 <6960ef41-fe22-4297-adc7-c85264288b6d@linux.dev>
 <3e085cef-e74d-417b-ab9b-b8795fa5e5c3@aisec.fraunhofer.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <3e085cef-e74d-417b-ab9b-b8795fa5e5c3@aisec.fraunhofer.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/14/23 12:17 AM, Michael Weiß wrote:
> On 13.12.23 17:59, Yonghong Song wrote:
>> On 12/13/23 6:38 AM, Michael Weiß wrote:
>>> This helper can be used to check if a cgroup-bpf specific program is
>>> active for the current task.
>>>
>>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>>> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
>>> ---
>>>    include/linux/bpf-cgroup.h |  2 ++
>>>    kernel/bpf/cgroup.c        | 14 ++++++++++++++
>>>    2 files changed, 16 insertions(+)
>>>
>>> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
>>> index a789266feac3..7cb49bde09ff 100644
>>> --- a/include/linux/bpf-cgroup.h
>>> +++ b/include/linux/bpf-cgroup.h
>>> @@ -191,6 +191,8 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
>>>    	return array != &bpf_empty_prog_array.hdr;
>>>    }
>>>    
>>> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type);
>>> +
>>>    /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enabled. */
>>>    #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
>>>    ({									      \
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 491d20038cbe..9007165abe8c 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -24,6 +24,20 @@
>>>    DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
>>>    EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>>>    
>>> +bool cgroup_bpf_current_enabled(enum cgroup_bpf_attach_type type)
>>> +{
>>> +	struct cgroup *cgrp;
>>> +	struct bpf_prog_array *array;
>>> +
>>> +	rcu_read_lock();
>>> +	cgrp = task_dfl_cgroup(current);
>>> +	rcu_read_unlock();
>>> +
>>> +	array = rcu_access_pointer(cgrp->bpf.effective[type]);
>> This seems wrong here. The cgrp could become invalid once leaving
>> rcu critical section.
> You are right, maybe we where to opportunistic here. We just wanted
> to hold the lock as short as possible.
>
>>> +	return array != &bpf_empty_prog_array.hdr;
>> I guess you need include 'array' usage as well in the rcu cs.
>> So overall should look like:
>>
>> 	rcu_read_lock();
>> 	cgrp = task_dfl_cgroup(current);
>> 	array = rcu_access_pointer(cgrp->bpf.effective[type]);
> Looks reasonable, but that we are in the cs now I would change this to
> rcu_dereference() then.

copy-paste error. Right, should use rcu_deference() indeed.

>
>> 	bpf_prog_exists = array != &bpf_empty_prog_array.hdr;
>> 	rcu_read_unlock();
>>
>> 	return bpf_prog_exists;
>>
>>> +}
>>> +EXPORT_SYMBOL(cgroup_bpf_current_enabled);
>>> +
>>>    /* __always_inline is necessary to prevent indirect call through run_prog
>>>     * function pointer.
>>>     */

