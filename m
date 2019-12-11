Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2B911AE13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 15:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfLKOoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 09:44:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36983 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbfLKOoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:44:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so10883342pga.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0noKfCU616o5aJg1NtSncjkK+qcITrk9Wzz3Uuhs+4A=;
        b=XQlVEpu/5+hm1CXz95btym65Dq4nyajQDRv9dxux95XhbEsue/bHnBHeL7fH1ggIN0
         yHhblwjtfodSxqRf+9w4vJ98Oui2Qk8caPMSUNE6nd2bG83aoP9lW6wIacsAnOxoI/YU
         xEK3mLb1pjWY52mLA3PWZD1dNKQ7Gt6PuyTbm48bEEGzp7f37nh6NSFJlAQzsGOYhJ37
         P+mkfsTWErCgUjg5btdw4P9ZLcWLSvPxwaxQZ/sYeHJNReSlNHRoC/Nh2HbkfTHLkHuV
         XVoxE+HtD928lUf8hnfA8/3Q9n4R8teZ1tL05NmcpYDNtYBLCJXXF64f3t6+e34y0Co3
         rPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0noKfCU616o5aJg1NtSncjkK+qcITrk9Wzz3Uuhs+4A=;
        b=aDxzwq3MjxNYbVNgZPpOvtW6+P2D0hPxP0NLJ75FrRddJedyC20KMZ5JYIfKUuQFOg
         w1X8Q13jo2AGVMQ3OIvuz0p4alr1+7KtfAozS2l4auSyDngaLqTEfdqI6Ouv6tzQ95So
         DCebZB2B5Jf8NYH5RehZW75+bN4Y4UnoryWbPxEc8ylN8CwA0jmrpEyffP1sXxxhpCNL
         xzEVwg2emb+F1f4nrSZn03zJ04ysJc65sEKEusGyKxSbYKpd0s3D4ilA29a3NBiAbNkj
         XNkTi6gxi7PHB9RMci/ZxVzsAmOwmLusqy4PqqwuFP8Uhysq3OpoXdp1kFB3XPun24xy
         6TXw==
X-Gm-Message-State: APjAAAUbvaB6UiuI78KpJ2wS/UW7tOvKvB9jCjYrqEqewrSWfWF84b22
        f1Rfaduw4jKl2LEfqXwu/17lRg==
X-Google-Smtp-Source: APXvYqwdI1SIycFevQzMpygeUnbYBln4nwDPnIzv35OREB+DT8S/L0C/8VDiyungiINcfSF7M6Q/hw==
X-Received: by 2002:a63:c12:: with SMTP id b18mr4486272pgl.156.1576075483289;
        Wed, 11 Dec 2019 06:44:43 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id o23sm3397588pgj.90.2019.12.11.06.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 06:44:42 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com
References: <20191210204304.12266-1-axboe@kernel.dk>
 <20191210204304.12266-6-axboe@kernel.dk>
 <20191211011415.GE19213@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d69ac99-b97d-283a-213c-7bbd62c3fc15@kernel.dk>
Date:   Wed, 11 Dec 2019 07:44:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211011415.GE19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 6:14 PM, Dave Chinner wrote:
>> @@ -864,15 +896,29 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>>  			 */
>>  			bytes = min_t(unsigned long, PAGE_SIZE - offset,
>>  						iov_iter_single_seg_count(i));
>> +			if (drop_page)
>> +				put_page(page);
>>  			goto again;
>>  		}
>> +
>> +		if (drop_page &&
>> +		    ((pos >> PAGE_SHIFT) != ((pos + copied) >> PAGE_SHIFT))) {
>> +			if (!pagevec_add(&pvec, page))
>> +				write_drop_cached_pages(&pvec, mapping);
>> +		} else {
>> +			if (drop_page)
>> +				put_page(page);
>> +			balance_dirty_pages_ratelimited(inode->i_mapping);
>> +		}
> 
> This looks like it's a problem: this is going to write the
> data, which can cause the extent mapping of the file to change
> beyond the range that was written (e.g. due to speculative delayed
> allocation) and so the iomap we have already cached to direct write
> behaviour may now be stale.
> 
> IOWs, to be safe we need to terminate the write loop at this point,
> return to iomap_apply() and remap the range we are writing into so
> that we don't end up using a stale iomap. That kinda defeats the
> purpose of iomap - we are trying to do a single extent mapping per
> IO instead of per-page, and this pulls it back to an iomap per 16
> pages for large user IOs. And it has the issues with breaking
> delayed allocation optimisations, too.
> 
> Hence, IMO, this is the wrong layer in iomap to be dealing with
> writeback and cache residency for uncached IO. We should be caching
> residency/invalidation at a per-IO level, not a per-page level.
> 
> Sure, have the write actor return a flag (e.g. in the iomap) to say
> that it encountered cached pages so that we can decide whether or
> not to invalidate the entire range we just wrote in iomap_apply, but
> doing it between mappings in iomap_apply means that the writeback is
> done once per user IO, and cache invalidation only occurs if no
> cached pages were encountered during that IO. i.e. add this to
> iomap_apply() after ops->iomap_end() has been called:
> 
> 
> 	if (flags & RWF_UNCACHED) {
> 		ret = filemap_write_and_wait_range(mapping, start, end);
> 		if (ret)
> 			goto out;
> 
> 		if (!drop_cache)
> 			goto out;
> 
> 		/*
> 		 * Try to invalidate cache pages for the range we
> 		 * just wrote. We don't care if invalidation fails
> 		 * as the write has still worked and leaving clean
> 		 * uptodate pages * in the page cache isn't a
> 		 * corruption vector for uncached IO.
> 		 */
> 		invalidate_inode_pages2_range(mapping,
> 				start >> PAGE_SHIFT, end >> PAGE_SHIFT);
> 	}
> out:
> 	return written ? written : ret;
> }

I really like this, and some variant of that solution can also be
applied to the non-iomap case. It'll make for a cleaner implementation
as well.

Once we do it per-write we'll have solved the performance and iomap
weirdness, but it does mean that we need to make a decision on when to
invalidate. For the per-page case it's clear - if the page is already
there, leave it. If not, (attempt to) kill it. For the full write range,
what if just one page was not there? Do we invalidate then? What if one
page was there?

I'm going to move forward with the notion that if we had to allocate any
page in the range, we invalidate the range. Only ranges that were fully
cached already will remain in the cache. I think those semantics make
the most sense.

> Note that this doesn't solve the write error return issue. i.e.
> if filemap_write_and_wait_range() fails, should that error be
> returned or ignored?

I think we should handle this exactly like we do the O_DIRECT case on
buffered IO write-and-wait.

> And that leads to my next question: what data integrity guarantees
> does RWF_UNCACHED give? What if the underlying device has a volatile
> write cache or we dirtied metadata during block allocation? i.e.  to
> a user, "UNCACHED" kinda implies that the write has ended up on
> stable storage because they are saying "do not cache this data". To
> me, none of this implementation guarantees data integrity, and users
> would still need O_DSYNC or fsync() with RWF_UNCACHED IO. That seems
> sane to me (same as direct io requirements) but whatever is decided
> here, it will need to be spelled out clearly in the man page so that 
> users don't get it wrong.

Fully agree, this isn't about data integrity guarantees. You will still
need the appropriate sync magic to make it safe. This is exactly like
O_DIRECT, and I think we should retain those exact same semantics for
the RWF_UNCACHED case.

Thanks for taking a look at this! I'll respin (and re-test) with the
write side changed.

-- 
Jens Axboe

