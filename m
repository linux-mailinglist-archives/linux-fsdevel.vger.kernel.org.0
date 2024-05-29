Return-Path: <linux-fsdevel+bounces-20489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7678D4013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA991288323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794831C8FD9;
	Wed, 29 May 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sr5Uu79D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE716937B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017007; cv=none; b=pxAUqFtu+XRSnTOgk817628JXStXKTHzQ9ZZOqYRRSbL99BoF/NXvXzqzc7ARrmDHG91HpMSeIcG04Rm0Hx2svZqzRToBmzMeQ84wMr7Coo6wA9Gc9VTLbstxljWrLLfYays546wgH2qVcAxcQFpnz5/dfwqRYyt/70dEoCUERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017007; c=relaxed/simple;
	bh=lLG9qrEBzzrrlGSBkNqSXTOgeYFJH/Weto4xUPpeTKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjVKMRL2d3/EZ+Q/ofvzD82byr468lIg+ZpNgTjmfJFQcZrpezj2ivDNO37iLohYwOOx0mfjhJ5EMqjFLHCX/1QAi38qNremMeOt2QbFwX3/iLZZRQumpIRBkbYpKRPgpIxBcZ2MSBC4DDTH3vJdKfBoZqXhUBY03EB26h5JbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sr5Uu79D; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae0abdf095so806596d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717017005; x=1717621805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYXYQT56dUMur+eiosGkrWQ3rdaZiq2spf9dV3EQNDA=;
        b=sr5Uu79DHw9KWEOOppodJwtnzZn1aXrahB5glieLla1fqDDoLhkUqqovUrCyhlOAi4
         t/O8hsN+LH6/PB9Gpdmni6a3Xi9YV4M4rQjOoPQBgJ15BNOUd/x/A6KdFtWY7y0H/vY1
         zu4/EeodEBwKkxiLtpR9CNsHeuICvtVobJaRlgJA2UZIU6PPAu3xE4PRWvTZAj3r9zy3
         2/fqTmzJn4rgVJy97S7D26eHrLWFUeN2xkWBrzp2zM0Hld/to5fi9k/Q6Bm4fYPrxfhz
         JR817oyOF0ih5sbTXp9N+ewj5/mBrmhQmkAzUlZTqqItLtutxhwtcfDDEfJBhbf0juNd
         jcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017005; x=1717621805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYXYQT56dUMur+eiosGkrWQ3rdaZiq2spf9dV3EQNDA=;
        b=iueZbS+shI7aAlze4nHQJPayU+6R5n0Q8gumnlJeBnl2Mjb/XFuTcoDPICNFlVJ5iG
         VWFKL4rdmyVwIEIFbBDk+V5u1ITsS93Vmx9hnVLqSJRd6iCz/JKkU4o19WmDmewSXm/T
         KQ9DcGQ48vSgU+S4s+2nde37sgIWorKZi6B8wnqUpY2nKBRgzYNDjBa7DN9UsiIkhxMR
         MHbRC6prsI5HuwS1IvJyDSswbtTaRCNQTwtgVvSG7l/LpfC2uMAXWBF3YVYyilCL91kQ
         HuB4D7mHOg5ISQGxni6KEc2A8RMNlsvPkYc6stUPn1/aH2vzwuK2UyKcw1ToLm+flbCq
         6cUg==
X-Forwarded-Encrypted: i=1; AJvYcCVPfqAaKjOVFcmVw2GXFqqqHdLV0yAh5tXSC1UKiCxS74Qb/jfq6X4f2Hg3HUdiGaVyl8VwCx1oKxEm0ukE2qT/mZc0T3+Na811iuttXA==
X-Gm-Message-State: AOJu0YxCL2QwF0taEn1QVVttjZCShnyFyePol++wQb0KkDlJxzqRluPC
	7Rwwhsi+2oyL1qG4VcZwvzPUmwDuWxdZlwR7U8DVz/1ZRXzk1A5i8H4t83NqN4Y=
X-Google-Smtp-Source: AGHT+IGLKAXmaGUOe5Qjb/I3FEZxsOnj9YSEYw1BzvqcJAG+eSLXICDu3GOX1WlKYqFs9LIWqGpZeQ==
X-Received: by 2002:a05:6214:4603:b0:6ad:7577:ea72 with SMTP id 6a1803df08f44-6ae0ccf4f1bmr3547876d6.63.1717017005601;
        Wed, 29 May 2024 14:10:05 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac070f0f77sm58220316d6.59.2024.05.29.14.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 14:10:05 -0700 (PDT)
Date: Wed, 29 May 2024 17:10:04 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm
Subject: Re: [PATCH RFC v2 03/19] fuse: Move request bits
Message-ID: <20240529211004.GC2182086@perftesting>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-3-d149476b1d65@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-fuse-uring-for-6-9-rfc2-out-v1-3-d149476b1d65@ddn.com>

On Wed, May 29, 2024 at 08:00:38PM +0200, Bernd Schubert wrote:
> These are needed by dev_uring functions as well
> 
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

