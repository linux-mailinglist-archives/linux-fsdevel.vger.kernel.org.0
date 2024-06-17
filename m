Return-Path: <linux-fsdevel+bounces-21854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED41290BFB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 01:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED301C21F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 23:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA61993A5;
	Mon, 17 Jun 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HUmW2Ahe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30D194C94
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666294; cv=none; b=X1/pRxxbToH8N8OtKyijOYxfP7I2w5Y4Qexx2XxE/60NVT42U4s+V83wScfu6GpqSuzqsNDhrFu1Z0GZ0oTOjII+W5zSH800OzRk5YgzHN1xgs7EdaijcmJRVFMuLJbTVi79fzpcZCTTPbag9ImQd2YFXRaMfrcyzHkDv2QpMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666294; c=relaxed/simple;
	bh=pcP3BpdjhmmxqdiTKi9niOwSo5grD2DrIFHASx9xk2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw9c10v8rR+FFoibBdHOuWD9PsV3JDTQ/J1c4XB8RHiU3UnjL9WgPehpRAs7FCI/em5n6iuY1l+6NwAe+1JIjwDJ8Vd0OOw2lgw4VHUkw5QVD6fxg/Q86IB+Hqq7WurYaAb5XNUImhs+lYjAqSywoIuLxsolkXC6k2AH55mv7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HUmW2Ahe; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-70df2135439so292992a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 16:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1718666292; x=1719271092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaehIoCCMbdtbvnUIS3Bk9WXrmvq/8zVNdJb/nDEkms=;
        b=HUmW2Ahe5S9AqqF9UkjtWiUxOZ5XU6dJrGR9QYkgI5zbvU8Nh/5E233mJrmm+y8rdJ
         c8WSrYtvZglsPa1LijMe2LebKJHB8LI9uJuDn9hq9DfpzUnMRyRSYHvZsDN+yX+Psr1a
         j/W0XNtuVTILAotGboEMI1uTFEPPGsNXzj3JG3mnZawFJSUiFwgdUaPHvVFxwQXVg8o1
         vPx/m6STqHf479xeKEM5Gwu3br7XdeFRW9uoqhyPz/t0c5dZJheM1GgV9ScsLRTfAIxc
         IyH/Dzx4PprmMciSZJ4CiCA7oQxmYo5+L06wv2SBFG+750l+h28XOIPeJoSI54xgY90B
         DpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718666292; x=1719271092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaehIoCCMbdtbvnUIS3Bk9WXrmvq/8zVNdJb/nDEkms=;
        b=g9bBiv1kjUlfFxZmx6O/BnbBj6yBMSvBAweq3Fy/Itz7gn/uTyTLZAe641WlxY3fqw
         L9+NAMlF9H89CTVNwRAj0txunLij7ObBwpSngK++av3JB6fkzVh/rwZ7y/TnZX86pxdY
         JACQpCu7QTXimhZ0aIcV4GmKwkOQlblpDKcUhWjCQU9vugyUwkTFXnk/ECSxVs1lDa/H
         yetJlwQfYio6hWWVZ9CkdnXITs7ZN1/arIahl3j12ZQKIlfhL5teaaTzkBhojcrAvETr
         TWs/IeuzCyDV8PQLfV2nXkklOwHqHCb9Bb0W/vDRlWfnM8+0AJDtwvB0PH8vBreDvRXR
         nfVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDNhluudY4JG3yBEfAxfAc0CS6qdttECw+ZfU9mJEDI6Mqi/T2ryk1r2wDES7h5U4SAofiJmOngvqivauwSLjjfNckx64Q4UYNUO0IcA==
X-Gm-Message-State: AOJu0Yzgtzy7HDievcRJy5Rtizi63AQI0i/nVHfJDWpUhDc648y+YBdM
	I/J31P9fvAC/oE5YhPlbwTfz9P0CqPw3jNRBmN6zvisAhzyUoX/oyA7QWvm+gzU=
X-Google-Smtp-Source: AGHT+IFZ5VaDbnJgrc4upZ8ziIxaNBi9yUsEpjQiocgmkB3SKh6FhcEhl90ontDwiZTKwkEGHbQzuw==
X-Received: by 2002:a05:6a20:321b:b0:1b8:5967:45bc with SMTP id adf61e73a8af0-1bae83a39fdmr9164501637.61.1718666291634;
        Mon, 17 Jun 2024 16:18:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee2d3673dsm7103023a12.69.2024.06.17.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:18:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sJLc0-0025gT-1w;
	Tue, 18 Jun 2024 09:18:08 +1000
Date: Tue, 18 Jun 2024 09:18:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, djwong@kernel.org,
	chandan.babu@oracle.com, brauner@kernel.org,
	akpm@linux-foundation.org, willy@infradead.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, Zi Yan <zi.yan@sent.com>,
	linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	cl@os.amperecomputing.com, john.g.garry@oracle.com
Subject: Re: [PATCH v7 11/11] xfs: enable block size larger than page size
 support
Message-ID: <ZnDEME/qMAzqli8l@dread.disaster.area>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-12-kernel@pankajraghav.com>
 <20240613084725.GC23371@lst.de>
 <Zm+RhjG6DUoat7lO@dread.disaster.area>
 <20240617065104.GA18547@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617065104.GA18547@lst.de>

On Mon, Jun 17, 2024 at 08:51:04AM +0200, Christoph Hellwig wrote:
> On Mon, Jun 17, 2024 at 11:29:42AM +1000, Dave Chinner wrote:
> > > > +	if (mp->m_sb.sb_blocksize > PAGE_SIZE)
> > > > +		igeo->min_folio_order = mp->m_sb.sb_blocklog - PAGE_SHIFT;
> > > > +	else
> > > > +		igeo->min_folio_order = 0;
> > > >  }
> > > 
> > > The minimum folio order isn't really part of the inode (allocation)
> > > geometry, is it?
> > 
> > I suggested it last time around instead of calculating the same
> > constant on every inode allocation. We're already storing in-memory
> > strunct xfs_inode allocation init values in this structure. e.g. in
> > xfs_inode_alloc() we see things like this:
> 
> While new_diflags2 isn't exactly inode geometry, it at least is part
> of the inode allocation.  Folio min order for file data has nothing
> to do with this at all.

Yet ip->i_diflags2 is *not* initialised in xfs_init_new_inode()
when we physically allocate and initialise a new inode. It is set
for all inodes when they are allocated in memory, regardless of
their use.

Whether that is the right thing to do or not is a separate issue -
xfs_inode_from_disk() will overwrite it in every inode read case
that isn't a create.

Indeed, We could do the folio order initialisation in
xfs_setup_inode() where we set up the mapping gfp mask, but that
doesn't change the fact we set it up for every inode that is
instantiated in memory or that we want it pre-calculated...

> > The only other place we might store it is the struct xfs_mount, but
> > given all the inode allocation constants are already in the embedded
> > mp->m_ino_geo structure, it just seems like a much better idea to
> > put it will all the other inode allocation constants than dump it
> > randomly into the struct xfs_mount....
> 
> Well, it is very closely elated to say the m_blockmask field in
> struct xfs_mount.

Not really. The block mask is a property of the and used primarily
for manipulating lengths in units of FSB to/from byte counts and
vice versa. It is used all over the place, and the only guaranteed
common structure that all those callers have access to is the
xfs_mount.

OTOH, the folio order is only used for regular files to tell the
page cache how to behave. The scope of the folio order setup is the
same as mapping_set_gfp_mask() - is it only used in one place and
used for inode configuration. I may have called the structure "inode
geometry" because that described what it contained when I first
implemented it, but that doesn't mean that is all that is can
contain. It contains static, precalculated inode configuration
values, and that what we are adding here...

> The again modern CPUs tend to get a you simple
> subtraction for free in most pipelines doing other things, so I'm
> not really sure it's worth caching for use in inode allocation to
> start with, but I don't care strongly about that.

It's not the cost of a subtraction that is the problem -
precalculation is about avoiding a potential branch misprediction in
a hot path that would stall the CPU. If there were no branches, it
wouldn't be an issue, but this value cannot be calculated without at
least one branch in the logic.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

