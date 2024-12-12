Return-Path: <linux-fsdevel+bounces-37123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708789EDE8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B182822F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 04:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAD16BE3A;
	Thu, 12 Dec 2024 04:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mWhQGVGh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AD1553AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 04:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733978110; cv=none; b=Z4HGFlz/jLjsBaMFJJNmugn4XuBPicplhcQ+sdf3A/6novE43GSTrOzf+BwokwTjg374R0kFbdfUJWBYTOcJRZ+mrxgsnqMng7B+m2vf+mxKJRhc1DVSO7oLBvE8XkqiTqroAYpRn2l3979A5XFUPiunTMRGUcq7wPdDh1qPrS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733978110; c=relaxed/simple;
	bh=ilLvlZcUUBmdlXI8FEVjzvo7IS4oqNYGJn1FjuvEca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO6IF4tAFh8P7Z3ZRwnkWWrX/b88YMEayAkllPPvq3n9A5KTQIRUnA4Z+/ciyJcDKyauZsgXlxDp+zKgLhEhqSr98AdZGqdSa0JQTOHqZlrYWSsfoEe8jrsN/QTqwrYhFw/HLuxTJHTzrogk2PMf/1k+pORiMc3miL9AMFLz/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mWhQGVGh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2167141dfa1so1669805ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 20:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733978108; x=1734582908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=mWhQGVGhK7ocZzEPwL4+s8hJreL/v2rshnO/2qrMEcm3Bj8EQamxsCSWcTdlW08laC
         YNGH+jXlJtjQpvE6USJmkZ14e1ZA26/CNuxS3PsKJXmCJyhjsg896ENHxTp5p9vOcmL0
         1y79IXKovXvRu++oZb+rAdQic5svkYtmJaPG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733978108; x=1734582908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eQ5332V/XImi01nVR9uvfbX+zP8Oy213LJgoxa19qw=;
        b=gzvPgI/LBCwL5N6gkrWp2fqi+nMzVyofcGHphDbrWQYvkmrBg9jBY0251C8jZpHkaK
         bL/svatYKMWeUHiTu1iQPpBg1YcySObQm16FYu3tbIkICQadPe7nZfaR4Gn6KEmTf5me
         eCL7TPclbRRsgb99oWWEMQtZ6lCmmGjQzOUz/Rrd0nv0zZojKWvV1FuJfa86NN1eWccn
         +nDR6o42iXfCsCH8F63htx6tkTZvHG+hYg0u+J5GmFc1C+x0B6OzH956QLHKQV9HyqNC
         BlwPMXKJQGtKDg7DNdkiTFSV6v6b3nQT6q2fl/QF9mWeikxXW6BMeSju78nEGGTqyBhq
         f3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBm4ZgCEW/xu6ZVGQpo6kZ3J872zgPr9aF+kdg5c1xziPhCzooDeputWbQDZe+QV52JpxPMTMg9ldA2Q7A@vger.kernel.org
X-Gm-Message-State: AOJu0YzHiDyEUNY+GlzmSystoZDCYUc6YBi0giVVs7+3vwu8s7lgXddd
	d//OtCokpwGQ3HDi4rSklcHrKoECQlT/HXyUFiGp22RXyqBJwm/331VekVIp2ajU3A0zvb6qTYk
	=
X-Gm-Gg: ASbGncu86J1ADraeQ4xJXpHyGVKMOvYTHrvmDbBqxv5+Wl6wIQVMVnkt/7oW43GEupJ
	FKDD3XoyMNl5Q/ajjprDplPFSpSKZCYVGYut5ovyfrvxGHCZ+HwQxSBmQ0DqiPHRwtyXpRXwgWw
	d244UNCzQI4AwDxTLLDzXHesetS/GoR4js6EEDKlYsFq7YlIKzaCM8aMEGV6NpuliNhXzCN6B5X
	KwPHOTlMTYn2o8BwWItMgLhQAmN/HIfruImgIMEgdrS0hxs7e9/7fTlhQyk
X-Google-Smtp-Source: AGHT+IEbTjYmoNjSHfYKhvMhadIRj8HQ01ctqbumJOOZupMel/xzlHR+iDynhJ3nrhudrJBVMZIUlg==
X-Received: by 2002:a17:902:d491:b0:215:44fe:163d with SMTP id d9443c01a7336-2178c873b07mr27094985ad.17.1733978108182;
        Wed, 11 Dec 2024 20:35:08 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:d087:4c7f:6de6:41eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2164ec76ef8sm59938415ad.228.2024.12.11.20.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 20:35:07 -0800 (PST)
Date: Thu, 12 Dec 2024 13:35:02 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	caiqingfu <baicaiaichibaicai@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212043502.GI2091455@google.com>
References: <20241212035826.GH2091455@google.com>
 <Z1pjJWkheibiaWuV@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1pjJWkheibiaWuV@casper.infradead.org>

On (24/12/12 04:14), Matthew Wilcox wrote:
> > We've got two reports [1] [2] (could be the same person) which
> > suggest that ext4 may change page content while the page is under
> > write().  The particular problem here the case when ext4 is on
> > the zram device.  zram compresses every page written to it, so if
> > the page content can be modified concurrently with zram's compression
> > then we can't really use zram with ext4.
> 
> Do you set BLK_FEAT_STABLE_WRITES on zram?

Yes, zram sets BLK_FEAT_STABLE_WRITES and BLK_FEAT_SYNCHRONOUS.

