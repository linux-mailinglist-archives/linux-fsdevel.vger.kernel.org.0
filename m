Return-Path: <linux-fsdevel+bounces-17893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224E8B3793
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 14:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40411F2291A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 12:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24130146D43;
	Fri, 26 Apr 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irte/VU8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51F13D500;
	Fri, 26 Apr 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136263; cv=none; b=fSwML+u4HuycwgQaos22dQ9D1b+4Y/MkPrlkavqdtZKt0fF/9Mw02D+M1/xONMUYmn3hjTdKz0aQipSqWYYUVvSI91fD18/9C0VqAH49pKFe8MGfgybbRl0dgiJx40AcL7vun61gT6QCtwGPWwRTYKBLHPgtL4sUDvM3OE6XmSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136263; c=relaxed/simple;
	bh=fHszdicZzvlPouapKh0LnGP2m9geUO4FdHcDyOTbn3o=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=E6vFXWaobDoxLkWCW2B8oCHyZKR8FzOvoeXgnKwtQD0j032Uy0RxQStI6Yrs/+HYZ/Md9vVpjDlUvKTKLKvP3OsTycvd1l+9ip7y54ktMmC5+79aM65ulqcv9AxcVXFzahe113O7TrctAN0GHh4m5m8kkhHSd0T8/OhjXY88UdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irte/VU8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1762084a12.3;
        Fri, 26 Apr 2024 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714136261; x=1714741061; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=endWZFs/huUwpiPXnvyhJNr3iwSnVQvC+T17t46UJ4o=;
        b=irte/VU8y9BjJTSwwf2KYeipvVjTGRIWiVox4HYUuibr3z6KGX0bHzlPaBeF8MN04y
         twEl6AfSpaGz2B15cOm/ibY90kIA6bkVpWmzNcWoYJ8OxX/MeW8QBJw42pGfCBUXmwLs
         if7x+g2j5TFnWhhtzU6BunYMwz24qoFPfwhVQgEttkt577HAMl9uYaxmBgU0cu6L40MX
         NHmKuCMKuA3wEGFsCWhHaUjKMFlZLH5C4z4zeNZffzbSH2BwMppWPxxD/j9NBFqTcay5
         x1mBdNnF3FKOPm1NtMNzteWZgRAw9IohKdtWPPQtkBaPpnNurdVahFp4iBMvBptUPHIw
         Mlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714136261; x=1714741061;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=endWZFs/huUwpiPXnvyhJNr3iwSnVQvC+T17t46UJ4o=;
        b=WFluaFsIckIb79Fa/zWYHJYjeVrJ32RGxSgmGisKCskVsslBdCLTMIfYocnM1tUELW
         BQShPTSC7vnESMyh29xAk2Q/02WrFFThFm2GK8cKGsBazBYSsnvk5/7pmRey8HLTYFln
         8SnrHJmP+WII8HWPaZNrnc5EIkv8i6yiyoVGr/QBs//tKUPFqU4aHC6tj5chpz5lR8uV
         Qc/BDgrc/OSTPcPle8jS7DJ/Vb15ERkkwPhiD7jwSCKZLl0D9l6ohzhCCOCbv2qjQ5Oi
         btOS/Ar8Uo39DaW44j8NkV+4CxQ7aPk0MUdwSdN+cS4NIWLb2JSpX80uu8FydJ/EujO1
         mk8g==
X-Forwarded-Encrypted: i=1; AJvYcCWI1xe7kjsGgKR/7MfjZvR4oLwZyoXIzqUDJUwOdF+8FG+090VDy7dHExmAYiLzQH3/K0wC75zOlX1H9tGqAr3Pp0opHPaxLZUP65IXOoLmqdCwlXky3CtJyNRs6dg+TmZGeVhEPsHL7Q==
X-Gm-Message-State: AOJu0YwvkAKAJ2ck5qTWlR3b24kE1MINV9a7PV6junVWLUNWfYAcqm4D
	ZaNBLvvIjzXBBtIzTZMZBNAI2qEh3SDJIQbrRYL2MVQM08pFfOJh
X-Google-Smtp-Source: AGHT+IEQAPUV/KA5Lz34E4irpjiyAsv33koqvqCYKYdiaGY5Yw7DPqFcAt70S4/nUSAiR+Zq1QnoMg==
X-Received: by 2002:a17:90a:67c6:b0:2ae:6e36:af21 with SMTP id g6-20020a17090a67c600b002ae6e36af21mr2412507pjm.25.1714136261420;
        Fri, 26 Apr 2024 05:57:41 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id eu6-20020a17090af94600b002aeb05d6e97sm6334259pjb.21.2024.04.26.05.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:57:40 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:27:30 +0530
Message-Id: <87frv8z3gl.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, yi.zhang@huaweicloud.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <87frv8nw4a.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Now we lookup extent status entry without holding the i_data_sem before
>> inserting delalloc block, it works fine in buffered write path and
>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>> lock, so the found extent locklessly couldn't be modified concurrently.
>> But it could be raced by fallocate since it allocate block whitout
>> holding i_rwsem and folio lock.
>>
>> ext4_page_mkwrite()             ext4_fallocate()
>>  block_page_mkwrite()
>>   ext4_da_map_blocks()
>>    //find hole in extent status tree
>>                                  ext4_alloc_file_blocks()
>>                                   ext4_map_blocks()
>>                                    //allocate block and unwritten extent
>>    ext4_insert_delayed_block()
>>     ext4_da_reserve_space()
>>      //reserve one more block
>>     ext4_es_insert_delayed_block()
>>      //drop unwritten extent and add delayed extent by mistake
>>
>> Then, the delalloc extent is wrong until writeback, the one more
>> reserved block can't be release any more and trigger below warning:
>>
>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>
>> Hold i_data_sem in write mode directly can fix the problem, but it's
>> expansive, we should keep the lockless check and check the extent again
>> once we need to add an new delalloc block.
>
> Hi Zhang, 
>
> It's a nice finding. I was wondering if this was caught in any of the
> xfstests?
>
> I have reworded some of the commit message, feel free to use it if you
> think this version is better. The use of which path uses which locks was
> a bit confusing in the original commit message.
>
> <reworded from your original commit msg>
>
> ext4_da_map_blocks(), first looks up the extent status tree for any
> extent entry with i_data_sem held in read mode. It then unlocks
> i_data_sem, if it can't find an entry and take this lock in write
> mode for inserting a new da entry.

Sorry about this above paragraph. I messed this paragraph.
Here is the correct version of this.

ext4_da_map_blocks looks up for any extent entry in the extent status
tree (w/o i_data_sem) and then the looks up for any ondisk extent
mapping (with i_data_sem in read mode).

If it finds a hole in the extent status tree or if it couldn't find any
entry at all, it then takes the i_data_sem in write mode to add a da entry
into the extent status tree. This can actually race with page mkwrite
& fallocate path. 

Note that this is ok between...  <and the rest can remain same>

>
> This is ok between -
> 1. ext4 buffered-write path v/s ext4_page_mkwrite(), because of the
> folio lock
> 2. ext4 buffered write path v/s ext4 fallocate because of the inode
> lock.
>


> But this can race between ext4_page_mkwrite() & ext4 fallocate path - 
>
>  ext4_page_mkwrite()             ext4_fallocate()
>   block_page_mkwrite()
>    ext4_da_map_blocks()
>     //find hole in extent status tree
>                                   ext4_alloc_file_blocks()
>                                    ext4_map_blocks()
>                                     //allocate block and unwritten extent
>     ext4_insert_delayed_block()
>      ext4_da_reserve_space()
>       //reserve one more block
>      ext4_es_insert_delayed_block()
>       //drop unwritten extent and add delayed extent by mistake
>
> Then, the delalloc extent is wrong until writeback and the extra
> reserved block can't be released any more and it triggers below warning:
>
>   EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>
> This patch fixes the problem by looking up extent status tree again
> while the i_data_sem is held in write mode. If it still can't find
> any entry, then we insert a new da entry into the extent status tree.
>
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 6a41172c06e1..118b0497a954 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>  		if (ext4_es_is_hole(&es))
>>  			goto add_delayed;
>>  
>> +found:
>>  		/*
>>  		 * Delayed extent could be allocated by fallocate.
>>  		 * So we need to check it.
>> @@ -1781,6 +1782,24 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
>>  
>>  add_delayed:
>>  	down_write(&EXT4_I(inode)->i_data_sem);
>> +	/*
>> +	 * Lookup extents tree again under i_data_sem, make sure this
>> +	 * inserting delalloc range haven't been delayed or allocated
>> +	 * whitout holding i_rwsem and folio lock.
>> +	 */
>
> page fault path (ext4_page_mkwrite does not take i_rwsem) and fallocate
> path (no folio lock) can race. Make sure we lookup the extent status
> tree here again while i_data_sem is held in write mode, before inserting
> a new da entry in the extent status tree.
>
>


-ritesh

