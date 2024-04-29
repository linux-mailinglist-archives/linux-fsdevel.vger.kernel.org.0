Return-Path: <linux-fsdevel+bounces-18111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 732038B5C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948911C21575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F2811E9;
	Mon, 29 Apr 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nF39WmpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F87EEE3;
	Mon, 29 Apr 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402787; cv=none; b=jKYJxxBsq/v3XYo4DXlewtt/k4PCovd/TOlERM/L3lieM3x3kRTEhNQ8R2E562yxaEXKPiPdBYa7F/Ek+zZgIRa5eKB7uE09aNXXDsnoumW4JA961pO3xWK5aPswp+lft61R3uIIrnJ1Nx4Qe/FYGCp42Igixc89UuszfVUKq8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402787; c=relaxed/simple;
	bh=B8vjlOZiqRrOg81+lbAx47cYya0urA5P44QLkl8RbAw=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=VQyvlGzx+M9C4LutqwayTxXHWEs14CGGvY9/kgNz3lOTEWr9NhH3h6Pjzv5h+2waQF3aXU+cf8VAAzadPmAL2a5qvEsY6lB7fdcLK9Wln0i9X2LMF85wcUVhPS0MhIZR8nttYv7PjZsIK6xWeSLX2HLIUQjY3o4GkU8Bali5q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nF39WmpM; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso4056436b3a.2;
        Mon, 29 Apr 2024 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714402786; x=1715007586; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2i2h/fU62HBi0Yob2v06SoPeokjr50XNhm9YQdF1O4=;
        b=nF39WmpMKRHKLWReGnwNaJkDn7q+YHhE6mNNqFBNmtwPZ27utw7nsOczm8cg82vrr0
         d4lYiOBqbv2cm6ic8qXMnT+qNxK69zZ8eBWzY50KMvTdFh+ihU2w81HqyrU1BWpxToIz
         aeob/2Pa27CQBznViQMtUmY5ybmH8RFAx6gEWMZvjF7MofQlRWdm/8AkMrVtbJuX6yG9
         9dhBz6D7LcE4+QOkTb1wa/rfIaFTIlX4gh6mSngjZvWbL0cagSVQ6aSsOxsnJis0Wchw
         Tva+9uXh/FreaLogcUmD1p/4Kt8xDu6EjOUrMWlTIDiRkC0ByyIMon8iX/D2dOQmTRBU
         KnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402786; x=1715007586;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2i2h/fU62HBi0Yob2v06SoPeokjr50XNhm9YQdF1O4=;
        b=Y0w1YWGDuDybzJjCKnGAz38KL5BBavdhm9hgdZr814QvEsp8W1WVvpl3fo3Qp0ViM8
         aYLCaQ3T5A14mKle8wPPczR7dIPJFaYoamm6NpJCLVCi57FnsApiv5c8Y/mtGbJ+dU7C
         U2R56oR8m0DpNs0ptQp6dmazYHIvq3iuzbXR9wrK4l0e0oUtY0Nah+MQBnoLQahBvhgF
         tZI5P73GsiVQglDv6mbReEd2gTCG+Z9pAoLdgkJyH29L7jDeFvKaEjsERjfRaYFl9zQt
         H8tdy2D9NxtrXA6abLXyLd8SuE2H4BBCddC33tl8u2NncVS8PVaXoqMGQPygF3JCikZF
         xP6g==
X-Forwarded-Encrypted: i=1; AJvYcCXRQf1UGZNons+heP0lhnK0zkyB3r9NM8xy6a4xIFjhbknJlAqvGRZc3vlfxu0f/HJe3dw63nG4mTdZPFYRPXG29stZgGQzBExLlsGkiOmxawN3dNKc+F/qXJNW1QOnT5KONpE9ID4vww==
X-Gm-Message-State: AOJu0Yz8JFIp/yU9p8kGZV89Y2yrL0yfYb4DoRw94tmk/ipQSWS6nY2c
	9Q3/5/LNsLMLA6SBjqFBKGPpbAOKDuYa9W2fCEwPj+9ou8hoLCuk
X-Google-Smtp-Source: AGHT+IFrQ4pzYZvOZbN3sE0v0c88khjAywVfp5oa41UWydT1M8w695R8CfnRvziWkYDWRWB95h5gNg==
X-Received: by 2002:a05:6a20:748b:b0:1a7:7358:f111 with SMTP id p11-20020a056a20748b00b001a77358f111mr14510571pzd.31.1714402785678;
        Mon, 29 Apr 2024 07:59:45 -0700 (PDT)
Received: from dw-tp ([171.76.84.250])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902a70c00b001e45c0d6be6sm20463521plq.246.2024.04.29.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:59:45 -0700 (PDT)
Date: Mon, 29 Apr 2024 20:29:38 +0530
Message-Id: <87o79sxlid.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <3243c67d-e783-4ec5-998f-0b6170f36e35@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> On 2024/4/27 0:39, Ritesh Harjani (IBM) wrote:
>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>> 
>>> On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
>>>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>>>>
>>>>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>>>>
>>>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>>>
>>>>>> Now we lookup extent status entry without holding the i_data_sem before
>>>>>> inserting delalloc block, it works fine in buffered write path and
>>>>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>>>>>> lock, so the found extent locklessly couldn't be modified concurrently.
>>>>>> But it could be raced by fallocate since it allocate block whitout
>>>>>> holding i_rwsem and folio lock.
>>>>>>
>>>>>> ext4_page_mkwrite()             ext4_fallocate()
>>>>>>  block_page_mkwrite()
>>>>>>   ext4_da_map_blocks()
>>>>>>    //find hole in extent status tree
>>>>>>                                  ext4_alloc_file_blocks()
>>>>>>                                   ext4_map_blocks()
>>>>>>                                    //allocate block and unwritten extent
>>>>>>    ext4_insert_delayed_block()
>>>>>>     ext4_da_reserve_space()
>>>>>>      //reserve one more block
>>>>>>     ext4_es_insert_delayed_block()
>>>>>>      //drop unwritten extent and add delayed extent by mistake
>>>>>>
>>>>>> Then, the delalloc extent is wrong until writeback, the one more
>>>>>> reserved block can't be release any more and trigger below warning:
>>>>>>
>>>>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>>>>>
>>>>>> Hold i_data_sem in write mode directly can fix the problem, but it's
>>>>>> expansive, we should keep the lockless check and check the extent again
>>>>>> once we need to add an new delalloc block.
>>>>>
>>>>> Hi Zhang, 
>>>>>
>>>>> It's a nice finding. I was wondering if this was caught in any of the
>>>>> xfstests?
>>>>>
>>>
>>> Hi, Ritesh
>>>
>>> I caught this issue when I tested my iomap series in generic/344 and
>>> generic/346. It's easy to reproduce because the iomap's buffered write path
>>> doesn't hold folio lock while inserting delalloc blocks, so it could be raced
>>> by the mmap page fault path. But the buffer_head's buffered write path can't
>>> trigger this problem,
>> 
>> ya right! That's the difference between how ->map_blocks() is called
>> between buffer_head v/s iomap path. In iomap the ->map_blocks() call
>> happens first to map a large extent and then it iterate over all the
>> locked folios covering the mapped extent for doing writes.
>> Whereas in buffer_head while iterating, we first instantiate/lock the
>> folio and then call ->map_blocks() to map an extent for the given folio.
>> 
>> ... So this opens up this window for a race between iomap buffered write
>> path v/s page mkwrite path for inserting delalloc blocks entries.
>> 
>>> the race between buffered write path and fallocate path
>>> was discovered while I was analyzing the code, so I'm not sure if it could
>>> be caught by xfstests now, at least I haven't noticed this problem so far.
>>>
>> 
>> Did you mean the race between page fault path and fallocate path here?
>> Because buffered write path and fallocate path should not have any race
>> since both takes the inode_lock. I guess you meant page fault path and
>> fallocate path for which you wrote this patch too :)
>
> Yep.
>
>> 
>> I am surprised, why we cannot see the this race between page mkwrite and
>> fallocate in fstests for inserting da entries to extent status cache.
>> Because the race you identified looks like a legitimate race and is
>> mostly happening since ext4_da_map_blocks() was not doing the right
>> thing.
>> ... looking at the src/holetest, it doesn't really excercise this path.
>> So maybe we can writing such fstest to trigger this race.
>> 
>
> I guess the stress tests and smoke tests in fstests have caught it,
> e.g. generic/476. Since there is only one error message in ext4_destroy_inode()
> when the race issue happened, we can't detect it unless we go and check the logs
> manually.

Hi Zhang,

I wasn't able to reproduce the any error messages with generic/476.

>
> I suppose we need to add more warnings, something like this, how does it sound?
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c8b691e605f1..4b6fd9b63b12 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1255,6 +1255,8 @@ static void ext4_percpu_param_destroy(struct ext4_sb_info *sbi)
>  	percpu_counter_destroy(&sbi->s_freeclusters_counter);
>  	percpu_counter_destroy(&sbi->s_freeinodes_counter);
>  	percpu_counter_destroy(&sbi->s_dirs_counter);
> +	WARN_ON_ONCE(!ext4_forced_shutdown(sbi->s_sb) &&
> +		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
>  	percpu_counter_destroy(&sbi->s_dirtyclusters_counter);
>  	percpu_counter_destroy(&sbi->s_sra_exceeded_retry_limit);
>  	percpu_free_rwsem(&sbi->s_writepages_rwsem);
> @@ -1476,7 +1478,8 @@ static void ext4_destroy_inode(struct inode *inode)
>  		dump_stack();
>  	}
>
> -	if (EXT4_I(inode)->i_reserved_data_blocks)
> +	if (!ext4_forced_shutdown(inode->i_sb) &&
> +	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>  		ext4_msg(inode->i_sb, KERN_ERR,
>  			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			 inode->i_ino, EXT4_I(inode),
>

I also ran ext4 -g auto and I couldn't reproduce anything with above
patch. Please note that I didn't use this patch series for testing. I was running
xfstests on upstream kernel with above diff (because that's what the
idea was that the problem even exists in upstream kernel and are we able
to observe the race with page mkwrite and fallocate path)

-ritesh

>
> Thanks,
> Yi.
>
>> 
>>>>> I have reworded some of the commit message, feel free to use it if you
>>>>> think this version is better. The use of which path uses which locks was
>>>>> a bit confusing in the original commit message.
>>>>>
>>>
>>> Thanks for the message improvement, it looks more clear then mine, I will
>>> use it.
>>>
>> 
>> Glad, it was helpful.
>> 
>> -ritesh
>> 

