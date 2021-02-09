Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55F731518C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 15:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhBIO2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 09:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBIO2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:28:01 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26459C061793
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 06:27:13 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id g9so16256239ilc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aq3qgdzINRFL23Dn3U54dtZVmlL/iGXyyjOyYitYchg=;
        b=Q8eJFyBOVIbD4ogb828BynFVMXVFH7Zvbd1xm5sf2+LB5zd+WDT3l59CLRjKS2ML6h
         bD+zrDDwbw7CtIv2yG6nq7s4FSgZf7uLmJ8hV98Em86K+9g7H3rVt2dm+PE3ZzCji0Kr
         3yeM4T5g2cYIDBmZj3/qMSh63aBvf39S7Ol4r3LP2D0+mjuD9z1CkkPyNo4ClpiOudyp
         jgeS8SpP4Na0FIxSZYkD/Ejqp98EaPpoyKE+EeA+e89Zstf86PXP9FTjTahysL/Pqa/x
         HvETpChb95LlayAISbhSCOYU8MYV6RMqlC+t47qzG1seCouo/7zwqEcgSWjwkuVbYt3J
         djXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aq3qgdzINRFL23Dn3U54dtZVmlL/iGXyyjOyYitYchg=;
        b=BoDynahl6ZLUBazWbzh2gJTDFPciv2ju5ItzeRyDHS3tAOQ3f60TBOawQm99SydjO7
         SiIWXEjBdUqjGnjL2+Q6eMeVpi27rODia1sbM//Ytw39a6q2cwA1w1zTLRU11mktu64a
         HFjrsrTbBhylELELYxiHTERK0RmtwV5sBRF7vbpWXtQTTsgY0IliJ6p2fZ1ZpJM2ZJZs
         pX51rHUt6Kr8ONI0BREVFQNZmHTt3nSQh5hUYMkeuW+L4r4sJeLpRgXsOMnOqdao/oNA
         zFTHnsyIm+vuSBmkmY6SPVUe1Z6uN1HPqS2wjzFBEXy1H7eTBCigQnJGVJXh/8+YQxcF
         PqrA==
X-Gm-Message-State: AOAM530DNGAkk0X3X/jMfy0NOIxmZUsi59zAAr8kuHxUgo8RcDqPPAuJ
        9bkluzrPvX62Wf8xVxPWElkHlkpqKoEsuHU/
X-Google-Smtp-Source: ABdhPJwfwCe2fYUCEX2oziQhxEYkTu1eHBrgoBCkz+EjImveMu91Rq6576Dbv4B/2c+J4VmCai8m0w==
X-Received: by 2002:a92:2e05:: with SMTP id v5mr21507028ile.241.1612880832503;
        Tue, 09 Feb 2021 06:27:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b1sm3984200iob.42.2021.02.09.06.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:27:12 -0800 (PST)
Subject: Re: [PATCH 2/3] mm: use filemap_range_needs_writeback() for O_DIRECT
 reads
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-3-axboe@kernel.dk>
 <20210209074814.GB1696555@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <07f67e83-ddfa-19f9-e4d5-f06a939b8840@kernel.dk>
Date:   Tue, 9 Feb 2021 07:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209074814.GB1696555@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 12:48 AM, Christoph Hellwig wrote:
> On Mon, Feb 08, 2021 at 07:30:07PM -0700, Jens Axboe wrote:
>> For the generic page cache read helper, use the better variant of checking
>> for the need to call filemap_write_and_wait_range() when doing O_DIRECT
>> reads. This avoids falling back to the slow path for IOCB_NOWAIT, if there
>> are no pages to wait for (or write out).
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  mm/filemap.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 6a58d50fbd31..c80acb80e8f7 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2643,8 +2643,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>>  
>>  		size = i_size_read(inode);
>>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>> -			if (filemap_range_has_page(mapping, iocb->ki_pos,
>> -						   iocb->ki_pos + count - 1))
>> +			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
>> +							  iocb->ki_pos + count - 1))
> 
> Please avoid the overy long line, which is trivial to do by using the
> normal two tab indent for the continuation.

Sure, fixed.

-- 
Jens Axboe

