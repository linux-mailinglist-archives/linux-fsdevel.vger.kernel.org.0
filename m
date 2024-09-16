Return-Path: <linux-fsdevel+bounces-29435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72B979AB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 07:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEE41F21D05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B833CF73;
	Mon, 16 Sep 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="DDyNIUed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DDE1C6A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464311; cv=none; b=I320IiMaq4p7UkBjHdL72bYwlRQIjavgwI+7iohM96ht+4oU7YfczL63JBZxZa0XLv3hgJ9OqignUqCdC8OF4v5cR1cihkutAexeGKA+CA5tw2HaBao+pKqW6bIYZZiI7P5FZFLTuY1NQlmA2iWdjCrmg5italBXwrreQGtIGQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464311; c=relaxed/simple;
	bh=PhJ/SoT4Su2eCZ3H9ERTVVKe4Gr+MBCEFQis4hJXPUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMXh2e0w45DzRNDpXsP9EvagJI0zEWUYkwwS2df/826FhgzLTt11K+Lq0N1Tuy1SvphZZvHvYzUa1YxJw6aPfS9MRRUwacIA+WhujcnwBTqboUEgQkFBkNbxWOxAXV4fWd7HKDEBDV0100n/uKlUcSh/t/krSkX2saLBA3aEYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=DDyNIUed; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso2315194a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 22:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726464309; x=1727069109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t95e1qcO4+iPyF80N5QwYplS3cfQKDQlUQ1sYj2roR8=;
        b=DDyNIUedvasIB61jCxDVj6dfDkDxTgW5krMgI0ALuUs9549+f4N8VA2tnaiJQB6d7q
         zfFaU+oJvVUovpt6JyHFZEvUq/S4ehh1waCO7PzMebt7UHL4ke62xZhsNy0eERCVEdbR
         bRwu3xWE4ERi5iNG3rbZEkTjkO30WVlfx/nBqsuazpT0Vap8suUG8YdqXmw5N3eSm0Tu
         mk6QhcW3AUD4tcbgOMM+7ttNBHBfmpX8n2QXizJGbrkOcB6uEs3P7/vDtsOWpfa3A/el
         /CXuhTJgQ/DsWKhGpJhsfKLiR+c7MxvJxMtN9EgZgbiWalqWRx0/uaDQuQml6cIOZtiU
         dW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726464309; x=1727069109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t95e1qcO4+iPyF80N5QwYplS3cfQKDQlUQ1sYj2roR8=;
        b=ShtpR3qD+DBqEl8ffKXaz0JNv7pSiq3RoGGZjdb24UYdDAs3ddHfTwlkBeUIyLZALz
         cKrQazqCoTAKyyG4GXYG9EnpT6iuRczMqG7w5OwbIX30rsFPXikF1KS6ssp0Sqcp98ov
         k7e1M7Fcl/8M0OgZ926E9yy3lSYT37CKx1gCTntlEzIk1DDA9kObFNYPidUmrncVfr+Y
         NcppvZu1MhrfpIuTLz1+3rxYjDzxVPKnHDQuUNxTi/gKgPhPuIMc+5XjtEmSulxdX7mp
         aYa1X0QlgTOu4VjmJYgY4/mg+yFzKUExXOpLnZ6HLfY8Ok66s1qo2MRNZXJ2v/iZcE6a
         SYEA==
X-Forwarded-Encrypted: i=1; AJvYcCVc2WkSdaLLK35yO1ia7mgneSZZ9Q0Ux0qj/N3Y+F2bAe0PDlapSZ+I6Md6DekWit1iOGjFnnomjLsAKM3k@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvTSWVwlfW9uUnNz5rkLOzWkLxonzAvzEiSoLgMra4hGsKB8Z
	hnGvlw4WL0SOZinbMtB9hMm8LaDhzCrUKD4V/T5jjna4JaeIb2uaVp0itkkvsWo=
X-Google-Smtp-Source: AGHT+IEHGbm4xNdN5V7XtNCeTolX7s6jFjSEe/NND3t9+4BGW16UNLZLW4kw1PWvx4PK910j+Os2uQ==
X-Received: by 2002:a05:6a21:e97:b0:1cf:337e:9919 with SMTP id adf61e73a8af0-1cf75ebadf6mr18034189637.16.1726464309278;
        Sun, 15 Sep 2024 22:25:09 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998fb22sm3455524a12.65.2024.09.15.22.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 22:25:08 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sq4EU-005nVa-1M;
	Mon, 16 Sep 2024 15:25:06 +1000
Date: Mon, 16 Sep 2024 15:25:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
	djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 00/14] forcealign for xfs
Message-ID: <ZufBMioqpwjSFul+@dread.disaster.area>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <87frqf2smy.fsf@gmail.com>
 <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>

On Mon, Sep 09, 2024 at 05:18:43PM +0100, John Garry wrote:
> > > > Patch 10 also modifies xfs_can_free_eofblocks() to take alignment
> > > > into account for the post-eof block removal, but doesn't change
> > > > xfs_free_eofblocks() at all. i.e  it also relies on
> > > > xfs_itruncate_extents_flags() to do the right thing for force
> > > > aligned inodes.
> > > 
> > > What state should the blocks post-EOF blocks be? A simple example of
> > > partially truncating an alloc unit is:
> > > 
> > > $xfs_io -c "extsize" mnt/file
> > > [16384] mnt/file
> > > 
> > > 
> > > $xfs_bmap -vvp mnt/file
> > > mnt/file:
> > >   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > >     0: [0..20479]:      192..20671        0 (192..20671)     20480 000000
> > > 
> > > 
> > > $truncate -s 10461184 mnt/file # 10M - 6FSB
> > > 
> > > $xfs_bmap -vvp mnt/file
> > > mnt/file:
> > >   EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > >     0: [0..20431]:      192..20623        0 (192..20623)     20432 000000
> > >     1: [20432..20447]:  20624..20639      0 (20624..20639)      16 010000
> > >   FLAG Values:
> > >      0010000 Unwritten preallocated extent
> > > 
> > > Is that incorrect state?
> > 
> > Think about it: what happens if you now truncate it back up to 10MB
> > (i.e. aligned length) and then do an aligned atomic write on it.
> > 
> > First: What happens when you truncate up?
> > 
> > ......
> > 
> > Yes, iomap_zero_range() will see the unwritten extent and skip it.
> > i.e. The unwritten extent stays as an unwritten extent, it's now
> > within EOF. That written->unwritten extent boundary is not on an
> > aligned file offset.
> 
> Right
> 
> > 
> > Second: What happens when you do a correctly aligned atomic write
> > that spans this range now?
> > 
> > ......
> > 
> > Iomap only maps a single extent at a time, so it will only map the
> > written range from the start of the IO (aligned) to the start of the
> > unwritten extent (unaligned).  Hence the atomic write will be
> > rejected because we can't do the atomic write to such an unaligned
> > extent.
> 
> It was being considered to change this handling for atomic writes. More
> below at *.

I don't think that this is something specific to atomic writes -
forced alignment means -alignment is guaranteed- regardless of what
ends up using it.

Yes, we can track unwritten extents on an -unaligned- boundary, but
that doesn't mean that we should allow it when we are trying to
guarantee logical and physical alignment of the file offset and
extent boundaries. i.e. The definition of forced alignment behaviour
is that all file offsets and extents in the file are aligned to the
same alignment.

I don't see an exception that allows for unaligned unwritten
extents in that definition.


> > That's not a bug in the atomic write path - this failure occurs
> > because of the truncate behaviour doing post-eof unwritten extent
> > conversion....
> > 
> > Yes, I agree that the entire -physical- extent is still correctly
> > aligned on disk so you could argue that the unwritten conversion
> > that xfs_bunmapi_range is doing is valid forced alignment behaviour.
> > However, the fact is that breaking the aligned physical extent into
> > two unaligned contiguous extents in different states in the BMBT
> > means that they are treated as two seperate unaligned extents, not
> > one contiguous aligned physical extent.
> 
> Right, this is problematic.
> 
> * I guess that you had not been following the recent discussion on this
> topic in the latest xfs atomic writes series @ https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/
> and also mentioned earlier in
> https://lore.kernel.org/linux-xfs/20240726171358.GA27612@lst.de/
> 
> There I dropped the sub-alloc unit zeroing. The concept to iter for a single
> bio seems sane, but as Darrick mentioned, we have issue of non-atomically
> committing all the extent conversions.

Yes, I understand these problems exist.  My entire point is that the
forced alignment implemention should never allow such unaligned
extent patterns to be created in the first place. If we avoid
creating such situations in the first place, then we never have to
care about about unaligned unwritten extent conversion breaking
atomic IO.

FWIW, I also understand things are different if we are doing 128kB
atomic writes on 16kB force aligned files. However, in this
situation we are treating the 128kB atomic IO as eight individual
16kB atomic IOs that are physically contiguous. Hence in this
situation it doesn't matter if we have a mix of 16kB aligned
written/unwritten/hole extents as each 16kB chunks is independent of
the others.

What matters is that each indivudal 16kB chunk shows either the old
data or the new data - we are not guaranteeing that the entire 128kB
write is atomic. Hence in this situation we can both submit and
process each 16kB shunk as independent IOs with independent IO
compeltion transactions. All that matters is that we don't signal
completion to userspace until all the IO is complete, and we already
do that for fragmented DIO writes...

> > Again, this is different to the traditional RT file behaviour - it
> > can use unwritten extents for sub-alloc-unit alignment unmaps
> > because the RT device can align file offset to any physical offset,
> > and issue unaligned sector sized IO without any restrictions. Forced
> > alignment does not have this freedom, and when we extend forced
> > alignment to RT files, it will not have the freedom to use
> > unwritten extents for sub-alloc-unit unmapping, either.
> > 
> So how do you think that we should actually implement
> xfs_itruncate_extents_flags() properly for forcealign? Would it simply be
> like:
> 
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1050,7 +1050,7 @@ xfs_itruncate_extents_flags(
>                 WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
>                 return 0;
>         }
> +	if (xfs_inode_has_forcealign(ip))
> +	       first_unmap_block = xfs_inode_roundup_alloc_unit(ip,
> first_unmap_block);
>         error = xfs_bunmapi_range(&tp, ip, flags, first_unmap_block,

Yes, it would be something like that, except it would have to be
done before first_unmap_block is verified.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

