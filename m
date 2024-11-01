Return-Path: <linux-fsdevel+bounces-33402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF809B89DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 04:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD51C20E66
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28808144D01;
	Fri,  1 Nov 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh4EnK7z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B1413C9A4;
	Fri,  1 Nov 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431028; cv=none; b=snlXlwCzT33apo1+izfFngGVpbw54e7kQYTcu8Q6WxTqa1tI2YJHpdkF0qXbyLGpblAdAJRG9y10FijLFvHsKg+MJ5UdhLFv/FdWAoTOZXJEp4gafR4l+SN3oCnVuV401/VPfg5vShukYoJzWGuZ5D+1NjyHF99Qp9y22L/uTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431028; c=relaxed/simple;
	bh=C34BvjwkI7ip7vWr5F+5OztvzheGZHJBHE44is5Amy4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=XlnnVa8XcNkPvmtTrVoVbw71auIe6PqOqbou907b5LVxx12aiFYSImfW7SZMy92njmZ/WDD9dcCpqsRjU2ic2BDXH4K7BlqAPu8RMKWNpmbVuD2kP2YK5W8DkMh82kkY7Wn5S2PcoYuciQz3phqSElOUuXS9ZBYlhNkeslI0sHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh4EnK7z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so1208793a12.0;
        Thu, 31 Oct 2024 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431025; x=1731035825; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eQHeJYJMiWQgVcB83ltfxRkmEP0Z+jaxx3ZbRoO0JNk=;
        b=eh4EnK7zpKE5fbfq1ZX5IeVDM2vCIE+fdLgiZPkAY5vloj6HdtxgkZmHYawxdl8ZEk
         aQKWWck9FRKDO/nn3hGBj0OV8fZ0kfiC/QiOi/+SCoBVRpAElp3KQUTL6VqgFz4aqUB7
         rmMPBDtUNSE8YR62Lc5tjvLcYocD8ez5FMImlh9YrnWYvCtCxvzloC/Ad5/ytFhC6nwM
         LTJD3iJWHwq9qjZPEOGQJJuNU4zBUo/S2VEzRt0ubN/DGM399PPso+Z+5UEOBB5qHj78
         8bhWooymf2cXnZtWnlUwB+rb2ppa2isDH/hCHlQlAvc12k5/zN49b6MqTUUzWV+ACkW2
         VehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431025; x=1731035825;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQHeJYJMiWQgVcB83ltfxRkmEP0Z+jaxx3ZbRoO0JNk=;
        b=JwD1rzMn7dM2kKx6789L7IN5E+0SSZ4iLK9ybzQ+YLFnoEzmv567q3bwOzPURNQKSp
         gZlyZpyYiXHxJX/bL2NznRjRQBhhgJgE4fNicTi2BIL/ZeGFlNWKHb/k8utvVC/aW96K
         siiefxrhXkUXvGfJ86XGpXRogNjp5VCZuurQztNIQ6oeZN4mxYaswe8LM3EU+88JaMqi
         tqjbcqikzmR8Ta2jwZCHaxTqWVKIfiOJ2+ByepqmQZtkYCfl53Uf6y6tY5xHP1jvTSPw
         OQN/0kEV6EXc9e7241+wHxlY2g+NQbKt1z3UCOe+bEkamAeONofojaeN7ifN9DH3a6EP
         3E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaLAJBjsPRs/2py2efpPUa2TaO/ZgVErItDAqcOJgym7D1sv/B53bNWX8ZG9bzCVP/qyIONFzOAFxg@vger.kernel.org, AJvYcCVUVFpCa3MeniwDEUz8uQa8c7yJptLVWSxlpIZ3XojrL/MdImctDZfAOksfzhLXAJ99b+4jz3sNSFOqC2rc@vger.kernel.org, AJvYcCWyOVHy0KRY3h7H0Qw+p5PfTCAj42BvCafskkP3zA6WlU2nJjOkHgYpF6GzaI+ScFz6NUJZAYLVWo4Qvdqo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yn5DyObuCbXO28MVu2nCxC3ulFbIhJFXoIWyEKguaMdC8xNC
	qiRf/Wk2mzViHFT2wjkgJrVMQXoQkNIbF6eadMXuPMqCvpKuC2fwRVp+Aw==
X-Google-Smtp-Source: AGHT+IG7+BrXI8EZ64Tpvc4GtpKul/4xOEvw6ZgbJiOiojc2M/zTqPQ943LllcKoBKh09C0gIU8GEg==
X-Received: by 2002:a05:6a21:e8e:b0:1d9:2453:433e with SMTP id adf61e73a8af0-1db91d517c4mr5987324637.4.1730431025171;
        Thu, 31 Oct 2024 20:17:05 -0700 (PDT)
Received: from dw-tp ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8d2fsm1887059b3a.9.2024.10.31.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 20:17:04 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ext4: Do not fallback to buffered-io for DIO atomic write
In-Reply-To: <20241031215111.GF21832@frogsfrogsfrogs>
Date: Fri, 01 Nov 2024 08:41:42 +0530
Message-ID: <874j4rzlzl.fsf@gmail.com>
References: <cover.1730286164.git.ritesh.list@gmail.com> <3c6f41ebed5ca2a669fb05ccc38e8530d0e3e220.1730286164.git.ritesh.list@gmail.com> <20241031215111.GF21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Wed, Oct 30, 2024 at 09:27:41PM +0530, Ritesh Harjani (IBM) wrote:
>> atomic writes is currently only supported for single fsblock and only
>> for direct-io. We should not return -ENOTBLK for atomic writes since we
>> want the atomic write request to either complete fully or fail
>> otherwise. We should not fallback to buffered-io in case of DIO atomic
>> write requests.
>> Let's also catch if this ever happens by adding some WARN_ON_ONCE before
>> buffered-io handling for direct-io atomic writes.
>> 
>> More details of the discussion [1].
>> 
>> [1]: https://lore.kernel.org/linux-xfs/cover.1729825985.git.ritesh.list@gmail.com/T/#m9dbecc11bed713ed0d7a486432c56b105b555f04
>> 
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>  fs/ext4/file.c  |  7 +++++++
>>  fs/ext4/inode.c | 14 +++++++++-----
>>  2 files changed, 16 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 8116bd78910b..61787a37e9d4 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -599,6 +599,13 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>  		ssize_t err;
>>  		loff_t endbyte;
>>  
>> +		/*
>> +		 * There is no support for atomic writes on buffered-io yet,
>> +		 * we should never fallback to buffered-io for DIO atomic
>> +		 * writes.
>> +		 */
>> +		WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
>> +
>>  		offset = iocb->ki_pos;
>>  		err = ext4_buffered_write_iter(iocb, from);
>>  		if (err < 0)
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index fcdee27b9aa2..26b3c84d7f64 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3449,12 +3449,16 @@ static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>>  {
>>  	/*
>>  	 * Check to see whether an error occurred while writing out the data to
>> -	 * the allocated blocks. If so, return the magic error code so that we
>> -	 * fallback to buffered I/O and attempt to complete the remainder of
>> -	 * the I/O. Any blocks that may have been allocated in preparation for
>> -	 * the direct I/O will be reused during buffered I/O.
>> +	 * the allocated blocks. If so, return the magic error code for
>> +	 * non-atomic write so that we fallback to buffered I/O and attempt to
>> +	 * complete the remainder of the I/O.
>> +	 * For atomic writes we will simply fail the I/O request if we coudn't
>> +	 * write anything. For non-atomic writes, any blocks that may have been
>> +	 * allocated in preparation for the direct I/O will be reused during
>> +	 * buffered I/O.
>>  	 */
>> -	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
>> +	if (!(flags & IOMAP_ATOMIC) && (flags & (IOMAP_WRITE | IOMAP_DIRECT))
>
> Huh.  The WRITE|DIRECT check doesn't look right to me, because the
> expression returns true for any write or any directio.  I think that's
> currently "ok" because ext4_iomap_end is only called for directio
> writes, but this bugs me anyway.  For a directio write fallback, that
> comparison really should be:
>
> 	(flags & (WRITE|DIRECT)) == (WRITE|DIRECT)
>

yes. You are right. It is working since ext4 only supports iomap
for DIRECTIO. But I agree it's better be fixed to avoid problem in future.

> static inline bool
> ext4_want_directio_fallback(unsigned flags, ssize_t written)
> {
> 	/* must be a directio to fall back to buffered */
> 	if (flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> 		    (IOMAP_WRITE | IOMAP_DIRECT)
> 		return false;
>
> 	/* atomic writes are all-or-nothing */
> 	if (flags & IOMAP_ATOMIC)
> 		return false;
>
> 	/* can only try again if we wrote nothing */
> 	return written == 0;
> }
>
> 	if (ext4_want_directio_fallback(flags, written))
> 		return -ENOTBLK;
>

I like the above helper. Thanks for doing that. 
I will incorporate this in v4.


>> +			&& written == 0)
>
> Nit: put the '&&' operator on the previous line when there's a multiline
> expression.
>

I guess we don't need this if we do it with your above inline helper.
But sure, next time will keep in mind for any such changes.

> --D
>

Thanks for the review!
-ritesh

>>  		return -ENOTBLK;
>>  
>>  	return 0;
>> -- 
>> 2.46.0
>> 
>> 

