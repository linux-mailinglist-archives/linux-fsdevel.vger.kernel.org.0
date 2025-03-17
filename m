Return-Path: <linux-fsdevel+bounces-44187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B534A6477C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41B51887326
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A896221F04;
	Mon, 17 Mar 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DCdrh+Hw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA24B199252;
	Mon, 17 Mar 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203947; cv=none; b=hb6XCwQ+eKsX6SO0Y17eu0Ncy2ZAOUZS169mGmHgsTQmK0YU8YMN0zH84wwmRmppEYD3DZz9G239+BphEbrJO6un8gSnlc/BA4RhEVl5LYzPVHb+sbtbp3+f8rs78zsfsO5sC/wYdQuLSFXeSBGt3Dg3PIjb6YA9a4ZjXyaaLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203947; c=relaxed/simple;
	bh=2OBI8WT+HrVc6aiOA/QiP6ctl2nuMkPjt2+k3QVyBHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEbmJlmZCprJJRmgidQMmVQc1sZBn3QIqMYxVHJG9H+NvO9/b9J9yq+E3rI5FU+ktUACrNSR0otF5/h36OnT410OhT0Uh8acx1gEcOSBEakJuefDS+W2BWyq5Mslf63pyhLfwG3U44zamymhjvAuBVbu+tDv54cWd06xBn3xnPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DCdrh+Hw; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=2OBI8WT+HrVc6aiOA/QiP6ctl2nuMkPjt2+k3QVyBHs=;
	b=DCdrh+Hw9F9cPsK+5KvPxLv49ZrwwoXqkU+WKe33KHAx4vxX020ZKYCqLMwblQ
	COiB/IxvYw27jHuJmN45BFgSi8+8rXgu6j79mYQC9hqe8osuhSo9W72JqlrqCmut
	DttHDy5FuALx8+JwomHxcKU5TrxE+cmgz0kjahLFveeMk=
Received: from [192.168.22.248] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnQvXm69dnxrNHTQ--.29714S2;
	Mon, 17 Mar 2025 17:31:20 +0800 (CST)
Message-ID: <38cd7b81-4ca7-409c-bb1f-3c1cddfef0d8@163.com>
Date: Mon, 17 Mar 2025 17:31:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/page: Refactoring to reduce code duplication.
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, ran.xiaokai@zte.com.cn, dan.carpenter@linaro.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Liu Ye <liuye@kylinos.cn>
References: <20250317080118.95696-1-liuyerd@163.com>
 <1c7018f1-fdc5-4fc6-adc7-fae592851710@redhat.com>
 <2ecdf349-779f-43d5-ae3d-55d973ea50e9@163.com>
 <4a336393-6cf3-4053-8137-c6d724c3cb5f@redhat.com>
Content-Language: en-US
From: Liu Ye <liuyerd@163.com>
In-Reply-To: <4a336393-6cf3-4053-8137-c6d724c3cb5f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnQvXm69dnxrNHTQ--.29714S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4UZr4DCFWftry8tw1xAFb_yoW8ur15pF
	43ta17Aw48X3sxCr1xtws5Z3s0y395KF48Xr47Jw1Iqa4qyrn3CFy2yF1F9ry8tryUAr1x
	Xa1jyF9IkF1YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jBa0PUUUUU=
X-CM-SenderInfo: 5olx5vlug6il2tof0z/1tbiEAkTTGfX6m0iOAAAsr


在 2025/3/17 17:18, David Hildenbrand 写道:
> On 17.03.25 10:13, Liu Ye wrote:
>>
>> 在 2025/3/17 16:56, David Hildenbrand 写道:
>>> On 17.03.25 09:01, Liu Ye wrote:
>>>> From: Liu Ye <liuye@kylinos.cn>
>>>>
>>>> The function kpageflags_read and kpagecgroup_read is quite similar
>>>> to kpagecount_read. Consider refactoring common code into a helper
>>>> function to reduce code duplication.
>>>>
>>>> Signed-off-by: Liu Ye <liuye@kylinos.cn>
>>>> ---
>>>>    fs/proc/page.c | 158 ++++++++++++++++---------------------------------
>>>>    1 file changed, 50 insertions(+), 108 deletions(-)
>>>>
>>>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>>>> index a55f5acefa97..f413016ebe67 100644
>>>> --- a/fs/proc/page.c
>>>> +++ b/fs/proc/page.c
>>>> @@ -37,19 +37,17 @@ static inline unsigned long get_max_dump_pfn(void)
>>>>    #endif
>>>>    }
>>>>    -/* /proc/kpagecount - an array exposing page mapcounts
>>>> - *
>>>> - * Each entry is a u64 representing the corresponding
>>>> - * physical page mapcount.
>>>> - */
>>>> -static ssize_t kpagecount_read(struct file *file, char __user *buf,
>>>> -                 size_t count, loff_t *ppos)
>>>> +static ssize_t kpage_read(struct file *file, char __user *buf,
>>>> +        size_t count, loff_t *ppos,
>>>> +        u64 (*get_page_info)(struct page *))
>>>
>>> Can we just indicate using an enum which operation to perform, so we can avoid having+passing these functions?
>>>
>> Like this? Good idea, I'll send a new patch later.
>>
>> enum kpage_operation {
>>      KPAGE_FLAGS,
>>      KPAGE_COUNT,
>>      KPAGE_CGROUP,
>> };
>>
>> static u64 get_page_info(struct page *page, enum kpage_operation op)
>> {
>>      switch (op) {
>>      case KPAGE_FLAGS:
>>          return stable_page_flags(page);
>>      case KPAGE_COUNT:
>>          return page_count(page);
>>      case KPAGE_CGROUP:
>>          return page_cgroup_ino(page);
>>      default:
>>          return 0;
>>      }
>> }
>
>
> Likely it's best to inline get_page_info() into kpage_read() to just get rid of it.
>
>
Thank you for your suggestion. I agree and will make the changes accordingly.

Thanks,
Liu Ye




