Return-Path: <linux-fsdevel+bounces-20077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BF8CDBC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 23:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46431F24CCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35432127E0F;
	Thu, 23 May 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1cpAX/WT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16C20DC8
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499006; cv=none; b=WEvd/iPFJQ0+fIfJQ+YAmLZnbZTA6v8umF3YMFy6lxZumEoG6sDsi4u/TX8Jzd2nTT4H9hjpbqRp0M14uPaOIZSbJFJKv+xTKqpXCnNaSqtpt5+f8AOMjThWP8sfn8cZ2pREW2r9KPlXfXnfRi3ozw8TTrm3QbR1V5yLa5r5iPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499006; c=relaxed/simple;
	bh=UyvAR+rCqOFMlr/SS+1G6e+pvgKBDpk94OJDklZdVUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdV+lxCCRKTl6cD+IQ249F85g/TkggGr74lPFoyk+UXJZCqdOmE/lDqotwsrhsJEiMkeJsewQ+XIzAdQSeaxdXUbn8Fmr4HEpnE7RKHlyktTDr22Hfw0G9jP2R48glv9OqTpEcD/wfL3ydNBd3u35MRNVD8JuSff81kQbbRakDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1cpAX/WT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f33772fa90so1496405ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716499001; x=1717103801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYKcD5IuchFm4IMrBOnq6lh3XNI0BhQKY7/Pq8Y41cA=;
        b=1cpAX/WTT+llFO04wUpvHFp4KZQDZVOU582pZ9oR8mGOBhcsAwKyHqr3mfDPVX/ynQ
         CXZoGJQFEpZ0MIlDWHem+rYrilyJHoM1fLQVuMLdYFdXFCszqF98nWWBVT+KhxF3mmRh
         aOe4Q0z+5yzOP8NO/7QL2dFO4ygvUS/iCAFOyrl1lTt+pAAaBCPJJBNtxtRt72XrtNoH
         MBdi84U8f7EgS+HMJI3qS7Uk4DNZXUMZBnn55Z76V8ny2cLFTnVzArduX2EjGwrebl4W
         8HZu1PskH01AXn50nsUge0JsJUtjIcWW52sknSLyESCe8p3ayIUq0GQ4xcVtAzMom2lK
         Uw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499001; x=1717103801;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYKcD5IuchFm4IMrBOnq6lh3XNI0BhQKY7/Pq8Y41cA=;
        b=NsNb7VuhF+1Aoz/YmJXRHkb8gJ6SQH5LOWluWGwCDzzPV/fAuZzpDnhwx5ZhMQbJGB
         9J0AbJmFIQ2R6fQ/JqtobyA+EJXHRa8w6OFojnjMErEcLvM/G1GJgA67joBROrrGl70/
         HYTdQAcvHqIsTtxHRR3Sd52mORMMoiTvyup0LeY0RDJVvg1jDrT/ck5576OHUaDS6JOD
         gUHV8dCVVVSzbVf2ZFzdpWAcSzRl9e4FBeohTr/8lithLDyerj9CdMFZmCs/x6WoiwJW
         DC/HH07f5Qg+j1G+JPG/FC9z6OqNpiH51FL/A/h6WvLblnFitwKQN4q2I7GEWH51vM/S
         nwqA==
X-Forwarded-Encrypted: i=1; AJvYcCV/2bq5+7J0OL3r2Ehe2iaeP7FvvIJWpKm05V3LH0qxgSux93fpdRRPi82kyXXFsDa9xyPKcR3cEtipdrYZ3w0gF5dWO0EAaoBK9Av9Gw==
X-Gm-Message-State: AOJu0YwyD8lIqJnMLS2npAInrp6g/PNS8/hPAjzxg6WY/+SgDrh8XWrd
	S1Z/hjxuklS2yjL0aUPUaF4DseuFrqOwljW3ozSvY3k9aDX3nFXux8hj4lhcdCo=
X-Google-Smtp-Source: AGHT+IEuoEoQ/bJet1m7gQrg83v+8LU9LhdnXxXzTFJ+8azHok2UlXv7rYJvnuhuAuTOIbgYM9Cflg==
X-Received: by 2002:a17:903:41c6:b0:1f2:f73c:c442 with SMTP id d9443c01a7336-1f4483e91a8mr6489475ad.0.1716499001521;
        Thu, 23 May 2024 14:16:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21c1::1060? ([2620:10d:c090:400::5:32c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c79d046sm373525ad.72.2024.05.23.14.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 14:16:40 -0700 (PDT)
Message-ID: <024b9a30-ad3b-4063-b5c8-e6c948ad6b2e@kernel.dk>
Date: Thu, 23 May 2024 15:16:38 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: invalidating pages is still necessary when io
 with IOCB_NOWAIT
To: Matthew Wilcox <willy@infradead.org>, Liu Wei <liuwei09@cestc.cn>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Goldwyn Rodrigues <rgoldwyn@suse.com>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
References: <20240513132339.26269-1-liuwei09@cestc.cn>
 <Zk-wa_GvvrxpX9kn@casper.infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zk-wa_GvvrxpX9kn@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 3:08 PM, Matthew Wilcox wrote:
> On Mon, May 13, 2024 at 09:23:39PM +0800, Liu Wei wrote:
>> After commit (6be96d3ad3 fs: return if direct I/O will trigger writeback),
> 
> If you're reporting problems with a particular commit, it's good form
> to cc the people who actually wrote that commit.

Yeah indeed...

>> when we issuing AIO with direct I/O and IOCB_NOWAIT on a block device, the
>> process context will not be blocked.
>>
>> However, if the device already has page cache in memory, EAGAIN will be
>> returned. And even when trying to reissue the AIO with direct I/O and
>> IOCB_NOWAIT again, we consistently receive EAGAIN.

-EAGAIN doesn't mean "just try again and it'll work".

>> Maybe a better way to deal with it: filemap_fdatawrite_range dirty pages
>> with WB_SYNC_NONE flag, and invalidate_mapping_pages unmapped pages at
>> the same time.
>>
>> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
>> ---
>>  mm/filemap.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 30de18c4fd28..1852a00caf31 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2697,8 +2697,15 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
>>  
>>  	if (iocb->ki_flags & IOCB_NOWAIT) {
>>  		/* we could block if there are any pages in the range */
>> -		if (filemap_range_has_page(mapping, pos, end))
>> +		if (filemap_range_has_page(mapping, pos, end)) {
>> +			if (mapping_needs_writeback(mapping)) {
>> +				__filemap_fdatawrite_range(mapping,
>> +						pos, end, WB_SYNC_NONE);
>> +			}

I don't think WB_SYNC_NONE tells it not to block, it just says not to
wait for it... So this won't work as-is.

>> +			invalidate_mapping_pages(mapping,
>> +					pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>>  			return -EAGAIN;
>> +		}
>>  	} else {
>>  		ret = filemap_write_and_wait_range(mapping, pos, end);
>>  		if (ret)
>> -- 
>> 2.42.1
>>
>>
>>

-- 
Jens Axboe


