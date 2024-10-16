Return-Path: <linux-fsdevel+bounces-32080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229469A05DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32081F26608
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 09:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B5205E33;
	Wed, 16 Oct 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FKhmVYeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBD20263F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071853; cv=none; b=oWEg1Wz1nAHDnaOyOY+3EpPwGetm9jbRU5U/FfMp/0MsmOfGxAzv4guT1kFo0hCTKC+BOOYgPjafV1jhmV/Y0+yXpLjlSQnN1ZLP4h6jTlCeXLFoWFJCTaZQ0re3OxpMhUz6wIXHfER0D9YUlouawJxjXaPe8bTt5UYrMk82/tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071853; c=relaxed/simple;
	bh=IABU4fFnnh84gVNXLdlU9TCqMRTS3/FHDGahPby08Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPH+xFVXTAL0gM3hKcL8CR983Jf3QBr8AZCmxtx1BMUktIXrJFtChnPs6/+Q51n8zYqPAZG/VsTi20x385OIUvD4E46hBG08z19rUxkxtukrWyw1hLVjBN/BVLtI8nL5Poj7TMAbIyzqanKuUDAKLF4/xNAHOsCfdaJPQgztDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FKhmVYeI; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729071848; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9ItjDkcA8lZDnqyxHAXggmLuWPrWEQeSROmFdmxwZxQ=;
	b=FKhmVYeI16xdig2/XB3AdJqvgeUKcOy0QkR6WdT+fRyTTY7STSgLYMRpimZc1OdG/XTBBM8wdY+1prQnfp7wNTvNJBsniy1l6ZQgMv9UuieRHNoGISd3oc6M7BCM+ckhbrA20s6t7A8U97bcH/AF3dtTvHlaaTSo1wbMhszTf8c=
Received: from 30.221.144.185(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WHH-KKw_1729071846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Oct 2024 17:44:07 +0800
Message-ID: <8eec0912-7a6c-4387-b9be-6718f438a111@linux.alibaba.com>
Date: Wed, 16 Oct 2024 17:44:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 josef@toxicpanda.com, bernd.schubert@fastmail.fm, hannes@cmpxchg.org,
 linux-mm@kvack.org, kernel-team@meta.com
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/16/24 3:17 AM, Shakeel Butt wrote:
> On Tue, Oct 15, 2024 at 10:06:52AM GMT, Joanne Koong wrote:
>> On Tue, Oct 15, 2024 at 3:01 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>>
>>> On Mon, 14 Oct 2024 at 20:23, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>>> This change sets AS_NO_WRITEBACK_RECLAIM on the inode mapping so that
>>>> FUSE folios are not reclaimed and waited on while in writeback, and
>>>> removes the temporary folio + extra copying and the internal rb tree.
>>>
>>> What about sync(2)?   And page migration?
>>>
>>> Hopefully there are no other cases, but I think a careful review of
>>> places where generic code waits for writeback is needed before we can
>>> say for sure.
>>
>> Sounds good, that's a great point. I'll audit the other places in the
>> mm code where we might call folio_wait_writeback() and report back
>> what I find.
>>
>>
> 
> So, any operation that the fuse server can do which can cause wait on
> writeback on the folios backed by the fuse is problematic. We know about
> one scenario i.e. memory allocation causing reclaim which may do the
> wait on unrelated folios which may be backed by the fuse server.
> 
> Now there are ways fuse server can shoot itself on the foot. Like sync()
> syscall or accessing the folios backed by itself. The quesion is should
> we really need to protect fuse from such cases?

I think there are several scenarios shall be evaluated case by case:

1) a non-malicious fuse daemon wants to allocate some memory when
processing a fuse request, which in turn leads to memory reclaim and
thus waiting on the writeback of fuse dirty pages - a deadlock here.
This is reasonable and also the target scenario that this series wants
to fix.

2) a malicious fuse daemon refuses to process any request; or a buggy or
not well-written fuse daemon as you described, e.g. may call sync(2)
itself or access page cache backed by itself, then
  2.1) any unrelated user process attempting to initiate a sync(2)
itself, will hang there.  This scenario is also unexpected and shall be
fixed.
  2.2) any direct user of fuse filesystem (e.g. access files backed by
fuse filesystem) will hang in this case.  IMHO this is expected, and the
impact is affordable as it is controlled within certain range (the
direct user of the fs).

-- 
Thanks,
Jingbo

