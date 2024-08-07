Return-Path: <linux-fsdevel+bounces-25290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFC94A711
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C21F22749
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D21E486F;
	Wed,  7 Aug 2024 11:39:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6861E2101;
	Wed,  7 Aug 2024 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030754; cv=none; b=mvhi+g5zEJJrnp9PE0jBY1ZTqXAfr9xpFaFbLALJMjedHw9ev6EA4TLjXM508buFiOlCXqwYLmGGndIoIT8cyT2d78YRMIsoKLMDUDQ4ak0P1prA0EwbtsNgDGtvQbs+13GBeYSnyhanyqBPZvthKPkEEVj7jFr/dSlmQLFl4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030754; c=relaxed/simple;
	bh=iWxaPO9BnrtCywje5tM/thdF9F2kH6y/xZ/ldwKobN0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lIblUhDTvTbKbxw5fHKyV+2KEwo/Spp9jAK2A9I3lQpaU9vCdYDEjVdp/1WF4HdxNhO13Y95sC/spgoFDriCVXqKKPh+pk/Q/T6MoJ7JNzuvNSeKBf8rKfldELL14UWZM9HKvF4/FPOmf9VSctDJNy+RfCpNZtxokFvojxr6YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wf7VQ0843z4f3jrt;
	Wed,  7 Aug 2024 19:38:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5BABB1A0568;
	Wed,  7 Aug 2024 19:39:07 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoTZXLNmb38WBA--.25043S3;
	Wed, 07 Aug 2024 19:39:07 +0800 (CST)
Subject: Re: [PATCH 5/6] iomap: drop unnecessary state_lock when setting ifs
 uptodate bits
To: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240731091305.2896873-1-yi.zhang@huaweicloud.com>
 <20240731091305.2896873-6-yi.zhang@huaweicloud.com>
 <Zqwi48H74g2EX56c@dread.disaster.area>
 <b40a510d-37b3-da50-79db-d56ebd870bf0@huaweicloud.com>
 <Zqx824ty5yvwdvXO@dread.disaster.area>
 <1b99e874-e9df-0b06-c856-edb94eca16dc@huaweicloud.com>
 <20240805124252.nco2rblmgf6x7z4s@quack3>
 <20240805140023.inte2rxlhumkfvrh@quack3>
 <ZrD0TKDHWhwiEoz_@casper.infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ed3c1368-766b-9a54-ec88-b0cde033775f@huaweicloud.com>
Date: Wed, 7 Aug 2024 19:39:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZrD0TKDHWhwiEoz_@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXPoTZXLNmb38WBA--.25043S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4xWr1kXw1ftrWxGFWkCrg_yoW8ZF1kpF
	Wjg3Z2kr4kJF4I9rnFya18J34Fk34xJw15GF1xGr12yF95uF1SgFy3tF1UuF18Gwsaga1I
	vFyUJas7ZF1UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/5 23:48, Matthew Wilcox wrote:
> On Mon, Aug 05, 2024 at 04:00:23PM +0200, Jan Kara wrote:
>> Actually add Matthew to CC ;)
> 
> It's OK, I was reading.
> 
> FWIW, I agree with Dave; the locking complexity in this patch was
> horrendous.  I was going to get to the same critique he had, but I first
> wanted to understand what the thought process was.

Yes, I'd like to change to use the solution as Dave suggested.

> 
>>>> Ha, right, I missed the comments of this function, it means that there are
>>>> some special callers that hold table lock instead of folio lock, is it
>>>> pte_alloc_map_lock?
>>>>
>>>> I checked all the filesystem related callers and didn't find any real
>>>> caller that mark folio dirty without holding folio lock and that could
>>>> affect current filesystems which are using iomap framework, it's just
>>>> a potential possibility in the future, am I right?
> 
> Filesystems are normally quite capable of taking the folio lock to
> prevent truncation.  It's the MM code that needs the "or holding the
> page table lock" get-out clause.  I forget exactly which callers it
> is; I worked through them a few times.  It's not hard to put a
> WARN_ON_RATELIMIT() into folio_mark_dirty() and get a good sampling.
> 
> There's also a "or holding a buffer_head locked" get-out clause that
> I'm not sure is documented anywhere, but obviously that doesn't apply
> to the iomap code.

Thanks for your answer, I've found some callers.

Thanks,
Yi.

> 
>>> There used to be quite a few places doing that. Now that I've checked all
>>> places I was aware of got actually converted to call folio_mark_dirty() under
>>> a folio lock (in particular all the cases happening on IO completion, folio
>>> unmap etc.). Matthew, are you aware of any place where folio_mark_dirty()
>>> would be called for regular file page cache (block device page cache is in a
>>> different situation obviously) without folio lock held?
> 
> Yes, the MM code definitely applies to regular files as well as block
> devices.
> 


