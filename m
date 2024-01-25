Return-Path: <linux-fsdevel+bounces-8833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EE83B711
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746BD1F23CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 02:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A415C9A;
	Thu, 25 Jan 2024 02:18:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0E17C2;
	Thu, 25 Jan 2024 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149136; cv=none; b=sdU34sb6yA5W26BQlxnH6LYk3KS9MKSIMmChRYldACQl2nHJpiz2ozrEKUab0emJP9dbigwVMHEhTuX37jriuzOOlG5orbXvc77e+FHZYK0bdj5gBvb94o24E9iqhNhJA9Pg1WKDIOF4v4Z7kpJrHtjqudvm8TSBzxy24rwPjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149136; c=relaxed/simple;
	bh=LKX/bcYsAYtUJv9o/sFrZ6ft2RE6lD34Ru8BlkGwnKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MppTwaKgM1dYJb5QYDOjfYpgOrHIlqq4RmeI7sOCX87Id9VS2XSDO2O9248EIytp25Po5LDpehf3MV9ohLN3c0bkYbpyZ9M5+l+kpu3iIOG2rm5UW/riFZ0W5J23Fwellk2l7JDaq3/nNyEYggjyqjQbQuW5CwLo4rs48sL5vwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TL4Gm5RbKzXgdZ;
	Thu, 25 Jan 2024 10:17:36 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 08343140444;
	Thu, 25 Jan 2024 10:18:50 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 10:18:48 +0800
Message-ID: <d68f50a5-8d83-99ba-1a5a-7f119cd52029@huawei.com>
Date: Thu, 25 Jan 2024 10:18:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
CC: Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<akpm@linux-foundation.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <arjunroy@google.com>,
	<wangkefeng.wang@huawei.com>
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org>
 <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org>
 <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org>
 <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
 <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com>
 <CANn89iKbyTRvWEE-3TyVVwTa=N2KsiV73-__2ASktt2hrauQ0g@mail.gmail.com>
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <CANn89iKbyTRvWEE-3TyVVwTa=N2KsiV73-__2ASktt2hrauQ0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/1/24 18:11, Eric Dumazet wrote:

> On Wed, Jan 24, 2024 at 10:30 AM zhangpeng (AS) <zhangpeng362@huawei.com> wrote:
>>
>> By using git-bisect, the patch that introduces this issue is 05255b823a617
>> ("tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive."). v4.18-rc1.
>>
>> Currently, there are no other repro or c reproduction programs can reproduce
>> the issue. The syz log used to reproduce the issue is as follows:
>>
>> r3 = socket$inet_tcp(0x2, 0x1, 0x0)
>> mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
>> r4 = socket$inet_tcp(0x2, 0x1, 0x0)
>> bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
>> connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
>> r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
>> 0x181e42, 0x0)
>> fallocate(r5, 0x0, 0x0, 0x85b8818)
>> sendfile(r4, r5, 0x0, 0x3000)
>> getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
>> &(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0,
>> 0x0, 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x10)
>> r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
>> 0x181e42, 0x0)
>>
> Could you try the following fix then ?
>
> (We also could remove the !skb_frag_off(frag) condition, as the
> !PageCompound() is necessary it seems :/)
>
> Thanks a lot !
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 1baa484d21902d2492fc2830d960100dc09683bf..ee954ae7778a651a9da4de057e3bafe35a6e10d6
> 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1785,7 +1785,9 @@ static skb_frag_t *skb_advance_to_frag(struct
> sk_buff *skb, u32 offset_skb,
>
>   static bool can_map_frag(const skb_frag_t *frag)
>   {
> -       return skb_frag_size(frag) == PAGE_SIZE && !skb_frag_off(frag);
> +       return skb_frag_size(frag) == PAGE_SIZE &&
> +              !skb_frag_off(frag) &&
> +              !PageCompound(skb_frag_page(frag));
>   }
>
>   static int find_next_mappable_frag(const skb_frag_t *frag,

This patch doesn't fix this issue. The page cache that can trigger this issue
doesn't necessarily need to be compound. 🙁

-- 
Best Regards,
Peng


