Return-Path: <linux-fsdevel+bounces-18466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEA8B9316
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 03:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE0B28355E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106C4134B2;
	Thu,  2 May 2024 01:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="o0BMVTW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715711718
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 01:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613213; cv=none; b=ciyFu4hHE9sXAaD6k6WpkpLDs3kJ/tnmrpjP/Ne8TDs0KtqmYk+xME/FNowIkJYfV4Yaf6ZhbO45WZ8YT8Peo2RPRB2R1sOkHd27vNwdlJ0j4VkYsaYf6i9WiZkTtRtkrQSbIp5bqbWR9VHjEBXjvzdh5+yB+f1Mw2ZFTtMH1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613213; c=relaxed/simple;
	bh=aiQLgMnrBrWvk7K6foZtmxAJr384q7kBAbb7yTl4V5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOFI0xt8LYfyRHX1ozNDNawhzKPhDt9UU6wqy5CD6gtuKCtJI7i/dgOwPCl4AZjnerJmypzzyezWZMZ4jeEnenCYuzUL6MYdcQrFne81zD+EGil78aBJHjtFXemdRe/G2G05MeWejuifcMODRYFldDaw5+oRrP0G2nMH4iGKTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=o0BMVTW3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f103b541aeso6226649b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714613211; x=1715218011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BoNtHTJ8szqDZXGrqdiequs/rQM0aLZwOdY/YpVYtUQ=;
        b=o0BMVTW3O9/N6bVJ1TKjQiTqcuWG+xPLGKDhdcrjGRSiJobke3aijfF9lEyrBswMLo
         bEXTVuMGMFv+bmv2z57rQNQjRq7YyfMJmnq3Fw1PlmouxXvCS5Xrl4ISJD1vIujqx4en
         5BY6v5Czswsz32zKTP9+YJ2kFnkMHOLxjcUu6uDM9h0oGGRlixEx76GsSuGusd+llGkK
         Klp88BwIYOPVBqT8KzYJ+GOAFHGFIuJKgXd7UurhvW+0LzVIexBntt2T9LRB3izJLKxW
         4oN/3pWUx/TDKzaoSQPNM4UxDAN7EUbHDxDx+OwYwmqRYhOgX+o59tbD8S3RuPm4PuFi
         EvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714613211; x=1715218011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoNtHTJ8szqDZXGrqdiequs/rQM0aLZwOdY/YpVYtUQ=;
        b=ioDNkgUoDmr9UafKiyWK/yoAyGoJoUY74N69ZXGocjHI2DJvo4FyGjMgmiMCJqyAS0
         CrLktHI0bh7LLNDzUwPmEcVofZ23nvA2HMBW3t04DsmLQLwxe1luSji9yGEVVFKzCmHF
         d54TSWJ5eKOJ7noMNtlN4yHiwOEaelwnTpkHdA7gOJ5Ql1AOEZn2jRIxgGcYpuAWqk3/
         8jpHLTyweCDEfUAAcRfjD1NZ+fSfRrOQ0gR/BlDtYm0lFowP6BX30zBXn7NQNF2+HTbX
         KrXJq3VSAvkFmTQaiZtvcFlzGhigLTguRy5y6NZdZnoyFB0WtcvdoWQUjML9CD/Hg07O
         UJjw==
X-Forwarded-Encrypted: i=1; AJvYcCVO1lU1zMvqPD4sZoFI5n2f6SD1tUScO0QJGoP42ygqX1Y7rifbvYvx/qd8vOp3B2JAyFKo1zEje5QmeKYO5aeHnPLvRvhKVsNHZ7pcCA==
X-Gm-Message-State: AOJu0YyvC14KL9yugS+wk3erYW9U4xp2ePwN3eQiwnEx5esZVvErqsIH
	7XSqIi/aNgVly+0DKuupmbr31b6l0p6K3lMIDGp4hUjiQRvS38zEz0DO4b+rl7w=
X-Google-Smtp-Source: AGHT+IHnNHve2YtRJXBin4iPljutTTUfrx/RxhWwRiJVuk82SYT4Ex3LTe2WrKa6Z73pMoij2m2nGw==
X-Received: by 2002:a05:6a00:23d5:b0:6f3:f30a:19b with SMTP id g21-20020a056a0023d500b006f3f30a019bmr4277299pfc.18.1714613210547;
        Wed, 01 May 2024 18:26:50 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id n16-20020a63ee50000000b005f3d54c0a57sm7292pgk.49.2024.05.01.18.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:26:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2LDj-000Nxl-18;
	Thu, 02 May 2024 11:26:47 +1000
Date: Thu, 2 May 2024 11:26:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 15/21] fs: xfs: iomap: Sub-extent zeroing
Message-ID: <ZjLr12LjiSrY4cdh@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-16-john.g.garry@oracle.com>
 <ZjGbkAuGj0MhXAZ/@dread.disaster.area>
 <0eb8b5b6-1a59-445c-8ac1-1de2a1c0ce4a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eb8b5b6-1a59-445c-8ac1-1de2a1c0ce4a@oracle.com>

On Wed, May 01, 2024 at 12:36:02PM +0100, John Garry wrote:
> On 01/05/2024 02:32, Dave Chinner wrote:
> > On Mon, Apr 29, 2024 at 05:47:40PM +0000, John Garry wrote:
> > > Set iomap->extent_size when sub-extent zeroing is required.
> > > 
> > > We treat a sub-extent write same as an unaligned write, so we can leverage
> > > the existing sub-FSblock unaligned write support, i.e. try a shared lock
> > > with IOMAP_DIO_OVERWRITE_ONLY flag, if this fails then try the exclusive
> > > lock.
> > > 
> > > In xfs_iomap_write_unwritten(), FSB calcs are now based on the extsize.
> > 
> > If forcedalign is set, should we just reject unaligned DIOs?
> 
> Why would we? That's very restrictive. Indeed, we got to the point of adding
> the sub-extent zeroing just for supporting that.
> > > @@ -646,9 +647,9 @@ xfs_file_dio_write_unaligned(
> > >   	ssize_t			ret;
> > >   	/*
> > > -	 * Extending writes need exclusivity because of the sub-block zeroing
> > > -	 * that the DIO code always does for partial tail blocks beyond EOF, so
> > > -	 * don't even bother trying the fast path in this case.
> > > +	 * Extending writes need exclusivity because of the sub-block/extent
> > > +	 * zeroing that the DIO code always does for partial tail blocks
> > > +	 * beyond EOF, so don't even bother trying the fast path in this case.
> > >   	 */
> > >   	if (iocb->ki_pos > isize || iocb->ki_pos + count >= isize) {
> > >   		if (iocb->ki_flags & IOCB_NOWAIT)
> > > @@ -714,11 +715,19 @@ xfs_file_dio_write(
> > >   	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
> > >   	struct xfs_buftarg      *target = xfs_inode_buftarg(ip);
> > >   	size_t			count = iov_iter_count(from);
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	unsigned int		blockmask;
> > >   	/* direct I/O must be aligned to device logical sector size */
> > >   	if ((iocb->ki_pos | count) & target->bt_logical_sectormask)
> > >   		return -EINVAL;
> > > -	if ((iocb->ki_pos | count) & ip->i_mount->m_blockmask)
> > > +
> > > +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> > > +		blockmask = XFS_FSB_TO_B(mp, ip->i_extsize) - 1;
> > > +	else
> > > +		blockmask = mp->m_blockmask;
> > 
> > 	alignmask = XFS_FSB_TO_B(mp, xfs_inode_alignment(ip)) - 1;
> 
> Do you mean xfs_extent_alignment() instead of xfs_inode_alignment()?

Yes, I was.

I probably should have named it xfs_inode_extent_alignment() because
clearly I kept thinking of it as "inode alignment"... :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com

