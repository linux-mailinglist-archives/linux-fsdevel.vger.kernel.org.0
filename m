Return-Path: <linux-fsdevel+bounces-49841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D6BAC3E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 13:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83F83B9A23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 11:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D111FBE80;
	Mon, 26 May 2025 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dOgOkcgW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333327454;
	Mon, 26 May 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258054; cv=none; b=KtJEebJo7U5LmGe0ioPq9grMxeJjFfrgbi8b5RYqpvqyD9i4NG3LmAn/xAcOt2FBs9tq6J+uaxvMfQFb9/CfMXyjxDVOHrMTOLiaUUWIm6BarDMHHb/vGXyUqfOGDW7bKWBMF+84KXWcYwXlNS1rddfQ56k0wle3d4NosrN2+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258054; c=relaxed/simple;
	bh=hVGhZucvzX5ojlygkfesTT5oBv5VBt6Jo24Z6T3XFmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUhqbOMVN6Ia0uLYWqdAbkF2yDtR1wm0BoUDAoweigvw6oeF/TlcqPYwVAK1abtaixLuQx7u5Oglv+v0IxTF+iHUYCg17REJxwXJlcdIob8Jb8JZTe8e5iYwOea3SouNixi8LK33tzy/2SU1XmxAiA835acCCKZG0Uqw3XMnvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dOgOkcgW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sRNyPwXExErBy/8kJGAzUEFc8FCKqjhWu+hUzGskcX8=; b=dOgOkcgW3891K46lC3h/P8Giqy
	j5wpFWLFbNsIvtu/CSMhuFpyXc2GMmf/qW7htsdUuVeQHy4WDIcUcklGJ/ViGPPunnUieV9Q4IDtY
	70vmdgOjsG/48WsDWWmRsgX30TeD25TnjOsUCjtkWJ8k3jGqeGKxRcEtaaR8bnvQ6O//TGBBuqxEm
	T9eJVseaQnlwEULmm3DUUsYFcCO4JUm3QzyGMhJ7MbX7DRjfIxy6Nuz+t721q3JL8uYv2FRdti1TE
	iXAOOvdxAotvmC56UVFnZM0j6AKJPYx3gSPt4AVRPNX7xCbTzeO3zT+lJmLdb3I0e/ttaelmWVQne
	f2AjMJBg==;
Received: from [223.233.79.88] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uJVmL-00DHZz-KJ; Mon, 26 May 2025 13:14:01 +0200
Message-ID: <1bc43d6c-2650-0670-8c2a-25e8d36cfb7c@igalia.com>
Date: Mon, 26 May 2025 16:43:52 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/3] exec: Add support for 64 byte 'tsk->comm_ext'
Content-Language: en-US
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-4-bhupesh@igalia.com>
 <202505222041.B639D482FB@keescook>
 <a7c323fe-6d11-4a21-a203-bd60acbfd831@igalia.com>
 <202505231346.52F291C54@keescook>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <202505231346.52F291C54@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kees,

On 5/24/25 2:25 AM, Kees Cook wrote:
> On Fri, May 23, 2025 at 06:01:41PM +0530, Bhupesh Sharma wrote:
>> 2. %s usage: I checked this at multiple places and can confirm that %s usage
>> to print out 'tsk->comm' (as a string), get the longer
>>      new "extended comm".
> As an example of why I don't like this union is that this is now lying
> to the compiler. e.g. a %s of an object with a known size (sizeof(comm))
> may now run off the end of comm without finding a %NUL character... this
> is "safe" in the sense that the "extended comm" is %NUL terminated, but
> it makes the string length ambiguous for the compiler (and any
> associated security hardening).

Right.

>
>> 3. users who do 'sizeof(->comm)' will continue to get the old value because
>> of the union.
> Right -- this is exactly where I think it can get very very wrong,
> leaving things unterminated.
>
>> The problem with having two separate comms: tsk->comm and tsk->ext_comm,
>> instead of a union is two fold:
>> (a). If we keep two separate statically allocated comms: tsk->comm and
>> tsk->ext_comm in struct task_struct, we need to basically keep supporting
>> backward compatibility / ABI via tsk->comm and ask new user-land users to
>> move to tsk->ext_comm.
>>
>> (b). If we keep one statically allocated comm: tsk->comm and one dynamically allocated tsk->ext_comm in struct task_struct, then we have the problem of allocating the tsk->ext_comm which _may_ be in the exec()  hot path.
>>
>> I think the discussion between Linus and Yafang (see [1]), was more towards avoiding the approach in 3(a).
>>
>> Also we discussed the 3(b) approach, during the review of v2 of this series, where there was a apprehensions around: adding another field to store the task name and allocating tsk->ext_comm dynamically in the exec() hot path (see [2]).
> Right -- I agree we need them statically allocated. But I think a union
> is going to be really error-prone.
>
> How about this: rename task->comm to something else (task->comm_str?),
> increase its size and then add ABI-keeping wrappers for everything that
> _must_ have the old length.
>
> Doing this guarantees we won't miss anything (since "comm" got renamed),
> and during the refactoring all the places where the old length is required
> will be glaringly obvious. (i.e. it will be harder to make mistakes
> about leaving things unterminated.)
>

Ok, I got your point. Let me explore then how best a ABI-keeping wrapper 
can be introduced.
I am thinking of something like:

abi_wrapper_get_task_comm {

     if (requested_comm_length <= 16)
         return 16byte comm with NUL terminator; // old comm (16-bytes)
     else
         return 64byte comm with NUL terminator; // extended comm (64-bytes)
     ....
}

Please let me know if this looks better. Accordingly I will start with 
v5 changes.

Thanks,
Bhupesh

