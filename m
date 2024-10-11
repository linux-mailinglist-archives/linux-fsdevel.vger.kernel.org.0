Return-Path: <linux-fsdevel+bounces-31659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A59F999963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE22B22058
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D203EAF6;
	Fri, 11 Oct 2024 01:32:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE09C13D;
	Fri, 11 Oct 2024 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610320; cv=none; b=GLst8ScNNzPO+t5X41pTfqkH9SVUv23t/eCO1Pzy0dU432z3n4NfXu1LnX1qJX9pWg6v2G1tb+q7xb1WGraI9+a0cAcHLVTDkdkGJMeDEyM9/0zEiWi4owIssvDwuj2Aah0/Hp9Lwu7XopOOT92xUyDOY0Q//UYGVbZjON0JbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610320; c=relaxed/simple;
	bh=WLIZqd8dlb1m7im5zIyPaUymXTbEoBm4AkPS9EzR/ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uRBkimVwJhMtDP9Q2Q6Qw3B5I+4WzwEBj2w2pINIcz+EdjK1LzpeYhA7Rl8bFxYM4vEGQOug3V4h2UcSW5JHMY0xaiQO3t9KU2FbrZ68pvaq/7d6V/FBjNfjtdFJ9n7I67yI49KFCp86OEsGtxd6WZ6BlWpJIs9fVB1QYbJpwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XPpy82zS0z2VRTp;
	Fri, 11 Oct 2024 09:32:00 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C2C8140202;
	Fri, 11 Oct 2024 09:31:55 +0800 (CST)
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Oct 2024 09:31:54 +0800
Message-ID: <94004b36-01ae-4c62-ad74-0bad5992eb7c@huawei.com>
Date: Fri, 11 Oct 2024 09:31:53 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] cachefiles: Fix NULL pointer dereference in
 object->file
To: David Howells <dhowells@redhat.com>
CC: <netfs@lists.linux.dev>, <jlayton@kernel.org>,
	<hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<libaokun1@huawei.com>, <yangerkun@huawei.com>, <houtao1@huawei.com>,
	<yukuai3@huawei.com>
References: <8d05cae1-55d2-415b-810e-3fb14c8566fd@huawei.com>
 <20240821024301.1058918-8-wozizhi@huawei.com>
 <20240821024301.1058918-1-wozizhi@huawei.com>
 <303977.1728559565@warthog.procyon.org.uk>
 <443969.1728571940@warthog.procyon.org.uk>
From: Zizhi Wo <wozizhi@huawei.com>
In-Reply-To: <443969.1728571940@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100017.china.huawei.com (7.202.181.16)



在 2024/10/10 22:52, David Howells 写道:
> Zizhi Wo <wozizhi@huawei.com> wrote:
> 
>> 在 2024/10/10 19:26, David Howells 写道:
>>> Zizhi Wo <wozizhi@huawei.com> wrote:
>>>
>>>> +	spin_lock(&object->lock);
>>>>    	if (object->file) {
>>>>    		fput(object->file);
>>>>    		object->file = NULL;
>>>>    	}
>>>> +	spin_unlock(&object->lock);
>>> I would suggest stashing the file pointer in a local var and then doing the
>>> fput() outside of the locks.
>>> David
>>>
>>
>> If fput() is executed outside the lock, I am currently unsure how to
>> guarantee that file in __cachefiles_write() does not trigger null
>> pointer dereference...
> 
> I'm not sure why there's a problem here.  I was thinking along the lines of:
> 
> 	struct file *tmp;
> 	spin_lock(&object->lock);
>   	tmp = object->file)
> 	object->file = NULL;
> 	spin_unlock(&object->lock);
> 	if (tmp)
> 		fput(tmp);
> 
> Note that fput() may defer the actual work if the counter hits zero, so the
> cleanup may not happen inside the lock; further, the cleanup done by __fput()
> may sleep.
> 
> David
> 
> 
Oh, I see what you mean. I will sort it out and issue the second patch
as soon as possible.

Thanks,
Zizhi Wo

