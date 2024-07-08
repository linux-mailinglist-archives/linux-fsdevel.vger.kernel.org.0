Return-Path: <linux-fsdevel+bounces-23276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C8A92A0C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179011F2211E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D54E8062A;
	Mon,  8 Jul 2024 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="SREvpOmE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9B80034
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437165; cv=none; b=qRAR6yaOOt8oAc10dlCbeTfRv2cw42ZaUU0j873uMaWGFYQPDc08A1XdIRcwhdUZLHBc6Vy9rjydLzGn9nrA8AheOh27rDGxOBWScepb+xVk5Bmi4IlyTA+GORezhdO+1LsLF/V/cWE/4jfbYmMGkeuUDvDnFXcmya1X0q+KvkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437165; c=relaxed/simple;
	bh=A2Amlxz9Q+VLZ+ZbVuZyhOzaRtPRJ07PVprnUekDnmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOYR5aTE47MuisP4jZ+hV0dL6ELQ2BteuZDDJPtoY5Y2YutPH2d/Tdr9mFzmEYaAOvkeK1W70HYBKnMcGVWgpZ0hBwMCfBaUQXJ5f8v43Fsu1S/RAUzea8yEdoNlN8jXedwoKGuwr4le4AZQqq4wtIvWHxtjYSHgsXSkJhm9iUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=SREvpOmE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-707040e3018so2437609a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720437163; x=1721041963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSy3YtVRLz8Qqrmq3FDZ7/bd/sxHOLhAnKAcU2qf1+s=;
        b=SREvpOmElyUxuPMoPV5gDO6lQycyumWwEg3q8ANSZf0dyj3h6Qv7zO71CZwm6JUSLG
         ANINJb9l1Kq0dUPvu99KnCYMX2wpGX+CxOiwCaBvkFtQc/aqeGWKfTUdg2ao+FPlIwDs
         lc4E+0Tsr6He4knX6DqPqngTxevPxq9qeF/mG9qnHInR95zcMyR3Wd+3IuKDqPePlwCe
         5ESXAbHFZ46NshUX82oaCdDBGy+U7IUe6qPb7WbiVmKGNnAbpdq3CqJo/xjDQNaOMKwG
         CZ305KFvgEA/I6RI2EhnfnN45lAVLtRRucq6RxmP12qlt5RtoaK2jEmP5gQtsq8fbwep
         R88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437163; x=1721041963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSy3YtVRLz8Qqrmq3FDZ7/bd/sxHOLhAnKAcU2qf1+s=;
        b=XuL+WLmzNBuae3wfaFk1CwEQPn081ZqDqHYxSfNEqqn3o2z8tG+bhlN4w/Q42FRGip
         Zny5GVNpgL828q2jiTOzU9AWrny8oL9t6iVezPnYzvTcDHY6bkgb0wTKalIp60aquJbN
         NfLp8rYUkAwlnyna0kCZWnIFGa9t0kSu2EzC0TidNqX+eXVFSd0a4JYsVI/zo3WLgbZa
         1PEBSUx15/KGg1sIKMrvcI92pB5kbZbQRU3JkrnF89RAzxlUfs4qVxfUg8HUFT+00FMb
         DPrXeXNfANFwMPi4hCeiRVP2pRC3svOg/KAPfhy5lGUENOeQDVjaTaZGSQ5T1KOhKG33
         0RAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWxVkm1MjbZot0jV9Oqp7eBJIFw1XZOJOYk6qVyL/msWwHvolLkjPkJWouM1Izq4nFrn7SSxeI5YlqNHcv338pO2tnqTyqv/w4dzN+xA==
X-Gm-Message-State: AOJu0YxFgSTaISRmUYU5RS8WxoyKojagilr2OtehifN+y5divBG62TAB
	Mi4s9IE3jO1B2EuswKtpfkdOo+vbCu8WTjld2p9zYMoOdk5suieyKJ7nQlPirEk=
X-Google-Smtp-Source: AGHT+IHfNuRXWdkd9A3TuADFoTsa8jBjnmvwH6ZaWhwnmXrfHwV8g/iNZoGZuUc1/0V1do1JY2onFw==
X-Received: by 2002:a05:6a20:7349:b0:1c2:74b4:a05d with SMTP id adf61e73a8af0-1c274b4a983mr2918085637.23.1720437163092;
        Mon, 08 Jul 2024 04:12:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb48b1bb5bsm58699265ad.1.2024.07.08.04.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:12:42 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sQmIS-008S5V-1F;
	Mon, 08 Jul 2024 21:12:40 +1000
Date: Mon, 8 Jul 2024 21:12:40 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, djwong@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v2 08/13] xfs: Do not free EOF blocks for forcealign
Message-ID: <ZovJqNFyHYRWRVbA@dread.disaster.area>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-9-john.g.garry@oracle.com>
 <20240706075609.GB15212@lst.de>
 <ZotEmyoivd1CEAIS@dread.disaster.area>
 <6427a661-2e92-49a0-8329-7f67e8dd5c35@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6427a661-2e92-49a0-8329-7f67e8dd5c35@oracle.com>

On Mon, Jul 08, 2024 at 08:36:52AM +0100, John Garry wrote:
> On 08/07/2024 02:44, Dave Chinner wrote:
> > On Sat, Jul 06, 2024 at 09:56:09AM +0200, Christoph Hellwig wrote:
> > > On Fri, Jul 05, 2024 at 04:24:45PM +0000, John Garry wrote:
> > > > -	if (xfs_inode_has_bigrtalloc(ip))
> > > > +
> > > > +	/* Only try to free beyond the allocation unit that crosses EOF */
> > > > +	if (xfs_inode_has_forcealign(ip))
> > > > +		end_fsb = roundup_64(end_fsb, ip->i_extsize);
> > > > +	else if (xfs_inode_has_bigrtalloc(ip))
> > > >   		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
> > > 
> > > Shouldn't we have a common helper to align things the right way?
> > 
> > Yes, that's what I keep saying.
> 
> Such a change was introduced in
> https://lore.kernel.org/linux-xfs/20240501235310.GP360919@frogsfrogsfrogs/
> 
> and, as you can see, Darrick was less than happy with it. That is why I kept
> this method which removed recently added RT code.

I know.

However, "This is pointless busywork!" is not a technical argument
against the observation that rtbigalloc and forcealign are exactly
the same thing from the BMBT management POV and so should be
combined.

Arguing that "but doing the right thing makes more work for me"
doesn't hold any weight. It never has. Shouting and ranting
irrationally is a great way to shut down any further conversation,
though.

Our normal process is to factor the code and add the extra condition
for the new feature. That's all I'm asking to be done. It's not
technically difficult. It makes the code better. it makes the code
easier to test, too, because there are now two entries in the test
matrix taht exercise that code path. It's simpler to understand
months down the track, makes new alignment features easier to add in
future, etc.

Put simply: if we just do what we have always done, then we end up
with better code.  Hence I just don't see why people are trying to
make a mountain out of this...

> Darrick, can we find a better method to factor this code out, like below?
> 
> > The common way to do this is:
> > 
> > 	align = xfs_inode_alloc_unitsize(ip);
> > 	if (align > mp->m_blocksize)
> > 		end_fsb = roundup_64(end_fsb, align);
> > 
> > Wrapping that into a helper might be appropriate, though we'd need
> > wrappers for aligning both the start (down) and end (up).
> > 
> > To make this work, the xfs_inode_alloc_unitsize() code needs to grow
> > a forcealign check. That overrides the RT rextsize value (force
> > align on RT should work the same as it does on data devs) and needs
> > to look like this:
> > 
> > 	unsigned int		blocks = 1;
> > 
> > +	if (xfs_inode_has_forcealign(ip)
> > +		blocks = ip->i_extsize;
> > -	if (XFS_IS_REALTIME_INODE(ip))
> > +	else if (XFS_IS_REALTIME_INODE(ip))
> >                  blocks = ip->i_mount->m_sb.sb_rextsize;
> 
> That's in 09/13

Thanks, I thought it was somewhere in this patch series, I just
wanted to point out (once again) that rtbigalloc and forcealign are
basically the same thing.

And, in case it isn't obvious to everyone, setting forcealign on a
rt inode is basically the equivalent of turning on "rtbigalloc" for
just that inode....

> >          return XFS_FSB_TO_B(ip->i_mount, blocks);
> > 
> > > But more importantly shouldn't this also cover hole punching if we
> > > really want force aligned boundaries?
> 
> so doesn't the xfs_file_fallocate(PUNCH_HOLES) -> xfs_flush_unmap_range() ->
> rounding with xfs_inode_alloc_unitsize() do the required job?

No, xfs_flush_unmap_range() should be flushing to *outwards*
block/page size boundaries because it is cleaning and invalidating
the page cache over the punch range, not manipulating the physical
extents underlying the data.

It's only once we go to punch out the extents in
xfs_free_file_space() that we need to use xfs_inode_alloc_unitsize()
to determine the *inwards* rounding for the extent punch vs writing
physical zeroes....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

