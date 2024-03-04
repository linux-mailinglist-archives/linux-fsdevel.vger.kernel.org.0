Return-Path: <linux-fsdevel+bounces-13423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BD86F99A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 06:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ED01C20C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920FBA37;
	Mon,  4 Mar 2024 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQcL/Rwz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E24C64;
	Mon,  4 Mar 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530419; cv=none; b=iB755XMzGdWwENqbHxN3k//rglWzDKDue+tPHfR7r+mBKtLjmt0pByZIK927H9S1IxnQoayUe+BRrMFcQ7cV/O0egPVVXgGvXLrOVyGRtDvKmZcRuRifipNPMwS+gEXV+o91ZCeVFYljnCz74m3NPrwLrE1SlgBS2M3fpt502Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530419; c=relaxed/simple;
	bh=39apz2RIGrko8XHZbaGJZ+Fl2vLUYS5jFil+wlmcMcs=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=oNNAle6YpbeunJhlXsrtfmO8YYcTbBWXDkQaVMR/kTYFyaBi7Z+ltU4lQki9Qr8lReUTtP4+f1hc6h1UC9wscSvaeyZhuwwhSgE7sLJRrJfY7BzxbeINP2O2nNtTHIbqtsm//yK+zusTK2OSBMmitiNdTW63O0ivKQd8rJjef6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQcL/Rwz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dca160163dso39697815ad.3;
        Sun, 03 Mar 2024 21:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709530416; x=1710135216; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XRgqB8lnh2BNgRkdsh5T5T6fC6NhqpxcVe+MwI/3eLQ=;
        b=WQcL/RwzQ0MeTM7ssqF6snnu4b1tUEwEaYw6epi0/wEK2qQUbIQp6pNR8cEy+WPoHX
         bi4yW7T3XeiY4K6Xz0qaviTXeTQhIJAoayE5FzRHOz/XywB9KjFaWJyLohEZSVgi0kie
         6erTLncUUJEMpp3BckxClt14HGuEr7i0m7a1iv+5dirRospUTihRDydgeR7lbrJI1a0S
         /kPVQClptrwpNAUPboJEnmypru35yUXORmBzIs2Mp3nS2ackmj/km5W+3YgV9E14RGlb
         2xKe3SU9BKnYuHfuV5YiEAv3f1LE8rAlAtu79eTZxLG3lXz6PV5qCShyejBNAYMueAYZ
         J+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709530416; x=1710135216;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XRgqB8lnh2BNgRkdsh5T5T6fC6NhqpxcVe+MwI/3eLQ=;
        b=jQJfci6nyKD5/RAeDgnhDdQCPoJOtbaKEycOhU3DNOvisYRTJkidfuljVg0/QMNblC
         tp472zn0S6ObCB7rbF5UK3XkLGVE4cP4tko8vTmCA/v8XsDj3wIMyuKM7fO3oCXMeqkA
         e0e+oP31BbhyuyapMEnfxBs5lwjFbBLW+RGmXP+l9fhFX1klCKD2+k38ubTWtWV+MSvv
         xxAUeKU/8Y49IMtLn3bu/1fShrnNqZxWaIoxikn7uw4AlfR1SFynYuvs1NX2wBGVQW9R
         trslwoqo1Ub95Bjc6oG+qe7SfGPXvzGXEEcu03kjUzkitvzIp4TiVP5OeAqufHqsvUqF
         ieSw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Uud6S+rk2menXDyoFOcYxvKQ+34HciEjL87P73Ey+AJd+Yhij6BLIYxJwxRcm5VjohlA6kpGSed6p9zmq8GFM8Szcrm2rlBr85BDCHNqt7TIt15mKFC33HoT7msc7adO9qqoI+U4RA==
X-Gm-Message-State: AOJu0YwzwrLIz28v1HiWh4gKVF6To5QY5RifkPwD0ZI3S8K64XoRaDIb
	2F7/cLYG02LPqaEoFHjMqkR8QVVGBG8wkQskqVePzAbE99+BJF5ORA4ggUelwGs=
X-Google-Smtp-Source: AGHT+IEeMfdwuDck5FOv5XpWhwXL28cQZZM5tnNWM1NakbkXHjnWbgc1FmA2NEsMuqsMtLcTOiQvyw==
X-Received: by 2002:a17:902:e5ca:b0:1dc:b7d2:3fc3 with SMTP id u10-20020a170902e5ca00b001dcb7d23fc3mr10471639plf.68.1709530416283;
        Sun, 03 Mar 2024 21:33:36 -0800 (PST)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id t2-20020a170902e84200b001db45855528sm7504197plg.198.2024.03.03.21.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 21:33:35 -0800 (PST)
Date: Mon, 04 Mar 2024 11:03:24 +0530
Message-Id: <87frx64l3v.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/8] iomap: Add atomic write support for direct-io
In-Reply-To: <ZeUhCbT4sbucOT3L@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Sat, Mar 02, 2024 at 01:12:00PM +0530, Ritesh Harjani (IBM) wrote:
>> This adds direct-io atomic writes support in iomap. This adds -
>> 1. IOMAP_ATOMIC flag for iomap iter.
>> 2. Sets REQ_ATOMIC to bio opflags.
>> 3. Adds necessary checks in iomap_dio code to ensure a single bio is
>>    submitted for an atomic write request. (since we only support ubuf
>>    type iocb). Otherwise return an error EIO.
>> 4. Adds a common helper routine iomap_dio_check_atomic(). It helps in
>>    verifying mapped length and start/end physical offset against the hw
>>    device constraints for supporting atomic writes.
>> 
>> This patch is based on a patch from John Garry <john.g.garry@oracle.com>
>> which adds such support of DIO atomic writes to iomap.

Please note this comment above. I will refer this in below comments.

>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/iomap/direct-io.c  | 75 +++++++++++++++++++++++++++++++++++++++++--
>>  fs/iomap/trace.h      |  3 +-
>>  include/linux/iomap.h |  1 +
>>  3 files changed, 75 insertions(+), 4 deletions(-)
>
> Ugh. Now we have two competing sets of changes to bring RWF_ATOMIC
> support to iomap. One from John here:

Not competing changes (and neither that was the intention). As you see I have
commented above saying that this patch is based on a previous patch in
iomap from John. 

So why did I send this one?  
1. John's latest patch series v5 was on "block atomic writes" [1], which
does not have these checks in iomap (as it was not required). 

2. For sake of completeness for ext4 atomic write support, I needed to
include this change along with this series. I have also tried to address all
the review comments he got on [2] (along with an extra function iomap_dio_check_atomic())

[1]: https://lore.kernel.org/all/20240226173612.1478858-1-john.g.garry@oracle.com/
[2]: https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/

>
> https://lore.kernel.org/linux-fsdevel/20240124142645.9334-1-john.g.garry@oracle.com/
>
> and now this one.
>
> Can the two of you please co-ordinate your efforts and based your
> filesysetm work off the same iomap infrastructure changes?

Sure Dave, make sense. But we are cc'ing each other in this effort
together so that we are aware of what is being worked upon. 

And as I mentioned, this change is not competing with John's change. If
at all it is only complementing his initial change, since this iomap change
addresses review comments from others on the previous one and added one
extra check (on mapped physical extent) which I wanted people to provide feedback on.

>
> .....
>
>> @@ -356,6 +360,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>  	if (need_zeroout) {
>>  		/* zero out from the start of the block to the write offset */
>>  		pad = pos & (fs_block_size - 1);
>> +		if (unlikely(pad && atomic_write)) {
>> +			WARN_ON_ONCE("pos not atomic write aligned\n");
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>
> This atomic IO should have been rejected before it even got to
> the layers where the bios are being built. If the IO alignment is
> such that it does not align to filesystem allocation constraints, it
> should be rejected at the filesystem ->write_iter() method and not
> even get to the iomap layer.

I had added this mainly from iomap sanity checking perspective. 
We are offloading some checks to be made by the filesystem before
submitting the I/O request to iomap. 
These "common" checks in iomap layer are mainly to provide sanity checking
to make sure FS did it's job, before iomap could form/process the bios and then
do submit_bio to the block layer. 



>
> .....
>
>> @@ -516,6 +535,44 @@ static loff_t iomap_dio_iter(const struct iomap_iter *iter,
>>  	}
>>  }
>>  
>> +/*
>> + * iomap_dio_check_atomic:	DIO Atomic checks before calling bio submission.
>> + * @iter:			iomap iterator
>> + * This function is called after filesystem block mapping and before bio
>> + * formation/submission. This is the right place to verify hw device/block
>> + * layer constraints to be followed for doing atomic writes. Hence do those
>> + * common checks here.
>> + */
>> +static bool iomap_dio_check_atomic(struct iomap_iter *iter)
>> +{
>> +	struct block_device *bdev = iter->iomap.bdev;
>> +	unsigned long long map_len = iomap_length(iter);
>> +	unsigned long long start = iomap_sector(&iter->iomap, iter->pos)
>> +						<< SECTOR_SHIFT;
>> +	unsigned long long end = start + map_len - 1;
>> +	unsigned int awu_min =
>> +			queue_atomic_write_unit_min_bytes(bdev->bd_queue);
>> +	unsigned int awu_max =
>> +			queue_atomic_write_unit_max_bytes(bdev->bd_queue);
>> +	unsigned long boundary =
>> +			queue_atomic_write_boundary_bytes(bdev->bd_queue);
>> +	unsigned long mask = ~(boundary - 1);
>> +
>> +
>> +	/* map_len should be same as user specified iter->len */
>> +	if (map_len < iter->len)
>> +		return false;
>> +	/* start should be aligned to block device min atomic unit alignment */
>> +	if (!IS_ALIGNED(start, awu_min))
>> +		return false;
>> +	/* If top bits doesn't match, means atomic unit boundary is crossed */
>> +	if (boundary && ((start | mask) != (end | mask)))
>> +		return false;
>> +
>> +	return true;
>> +}
>
> I think you are re-implementing stuff that John has already done at
> higher layers and in a generic manner. i.e.
> generic_atomic_write_valid() in this patch:
>
> https://lore.kernel.org/linux-fsdevel/20240226173612.1478858-4-john.g.garry@oracle.com/
>
> We shouldn't be getting anywhere near the iomap layer if the IO is
> not properly aligned to atomic IO constraints...

So current generic_atomic_write_valid() function mainly checks alignment
w.r.t logical offset and iter->len. 

What this function was checking was on the physical block offset and
mapped extent length. Hence it was made after iomap_iter() call.
i.e. ...

 +	/* map_len should be same as user specified iter->len */
 +	if (map_len < iter->len)
 +		return false;
 +	/* start should be aligned to block device min atomic unit alignment */
 +	if (!IS_ALIGNED(start, awu_min))
 +		return false;


But I agree, that maybe we can improve generic_atomic_write_valid()
to be able to work on both logical and physical offset and
iter->len + mapped len. 

Let me think about it. 

However, the point on which I would like a feedback from others is - 
1. After filesystem has returned the mapped extent in iomap_iter() call,
iomap will be forming a bio to be sent to the block layer.
So do we agree to add a check here in iomap layer to verify that the
mapped physical start and len should satisfy the requirements for doing
atomic writes?

>
> So, yeah, can you please co-ordinate the development of this
> patchset with John and the work that has already been done to
> support this functionality on block devices and XFS?

We actually are in a way. If you see this ext4 series is sitting on top of
John's v5 series of "block atomic write". This patch [1] ([RFC 5/8] part
of this series), in ext4 does use generic_atomic_write_valid() function
for DIO atomic write validity.

[1]: https://lore.kernel.org/linux-ext4/e332979deb70913c2c476a059b09015904a5b007.1709361537.git.ritesh.list@gmail.com/T/#u


Thanks for your review!

-ritesh

