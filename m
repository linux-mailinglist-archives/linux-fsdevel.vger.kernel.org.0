Return-Path: <linux-fsdevel+bounces-34469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1299C5AE6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9755628404A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7661FF5F9;
	Tue, 12 Nov 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MMWaQqzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F991FF034
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423086; cv=none; b=eerOIP/oF3psMQ0PhY3HTxXR/35dm3iAqLxrJvGxheTOA5gTytR3C0CcTu5i9BjVrFt08D88hUPk1gk86Ngw0KQHl2Moc7KkmLUufef1DROuMcSwn/vJXe3iD3/iWLn6r8QSBhKCU9DiHq/wWIMWXIMLBoYuee/9hJc4gvbTAOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423086; c=relaxed/simple;
	bh=mqQhsAaxwWysPBIhvxpmHkNJDSNibPBlWN5Kv3bKH+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLvdlpBLF0fhEIGy0LAh0y/QMSIlnjidNkEEkKTT33i6CAWX3b2xwW93aGvIHC9Ec8kFbrdYCQ4BN9du8oSJrjlv9/3NWpjEAQAUtxmFCD9urJrBRx4/IlEyTZx/uBEyscL99S3jBimO0P6lTMBVW2b2FLWq9O9NWWlB8I0VuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MMWaQqzU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-715716974baso3557027a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731423083; x=1732027883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvE32TaYAXjgECParzeSgw6HkypztPHssnr8m+v8i78=;
        b=MMWaQqzUDQDT1sfOfxiY65TAT9MMPmlRKLKvFdLPP9pl0T2umtwURHkpfFLHRNLmE9
         7Io/SDzMfM+TIjkbKoYHts7giQXM3zhPvoh40kX35s+fR6leqO2JoxMskuIDVSQ9TT35
         cYX1rXUdLYaBsw5hKJhFJPAnf7ZQXiA91bKRLYr5AhN5oWQd+MEetGjPyquQW+GlOMPu
         xAQwUpy5NF/CwOvvWtipGB99muWOWB4/pLa4Z+O/YnjYf9fi1jq6jNHtARZ6pVfwCxfH
         F5e2KmWCPHnQzFUZWHH5JR+8/yatUNWuKdmermCkmnUBCV+EMOkrfKrhhRhbNL/LD+07
         G08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423083; x=1732027883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvE32TaYAXjgECParzeSgw6HkypztPHssnr8m+v8i78=;
        b=N56vcgRhd7oqpmyCzICHtHC/3Aj/ECepYtjX74UNdzoTgGLx4yjg23b4bwPqmEOUBM
         Sxt/Dglf8v6QfKGNyped2VxunS3mL0r2Y1QZl3TEUGKSlT9bmBb6S7iEzGGrzMv7/tGm
         WM2ReOfzZFG7AWxQbCSxaJA8xTtN7T4oLBzD/3G8tj4Rag5snd3obQGcC2oiEcjk0QiL
         6s3+Dq2+sS6ebYei1FFbC4RyoAICBgqr6YbbACSFR/DbZQK5jWWwy/z5L+OZDwu1tVHz
         5He7qkokzieqJzfmb5Nru7+Xp0IryH0FpdcBg/bAJR1mf8S/cFwzDZb98KyRwRSRCcdf
         8k+w==
X-Forwarded-Encrypted: i=1; AJvYcCXVbAx2xxJDcJtBmRldIp+ygrz9pQm/OaAIu7CPHF7J4COJChqa1o9gU6JcPjfxQF99oV0UTUix9we4lP9k@vger.kernel.org
X-Gm-Message-State: AOJu0YyxikaehzA27JKHYWqCm2o3uX2WDaA2zT9YvChwZYUWbyH/JR1Q
	Ndw1pd3sR7u32wnNBO9EBpipxEjyp0AjV8cRAjXv0wzcuJBYJ4ucizpC8E9IcUk=
X-Google-Smtp-Source: AGHT+IH7Ryn2K78a+7vMPHSR7u3Kh0PU/404i9EkCLLhxngvy6O/IjGB1rfvrkuz3xsVwrzASt/5mA==
X-Received: by 2002:a05:6830:6d86:b0:710:f1cd:b237 with SMTP id 46e09a7af769-71a1c2860eemr14833704a34.20.1731423083214;
        Tue, 12 Nov 2024 06:51:23 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a10833f05sm2722374a34.31.2024.11.12.06.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:51:22 -0800 (PST)
Message-ID: <20b661ee-a7aa-4116-a0ec-96da9343af61@kernel.dk>
Date: Tue, 12 Nov 2024 07:51:21 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] mm/filemap: make buffered writes work with
 RWF_UNCACHED
To: Dave Chinner <david@fromorbit.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
 clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
 kirill@shutemov.name, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-11-axboe@kernel.dk>
 <ZzKn4OyHXq5r6eiI@dread.disaster.area>
 <0487b852-6e2b-4879-adf1-88ba75bdecc0@kernel.dk>
 <ZzMLmYNQFzw9Xywv@dread.disaster.area>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzMLmYNQFzw9Xywv@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/24 1:02 AM, Dave Chinner wrote:
> On Mon, Nov 11, 2024 at 06:27:46PM -0700, Jens Axboe wrote:
>> On 11/11/24 5:57 PM, Dave Chinner wrote:
>>> On Mon, Nov 11, 2024 at 04:37:37PM -0700, Jens Axboe wrote:
>>>> If RWF_UNCACHED is set for a write, mark new folios being written with
>>>> uncached. This is done by passing in the fact that it's an uncached write
>>>> through the folio pointer. We can only get there when IOCB_UNCACHED was
>>>> allowed, which can only happen if the file system opts in. Opting in means
>>>> they need to check for the LSB in the folio pointer to know if it's an
>>>> uncached write or not. If it is, then FGP_UNCACHED should be used if
>>>> creating new folios is necessary.
>>>>
>>>> Uncached writes will drop any folios they create upon writeback
>>>> completion, but leave folios that may exist in that range alone. Since
>>>> ->write_begin() doesn't currently take any flags, and to avoid needing
>>>> to change the callback kernel wide, use the foliop being passed in to
>>>> ->write_begin() to signal if this is an uncached write or not. File
>>>> systems can then use that to mark newly created folios as uncached.
>>>>
>>>> Add a helper, generic_uncached_write(), that generic_file_write_iter()
>>>> calls upon successful completion of an uncached write.
>>>
>>> This doesn't implement an "uncached" write operation. This
>>> implements a cache write-through operation.
>>
>> It's uncached in the sense that the range gets pruned on writeback
>> completion.
> 
> That's not the definition of "uncached". Direct IO is, by
> definition, "uncached" because it bypasses the cache and is not
> coherent with the contents of the cache.

I grant you it's not the best word in the world to describe it, but it
is uncached in the sense that it's not persistent in cache. It does very
much use the page cache as the synchronization point, exactly to avoid
the pitfalls of the giant mess that is O_DIRECT. But it's not persistent
in cache, whereas write-through very much traditionally is. Hence I
think uncached is a much better word than write-through, though as
mentioned I'll be happy to take other suggestions. Write-through isn't
it though, as the uncached concept is as much about reads as it is about
writes.

> This IO, however, is moving the data coherently through the cache
> (both on read and write).  The cached folios are transient - i.e.
> -temporarily resident- in the cache whilst the IO is in progress -
> but this behaviour does not make it "uncached IO".
> 
> Calling it "uncached IO " is simply wrong from any direction I look
> at it....

As mentioned, better words welcome :-)

>> For write-through, I'd consider that just the fact that it
>> gets kicked off once dirtied rather than wait for writeback to get
>> kicked at some point.
>>
>> So I'd say write-through is a subset of that.
> 
> I think the post-IO invalidation that these IOs do is largely
> irrelevant to how the page cache processes the write. Indeed,
> from userspace, the functionality in this patchset would be
> implemented like this:
> 
> oneshot_data_write(fd, buf, len, off)
> {
> 	/* write into page cache */
> 	pwrite(fd, buf, len, off);
> 
> 	/* force the write through the page cache */
> 	sync_file_range(fd, off, len, SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_AFTER);
> 
> 	/* Invalidate the single use data in the cache now it is on disk */
> 	posix_fadvise(fd, off, len, POSIX_FADV_DONTNEED);
> }

Right, you could do that, it'd obviously just be much slower as you lose
the pipelining of the writes. This is the reason for the patch, after
all.

> Allowing the application to control writeback and invalidation
> granularity is a much more flexible solution to the problem here;
> when IO is sequential, delayed allocation will be allowed to ensure
> large contiguous extents are created and that will greatly reduce
> file fragmentation on XFS, btrfs, bcachefs and ext4. For random
> writes, it'll submit async IOs in batches...
> 
> Given that io_uring already supports sync_file_range() and
> posix_fadvise(), I'm wondering why we need an new IO API to perform
> this specific write-through behaviour in a way that is less flexible
> than what applications can already implement through existing
> APIs....

Just to make it available generically, it's just a read/write flag after
all. And yes, you can very much do this already with io_uring, just by
linking the ops. But the way I see it, it's a generic solution to a
generic problem.

>>> That also gives us a common place for adding cache write-through
>>> trigger logic (think writebehind trigger logic similar to readahead)
>>> and this is also a place where we could automatically tag mapping
>>> ranges for reclaim on writeback completion....
>>
>> I appreciate that you seemingly like the concept, but not that you are
>> also seemingly trying to commandeer this to be something else. Unless
>> you like the automatic reclaiming as well, it's not clear to me.
> 
> I'm not trying to commandeer anything.

No? You're very much trying to steer it in a direction that you find
better. There's a difference between making suggestions, or speaking
like you are sitting on the ultimate truth.

> Having thought about it more, I think this new API is unneccesary
> for custom written applications to perform fine grained control of
> page cache residency of one-shot data. We already have APIs that
> allow applications to do exactly what this patchset is doing. rather
> than choosing to modify whatever benchmark being used to use
> existing APIs, a choice was made to modify both the applicaiton and
> the kernel to implement a whole new API....
> 
> I think that was the -wrong choice-.
> 
> I think this partially because the kernel modifications are don't
> really help further us towards the goal of transparent mode
> switching in the page cache.
> 
> Read-through should be a mode that the readahead control activates,
> not be something triggered by a special read() syscall flag. We
> already have access patterns and fadvise modes guiding this.
> Write-through should be controlled in a similar way.
> 
> And making the data being read and written behave as transient page
> caceh objects should be done via an existing fadvise mode, too,
> because the model you have implemented here exactly matches the 
> definition of FADV_NOREUSE:
> 
> 	POSIX_FADV_NOREUSE
>               The specified data will be accessed only once.
> 
> Having a new per-IO flag that effectively collides existing
> control functionality into a single inflexible API bit doesn't
> really make a whole lot of sense to me.
> 
> IOWs, I'm not questioning whether we need rw-through modes and/or
> IO-transient residency for page cache based IO - it's been on our
> radar for a while. I'm more concerned that the chosen API in this
> patchset is a poor one as it cannot replace any of the existing
> controls we already have for these sorts of application directed
> page cache manipulations...

We'll just have to disagree, then. Per-file settings is fine for sync
IO, for anything async per-io is the way to go. It's why we have things
like RWF_NOWAIT as well, where O_NONBLOCK exists too. I'd argue that
RWF_NOWAIT should always have been a thing, and O_NONBLOCK is a mistake.
That's why RWF_UNCACHED exists. And yes, the FADV_NOREUSE was already
discussed with Willy and Yu, and I already did a poc patch to just
unconditionally set RWF_UNCACHED for FADV_NOREUSE enabled files. While
it's not exactly the same concept, I think the overlap is large enough
that it makes sense to do that. Especially since, historically,
FADV_NOREUSE has been largely a no-op and even know it doesn't have well
defined semantics.

-- 
Jens Axboe

