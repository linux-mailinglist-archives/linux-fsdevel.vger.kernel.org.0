Return-Path: <linux-fsdevel+bounces-21097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A58FE169
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 10:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C3287BF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 08:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F84213D8AC;
	Thu,  6 Jun 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YbKTq5JE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD513CFAF
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663628; cv=none; b=FVi7GdWY4XzRw3/agEC74Dt+hY0qmojVJxnqo/Nl91jx8cbj2KjOEvHeVNCIwNqMY2k3XQhiEgNl3fjGDKnO0o+X2MSJ+q3wAyLczrgGWdner1LuhGnRyFIKSubXyKyUi2CBLn2TP5y4H/kUhHZieHot5fLBd5vTejhmOlvpuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663628; c=relaxed/simple;
	bh=Cniel9xmz6tFmH21G0iQilDoqldTJ7+he557GBpk4mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrlQsfqjAKZawg1FUOYezH54vzRyfl53UuQWlUL2XCRDzBJ8qBrJH6h750KcqWjJoQ5MbTWOPIN7TzsIGJftC+dPdOM1xwmIe8aw+Ws32+vkUMQCKhSc04aJ+pAgmmWejILZl9GVE/9pAcRNWHiFNkhYQlvAEhdJjk/eCowbwik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YbKTq5JE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70260814b2dso532230b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 01:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717663627; x=1718268427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=41y8XHGYPcaf8xhTg/yf8k7aSgLq6vpwTaajj5o1iV0=;
        b=YbKTq5JE7bUxuyGpvh8Td2MgBPekNV4/yshy/pLrOTb/G3Dpd8grz/Ox1yxGavclOc
         FeMKPKeX8y+AwkxSwV9i6LQrZPcApskmCCNxxkAW6eG9mUJ0Wf1PUt9kJLELmtdSCTGA
         8nD5S3N8q17ciI8V/d80e7sbATg+KWk3L3ItXx3garZwvd91RTltr7GevJs8FXUR+bXt
         vGGZzCcOwQNZguIYmBKbGnw0B8xaFu141N/jQiLynApX/zrKNqlLGnZ2eWizIBKV0eOP
         /DiEaekdE7UkSk/oIUh0zjbDl6vcn572oLKTgWzz6Itfo8lzS5g5KSPDhqMuaPf8xofn
         mWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663627; x=1718268427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41y8XHGYPcaf8xhTg/yf8k7aSgLq6vpwTaajj5o1iV0=;
        b=d0ZvdyQgsohUjQP8030f1UtAdXYnSqeAlN3ZHLoGuLAi5SZyfthES2yjlRjvAoPe3f
         zHRDnyoyGEg3mgRcxDOI0dLlNZNrAgGe6KbZwaKF5OSy9GtXUIcmr1hdBptBN/ekCsrw
         SxuqFiKOzsgWgkahpsHfE+B1A5XY5LzGmSuifHuLJ3WE+x/UhmKGq/Lk7Uq19ul9Puwl
         mJKKWS3M4QCq/Ef3jKB95+svSAiHAhJQQv8N6OFqXPHi+YXdUwpwsy12K/p7LcIVqIH7
         Ha87dZ9xfXGlJ1bgOFclUmi26r0k4BQ2q5JqCZ9vQzh9yLUclbxeetaxgUn6S8mCF8kF
         xAnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0pqGizVmYOvpbn8bSuPfyK3lSkoLAnukhUng5i1vgKHscjK4EqPkexh3CanCU7gPlgkzkPLoAzaaP6wV7XRSGoRU+41Qrv142ZlVbNA==
X-Gm-Message-State: AOJu0YwMeaPQHjT91+FSEdpprYEVDDmUcF4YuKuQlWjPZEiKP+alexSy
	oFncfAOjt7AVjiMPaMEziYt/FVq9gDfx2YM8ugCd5NvsbX788Ud0YG9F2aQEIfE=
X-Google-Smtp-Source: AGHT+IHjGeY29y4OU+xw1rBhPOFqtYDVJ8x9JMmJjh9yFx+g6FM2F5NCbVZSw7OeTFhUfQU8Amb4dA==
X-Received: by 2002:a05:6a20:2447:b0:1b2:cd79:f41b with SMTP id adf61e73a8af0-1b2cd7a18aamr558625637.25.1717663626447;
        Thu, 06 Jun 2024 01:47:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28957153sm695226a12.91.2024.06.06.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:47:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sF8lz-006AWk-0H;
	Thu, 06 Jun 2024 18:47:03 +1000
Date: Thu, 6 Jun 2024 18:47:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v3 07/21] fs: xfs: align args->minlen for forced
 allocation alignment
Message-ID: <ZmF3h2ObrJ5hNADp@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-8-john.g.garry@oracle.com>
 <c9ac2f74-73f9-4eb5-819e-98a34dfb6b23@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9ac2f74-73f9-4eb5-819e-98a34dfb6b23@oracle.com>

On Wed, Jun 05, 2024 at 03:26:11PM +0100, John Garry wrote:
> Hi Dave,
> 
> I still think that there is a problem with this code or some other allocator
> code which gives rise to unexpected -ENOSPC. I just highlight this code,
> above, as I get an unexpected -ENOSPC failure here when the fs does have
> many free (big enough) extents. I think that the problem may be elsewhere,
> though.
> 
> Initially we have a file like this:
> 
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        62592..62719      0 (62592..62719)     128
>    1: [128..895]:      hole                                   768
>    2: [896..1023]:     63616..63743      0 (63616..63743)     128
>    3: [1024..1151]:    64896..65023      0 (64896..65023)     128
>    4: [1152..1279]:    65664..65791      0 (65664..65791)     128
>    5: [1280..1407]:    68224..68351      0 (68224..68351)     128
>    6: [1408..1535]:    76416..76543      0 (76416..76543)     128
>    7: [1536..1791]:    62720..62975      0 (62720..62975)     256
>    8: [1792..1919]:    60032..60159      0 (60032..60159)     128
>    9: [1920..2047]:    63488..63615      0 (63488..63615)     128
>   10: [2048..2303]:    63744..63999      0 (63744..63999)     256
> 
> forcealign extsize is 16 4k fsb, so the layout looks ok.
> 
> Then we truncate the file to 454 sectors (or 56.75 fsb). This gives:
> 
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        62592..62719      0 (62592..62719)     128
>    1: [128..455]:      hole                                   328
>
> We have 57 fsb.
> 
> Then I attempt to write from byte offset 232448 (454 sector) and a get a
> write failure in xfs_bmap_select_minlen() returning -ENOSPC; at that point
> the file looks like this:

So you are doing an unaligned write of some size at EOF and EOF is
not aligned to the extsize?

>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL
>    0: [0..127]:        62592..62719      0 (62592..62719)     128
>    1: [128..447]:      hole                                   320
>    2: [448..575]:      62720..62847      0 (62720..62847)     128
> 
> That hole in ext #1 is 40 fsb, and not aligned with forcealign granularity.
> This means that ext #2 is misaligned wrt forcealign granularity.

OK, so the command to produce this would be something like this?

# xfs_io -fd -c "truncate 0" \
	-c "chattr +<forcealign>" -c "extsize 64k" \
	-c "pwrite 0 64k -b 64k" -c "pwrite 448k 64k -b 64k" \
	-c "bmap -vvp" \
	-c "truncate 227k" \
	-c "bmap -vvp" \
	-c "pwrite 227k 64k -b 64k" \
	-c "bmap -vvp" \
	/mnt/scratch/testfile

> This is strange.
> 
> I notice that we when allocate ext #2, xfs_bmap_btalloc() returns
> ap->blkno=7840, length=16, offset=56. I would expect offset % 16 == 0, which
> it is not.

IOWs, the allocation was not correctly rounded down to an aligned
start offset.  What were the initial parameters passed to this
allocation? i.e. why didn't it round the start offset down to 48?
Answering that question will tell you where the bug is.

Of course, if the allocation start is rounded down to 48, then
the length should be rounded up to 32 to cover the entire range we
are writing new data to.

> In the following sub-io block zeroing, I note that we zero the front padding
> from pos=196608 (or fsb 48 or sector 384) for len=35840, and back padding
> from pos=263680 for len=64000 (upto sector 640 or fsb 80). That seems wrong,
> as we are zeroing data in the ext #1 hole, right?

The sub block zeroing is doing exactly the right thing - it is
demonstrating the exact range that the force aligned allocation
should have covered.

> Now the actual -ENOSPC comes from xfs_bmap_btalloc() -> ... ->
> xfs_bmap_select_minlen() with initially blen=32 args->alignment=16
> ap->minlen=1 args->maxlen=8. There xfs_bmap_btalloc() has ap->length=8
> initially. This may be just a symptom.

Yeah, now the allocator is trying to fix up the mess that the first unaligned
allocation created, and it's tripping over ENOSPC because it's not
allowed to do sub-extent size hint allocations when forced alignment
is enabled....

> I guess that there is something wrong in the block allocator for ext #2. Any
> idea where to check?

Start with tracing exactly what range iomap is requesting be
allocated, and then follow that through into the allocator to work
out why the offset being passed to the allocation never gets rounded
down to be aligned. There's a mistake in the logic somewhere that is
failing to apply the start alignment to the allocation request (i.e.
the bug will be in the allocation setup code path. i.e. somewhere
in the xfs_bmapi_write -> xfs_bmap_btalloc path *before* we get to
the xfs_alloc_vextent...() calls.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

