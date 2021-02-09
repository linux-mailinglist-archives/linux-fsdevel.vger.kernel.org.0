Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0729631519B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhBIOaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 09:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBIOaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:30:19 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0BFC061788
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 06:29:39 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e133so18888700iof.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 06:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sR8Y5r3hBaqi7OfyrOKfoKntN+cJHKvefPND1Fw72qs=;
        b=Xmsw9t81sF7zEdoNNbMsU6rqedj1RxMf9mcipV//PWNWxig3fn3xRl9ZGIeGGOnnGX
         Boh54R+8O+7qvyy9btRg54MNOmu+D8TRD1muXASban1wc5YNR0LxyLI6bj+Vc31h8M03
         IbUNoZmyk6qoh2CbqqmVGQZBckW9uc5gPyfqJZQp0G45Gfcr6jtNUrq4IyCCo9YPeWNq
         SdJ/u7jFjajPV04J5QXW4JPZdK1GKo56wIgUOIO2nLmvV/ZHgzwrybBnVZO24oss0rK+
         B5oi6SEnXZVOmx4ifTo0hTMEH7UMB6xw83Dan05fNjE05nOC++APeB1TGYu9yKWZMMwe
         5gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sR8Y5r3hBaqi7OfyrOKfoKntN+cJHKvefPND1Fw72qs=;
        b=HN3hC96zoDfc0dB3rWL4ZJNZmohudPA0ZtmkDQebYLS4O3qC1ZDBgRzU+NbX74nf+w
         d+fq/3b2UsN4LbLKvUt2ss0OrNM0hcSu4/pZ8r1oi9xohEcn1aqF+Ad8zl+6j/XvobYa
         Wf6Aec9umIx+C702xT4u5FydnQpxX3+ewrwbJNBdY9xRHTI4BYcL+2Ddxh7m2JaV4KSA
         VXj1y9KmbW3jFBqWdAFJbdrGbpv72iaeVxNPV8bBcGXcgkNKKA/ifk759ncTNb15hlgc
         L93fBnekegNcNl+tzD+NrWUJdpC0AxZ6X0Fn8v+VfUVWGnysIkp0t+reduO3yEx0iuf/
         BDFA==
X-Gm-Message-State: AOAM532AFggLiIxEkUxbs8OoYlKRMuSdyH5Za7n4K5CS7JDKyk6KO2eZ
        5wqSDsmkkqw7vc2ZgF/s9KrGtA==
X-Google-Smtp-Source: ABdhPJx10WZDpqwBaXShrmjbhnFlTKZO7snwFdVsANnFEeNvaYn8UtAwvKhWqiF60oh87N98gP9y4Q==
X-Received: by 2002:a5e:c74a:: with SMTP id g10mr3350295iop.129.1612880978696;
        Tue, 09 Feb 2021 06:29:38 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h12sm10678522ilj.52.2021.02.09.06.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:29:38 -0800 (PST)
Subject: Re: [PATCH 3/3] iomap: use filemap_range_needs_writeback() for
 O_DIRECT reads
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20210209023008.76263-1-axboe@kernel.dk>
 <20210209023008.76263-4-axboe@kernel.dk>
 <20210209075119.GC1696555@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fb1a43c-3d5f-be43-952e-b0462ed47b4c@kernel.dk>
Date:   Tue, 9 Feb 2021 07:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209075119.GC1696555@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/9/21 12:51 AM, Christoph Hellwig wrote:
> On Mon, Feb 08, 2021 at 07:30:08PM -0700, Jens Axboe wrote:
>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>> +			if (filemap_range_needs_writeback(mapping, pos, end)) {
>> +				ret = -EAGAIN;
>> +				goto out_free_dio;
>> +			}
>> +			flags |= IOMAP_NOWAIT;
>> +		}
>>  		if (iter_is_iovec(iter))
>>  			dio->flags |= IOMAP_DIO_DIRTY;
>>  	} else {
>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>> +			if (filemap_range_has_page(mapping, pos, end)) {
>> +				ret = -EAGAIN;
>> +				goto out_free_dio;
>> +			}
>> +			flags |= IOMAP_NOWAIT;
>> +		}
>> +
>>  		flags |= IOMAP_WRITE;
>>  		dio->flags |= IOMAP_DIO_WRITE;
>>  
>> @@ -478,14 +493,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>  			dio->flags |= IOMAP_DIO_WRITE_FUA;
>>  	}
>>  
>> -	if (iocb->ki_flags & IOCB_NOWAIT) {
>> -		if (filemap_range_has_page(mapping, pos, end)) {
>> -			ret = -EAGAIN;
>> -			goto out_free_dio;
>> -		}
>> -		flags |= IOMAP_NOWAIT;
>> -	}
> 
> looking at this I really hate the scheme with the potential racyness
> and duplicated page looksups.

Me too

> Why can't we pass a nonblock flag to filemap_write_and_wait_range
> and invalidate_inode_pages2_range that makes them return -EAGAIN
> when they would block to clean this whole mess up?

We could, but that's a _lot_ of surgery. I'd rather live with the
slight race for now instead of teaching writepages, page laundering,
etc about IOCB_NOWAIT.

I do think that's a worthy long term goal, but we dio read situation
is bad enough that it warrants a quicker fix.

-- 
Jens Axboe

