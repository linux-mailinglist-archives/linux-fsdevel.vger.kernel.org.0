Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB23111ADCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 15:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfLKOj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 09:39:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33267 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfLKOjZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:39:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so10881491pgk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JIZ0Z2kz72zIQNA6G4bYzFn40yhbQ+MQB3rkdPMRBVA=;
        b=ItJvVAGSLpP2Qi+JlwGHdyO1sjXtP2FS1mtHFHhX0wx1Yd51DPvWT7RxgPM5kfmFl2
         z5h+0QPmcrpRx8D481hiFimlEXuB5e3/Q6Mh5auXLERPFLAXVjjcMTLPfVAJyc4iOcMu
         NAkddftDmeAyKALkUXIbLZnXkhOA/BzyOz2aSS6ZWODXr2fObOUeB9Pxrul75Zw5LO3o
         fmvHxpomY5OKDtxH7sLGXx4OFI2EsHcqHnjaG5I9VQpCzMCU0anGQuibyLwlqOFDNEqY
         NIoPj5cAsWz3bed/Ph/aApEzac2HTpk/om2JSCJPmteYqBbDC4EpQIDy1A4FoTYmNhxv
         iVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JIZ0Z2kz72zIQNA6G4bYzFn40yhbQ+MQB3rkdPMRBVA=;
        b=fOVmqT8lnbVMLbzCcTsSXHoAQVoPHBwFGqPAK47JdrvE8wLgV/25SyQxsJJn8A7B/v
         Rd5SQjJr2zyJaIQhCFa6Q00339sVorqVXSWlm8ML6cgKEajCAXXC2IQ5KLfZVuM1qaIe
         EfAmSbjTL4MvMG5G2ojXHqbRHr5gyYuch63ehzf2r5cX53ZaKsMyptcPMbekdi1TFfOT
         rW/ztasWJRpedn5mQOLMok/wCMxwfhIwKVzkhyoACCe6J8GKrG65uq7FxmtOL7/IRpmh
         r3ckzBYhgaCuTJr+9WlgwyrmpQ/kx51RkDOZ320sTEzXYPYFadj+cgF0Ra9LUI6n1ar6
         7reg==
X-Gm-Message-State: APjAAAUeNKxDMirzD/zRx17xXZvFcSk6d/GWsQpopwPDradxm+5G04fD
        oZcdLyH7URnOGRklXynTOC17tA==
X-Google-Smtp-Source: APXvYqyGeiGi1rdrfdXNO/icOwO5gEDSo2Gr7BxhF5G7xiGB1lEMbNYINxHWG76c4XmZgIber6/vfA==
X-Received: by 2002:a63:ce4b:: with SMTP id r11mr4616880pgi.419.1576075164601;
        Wed, 11 Dec 2019 06:39:24 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id x197sm3578266pfc.1.2019.12.11.06.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:39:23 -0800 (PST)
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191211002349.GC19213@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc595f20-fe12-8b9d-a7d5-53ac4ce6e108@kernel.dk>
Date:   Wed, 11 Dec 2019 07:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211002349.GC19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 5:23 PM, Dave Chinner wrote:
> On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
>> If RWF_UNCACHED is set for io_uring (or pwritev2(2)), we'll drop the
>> cache instantiated for buffered writes. If new pages aren't
>> instantiated, we leave them alone. This provides similar semantics to
>> reads with RWF_UNCACHED set.
> 
> So what about filesystems that don't use generic_perform_write()?
> i.e. Anything that uses the iomap infrastructure (i.e.
> iomap_file_buffered_write()) instead of generic_file_write_iter())
> will currently ignore RWF_UNCACHED. That's XFS and gfs2 right now,
> but there are likely to be more in the near future as more
> filesystems are ported to the iomap infrastructure.

I'll skip this one as you found it.

> I'd also really like to see extensive fsx and fstress testing of
> this new IO mode before it is committed - this is going to exercise page
> cache coherency across different operations in new and unique
> ways. that means we need patches to fstests to detect and use this
> functionality when available, and new tests that explicitly exercise
> combinations of buffered, mmap, dio and uncached for a range of
> different IO size and alignments (e.g. mixing sector sized uncached
> IO with page sized buffered/mmap/dio and vice versa).
> 
> We are not going to have a repeat of the copy_file_range() data
> corruption fuckups because no testing was done and no test
> infrastructure was written before the new API was committed.

Oh I totally agree, and there's no push from my end on this. I just
think it's a cool feature and could be very useful, but it obviously
needs a healthy dose of testing and test cases written. I'll be doing
that as well.

>> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
>> +			     unsigned *nr)
>> +{
>> +	loff_t start, end;
>> +	int i;
>> +
>> +	end = 0;
>> +	start = LLONG_MAX;
>> +	for (i = 0; i < *nr; i++) {
>> +		struct page *page = pgs[i];
>> +		loff_t off;
>> +
>> +		off = (loff_t) page_to_index(page) << PAGE_SHIFT;
>> +		if (off < start)
>> +			start = off;
>> +		if (off > end)
>> +			end = off;
>> +		get_page(page);
>> +	}
>> +
>> +	__filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
>> +
>> +	for (i = 0; i < *nr; i++) {
>> +		struct page *page = pgs[i];
>> +
>> +		lock_page(page);
>> +		if (page->mapping == mapping) {
>> +			wait_on_page_writeback(page);
>> +			if (!page_has_private(page) ||
>> +			    try_to_release_page(page, 0))
>> +				remove_mapping(mapping, page);
>> +		}
>> +		unlock_page(page);
>> +	}
>> +	*nr = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(write_drop_cached_pages);
>> +
>> +#define GPW_PAGE_BATCH		16
> 
> In terms of performance, file fragmentation and premature filesystem
> aging, this is also going to suck *really badly* for filesystems
> that use delayed allocation because it is going to force conversion
> of delayed allocation extents during the write() call. IOWs,
> it adds all the overheads of doing delayed allocation, but it reaps
> none of the benefits because it doesn't allow large contiguous
> extents to build up in memory before physical allocation occurs.
> i.e. there is no "delayed" in this allocation....
> 
> So it might work fine on a pristine, empty filesystem where it is
> easy to find contiguous free space accross multiple allocations, but
> it's going to suck after a few months of production usage has
> fragmented all the free space into tiny pieces...

I totally agree on this one, and I'm not a huge fan of it. But
considering your suggestion in the other email, I think we just need to
move this up a notch and do it per-write instead. If we can pass back
information about the state of the page cache for the range we care
about, then there's no reason to do it per-page for the write case.
Reads are still best done that way, and we can avoid the LRU overhead by
doing it that way.

-- 
Jens Axboe

