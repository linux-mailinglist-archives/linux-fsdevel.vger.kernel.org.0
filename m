Return-Path: <linux-fsdevel+bounces-46593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E8A90DE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 23:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08DCC447F23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CA238C28;
	Wed, 16 Apr 2025 21:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2D8q59U+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F4233732
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744839689; cv=none; b=XmzIj7axqwBKFWBaIlhDI4eZGWLD1JlShdxpyI2dMM1US8HSrfpDMoJQTndjPlO9RPOIc4oiTMfMfpSq2rYeIzMvek5jrL/0XvvXxrIAkXByXau0Q+WbZB1OtnhTUb8yPliO+jNWbyRaGjKiyWI29XSYjBkVEqAoU/eZlX9i/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744839689; c=relaxed/simple;
	bh=o1sU+rz5Tha47B6TR7hM+/zjkjKkHAOxgg9OV4snp1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIdx0OPpTMJirqEF+ncZ6If9zLsV2cQRVRrMqJrQrLkTywxTicPcMOSyx1ELU0qxhtltWO7KLMn0qLmy1UKIUkl+RqKL4LIkUona5zBUBWNDFEjXbaW5EvpDEDUszysjz/6Z4T6HiV5/Z0qnl4EN88Xm9XDVweRMSb61KQKJhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2D8q59U+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73712952e1cso56540b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 14:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744839685; x=1745444485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=47HMeV8+xYWF7g+B9xPvO9nX8RwZgvRlZTZkm2TUzrM=;
        b=2D8q59U+TSnePN+u+ydZqa8B8cLKgnpPuazUV1BOTTzy3503XnnQkHeUBtBM/uuWeS
         cxR/bXqo/a61dW4Ml0vlj+SPK//4Ke86iRR0yLvqK43EsT/sjTsMrihBXWrvwAjOF0Zq
         H7WgIP54DImpP4qnceZLq8rEtDUwwm05x4+fuQ6RwM6CPr9rnyr1EASnf8iTJ/OCo9i1
         afT4wCj8310DF5Bap6FMrYOR93xlSNx/JYEGL+tTh8ZvN3BH+sah4f0rF+vAJ8jUMy39
         ICNKoj82sv54CxWb+YTZ3OmG1e9TapeKwjYw7whd1f5BIncdlEKXtlOv58ehL6U3E75F
         q3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744839685; x=1745444485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47HMeV8+xYWF7g+B9xPvO9nX8RwZgvRlZTZkm2TUzrM=;
        b=PVbnLbQOp+CfqdkC5d/2VjB1KqCXAR8p1Ma3uRr9NmY4C4RfKFFlNtsVbAH/yB+09h
         ZT03/IcMksqcjUhb2GMue8cerjcyviy7LUPY02Rj1cd+ABu+ny8NHie3DatluG6TFRrb
         m+00MEeVzHQ2rCeDll39PSutZSHAp/UguYlpwtTKF1frEMV/H72krD5GpoN5wM6KbHp9
         R8Man9OLEuAqQIm4wv4f2G6fCh0I49/gRkk3gMgO1HQrrpHtcrrmXpdCUMSQTGejqIFw
         CbWPnlNkq/5w7lf/kDOO8ZIxzUF5WXgBQdd14t2TuwL4eHTTjU6/E5CvgZCqSTa/Ix9K
         /+oA==
X-Forwarded-Encrypted: i=1; AJvYcCXUqbi3k1e8piOvvFjrf54usTAhUoiIP8QcCx9lNnnVqhOOtnP+nFAlEgG35U1PqqGvDL3+iHhWD8i3yb1j@vger.kernel.org
X-Gm-Message-State: AOJu0YzmmIHy/KPADFX+AD1SX2ExZFhK7eq7kMtXoDjgLqWitooncLHg
	bQTGp1fvt3N9AHQuNrlh83qmLgkoJAIdFUI0+UkwPYQ0UlDDy7rt+Xuv4EtQ/p0=
X-Gm-Gg: ASbGncsLQ1HqcoSVXnoiKwCJF/+/C5fWyOgJnsHfLMDNgncnUxFjkirmmWzi9eBL1J0
	vujjZpnGn+H3IMPHYhtzuzEBZPO2XQVpS+iFye1ZEcq9jah45JkBGjIC41QcdH24f+PIPzPrUc/
	UDltYddoQF7WbH/UI2BWSIXQcPszSqqXGxBOnFI/5Ogdq4iTYS2JH/XmUN0KVdMn+wHSHWE76jU
	qcybjVDIl7arqU1QUaBkoTUaee2dRybl9X85+vild7GAbnylkXuG5+hFp5HTx01YJwVOV9+NNJn
	BKEYBiDp9XmbpjW6RTIayoWuL/Q7Tf/F/ZspAhwToFL5Ka0zw21fsvuC3SWZ4c0digvjo7/p/cp
	UN40=
X-Google-Smtp-Source: AGHT+IG04IaL8bFms3wlp0JccutYi5cFkemAqhF2QeHtfu/j0n7MMMdjRR8GWwkeyhYc9OA83+n9UQ==
X-Received: by 2002:a05:6a00:1305:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-73c266fba39mr3923818b3a.10.1744839685339;
        Wed, 16 Apr 2025 14:41:25 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c388fsm11328223b3a.54.2025.04.16.14.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:41:24 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u5AVV-00000009SRr-3o6o;
	Thu, 17 Apr 2025 07:41:21 +1000
Date: Thu, 17 Apr 2025 07:41:21 +1000
From: Dave Chinner <david@fromorbit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Andreas Dilger <adilger@dilger.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <aAAkAZQqlw_DcDQH@dread.disaster.area>
References: <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org>
 <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
 <Z_00ahyvcMpbKXoj@casper.infradead.org>
 <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
 <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
 <CAJfpegtchAYvz8vLzrAkVy5WmV-Zc1PLbXUuwzxpiBCPOhK5Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtchAYvz8vLzrAkVy5WmV-Zc1PLbXUuwzxpiBCPOhK5Rg@mail.gmail.com>

On Wed, Apr 16, 2025 at 05:18:17PM +0200, Miklos Szeredi wrote:
> On Tue, 15 Apr 2025 at 19:22, Andreas Dilger <adilger@dilger.ca> wrote:
> 
> > If the negative dentry count exceeds the actual entry count, it would
> > be more efficient to just cache all of the positive dentries and mark
> > the directory with a "full dentry list" flag that indicates all of the
> > names are already present in dcache and any miss is authoritative.
> > In essence that gives an "infinite" negative lookup cache instead of
> > explicitly storing all of the possible negative entries.
> 
> This sounds nice in theory, but there are quite a number of things to sort out:
> 
>  - The "full dir read" needs to be done in the background to avoid
> large latencies, right?
> 
>  - Instantiate inodes during this, or have some dentry flag indicating
> that it's to be done later?
> 
>  - When does the whole directory get reclaimed?
> 
>  - What about revalidation in netfs?  How often should a "full dir
> read" get triggered?
> 
> I feel that it's just too complex.
> 
> What's wrong with just trying to get rid of the bad effects of
> negative dentries, instead of getting rid of the dentries themselves ?
> 
> Lack of memory pressure should mean that nobody else needs that
> memory, so it should make no difference if it's used up in negative
> dentries instead of being free memory.  Maybe I'm missing something
> fundamental?

There is no issue with the existence of huge numbers of negative
dentries. The issue is the overhead and latency of reclaiming
hundreds of millions of tiny objects to release the memory is
prohibitive. Dentry reclaim is generally pretty slow, especially if
it is being done by a single background thread like kswapd.

FWIW, I think there is a simpler version of this "per-directory
dentry count" heuristic that might work well enough to bound the
upper maximum: apply the same hueristic to the entire dentry cache.
I'm pretty sure this has been proposed in the past, but we should
probably revisit it anyway because this problem hasn't gone away.

i.e. if the number of negative dentries exceeds the number of
positive dentries and the total number of dentries exceeds a certain
amount of memory, kick a background thread to reap some negative
dentries from the LRU. e.g. every 30s check if dentries exceed 10%
of memory and negative dentries exceed positive. If so, reap the
oldest 10% of negative dentries.

That will still allow a system with free memory to build up a -lot-
of negative dentries, but also largely bound the amount of free
memory that can be consumed by negative dentries to around 5% of
total memory.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

