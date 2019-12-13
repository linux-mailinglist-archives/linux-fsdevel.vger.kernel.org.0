Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3993311DB50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 01:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLMAyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 19:54:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41382 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfLMAyi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:54:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so484996pfd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 16:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NjQPeu/vo29w3hIHTst+tVVX7bZ4rYaCd8S/G0yNofM=;
        b=qpOOX0t6YughmSV7gUyfrpa+/bs3NbDWusKWxMdnj5PoWznexOHmdM1qXfh5Sf5gvq
         rtnWRiaUisKf2g1Sf/A1yH5JIBW+uMB0eldVfaQ42mnVHraq0TYqhBT9pqWSUCq4RWV+
         689hbSmLhOYq4Gw64jmB5Rt5bFZz8MVOb+uig+anOk/+KBb8waekdHRqkCz3aO2I1Uic
         h20b3XO5jR8ygUiDkXiKz2ykL2DWyL/iqi2ELGCeGFWcctRv73C8PZDy4KsAEes8N+nn
         LhYZuJmNVTU2MFcV8RHL2GNmXiQUhO0qXB0rH7NCmh3sLVWk06wwy6bHkxTBLKkBo4zH
         6lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NjQPeu/vo29w3hIHTst+tVVX7bZ4rYaCd8S/G0yNofM=;
        b=hQKO28c8h6v1fCJEwRkpoYYRt1IM5u1ij5YH8YTsjMBwMqmnN2yJ0NCAxFKQEdjESt
         cz4oIpLqq6P91WYlueUICd3MG06qKeu9qmI1LKvnkYvTZ66pWUUR1tIMrRc/cWb9WSSg
         p7yq5a444IpTfy+tDsfqgxDjs5dvuGWUE9lc6vDkCbJgi6ezfo1E0S9q2eGPtRsh4laE
         JsozxDiOL2hZtka0RjSFoM4DwUdFCniCNMfjATmyAm+dfFdAJUUPbEcMoGhFMBtMKjov
         63aMppilBN6NDoNW8FQx003RpNmwMQ1G0m4NqAySago+EFVPAIjESi2GBikx8NgLxUvZ
         zinw==
X-Gm-Message-State: APjAAAWm8ZAer7EnwK3vwGPRYMnTBa4IOSGmobq31EDLf7HP/rbwultS
        9NOywaCeCBO2vt6PE1ji3HNo3w==
X-Google-Smtp-Source: APXvYqxqLyVS4a+7wMFi2zN5Ek7Z4qqBXZe3zrCV2/Z4xLk+vaM786UcrliEOJJYj86ew0pkXN+f0w==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr13080249pgc.19.1576198477803;
        Thu, 12 Dec 2019 16:54:37 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id w5sm8156901pgb.78.2019.12.12.16.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:54:36 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191212223403.GH19213@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
Date:   Thu, 12 Dec 2019 17:54:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212223403.GH19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 3:34 PM, Dave Chinner wrote:
> On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
>> This adds support for RWF_UNCACHED for file systems using iomap to
>> perform buffered writes. We use the generic infrastructure for this,
>> by tracking pages we created and calling write_drop_cached_pages()
>> to issue writeback and prune those pages.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>>  fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++--------
>>  include/linux/iomap.h  |  5 +++++
>>  3 files changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
>> index 562536da8a13..966826ad4bb9 100644
>> --- a/fs/iomap/apply.c
>> +++ b/fs/iomap/apply.c
>> @@ -90,5 +90,29 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>>  				     flags, &iomap);
>>  	}
>>  
>> +	if (written && (flags & IOMAP_UNCACHED)) {
>> +		struct address_space *mapping = inode->i_mapping;
>> +
>> +		end = pos + written;
>> +		ret = filemap_write_and_wait_range(mapping, pos, end);
>> +		if (ret)
>> +			goto out;
>> +
>> +		/*
>> +		 * No pages were created for this range, we're done
>> +		 */
>> +		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
>> +			goto out;
>> +
>> +		/*
>> +		 * Try to invalidate cache pages for the range we just wrote.
>> +		 * We don't care if invalidation fails as the write has still
>> +		 * worked and leaving clean uptodate pages in the page cache
>> +		 * isn't a corruption vector for uncached IO.
>> +		 */
>> +		invalidate_inode_pages2_range(mapping,
>> +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>> +	}
>> +out:
>>  	return written ? written : ret;
>>  }
> 
> Just a thought on further optimisation for this for XFS.
> IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
> methods by iomap_apply().  Hence the filesystems know that it is
> an uncached IO that is being done, and we can tailor allocation
> strategies to suit the fact that the data is going to be written
> immediately.
> 
> In this case, XFS needs to treat it the same way it treats direct
> IO. That is, we do immediate unwritten extent allocation rather than
> delayed allocation. This will reduce the allocation overhead and
> will optimise for immediate IO locality rather than optimise for
> delayed allocation.
> 
> This should just be a relatively simple change to
> xfs_file_iomap_begin() along the lines of:
> 
> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
> +	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
> +	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
> 		/* Reserve delalloc blocks for regular writeback. */
> 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
> 				iomap);
> 	}
> 
> so that it avoids delayed allocation for uncached IO...

That's very handy! Thanks, I'll add that to the next version. Just out
of curiosity, would you prefer this as a separate patch, or just bundle
it with the iomap buffered RWF_UNCACHED patch? I'm assuming the latter,
and I'll just mention it in the changelog.

-- 
Jens Axboe

