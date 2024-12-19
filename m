Return-Path: <linux-fsdevel+bounces-37783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EE9F795A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 11:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0007A2DFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A978222591;
	Thu, 19 Dec 2024 10:17:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DA54727;
	Thu, 19 Dec 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603473; cv=none; b=a+/snOmusPFkXvl0ozRggJIVwYanwd1ghRxxR6XCfgU0mfBqLurJ7EOr18y3cRwFVTq10b1QQpGSKBsTaZLYM+sSY5tKtEY0z1g0sPvgdVM3sVGfwFsgxcj6Nxm80eAUGZQMg3SR4+xOGsaZ2GJn5Ot9OSb74Pq0wNA4Xlmwp5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603473; c=relaxed/simple;
	bh=POM19mxQyNkT7azwAD87n4rCYlEgQ+MaobYtueEKyS4=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gy/iGNk0KOnqp7vlsVDDYYBMiR4Fu+u10G1S/axgftuT0Pi/NddSSqWCA7P72Dd4YpI1TKC0FM8PY3TC9/bzZLcnPLrk/v83oDM77Sbr0/HwvwhBxzCR2/taEHV3qxSwsmEH9nuBiWADwjP3MFMixK89hatjjgwR9DMAb9Sd26c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YDRJn5k4mz21nYj;
	Thu, 19 Dec 2024 18:15:53 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FA571A016C;
	Thu, 19 Dec 2024 18:17:47 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Dec 2024 18:17:43 +0800
Subject: Re: [PATCH v3 -next 11/15] sunrpc: use vfs_pressure_ratio() helper
To: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
References: <> <12ec5b63b17b360f2e249a4de0ac7b86e09851a3.camel@kernel.org>
 <172859659591.444407.1507982523726708908@noble.neil.brown.name>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <okorniev@redhat.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <paul@paul-moore.com>,
	<jmorris@namei.org>, <linux-sh@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <5bcb9ace-de01-e597-92a2-22013aa695ba@huawei.com>
Date: Thu, 19 Dec 2024 18:17:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <172859659591.444407.1507982523726708908@noble.neil.brown.name>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2024/10/11 5:43, NeilBrown wrote:
> On Fri, 11 Oct 2024, Jeff Layton wrote:
>> On Thu, 2024-10-10 at 23:22 +0800, Kaixiong Yu wrote:
>>> Use vfs_pressure_ratio() to simplify code.
>>>
>>> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
>>> Reviewed-by: Kees Cook <kees@kernel.org>
>>> Acked-by: Anna Schumaker <anna.schumaker@oracle.com>
>>> ---
>>>   net/sunrpc/auth.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
>>> index 04534ea537c8..3d2b51d7e934 100644
>>> --- a/net/sunrpc/auth.c
>>> +++ b/net/sunrpc/auth.c
>>> @@ -489,7 +489,7 @@ static unsigned long
>>>   rpcauth_cache_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>>>   
>>>   {
>>> -	return number_cred_unused * sysctl_vfs_cache_pressure / 100;
>>> +	return vfs_pressure_ratio(number_cred_unused);
>>>   }
>>>   
>>>   static void
>> Acked-by: Jeff Layton <jlayton@kernel.org>
>>
> I realise this is a bit of a tangent, and I'm not objecting to this
> patch, but I wonder what the justification is for using
> vfs_cache_pressure here.  The sysctl is documented as
>
>     This percentage value controls the tendency of the kernel to reclaim
>     the memory which is used for caching of directory and inode objects.
>
> So it can sensibly be used for dentries and inode, and for anything
> directly related like the nfs access cache (which is attached to inodes)
> and the nfs xattr cache.
>
> But the sunrpc cred cache scales with the number of active users, not
> the number of inodes/dentries.
>
> So I think this should simply "return number_cred_unused;".
>
> What do others think?
>
> NeilBrown
>
> .

Thank you, I will receive your advice.


