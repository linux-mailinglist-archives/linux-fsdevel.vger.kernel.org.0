Return-Path: <linux-fsdevel+bounces-9026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB683D1FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71421F261C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 01:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16FEC3;
	Fri, 26 Jan 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="IS31o1Sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E72387
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 01:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232158; cv=none; b=GGxGkeieJ3HCftH8rqtn4evhub6plHSK0qU/B6IegTon8jI2Ih9ajAB/vwRCgiO214A7961CK73vdyf+FvZH3dE/nitMeIMkk9JegYLN3z6WUki635Sy70iKcvu1p+1dGIF9ZgyjLLeUQ28Ta3NDfBXd4KlxTMKsNklAn3P54Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232158; c=relaxed/simple;
	bh=1F+rAV36tC4Kz6ldSv8ppWHrgr0CFC1kXTRmrXsF77U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8so98n+bglGFyySsHzxGC+7ahSSZ2unoO65L1ZaxskZAQjbhosxO9ObIL94B0UwIibFsKspenUjBiKlNjHRIhf0AJvEwfQsmsDW8+MXX2a/KKXg5IxsBK1IV0Wd93MoREOtVLlefWm2v+JrRXxCPGVtpF8kxVT8THtWlW+LeK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=IS31o1Sp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6de83f5a004so5039763a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 17:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706232156; x=1706836956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgZmrHj0PVUb7yLYlnrjN1ZfCHfN35i+bqGTjY/Xxl4=;
        b=IS31o1SplTY/7j1Z4awxuQmYGZ4USqeuJ2GzF8v3IvZoUyf6A7y6g6ygDGW5JhGVXq
         JrSpk3qglzL3lwzgeZSe/SFvjJ2Jfr0+QydiYp8tp6sB6bzeE7PMuZnI10i0etsp9gAt
         IZxfx6CC2z1V5U997tU2+ny217q5+KK5zl9AQw6XEHEiu/g2OSAd1OoXJdXzBhaI5pDM
         psc168in/3mFftpreAfveW426Dp2Feou5RexDgV65ifx5VFkSWyzehaxnCJ5uTExjzU6
         +781HwVNInE2R9op+LGbBY+jqLB8bi/0qd/HUVp8JIi+aP6ymhFnNHj0bCbcK6WJHlls
         7WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232156; x=1706836956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgZmrHj0PVUb7yLYlnrjN1ZfCHfN35i+bqGTjY/Xxl4=;
        b=Sn2GRH3VDqJB1wC1Ny7oHLraMxxLT73pz+llOPNoAoLiG7di/6ZMJutpzPjXHO2Iw5
         kmScTsu16gj3TgkQzzYw7s4whg+NTXxhPTIvxWhuLADdPIXFGIUPlq/K8EexR0IbX+0G
         foOUMUrOoKAEo5qD/5Aw7Qmr8G2oH1SGUTqiWm7nSvJb/E8nWYpnQVPvaS31uMVdkwqm
         RIO/JxJFRp4a4iMkN3dtc5bCR4uir02iF7mRK8k2qLLoAe/RGy3rMeTm/xZ5++iPFjfw
         K+PUF25gSgpshwmaO29JrPvlrJ69ANjgWCx0hE5hT5yrWHubDhPrsslQB4FrAviAzI+1
         mYag==
X-Gm-Message-State: AOJu0YzKzzXdiZDSMYMbEHvKOhRakecCnl5Hs1Msb09siQE7kZaff8I4
	6sKAFolTcjzqOe3ahNvyYRIRRtg+q2BVb87/R7O/H0k+hpUhm1sWQ1PAs+CVQJg=
X-Google-Smtp-Source: AGHT+IHODhzOdYDSYbBuxGs1xG5yIwFSKcKTSM2CBMh8KEuICI7CS/GtQwi/BQuLmOUF2kdLEU1+fg==
X-Received: by 2002:a9d:6848:0:b0:6dc:7512:636c with SMTP id c8-20020a9d6848000000b006dc7512636cmr752143oto.68.1706232155901;
        Thu, 25 Jan 2024 17:22:35 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id u33-20020a056a0009a100b006d9aaee2f57sm147194pfg.102.2024.01.25.17.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:22:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rTAvQ-00FKrj-1J;
	Fri, 26 Jan 2024 12:22:32 +1100
Date: Fri, 26 Jan 2024 12:22:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	Matthew Wilcox <willy@infradead.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
 <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>

On Thu, Jan 25, 2024 at 07:19:45PM +0900, Namjae Jeon wrote:
> 2024-01-25 6:35 GMT+09:00, Dave Chinner <david@fromorbit.com>:
> > On Wed, Jan 24, 2024 at 10:05:15AM +0000, Yuezhang.Mo@sony.com wrote:
> >> From: Matthew Wilcox <willy@infradead.org>
> >> Sent: Wednesday, January 24, 2024 1:21 PM
> >> To: Mo, Yuezhang <Yuezhang.Mo@sony.com>
> >> Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
> >> exfat_file_mmap()
> >> > On Wed, Jan 24, 2024 at 05:00:37AM +0000, mailto:Yuezhang.Mo@sony.com
> >> > wrote:
> >> > > inode->i_rwsem should be locked when writing file. But the lock
> >> > > is missing when writing zeros to the file in exfat_file_mmap().
> >> >
> >> > This is actually very weird behaviour in exfat.  This kind of "I must
> >> > manipulate the on-disc layout" is not generally done in mmap(), it's
> >> > done in ->page_mkwrite() or even delayed until we actually do
> >> > writeback.
> >> > Why does exfat do this?
> >>
> >> In exfat, "valid_size" describes how far into the data stream user data
> >> has been
> >> written and "size" describes the file size.  Return zeros if read
> >> "valid_size"~"size".
> >>
> >> For example,
> >>
> >> (1) xfs_io -t -f -c "pwrite -S 0x59 0 1024" $filename
> >>      - Write 0x59 to 0~1023
> >>      - both "size" and "valid_size" are 1024
> >> (2) xfs_io -t -f -c "truncate 4K" $filename
> >>      - "valid_size" is still 1024
> >>      - "size" is changed to 4096
> >>      - 1024~4095 is not zeroed
> >
> > I think that's the problem right there. File extension via truncate
> > should really zero the bytes in the page cache in partial pages on
> > file extension (and likley should do it on-disk as well). See
> > iomap_truncate_page(), ext4_block_truncate_page(), etc.
> >
> > Leaving the zeroing until someone actually accesses the data leads
> > to complexity in the IO path to handle this corner case and getting
> > that wrong leads directly to data corruption bugs. Just zero the
> > data in the operation that exposes that data range as zeros to the
> > user.
> We need to consider the case that mmap against files with different
> valid size and size created from Windows. So it needed to zero out in mmap.

That's a different case - that's a "read from a hole" case, not a
"extending truncate" case. i.e. the range from 'valid size' to EOF
is a range where no data has been written and so contains zeros.
It is equivalent to either a hole in the file (no backing store) or
an unwritten range (backing store instantiated but marked as
containing no valid data).

When we consider this range as "reading from a hole/unwritten
range", it should become obvious the correct way to handle this case
is the same as every other filesystem that supports holes and/or
unwritten extents: the page cache page gets zeroed in the
readahead/readpage paths when it maps to a hole/unwritten range in
the file.

There's no special locking needed if it is done this way, and
there's no need for special hooks anywhere to zero data beyond valid
size because it is already guaranteed to be zeroed in memory if the
range is cached in the page cache.....

> We tried to improve this after receiving a report of a compatibility
> issue with linux-exfat, where the two file sizes are set differently
> from Windows.
> 
> https://github.com/exfatprogs/exfatprogs/issues/213
> 
> Yue referred to mmap code of ntfs3 that has valid-size like exfat and
> had handled it in mmap.

Saying "but someone else did the same thing" doesn't make it the
right thing to do. It just means someone else has already done it
the wrong way, and it wasn't noticed during review. :/

-Dave.
-- 
Dave Chinner
david@fromorbit.com

