Return-Path: <linux-fsdevel+bounces-13171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07886C33B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 09:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E231F23766
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FD4D9E8;
	Thu, 29 Feb 2024 08:13:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24F482F4;
	Thu, 29 Feb 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194412; cv=none; b=nrBEvFaVTOJYu5bT2kNsJiNnCyDLMGtAIAg5aQbmuehAG0SfIfzwSx0NWTvfmkU7sZyaq30yeJpxV4c8zSBSlBLHoeG1Yvj221I+W1wsxi2Ht2+EMY+SE8hRwVEEyUDy7u3xq+XKlh36tb6qMjrkFouea3WeqULEau4+rGbLC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194412; c=relaxed/simple;
	bh=m1ENKFuVqqs6NcU1ONAoAAp9WZXAXhJXbETdBIy3WBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=etaNyd58aOizHzDvVqaUyF4V6d/odIrX1wYosys2ET3RZL64HtlNImKrTYnhaCwhGbaDSFMoUrh+pQffLa5ljrlxyiT30l7LwxvVTx3XBk3TI0ZKRT82o+7MdIUSSZ/fvuHwiDql6QB2Rc0bQ9CIpCycfkKiQOZWSd2yV0ht7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TlkTK1Ntcz1xppT;
	Thu, 29 Feb 2024 16:11:49 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AB2F1A0172;
	Thu, 29 Feb 2024 16:13:20 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 16:13:19 +0800
Message-ID: <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com>
Date: Thu, 29 Feb 2024 16:13:18 +0800
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>
CC: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Al Viro
	<viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Christian Brauner
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
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/2/29 6:57, Linus Torvalds 写道:
> On Wed, 28 Feb 2024 at 13:21, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm. If the copy doesn't succeed and make any progress at all, then
>> the code in generic_perform_write() after the "goto again"
>>
>>                  //[4]
>>                  if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
>>                                bytes)) {
>>
>> should break out of the loop.
> 
> Ahh. I see the problem. Or at least part of it.
> 
> The iter is an ITER_BVEC.
> 
> And fault_in_iov_iter_readable() "knows" that an ITER_BVEC cannot
> fail. Because obviously it's a kernel address, so no user page fault.
> 
> But for the machine check case, ITER_BVEC very much can fail.
> 
> This should never have worked in the first place.
> 
> What a crock.
> 
> Do we need to make iterate_bvec() always succeed fully, and make
> copy_mc_to_kernel() zero out the end?
> 
>                     Linus
> .

Hi Linus:

See the logic before this patch, always success (((void)(K),0)) is
returned for three types: ITER_BVEC, ITER_KVEC and ITER_XARRAY.

-------------------------------------------------------------------
   -#define __iterate_and_advance(i, n, base, len, off, I, K) {	\
   -	if (unlikely(i->count < n))				\
   -		n = i->count;					\
   -	if (likely(n)) {					\
   -		if (likely(iter_is_ubuf(i))) {			\
   			[...]					\
   -			iterate_buf(i, n, base, len, off,	\
   -						i->ubuf, (I)) 	\
   -		} else if (likely(iter_is_iovec(i))) {		\
			[...]					\
   -			iterate_iovec(i, n, base, len, off,	\
   -						iov, (I))	\
   -			i->nr_segs -= iov - iter_iov(i);	\
   -			i->__iov = iov;				\
   -		} else if (iov_iter_is_bvec(i)) {		\
			[...]					\
   -			iterate_bvec(i, n, base, len, off,	\
   -						bvec, (K))	\
   -			i->nr_segs -= bvec - i->bvec;		\
   -			i->bvec = bvec;				\
   -		} else if (iov_iter_is_kvec(i)) {		\
			[...]					\
   -			iterate_iovec(i, n, base, len, off,	\
   -						kvec, (K))	\
			[...]					\
   -		} else if (iov_iter_is_xarray(i)) {		\
			[...]					\
   -			iterate_xarray(i, n, base, len, off,	\
   -							(K))	\
   -		}						\
   -		i->count -= n;					\
   -	}							\
   -}
   -#define iterate_and_advance(i, n, base, len, off, I, K) \
   -	__iterate_and_advance(i, n, base, len, off, I, ((void)(K),0))
-------------------------------------------------------------------

Maybe we're all gonna fix it back? as follows：
-------------------------------------------------------------------
   --- a/include/linux/iov_iter.h
   +++ b/include/linux/iov_iter.h
   @@ -246,11 +246,11 @@ size_t iterate_and_advance2(struct iov_iter 
*iter, size_t len, void *priv,
           if (likely(iter_is_iovec(iter)))
                   return iterate_iovec(iter, len, priv, priv2, ustep);
           if (iov_iter_is_bvec(iter))
   -               return iterate_bvec(iter, len, priv, priv2, step);
   +               return iterate_bvec(iter, len, priv, priv2, ((void 
*)step, 0));
           if (iov_iter_is_kvec(iter))
   -               return iterate_kvec(iter, len, priv, priv2, step);
   +               return iterate_kvec(iter, len, priv, priv2, ((void 
*)step, 0));
           if (iov_iter_is_xarray(iter))
   -               return iterate_xarray(iter, len, priv, priv2, step);
   +               return iterate_xarray(iter, len, priv, priv2, ((void 
*)step, 0));
           return iterate_discard(iter, len, priv, priv2, step);
    }

   diff --git a/lib/iov_iter.c b/lib/iov_iter.c
   index e0aa6b440ca5..fabd5b1b97c7 100644
   --- a/lib/iov_iter.c
   +++ b/lib/iov_iter.c
   @@ -257,7 +257,7 @@ static size_t __copy_from_iter_mc(void *addr, 
size_t bytes, struct iov_iter *i)
                   bytes = i->count;
           if (unlikely(!bytes))
                   return 0;
   -       return iterate_bvec(i, bytes, addr, NULL, memcpy_from_iter_mc);
   +       return iterate_bvec(i, bytes, addr, NULL, ((void 
*)memcpy_from_iter_mc, 0));
    }

    static __always_inline
-------------------------------------------------------------------

    Hi, maintainer Alexander, what do you think ? :)

Thanks,
Tong.


