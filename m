Return-Path: <linux-fsdevel+bounces-13432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FB686FC5F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B55891C21A58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE724215;
	Mon,  4 Mar 2024 08:45:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231B7199A1;
	Mon,  4 Mar 2024 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541944; cv=none; b=GgnErBNvJcSoMc6XysZ9/z07gAMxTiJcwP5YZy72G6rp6T4nUCSXYKXkhhiSsopUS62anULH2jaCls5O+Ol6NzKFSvT21Uls/SvBCBh+ze1U5xeuh3npNxKUWuCaupD8/AD+kfE0tYMUWFrBfG23huEmoVD8DjMFpkfWV54/xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541944; c=relaxed/simple;
	bh=3INRU0FvSF5yHYj1wch7w3hifZglrOnv+QBi8Qw0ndI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z9afsHX2yrb2dBfMHl9TF1fy2LyQr6Lm9LawJ1VZ9YTSvjs5zid7tfBJdPbRzU/nv8oMklibHsHeH2ZxCgeFQoHweJXDExq7skw2GA0QkngIyqH0A1hpEQYxIA0a0xmvASfhU/TL9qAUed0mwkmh3RE0UkzeaceLnkhbuSNFmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TpC0X6tGKzNlpP;
	Mon,  4 Mar 2024 16:43:56 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id CF891140415;
	Mon,  4 Mar 2024 16:45:32 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 16:45:31 +0800
Message-ID: <bc82e3e7-f301-3a40-cbf6-927351b6575d@huawei.com>
Date: Mon, 4 Mar 2024 16:45:30 +0800
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
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Christian Brauner
	<christian@brauner.io>, David Laight <David.Laight@aculab.com>, Matthew
 Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20230925120309.1731676-1-dhowells@redhat.com>
 <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
 <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
 <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
 <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/3 2:06, Linus Torvalds 写道:
> On Sat, 2 Mar 2024 at 01:37, Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>> I think this solution has two impacts:
>> 1. Although it is not a performance-critical path, the CPU usage may be
>> affected by one more memory copy in some large-memory applications.
> 
> Compared to the IO, the extra memory copy is a non-issue.
> 
> If anything, getting rid of the "copy_mc" flag removes extra code in a
> much more important path (ie the normal iov_iter code).

Indeed. I'll test this solution. Theoretically, it should solve the problem.

> 
>> 2. If a hardware memory error occurs in "good location" and the
>> ".copy_mc" is removed, the kernel will panic.
> 
> That's always true. We do not support non-recoverable machine checks
> on kernel memory. Never have, and realistically probably never will. >
> In fact, as far as I know, the hardware that caused all this code in
> the first place no longer exists, and never really made it to wide
> production.

Yes. There is a low probability that the newly applied memory is faulty.

Thanks,
Tong.

> 
> The machine checks in question happened on pmem, now killed by Intel.
> It's possible that somebody wants to use it for something else, but
> let's hope any future implementations are less broken than the
> unbelievable sh*tshow that caused all this code in the first place.
> 
> The whole copy_mc_to_kernel() mess exists mainly due to broken pmem
> devices along with old and broken CPU's that did not deal correctly
> with machine checks inside the regular memory copy ('rep movs') code,
> and caused hung machines.
> 
> IOW, notice how 'copy_mc_to_kernel()' just becomes a regular
> 'memcpy()' on fixed hardware, and how we have that disgusting
> copy_mc_fragile_key that gets enabled for older CPU cores.
> 
> And yes, we then have copy_mc_enhanced_fast_string() which isn't
> *that* disgusting, and that actually handles machine checks properly
> on more modern hardware, but it's still very much "the hardware is
> misdesiged, it has no testing, and nobody sane should depend on this"
> 
> In other words, it's the usual "Enterprise Hardware" situation. Looks
> fancy on paper, costs an arm and a leg, and the reality is just sad,
> sad, sad.
> 
>                 Linus
> .

