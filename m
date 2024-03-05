Return-Path: <linux-fsdevel+bounces-13579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9987161D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D006E1C21F2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 06:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E1D7D3FE;
	Tue,  5 Mar 2024 06:57:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B461E520;
	Tue,  5 Mar 2024 06:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621835; cv=none; b=sUmpwDt4RQggwBcg3y1bo/ZctD3WTPhbOGejgVqEwzFF/5Bk3SAxta0J62admC2JiLk7Y0A3eBrsFOtFVt+0YTw4WDCBYcOuG5Dlrn3w2ReUwbpUBxZqYqFmYFNqWmY4wtHN5qIvgBpaYHOZrqUpLT3DUzu8E++dImiBIryP3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621835; c=relaxed/simple;
	bh=j5xdkyAxdoy8QAlxjMj5w7uWMdaAuQTOn/PLDJgCo3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gcg0z3nZaQ1bKF4qAxuvOQ6R5ROY2S90nZd5gSj45PMC0ttwRwJdC90GWbSWest5dHFlU9xFY8V/cKNaWS70g6GxI71GJmveuGMnPiiHv2GlDNdqdG7mDkpyp8fE7Snf3yEgX4lA9tNHWhwMWBzykZI6fBAIfrpN94fxSFz9EoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpmY138dPz1xqCv;
	Tue,  5 Mar 2024 14:55:33 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id D954718002D;
	Tue,  5 Mar 2024 14:57:09 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 14:57:08 +0800
Message-ID: <7e6f9061-1bb9-4d7d-b679-c0183037cbf2@huawei.com>
Date: Tue, 5 Mar 2024 14:57:08 +0800
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
To: Linus Torvalds <torvalds@linux-foundation.org>, David Howells
	<dhowells@redhat.com>
CC: Al Viro <viro@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Christian Brauner <christian@brauner.io>, David Laight
	<David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, Jeff Layton
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
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
 <769021.1709553367@warthog.procyon.org.uk>
 <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAHk-=wgrmt875HJNUY9a-ti0M6M1m6jHEGvCSjcOfXy_E7_X_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/5 2:32, Linus Torvalds 写道:
> On Mon, 4 Mar 2024 at 03:56, David Howells <dhowells@redhat.com> wrote:
>>
>> That said, I wonder if:
>>
>>          #ifdef copy_mc_to_kernel
>>
>> should be:
>>
>>          #ifdef CONFIG_ARCH_HAS_COPY_MC
> 
> Hmm. Maybe. We do have that
> 
>    #ifdef copy_mc_to_kernel
> 
> pattern already in <linux/uaccess.h>, so clearly we've done it both ways.
> 
> I personally like the "just test for the thing you are using" model,
> which is then why I did it that way, but I don't have hugely strong
> opinions on it.
> 
>> and whether it's possible to find out dynamically if MCEs can occur at all.
> 
> I really wanted to do something like that, and look at the source page
> to decide "is this a pmem page that can cause machine checks", but I
> didn't find any obvious way to do that.
> 
> Improvement suggestions more than welcome.

I used EINJ to simulate hardware memory error and tested it on an ARM64
  server. This solution can solve the coredump deadloop problem.

I'll sort it out and send the patch.

Thanks,
Tong.

> 
>                 Linus
> .

