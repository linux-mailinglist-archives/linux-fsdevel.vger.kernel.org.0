Return-Path: <linux-fsdevel+bounces-38693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B6CA06B33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 03:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F51648BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 02:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525D13C3CD;
	Thu,  9 Jan 2025 02:35:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD4B677;
	Thu,  9 Jan 2025 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390154; cv=none; b=KY01ORcgNJltPyzw9rdxX6/Dv/u2Xv01X9gtwZl4oocOiDPnjbVOB0P9rNGu7M7kNMNTfvytNugmc/DfDfQFDZxxViQCk6WgdCX19h8iK6L6t4aPKxgr9miIwhnMtAidKUYFruVutVAxA8MXxk3z6rJV1BAvU4iSBEkFk8KM1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390154; c=relaxed/simple;
	bh=v6RHc7zhOibwm5D3u9BmgZgHgfNmeEq0kdACY3wQAYI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZFl2drhOhf949lyXF96iC7A+B0bNDVBezV9F89oG9xMf3HbDlSAemHSFwSO32ZzPEz/gahFkNwzZg6SffaqrkS4ahHlTvijDT2eGuLFVaSLAOdhh01H0Ml4al0+lDsA6KXJsaho8SZHN/G6TR9po2AsRPJhnjtiDBZxFUQqbcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YT83L0ffBzRl2B;
	Thu,  9 Jan 2025 10:33:18 +0800 (CST)
Received: from kwepemh100016.china.huawei.com (unknown [7.202.181.102])
	by mail.maildlp.com (Postfix) with ESMTPS id 11B9D180216;
	Thu,  9 Jan 2025 10:35:34 +0800 (CST)
Received: from [10.174.179.93] (10.174.179.93) by
 kwepemh100016.china.huawei.com (7.202.181.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 10:35:30 +0800
Subject: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
To: Joel Granados <joel.granados@kernel.org>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <42tsyuvdvym6i3j4ppsluvx7kejxjzbma5z4jjgccni6kuwtj7@rhuklbyko7yf>
 <ceb3be0a-f035-aaec-286f-8ba95e62deba@huawei.com>
 <3elcftj5bn5iqfdly4cgmzpz4kodqrdl6dnqyqvn5fxjgmoxw4@yactmy2fbdkm>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <luto@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
	<jack@suse.cz>, <kees@kernel.org>, <j.granados@samsung.com>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>
From: yukaixiong <yukaixiong@huawei.com>
Message-ID: <0b086d15-0341-a2ac-f691-752faf3b0c88@huawei.com>
Date: Thu, 9 Jan 2025 10:35:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3elcftj5bn5iqfdly4cgmzpz4kodqrdl6dnqyqvn5fxjgmoxw4@yactmy2fbdkm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml500006.china.huawei.com (7.185.36.76) To
 kwepemh100016.china.huawei.com (7.202.181.102)



On 2025/1/6 19:22, Joel Granados wrote:
> On Sat, Dec 28, 2024 at 09:40:50PM +0800, yukaixiong wrote:
>>
>> On 2024/12/28 20:15, Joel Granados wrote:
>>> On Mon, Dec 23, 2024 at 10:15:19PM +0800, Kaixiong Yu wrote:
>>>> This patch series moves sysctls of vm_table in kernel/sysctl.c to
>>>> places where they actually belong, and do some related code clean-ups.
>>>> After this patch series, all sysctls in vm_table have been moved into its
>>>> own files, meanwhile, delete vm_table.
> ...
>>>>     sysctl: remove unneeded include
>>> This patchset looks strange. There seems to be 15 patches, but there are
>>> 30 e-mails in the thread? You can also see this when you look at it in
>>> lore [1]. And they are different repeated e-mails (mutt does not
>>> de-duplicate them). Also `b4 shazam ...` does not work. What happened?
>>> Did you send it twice with the same mail ID? Am I the only one seeing
>>> this?
>>>
>>> I would suggest the following (hopefully you are using b4):
>>> 1. Check to see how things will be sent with b4. `b4 send --resend -o OUTPUT_DIR`
>>>      If you see 30 emails in that dir from your patchset then something is
>>>      still wrong.
>>> 2. After you make sure that everything is in order. Do the resend
>>>      without bumping the version up (leave it at version 4)
>>>
>>> Best
>>>
>>> [1] : https://lore.kernel.org/all/20241223141550.638616-1-yukaixiong@huawei.com/
>> I'm very sorry, due to my mistake, 15 patches were sent twice.
> No worries. I saw that you have re-sent the patchset and it seems that
> this time there is only 15 mails. I see that you are only using my
> j.granados@samsung.com ID; can you please add my kernel.org
> (joel.granados@kernel.org) mail to the future mails that you send (no
> need to re-send v4).
>
> Thx
>
> ...

OK, I will add joel.granados@kernel.org to the future mails.


