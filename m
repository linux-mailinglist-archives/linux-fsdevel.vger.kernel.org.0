Return-Path: <linux-fsdevel+bounces-47904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10BAA6DF1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917CA7A6136
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254722E412;
	Fri,  2 May 2025 09:20:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BCF2581;
	Fri,  2 May 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746177657; cv=none; b=lkGHk5ciEaNNrlUXFt3qOaQ9Oty1raje0mRSkXJ2TklSWsBn9x2Q6DU6HrzaY9re3Ow0j/SH17DvVyLr5AC7b07Ov39TWw6Cxc5OKajcdJHPNJLKbr6pAs3YVhRd4szQtRjjC+CQ+1pQEnPkEtmr0hPmBsOCVYpvXTw3ZXL2DpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746177657; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d251SIS0NgVnp6q6ZKa+6rcR4vlEG0M8yFIUwS39sSGXaW4dCGf2nH8AEzp5bEd7ElOYTcxRwOqcjNTIGRKry8oIxkPdeBsx8o31WwmtFzd4/hIol4BFDj5WNng2mc1TdDXy/PfroCq6Fm6m8zMatZdjbi0t8mKtLtdSMaM781M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so13036985e9.3;
        Fri, 02 May 2025 02:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746177654; x=1746782454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
        b=U1DIn3GaLRTVVzNmvDrdfvfv2nHagj10/ffZxyXZz9s3Hkt/xwHpgilAxSV4ejK1/o
         /WuJnvvj1Dd+/Iu9xf7/s9sC2RNFQwCI0RadVycoVD9fOaWV2dFI3uNCq1vVt1E/4BUm
         CccyMqKcPCnkLJvMsG5ZLckIQdaK2pvcVdE/DLrfhWw5XB4n7M2uWcyovahiyoXZdhWb
         +K6ECrjG3Txb0K3/fy6f1ybnuTOC+RH2ObneEWERUEeAVsjuwDD4Bd4VHbDPk1FaWQMw
         SW4mN87A1aFoV4dAy+SqHacND7VE5E2xSKwG6xPDh0hHCigNHgw/VzFArLlsOiGLZWhb
         xs7w==
X-Forwarded-Encrypted: i=1; AJvYcCURwfP3XT0tbazW3EDOFTCIusRvNZ+yA701cnA+vQFnxMs649P+r/B6+fO1JU+E32liKX9RAc6iOJkK@vger.kernel.org, AJvYcCUYoDkx3FxJDyYSdX9sRzNDCMMb17Xd+AYjQy8RKbbD4I5S2TdX2NS4ToPCno6YCmrclhKpkxNB1n1mkIQ=@vger.kernel.org, AJvYcCUdvGQf/zbzAMdZrd43TPwHTDeZeJnReGPjFFvp8aVk8pA9Kr1EI52Fe3En4XVu8hk6wdhMLapHOrj6QXkE4g==@vger.kernel.org, AJvYcCUhD+FrKGd758fXGKLoj0NHzBWO7AdPhVn4Ycp43Flj+DC375GmJpnHM/5LuQL1ceLgjGgFbp3m0hk8VqI=@vger.kernel.org, AJvYcCVictzNH/8LSq7ypbVTSRe+MsTj2yzEn1cj/nqGCdL0Hm0N8+fObiqVckphkPvRo3++K/IJZvkvGbE=@vger.kernel.org, AJvYcCVvWbaYCtYKk5WwYMHM83YExn5zuLggbhCehi10vgzXMtCp9tuoJCaBVvskZPa1lpqs6G63TQDxVeWlxUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6UtHaSXqbRxHDrBNqPUGvcYVWi+vzgHLj1PFmRATgoSGVED33
	kadjvLDRthlpvzXEu4iqq6UIcQ6m+j0bfZwL+3jp4xUKzvWrPZQK
X-Gm-Gg: ASbGncumY110CLmKeW449aEYgUltUh5ZPpiq3hY2h/6J9G4sYwwNqW1dGVjMw5rROfP
	7OGZQn0eIScgusMLlwoi8z1Yz36IGytN/VIGEZutA4HX5T3AANi6DKJXf70NNQ+dvmgVrSVlASB
	IHAIRHFMJOLTvE6hybAmf2BxROEIgFTJo/LzN/xAeMkVulEhZyIxpEJ2M9Q50FOcd+vZsLc458v
	ChRqgmk+B4CpvObMOdBTDcsbJfJ5D2y0kxEOOS3SpB0tGdbXTAmhQo3noNZGeX3kzeEWRuzgX79
	CtJ93uVV5DRPDXCZLRuNG+akU6g+aCItxeIX84luxh3VtItH6JLhen8buQ==
X-Google-Smtp-Source: AGHT+IFgGSam1M2eyL/4Vk4mDkIaVvxS1jdjCI6lel5HYbzONYXZiJZ8VWNJWL/XzxR8+LguUZV9dA==
X-Received: by 2002:a05:600c:3b20:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-441bbeb0efbmr17223385e9.9.1746177654117;
        Fri, 02 May 2025 02:20:54 -0700 (PDT)
Received: from fedora (p54ad9a78.dip0.t-ipconnect.de. [84.173.154.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0b9fsm1571335f8f.4.2025.05.02.02.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:20:53 -0700 (PDT)
Date: Fri, 2 May 2025 11:20:51 +0200
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
Subject: Re: [PATCH 04/19] block: add a bio_add_vmalloc helpers
Message-ID: <aBSOc4-xWw9JLUgB@fedora>
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430212159.2865803-5-hch@lst.de>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

