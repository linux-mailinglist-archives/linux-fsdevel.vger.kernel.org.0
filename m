Return-Path: <linux-fsdevel+bounces-22592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A5C919D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 04:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7581C21A10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808C8D29E;
	Thu, 27 Jun 2024 02:18:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3917F3;
	Thu, 27 Jun 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719454716; cv=none; b=Cr0l6CmBGKGynZ8DWavRGo6sjcONUZD+WBnLJ6Un8Q8QYAOt7R2xrj2TXhXlNdThjNXDOgFZBvi1rGtCJv0GVG1KZBQsucaAYYLU6kmUdtVTOJKxjh+J1DRVdv6K4OS0h//n90/MIyJmWdYN37bOO9weRfTZl/zFLlDN76eQzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719454716; c=relaxed/simple;
	bh=Rg5FD+AHiNN7C2ClglnhSg+pHeSKyBFnBijBK9oM7K8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXZzdOV/XVr4fKjXmyZQXx2ggEMT6t2DZVDnPz/uVu6OJz6r85yEXAHkdlBbxUI8MyK3bp6Pxsiz3YpwhJiIcKfucCrY0g/miERKZa+pOAnB4EhOf57RqjS7tD55SrzGS7S+7eZoLwvHB2WPhMdTfO/qv33H4FdaUHUlDA6P9oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8j0T3nZYz4f3kwB;
	Thu, 27 Jun 2024 10:18:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B21C01A016E;
	Thu, 27 Jun 2024 10:18:29 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgAXQn7xy3xmv7DBAQ--.28382S3;
	Thu, 27 Jun 2024 10:18:29 +0800 (CST)
Message-ID: <42ef73fd-bfba-4ac8-88b3-5d98e011535f@huaweicloud.com>
Date: Thu, 27 Jun 2024 10:18:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] cachefiles: some bugfixes for clean object/send
 req/poll
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: netfs@lists.linux.dev, dhowells@redhat.com, jlayton@kernel.org,
 jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com,
 yukuai3@huawei.com, wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>,
 Baokun Li <libaokun@huaweicloud.com>
References: <20240515125136.3714580-1-libaokun@huaweicloud.com>
 <13b4dd18-8105-44e0-b383-8835fd34ac9e@huaweicloud.com>
 <c809cda4-57be-41b5-af2f-5ebac23e95e0@linux.alibaba.com>
 <6b844047-f1f5-413d-830b-2e9bc689c2bf@huaweicloud.com>
 <d97a1e87-9571-453e-909c-4de17d1d67db@linux.alibaba.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <d97a1e87-9571-453e-909c-4de17d1d67db@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXQn7xy3xmv7DBAQ--.28382S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4rGFWDurW7uw47Ww1Utrb_yoWkCFg_uF
	ZavFZrCw4UXrsFyanayrW5Zrs2grWrZr1rA34rJr1Uu3s5XFyrWF4kWryxZrs3Aa18JF4I
	kr9I9ayav343WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAHBV1jkH+ALAAAs+

On 2024/6/27 10:08, Gao Xiang wrote:
>
>
> On 2024/6/27 09:49, Baokun Li wrote:
>> On 2024/6/26 11:28, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/26 11:04, Baokun Li wrote:
>>>> A gentle ping.
>>>
>>> Since it's been long time, I guess you could just resend
>>> a new patchset with collected new tags instead of just
>>> ping for the next round review?
>>>
>>> Thanks,
>>> Gao Xiang
>>
>> Okay, if there's still no feedback this week, I'll resend this patch 
>> series.
>>
>> Since both patch sets under review are now 5 patches and have similar
>> titles, it would be more confusing if they both had RESEND. So when I
>> resend it I will merge the two patch sets into one patch series.
>
> Sounds fine, I think you could rearrange the RESEND patchset with
> the following order
> cachefiles: some bugfixes for withdraw and xattr
> cachefiles: some bugfixes for clean object/send req/poll

Okay, I'll arrange the patches in that order.

Thank you for your suggestion!

>
> Jingbo currently is working on the internal stuff, I will try to
> review myself for this work too.
>
> Thanks,
> Gao Xiaang

Thank you so much for helping to review these patches.

-- 
With Best Regards,
Baokun Li


