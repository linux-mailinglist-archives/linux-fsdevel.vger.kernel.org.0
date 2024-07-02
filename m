Return-Path: <linux-fsdevel+bounces-22950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5292407D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BCA282629
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 14:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA2F1BA067;
	Tue,  2 Jul 2024 14:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A71DFE3;
	Tue,  2 Jul 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930067; cv=none; b=LyFOQakvN+K8R/uuAK7Clv3LHZN6NyxFIJ9n8n91pczfVymEna3NZkqKmwTqZbR83nCh+tOCwjPkbXJASpahQzUuvzruT0Y0jgCoBxdhdBaOW0yW2HTvw5oipafUCnVUcXjSxRiWAckSZhkphY14s1HfbpKD3ZGOPY78xwXr+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930067; c=relaxed/simple;
	bh=nWKxdV5ujyrGy3s7qRfFotWRCfmuZrI9OL8cics4EZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZXuqLTUY0NkqY9yne71EGn05EcHkV9nvteFSWkdA0cSYtqdidqAa4GyOEy3Q/0BIbBhJGT4ophOSRbgdZUZHrDfUvjLRNlL6GgRHz2P7s0Aej4ZBxOX4GB8xtcyI6T05WQDgfswHvG7qkMTr4yUtQWrkjaTgnJe18yGpJMdhP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WD4hr5GkHz1T4Fw;
	Tue,  2 Jul 2024 22:16:28 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E9C0A1400CD;
	Tue,  2 Jul 2024 22:21:00 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 22:21:00 +0800
Message-ID: <5856cee4-1e13-4c67-8fea-f5f938f7452f@huawei.com>
Date: Tue, 2 Jul 2024 22:21:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hugetlbfs: use tracepoints in hugetlbfs functions.
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
	<rostedt@goodmis.org>
CC: <muchun.song@linux.dev>, <mhiramat@kernel.org>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <20240612011156.2891254-1-lihongbo22@huawei.com>
 <20240612011156.2891254-3-lihongbo22@huawei.com>
 <20240701194906.3a9b6765@gandalf.local.home>
 <1eca1fcd-5479-47b2-b7ba-eb4027135af2@huawei.com>
 <8015a0bf-39e2-406c-8f61-db87a40a71a3@efficios.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <8015a0bf-39e2-406c-8f61-db87a40a71a3@efficios.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/2 21:30, Mathieu Desnoyers wrote:
> On 2024-07-02 07:55, Hongbo Li wrote:
>>
>>
>> On 2024/7/2 7:49, Steven Rostedt wrote:
>>> On Wed, 12 Jun 2024 09:11:56 +0800
>>> Hongbo Li <lihongbo22@huawei.com> wrote:
>>>
>>>> @@ -934,6 +943,12 @@ static int hugetlbfs_setattr(struct mnt_idmap 
>>>> *idmap,
>>>>       if (error)
>>>>           return error;
>>>> +    trace_hugetlbfs_setattr(inode, dentry->d_name.len, 
>>>> dentry->d_name.name,
>>>> +            attr->ia_valid, attr->ia_mode,
>>>> +            from_kuid(&init_user_ns, attr->ia_uid),
>>>> +            from_kgid(&init_user_ns, attr->ia_gid),
>>>> +            inode->i_size, attr->ia_size);
>>>> +
>>>
>>> That's a lot of parameters to pass to a tracepoint. Why not just pass 
>>> the
>>> dentry and attr and do the above in the TP_fast_assign() logic? That 
>>> would
>>> put less pressure on the icache for the code part.
>>
>> Thanks for reviewing!
>>
>> Some logic such as kuid_t --> uid_t might be reasonable obtained in 
>> filesystem layer. Passing the dentry and attr will let trace know the 
>> meaning of structure, perhaps tracepoint should not be aware of the
>> members of these structures as much as possible.
> 
> As maintainer of the LTTng out-of-tree kernel tracer, I appreciate the
> effort to decouple instrumentation from the subsystem instrumentation,
> but as long as the structure sits in public headers and the global
> variables used within the TP_fast_assign() logic (e.g. init_user_ns)
> are export-gpl, this is enough to make it easy for tracer integration
Thank you for your friendly elaboration and suggestion!
I will update this part based on your suggestion in next version.

Thanks,
Hongbo
> and it keeps the tracepoint caller code footprint to a minimum.
> 
> The TRACE_EVENT definitions are specific to the subsystem anyway,
> so I don't think it matters that the TRACE_EVENT() need to access
> the dentry and attr structures.
> 
> So I agree with Steven's suggestion. However, just as a precision,
> I suspect it will have mainly an impact on code size, but not
> necessarily on icache footprint, because it will shrink the code
> size within the tracepoint unlikely branch (cold instructions).
> 
> Thanks,
> 
> Mathieu
> 
>>
>> Thanks,
>> Hongbo
>>
>>>
>>> -- Steve
>>>
> 

