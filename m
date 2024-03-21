Return-Path: <linux-fsdevel+bounces-14950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC69A881C77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 07:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BFD2836B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F623A8CB;
	Thu, 21 Mar 2024 06:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0fNtcS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15115AD48
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 06:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002446; cv=none; b=QrhJOjcH3EWlldwJqWbveJqDQp0ThWAPLwCxl+GmcDM0tL/MVuBDysKSf/zPGVqOkZtCt7uWPBbcOyJqHdFkedXlIDfg3vvn/1zeQDR6IZx01bf4ghlAT7ub6sdpm0FeYHcEQkwyZRT2TQMb/cmSBcCH7JOcUufVPF4hGA7a13Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002446; c=relaxed/simple;
	bh=wWeZ5wKnmyqfo6klLo7hs0oKotIAM52wU8x+gYne8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKXmAhhld5O/Qe2s6disxUuDWesLV4W4rV/P8cv9/wlDBcL4BFgQ9rR1doAx6GzD5EB7DMPC6ZxwgsNSb7dJDjfJU8zutpjL729rHLC0NRJqr0C/+wc0VfBSFrvZcgrAoGtK64xDBlrGHglJt6n2TmaI6fwfolDGsxwD3zoBsCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0fNtcS+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341950a6c9aso381039f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 23:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711002443; x=1711607243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tSQhQiUH2jjd3Q+kMevndwXSXFnGsWPcdl8QHcS1iag=;
        b=D0fNtcS+FE/DteAxmgmrAEXr+yaJLvsXSwDif3OVqKJ5gnjz3SLDWIt1tgP64lh0y6
         sEGO0S9A9pair3rfQEZFcf2VF79SD/u9+rf6M2i/xSp0g4S8+r6NUAa8VGczrvBtY3LU
         MOaK2PZdvPKIdvyV4UXkGhLHk6x1uddv59j4eDCA3Kz61BKavKFyO3RbmharqkQeA/TV
         9QD2x2gk/Cn3O3IGeGYDnGsWLbzXJpMC6SSIopdZB09MoZBGWCvd8q8b3F3TV45CIL/q
         PhPtD3GdToW1diWqbTKBNrOf05b9Rsk5G4rEHdW8wd2rPYA8xhxoVra9Pcps8rhRzrJL
         3L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711002443; x=1711607243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSQhQiUH2jjd3Q+kMevndwXSXFnGsWPcdl8QHcS1iag=;
        b=rT2uwjxAv0TsJ9v3hhOMzGFi9kzz0cdraB5jrCTfYcJ/CTcs9kX8Yw+FT0xHxw2WRN
         bqZJ/t04J70/s+L0SlLXy5EDW55eroI+l6R8XMhHQIap+tUyw1TLO8sk/guB9XuR/wnJ
         186oMT4KL+Evm1kfy24qPBukGxslbRCsk1IMZw9KILnvrc5TuWWMNl8hg7xc4z0mHvZT
         Zsa/7vpz4KWO2eu9HbaUqJGrP8cl2hnFmyvGm13LEXvxKdwLZXTCp6eyia1IGE5Jwul7
         gOO31Nl8wy/BhGlRa6uujBYDk6uUu+d91XEkOLpefdPXIWzxWocMewKjdJ0cDyPWUCy6
         oydQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlmu8ZM6zX1EO06A8itDGjd+P3b+nzgX8zUO1VahpUWHuF7MxIG1v0HGV4XSK5SmYBiUlYAoMV7w0Ho//5C00bdeHhY6bQL8t0Ffcm2A==
X-Gm-Message-State: AOJu0Ywyg3Wd3hwr+bT9gmcazXBinlQdIvS1unfAjU7/rtPE5PJynhbg
	FnoDA9+npcA45mw1aenh5oM+CtjayoqYWcA0Wt4VenPYlHku5GmH+0D1sV+TmgI=
X-Google-Smtp-Source: AGHT+IGcFZM7skFlJ6C6gRjFbmw45WroL80/uGSIzGK+mD9Pf2Ww1sESE8kIm89OItZQCbsTSFMtAQ==
X-Received: by 2002:a5d:62c1:0:b0:33e:c56f:b5e7 with SMTP id o1-20020a5d62c1000000b0033ec56fb5e7mr867149wrv.31.1711002443326;
        Wed, 20 Mar 2024 23:27:23 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dd15-20020a0560001e8f00b0033ce727e728sm16332994wrb.94.2024.03.20.23.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:27:23 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:27:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <22363d0a-71db-4ba7-b5e1-8bb515811d1c@moroto.mountain>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170950594802.24797.17587526251920021411@noble.neil.brown.name>

On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> I have in mind a more explicit statement of how much waiting is
> acceptable.
> 
> GFP_NOFAIL - wait indefinitely

Why not call it GFP_SMALL?  It wouldn't fail.  The size would have to be
less than some limit.  If the size was too large, that would trigger a
WARN_ON_ONCE().

I obviously understand that this duplicates the information in the size
parameter but the point is that GFP_SMALL allocations have been
reviewed, updated, and don't have error handling code.

We'd keep GFP_KERNEL which would keep the existing behavior.  (Which is
that it can sleep and it can fail).  I think that maps to GFP_RETRY but
GFP_RETRY is an uglier name.

People could still use __GFP_NOFAIL for larger allocations.

regards,
dan carpenter


