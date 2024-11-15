Return-Path: <linux-fsdevel+bounces-34923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A99CE9FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626A428848B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A32B1D5164;
	Fri, 15 Nov 2024 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RROIqpK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07FC1D4604
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683225; cv=none; b=TcMEBi+ILlSpeitHHUzKGx762ySRCVW3UrPOBTSPnelubuHgjxhRkItbbGO7colRfHtbRRpbHFbA4gF9rgRxAUKDCwaEZR5pkbj9q1ckXej95qKLKNlbRxaNYNK8j0DvuXHWyxyG3ZBU0ObND9W+Aj1mixlkjgJBMKmy0GEmc54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683225; c=relaxed/simple;
	bh=JoueD5DdbEps7KANkoLAA34opKmVg057HSDEhnbmjsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vecpsndf4iCeXyQInZ20ymbQSdi32W9BHY+jI/su5Q3ZUgiDZkyH2ajB26GyI0agmd0P25j0p10prtWi5eyf7AF9JnRc1TBOQeT6kMa8zIlgm3MrW1zEQJrgO4z4BQD9pDoaUSDEYEKgKK3kJRqdQjNp4LmSbxW8dB7p2o128qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RROIqpK4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e786167712so521140b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 07:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731683222; x=1732288022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gUCqtsVIcpTKxB887ynhni13OvvpCFWbJ2pT4TerOo=;
        b=RROIqpK41XM1XxPaZU4J0Hh1Yfu3ibn1or6r1aMG1ocm37YpJkwMmjDUVOrpKMOjYk
         MER/k9d6rkjtp7bLmd4cwudVjXvHPeJq/qrblXkwmgU/Z/5xf2VTv78OIoWS80MmhSAz
         jfQ4AFY6jyQYIcAInv22ztdPjElN954+4NwSsAHlTrFvClQkaW5wSnqCaAQF2S8wiccM
         gRZxvOaeK89c/vzRQF2fzw/UWZ3/Z6R8ersCSNkf3re7vMS2ye/2l0ThXdUGdBmD/lj3
         JQy8KjuBf9h8CF1APS7HxMpp2l3M25kIwvC2wMspv11NMcrw9t0f9lF9hEYbwXjjZeeO
         1Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683222; x=1732288022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gUCqtsVIcpTKxB887ynhni13OvvpCFWbJ2pT4TerOo=;
        b=Xq2ADMILu5517MbOA2SOznNVVQsA65fxTexCCupHuG6D2s+qEZiaNy2WcqMzrDeBux
         QlpkopnAGUUSxTHg98HHLEESB4magcPc0G24kJQ28z56H/+aqxXJQ8Ra43yNnH9oZSqW
         fljawxZo3edLnlfcCJycZ1LCvGz1cPBgQWJvTgRUHTQ8Pl/UT4TiGYk+WQvGYZkV1Zuh
         wnmM19pLU7vqDoNoKDMhcHCJGypqhpFGDE34qNhWHw58n+mKvFnM7ln82w6G/qcRKiiU
         G1t0P7MFORF6orpfgts0BotlrwCf/geKALiolx+g1FmkDO8VX2m+R0LQDSQbGVR1T9oc
         lbQg==
X-Forwarded-Encrypted: i=1; AJvYcCXlvFc5eZizbKqyGg+zAMZMOPdMRTznrjuCdpmwSZPwnP+4vjimk9eA2Q958wQB6RqO+1qYlpJ7y1/poSxl@vger.kernel.org
X-Gm-Message-State: AOJu0YwxShxKHHAY0P/7rmHy8puoEVkY9MbOY9AYwVVEkOvkWrIYpZlr
	07/C9ceSsGptW5SXDu79lro1toeJ4q2c5Ab3ZWXPhPMlrR+XjjlEZiOlLZh50s4=
X-Google-Smtp-Source: AGHT+IESr8fzq2A6pN9+2NHIo06fx9RY7MS57VQq1z635m6xFAB4jhV9p9zb/JVkay2xsrjQDiNpqw==
X-Received: by 2002:a05:6808:3096:b0:3e6:14a6:4288 with SMTP id 5614622812f47-3e7bc7c14a8mr3816872b6e.11.1731683221679;
        Fri, 15 Nov 2024 07:07:01 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd82ad7sm536427b6e.40.2024.11.15.07.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:07:00 -0800 (PST)
Message-ID: <94116ae9-30a8-40fa-8ff0-0c51ee126c64@kernel.dk>
Date: Fri, 15 Nov 2024 08:06:59 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v5 0/17] Uncached buffered IO
To: Julian Sun <sunjunchao2870@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, bfoster@redhat.com
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <8b47ebabf12a531f2fa24a7671df5e569b82adb7.camel@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8b47ebabf12a531f2fa24a7671df5e569b82adb7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/24 9:01 PM, Julian Sun wrote:
> On Thu, 2024-11-14 at 08:25 -0700, Jens Axboe wrote:
>> Hi,
>>
>> 5 years ago I posted patches adding support for RWF_UNCACHED, as a way
>> to do buffered IO that isn't page cache persistent. The approach back
>> then was to have private pages for IO, and then get rid of them once IO
>> was done. But that then runs into all the issues that O_DIRECT has, in
>> terms of synchronizing with the page cache.
>>
>> So here's a new approach to the same concent, but using the page cache
>> as synchronization. That makes RWF_UNCACHED less special, in that it's
>> just page cache IO, except it prunes the ranges once IO is completed.
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
>> Common for both reads and writes with RWF_UNCACHED is that they use the
>> page cache for IO. Reads work just like a normal buffered read would,
>> with the only exception being that the touched ranges will get pruned
>> after data has been copied. For writes, the ranges will get writeback
>> kicked off before the syscall returns, and then writeback completion
>> will prune the range. Hence writes aren't synchronous, and it's easy to
>> pipeline writes using RWF_UNCACHED. Folios that aren't instantiated by
>> RWF_UNCACHED IO are left untouched. This means you that uncached IO
>> will take advantage of the page cache for uptodate data, but not leave
>> anything it instantiated/created in cache.
>>
>> File systems need to support this. The patches add support for the
>> generic filemap helpers, and for iomap. Then ext4 and XFS are marked as
>> supporting it. The last patch adds support for btrfs as well, lightly
>> tested. The read side is already done by filemap, only the write side
>> needs a bit of help. The amount of code here is really trivial, and the
>> only reason the fs opt-in is necessary is to have an RWF_UNCACHED IO
>> return -EOPNOTSUPP just in case the fs doesn't use either the generic
>> paths or iomap. Adding "support" to other file systems should be
>> trivial, most of the time just a one-liner adding FOP_UNCACHED to the
>> fop_flags in the file_operations struct.
>>
>> Performance results are in patch 8 for reads and patch 10 for writes,
>> with the tldr being that I see about a 65% improvement in performance
>> for both, with fully predictable IO times. CPU reduction is substantial
>> as well, with no kswapd activity at all for reclaim when using uncached
>> IO.
>>
>> Using it from applications is trivial - just set RWF_UNCACHED for the
>> read or write, using pwritev2(2) or preadv2(2). For io_uring, same
>> thing, just set RWF_UNCACHED in sqe->rw_flags for a buffered read/write
>> operation. And that's it.
>>
>> Patches 1..7 are just prep patches, and should have no functional
>> changes at all. Patch 8 adds support for the filemap path for
>> RWF_UNCACHED reads, patch 10 adds support for filemap RWF_UNCACHED
>> writes, and patches 13..17 adds ext4, xfs/iomap, and btrfs support.
>>
>> Passes full xfstests and fsx overnight runs, no issues observed. That
>> includes the vm running the testing also using RWF_UNCACHED on the host.
>> I'll post fsstress and fsx patches for RWF_UNCACHED separately. As far
>> as I'm concerned, no further work needs doing here. Once we're into
>> the 6.13 merge window, I'll split up this series and aim to get it
>> landed that way. There are really 4 parts to this - generic mm bits,
>> ext4 bits, xfs bits, and btrfs bits.
>>
>> And git tree for the patches is here:
>>
>> https://git.kernel.dk/cgit/linux/log/?h=buffered-uncached.7
>>
>>  fs/btrfs/bio.c                 |   4 +-
>>  fs/btrfs/bio.h                 |   2 +
>>  fs/btrfs/extent_io.c           |   8 ++-
>>  fs/btrfs/file.c                |   9 ++-
>>  fs/ext4/ext4.h                 |   1 +
>>  fs/ext4/file.c                 |   2 +-
>>  fs/ext4/inline.c               |   7 +-
>>  fs/ext4/inode.c                |  18 +++++-
>>  fs/ext4/page-io.c              |  28 ++++----
>>  fs/iomap/buffered-io.c         |  15 ++++-
>>  fs/xfs/xfs_aops.c              |   7 +-
>>  fs/xfs/xfs_file.c              |   3 +-
>>  include/linux/fs.h             |  21 +++++-
>>  include/linux/iomap.h          |   8 ++-
>>  include/linux/page-flags.h     |   5 ++
>>  include/linux/pagemap.h        |  14 ++++
>>  include/trace/events/mmflags.h |   3 +-
>>  include/uapi/linux/fs.h        |   6 +-
>>  mm/filemap.c                   | 114 +++++++++++++++++++++++++++++----
>>  mm/readahead.c                 |  22 +++++--
>>  mm/swap.c                      |   2 +
>>  mm/truncate.c                  |  35 ++++++----
>>  22 files changed, 271 insertions(+), 63 deletions(-)
>>
>> Since v3
>> - Use foliop_is_uncached() in ext4 rather than do manual compares with
>>   foliop_uncached.
>> - Add filemap_fdatawrite_range_kick() helper and use that in
>>   generic_write_sync() to kick off uncached writeback, rather than need
>>   every fs adding a call to generic_uncached_write().
>> - Drop generic_uncached_write() helper, not needed anymore.
>> - Skip folio_unmap_invalidate() if the folio is dirty.
>> - Move IOMAP_F_UNCACHED to the internal iomap flags section, and add
>>   comment from Darrick to it as well.
>> - Only kick uncached writeback in generic_write_sync() if
>>   iocb_is_dsync() isn't true.
>> - Disable RWF_UNCACHED on dax mappings. They require more extensive
>>   invalidation, and as it isn't a likely use case, just disable it
>>   for now.
>> - Update a few commit messages
>>
> 
> Hi,
> 
> Hello, the simplicity and performance improvement of this patch series are
> really impressive, and I have no comments on it. 
> 
> I'm just curious about its use cases?under which scenarios should it be
> used, and under which scenarios should it be avoided? I noticed that the
> backing device you used for testing can provide at least 92GB/s read
> performance and 115GB/s write performance. Does this mean that the higher
> the performance of the backing device, the more noticeable the
> optimization? How does this patch series perform on low-speed devices?

It's really more about ratio of device speed to size of RAM. Yes the box
I tested on has a lot of drives, but it also has a lot of memory. Hence
the ratio to device speeds and memory size isn't that different from a
normal desktop box with eg 32G of memory, and a flash drive that does
6GB/sec. Obviously reclaim for that smaller box will not be as bad as
the big one, but still.

It's really two fold:

- You want to kick off writeback sooner rather than later. On devices
  these days, it's pretty pointless to let a lot of dirty data build up
  before starting to clean it. Uncached writeback starts when the copy
  is done, rather than many seconds later when some writeback thread
  decides the pressure is either too high, or it's been dirty too long.

- Don't leave things in cache that aren't going to get reused, only to
  get pruned later at the point where you need more memory for the cache
  anyway.

> My understanding is that the performance issue this patch is trying to
> address originates from the page cache being filled up, causing the current
> IO to wait for write-back or reclamation, correct? From this perspective,
> it seems that this would be suitable for applications that issue a large
> amount of IO in a short period of time, and it might not be dependent on
> the speed of the backing device?

On the read side, if you're not going to be reusing the data you read,
uncached is appropriate. Ditto on the write side, if you're just
flushing out a bunch of data with limted reuse, may as well prune the
cache regions as soon as the write is done, rather than let some kind of
background activity do that when memory becomes scarce.

-- 
Jens Axboe

