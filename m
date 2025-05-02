Return-Path: <linux-fsdevel+bounces-47900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA7AA6C57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 10:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A533983BE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 08:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46A2690D9;
	Fri,  2 May 2025 08:11:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFF19FA92;
	Fri,  2 May 2025 08:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746173485; cv=none; b=OkT5AxPPKOdH4ym4YukaPE7EBxAoo1LupozW01SZDYDbUH4LdOZmyX2JawXSAECWAUTvg5Uv3+XWspAGgZbPeqThzk9Q3FBfC7i/udChXXLeF3u2y59Xlj7M4t8jsqzyd2mEGMVi8D3XYsQ3rYhuWpIGdOJAdMGQV3wxacwhEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746173485; c=relaxed/simple;
	bh=/l9WRHoddJfJFKPKt/vNBHpMtm1OJBFgkOV9dcTiSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiniIj/znMtAD+X+o0SKwP8ic7RXJaS1uq7kWEaTEvqL+WNz4oYs8PsGJ+g5wQ2l8IJiujjRRGyNzyJTaf8FLmjPxt1n6mOI+wNBJkgxltX8NNBHQH/2Fd8tLSg285z4DTHu8s66UvZW+a1EbGC0H6HnhSBfQX70MdLjv1CK4BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso13616735e9.0;
        Fri, 02 May 2025 01:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746173482; x=1746778282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l9WRHoddJfJFKPKt/vNBHpMtm1OJBFgkOV9dcTiSDo=;
        b=pcQZBnDz6PDlsFkwUVfID2HPnMKhcneNC//sWHPJlOVtb0pw3pGBX1F2WjINJjJDKq
         g5en82s7pAUu6d7yEJ1wyDMJlsJLAzS6LFLz5NQsSXFRY911iHsy3XIsve4OrONz/bgk
         NKZpGBD4Encz2iX/smED3Q/iSvclY4JqpcLqPi+/a0h/rSfUqXVVhTjCWisHUyM+3b1Z
         zzY3TIpA3XwtCecJO7zZXwozs31Q7hwywUjZcMkiweOHR2LTunBwn0Dism9quEeGwgdh
         4yis0iBvQJB0JMdkNcWpPIjgB3tDKERqBFJL2YnkY1et7y5l9bI+6sk5ITo9U2MAU+0Z
         OEoA==
X-Forwarded-Encrypted: i=1; AJvYcCUVo6RKyWB3rOSN3Aj58ct1ifp9WV0Xr8rUms5RA52WHNQVPvKzucB89NAO/61tTvNu5hBsVZjDOybT@vger.kernel.org, AJvYcCVxxLIB8fyY7GwzkyNHqgnwYUcpe4QQX8pVxuxoTMCzCfRKxUDmyEfhormFJQz62P5SsTHdwMbu0DzA6Bo=@vger.kernel.org, AJvYcCXPwcOeWiuathjXbrn53N7Sb4o9ydPWMbnvzADuzzRU0D3vUFAr0PNpVUQBr2aDqAzdm2gN0O7T9b0t/e8=@vger.kernel.org, AJvYcCXV1EB7+pT8UHUN063M3VbedC+1pFMLMfP9dRHt6tSuggZsZynHD4g6AeJdJQk7n2+xtaR6SXgdIvJs6PA=@vger.kernel.org, AJvYcCXV6iPVmEcTUsyA8lH/zZHOHE7M5bNkRXYpr3Uo4lyHvIs/ui41aNxJfw0fdgW2pXfBV0AT1hDtGnaUDBBl3A==@vger.kernel.org, AJvYcCXfWfQhKq6aLQ9noMLvhoYJn2wFNAkiXlWaYWnibsaXB1s0HW/qRjTMzBgEHUJWX/mUfDpGYtHWnG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrtGsguGwe3nd14l12FwTvbpbUuvgXvgk5Rfd72K/5G+HfY5b
	Sgx9nZonXsA5PVGdbzPW7onnX7MZt7CgOFFuj0T1dNy3KYwnVwOQ
X-Gm-Gg: ASbGncsWt40bmBRbcbytn+FxxHY4SMhTsu3pcgPWft9qA3LCpTBkm5K11zdOB+QzzNG
	1LCgLh+ved/2oUawZPKZjAYl+CssO2v9vwuPUDnOHNE70WPCpCTOqwN/xxip4uvFjnIpxBlLkQS
	R4uUx3SGMYhSyYDGboHnJF3SWPXkSCxFfSogW8Xyue4/l0UWIXCC0sbuR7jn2YNwYxaxw5GvTEC
	yryQoik/Z519ZtIs/KktQfoGJFfwn2T9Jn1O/UhuUq4VSSUFLBjJigeT92pArchKuW/aIiT+B8V
	kjvqHZcZ1TAyOB8i6IIL1mVoBcfMSGb3t5Gsyh5EOwlPQ3PR641CTuH0vw==
X-Google-Smtp-Source: AGHT+IF5PXSof6LicA+MgHiU22N+nB2PIEsPoZ92lRPcS/dOgUxz6GrNK7mU/Mus+h0qVk26GnapfQ==
X-Received: by 2002:a05:600c:1d99:b0:441:b19c:96fc with SMTP id 5b1f17b1804b1-441bbeb0e07mr13471465e9.11.1746173481946;
        Fri, 02 May 2025 01:11:21 -0700 (PDT)
Received: from fedora (p54ad9a78.dip0.t-ipconnect.de. [84.173.154.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc441sm36983865e9.3.2025.05.02.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 01:11:21 -0700 (PDT)
Date: Fri, 2 May 2025 10:11:18 +0200
From: Johannes Thumshirn <jth@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/19] block: add a bio_add_max_vecs helper
Message-ID: <aBR-JiTsQj3Hv4DA@fedora>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-4-hch@lst.de>

Looks good to me,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

