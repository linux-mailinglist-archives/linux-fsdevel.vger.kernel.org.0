Return-Path: <linux-fsdevel+bounces-23598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C306D92F2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 01:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E699F1C22230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 23:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F391813D8A7;
	Thu, 11 Jul 2024 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yZOs4g29"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D647F7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740819; cv=none; b=Qd9vbZssKNWhwv1NVbsvku5rhnJLJlspHid8IQJ1Omku4d5UMdicmfl32RhAI5wRl0qfRiCzbqh9cJq5QeZO/tub0XdmtF8unRyDVYZHBszyNIITFyJ3uB4W3L8vFfHhn3ZcbP38N+tUB+T1gh/WZo46E/PcvjuFbC2EMVrpwtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740819; c=relaxed/simple;
	bh=OZtAUePQhF0aAKjkKhpqiuXkvHDUB3MV06KZAV3puMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvnFbrJrXcao1LgcksRyfSz1wP5iaxIIT0rMcO6xDP6sOxuiqrYUY+Iw/WvSDvEqt0QcRq8wjWvjNZkjed9SqS11/pEsI4h9mY82e8je/KhfAI0Gh5OHUXMD+J/n68iv6yWtsmXT1dr4LZI4xgLrhdvHzEba9LDQp9ln+p0DeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yZOs4g29; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b702be5e4so18747b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720740817; x=1721345617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2pMQBrXjSXW5+E7qKeqzFFTZD5csYqxc9KtPyp40AWw=;
        b=yZOs4g29egBwb6g1cKYnGcEWyOMOJxyT+RVCd2xfY3BQhdaGTRSsEtGh8ZtPecw1aI
         5RQo6BMnyTvgg6e6y8TnRkfKx2zcOYKzh/qU44rIHivMo2uFeXKpFJa5gtlbRCwhR82Y
         gcQoIeM69tWJ8AsRvsLXMPyc9v6GGa0VHTk7MbTUDUADpDQBevFRUlwck2MnzlIAepLo
         PvmhP2iCxdLvfnTAI6rm/pTKmLPIHWV6uzajFqptaQk8ncmz3mDPOqriynqeRWNvWufT
         Kox+pvU5VgA6QsMwQglpLUOalYAMazDXTyUnurl8TqK5CDSaq2sXW6xK2JDJ2aCKuH8k
         DhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740817; x=1721345617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pMQBrXjSXW5+E7qKeqzFFTZD5csYqxc9KtPyp40AWw=;
        b=XXjdVHJjHdT9fCQtPqeERobUSXEMp3BroE1N5vyvZTh0KrW2bxebhh5mbDphFOU0rR
         AUu4U/t/GNYpyiZ04qTDDVk4rToQk227YLA08xl2ZzZtl1UFNVLA2Bs6FC2SFxfrsxSA
         u+nbkUoyTNWlLRG1EgqkpSUUKo38NidrU5mQ3KfprIh01k53bHR4gVms7auecfgKdbN4
         UV2msVkNjmszaZrP4+ysDQVUJw0H2xafl6V4QdGnHF0cozmHEEdk5jneqVcu5gTZx2sH
         ZtrKwVomnmHB51YEK1H9BChfPynQMy3WYw7azPnKzz49F19zHk2Wrc9AUO8dkZbkpC6U
         CbGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1P17GXcgPvNy/0Z71SdbVwgV0JzEaAanCsFvdfzQnBN54ATFzG/SYMeXVPuV7Zc1cEJYCFJDqJ+kx+MLQqfVOu9SYi02DT1nf5tu5UA==
X-Gm-Message-State: AOJu0YyUvk+2tDiZO+qr8kj3xF3aecnvUy0xieukEi3ndbhNyjWh3yvD
	EVTQ/oEE8egg76e1a0GsFlm8KNzTCwtUIDu7NA1fORs/ym5IQshc+ZKSBRkfYNU=
X-Google-Smtp-Source: AGHT+IEBYQvpYj7Rbudw0zAL7vKb6EcL2jE8eFfIywHD/bxlD5sOrGCx4bz89cXJoGHD7hhFELFcjA==
X-Received: by 2002:a05:6a00:1748:b0:706:8066:5cdf with SMTP id d2e1a72fcca58-70b435e9912mr10487879b3a.21.1720740817261;
        Thu, 11 Jul 2024 16:33:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c3653sm6233133b3a.71.2024.07.11.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:33:36 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sS3I6-00CZmT-1F;
	Fri, 12 Jul 2024 09:33:34 +1000
Date: Fri, 12 Jul 2024 09:33:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <ZpBrzntUOVjJgsh7@dread.disaster.area>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <d4474c49-1000-4553-bd21-c0a9ad41bba4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4474c49-1000-4553-bd21-c0a9ad41bba4@oracle.com>

On Thu, Jul 11, 2024 at 08:17:26AM +0100, John Garry wrote:
> On 11/07/2024 03:59, Darrick J. Wong wrote:
> > On Fri, Jul 05, 2024 at 04:24:44PM +0000, John Garry wrote:
> > > +/* Validate the forcealign inode flag */
> > > +xfs_failaddr_t
> > > +xfs_inode_validate_forcealign(
> > > +	struct xfs_mount	*mp,
> > > +	uint32_t		extsize,
> > > +	uint32_t		cowextsize,
> > > +	uint16_t		mode,
> > > +	uint16_t		flags,
> > > +	uint64_t		flags2)
> > > +{
> > > +	bool			rt =  flags & XFS_DIFLAG_REALTIME;
> > > +
> > > +	/* superblock rocompat feature flag */
> > > +	if (!xfs_has_forcealign(mp))
> > > +		return __this_address;
> > > +
> > > +	/* Only regular files and directories */
> > > +	if (!S_ISDIR(mode) && !S_ISREG(mode))
> > > +		return __this_address;
> > > +
> > > +	/* We require EXTSIZE or EXTSZINHERIT */
> > > +	if (!(flags & (XFS_DIFLAG_EXTSIZE | XFS_DIFLAG_EXTSZINHERIT)))
> > > +		return __this_address;
> > > +
> > > +	/* We require a non-zero extsize */
> > > +	if (!extsize)
> > > +		return __this_address;
> > > +
> > > +	/* Reflink'ed disallowed */
> > > +	if (flags2 & XFS_DIFLAG2_REFLINK)
> > > +		return __this_address;
> > 
> > Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
> > superblock verifier or xfs_fs_fill_super fail the mount so that old
> > kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
> > support for forcealign'd cow and starts writing out files with both
> > iflags set?
> 
> Fine, I see that we do something similar now for rtdev.
>
> However why even have the rt inode check, below, to disallow for reflink cp
> for rt inode (if we can't even mount with rt and reflink together)?

In theory we should be able to have reflink enabled on a filesystem
with an RT device right now - we just can't share extents on a rt
inode.  Extent sharing should till work just fine on non-rt files,
but the overall config is disallowed at mount time because we
haven't ever tested that configuration. I'm not sure that mkfs.xfs
even allows you to make a filesystem of that config....

That said, it's good practice for the ->remap_file_range()
implementation (and anything else using shared extents) to be
explicitly checking for and preventing extent sharing on RT inodes.
THose operations don't support that config, and so should catch any
attempt that is made to do so and error out. It doesn't matter that
we have mount time checks, the checks in the extent sharing code
explicitly document that it doesn't support RT inodes right now...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

