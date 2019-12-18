Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C75123DCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 04:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLRDSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 22:18:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35065 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfLRDSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:18:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id b19so402564pfo.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 19:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ta/F+L8w0E5Hsiu1Igiebv41Nze84UUp3eXpDEiDKAA=;
        b=KDc68TBh+4TfL77pWZXYmUWe8TPGF+1ClWdmdKZBL0Ld2dRfaCxeCXnXuJeqsruPLM
         MiWNvK1N+MGoSF+JXJ6taR8FF5m71Jraz1SnG5RpIgc3UnMWiFHsH0ozwcUO0MopuhvG
         5oHz5cHvo1A/mBdjf7GWGF98JrJ+05/5WcjbXcv0Z3mP+I7SpwEbF85gw+yfwDyYJDHs
         DTNQJVTWN7W0e5WMgs61VP1ukul4Q/tobFlH1Pou86F7M5qV2jw4Szj425WNTvHWZ7Pc
         WTOwcDQD1NRDJ85RzvNXuXXOeVsUWEBZgyH8UnKtIpiXCJgQpPsd72JC9s7n3k3U2l3c
         Q/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ta/F+L8w0E5Hsiu1Igiebv41Nze84UUp3eXpDEiDKAA=;
        b=SYLdD7v5rGbmj2kM2hJw1ZY3YyXG99Satu3iLPXelMAsUzcMqXGSsN4A/t2xmGrUMb
         MGbgTu4Uxa2BnyK8m1UWcxEKxbJwY56YnjwApPc6MxHZE4IUM1qoIQo2YT4KYG9W13Ac
         awWmy6j60sRk6nxtvwp6P44s7l2adj4FjrgwyTZkHANW9kECiNKHIK342TAk6ijyn6M7
         bCvNaxqTgyQWVufN6ZvN8S1TfVkuevYHMk8m5W+2ro4H1p1ZumVnRrUTr33uMLTUEk+1
         8zU4S76vMQmJT6OjVqtxRXtJXobZ8mhgCsohdCjaonzIFz+m8EBUhRIymD9K9yDSpc6E
         Jg8Q==
X-Gm-Message-State: APjAAAXT6pY33EQTrK4QziZm145xv7zTOq8psromoTd6qgQ0zDVYDFKm
        kQRwm2NhxU9HdY7RKs109prRWeHg25jgLQ==
X-Google-Smtp-Source: APXvYqyar7zHwCKSJXrCrLtpVriBCxuxJiegePUjc/NgExi/+9E2y19RnuI9ZvhWHL5lDUryN1G47Q==
X-Received: by 2002:a62:e817:: with SMTP id c23mr515734pfi.24.1576639089958;
        Tue, 17 Dec 2019 19:18:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g8sm567926pfh.43.2019.12.17.19.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 19:18:09 -0800 (PST)
Subject: Re: [PATCH 5/6] iomap: support RWF_UNCACHED for buffered writes
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191217143948.26380-1-axboe@kernel.dk>
 <20191217143948.26380-6-axboe@kernel.dk> <20191218015259.GJ12766@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <58036cc3-e0c3-70fe-0ce6-a86754258f24@kernel.dk>
Date:   Tue, 17 Dec 2019 20:18:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218015259.GJ12766@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/17/19 6:52 PM, Darrick J. Wong wrote:
> On Tue, Dec 17, 2019 at 07:39:47AM -0700, Jens Axboe wrote:
>> This adds support for RWF_UNCACHED for file systems using iomap to
>> perform buffered writes. We use the generic infrastructure for this,
>> by tracking pages we created and calling write_drop_cached_pages()
>> to issue writeback and prune those pages.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/iomap/apply.c       | 35 +++++++++++++++++++++++++++++++++++
>>  fs/iomap/buffered-io.c | 28 ++++++++++++++++++++++++----
>>  fs/iomap/trace.h       |  4 +++-
>>  include/linux/iomap.h  |  5 +++++
>>  4 files changed, 67 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
>> index 792079403a22..687e86945b27 100644
>> --- a/fs/iomap/apply.c
>> +++ b/fs/iomap/apply.c
>> @@ -92,5 +92,40 @@ iomap_apply(struct iomap_ctx *data, const struct iomap_ops *ops,
>>  				     data->flags, &iomap);
>>  	}
>>  
>> +	if (written <= 0)
>> +		goto out;
>> +
>> +	/*
>> +	 * If this is an uncached write, then we need to write and sync this
>> +	 * range of data. This is only true for a buffered write, not for
>> +	 * O_DIRECT.
>> +	 */
> 
> I tracked down the original conversation, where Dave had this to say:
> 
> "Hence, IMO, this is the wrong layer in iomap to be dealing with¬
> writeback and cache residency for uncached IO. We should be caching¬
> residency/invalidation at a per-IO level, not a per-page level."
> 
> He's right, but I still think it doesn't quite smell right to be putting
> this in iomap_apply, since that's a generic function that implements
> iteration and shouldn't be messing with cache invalidation.
> 
> So I have two possible suggestions for where to put this:
> 
> (1) Add the "flush and maybe invalidate" behavior to the bottom of
> iomap_write_actor like I said in the v4 patchset.  That will issue
> writeback and invalidate pagecache in smallish quantities.
> 
> (2) Find a way to pass the IOMAP_F_PAGE_CREATE state from
> iomap_write_actor back to iomap_file_buffered_write and do the
> flush-and-invalidate for the entire write request once at the end.

Thanks for your suggestion, I'll look into option 2. Option 1 isn't
going to work, as smaller quantities is going to cause a performance
issue for streamed IO.

>> @@ -851,10 +860,18 @@ iomap_write_actor(const struct iomap_ctx *data, struct iomap *iomap,
>>  			break;
>>  		}
>>  
>> -		status = iomap_write_begin(inode, pos, bytes, 0, &page, iomap,
>> -				srcmap);
>> -		if (unlikely(status))
>> +retry:
>> +		status = iomap_write_begin(inode, pos, bytes, flags,
>> +						&page, iomap, srcmap);
>> +		if (unlikely(status)) {
>> +			if (status == -ENOMEM &&
>> +			    (flags & IOMAP_WRITE_F_UNCACHED)) {
>> +				iomap->flags |= IOMAP_F_PAGE_CREATE;
>> +				flags &= ~IOMAP_WRITE_F_UNCACHED;
> 
> What's the strategy here?  We couldn't get a page for an uncached write,
> so try again as a regular cached write?

The idea is that we start with IOMAP_WRITE_F_UNCACHED set, in which case
we only do page lookup, not create. If that works, then we know that the
given page was already in the page cache. If it fails with -ENOMEM, we
store this information as IOMAP_F_PAGE_CREATE, and then clear
IOMAP_WRITE_F_UNCACHED and retry. The retry will create the page, and
now the caller knows that we had to create pages to satisfy this
write. The caller uses this information to invalidate the entire range.

Hope that explains better!

> Thanks for making the updates, it's looking better.

Thanks!

-- 
Jens Axboe

