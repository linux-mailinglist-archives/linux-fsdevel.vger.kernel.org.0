Return-Path: <linux-fsdevel+bounces-73646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1ED1D718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 165C330BBDEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02DE3816F0;
	Wed, 14 Jan 2026 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qaJLD1Fo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48837FF7C;
	Wed, 14 Jan 2026 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381563; cv=none; b=k7BVIqvC1/xZR+lfYkeP+ugHE2wn0FP85VM5uaxp2oG6mjKFs75kQDS3tdtJ0VrJyHdTocoQNoQwsrvqGAyPTvYTgQBqD6lmLi/d2Kr+zD9+IjPVGa66ZsYcj8Ao0GYxfiCHFGg5i4hdFUM0F4+/LuvOhrsL1YbI1Eun9qXMjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381563; c=relaxed/simple;
	bh=Z/c5xzA8GsX9mu/B0hzCKBFGxJax0635OBr+LZaU52k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnQ0dPB8ber64MuVmVrPEqa6zhrjMAj63z66iUuTIS0aor4D92D65alJD9xR+PIbDERFHwdJTWNN+eJcYGIVD1XD0m1oDS1dsoWe4hgRK/RhD6cDkdyG4zxyCaiUOWRn+VDN3cSSKLLyF1Nw7RLj2uU/hoivMrpqplMR2OFYFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qaJLD1Fo; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768381552; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EyFwIrf9sSF50zf02WWt1cpGq8zTuT3XybAEwTZBtdg=;
	b=qaJLD1FokQcbIujrOG8yhVHejgXw3xUXNFfAwV33tZffCV5m4nOV3fxSWoWpJ3kaFG1nRFQRT6E3t8kEtOLEA0Cmiss9QWlkjp6Oca/iwMO0JNxp6vT7E11LYPAFZmg+T5PJ/QVkVbdcUhSkcJFLZFzKKtTPwy1ZzpTbj28aDsA=
Received: from 30.221.147.158(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wx1jSBj_1768381551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 14 Jan 2026 17:05:52 +0800
Message-ID: <03d69c33-e7c9-4160-890f-3b7f65de37d5@linux.alibaba.com>
Date: Wed, 14 Jan 2026 17:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ak: fuse: fix premature writetrhough request for large
 folio
To: Horst Birthelmer <horst@birthelmer.de>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114055615.17903-1-jefflexu@linux.alibaba.com>
 <aWdYxTEO29S91qp-@fedora.fritz.box>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <aWdYxTEO29S91qp-@fedora.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 4:58 PM, Horst Birthelmer wrote:
> 
> Hi Jingbo,
> 
> On Wed, Jan 14, 2026 at 01:56:15PM +0800, Jingbo Xu wrote:
>> When large folio is enabled and the initial folio offset exceeds
>> PAGE_SIZE, e.g. the position resides in the second page of a large
>> folio, after the folio copying the offset (in the page) won't be updated
>> to 0 even though the expected range is successfully copied until the end
>> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
>> before the request has reached the max_write/max_pages limit.
>>
>> Fix this by eliminating page offset entirely and use folio offset
>> instead.
>>
>> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
>> ---
>>  fs/fuse/file.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index 625d236b881b..6aafb32338b6 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -1272,7 +1272,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>  {
>>  	struct fuse_args_pages *ap = &ia->ap;
>>  	struct fuse_conn *fc = get_fuse_conn(mapping->host);
>> -	unsigned offset = pos & (PAGE_SIZE - 1);
>>  	size_t count = 0;
>>  	unsigned int num;
>>  	int err = 0;
>> @@ -1299,7 +1298,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>  		if (mapping_writably_mapped(mapping))
>>  			flush_dcache_folio(folio);
>>  
>> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
>> +		folio_offset = offset_in_folio(folio, pos);
>>  		bytes = min(folio_size(folio) - folio_offset, num);
>>  
>>  		tmp = copy_folio_from_iter_atomic(folio, folio_offset, bytes, ii);
>> @@ -1329,9 +1328,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>  		count += tmp;
>>  		pos += tmp;
>>  		num -= tmp;
>> -		offset += tmp;
>> -		if (offset == folio_size(folio))
>> -			offset = 0;
>>  
>>  		/* If we copied full folio, mark it uptodate */
>>  		if (tmp == folio_size(folio))
>> @@ -1343,7 +1339,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>>  			ia->write.folio_locked = true;
>>  			break;
>>  		}
>> -		if (!fc->big_writes || offset != 0)
>> +		if (!fc->big_writes)
>> +			break;
>> +		if (folio_offset + tmp != folio_size(folio))
>>  			break;
>>  	}
>>  
>> -- 
>> 2.19.1.6.gb485710b
>>
>>
> 
> 
> I think this might have been an oversight when moving from pages to folios.
> 
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>

Right, it's not triggered until large folio is enabled.

Thanks for the review :)

