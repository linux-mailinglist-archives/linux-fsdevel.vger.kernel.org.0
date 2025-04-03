Return-Path: <linux-fsdevel+bounces-45668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5FA7A889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6382F1898052
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412122528E3;
	Thu,  3 Apr 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmRU5H9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1BB2512E2;
	Thu,  3 Apr 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700897; cv=none; b=fLzQMhMrDOHH6/ubGpiU8zOdUW1tm0VUU+uOQsg6VYxSjw1ipfEHjk4UV0i5qyz37k/2bB+0Ra3XAA0/JHwU9Cg/Os+67IhV58iCLzh4V5J2NnkFwM2pAe1ltNBytzHdJl9WaybzBCbDTO43dDOH8Cn4FFQdLBamr8RypSIWjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700897; c=relaxed/simple;
	bh=5VTkTvt4U26+IHLcyRCdrLHYyzhh+ixz71UAKBWhyHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvNa02j2JCFs4/QsA9p79+5slv/Hrun6FQq81KCdmipkdQntR4y1a7Q9jLcmABNkH0z2+LERsXO3NaWSkc4rX/GK12lr06UK2vpcst4NugpYnjcqdjY8vUoEUT8moEBolEF/w9fBlierGUgGMxkNrWQC/9GhxxqHdYh124NiUQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmRU5H9w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso11966155e9.0;
        Thu, 03 Apr 2025 10:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743700894; x=1744305694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnpR8OgMebTEJ8xJsBLlSK1/A5gG4m5yk9Ssya6rAW0=;
        b=jmRU5H9wOS/0F2MyC/Ph9sqobWDcs1NgLHcXWjl+tTzPaUn6woYfEJ/IcjmWSo/4I4
         z13lQYnMsNI6vqO97l8PM6kRs4M2WJ7k5CFmm2mg9ugNetmfQvYXNEAy7MJjEMY055RD
         IOeoLkaCPeZbmEB29h9H3mdVb9rpF9G79ZDwHOioiyCNx04lEp+lhrdGVsqYpsUBELZy
         7P0zXmo1IXhrEbqycGlzqs6UqE+wwtQNt+m7vtheFiRZn/xpZNessqsbOe2TkggEDT7o
         8KIawFLHbRJ36UYl74Z/xklO+P8MQC/NIFEr6HhJZ/qisI5zf5/NKYHVOYpEHO+hFzG1
         ehKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743700894; x=1744305694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnpR8OgMebTEJ8xJsBLlSK1/A5gG4m5yk9Ssya6rAW0=;
        b=Q+oEDdVoKLjAkS4wEFET0IEh+XnCmIhZLW4SUsL3Z9nJhNY1NoV3s9emHhON/JHdvv
         TSUeN9IehqikiiVYqO20p1U/0MfmvaXEbElOAbVnZWPALHVIC05+SmLYIg1mhrRklNW7
         +RY/a0N6KG7NJGrTdsBdWIwpU0uVJMEJ1VhuIpdcAV/YRd+aVkFxoKSE+XrpWseSPYP9
         pjqDM1Stm3ICOStN7h2k4anqW+v8IvcJMOrazJMyfizNDJn6Puo+NKvj2sknm4dqH0m3
         DWWvvEjeQyjANkd9yfl/8qJbPFbDJ3Jz9O3iUKHjEcZdQIqyAnDdUim+oVbq0Y5KR1+m
         tcBA==
X-Forwarded-Encrypted: i=1; AJvYcCVi7i+HhMGjRHB3HGlVFzULKPiDab7Df1ho2HJbxrqkgYqOcxzuuBM0cC/TFcubriYiCThUIGUpTbO+DXp2@vger.kernel.org, AJvYcCVlrrubNgvYExz1wSqgkt7uG0RKfSkf8AB1nw8i2CCO36hKoSNgP6Of+XWA1sRLc5MTne6UUFQZeBv3iXii@vger.kernel.org
X-Gm-Message-State: AOJu0YzBj/HB/RdGIPIvfzVsIIPHguyOJuqiciiLCWer/+LuWNHjEgN2
	dDGlRTa8TzA2nf/ECUMTbaVdmRfb/FJFKTpyInJVSG6z+iRsLAzQ
X-Gm-Gg: ASbGncs5tSjuPtiKbR106b4oIO/10OzrjFgEDWCLlH5rD3gJZmjWU8k4MRT5tL0NjIC
	mYEoqVbS1P+SF/oBT73/LlwiGirXWyAdpwGedXTHUaNyPyDSE+k3Tvl5Ch5b4wK4F0uxtu7EO0v
	B+OpJB/MxtzF9R/MGYKdvGigqdGcU9EkwCLrVVGj/zO1P5W5XC9rDnG7MvKFOvQYaNcTe7Zybxf
	ujKjS7X2oUa2xnDN+eBOYFu/l0397SipPSLQNORjJ3b/imTf7UNEliw0C9cOasxQQhWRaFwTkxF
	sUV4bVjKdJOnNo8EclFEVrSpG+vRNSRjQdyZfSoVJszLzIpQ9XQmNh5hqA==
X-Google-Smtp-Source: AGHT+IEwb9SrGBRoqe8AidUqGlxM/HlSsMmJFSiP3WpkHCRbMOWJNXmHFpor78eG6fNAG/32vnpdgg==
X-Received: by 2002:a05:600c:3584:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43db62b7557mr181529925e9.21.1743700894109;
        Thu, 03 Apr 2025 10:21:34 -0700 (PDT)
Received: from f (cst-prg-6-220.cust.vodafone.cz. [46.135.6.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea97904b7sm57325665e9.1.2025.04.03.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 10:21:33 -0700 (PDT)
Date: Thu, 3 Apr 2025 19:21:24 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	pr-tracker-bot@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>

On Thu, Apr 03, 2025 at 11:34:34AM -0400, James Bottomley wrote:
> On Thu, 2025-04-03 at 17:15 +0200, Christian Brauner wrote:
> > On Thu, Apr 03, 2025 at 10:29:37AM +0200, Christian Brauner wrote:
> > > On Tue, Apr 01, 2025 at 08:07:15PM +0300, Leon Romanovsky wrote:
> > > > On Mon, Mar 24, 2025 at 09:00:59PM +0000,
> > > > pr-tracker-bot@kernel.org wrote:
> > > > > The pull request you sent on Sat, 22 Mar 2025 11:13:18 +0100:
> > > > > 
> > > > > > git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> > > > > > tags/vfs-6.15-rc1.mount
> > > > > 
> > > > > has been merged into torvalds/linux.git:
> > > > > https://git.kernel.org/torvalds/c/fd101da676362aaa051b4f5d8a941bd308603041
> > > > 
> > > > I didn't bisect, but this PR looks like the most relevant
> > > > candidate.
> > > > The latest Linus's master generates the following slab-use-after-
> > > > free:
> > > 
> > > Sorry, did just see this today. I'll take a look now.
> > 
> > So in light of "Liberation Day" and the bug that caused this splat
> > it's
> > time to quote Max Liebermann:
> > 
> > "Ich kann nicht so viel fressen, wie ich kotzen möchte."
> 
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2478,7 +2478,8 @@ struct vfsmount *clone_private_mount(const
> > struct path *path)
> >  	struct mount *old_mnt = real_mount(path->mnt);
> >  	struct mount *new_mnt;
> >  
> > -	scoped_guard(rwsem_read, &namespace_sem)
> > +	guard(rwsem_read, &namespace_sem);
> > +
> >  	if (IS_MNT_UNBINDABLE(old_mnt))
> >  		return ERR_PTR(-EINVAL);
> > 
> 
> Well that's a barfworthy oopsie, yes.  However, it does strike me as an
> easy one to make for a lot of these cleanup.h things since we have a
> lot of scoped and unscoped variants.  We should, at least, get
> checkpatch to issue a warning about indentation expectations as it does
> for our other scoped statements like for, while, if etc.
> 

I think this is too easy of a mistake to make to try to detect in
checkpatch.

I would argue it would be best if a language wizard came up with a way
to *demand* explicit use of { } and fail compilation if not present.

This would also provide a nice side effect of explicitly delineating
what's protected.

There are some legitimate { }-less users already, it should not pose
difficulty to patch them. I can do the churn, provided someone fixes the
problem.

