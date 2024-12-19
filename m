Return-Path: <linux-fsdevel+bounces-37831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FB59F80C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE431627E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D45189BB5;
	Thu, 19 Dec 2024 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dtqMC79w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D1486337
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627280; cv=none; b=kTFVvlsJaOtT4C0HOqi86TWckkZtCnCpEaRXgwYX6bNXyzO+Z48ktgDFAAA9g7Wm6ION3Z/6tI6ltDbvf9RoRSj8w7lGOvKz9FC6S3BgSHK2HGw3rWougxHMjHYaa2e6w0KxlHdafuJZOS+KXqGxFhUJnkEJF6aq2Pc0AOfn5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627280; c=relaxed/simple;
	bh=JUV4liDYTCIu5aDrNKdlzIkYfpQhovHO/SNXy3a8XJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PV+VF6h/xzjQHp4CY+oYAHBPhHxIIglAm79XHBrKJ2smGB2SJBWdJA3rho/palxfr8v49hjEHlkh09bu2+4ZTghmGvrr6Xq4KgB4swjkIHkEi5pQldFl+UNf8hGoaSkparESPpMCPe7U2upaXvnEA+1wFl21Pt71E+wwFhot4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dtqMC79w; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so6707125ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 08:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734627276; x=1735232076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPAQC0CjmPDU3In7QT2WvDFGTmpm90H78Rbp4/qGsVE=;
        b=dtqMC79wDYgWYpDi5e0JY5TZ/pjDia+1osB8T1NxgQrx2jMgQ+gCWAQYp0KOaCyWLU
         +ehWeGOgvGOrVsTyap+ppVusP7IVzaYfePMgDSBCYKU0gsiUdR06tF0e7z0xnOafkqxo
         N47+XXFuweHKy4RzHMWIBiJ91bemzbv//SeMvTeMvJW5NvokBTzvD7yN98wblpWZN24T
         btRCn+SANOqcrgPBaVqzTEBqm+qpraCecwcIUzKQdINiotNGZPbTevteN9CeN8bEZ8lZ
         H7GcZjtB3isw+iIYLH6fOqxO7Q/0FgnZ8isjz7s1pJR9P7B7CSKLnR3MXG4LJXnb64UY
         vkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627276; x=1735232076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPAQC0CjmPDU3In7QT2WvDFGTmpm90H78Rbp4/qGsVE=;
        b=gHLwJUnukluULrZWpuISOj1unCdTVpi2oFnx3PPlfi420ZLHZhvCSSyOwYfePb4dvj
         mAB0Zzn4nZHwqB+X9l7RZh7Ps7cCg6bkIWriWq5BQZIJSC10TkrzQ4GBEJ2HTE4FNdTG
         EkroBmTRAfRlbqIjXiOIb7RU+Yi7Am7qZ31moDG7wBYvoCyxc9hbgYY+JI5dlVKLCL14
         u//IndZUPuC6m5qPo0JqctZVIqMLC+9UoVmAJ4KVZ8qpsmDU72mItvajYiu/mTXkp25B
         Y6lBJek00IzXlpxxhB2DyMFk0HNI1/Az2RWg5QFD1LLpqOLagIo9uXtGfKn7y8DnZt3t
         Jmrg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Nzl0OcG2aWGUsvUO01haw7i4P4Ltp3t8nANGxeOKT69pu+5iU9QTVtFrbOqKRCnVe+vA6+AK1edAqFi9@vger.kernel.org
X-Gm-Message-State: AOJu0YwAryMYXfrJNEQRcPjy3ffUn6iR9td1pBNcyqymGeTwvogBqT93
	EMWtDCsefbYZgDVQns8PVUzX1Fxjp0LFTjpDD8cup6HBDjt69pVD7Hx/t8EEvnk=
X-Gm-Gg: ASbGnct+WalG+dH6+5r2QlcoUVFPbJwq9wNfLQX6lXuFxrxzVVYcQKuOQGBkQrKixgs
	Gx6K16E1P1qM4bBpH3Qi5E0dys32gtq5Gn0shRm7N8gx2OfBXrxd56eZ5lo9n9crEdaPpsfjJXw
	sNE6vqlyWMAYfJ7q3TeVWaOoCEd2QUPHEaCQ/Lhlwek9DxAm27ECz0Xqd1j1Mh5SLQ9/c0qTJl6
	uCZ9PyimPdUwo/0rP1szcUSvh0nxBgMFouUu60mDyvv3vg52Fbu
X-Google-Smtp-Source: AGHT+IGPEmA/enwGnPfk2ZscKkQAFMKMb86HCI3AABDK1Ki272AdM1qkof8Vw8rfxfn10YTd+tUqIQ==
X-Received: by 2002:a05:6e02:3f0f:b0:3a7:fede:7113 with SMTP id e9e14a558f8ab-3bdc437aa59mr72379185ab.18.1734627276499;
        Thu, 19 Dec 2024 08:54:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf67546sm359332173.42.2024.12.19.08.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 08:54:35 -0800 (PST)
Message-ID: <c3fe0ae1-d42f-4208-a0bf-c97ad29f3559@kernel.dk>
Date: Thu, 19 Dec 2024 09:54:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: flag as supporting FOP_DONTCACHE
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, bfoster@redhat.com, linux-nfs@vger.kernel.org
References: <20241213155557.105419-1-axboe@kernel.dk>
 <Z2MDfBWULaV7n9Pb@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z2MDfBWULaV7n9Pb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 10:16 AM, Mike Snitzer wrote:
> On Fri, Dec 13, 2024 at 08:55:14AM -0700, Jens Axboe wrote:
>> Hi,
>>
>> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
>> to do buffered IO that isn't page cache persistent. The approach back
>> then was to have private pages for IO, and then get rid of them once IO
>> was done. But that then runs into all the issues that O_DIRECT has, in
>> terms of synchronizing with the page cache.
>>
>> So here's a new approach to the same concent, but using the page cache
>> as synchronization. Due to excessive bike shedding on the naming, this
>> is now named RWF_DONTCACHE, and is less special in that it's just page
>> cache IO, except it prunes the ranges once IO is completed.
>>
>> Why do this, you may ask? The tldr is that device speeds are only
>> getting faster, while reclaim is not. Doing normal buffered IO can be
>> very unpredictable, and suck up a lot of resources on the reclaim side.
>> This leads people to use O_DIRECT as a work-around, which has its own
>> set of restrictions in terms of size, offset, and length of IO. It's
>> also inherently synchronous, and now you need async IO as well. While
>> the latter isn't necessarily a big problem as we have good options
>> available there, it also should not be a requirement when all you want
>> to do is read or write some data without caching.
>>
>> Even on desktop type systems, a normal NVMe device can fill the entire
>> page cache in seconds. On the big system I used for testing, there's a
>> lot more RAM, but also a lot more devices. As can be seen in some of the
>> results in the following patches, you can still fill RAM in seconds even
>> when there's 1TB of it. Hence this problem isn't solely a "big
>> hyperscaler system" issue, it's common across the board.
>>
>> Common for both reads and writes with RWF_DONTCACHE is that they use the
>> page cache for IO. Reads work just like a normal buffered read would,
>> with the only exception being that the touched ranges will get pruned
>> after data has been copied. For writes, the ranges will get writeback
>> kicked off before the syscall returns, and then writeback completion
>> will prune the range. Hence writes aren't synchronous, and it's easy to
>> pipeline writes using RWF_DONTCACHE. Folios that aren't instantiated by
>> RWF_DONTCACHE IO are left untouched. This means you that uncached IO
>> will take advantage of the page cache for uptodate data, but not leave
>> anything it instantiated/created in cache.
>>
>> File systems need to support this. This patchset adds support for the
>> generic read path, which covers file systems like ext4. Patches exist to
>> add support for iomap/XFS and btrfs as well, which sit on top of this
>> series. If RWF_DONTCACHE IO is attempted on a file system that doesn't
>> support it, -EOPNOTSUPP is returned. Hence the user can rely on it
>> either working as designed, or flagging and error if that's not the
>> case. The intent here is to give the application a sensible fallback
>> path - eg, it may fall back to O_DIRECT if appropriate, or just live
>> with the fact that uncached IO isn't available and do normal buffered
>> IO.
>>
>> Adding "support" to other file systems should be trivial, most of the
>> time just a one-liner adding FOP_DONTCACHE to the fop_flags in the
>> file_operations struct.
>>
>> Performance results are in patch 8 for reads, and you can find the write
>> side results in the XFS patch adding support for DONTCACHE writes for
>> XFS:
>>
>> ://git.kernel.dk/cgit/linux/commit/?h=buffered-uncached.9&id=edd7b1c910c5251941c6ba179f44b4c81a089019
>>
>> with the tldr being that I see about a 65% improvement in performance
>> for both, with fully predictable IO times. CPU reduction is substantial
>> as well, with no kswapd activity at all for reclaim when using
>> uncached IO.
>>
>> Using it from applications is trivial - just set RWF_DONTCACHE for the
>> read or write, using pwritev2(2) or preadv2(2). For io_uring, same
>> thing, just set RWF_DONTCACHE in sqe->rw_flags for a buffered read/write
>> operation. And that's it.
>>
>> Patches 1..7 are just prep patches, and should have no functional
>> changes at all. Patch 8 adds support for the filemap path for
>> RWF_DONTCACHE reads, and patches 9..11 are just prep patches for
>> supporting the write side of uncached writes. In the below mentioned
>> branch, there are then patches to adopt uncached reads and writes for
>> xfs, btrfs, and ext4. The latter currently relies on bit of a hack for
>> passing whether this is an uncached write or not through
>> ->write_begin(), which can hopefully go away once ext4 adopts iomap for
>> buffered writes. I say this is a hack as it's not the prettiest way to
>> do it, however it is fully solid and will work just fine.
>>
>> Passes full xfstests and fsx overnight runs, no issues observed. That
>> includes the vm running the testing also using RWF_DONTCACHE on the
>> host. I'll post fsstress and fsx patches for RWF_DONTCACHE separately.
>> As far as I'm concerned, no further work needs doing here.
>>
>> And git tree for the patches is here:
>>
>> https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.9
>>
>>  include/linux/fs.h             | 21 +++++++-
>>  include/linux/page-flags.h     |  5 ++
>>  include/linux/pagemap.h        |  1 +
>>  include/trace/events/mmflags.h |  3 +-
>>  include/uapi/linux/fs.h        |  6 ++-
>>  mm/filemap.c                   | 97 +++++++++++++++++++++++++++++-----
>>  mm/internal.h                  |  2 +
>>  mm/readahead.c                 | 22 ++++++--
>>  mm/swap.c                      |  2 +
>>  mm/truncate.c                  | 54 ++++++++++---------
>>  10 files changed, 166 insertions(+), 47 deletions(-)
>>
>> Since v6
>> - Rename the PG_uncached flag to PG_dropbehind
>> - Shuffle patches around a bit, most notably so the foliop_uncached
>>   patch goes with the ext4 support
>> - Get rid of foliop_uncached hack for btrfs (Christoph)
>> - Get rid of passing in struct address_space to filemap_create_folio()
>> - Inline invalidate_complete_folio2() in folio_unmap_invalidate() rather
>>   than keep it as a separate helper
>> - Rebase on top of current master
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> 
> Hi Jens,
> 
> You may recall I tested NFS to work with UNCACHED (now DONTCACHE).
> I've rebased the required small changes, feel free to append this to
> your series if you like.
> 
> More work is needed to inform knfsd to selectively use DONTCACHE, but
> that will require more effort and coordination amongst the NFS kernel
> team.

Thanks Mike, I'll add it to the part 2 mix.

-- 
Jens Axboe

