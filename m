Return-Path: <linux-fsdevel+bounces-29726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1263697CF3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 00:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34C12845F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBA1B2EDD;
	Thu, 19 Sep 2024 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZxLDelKH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840A5381A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726785261; cv=none; b=Mq4MvSHTPhkubyWGguAyFpt6nXr/0e8RkBqy1VGIgj2ipAfx3e1VN8D20qzCt6Zlmh45ZmUAEyclmd6wCwHBYxWvDfXlmSAUxe03x3b+msV1dSjcbf0eE9hKw6JP2FWbptSnT0x+fEcPdGJwMTlL+x40EqtcCMBV0MMm26auFyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726785261; c=relaxed/simple;
	bh=g/ecMF/sw/yVF1INJCRkpTfEM+9BG73xHJwB2ynrrLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nr5/y7adbf9EfDq9CNi1wBJ9bq6gieeljePtXwMFtyhMdeJgdaijLcswdERFepxgYDAamt3P0cliRneXIg0WYSnwvWqvQAhv076HhzEa4xxNqqTi1Vs1VsEY+SwDxR6E3haOajpKFJPWPtibaYAzOtHBDLKwCqluB0bPWYbSA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZxLDelKH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so1026623b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726785259; x=1727390059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPylLiZ7PWxP0wN+w7CEhhbolesJkThAPqP1eba+Vi0=;
        b=ZxLDelKHT+0Ug/j9re2TbR4Ybf9GeG4hPCgvHstjPJZvDXA2BxU+xI/UglNXEPH+VW
         /PqqUiKDAEwGtqT1OL1sgYiK8OOWgXcAOMS9iOh11dmEysvcIMj/mFQbnr1zsiMTKnXB
         jsxMOxSd8HybmuiZWH/z6wa3uZ9dwfwjUpXHWq6bf3LNm42ZVuwhZdOmM5CdLLxxT1Xl
         C+9HGWhVz5eWsHl5WU6BCpTUrI5Gl6E+PEne3/gYROr/QbJ7Tjq7hrgOLl7E5s5+PZD3
         gWABF//8lZENAlrQl1+Eus8v6EnlVu5YCi3cVDs3r9XynZ6bCMdnnRigjED1aWydW+D1
         ORng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726785259; x=1727390059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPylLiZ7PWxP0wN+w7CEhhbolesJkThAPqP1eba+Vi0=;
        b=PeTHGlFBueA13oDST/oEgy/YfMpKmKMVr89SYme/7nf76jjjfwfysxFL+Jr7onR+JT
         tyNtnFe7qHFwNa92rppue8FMjXm/X9NEPJ/MSMPDboNZRJNiWyPkRkELAsJbzvol9LXh
         x5DQ7NNQ98rAgaM5bQFFx3oI4sBgoh/to16cN0f5JjsZGymAZyRtgQw4cZlsN+3sIE9a
         uM6/07mjSfEt9RUr56z1L/Jt8uRS/KKYgESoJnhl3J0bF7pNRxtnJrnpaqU2FOWF8esP
         lJAml887hguMzs75KzxQ8tDoVFG/7uZgyWXVJWMKss0JwydTcmhuf8oFJYdi9uOUVigS
         gqpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXkgp1u/ehSCpvTtLpCjSNUDUAOOHDhEKgLyigYMLuXM7C9CrzvhZJBBP861rTao5SJLAcjnYByWusIvaa@vger.kernel.org
X-Gm-Message-State: AOJu0YySKUSpbuyrFdTdXzO1nU6RmyCdpJCIXNjSiHaHA7YPsTQ3NAER
	f/o+skRHeWg2KyosYAdn6hFrg0DvF89guVbUCtdRf8m3QOelesxbaBN16qQhH98=
X-Google-Smtp-Source: AGHT+IFTKz5dpfb+KDYUMX6NntS62oh+fxC5f3xzf9TFJpXVhvPLuHHJFeIgB7iSz4vzGVBOooAxZQ==
X-Received: by 2002:a05:6a00:13a4:b0:714:3acb:9d4b with SMTP id d2e1a72fcca58-7199ce207bcmr857880b3a.18.1726785258792;
        Thu, 19 Sep 2024 15:34:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b110sm8763605b3a.134.2024.09.19.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 15:34:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1srPj4-007QGw-1o;
	Fri, 20 Sep 2024 08:34:14 +1000
Date: Fri, 20 Sep 2024 08:34:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
	dchinner@redhat.com
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
Message-ID: <Zuym5suTo/KYUAND@dread.disaster.area>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
 <ZuqjU0KcCptQKrFs@dread.disaster.area>
 <ZuvPDQ+S/u4FdNNU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuvPDQ+S/u4FdNNU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>

On Thu, Sep 19, 2024 at 12:43:17PM +0530, Ojaswin Mujoo wrote:
> On Wed, Sep 18, 2024 at 07:54:27PM +1000, Dave Chinner wrote:
> > On Wed, Sep 11, 2024 at 02:31:04PM +0530, Ojaswin Mujoo wrote:
> > Behaviour such as extent size hinting *should* be the same across
> > all filesystems that provide this functionality.  This makes using
> > extent size hints much easier for users, admins and application
> > developers. The last thing I want to hear is application devs tell
> > me at conferences that "we don't use extent size hints anymore
> > because ext4..."
> 
> Yes, makes sense :)  
> 
> Nothing to worry here tho as ext4 also treats the extsize value as a
> hint exactly like XFS. We have tried to keep the behavior as similar
> to XFS as possible for the exact reasons you mentioned. 

It is worth explicitly stating this (i.e. all the behaviours that
are the same) in the design documentation rather than just the
corner cases where it is different. It was certainly not clear how
failures were treated.

> And yes, we do plan to add a forcealign (or similar) feature for ext4 as
> well for atomic writes which would change the hint to a mandate

Ok. That should be stated, too.

FWIW, it would be a good idea to document this all in the kernel
documentation itself, so there is a guideline for other filesystems
to implement the same behaviour. e.g. in
Documentation/filesystems/extent-size-hints.rst

> > > 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
> > >    hint. That means on XFS for eof allocations (with extsize hint) only logical
> > >    start gets aligned.
> > 
> > I'm not sure I understand what you are saying here. XFS does extsize
> > alignment of both the start and end of post-eof extents the same as
> > it does for extents within EOF. For example:
> > 
> > # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "bmap -vvp" foo
> > wrote 4096/4096 bytes at offset 0
> > 4 KiB, 1 ops; 0.0308 sec (129.815 KiB/sec and 32.4538 ops/sec)
> > foo:
> > EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> >    0: [0..7]:          256504..256511    0 (256504..256511)     8 000000
> >    1: [8..31]:         256512..256535    0 (256512..256535)    24 010000
> >  FLAG Values:
> >     0100000 Shared extent
> >     0010000 Unwritten preallocated extent
> > 
> > There's a 4k written extent at 0, and a 12k unwritten extent
> > beyond EOF at 4k. I.e. we have an extent of 16kB as the hint
> > required that is correctly aligned beyond EOF.
> > 
> > If I then write another 4k at 20k (beyond both EOF and the unwritten
> > extent beyond EOF:
> > 
> > # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "pwrite 20k 4k" -c "bmap -vvp" foo
> > wrote 4096/4096 bytes at offset 0
> > 4 KiB, 1 ops; 0.0210 sec (190.195 KiB/sec and 47.5489 ops/sec)
> > wrote 4096/4096 bytes at offset 20480
> > 4 KiB, 1 ops; 0.0001 sec (21.701 MiB/sec and 5555.5556 ops/sec)
> > foo:
> >  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> >    0: [0..7]:          180000..180007    0 (180000..180007)     8 000000
> >    1: [8..39]:         180008..180039    0 (180008..180039)    32 010000
> >    2: [40..47]:        180040..180047    0 (180040..180047)     8 000000
> >    3: [48..63]:        180048..180063    0 (180048..180063)    16 010000
> >  FLAG Values:
> >     0100000 Shared extent
> >     0010000 Unwritten preallocated extent
> > 
> > You can see we did contiguous allocation of another 16kB at offset
> > 16kB, and then wrote to 20k for 4kB.. i.e. the new extent was
> > correctly aligned at both sides as the extsize hint says it should
> > be....
> 
> Sorry for the confusion Dave. What was meant is that XFS would indeed
> respect extsize hint for EOF allocations but if we close the file, since
> we trim the blocks past EOF upon close, we would only see that the
> lstart is aligned but the end would not.

Right, but that is desired behaviour, especially when extsize is
large.  i.e. when the file is closed it is an indication that the
file will not be written again, so we don't need to keep post-eof
blocks around for fragmentation prevention reasons.

Removing post-EOF extents on close prevents large extsize hints from
consuming lots of unused space on files that are never going to be
written to again(*).  That's user visible, and because it can cause
premature ENOSPC, users will report this excessive space usage
behaviour as a bug (and they are right).  Hence removing post-eof
extents on file close when extent size hints are in use comes under
the guise of Good Behaviour To Have.

(*) think about how much space is wasted if you clone a kernel git
tree under a 1MB extent size hint directory. All those tiny header
files now take up 1MB of space on disk....

Keep in mind that when the file is opened for write again, the
extent size hint still gets applied to the new extents.  If the
extending write starts beyond the EOF extsize range, then the new
extent after the hole at EOF will be fully extsize aligned, as
expected.

If the new write is exactly extending the file, then the new extents
will not be extsize aligned - the start will be at the EOF block,
and they will be extsize -length-.  IOWs, the extent size is
maintained, just the logical alignment is not exactly extsize
aligned. This could be considered a bug, but it's never been an
issue for anyone because, in XFS, physical extent alignment is
separate (and maintained regardless of logical alignment) for extent
size hint based allocations.

Adding force-align will prevent this behaviour from occurring, as
post-eof trimming will be done to extsize alignment, not to the EOF
block.  Hence open/close/open will not affect logical or physical
alignment of force-align extents (and hence won't affect atomic
writes).

-Dave.
-- 
Dave Chinner
david@fromorbit.com

