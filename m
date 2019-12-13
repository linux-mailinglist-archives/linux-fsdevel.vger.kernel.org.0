Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6604211DB60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 01:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfLMA6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 19:58:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41755 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfLMA6B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:58:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so492104pfd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kPUFVfOVAnF2JsF7KBCO7Zshd0dUdc7irjBRYIOyMZw=;
        b=RHWYJIwiPf++l18S8H7nWplShVpnXgchNP7T5uXsv+euP1AKizc+7XgoWD7elMIoS9
         +93QAEGvIaI8iMgqA5Gi3HC2r6igfHIKSLcDpXjBRu2EKbxCKRO5QWkrbDBuvO594/zG
         tao4apYk+as3E6xLeWwLnOjRNw+1XWdwshMpSLvUx6kQbuRlNAkqddKeuQLvFTkdHbC0
         b/tDe5unV7I0ILNCJncr3xB7Lkji0cuT9+DQgcuhk2fxyzBt7Ki8z/2j5f2OKv1HYpPP
         SaLVNlvx35mgy0Ey5+NBAzwPElpJdVv78v7xqO8pX5pVs1x6lBUQouOh5rwd8ASrfVIu
         R3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPUFVfOVAnF2JsF7KBCO7Zshd0dUdc7irjBRYIOyMZw=;
        b=iAKmhAgGhLrKG/TrM6ByAJgXAGhePI5VTYVH1WA3xDtIANzbW/61VLhwQwf7DqMa3N
         2Vzn+SQ7BDI1pQbsY22ozlDIKXm37hzUs0WZ0bDHbrdRDto7L37VtKgxyiFtWacA/lGU
         u+qm6j7BS6ZijPq7/gd9jNVLf6W58HOkjyIMwIbCApZ4b46tkp1emxAIIK8ZzYECqHEY
         UmaVz1Ld7nqJY+KjWgcIrFyNLY9SuRmrBFzPUvIs6eYXSlMG5jYrvfVsuEJVzddkp601
         ruVrOaKd7J/TyFmJfCVSf+Li1LSfAke+1yTWsS4CQieAD10Eu7HOKCNE6gD8zB/TR6AR
         5dDw==
X-Gm-Message-State: APjAAAW35knDkwrESDtfamvPHMF0UMpwOQLjGXnJAyEBH6CHM9ASuiAk
        GL1QOkQjW/ijGYQ38vVp9xg5IQ==
X-Google-Smtp-Source: APXvYqyoESWHbhxbNpM9sP+Mvi0gku5Yus79Kx17lJ6LugtKZUcRGJHakDcIWfC5uCf7M+sQk4FyIw==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr12949073pfe.17.1576198680455;
        Thu, 12 Dec 2019 16:58:00 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id 133sm8538744pfy.14.2019.12.12.16.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 16:57:59 -0800 (PST)
Subject: Re: [PATCH 5/5] iomap: support RWF_UNCACHED for buffered writes
From:   Jens Axboe <axboe@kernel.dk>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org
References: <20191211152943.2933-1-axboe@kernel.dk>
 <20191211152943.2933-6-axboe@kernel.dk>
 <20191212223403.GH19213@dread.disaster.area>
 <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
Message-ID: <39af5a4d-7539-5746-ac3e-e2d6bd2209e3@kernel.dk>
Date:   Thu, 12 Dec 2019 17:57:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <df334467-9c1a-2f03-654f-58b002ea5ae4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 5:54 PM, Jens Axboe wrote:
> On 12/12/19 3:34 PM, Dave Chinner wrote:
>> On Wed, Dec 11, 2019 at 08:29:43AM -0700, Jens Axboe wrote:
>>> This adds support for RWF_UNCACHED for file systems using iomap to
>>> perform buffered writes. We use the generic infrastructure for this,
>>> by tracking pages we created and calling write_drop_cached_pages()
>>> to issue writeback and prune those pages.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  fs/iomap/apply.c       | 24 ++++++++++++++++++++++++
>>>  fs/iomap/buffered-io.c | 37 +++++++++++++++++++++++++++++--------
>>>  include/linux/iomap.h  |  5 +++++
>>>  3 files changed, 58 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
>>> index 562536da8a13..966826ad4bb9 100644
>>> --- a/fs/iomap/apply.c
>>> +++ b/fs/iomap/apply.c
>>> @@ -90,5 +90,29 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>>>  				     flags, &iomap);
>>>  	}
>>>  
>>> +	if (written && (flags & IOMAP_UNCACHED)) {
>>> +		struct address_space *mapping = inode->i_mapping;
>>> +
>>> +		end = pos + written;
>>> +		ret = filemap_write_and_wait_range(mapping, pos, end);
>>> +		if (ret)
>>> +			goto out;
>>> +
>>> +		/*
>>> +		 * No pages were created for this range, we're done
>>> +		 */
>>> +		if (!(iomap.flags & IOMAP_F_PAGE_CREATE))
>>> +			goto out;
>>> +
>>> +		/*
>>> +		 * Try to invalidate cache pages for the range we just wrote.
>>> +		 * We don't care if invalidation fails as the write has still
>>> +		 * worked and leaving clean uptodate pages in the page cache
>>> +		 * isn't a corruption vector for uncached IO.
>>> +		 */
>>> +		invalidate_inode_pages2_range(mapping,
>>> +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
>>> +	}
>>> +out:
>>>  	return written ? written : ret;
>>>  }
>>
>> Just a thought on further optimisation for this for XFS.
>> IOMAP_UNCACHED is being passed into the filesystem ->iomap_begin
>> methods by iomap_apply().  Hence the filesystems know that it is
>> an uncached IO that is being done, and we can tailor allocation
>> strategies to suit the fact that the data is going to be written
>> immediately.
>>
>> In this case, XFS needs to treat it the same way it treats direct
>> IO. That is, we do immediate unwritten extent allocation rather than
>> delayed allocation. This will reduce the allocation overhead and
>> will optimise for immediate IO locality rather than optimise for
>> delayed allocation.
>>
>> This should just be a relatively simple change to
>> xfs_file_iomap_begin() along the lines of:
>>
>> -	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) && !(flags & IOMAP_DIRECT) &&
>> -			!IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>> +	if ((flags & (IOMAP_WRITE | IOMAP_ZERO)) &&
>> +	    !(flags & (IOMAP_DIRECT | IOMAP_UNCACHED)) &&
>> +	    !IS_DAX(inode) && !xfs_get_extsz_hint(ip)) {
>> 		/* Reserve delalloc blocks for regular writeback. */
>> 		return xfs_file_iomap_begin_delay(inode, offset, length, flags,
>> 				iomap);
>> 	}
>>
>> so that it avoids delayed allocation for uncached IO...
> 
> That's very handy! Thanks, I'll add that to the next version. Just out
> of curiosity, would you prefer this as a separate patch, or just bundle
> it with the iomap buffered RWF_UNCACHED patch? I'm assuming the latter,
> and I'll just mention it in the changelog.

OK, since it's in XFS, it'd be a separate patch. The code you quote seems
to be something out-of-tree?

-- 
Jens Axboe

