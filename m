Return-Path: <linux-fsdevel+bounces-73145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BBFD0E1E2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 08:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BB530124D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74421E2858;
	Sun, 11 Jan 2026 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U6cN+HOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8C3A41;
	Sun, 11 Jan 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768116565; cv=none; b=fF7DUqUL4mGTEenFX+/C9T9vo/5P/cuEW58eluocZt4LpE9iigTLUw1iCl8z5qBBiCRMkc6JlLZdYk79uLqbKucANzT65t8NhARSiulTIixd9tZSrMa6sK4f6fUgbmamRhvXBLZgoecmbQTh+3LD0sJvjpT1WeZekZayiTJobB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768116565; c=relaxed/simple;
	bh=3VDaEy3X9RSul9vY5nkcGkc2Lqt4RonrCeRULUzerHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocLJ+7C21278Cy1sDoNbkvpBk+LZwurevd1jpSEU/oBqTdcjOKxbcC88/AOQaM6Zx7tNuFRrpV+lrchM6xjgEwpeSR178JNkM6C1OshcCKt4h6cl2FErjbOidHIiDKWTM7I7GtEd5KFUXYrzPatUUC1fIup+aIbqmLISTA4SQnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U6cN+HOq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768116552; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RoS0ELY1/PvtyN/kgl1rlk5L1a/Pb9/45nwvxgWuw9w=;
	b=U6cN+HOqtsp12dVKeZqsSUxdm0Vo+LCtgZ8+5ERFJlMeVYc3wZnBLVwtcDwgAg6kot2ED3ALUNIm/hY6RipbwzGDnnE3xGme1Ds9vCj1nQ9mQrijWyxGAhE3H/9w6aTFZv51JYbzdMdpTd5RQJnVf4vZnWgpudRb61jrqmSLQGo=
Received: from 30.180.152.220(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WwlmWko_1768116551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 11 Jan 2026 15:29:11 +0800
Message-ID: <6fd06c7f-a30b-4ba5-97aa-b7277d56b190@linux.alibaba.com>
Date: Sun, 11 Jan 2026 15:29:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: invalidate the page cache after direct write
To: Bernd Schubert <bernd@bsbernd.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, bschubert@ddn.com
Cc: linux-kernel@vger.kernel.org
References: <20260109070110.18721-1-jefflexu@linux.alibaba.com>
 <b8f7dd35-7702-4c70-be4f-0704abc1976d@bsbernd.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <b8f7dd35-7702-4c70-be4f-0704abc1976d@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 10:05 PM, Bernd Schubert wrote:
> 
> 
> On 1/9/26 08:01, Jingbo Xu wrote:
>> -	return err ?: ia->write.out.size;
>> +	/*
>> +	 * As in generic_file_direct_write(), invalidate after the write, to
>> +	 * invalidate read-ahead cache that may have competed with the write.
>> +	 * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
>> +	 * invalidation for synchronous write.
>> +	 */
>> +	if (!err && written && mapping->nrpages &&
>> +	    ((ff->open_flags & FOPEN_DIRECT_IO) || !ia->io->blocking)) {
>> +		invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
>> +					(pos + written - 1) >> PAGE_SHIFT);
>> +	}
>> +
>> +	return err ?: written;
>>  }
> 
> Sorry, but I'm confused about "|| !ia->io->blocking". When we go into this
> code path it either via generic_file_direct_write(), which then
> already invalidates or directly and then 
> (ff->open_flags & FOPEN_DIRECT_IO) is set?
> 

Alright. I mistakenly thought that generic_file_direct_write() will skip
the invalidation for async write (without FOPEN_DIRECT_IO) when
fc->async_dio is false, as the ->direct_IO() will return -EIOCBQUEUED
for async write.

But in fact when fc->async_dio is false, fuse_direct_IO() will wait for
the IO completion and return the number of bytes written on success.
Thus generic_file_direct_write() will do the invalidation in this case.

I will drop "|| !ia->io->blocking" in v3 and add your "Reviewed-by" tag
then.

Thank you for the reviewing!

-- 
Thanks,
Jingbo


