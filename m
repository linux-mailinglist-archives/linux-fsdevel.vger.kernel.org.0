Return-Path: <linux-fsdevel+bounces-18088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307FB8B54D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 12:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542951C219B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 10:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957722DF84;
	Mon, 29 Apr 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+Ee0UQR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD32C86A
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385765; cv=none; b=khGMXJCqF8XblAPMfve1LhFWgA5O8Moj2/786Vh16KiOhTRny7i9qcrkhATzw6nqUvIFB6K6cC0fo5CD9ESgQjMIFnceCjkQNxCpeZ5id4bXu1eEIFskYnYzLRaUMeKZTtFlGBc6Sc9sF0huIJTyT47QS5Jfv2oUTMiByzxF1oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385765; c=relaxed/simple;
	bh=lKTOU9N+85BvqC3gloCf/TwFceRQrNXCqbIxxTFKCTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUi/rK6GZNC96LsPIyhL/I+BflHLZYbU/eFufosEunI2DlVH3gIGotlBzuYHkRWw5yxUvCYmDxRJiRJ45nm1RwuUlBlw4e7WrCbQj93ZNb+NHU4QNPA1NCb3k7vP+fF8i6fmChBw6TuNNC4cmXjQs1B4qJwg8GTCH3I+nSUg8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+Ee0UQR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714385762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNchlTgOKwFFInGOdGwC6RbeyHgd+ZHvemJPoJarTq4=;
	b=c+Ee0UQRUjIw5fRgyMA5dXc9rS1VKYkLAkWgwSe993ifjklizRupGtZAmhfzXjVIDk+TeB
	+cexCvCWOA6ChTWDtHtAirpFLT1cCNB75ZWemT1ff9UL2+2XZEE4mvL6kAmlvgCtOe3xvD
	OzN/tjwYUWXkMH/kvb2sEzxxa0J9ll8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-wpSLAvLMMyO1aljrSVY61g-1; Mon, 29 Apr 2024 06:15:59 -0400
X-MC-Unique: wpSLAvLMMyO1aljrSVY61g-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c1ac93679so3351156a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 03:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385758; x=1714990558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNchlTgOKwFFInGOdGwC6RbeyHgd+ZHvemJPoJarTq4=;
        b=jb8IPVmsSZ2a0ttXuuyNtWqKcTXOXInMDf5sOlOAR2Y4KnTcrSBGM0VWM7B4WmSYj7
         gY+Gx2V/I5phFVGiJYfcZo+s1goXfgMGXbpKug4Vv9uq0gPE2I9NnNwpLA8O451hIinp
         r0Jcg8XDp+9qf+9B4y1ss+A2A3VJDAh4XwvgolmSI8h988hRwtIEICKJIMu8/Jw2zcHX
         G3sPm8d1ssbxcx2NJDk86PosY9bBrxyJISoIM1sDUtuWcqFrpSp+wOJGYTGWo9/oKrK5
         pUu2enKV2nfxhUegEQ1Hy3lhHwfF4UFMHEyV1U6XStDBkij0g6DzgcFE/Yzq6WsATQxG
         JZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvJ6bMzubBnAYro0dkDD1ycTDzag/Z6OHY+mDJc5Pypks2FYJR3W74L6Y0M2STGxaTMx4E+qzcBlL66ip0l6gVe1Q128AkDHKClxli6w==
X-Gm-Message-State: AOJu0YyEolcMxxqkUCSPYvwQzXY3J3o/2XKMlR1lUgmxkpnT5T+J4KQv
	V/qHiGu9RPWuFiNuCwlguYWA6WcIxLfD7ha+jHHEagktwmNjqfRXQRfvNJviur4j+auCgVd12Qx
	QvT4UL2UYSltl8HyIuBuklxcAocDd7RyPgre3pDpO3vxaNLJvdgSnS99Enql3lg==
X-Received: by 2002:a50:ab0a:0:b0:570:369:3e06 with SMTP id s10-20020a50ab0a000000b0057003693e06mr6735116edc.19.1714385757764;
        Mon, 29 Apr 2024 03:15:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERi+njQq/kNI4MqXnZavZnU6Y9BVUhxt3DFboXnNrfq5klNd0Tca0cq3Xwn4hhEyNxQ3/zUw==
X-Received: by 2002:a50:ab0a:0:b0:570:369:3e06 with SMTP id s10-20020a50ab0a000000b0057003693e06mr6735084edc.19.1714385757195;
        Mon, 29 Apr 2024 03:15:57 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ek17-20020a056402371100b0057266474cd2sm2854873edb.15.2024.04.29.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:15:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:15:55 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 12/13] fsverity: remove system-wide workqueue
Message-ID: <j6a357qbjsf346khicummgmutjvkircf7ff7gd7for2ajn4k7q@q6dw22io6dcp>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868064.1987804.7068231057141413548.stgit@frogsfrogsfrogs>
 <20240405031407.GJ1958@quark.localdomain>
 <20240424180520.GJ360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424180520.GJ360919@frogsfrogsfrogs>

On 2024-04-24 11:05:20, Darrick J. Wong wrote:
> On Thu, Apr 04, 2024 at 11:14:07PM -0400, Eric Biggers wrote:
> > On Fri, Mar 29, 2024 at 05:35:48PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Now that we've made the verity workqueue per-superblock, we don't need
> > > the systemwide workqueue.  Get rid of the old implementation.
> > 
> > This commit message needs to be rephrased because this commit isn't just
> > removing unused code.  It's also converting ext4 and f2fs over to the new
> > workqueue type.  (Maybe these two parts belong as separate patches?)
> 
> Yes, will fix that.
> 
> > Also, if there are any changes in the workqueue flags that are being used for
> > ext4 and f2fs, that needs to be documented.
> 
> Hmm.  The current codebase does this:
> 
> 	fsverity_read_workqueue = alloc_workqueue("fsverity_read_queue",
> 						  WQ_HIGHPRI,
> 						  num_online_cpus());
> 
> Looking at commit f959325e6ac3 ("fsverity: Remove WQ_UNBOUND from
> fsverity read workqueue"), I guess you want a bound workqueue so that
> the CPU that handles the readahead ioend will also handle the verity
> validation?
> 
> Why do you set max_active to num_online_cpus()?  Is that because the
> verity hash is (probably?) being computed on the CPUs, and there's only
> so many of those to go around, so there's little point in making more?
> Or is it to handle systems with more than WQ_DFL_ACTIVE (~256) CPUs?
> Maybe there's a different reason?
> 
> If you add more CPUs to the system later, does this now constrain the
> number of CPUs that can be participating in verity validation?  Why not
> let the system try to process as many read ioends as are ready to be
> processed, rather than introducing a constraint here?
> 
> As for WQ_HIGHPRI, I wish Dave or Andrey would chime in on why this
> isn't appropriate for XFS.  I think they have a reason for this, but the
> most I can do is speculate that it's to avoid blocking other things in
> the system.

The log uses WQ_HIGHPRI for journal IO completion
log->l_ioend_workqueue, as far I understand some data IO completion
could require a transaction which make a reservation which
could lead to data IO waiting for journal IO. But if data IO
completion will be scheduled first this could be a possible
deadlock... I don't see a particular example, but also I'm not sure
why to make fs-verity high priority in XFS.

> In Andrey's V5 patch, XFS creates its own the workqueue like this:
> https://lore.kernel.org/linux-xfs/20240304191046.157464-10-aalbersh@redhat.com/
> 
> 	struct workqueue_struct *wq = alloc_workqueue(
> 		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> 
> I don't grok this either -- read ioend workqueues aren't usually
> involved in memory reclaim at all, and I can't see why you'd want to
> freeze the verity workqueue during suspend.  Reads are allowed on frozen
> filesystems, so I don't see why verity would be any different.

Yeah maybe freezable can go away, initially I picked those flags as
most of the other workqueues in xfs are in same configuration.

-- 
- Andrey


