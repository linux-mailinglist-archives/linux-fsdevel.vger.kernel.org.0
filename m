Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F23122EC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 15:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfLQOby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 09:31:54 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35222 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbfLQOby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:31:54 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so8545695ild.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 06:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bsXy6SvaefOblWZ7i+cRbd52GZJJY4c/N9MWt4fO6hM=;
        b=dQAfDBIa6KdyhQR1JhfYH5r8FnzApSR7zFzmXI6tJnxw7kRQjQORP3f/LjZYm8OTax
         IlASVyxh/jsMpTWY5QFPigvcxbuXOT9FR3oI98951x7amL28QEchi7CmhDDHq2emKdj4
         k2rF0y80sCpjz1xmM5rIR7v673osGST0EY9lTCVni6HZpEvpZ9cXTEqR64S/F2Dxzbdd
         68akArwvS6GvG7jz7LcjkrCgYt+BYF9rG2kxkLjQpL1TRsmsUK4f23rsoax0ULUo4xgR
         TzGRWlC0wvEsPvQ+rEUe3x5U+oL06L6wt+snY0ITYVJn0B7xiQmFJdV9gQBlztA4sWBi
         LBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsXy6SvaefOblWZ7i+cRbd52GZJJY4c/N9MWt4fO6hM=;
        b=qsBmUjXDv6ABeO3su4F6MVrwG+eCEK7So2CrloycWxFMwA21ARdZG3bUHzAygR1Yae
         F09I/IcrM1S9gP1X56QX31bgRMOM5H7Jh1RQFKlNOEhCT6BuwSBe+Sn/sf+jwMXzsycL
         XeneKmDoMFprBEGWtbwdVYW09Ine5WCKynD8SqpuAi+xYh+GjGJeE4AjQQPcDV3ZCPwd
         swxCEK5zPFG5hVygDw6gveC/BRoxdep6zcJ7v8Cuk8ty2r2g4ElDTIXqILPhIAskgFaG
         bn87B/WWic8eAA74uCsSkr9Sglj5ri2uUMeM1DmZrsjZh4BU31PA+dxB6y37/2d/Ftfd
         VNlw==
X-Gm-Message-State: APjAAAVAe2ETTAeRykMm71B2DHrharJ4/uNsKNrj/LGJJnwtq00LknLX
        xEqdykkSvMxroNB9nQywdjo3Nz7eJuoI/Q==
X-Google-Smtp-Source: APXvYqwbvr81EBtNyIasUiB3NONxnvXQnDe+GMchwxM37nCo9y4U19JRorUXjgn8z6ch1pN7a+0KHA==
X-Received: by 2002:a92:4095:: with SMTP id d21mr16529615ill.158.1576593113136;
        Tue, 17 Dec 2019 06:31:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m27sm2636891ilb.53.2019.12.17.06.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 06:31:52 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191212223403.GH19213@dread.disaster.area>
 <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
 <39af5a4d-7539-5746-ac3e-e2d6bd2209e3@kernel.dk>
 <20191216041748.GL19213@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a30113f7-2d5a-3adf-19c4-fe49e8ef1ae8@kernel.dk>
Date:   Tue, 17 Dec 2019 07:31:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216041748.GL19213@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/15/19 9:17 PM, Dave Chinner wrote:
> On Thu, Dec 12, 2019 at 05:57:57PM -0700, Jens Axboe wrote:
>> On 12/12/19 5:54 PM, Jens Axboe wrote:
>>> On 12/12/19 3:34 PM, Dave Chinner wrote:
>>>> On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
>>>>> This adds support for RWF_UNCACHED for file systems using iomap to
>>>>> perform buffered writes. We use the generic infrastructure for this,
>>>>> by tracking pages we created and calling write_drop_cached_pages()
>>>>> to issue writeback and prune those pages.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>>>>>  fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++--------
>>>>>  include/linux/iomap.h  |  5 +++++
>>>>>  3 files changed, 58 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
>>>>> index 562536da8a13..966826ad4bb9 100644
>>>>> --- a/fs/iomap/apply.c
>>>>> +++ b/fs/iomap/apply.c
>>>>> @@ -90,5 +90,29 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>>>>>  				     flags, &iomap);
>>>>>  	}
>>>>>  
>>>>> +	if (written && (flags & IOMAP_UNCACHED)) {
>>>>> +		struct address_space *mapping = inode->i_mapping;
>>>>> +
>>>>> +		end = pos + written;
>>>>> +		ret = filemap_write_and_wait_range(mapping, pos, end);
>>>>> +		if (ret)
>>>>> +			goto out;
>>>>> +
>>>>> +		/*
>>>>> +		 * No pages were created for this range, we're done
>>>>> +		 */
>>>>> +		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
>>>>> +			goto out;
>>>>> +
>>>>> +		/*
>>>>> +		 * Try to invalidate cache pages for the range we just wrote.
>>>>> +		 * We don't care if invalidation fails as the write has still
>>>>> +		 * worked and leaving clean uptodate pages in the page cache
>>>>> +		 * isn't a corruption vector for uncached IO.
>>>>> +		 */
>>>>> +		invalidate_inode_pages2_range(mapping,
>>>>> +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>>>>> +	}
>>>>> +out:
>>>>>  	return written ? written : ret;
>>>>>  }
>>>>
>>>> Just a thought on further optimisation for this for XFS.
>>>> IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
>>>> methods by iomap_apply().  Hence the filesystems know that it is
>>>> an uncached IO that is being done, and we can tailor allocation
>>>> strategies to suit the fact that the data is going to be written
>>>> immediately.
>>>>
>>>> In this case, XFS needs to treat it the same way it treats direct
>>>> IO. That is, we do immediate unwritten extent allocation rather than
>>>> delayed allocation. This will reduce the allocation overhead and
>>>> will optimise for immediate IO locality rather than optimise for
>>>> delayed allocation.
>>>>
>>>> This should just be a relatively simple change to
>>>> xfs_file_iomap_begin() along the lines of:
>>>>
>>>> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
>>>> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>>>> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
>>>> +	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
>>>> +	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>>>> 		/* Reserve delalloc blocks for regular writeback. */
>>>> 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
>>>> 				iomap);
>>>> 	}
>>>>
>>>> so that it avoids delayed allocation for uncached IO...
>>>
>>> That's very handy! Thanks, I'll add that to the next version. Just out
>>> of curiosity, would you prefer this as a separate patch, or just bundle
>>> it with the iomap buffered RWF_UNCACHED patch? I'm assuming the latter,
>>> and I'll just mention it in the changelog.
>>
>> OK, since it's in XFS, it'd be a separate patch.
> 
> *nod*
> 
>> The code you quote seems
>> to be something out-of-tree?
> 
> Ah, I quoted the code in the 5.4 release branch, not the 5.5-rc1
> tree. I'd forgotten that the xfs_file_iomap_begin() got massively
> refactored in the 5.5 merge and I hadn't updated my cscope trees. SO
> I'm guessing you want to go looking for the
> xfs_buffered_write_iomap_begin() and add another case to this
> initial branch:
> 
>         /* we can't use delayed allocations when using extent size hints */
>         if (xfs_get_extsz_hint(ip))
>                 return xfs_direct_write_iomap_begin(inode, offset, count,
>                                 flags, iomap, srcmap);
> 
> To make the buffered write IO go down the direct IO allocation path...

Makes it even simpler! Something like this:


commit 1783722cd4b7088a3c004462c7ae610b8e42b720
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Dec 17 07:30:04 2019 -0700

    xfs: don't do delayed allocations for uncached buffered writes
    
    This data is going to be written immediately, so don't bother trying
    to do delayed allocation for it.
    
    Suggested-by: Dave Chinner <david@fromorbit.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 28e2d1f37267..d0cd4a05d59f 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -847,8 +847,11 @@ xfs_buffered_write_iomap_begin(
 	int			allocfork = XFS_DATA_FORK;
 	int			error = 0;
 
-	/* we can't use delayed allocations when using extent size hints */
-	if (xfs_get_extsz_hint(ip))
+	/*
+	 * Don't do delayed allocations when using extent size hints, or
+	 * if we were asked to do uncached buffered writes.
+	 */
+	if (xfs_get_extsz_hint(ip) || (flags & IOMAP_UNCACHED))
 		return xfs_direct_write_iomap_begin(inode, offset, count,
 				flags, iomap, srcmap);
 

-- 
Jens Axboe

