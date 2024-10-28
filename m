Return-Path: <linux-fsdevel+bounces-33046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B121B9B2B84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71836282207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 09:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582CA1D278C;
	Mon, 28 Oct 2024 09:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDENCYm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46F199247;
	Mon, 28 Oct 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107490; cv=none; b=VR0SsAHUVTpvHCOm7j8CgseRT/DtMJBB3cty4Buf+VxDgZgVU3RZPtS+OyIwSmbGm8+zmGXbmibDJGZx87GArmmU2hEGWKQ8y7nsQ1JkTfz2rdZ1Pkge2b4XNNvOz9y2YjQpAQsg0q1P4ofgd1FLkRlm0JXuExa1oQ8gYf/9UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107490; c=relaxed/simple;
	bh=ZV9RBcstAJev0uUdkdHZIT0ZH8NAfdvVV5j+xySTPjE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jCI/vll7YJGoUX16DwSg55uThAKDNgfY8SwhyXcF4u0PhKojpeVMG5f20yGgQVm6OoZcyO3ocHxdbyOicPwfJX7/rtrix8+Vtsl5XfvXRykNSv8lODT1Tv8+lGEnuJ6FJDbiXTzdqp11l2zBGh+YDKgkN8uvOf9PYpbDBeErH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDENCYm7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e91403950dso260066a91.3;
        Mon, 28 Oct 2024 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730107487; x=1730712287; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4arsEPgLvopJkZ0EO0mxM7Hlfe/zqijt2s3+ooF9jok=;
        b=HDENCYm7GUTAJeCzR+n8AtTTPRv6YXd6A5Ldhnjw4CAHFV1Anr507GvjIYfQRdBcc7
         +1bgEyjIHVKS8jAcQ+RxrtVDchgpp+rSE/q3arXmWSvWvrZm+aHqEZ3Ut3YDaO14zQ2V
         ZjxwGabFhXcpI9QXBeRozFzvxmuSA2FeWrnErULdTJE/xJiiNBERKl8szEYg6luTYnOh
         yJgpi+gvbbupHzPFBE+EQOPbwwBnuVYoZzPKDfmDDEtVjbqhoKkl/OOEjETd+NtsAKCc
         4M293fxM020vrDF8w74cDMpLBRXdKU3cXFK/gsrhOY766dYLROxfVyAo5/jStHNlIlV2
         mCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107487; x=1730712287;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4arsEPgLvopJkZ0EO0mxM7Hlfe/zqijt2s3+ooF9jok=;
        b=fTJ2ahn8geI7XfNQgUaBF7bIUGkLcc8xES8Q5CpnouD5XYyl/H6hCBTrMPETZ9eN9t
         y5tqejCM5Yv6KUZHMpy3N0lqJgN+PJf0wGZcID5zchMLYgCMqLFip4plZEjU+D34OA3J
         4xKUUX45dy4bmPjal7hZ1FNijOub2CU4JIACAx0yd/FE4hvNkNuBVctv4pa6+BJg8vYM
         QqWl8izEoCXUMu6Rs6N/MfnL8VSyRxnC3YDB9obCUvxMwX2n+AVcke/o+KcPmX0mYc3V
         rjcZomth2UF7ICqM2a2lexGNt36W2vsdPYuAE40qne8s2roSHAHkAd701BzlPIR6chCW
         031Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+WuqtGd6GdwxK+LleTrQYUPvhEdk/C0G4Kt/CCurDzp4+y9UfqlDeTrdBveiEGrIMQwod0hVQzpv/YfV3@vger.kernel.org, AJvYcCWBrKwZerCHz/DS8QuhFiqm7q3o+fJMH01j0D33GVZaA0cvT7S1jvqpHss1V7YnuYzehpp4LKYLVlhi6cDj@vger.kernel.org, AJvYcCXirYG0pmjptVd3CR0jajgQMtvGk1sM2pNzjSdXFBY/4EwHX3iP7xQVnfBhz3SIJAQmi0DS4JoGJr47@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0J1QMwt1Pb8iSWYaRWhUzoHTsn1hpY1S6K6H8V3Sx9+CQ/p8a
	596H2/LpapomNVHYc8vjtJ8mgh/U0rYX4A7vA9RTgxzUnCtNR1I9ugDmZg==
X-Google-Smtp-Source: AGHT+IGZUQenfUPUmlTWBuGMWDZvH08YhwJYtXJrfvnf1RSW0PPEJptrNxQI9FEs/ZPyMHG7tqeTbQ==
X-Received: by 2002:a17:90a:e7cd:b0:2e2:c406:ec8d with SMTP id 98e67ed59e1d1-2e8f11b96admr10022723a91.31.1730107486942;
        Mon, 28 Oct 2024 02:24:46 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771814sm6645564a91.52.2024.10.28.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:24:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] ext4: Warn if we ever fallback to buffered-io for DIO atomic writes
In-Reply-To: <Zx8ga59h0JgU/YIC@dread.disaster.area>
Date: Mon, 28 Oct 2024 14:13:54 +0530
Message-ID: <87bjz4mxbp.fsf@gmail.com>
References: <cover.1729825985.git.ritesh.list@gmail.com> <7c4779f1f0c8ead30f660a2cfbdf4d7cc08e405a.1729825985.git.ritesh.list@gmail.com> <Zx6+F4Cl1owSDspD@dread.disaster.area> <87iktdm3sf.fsf@gmail.com> <Zx8ga59h0JgU/YIC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Dave Chinner <david@fromorbit.com> writes:

> On Mon, Oct 28, 2024 at 06:39:36AM +0530, Ritesh Harjani wrote:
>> 
>> Hi Dave, 
>> 
>> Dave Chinner <david@fromorbit.com> writes:
>> 
>> > On Fri, Oct 25, 2024 at 09:15:53AM +0530, Ritesh Harjani (IBM) wrote:
>> >> iomap will not return -ENOTBLK in case of dio atomic writes. But let's
>> >> also add a WARN_ON_ONCE and return -EIO as a safety net.
>> >> 
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  fs/ext4/file.c | 10 +++++++++-
>> >>  1 file changed, 9 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> >> index f9516121a036..af6ebd0ac0d6 100644
>> >> --- a/fs/ext4/file.c
>> >> +++ b/fs/ext4/file.c
>> >> @@ -576,8 +576,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>> >>  		iomap_ops = &ext4_iomap_overwrite_ops;
>> >>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>> >>  			   dio_flags, NULL, 0);
>> >> -	if (ret == -ENOTBLK)
>> >> +	if (ret == -ENOTBLK) {
>> >>  		ret = 0;
>> >> +		/*
>> >> +		 * iomap will never return -ENOTBLK if write fails for atomic
>> >> +		 * write. But let's just add a safety net.
>> >> +		 */
>> >> +		if (WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC))
>> >> +			ret = -EIO;
>> >> +	}
>> >
>> > Why can't the iomap code return EIO in this case for IOCB_ATOMIC?
>> > That way we don't have to put this logic into every filesystem.
>> 
>> This was origially intended as a safety net hence the WARN_ON_ONCE.
>> Later Darrick pointed out that we still might have an unconverted
>> condition in iomap which can return ENOTBLK for DIO atomic writes (page
>> cache invalidation).
>
> Yes. That's my point - iomap knows that it's an atomic write, it
> knows that invalidation failed, and it knows that there is no such
> thing as buffered atomic writes. So there is no possible fallback
> here, and it should be returning EIO in the page cache invalidation
> failure case and not ENOTBLK.
>

Sorry my bad. I think I might have looked into a different version of
the code earlier. So the current patch from John already takes care of
the condition where if the page cache invalidation fails we don't return
-ENOTBLK [1]

[1]: https://lore.kernel.org/linux-xfs/Zxnp8bma2KrMDg5m@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/T/#m3664bbe00287d98caa690bb04f51d0ef164f52b3

>> You pointed it right that it should be fixed in iomap. However do you
>> think filesystems can still keep this as safety net (maybe no need of
>> WARN_ON_ONCE).
>
> I don't see any point in adding "impossible to hit" checks into
> filesystems just in case some core infrastructure has a bug
> introduced....
>

So even though we have taken care of that case from page cache
invalidation code, however it can still happen if iomap_iter()
ever returns -ENOTBLK.  

e.g. 

    blk_start_plug(&plug);
	while ((ret = iomap_iter(&iomi, ops)) > 0) {
		iomi.processed = iomap_dio_iter(&iomi, dio);

		/*
		 * We can only poll for single bio I/Os.
		 */
		iocb->ki_flags &= ~IOCB_HIPRI;
	}

	blk_finish_plug(&plug);

	/*
	 * We only report that we've read data up to i_size.
	 * Revert iter to a state corresponding to that as some callers (such
	 * as the splice code) rely on it.
	 */
	if (iov_iter_rw(iter) == READ && iomi.pos >= dio->i_size)
		iov_iter_revert(iter, iomi.pos - dio->i_size);

	if (ret == -EFAULT && dio->size && (dio_flags & IOMAP_DIO_PARTIAL)) {
		if (!(iocb->ki_flags & IOCB_NOWAIT))
			wait_for_completion = true;
		ret = 0;
	}

	/* magic error code to fall back to buffered I/O */
	if (ret == -ENOTBLK) {
		wait_for_completion = true;
		ret = 0;
	}

Reviewing the code paths there is a lot of ping pongs between core iomap
and FS. So it's not just core iomap what we are talking about here.

So I am still inclined towards having that check in place as a safety net. 
However - let me take some time to review some of this code paths
please. I wanted to send this email mainly to mention the point that
page cache invalidation case is already taken care in iomap for atomic
writes, so there is no bug there. 

I will get back on rest of the cases after I have looked more closely at it.

> -Dave.
>
> -- 
> Dave Chinner
> david@fromorbit.com

Thanks for the review!
-ritesh


