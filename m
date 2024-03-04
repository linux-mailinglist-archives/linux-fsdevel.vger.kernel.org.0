Return-Path: <linux-fsdevel+bounces-13447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C7870117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 13:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8C282A33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E373F8E2;
	Mon,  4 Mar 2024 12:15:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8232D3C6BA;
	Mon,  4 Mar 2024 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554515; cv=none; b=lVCp/wyoftYpCGDIlTIB8AN1aRIvKNASZ2NabD97ceCiCQ1N30b5hDN+kS7twl/VQCITx8gIvOx3ZeNkJSewZjDeGwvZGl2pf4E3XZVwyzZannMFUef6jrDj/F7Y1FBOGkcI33D8WdVxuLPZqj8E4V4xxnIE0ecOtL2xijiy7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554515; c=relaxed/simple;
	bh=lwP4RibQzl0xJaFX0Gi7RsrGXSdIQk+HatR8ivh4sEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vb8Q9yfCVTsM36f0pNTf4Xrj5tZu161j+h8okHvVMOi3KqtOLZCo9z55EBlzEe0l5b5FNVrcwU4CQjQHW42S2VRk0x08dyii0J6HBy4TKWRDmbX0mLP7IQwXifTGbi+uiCyZe1YoxFNOLkR8wN5FESuiW+jYp7TYSe4wgYDd8z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpHdW29K8z2Bf7Q;
	Mon,  4 Mar 2024 20:12:47 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id B4F691A016E;
	Mon,  4 Mar 2024 20:15:06 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 20:15:05 +0800
Message-ID: <5c883e3c-e96c-c6ba-7797-dc48de4698ca@huawei.com>
Date: Mon, 4 Mar 2024 20:15:04 +0800
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
To: David Howells <dhowells@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Al Viro <viro@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Christian Brauner <christian@brauner.io>, David Laight
	<David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, Jeff Layton
	<jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <linux-mm@kvack.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
References: <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <20230925120309.1731676-1-dhowells@redhat.com>
 <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com>
 <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
 <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <769021.1709553367@warthog.procyon.org.uk>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <769021.1709553367@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/4 19:56, David Howells 写道:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> Actually, I think the right model is to get rid of that horrendous
>> .copy_mc field entirely.
>>
>> We only have one single place that uses it - that nasty core dumping
>> code. And that code is *not* performance critical.
>>
>> And not only isn't it performance-critical, it already does all the
>> core dumping one page at a time because it doesn't want to write pages
>> that were never mapped into user space.
>>
>> So what we can do is
>>
>>   (a) make the core dumping code *copy* the page to a good location
>> with copy_mc_to_kernel() first
>>
>>   (b) remove this horrendous .copy_mc crap entirely from iov_iter
>>
>> This is slightly complicated by the fact that copy_mc_to_kernel() may
>> not even exist, and architectures that don't have it don't want the
>> silly extra copy. So we need to abstract the "copy to temporary page"
>> code a bit. But that's probably a good thing anyway in that it forces
>> us to have nice interfaces.
>>
>> End result: something like the attached.
>>
>> AGAIN: THIS IS ENTIRELY UNTESTED.
>>
>> But hey, so was clearly all the .copy_mc code too that this removes, so...
> 
> I like it:-)
> 
> I've tested it by SIGQUIT'ing a number of processes and using gdb to examine
> the coredumps - which seems to work - at least without the production of any
> MCEs.  I'm not sure how I could test it with MCEs.

I'm going to test the coredump with the MCE.

> 
> Feel free to add:
> 
> Reviewed-by: David Howells <dhowells@redhat.com>
> Tested-by: David Howells <dhowells@redhat.com>
> 
> That said, I wonder if:
> 
> 	#ifdef copy_mc_to_kernel
> 
> should be:
> 
> 	#ifdef CONFIG_ARCH_HAS_COPY_MC
> 
> and whether it's possible to find out dynamically if MCEs can occur at all.

MCE can occur during the use of a page. So i think it occurs
dynamically.

Thanks,
Tong

> 
> David
> 
> .

