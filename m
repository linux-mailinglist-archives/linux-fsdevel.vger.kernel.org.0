Return-Path: <linux-fsdevel+bounces-13234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC7C86D971
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2586B2286A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 02:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9953B3A8CB;
	Fri,  1 Mar 2024 02:13:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903B2AF0D;
	Fri,  1 Mar 2024 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259221; cv=none; b=q+y9ccWTEWCyQtdx80k8ss7310sKU3NVfw1mLfrRou0LQcVCHBRELwGh3hkqmF95sbhJilJzwreHpBX7F7UmX5uvl2lxksJpuiu2uOJ0DtwRULDifIVifuPKr2TawwIxLCuNld1l9SpZnHXh5rrySqmmx4/eETLflgEQl6KqpiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259221; c=relaxed/simple;
	bh=NPD/17SvfvonoQ1qrXhKNqN7Pwo5QKQggEW33QEBWeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfD0dyWxVn+SPVk1ebxteC5GsrBUqwysHXMd3MbH7JtV27pGD7vOfgnbfcVJbknQb3aZQIe2v2/9yebX/GJxLYKpZIYhVcJu4mcFInp8eyOBjPxbeO3mYXmS744bksf/iHp0yJDEMlEzImmECECN/PhmCkI7oKJCXiTLf15qZjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TmBQn5z23z1h142;
	Fri,  1 Mar 2024 10:11:13 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 15F1D1A016B;
	Fri,  1 Mar 2024 10:13:30 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:13:28 +0800
Message-ID: <8d49ad72-4d51-27b9-1c0e-0948942f8027@huawei.com>
Date: Fri, 1 Mar 2024 10:13:28 +0800
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
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/3/1 1:32, Linus Torvalds 写道:
> On Thu, 29 Feb 2024 at 00:13, Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>> See the logic before this patch, always success (((void)(K),0)) is
>> returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.
> 
> No, look closer.
> 
> Yes, the iterate_and_advance() macro does that "((void)(K),0)" to make
> the compiler generate better code for those cases (because then the
> compiler can see that the return value is a compile-time zero), but
> notice how _copy_mc_to_iter() didn't use that macro back then. It used
> the unvarnished __iterate_and_advance() exactly so that the MC copy
> case would *not* get that "always return zero" behavior.
> 
> That goes back to (in a different form) at least commit 1b4fb5ffd79b
> ("iov_iter: teach iterate_{bvec,xarray}() about possible short
> copies").
> 
> But hardly anybody ever tests this machine-check special case code, so
> who knows when it broke again.
> 
> I'm just looking at the source code, and with all the macro games it's
> *really* hard to follow, so I may well be missing something.
> 
>> Maybe we're all gonna fix it back? as follows：
> 
> No. We could do it for the kvec and xarray case, just to get better
> code generation again (not that I looked at it, so who knows), but the
> one case that actually uses memcpy_from_iter_mc() needs to react to a
> short write.
> 
> One option might be to make a failed memcpy_from_iter_mc() set another
> flag in the iter, and then make fault_in_iov_iter_readable() test that
> flag and return 'len' if that flag is set.
> 
> Something like that (wild handwaving) should get the right error handling.
> 
> The simpler alternative is maybe something like the attached.
> COMPLETELY UNTESTED. Maybe I've confused myself with all the different
> indiraction mazes in the iov_iter code.
> 
>                       Linus

Hi Linus:

The method in the attachment i have tested before is feasible and can
solve this deadloop problem. I also have some confusion about the
iov_iter code. Let's take a look at manitainer's comments to see whether
there are more comprehensive considerations.

Thanks,
Tong.

