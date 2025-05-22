Return-Path: <linux-fsdevel+bounces-49692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1FAC14F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 21:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D8A25541
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946602BF3C9;
	Thu, 22 May 2025 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rPeK2Anl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067FD1519B8;
	Thu, 22 May 2025 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943112; cv=none; b=T0XWX8Rns7pcgopxj0rdkrIIwjhWZm26yoWK2MRVFZVDFbTkZcVt0KafABJgU4tJ2Ze23F7tL1Wlhg6wf2oHffX8hYSd7tBaQRT8EXgjJzmT+ub+ftyCZV8Ug56dBw64dDVQSAX2TsUWz9D5q40ueGyyniOXIHGAsFD9XCghSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943112; c=relaxed/simple;
	bh=yh0R90YapmvdDEQUM4WgEM8LTT2tIlKucgQTnOOO3dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnILHXA4e/CFQWs08uEZ16Ltv5weaSnhWVpMcQPUIwaV7vUONnXSXRzI8KPBokRybSYLALZyu+VPo05WO+SZ25eqQ8zn8qOX//dT+ke5urdu5+w3rGN4hStMGfrweOesAWKaEnHV30JX0rU2xI1V5akYfYHa6uEOiw5n9D7bXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rPeK2Anl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=b4Gq7lrRnu32phU15nLFZ+zTgkQ+RFVbw49dZ/Yes3Q=; b=rPeK2Anl5+yLqAmwH2j1YJTwdu
	nE8CLl7xTplJk3RKL83afh7JUR2UnPhCPEwBk1Zj94FguLMhsl9Y/SagBXghVU+3Tfjgi+SKbliA1
	LEA+6MiA9tJBO64lX+oBgP+c8JUwOewP6vKC2XkL075S8Eg2GTFo0+FAmH3cw5cIn6NGWeUAXOdEC
	lVB8TsvW4eYKOJ7QAp5CMzWUZSdZYawijkZM4h22RumI/l81Jm7Re+DX+9m5iuMmlk0Hr4ambP4z9
	2ObLFSaO6pdJQj7lNsFWBK20GWtcDZksYHtDExpllRuEPohRfJIa8TITV2/VPsmbeTTfFH3pMy5k6
	r4P8hH5A==;
Received: from [223.233.76.245] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uIBqe-00BrwM-2I; Thu, 22 May 2025 21:45:00 +0200
Message-ID: <1ff57d4d-6e57-20f1-c3e3-b0f7dfeccaaf@igalia.com>
Date: Fri, 23 May 2025 01:14:05 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, pmladek@suse.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
 ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-trace-kernel@vger.kernel.org
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-3-bhupesh@igalia.com>
 <CALOAHbCm_ggnxAtHMx07MUgnW01RiymD6MpR7coJOiokR4v52A@mail.gmail.com>
 <CALOAHbDNBQN6m9SzK6MegwapUQ9vm4NgcZgyp=aepG8RA8J7UA@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CALOAHbDNBQN6m9SzK6MegwapUQ9vm4NgcZgyp=aepG8RA8J7UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yafang,

Many thanks for the review.

On 5/22/25 11:57 AM, Yafang Shao wrote:
> On Thu, May 22, 2025 at 2:15 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>> On Wed, May 21, 2025 at 2:24 PM Bhupesh <bhupesh@igalia.com> wrote:
>>> As Linus mentioned in [1], currently we have several memcpy() use-cases
>>> which use 'current->comm' to copy the task name over to local copies.
>>> For an example:
>>>
>>>   ...
>>>   char comm[TASK_COMM_LEN];
>>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>>   ...
>>>
>>> These should be modified so that we can later implement approaches
>>> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
>>> is a more modular way (follow-up patches do the same):
>>>
>>>   ...
>>>   char comm[TASK_COMM_LEN];
>>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>>   comm[TASK_COMM_LEN - 1] = '\0';
>>>   ...
>>>
>>> The relevant 'memcpy()' users were identified using the following search
>>> pattern:
>>>   $ git grep 'memcpy.*->comm\>'
>> Hello Bhupesh,
>>
>> Several BPF programs currently read task->comm directly, as seen in:
>>
>> // tools/testing/selftests/bpf/progs/test_skb_helpers.c [0]
>> bpf_probe_read_kernel_str(&comm, sizeof(comm), &task->comm);
>>
>> This approach may cause issues after the follow-up patch.
>> I believe we should replace it with the safer bpf_get_current_comm()
>> or explicitly null-terminate it with "comm[sizeof(comm) - 1] = '\0'".
>> Out-of-tree BPF programs like BCC[1] or bpftrace[2] relying on direct
>> task->comm access may also break and require updates.
>>
>> [0]. https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/test_skb_helpers.c#n26
>> [1]. https://github.com/iovisor/bcc
>> [2]. https://github.com/bpftrace/bpftrace
> Hmm, upon checking, I confirmed that bpf_probe_read_kernel_str()
> already ensures the destination string is null-terminated. Therefore,
> this change is unnecessary. Please disregard my previous comment.
>

Sure. Yes, bpf_probe_read_kernel_str() handles these cases.

Thanks,
Bhupesh


