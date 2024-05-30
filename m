Return-Path: <linux-fsdevel+bounces-20516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7E78D4B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981FF1C22506
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5BE176AAA;
	Thu, 30 May 2024 11:48:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDDD183964
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717069684; cv=none; b=GTA8yY3Y+iGM8Ip7EfxGZoBTqzs2sSNXB2IdiRRK/izzrQPL1dr/2UUgOcm0m1ls5MeGzieaG6wKXrzcLFrtw5vo0Z3kSxH+WhHFn6AgjI9Ox0vNdmi8TsJseE/WsVfKK0vswOSQkXl8I+AdZwud7fiuxAkfKGezfFL0Ucfn/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717069684; c=relaxed/simple;
	bh=C0Pgs8gmUVD60xjItK/ZZjzHKThqzM4CpQVps2B01GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FDLemGjKOjkJBxHWsT/s6kCCMvp7atyQhx6jfZfAOJH8RWP4T8XrEZYTCleWyqxSDyhiggMkJIGiQw73chmaulWJTXitwgDyJnu/P4+BAX92G7WGx3pEhsDKeLfgCT6DlqKgqxpMphvmA1Q+6BUKyxZQqaBwb81JFVt4fM4qdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VqksY3crKzmWyJ;
	Thu, 30 May 2024 19:43:29 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AAEA0140382;
	Thu, 30 May 2024 19:47:53 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 30 May 2024 19:47:53 +0800
Message-ID: <49f5cd14-987f-4d72-8606-496fca08a708@huawei.com>
Date: Thu, 30 May 2024 19:47:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostfs: convert hostfs to use the new mount api
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <oe-kbuild@lists.linux.dev>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	<linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
References: <d845ba1a-2b10-4d83-a687-56406ce657c9@suswa.mountain>
 <74576c52-5eca-4961-ada4-a9ec99fb16cf@huawei.com>
 <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <df349a89-e638-41de-858b-04341d89774e@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Thanks for replying.

I will send the new patch marked with v2 later.

regards,
Hongbo Li

On 2024/5/23 18:43, Dan Carpenter wrote:
> On Fri, May 17, 2024 at 07:21:09PM +0800, Hongbo Li wrote:
>> Thanks for your attention, I have solved the warnings in the following patch
>> (the similar title: hostfs: convert hostfs to use the new mount API):
>>
>> https://lore.kernel.org/all/20240515025536.3667017-1-lihongbo22@huawei.com/
>>
>> or
>>
>> https://patchwork.ozlabs.org/project/linux-um/patch/20240515025536.3667017-1-lihongbo22@huawei.com/
>>
>> It was strange that the kernel test robot did not send the results on the
>> new patch.
> 
> With uninitialized variable warnings, quite often Smatch is not the only
> or first checker to report the bug so I normally search lore to see if
> it has already been fixed.  In this case there were no bug reports from
> Nathan Chancelor and the second version of the patch wasn't marked as a
> v2 and there was no note explaining it like:
> 
> ---
> v2: fixed uninitialized variable warning
> 
> So it wasn't immediately clear that it had been fixed already.
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
> 
> regards,
> dan carpenter
> 

