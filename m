Return-Path: <linux-fsdevel+bounces-19780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17A8C9C12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FFD61F220E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23C535B8;
	Mon, 20 May 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZRWlrIKp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C871B42044;
	Mon, 20 May 2024 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204255; cv=none; b=greCa1sb+xv72iCpJ/akfoPgLzaDg9c7HIUimHzBbUIv2Lzluvpy20ejUz5iACi0axYAPHyAlSTIBg/5FDhQeHg0DVDT5HLns46odRRFkBST4Q+zQX8OYP3XvPIh2T62mlZVcIMvcycil1yhyc4yO49mOlIxndyCPX9j/UF0IJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204255; c=relaxed/simple;
	bh=e5msGpPJDfpNozD6dX0TXGDkIn5t6CljDiGOFY3+f8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7tEErEllBZlwaOHiDrH8ALqwn8RUQMuhdYygIRDzo+QeSMlHmC/MgCRAxcO3vlftc4EW/R3q4zEl2xD3dvU9LTJvaykmYE4gihTij+EdeVlcCc5NfF1LQWqyG+DK1K4iNYXScsfKNxsHNWKyI0dtE1yDpwPeyZoGBJwAT25a2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZRWlrIKp; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716204249; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e5msGpPJDfpNozD6dX0TXGDkIn5t6CljDiGOFY3+f8E=;
	b=ZRWlrIKplW1YPjLd05G9+f+tm8g6XYzuhfjvg3YpjE61faO8TNVdmVePsn751grmQA222UszBEuvIMM9CiMIBjplNb8Zbp8YOOeHs+ujwbX0F704RA4gJjnuPqUGTLGoqCnOUlkmp3oGg/X98WSQoQMIhvRaAODS67uSQDnnLPY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W6s..ub_1716204246;
Received: from 30.97.48.204(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6s..ub_1716204246)
          by smtp.aliyun-inc.com;
          Mon, 20 May 2024 19:24:08 +0800
Message-ID: <e57ae68f-29c3-41ac-bf16-f11d546dd958@linux.alibaba.com>
Date: Mon, 20 May 2024 19:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] cachefiles: never get a new anonymous fd if
 ondemand_id is valid
To: Baokun Li <libaokun@huaweicloud.com>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 dhowells@redhat.com, jlayton@kernel.org
Cc: zhujia.zj@bytedance.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
 <20240515084601.3240503-9-libaokun@huaweicloud.com>
 <f4d24738-76a2-4998-9a28-493599cd7eae@linux.alibaba.com>
 <d62b162d-acb3-2fa7-085e-79da3278091a@huaweicloud.com>
 <a3ca2292-0218-45f6-8afe-4319a10b69e2@linux.alibaba.com>
 <5b1b2719-2123-9218-97b4-ccda8b5cb3b4@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5b1b2719-2123-9218-97b4-ccda8b5cb3b4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/5/20 19:14, Baokun Li wrote:
> On 2024/5/20 17:24, Jingbo Xu wrote:
>>
>> On 5/20/24 5:07 PM, Baokun Li wrote:
>>> On 2024/5/20 16:43, Jingbo Xu wrote:
>>>> On 5/15/24 4:45 PM, libaokun@huaweicloud.com wrote:
>>>>> From: Baokun Li <libaokun1@huawei.com>
>>>>>
> SNIP
>>>>>
>>>>> To avoid this, allocate a new anonymous fd only if no anonymous fd has
>>>>> been allocated (ondemand_id == 0) or if the previously allocated
>>>>> anonymous
>>>>> fd has been closed (ondemand_id == -1). Moreover, returns an error if
>>>>> ondemand_id is valid, letting the daemon know that the current userland
>>>>> restore logic is abnormal and needs to be checked.
>>>>>
>>>>> Fixes: c8383054506c ("cachefiles: notify the user daemon when looking
>>>>> up cookie")
>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>> The LOCs of this fix is quite under control.  But still it seems that
>>>> the worst consequence is that the (potential) malicious daemon gets
>>>> hung.  No more effect to the system or other processes.  Or does a
>>>> non-malicious daemon have any chance having the same issue?
>>> If we enable hung_task_panic, it may cause panic to crash the server.
>> Then this issue has nothing to do with this patch?  As long as a
>> malicious daemon doesn't close the anonymous fd after umounting, then I
>> guess a following attempt of mounting cookie with the same name will
>> also wait and hung there?
>>
> Yes, a daemon that only reads requests but doesn't process them will
> cause hung，but the daemon will obey the basic constraints when we
> test it.

If we'd really like to enhanace this ("hung_task_panic"), I think
you'd better to switch wait_for_completion() to
wait_for_completion_killable() at least IMHO anyway.

Thanks,
Gao Xiang


