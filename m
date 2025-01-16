Return-Path: <linux-fsdevel+bounces-39355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B10A13235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451CE3A6152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C8142E7C;
	Thu, 16 Jan 2025 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="v0paJONS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AF55661
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737003837; cv=none; b=e23cc7zV7njpvTlmW4bEdvDPAtLh3kIAEPhcOBMpbfbYUec2T2HSW3lE6iU0SnFkA8BjMsOvG9O6cGzmz9iXIywayV2cUHJONz15n0MGjefpEwF9FUOykLRspzZBGF9OFyqs1Eda78qM7Cx5qcpVbGAJ+YVbCZX1cPq5/XoIdtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737003837; c=relaxed/simple;
	bh=wELArgmung28UVW6a1djIOqJloxqOE5PObrjaTGmt24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daC9Hr+bjm/HdxR/HcRZ6fzPnai0h4QJbMZmDHK8PjiOZt2HnMdJCCkhOIIKbWO7jnsg/MexSQyLM1xwcvJN8t+MezzZWTgJWAtSRSxLiturx5RWpusV5/kx1t837UnNlIAVIH9+bjuzfz7Uerl+h4xLJMCpLB9k0vwoX8Anno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=v0paJONS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163dc5155fso7608775ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 21:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737003835; x=1737608635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=v0paJONShVSwTov0vlckCCKx166z0WlVMcBq0nm7xyn3POJk0Y9jS/Im2nI4/GOXhQ
         csFjAZkT3QQI66xORHtTMnh85IBerAjVLvO5mm6QnbLs0IKsd0yYmmMqTj7hjbhbkBDS
         SpPlrJVVpJMjWuwidRR7s86gSmShUXs3uaPpJhAc3Pf4h/UprFWOl+1OPQbszhj0d18M
         zn9D0WMzjDnNxW8jbnSq3r0yryiR0ZZoRQvGbw0VYbPM1rUPGKOGBtIfM29oFE7PsLnf
         Bi7yBtDxjeTAu2hiXoYBOFTXU15Hc3bBDCA2erw9Gp9QLr71cAI08CbHmv3CovAU3dMa
         1aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737003835; x=1737608635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQtwcz66cRpnEOfOa/HyiuZRqWSGLaKRKp3+zlxh6e0=;
        b=DKVfdQU2B9jWjPjWWDJaJVaWYBOngShFnnW13+zgab5RtYSNNVdJccMGaFTg16emmV
         xZUZ186+TB2tw3y7Jm9rmkh4iLvueFmcrlbMpLrr3iCGgXF/fy5yOo6BXYkLcxYAiIQG
         oCuMyOGDcJJ4PmB+Rd5CcTRbWyqxyk0lp9uEyfy1v4IcoToh4f3K42m2o54uevvWf7+q
         yDPb0pMGsJiWDcxWhatYLLX0GDkfjNVeM9YEal1q6WHZbOnqyiX/e0Ohp39pWZnmENLY
         O8gdDbxT/IhT3HlAF8iPioQqQ/7kRvY1jHIlV/IrvnW6z8fHxWa4lAzgzeqSjVzRNTDm
         Hw0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+FT9lGRlA+dUOfy7N6udtdqjRequGOUjUzmzwL6MFaRn807SWJBoEE6rQtr3DGve8ByajCIx7wf2uWAE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zypf6hrjGFbL0XaRr+CcFCKoVkcLbAM0opcOaOOO4CGqrx4R
	Vpo4yhKb97IpO3ACUFt2hyVrx6aXmot2o2cdtDZp/tYWIPkhKL9nPQc7y0gKt5Q=
X-Gm-Gg: ASbGncsFOVbzyKCkvnGyb5W5AKeTsdb4WZB9/w4cuHfLGk/PB1KkXLoblE9IWNE0/ro
	V2HS4UH5T+EbcDgaNqdtMapp7HpvDOgAsxLfLJDjUxQffsYIX0xxGfW+6sR278QxtzoAqt1NePW
	+uk+/U6qMZfHDHoHZF9KI18NJ/thcHRFmBg4Eo2JW4eUtgUaPIvSRW8Jo9p+b1UTvVS/r6d9HIy
	YfnBy3p5AZ83R31XEKzW/ll3The8thz5uQs+McbaxbfDBVl1snpFJfnno7piN40WbggzQTBTcs8
	L6IvAi7ASgsSveIsvzJXqP+D2hxpeunp
X-Google-Smtp-Source: AGHT+IGNOhZ2CDB3dC9ypPRx2+QFrztyTh30xO+H1dvtRXfxPIdj2LE0KDNO2Mwf1ivGr5YrWG2u9A==
X-Received: by 2002:a05:6a20:244d:b0:1d9:fbc:457c with SMTP id adf61e73a8af0-1e88d0a4771mr34957994637.36.1737003834927;
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f72dsm10406495b3a.145.2025.01.15.21.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 21:03:54 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tYI2p-00000006SjT-2V99;
	Thu, 16 Jan 2025 16:03:51 +1100
Date: Thu, 16 Jan 2025 16:03:51 +1100
From: Dave Chinner <david@fromorbit.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 6/8] dcache: use lockref_init for d_lockref
Message-ID: <Z4iTN86x2SsTVOIY@dread.disaster.area>
References: <20250115094702.504610-1-hch@lst.de>
 <20250115094702.504610-7-hch@lst.de>
 <Z4gW4wFx__n6fu0e@dread.disaster.area>
 <20250115203024.GB1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115203024.GB1977892@ZenIV>

On Wed, Jan 15, 2025 at 08:30:24PM +0000, Al Viro wrote:
> On Thu, Jan 16, 2025 at 07:13:23AM +1100, Dave Chinner wrote:
> > On Wed, Jan 15, 2025 at 10:46:42AM +0100, Christoph Hellwig wrote:
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/dcache.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/dcache.c b/fs/dcache.c
> > > index b4d5e9e1e43d..1a01d7a6a7a9 100644
> > > --- a/fs/dcache.c
> > > +++ b/fs/dcache.c
> > > @@ -1681,9 +1681,8 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
> > >  	/* Make sure we always see the terminating NUL character */
> > >  	smp_store_release(&dentry->d_name.name, dname); /* ^^^ */
> > >  
> > > -	dentry->d_lockref.count = 1;
> > >  	dentry->d_flags = 0;
> > > -	spin_lock_init(&dentry->d_lock);
> > 
> > Looks wrong -  dentry->d_lock is not part of dentry->d_lockref...
> 
> include/linux/dcache.h:80:#define d_lock  d_lockref.lock

Ah, I missed that subtlety (obviously). Carry on!

-Dave.
-- 
Dave Chinner
david@fromorbit.com

