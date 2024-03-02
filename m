Return-Path: <linux-fsdevel+bounces-13360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C586EFDD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 10:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C351F21DF7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D714F75;
	Sat,  2 Mar 2024 09:37:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E25168BD;
	Sat,  2 Mar 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709372243; cv=none; b=ay+sf4gXQzDgzoAChcsjEdyG4G+9vrsXGdzkKdNNQgPvu/NC1PT+Y43cgcimCn3pgl8tQ6p5u4LIYWVZlctomoIE7fOgtdhc0A/Twf2HYW4PZzpetc2kD2HNdFw8YULo9v/UB3Kw7/sd9SXWP+nWq5bh75VPXFJpleylbuFk358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709372243; c=relaxed/simple;
	bh=8kiw5+UWs4a9+DdGKdL4oMotwww+LKy0HwEZtFqYFjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fgcLco1fYD7WvY4YxgQUNFK0LR6MO5nnBzvcO1hfqB5bo8n0ontevk+iih/HjAFm2FZFNU64fbVCejfnzag9zaavgoKks8gMH1oZXENW4QQ9L5rRx4lFOy9h1t4+dBhhOppiPy4NtDOl0wOJHI1BxdIY9CdCTiveTVmdr03tqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tn0Gx2Hwtz1FLPY;
	Sat,  2 Mar 2024 17:37:13 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DE711A016B;
	Sat,  2 Mar 2024 17:37:17 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 2 Mar 2024 17:37:15 +0800
Message-ID: <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
Date: Sat, 2 Mar 2024 17:37:15 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>
CC: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>,
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
 <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
 <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
 <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/2 10:59, Linus Torvalds 写道:
> On Thu, 29 Feb 2024 at 09:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> One option might be to make a failed memcpy_from_iter_mc() set another
>> flag in the iter, and then make fault_in_iov_iter_readable() test that
>> flag and return 'len' if that flag is set.
>>
>> Something like that (wild handwaving) should get the right error handling.
>>
>> The simpler alternative is maybe something like the attached.
>> COMPLETELY UNTESTED. Maybe I've confused myself with all the different
>> indiraction mazes in the iov_iter code.
> 
> Actually, I think the right model is to get rid of that horrendous
> .copy_mc field entirely.
> 
> We only have one single place that uses it - that nasty core dumping
> code. And that code is *not* performance critical.
> 
> And not only isn't it performance-critical, it already does all the
> core dumping one page at a time because it doesn't want to write pages
> that were never mapped into user space.
> 
> So what we can do is
> 
>   (a) make the core dumping code *copy* the page to a good location
> with copy_mc_to_kernel() first
> 
>   (b) remove this horrendous .copy_mc crap entirely from iov_iter

I think this solution has two impacts:
1. Although it is not a performance-critical path, the CPU usage may be
affected by one more memory copy in some large-memory applications.
2. If a hardware memory error occurs in "good location" and the
".copy_mc" is removed, the kernel will panic.

I would prefer to use the previous solution(modify the implementation of
memcpy_from_iter_mc()).

Thanks,
Tong.

> 
> This is slightly complicated by the fact that copy_mc_to_kernel() may
> not even exist, and architectures that don't have it don't want the
> silly extra copy. So we need to abstract the "copy to temporary page"
> code a bit. But that's probably a good thing anyway in that it forces
> us to have nice interfaces.
> 
> End result: something like the attached.
> 
> AGAIN: THIS IS ENTIRELY UNTESTED.
> 
> But hey, so was clearly all the .copy_mc code too that this removes, so...
> 
>                 Linus

