Return-Path: <linux-fsdevel+bounces-8688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D97183A572
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 10:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FCF2923A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FDA18037;
	Wed, 24 Jan 2024 09:30:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6025F1802A;
	Wed, 24 Jan 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088631; cv=none; b=kQih61y2HaO9kMVxLANw+Z06BPOOeaeAhNyghYhL6qhlC23mKB9ZijRu2IrVCjFfYFQCbocn9KJlTJEKq/Pb0WI7m8mGwbSYwwbf9ODozFBvi1DJAAgWY3ar0oQL8krFa/ngYx/f4BKHlntHanGIRzHxAx/3FifpP7y+i5dEURU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088631; c=relaxed/simple;
	bh=qmC5nXw/zGxMMGst/hVylM3OFQtfUYgQ8/8cGXf1tIk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hNcYZw37lEnl0Vnw+vtOGZIqmNhGRT+DEoGzm+1PoC/05dxfS24zJORn6P1QZGbjI9u8k+IsrYBF0J1PG/Q/f/STYRvMTn2tOI4un9PUB8cjk2Po87Ja08E42ke5E/XoPyQaps/i/KF+lDozE9iv3vuagdAKwaCTGO42Tib0+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TKdvc69lnzNlS9;
	Wed, 24 Jan 2024 17:29:32 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id A500D18005E;
	Wed, 24 Jan 2024 17:30:25 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 17:30:24 +0800
Message-ID: <4f78fea2-ced6-fc5a-c7f2-b33fcd226f06@huawei.com>
Date: Wed, 24 Jan 2024 17:30:23 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From: "zhangpeng (AS)" <zhangpeng362@huawei.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <akpm@linux-foundation.org>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<arjunroy@google.com>, <wangkefeng.wang@huawei.com>
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org>
 <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org>
 <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
 <Za6h-tB7plgKje5r@casper.infradead.org>
 <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANn89iJDNdOpb6L6PkrAcbGcsx6_v4VD0v2XFY77g7tEnJEXXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)

On 2024/1/23 1:39, Eric Dumazet wrote:

> On Mon, Jan 22, 2024 at 6:12 PM Matthew Wilcox<willy@infradead.org>  wrote:
>> On Mon, Jan 22, 2024 at 05:30:18PM +0100, Eric Dumazet wrote:
>>> On Mon, Jan 22, 2024 at 5:04 PM Matthew Wilcox<willy@infradead.org>  wrote:
>>>> I'm disappointed to have no reaction from netdev so far.  Let's see if a
>>>> more exciting subject line evinces some interest.
>>> Hmm, perhaps some of us were enjoying their weekend ?
>> I am all in favour of people taking time off!  However the report came
>> in on Friday at 9am UTC so it had been more than a work day for anyone
>> anywhere in the world without response.
>>
>>> I don't really know what changed recently, all I know is that TCP zero
>>> copy is for real network traffic.
>>>
>>> Real trafic uses order-0 pages, 4K at a time.
>>>
>>> If can_map_frag() needs to add another safety check, let's add it.
>> So it's your opinion that people don't actually use sendfile() from
>> a local file, and we can make this fail to zerocopy?
> Certainly we do not do that at Google.
> I am not sure if anybody else would have used this.
>
>
>
>   That's good
>> because I had a slew of questions about what expectations we had around
>> cache coherency between pages mapped this way and write()/mmap() of
>> the original file.  If we can just disallow this, we don't need to
>> have a discussion about it.
>>
>>> syzbot is usually quite good at bisections, was a bug origin found ?
>> I have the impression that Huawei run syzkaller themselves without
>> syzbot.  I suspect this bug has been there for a good long time.
>> Wonder why nobody's found it before; it doesn't seem complicated for a
>> fuzzer to stumble into.
> I is strange syzbot (The Google fuzzer) have not found this yet, I
> suspect it might be caused
> by a recent change somewhere ?
>
> A repro would definitely help, I could start a bisection.

By using git-bisect, the patch that introduces this issue is 05255b823a617
("tcp: add TCP_ZEROCOPY_RECEIVE support for zerocopy receive."). v4.18-rc1.

Currently, there are no other repro or c reproduction programs can reproduce
the issue. The syz log used to reproduce the issue is as follows:

r3 = socket$inet_tcp(0x2, 0x1, 0x0)
mmap(&(0x7f0000ff9000/0x4000)=nil, 0x4000, 0x0, 0x12, r3, 0x0)
r4 = socket$inet_tcp(0x2, 0x1, 0x0)
bind$inet(r4, &(0x7f0000000000)={0x2, 0x4e24, @multicast1}, 0x10)
connect$inet(r4, &(0x7f00000006c0)={0x2, 0x4e24, @empty}, 0x10)
r5 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
0x181e42, 0x0)
fallocate(r5, 0x0, 0x0, 0x85b8818)
sendfile(r4, r5, 0x0, 0x3000)
getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
&(0x7f00000001c0)={&(0x7f0000ffb000/0x3000)=nil, 0x3000, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=0x10)
r6 = openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)='./file0\x00',
0x181e42, 0x0)

-- 
Best Regards,
Peng


