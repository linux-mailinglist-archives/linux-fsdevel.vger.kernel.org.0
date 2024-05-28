Return-Path: <linux-fsdevel+bounces-20325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E394D8D1779
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54CC8B21C50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BB155A4F;
	Tue, 28 May 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="grNfTieT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78825155C8F
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889520; cv=none; b=smE4xOrnjAZs7CXwbxywRgW7NyIlniQJDEqyNpRgSzIgmRTCy2VutAWXb8xES2g4PTI+LwblYHRR/XZlp5ndNIuokCzfwU2/48VPYoKABs/U2ojgsS9LZUFO0g0CiWe+pxwBviaWN3s2zuy9Rqf+z9DRuFtnhWM9izD68SEMRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889520; c=relaxed/simple;
	bh=nfVZoECiu21SbnQns93xMAJk8jPOEkArHUrOO7sZ98o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOEL+mGIx6pd28D+CI6qgEr4UUTWbE951YGqUOovgYZttREZLA+UqhVyjblKGUNj/8kfUJnyHN/fcAIF6Th7Apc/gZ9gIJOYUSOPTdDbok0ILsFjNVMj7O4a0T/WPWknYLlQI6PHjvHU7OMDvayB7PFUcq3Y9WzS+mMhtOLUeVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=grNfTieT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f693306b7cso520209b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 02:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716889519; x=1717494319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mSaikuAEE1TmRWmTPr+CsdopaGULdY/HVZMAQhbHYwc=;
        b=grNfTieTrRGwevSntA7MPXhCRrXTu/OGLUG9NtE1LQ9CFjbzRvh6WalZV8FHXa0m4a
         3HZd+MyDEF+vFFWniCBXMPUr8zv2XiAryzGYijBRhnuq7P/+JL0nTeW0XP8xkjQF/1ab
         j1j1jfy4gN+2vzqbWaN+oO0111QlywCJdRtSlYrNLwKj/rIAWy5hVJsB976RFZW1ioCh
         diNtDcLZVAaYWGLg/KjrBeZxDL0M53Hf8M/7zdygvlSp4dndBu8wtuXVoBPHohenZTVk
         dZNTbsyZ3wp2g989D3el9i5+VQ/zmWCllVaW3+TYhEjDW+PVE8/qMEGPSPL2fsi6NGnh
         nfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889519; x=1717494319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSaikuAEE1TmRWmTPr+CsdopaGULdY/HVZMAQhbHYwc=;
        b=Ub7DBHWIMu/+CvBPCyAded0H/FdsdAl2qMl+2Wl4iBtuH60d4v48Q15PxGFa0/U7gh
         bhzKnSVp+ufDO4gnWfW01Rx4UW+rmN3DW3dCN6qkYxjGipWll43inWh7T2JYxvKsndw3
         hxuu67t0PQu0QaVj9U49SZl+WzKwIchB9ia3/5Qgt2pe3ujC6mnrapz0GuLOcooyW6XR
         D7IO6eyd6VEke2jw0873wr+0iZM9cKjAz4X3nZrsjkHwJ76RYJZ3Z7ChpawijcWcwu4Q
         zuFcoftvWraY8ukfXd4yk/OVnasqMAgmpQePMoxxw8C36Yj7f7vl9hJEMEYI9Y+nHGMw
         KRig==
X-Forwarded-Encrypted: i=1; AJvYcCUQd8afzwsf8W23QbQTsuMNmHp6Iv+x6HNJDYCOBEgtEWZyOmLVUFNXJNNf4MqcmktWSiD1oLpftGR9txQRgeqpCHuQXnCbY9dreEoK2g==
X-Gm-Message-State: AOJu0Yxf8oY3RuQ6aUMDuIRes/eBuhjga0YetFHqA459A/rH4vetNDOT
	+qWlzcP8xh4VVnsGglxiaDmSuhatJwQ/msywenBztA6LMkbStsYHR/kUHxRnBds=
X-Google-Smtp-Source: AGHT+IF5RgW5VSoTNNLwvOASd+BGDj5dWiaubF8Oqrmvn2nbTRNTa88hfPX0xKeu1Haa6CBW/oCfgw==
X-Received: by 2002:a05:6a20:a10c:b0:1af:d1f3:2cb5 with SMTP id adf61e73a8af0-1b212ce1f49mr14193215637.8.1716889518533;
        Tue, 28 May 2024 02:45:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9d89b3sm75760405ad.292.2024.05.28.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:45:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBtON-00DKcW-0N;
	Tue, 28 May 2024 19:45:15 +1000
Date: Tue, 28 May 2024 19:45:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, chandan.babu@oracle.com,
	hare@suse.de, ritesh.list@gmail.com, john.g.garry@oracle.com,
	ziy@nvidia.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlWnqztSjDdbqDcB@dread.disaster.area>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
 <ZlUMnx-6N1J6ZR4i@casper.infradead.org>
 <ZlUQcEaP3FDXpCge@dread.disaster.area>
 <20240528091202.qevisz7zr6n5ouj7@quentin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528091202.qevisz7zr6n5ouj7@quentin>

On Tue, May 28, 2024 at 09:12:02AM +0000, Pankaj Raghav (Samsung) wrote:
> On Tue, May 28, 2024 at 09:00:00AM +1000, Dave Chinner wrote:
> > On Mon, May 27, 2024 at 11:43:43PM +0100, Matthew Wilcox wrote:
> > > On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> > > > > > +	AS_FOLIO_ORDER_MIN = 16,
> > > > > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > > > > >  };
> > > > > >  
> > > > > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > > > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > > > 
> > > > > As you changed the mapping flag offset, these masks also needs to be
> > > > > changed accordingly.
> > > > 
> > > > That's why I did change them?
> > > 
> > > How about:
> > > 
> > > -#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > -#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > +#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
> > > +#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)
> > 
> > Lots of magic numbers based on the order having only having 5 bits
> > of resolution. Removing that magic looks like this:
> > 
> > 	AS_FOLIO_ORDER_BITS = 5,
> 
> I think this needs to be defined outside of the enum as 5 is already
> taken by AS_NO_WRITEBACK_TAGS? But I like the idea of making it generic
> like this.

Duplicate values in assigned enums are legal and fairly common.
This:

enum {
        FOO = 1,
        BAR = 2,
        BAZ = 1,
};

int main(int argc, char *argv[])
{
        printf("foo %d, bar %d, baz %d\n", FOO, BAR, BAZ);
}

compiles without warnings or errors and gives the output:

foo 1, bar 2, baz 1

-Dave.
-- 
Dave Chinner
david@fromorbit.com

