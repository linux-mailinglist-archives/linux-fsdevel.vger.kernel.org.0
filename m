Return-Path: <linux-fsdevel+bounces-13151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284786BE44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 02:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766461C21985
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 01:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3632182;
	Thu, 29 Feb 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="1pVlI9Vb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBB2D602
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 01:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170181; cv=none; b=QTPQTenHyemO+VnqdJqLL1QA3d4aGNVV5F5Zj3Ml+S0Jazokm3pgEN4XqCZ96cUI301G4YTMLGqrKqez6eAOsE9ee+zBvZ2REYVNzWER+599nY77TnHrFd6LBfF0QZr+Oe5BKg4uB8yi6qi868FUankvA1bROiSM1jOW8Dfk+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170181; c=relaxed/simple;
	bh=EpXSQdK4jmJW+nojp/NvHDKEUytyqX/mlT/ypLQHi4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnyOi0aF4DfOQvJS1DRa0RTxuY6frRFVbktpAKFoZnJJJiOL9sEqESy68tSCz/316L8CVhL0AWPW+vbrgFc5/2HfNJ4cUmDMJz/+hCz0Sfsda047KtuSX7OoHqL308APwqUIsKcfcKlBFV/HQ5bKBcd/Ujgn3IcBycUx4HPNCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=1pVlI9Vb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21f70f72fb5so234638fac.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 17:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709170178; x=1709774978; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xz94DoVuij4oLtGOO6tw4fxB1njQ+3NgCDwY0tEfi4E=;
        b=1pVlI9VbhfxYqu2HivIq9UJLe+C1PZ9IshP6VkDeLV7Va9xoGMRr5sJeIYOBTJoy+o
         xP+50kKf7rB6YMIJUd5MkieGZ5QbGH5ulmcaaT9aBVQgoqDUUiJ+exqHmIylMlER1e6j
         K7ApHcOwtW/eEhzHbqbPmWRrsu2hcH9250z9dr0Dx18gN33747z03/i67+F+K9gBd683
         Brq9RNY5Rmxw0GDU88PkHDFy0EH2TZ+r4pYvEeGzIHmS1D5G2oO5XGfjU8NSMI4Jxccv
         Ad09jXlABT6pjccZ25N8JnpzIPcXkBhBc9GM9wt4PHr3SAJ/dxHEfJ/AgqJS7IpDYMNL
         v7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170178; x=1709774978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz94DoVuij4oLtGOO6tw4fxB1njQ+3NgCDwY0tEfi4E=;
        b=ksYyWdKFWIY9hebNO/IYbVLGGkd5cY9V8qNuarRo8Kk9rNzalXP6qI4nq0rJK88xh3
         FnH4pd7cTSj6SH+B3D6oV3yY8XVuernZq9i2CqkrT9q/xc08PrDecrivmNhJ3d4YWdNq
         A6JB2bx4rLtdEfqq5Tl4JfeZKtMKHcBLWJP/i5MdM7TVCXfFGkh1NTOqdYhbWtOndnYs
         HJAWcNx8eusvrzT8TgJSa3OTvM65juv0lrixC9iNhuj6pB8C4l/lzJHqfyGpKZ7Ibwnx
         kD2FT1BwQVoRmvRyIXYd/ReaCStu7dYaiBFEPU+tIubUhLtFym4xnoO/ZaMPxwPCe54F
         m85w==
X-Forwarded-Encrypted: i=1; AJvYcCWK5xDmET32UrcT2q4k7Wd0Ljn1IatYWsb1dybg2mzPfVohoZ82NYIllebeRUbMkeKt0dHEzyf2Ivw9RoyUjwWOPaoaWNKKUtzTN+MVsw==
X-Gm-Message-State: AOJu0YzTfGZyO9S1205dvQRUN7a4Rl3ibnpbysZtrNMISltDeJf2m3Dl
	DbZiLxF+Xi4pEFAAqKshX61IQ9WgFqlVlOpPFrVTvcl4bM7fdiITozGFeWdh8d4=
X-Google-Smtp-Source: AGHT+IEc3wN6tqDFLYKhItvK5Mp5Q/pgHwZEnU/DFxLYj9cWlNMEAqVICODUvE2fEpnAE5B4NpUejw==
X-Received: by 2002:a05:6870:134b:b0:220:13b5:3e9e with SMTP id 11-20020a056870134b00b0022013b53e9emr582644oac.4.1709170178566;
        Wed, 28 Feb 2024 17:29:38 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b006e4f311f61bsm89206pfn.103.2024.02.28.17.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:29:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfVEt-00Cu3g-0D;
	Thu, 29 Feb 2024 12:29:35 +1100
Date: Thu, 29 Feb 2024 12:29:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <Zd/d/w2bFfHs5nTe@dread.disaster.area>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd-LljY351NCrrCP@casper.infradead.org>

On Wed, Feb 28, 2024 at 07:37:58PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > Recent discussions [1] suggest that greater mutual understanding between
> > > memory reclaim on the one hand and RCU on the other might be in order.
> > >
> > > One possibility would be an open discussion.  If it would help, I would
> > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > some ways that RCU's reactions and responses could be enhanced if needed.
> > >
> > 
> > Adding fsdevel as this should probably be a cross track session.
> 
> Perhaps broaden this slightly.  On the THP Cabal call we just had a
> conversation about the requirements on filesystems in the writeback
> path.  We currently tell filesystem authors that the entire writeback
> path must avoid allocating memory in order to prevent deadlock (or use
> GFP_MEMALLOC).  Is this appropriate?

The reality is that filesystem developers have been ignoring that
"mm rule" for a couple of decades. It was also discussed at LSFMM a
decade ago (2014 IIRC) without resolution, so in the mean time we
just took control of our own destiny....

> It's a lot of work to assure that
> writing pagecache back will not allocate memory in, eg, the network stack,
> the device driver, and any other layers the write must traverse.
>
> With the removal of ->writepage from vmscan, perhaps we can make
> filesystem authors lives easier by relaxing this requirement as pagecache
> should be cleaned long before we get to reclaiming it.

.... by removing memory reclaim page cache writeback support from
the filesystems entirely.

IOWs, this rule hasn't been valid for a -long- time, so maybe it
is time to remove it. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

