Return-Path: <linux-fsdevel+bounces-17927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F588B3CFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8521C227F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00916152E1C;
	Fri, 26 Apr 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbnzfCGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B16BFB1;
	Fri, 26 Apr 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149571; cv=none; b=Q/2m+2qnzmCbv+mq5jox3OscknNaz0m2V4DYBC3Cg8TkqPJd58SLJ4Sc7ZFo18NgFDUk9x58H9TSPI4BUzCeaSwL72rHBdeQeS6F7EMyGljVZadK4VSiFuO8O1J0BKsTl2rJC44Dt0SZ/Vq6b6cWX61bfIbOpzga/E0sHY+VJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149571; c=relaxed/simple;
	bh=w/gBi3edSmNDW/znJg1vZKFL1LvFh9km4CBTyDCZ8D0=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=d6+akkOA8x8ZNCUjPyPjS3datlnpxQZGWUicZDQZJlHEwvkft53/Pl7BSqD9ULf0Q81IdlmmabcbnzovflH/J3P39J7/bj69hegIX1BkjFD56l/UVlW3/K0Fx4RvHdIGaGa+LmqIkgJKpZLbPMNq22sFgyzN9564xjg0iEjX5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbnzfCGM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e3ff14f249so18017175ad.1;
        Fri, 26 Apr 2024 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714149569; x=1714754369; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5vdb3yhYZF5PVXMwqqX9zuy/qHRdeg9Flas2P2+YbpY=;
        b=bbnzfCGMXVLjPaJoB5S1TCy3ZEXQ3W0PzadUKI4mu4nmS7Bgf6+znRrckhC/y8FxRL
         z+YznnN/TIcJIazzBYzuqR3T9Ntla8Jk090MQHN4EE6lY2Jgx2TN1XWcaZUIDZbjiy1G
         tKyPEXyWffON2vQmuefjmLllyberL/7F+E5AN5MSN4J4h7lvvWzyUc6YJHwWJa+fgaNU
         GwvV44EDS0ugV7f9tHaM9s3M7nMwvOBmqx7Aco0V5P7nYypkh4+klZpaQJQMubCV1WWs
         6xV4m6pHmKICscAK5LdmgntMtvPTRY8iV2kjcyNsO+mSmT9NA1QgRz7fY/K2lYbXETO9
         ItJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714149569; x=1714754369;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vdb3yhYZF5PVXMwqqX9zuy/qHRdeg9Flas2P2+YbpY=;
        b=eSJ9jX/SS4y+yTNOyYGz7neeS0e/sZ32Ec06HNZSEhacEpD5X3r3PbTigyaaHCVEWr
         tHRtbt776g33HMhfw/w0Gg4/jR2FIAMpcrgrKAWjbfajfsqZv1sDP02bWXrppsqAisaL
         tFf53tXLoZaznXBTPrY7QeHUpm+OXqbmBU3dnf3DM08bfpF2u1xitMmt7HshuEk/Pme+
         aHgXxL7H2srzUpA/EQbXKS6F3KMjLApFj1Mf0jIZB8ZT1bYXgveKPPAhJqqYYFIK1sH7
         CngMSXPDnpCqdV2e3MpobSTx3JJ8D5xeyly2rlGfyaquR+F4F3D405ujPUlNCnC3YKmO
         Crfw==
X-Forwarded-Encrypted: i=1; AJvYcCUHJ0RuaR4mIB+rmUvH0MdyJqIg4iu2dWZ/3iXuR1tpSPNqKe3w/hDUkbsRPuj4o78j29JFnEGxG867PEOFzX13MkFIWUomNAGxeUyXV4gTDZDpg3nQTaLbrnfDL/+RCBN1ads+yWNIMw==
X-Gm-Message-State: AOJu0Yx2EzWe8PzlFHxSQsF/CEVwpW4K9xkFzgPgZHxXxv9tzm8veW7v
	UBbf3xwfA033zvG0VRjvcLNzZXqkx34JUWj0eIVQgdR58pjxtDyB
X-Google-Smtp-Source: AGHT+IEymwytHhWcAtyIhw1i68RqqiL4j2SDBBwBfiMs1KrBO+LxIoTewEe2hXkZc6FjNkC9DbUTtQ==
X-Received: by 2002:a17:902:e802:b0:1e0:c0b9:589e with SMTP id u2-20020a170902e80200b001e0c0b9589emr308917plg.25.1714149568671;
        Fri, 26 Apr 2024 09:39:28 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id lf13-20020a170902fb4d00b001ea374c5099sm6545823plb.197.2024.04.26.09.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:39:27 -0700 (PDT)
Date: Fri, 26 Apr 2024 22:09:22 +0530
Message-Id: <87cyqcyt6t.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com, willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 02/34] ext4: check the extent status again before inserting delalloc block
In-Reply-To: <185a0d75-558e-a1ae-9415-c3eed4def60f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> On 2024/4/26 20:57, Ritesh Harjani (IBM) wrote:
>> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
>> 
>>> Zhang Yi <yi.zhang@huaweicloud.com> writes:
>>>
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Now we lookup extent status entry without holding the i_data_sem before
>>>> inserting delalloc block, it works fine in buffered write path and
>>>> because it holds i_rwsem and folio lock, and the mmap path holds folio
>>>> lock, so the found extent locklessly couldn't be modified concurrently.
>>>> But it could be raced by fallocate since it allocate block whitout
>>>> holding i_rwsem and folio lock.
>>>>
>>>> ext4_page_mkwrite()             ext4_fallocate()
>>>>  block_page_mkwrite()
>>>>   ext4_da_map_blocks()
>>>>    //find hole in extent status tree
>>>>                                  ext4_alloc_file_blocks()
>>>>                                   ext4_map_blocks()
>>>>                                    //allocate block and unwritten extent
>>>>    ext4_insert_delayed_block()
>>>>     ext4_da_reserve_space()
>>>>      //reserve one more block
>>>>     ext4_es_insert_delayed_block()
>>>>      //drop unwritten extent and add delayed extent by mistake
>>>>
>>>> Then, the delalloc extent is wrong until writeback, the one more
>>>> reserved block can't be release any more and trigger below warning:
>>>>
>>>>  EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!
>>>>
>>>> Hold i_data_sem in write mode directly can fix the problem, but it's
>>>> expansive, we should keep the lockless check and check the extent again
>>>> once we need to add an new delalloc block.
>>>
>>> Hi Zhang, 
>>>
>>> It's a nice finding. I was wondering if this was caught in any of the
>>> xfstests?
>>>
>
> Hi, Ritesh
>
> I caught this issue when I tested my iomap series in generic/344 and
> generic/346. It's easy to reproduce because the iomap's buffered write path
> doesn't hold folio lock while inserting delalloc blocks, so it could be raced
> by the mmap page fault path. But the buffer_head's buffered write path can't
> trigger this problem,

ya right! That's the difference between how ->map_blocks() is called
between buffer_head v/s iomap path. In iomap the ->map_blocks() call
happens first to map a large extent and then it iterate over all the
locked folios covering the mapped extent for doing writes.
Whereas in buffer_head while iterating, we first instantiate/lock the
folio and then call ->map_blocks() to map an extent for the given folio.

... So this opens up this window for a race between iomap buffered write
path v/s page mkwrite path for inserting delalloc blocks entries.

> the race between buffered write path and fallocate path
> was discovered while I was analyzing the code, so I'm not sure if it could
> be caught by xfstests now, at least I haven't noticed this problem so far.
>

Did you mean the race between page fault path and fallocate path here?
Because buffered write path and fallocate path should not have any race
since both takes the inode_lock. I guess you meant page fault path and
fallocate path for which you wrote this patch too :)

I am surprised, why we cannot see the this race between page mkwrite and
fallocate in fstests for inserting da entries to extent status cache.
Because the race you identified looks like a legitimate race and is
mostly happening since ext4_da_map_blocks() was not doing the right
thing.
... looking at the src/holetest, it doesn't really excercise this path.
So maybe we can writing such fstest to trigger this race.


>>> I have reworded some of the commit message, feel free to use it if you
>>> think this version is better. The use of which path uses which locks was
>>> a bit confusing in the original commit message.
>>>
>
> Thanks for the message improvement, it looks more clear then mine, I will
> use it.
>

Glad, it was helpful.

-ritesh

