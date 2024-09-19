Return-Path: <linux-fsdevel+bounces-29673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D3997C2A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 03:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB8286773
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84FC1CFBE;
	Thu, 19 Sep 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zBDJ6s/7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26C512E75
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710200; cv=none; b=enSNpVcqJ0DLQWDbgQpsSfmMKEk1B3cfacF5cUIgA54Oxmxn/ztK+tqn2WA+AQm6PiW08yUkM2SpsmHwwKnrtLB8pcVVds2HQKrxUhtUbHazlWRTe8IpgelE0oTZnIUtuZpyiNgmGpLdU7wOCPcUmFPqK4B+Avu4VWPKMnCjWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710200; c=relaxed/simple;
	bh=oNXPqtyDgLu9Kh2ue6NBD6CfWTrY2WHFnxBQrLR39sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av7xSP3zGwD17hW+ECugot2v1IJJhi4yMzLnYFS+k0rWzaLBzTLu+zQ403HtsypFwiqkTpnrmt5IqO3nmWLU+PlysFbMZTFFWUCMST8Bz5lR1NKxcqxBjy7jj4b2p599r7jpWOnDHoYsuUeYiLE7ctqVOtFBwmj8ijJwXD3kBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zBDJ6s/7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71971d2099cso227978b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 18:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726710198; x=1727314998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+jwxQJbxpwl4voWuXzYITDQeat0ESjsMo2U9Mc7bSDY=;
        b=zBDJ6s/7s54hp1CPEEoM5xvQtVnHO9JpYjNVxYHuwzcCmu0iUhSxVkE1Nz3Qa7lNdP
         /1cxGp7hj9VIbmrZvqdfkEv4CNhjjqNYgJKbLcplGlWvuwch1HPxXgoXPAfDS8ilZfMF
         cLxTIeLj45WtloEoPSfyGPGQSN3CVJPq0H8g7P9oX+ffFL8vvdbD3+m5ZpWtfMnu5AuI
         XMtXmNGFzwVw3D6hFPoVVGcYqaaJ+IBpdMfNbF1j4Z1sc2WXoB47QYRstLaH0Gjv19r4
         YJlXquYfhTpv3wP/Mq2RkBeUmvl3vy1sHoZKx9Hf3FZ9jq0XAwGK9sJG2RoQyYr+gZgL
         h28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726710198; x=1727314998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+jwxQJbxpwl4voWuXzYITDQeat0ESjsMo2U9Mc7bSDY=;
        b=hT7gGvLYyiV6MsYMP08RJJ2bDwmU30kLxsehFuGKz9Zgvl4g67g5slvoHF9PycCRKM
         mozqTD6YGDczW9+fGF9JobjnRd1ew8/ea1EWxKjJaRJgBWSlY4X9cbjtFQl3iSC40Qyu
         18fvqgYmz1itGirls0ZdC6Ca8nGEGt4gBA5VWAIrlOAczXAL6tTaDQyEaN1OJuQNhFyU
         SVCDPprcoVdA0nLJDn34kZyGVqcqFIHItLUPx+NNVqitZ1lEEPawmywr2D9fY8ruQcJE
         MeooF/l2oINSuGUyTH9dFtY+YOTyuHl8QBIEU2r+U0M0R8MPPHZAtMz2fy9zVI+KgVBL
         qUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsvKPelRObW4TO21D/eYCeOurNsko2U8pIzxCEsJN2QXLQ2eDLWLaruSQYB1Vvh6iCFtFCGlfdZEISmQZa@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcyFsCq2il9Ym0osDmYbYdPG9Ty4qk15K8az7k9MO6TUxK+rC
	vFm2sMhnxB0EBDrCHUwmAOArislAPts/0+RD9g9h7FDWCjI2riYdxnLej60cwGLNqHbHjCB5/Ei
	i
X-Google-Smtp-Source: AGHT+IHP3QnTzJJQUGix1BZtfPAN61RzG3kG6wmczzL7AUu1v04MsD1wNi6JBs9VM4Ciz1/aEAynVA==
X-Received: by 2002:a05:6a21:3942:b0:1d2:bb49:908b with SMTP id adf61e73a8af0-1d2bb499130mr25408416637.18.1726710198379;
        Wed, 18 Sep 2024 18:43:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719918df7ccsm150940b3a.40.2024.09.18.18.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:43:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sr6CR-0072c8-0x;
	Thu, 19 Sep 2024 11:43:15 +1000
Date: Thu, 19 Sep 2024 11:43:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZuuBs762OrOk58zQ@dread.disaster.area>
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZurXAco1BKqf8I2E@casper.infradead.org>

On Wed, Sep 18, 2024 at 02:34:57PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 18, 2024 at 11:28:52AM +0200, Chris Mason wrote:
> > I think the bug was in __filemap_add_folio()'s usage of xarray_split_alloc()
> > and the tree changing before taking the lock.  It's just a guess, but that
> > was always my biggest suspect.
> 
> Oh god, that's it.
> 
> there should have been an xas_reset() after calling xas_split_alloc().
> 
> and 6758c1128ceb calls xas_reset() after calling xas_split_alloc().

Should we be asking for 6758c1128ceb to be backported to all
stable kernels then?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

