Return-Path: <linux-fsdevel+bounces-35589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BEC9D60D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E699282C1A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F018148828;
	Fri, 22 Nov 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YKSh3VMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFB182D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287038; cv=none; b=uvc1JHskB5IVOaWspAi2tvfyXO+Zd7QoaJRUC4enDgTHfEM9PqNSmomADRO5TflwQoHXxCalDKYtf1rpo1HociI6Da4ms/iz8Z4R4xntGnXenhLCgLvCtF/5X2YtQMMpXuaMFWPgjre24Tp0GsrKtvQVBdATsw/F9D+hvhvoc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287038; c=relaxed/simple;
	bh=eALR0PYAuKNOKmSX5m9QqhJvgxHwOcMl5y8MaZjp/1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4M1ecKuehIG7/fmu6AGhr14zMjsGVHl+6gNk6bHHgw4lK84FMY8570IIjMcITBz4BV6S3X6SnFDl1rxTtS7x/VoS1SaJQ3hwuhaeVZ+ougcu5amUnvt01JsW1EGKh22vvwMD281BK5Fs2m0BawrhZ17R8ziR6VC72eXUYK7mPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YKSh3VMW; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e6089a1d39so1158902b6e.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1732287033; x=1732891833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNh7GjPCl+r0fR0Mcc2zYHiRPONrDdVgiL01cav1HU0=;
        b=YKSh3VMWiw5ONie0an+E4ZJHNYWvOrMyEkJu9q1BYvxBd8FuUQrAAuAU9/jsQMN3Q3
         zGkwNGAS1OjrekmQKg7ASIKdmudPMHNqLj399uSC8AHgMpsN9RIY1mBjMaEJ7jcHKLk2
         bi3hHuJkylnaODru+68nqy2s8Ahi/vLNWIm4s0WSp3rCnrpIYB4CjwZl4y4a69eus9g2
         1IALU5tF1DBMk/vLttWC5zW/VyIzCHxM++b/uoxpHfyeSkV2z+m1ZUr6RKzK0SEto6pN
         FmbFzCNMXuIuTj1OHO/Dl6dqk7hxJUaDDth6O5UDr8953gSsTsWyiNmBJ7vSNR5136EA
         KW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287033; x=1732891833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNh7GjPCl+r0fR0Mcc2zYHiRPONrDdVgiL01cav1HU0=;
        b=WpbSAxuFW5uIZFwgiz0bghK47EYzEvRrihoRBB+4QGLpgCFwq2oxNd2Nq7qsUgx6M9
         8efyknMBXOzsE7Wjt/JG0qNLQlB5KllDqrVcDlfX+T5FMybJVTj2pLtlcnJUaUYrYJqf
         BynwH1y26tE2A35lKjcH5IIKCDwj6ZyGyFkcsVGIsbu9tbQlZgaRYEjlvI7bn+1HoPp3
         /lCHtSoeacCrghgD7FKH7VYbqtYIflp5PwGzogvLXLuXa8eovOFhHHXnlV2gn9s5L7Hu
         TK1QcFBC83UWu9wau6IErldbrU6Di7PrJDeMF+XjECoPWqGIgNQDEaAkIKJpXuOBmgbf
         wgeg==
X-Forwarded-Encrypted: i=1; AJvYcCXX4MpdX7QtCNUvbEPVL93EArNmd6obvr75MK2f3RiKODUYHdqUPkCNhs2ruIoxZZOFIccj/bY3537+LUyF@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTphCCyo3TDFBVzJmQdDjSg8Yxz872epvDVPmedgKIT1qmicM
	KSe5e6JSx3F/BAvSG/WfUTBN1pTldSTFTzWnDykvm5+JLkGufe5DRImwXwUDtaHUoPHjQrDoYTL
	1
X-Gm-Gg: ASbGncvFW5/ecY6L7i6Mc/AJP8Z2XPpIoU7xzjd3xlJbDEqlzw7H3oAJie2iY8Ykph/
	A0pwtyqgfSEDMR6SozfyBGxO6sUEoBqgd1MrOa/6tkZ5rc+3pOtA9i0Sg6YbBGsX7nAnhKv8HoA
	n2LiEoW2PjUEwDdrian433EvnYDQapiNAb+rtiwHVFaW2YlqkmNysIy/PO8E03fJL0CW9FG+bA2
	lBIwYRgH5qPdzUdNHenUhhGxud4rHLHbkeMeYHr6WmzPrusRpuQmWuAxWQhV73w/OJBwnIQw2lL
	Qqp5bdKPkG0=
X-Google-Smtp-Source: AGHT+IE82Os+YoFbQhV0MJXyg97Kyw4N0eW6SKK9vUnF/oRMaXpzMiZ4nMYTmGyINDresjqvIWiWXw==
X-Received: by 2002:a05:6808:2286:b0:3e7:aab4:db62 with SMTP id 5614622812f47-3e915a64e98mr4016706b6e.36.1732287033160;
        Fri, 22 Nov 2024 06:50:33 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a97d7fsm10593426d6.36.2024.11.22.06.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 06:50:32 -0800 (PST)
Date: Fri, 22 Nov 2024 09:50:31 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	willy@infradead.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 11/12] fuse: support large folios for writeback
Message-ID: <20241122145031.GG2001301@perftesting>
References: <20241109001258.2216604-1-joannelkoong@gmail.com>
 <20241109001258.2216604-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109001258.2216604-12-joannelkoong@gmail.com>

On Fri, Nov 08, 2024 at 04:12:57PM -0800, Joanne Koong wrote:
> Add support for folios larger than one page size for writeback.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

