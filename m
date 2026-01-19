Return-Path: <linux-fsdevel+bounces-74358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A9D39C59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 03:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FAAB3002941
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 02:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5395F23EA84;
	Mon, 19 Jan 2026 02:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A79Eh4Gu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA448632B;
	Mon, 19 Jan 2026 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768789412; cv=none; b=r3SAm+gKiFBjU3Q1atTaaOdxVrSQRKNqeUYmQa/GOOa0ry03Bke2MIs/DwGazPVFpkbKEBzcEHxU2GWNF+p8g6SznEl93tiEWJY47Yp7a8nNqxza5tnq6wrcb1Yz552trP1xx9h89Lm0wPay9Z+Mc9wyoaNEo2eg3EfMWhJkt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768789412; c=relaxed/simple;
	bh=Q2gYrsAH/a8GRTvPpKVGjA3z7A4SS5Mm3nMax7QpXs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rNQc9He3+4Frp+ycBmbQMXD3N4Jdqx/CRD0v0jp5J/cp5aKfwfrcxUA6ho7whAs8u1/2wXKz+nZOQUtdt7Zf+w00X59syUHSF3col8VxIIu4hkA83st+UCuoqCt7GtwYyFEuBrsWH6H6U4xkJ8EYxPUiwmR7aYvhSm4QqrvNx3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A79Eh4Gu; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6ifYJHiENUMbwaVUwhFUHHUpgltd0Ktz7kDQsPQYVmQ=;
	b=A79Eh4GuRKx7lbMetgn5ruW2GmibzzFqJDri6hkwXHJiC7jgBgxrZ8Q+JahGrgngSEC7OT6Z0
	mQ0Yamw0aIA4yjPqGgJFzz+28/XXc2fedN0NNn1CnLfr6JToWFcjwzpZQj+eP1J8TvVHg9azzmh
	1L951Nu3Qv2twfGY4AJM/zA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dvZ096DKhznTZ3;
	Mon, 19 Jan 2026 10:19:21 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 323F440536;
	Mon, 19 Jan 2026 10:23:21 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Jan 2026 10:23:20 +0800
Message-ID: <8ad34c0b-c880-48d5-a24e-8f2626e5f21d@huawei.com>
Date: Mon, 19 Jan 2026 10:23:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 2/9] erofs: decouple `struct erofs_anon_fs_type`
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
CC: <chao@kernel.org>, <brauner@kernel.org>, <djwong@kernel.org>,
	<amir73il@gmail.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116095550.627082-3-lihongbo22@huawei.com>
 <20260116153829.GB21174@lst.de>
 <c2f3f8bd-6319-4f5a-92cf-7717fa0c0972@huawei.com>
 <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <e4a45ea4-a0e9-4b8e-ab8b-b4dbb6a2ba21@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)

Hi,

On 2026/1/19 9:44, Gao Xiang wrote:
> 
> 
> On 2026/1/19 09:34, Hongbo Li wrote:
>> Hi, Xiang
>>
>> On 2026/1/16 23:38, Christoph Hellwig wrote:
>>>> +#if defined(CONFIG_EROFS_FS_ONDEMAND)
>>>
>>> Normally this would just use #ifdef.
>>>
>> How about using #ifdef for all of them? I checked and there are only 
>> three places in total, and all of them are related to 
>> FS_PAGE_CACHE_SHARE or FS_ONDEMAND config macro.
> 
> I'm fine with most cases (including here).
> 
> But I'm not sure if there is a case as `#if defined() || defined()`,
> it seems it cannot be simply replaced with `#ifdef`.
> 
Yeah, we cannot replace it in this case. So I will keep it here because 
it will be changed into `#if defined() || defined()` in following steps. 
Instead, I will use this way in other place, such as:

```
#if defined(CONFIG_EROFS_FS_PAGE_CACHE_SHARE)
                 set_opt(&sbi->opt, INODE_SHARE);
#else
...
```

Thanks,
Hongbo


> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
> 

