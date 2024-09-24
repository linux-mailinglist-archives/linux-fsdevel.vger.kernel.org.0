Return-Path: <linux-fsdevel+bounces-29924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7F4983B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 05:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16581F23871
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FFF36130;
	Tue, 24 Sep 2024 03:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="YUpd9d/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CB1CFBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148860; cv=none; b=TjGZON/Q5yxefJcrmvvuHSK1CO59XHY0krzQRca7sY8KSHQOxP2KJr0ShmEa9IXUyeCVtB53KWl9AVfrkMtm+UZ9kU5DLgf/aUtCFmw54C9TfLdIvo41+5d9BKSP1xl5w3d2o0Z5KVCjtoUPgR6L68THPaSkT5kvGoXZbD94uHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148860; c=relaxed/simple;
	bh=z1dOkhvrMWny0ohbL42mv6n+7Xdf2nXp1JIvTFKjenw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZfyuaGuFD1IyigxXdsqhG5sajuIAT+6ck89iamm/FRqIHQesRROprC8xqxwrwqdvMj8PwVmgG3FTXkn14z3xaRlQZVcoxQT4tLZ2IbmUWx3aix9RYTgkt28XhhnlSlmWIUg/7GSjx1g4hE80xXIJxzg4phxGFhk/Z/0IlvQyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=YUpd9d/J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055a3f80a4so31520405ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 20:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727148858; x=1727753658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/SKj4lWI1yJlZOtC07mR6A3SxW5HcZiLXldmOIyxwo=;
        b=YUpd9d/JlzZtdSZt+6CIO3OiWz7shf2HDWMi8QMtLoPNe1QbAfHjHmAgBjrtq7ypQJ
         GY6SBxFCJDUpcxV1rv+OOwQYS3XVjV4ffuyZmaAp54hx3SyTOCG6zukb691Tjh27pk4Q
         jsctXYtIm4s6kdvIfLfyMZ/vCBuJJgtxMysNWujULBltquRUYw2m6Sz8faOHRVaucI55
         3NHqhp3T+RYRCYPeir7bfZDfSTWKQsaVw5KLZ32i5jMwfF/gH+PTCTwVl7XuOTVFPUMr
         /Ys3oI+fq25fEldvQOogVZaqRm37fXiBvA11LSy2x2ZOhIVgWfUMe8eP1Bbw9Nz3v9FQ
         fcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727148858; x=1727753658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/SKj4lWI1yJlZOtC07mR6A3SxW5HcZiLXldmOIyxwo=;
        b=FUV/Hewb8ymoi6mORmSLsV10p9ZaJUDEcTH+32AaCnOb6mRHwO0U46cP5MssaUYtrc
         ZnDj/XPLaqlVE9T4zeZgTe3lkYcKt4rQijBLgH5EKtSMPtzwb54kj9bB0J6cH1icPJFk
         DYr4U4H2xbIx78AowXYLa896AF+if1RXb5+BDvAbBUSpP1jzCOGQCPZHdshnIExpwEPy
         HBME8XatFNK0X6E6Y6aMVCS2nfFYa2PACKGChOGRb3xSFj4pgZy6myIoR5Do1kdikJ7y
         45xDzOVIvlXAC13jHwLyP2q33fLU9gR5eHR9Dc7R5WbW1H0be8Kcqdih422Dd4w04GYw
         S0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXAw7TBBlJbPUj1XfvLXnDBjOBXkodTgFhmx5wnDhKQZBDTREOlOCXNRozLJCAx+xiJrCjnxpupZ2+nbBTW@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eHaD8/3+LmULiH2kHCXUhzQ048jwgwpkatbp5Aeq1vqqsx/r
	aZA7/K2vtHhlMAyZwPjKm4/IBrtDGOrWs5+BFCsCNtzVFyV/rn3wdSqIopaAp6w=
X-Google-Smtp-Source: AGHT+IH3lRAeJYZlmh0xwaPd9RsTWL2j6QkCXJrNFRv9mB3OVeKtUOXeyHBewN2Wk8kyVcvwOLtk2Q==
X-Received: by 2002:a17:902:d2d1:b0:205:40a6:115a with SMTP id d9443c01a7336-208d9872fc8mr201072425ad.48.1727148857727;
        Mon, 23 Sep 2024 20:34:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0435sm2435535ad.13.2024.09.23.20.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 20:34:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sswJa-009GFU-0W;
	Tue, 24 Sep 2024 13:34:14 +1000
Date: Tue, 24 Sep 2024 13:34:14 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <ZvIzNlIPX4Dt8t6L@dread.disaster.area>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74sgzrvtnry4wganaatcmxdsfwauv6r33qggxo27yvricrzxvq@77knsf6cfftl>

On Mon, Sep 23, 2024 at 10:55:57PM -0400, Kent Overstreet wrote:
> On Mon, Sep 23, 2024 at 07:26:31PM GMT, Linus Torvalds wrote:
> > On Mon, 23 Sept 2024 at 17:27, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > However, the problematic workload is cold cache operations where
> > > the dentry cache repeatedly misses. This places all the operational
> > > concurrency directly on the inode hash as new inodes are inserted
> > > into the hash. Add memory reclaim and that adds contention as it
> > > removes inodes from the hash on eviction.
> > 
> > Yeah, and then we spend all the time just adding the inodes to the
> > hashes, and probably fairly seldom use them. Oh well.
> > 
> > And I had missed the issue with PREEMPT_RT and the fact that right now
> > the inode hash lock is outside the inode lock, which is problematic.
> > 
> > So it's all a bit nasty.
> > 
> > But I also assume most of the bad issues end up mainly showing up on
> > just fairly synthetic benchmarks with ramdisks, because even with a
> > good SSD I suspect the IO for the cold cache would still dominate?
> 
> Not for bcachefs, because filling into the vfs inode cache doesn't
> require a disk read - they're cached in the inodes btree and much
> smaller there. We use a varint encoding so they're typically 50-100
> bytes, last I checked.
> 
> Compare to ~1k, plus or minus, in the vfs inode cache.
> 
> Thomas Bertshinger has been working on applications at LANL where
> avoiding pulling into the vfs inode cache seems to make a significant
> difference (file indexing in his case) - it turns out there's an xattr
> syscall that's missing, which I believe he'll be submitting a patch for.
> 
> But stat/statx always pulls into the vfs inode cache, and that's likely
> worth fixing.

No, let's not even consider going there.

Unlike most people, old time XFS developers have direct experience
with the problems that "uncached" inode access for stat purposes.

XFS has had the bulkstat API for a long, long time (i.e. since 1998
on Irix). When it was first implemented on Irix, it was VFS cache
coherent. But in the early 2000s, that caused problems with HSMs
needing to scan billions inodes indexing petabytes of stored data
with certain SLA guarantees (i.e. needing to scan at least a million
inodes a second).  The CPU overhead of cache instantiation and
teardown was too great to meet those performance targets on 500MHz
MIPS CPUs.

So we converted bulkstat to run directly out of the XFS buffer cache
(i.e. uncached from the perspective of the VFS). This reduced the
CPU over per-inode substantially, allowing bulkstat rates to
increase by a factor of 10. However, it introduced all sorts of
coherency problems between cached inode state vs what was stored in
the buffer cache. It was basically O_DIRECT for stat() and, as you'd
expect from that description, the coherency problems were horrible.
Detecting iallocated-but-not-yet-updated and
unlinked-but-not-yet-freed inodes were particularly consistent
sources of issues.

The only way to fix these coherency problems was to check the inode
cache for a resident inode first, which basically defeated the
entire purpose of bypassing the VFS cache in the first place.

So we went back to using coherent lookups once we stopped caring
about the old SGI HSM SLA requirements back in 2010:

commit 7dce11dbac54fce777eea0f5fb25b2694ccd7900
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Jun 23 18:11:11 2010 +1000

    xfs: always use iget in bulkstat

    The non-coherent bulkstat versionsthat look directly at the inode
    buffers causes various problems with performance optimizations that
    make increased use of just logging inodes.  This patch makes bulkstat
    always use iget, which should be fast enough for normal use with the
    radix-tree based inode cache introduced a while ago.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Dave Chinner <dchinner@redhat.com>

Essentially, we now always being inodes into cache as fully
instantiated VFS inodes, and mark them with I_DONT_CACHE so they get
torn down immediately after we've used them if they weren't already
cached. (i.e. all accesses are done in a single task context with
the inode hot in the CPU caches.)

Without the patchset I pointed to, bulkstat maxxes out the VFS inode
cache cycling on the sb->s_inodes_list_lock at about 700,000
inodes/sec being cycled through the cache. With that patchset, it
maxxed out the bandwidth of the NVMe SSDs I was using  at ~7GB/s
read IO and cycling about 6 million inodes/sec through the VFS cache.

IOWs, we can make the VFS inode cache scale way beyond what most
users actually need right now.

The lesson in all this?

Don't hack around VFS scalability issues if it can be avoided.

If we fix the problems properly in the first place, then most fs
developers (let alone users!) won't even realise there was a
scalability problem in the VFS to begin with. Users will, however,
notice every inconsistency and/or corruption caused by fs developers
trying to work around VFS cache limitations...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

