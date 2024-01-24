Return-Path: <linux-fsdevel+bounces-8682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB283A3B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 09:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76054B22A3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 08:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2417543;
	Wed, 24 Jan 2024 08:06:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE42171AB;
	Wed, 24 Jan 2024 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083580; cv=none; b=oqAasfi+H2s9wPPchkljT/d37RJIL6Qc+bCEcpCNmp9rnjfisCtUPZh9b9LbK5IQ1Hzel6PrytgK/Sr7xhNoa4MYWHxoeg2DiOEU02ibjqBhWzmacF0eaW7yqtbvmIQQdlng8Ojv8nneieKS/XhYFVIzfYRKVSugLLiPP12Krxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083580; c=relaxed/simple;
	bh=DtyfKITA4pnakpz/HIXhooug2MJu65n2wbaOdYeeJW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hiM+4ma1vxj1sC2uGFhMsFIkP59k6Ssmxv2HTSJuBdmgUKiepLFeFBiWd0GpTjyr+7MiBIP0gT8LxqFwx/0/rxJ/A+Zfj0XUT/Ame0N0r9Nh0M2OxwZ4XrRaqegm/fh3DFiK+7S5a1z/8YRENtpsoYDfBGKXwuZfohRjhR808ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TKc2H3ZFfzsWCm;
	Wed, 24 Jan 2024 16:05:11 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 37E0B140487;
	Wed, 24 Jan 2024 16:06:14 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 16:06:13 +0800
Message-ID: <222c5c22-702f-44e7-734a-872a2b25d639@huawei.com>
Date: Wed, 24 Jan 2024 16:06:13 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 0/2] fs: make the i_size_read/write helpers be
 smp_load_acquire/store_release()
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<willy@infradead.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>,
	<linux-fsdevel@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <20240122094536.198454-1-libaokun1@huawei.com>
 <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
 <20240123185622.ssscyrrw5mjqjdyh@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240123185622.ssscyrrw5mjqjdyh@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/24 2:56, Jan Kara wrote:
> On Mon 22-01-24 12:14:52, Christian Brauner wrote:
>> On Mon, 22 Jan 2024 17:45:34 +0800, Baokun Li wrote:
>>> This patchset follows the linus suggestion to make the i_size_read/write
>>> helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
>>> in filemap_read() is no longer needed, so it is removed.
>>>
>>> Functional tests were performed and no new problems were found.
>>>
>>> Here are the results of unixbench tests based on 6.7.0-next-20240118 on
>>> arm64, with some degradation in single-threading and some optimization in
>>> multi-threading, but overall the impact is not significant.
>>>
>>> [...]
>> Hm, we can certainly try but I wouldn't rule it out that someone will
>> complain aobut the "non-significant" degradation in single-threading.
>> We'll see. Let that performance bot chew on it for a bit as well.
> Yeah, over 5% regression in buffered read/write cost is a bit hard to
> swallow. I somewhat wonder why this is so much - maybe people call
> i_size_read() without thinking too much and now it becomes atomic op on
> arm? Also LKP tests only on x86 (where these changes are going to be
> for noop) and I'm not sure anybody else runs performance tests on
> linux-next, even less so on ARM... So not sure anybody will complain until
> this gets into some distro (such as Android).
>
>> But I agree that the smp_load_acquire()/smp_store_release() is clearer
>> than the open-coded smp_rmb().
> Agreed, conceptually this is nice and it will also silence some KCSAN
> warnings about i_size updates vs reads.
>
> 								Honza
Hello Honza!

Are there any other performance tests you'd like to perform?
I can test it on my machine if you have any.

Cheers!
-- 
With Best Regards,
Baokun Li
.

