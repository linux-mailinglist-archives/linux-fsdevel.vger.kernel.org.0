Return-Path: <linux-fsdevel+bounces-37142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E39EE4AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C514C1660E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7ED21147B;
	Thu, 12 Dec 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="afFvSiAy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22D12116E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001433; cv=none; b=agUX2S9lQ6Veds0vImtA/cRjqPglAwOe+y+Sbc1WN0Zrrqyf/BuG0fcq8orTipnt8fQWrhxszQQwhMxwDjIg1coOwn47ssAWykhPJhXYEqKh55Yt5lTaFwEz189E5jcPiyfdNJ2RbMN56pcjHLPK6OYLHDVRsBqIChAK0McZMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001433; c=relaxed/simple;
	bh=iAsrtImFQAmrN2a+yJWp02R0ljwpzKF8GJhJArvToBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RYV1QhNOdQr6mCqCTFR2SNO6SnNWHF/KphB2465jaqLscsbpcEAemsxlgxZmSq3sUKpVqegQXscRN70xST8puoBnIK0HBgMIElwEOK3JNCL9XM5uWSgvSLfuaWpkhujnEbvVcfJjVf+Q2hnV+DsrZ2UkfDgkfEePl95DIYyPruw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=afFvSiAy; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4677675abd5so2080351cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1734001429; x=1734606229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iAsrtImFQAmrN2a+yJWp02R0ljwpzKF8GJhJArvToBo=;
        b=afFvSiAyDXi0VyKk/Y+Itor0XIecmlC4gusnMbwq4b3Ha/fo/csw3ho95VCmPnMy98
         V+VHEg8wVi0WMGVm4gh4ZW8KMI6s5E98DmQswTNvWm5X7Bjb/oD+MevlOfBIRfB3cvgx
         bYbyvpbCHqAE+udHrWi4rFvfR5Ig71GqMvUL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734001429; x=1734606229;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAsrtImFQAmrN2a+yJWp02R0ljwpzKF8GJhJArvToBo=;
        b=KCy9oW0y1VlPcSrt0M/EZ4nDBZeIDUHgtT0fLudGFknUfm3+MmMx+sPDxOMmjp0FUJ
         jSl/a3ahLcJzY/XX78ZD/cCaDkk7NiO3Txhh3uwk0TZTlpbtKQ0xyvcZtPRnWY5038ud
         HsHM0nXq5JhmfZQm19Zxue9FDp4CA/HEkN3R6h9IUbMLOwltS29WfaHCfNq1Z5tp5Q0J
         FumnXrYNqPs02XwyNSyUPrrOPhf+FoslRuQAYdQOaifFzBFhk7IfyWKYTVsi66QAyTjD
         6nUxLf7Zg485XvQrTByLXB1syou2WUer7Xza4cwPgECh/KEED17yYnEVZkXghse5LYKU
         tbSg==
X-Gm-Message-State: AOJu0Yw+nEIotLNloq2tWZxGp0cZu0F24dxADIvjkxV4jpenaRwQfBiR
	SUOkqaHoIOvDHNaqqVFTg/7ukDWeolRktpCXLcotKKBgrmHD/bTVU26ovLXH0sDZ36KLEYvnPa7
	HICUKu/lU8ulBn2GCbh9KSBdh4m4nJxGxuJnVAlhasOd3NzOz
X-Gm-Gg: ASbGnctdd6EIj9mlMFJiqP7vYIV1OnE2lZVPKewiTNjsgwtSF3/l5qC4DKad2uQnvHW
	XQW30U2+sDDkYyw89Q5dD/bloUzj555Yii5zj6A==
X-Google-Smtp-Source: AGHT+IG/5Y483ldzQpyXtSXdAjEnSTpbxX1khrU1ocGj9mgb17z3FoC/CReG9jvuVavOEtUVyhchn7pfUtOcDMVfDjU=
X-Received: by 2002:a05:622a:c9:b0:467:53c8:7572 with SMTP id
 d75a77b69052e-4679616e596mr55284951cf.13.1734001429714; Thu, 12 Dec 2024
 03:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211205556.1754646-1-joannelkoong@gmail.com> <20241211205556.1754646-2-joannelkoong@gmail.com>
In-Reply-To: <20241211205556.1754646-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 12 Dec 2024 12:03:38 +0100
Message-ID: <CAJfpegvDMC1S=HU=dXAOZvU31Qkir+D34cDS7FuwnNnjW74ODA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: fix direct io folio offset and length calculation
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, malte.schroeder@tnxip.de, willy@infradead.org, 
	kent.overstreet@linux.dev, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 21:58, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> For the direct io case, the pages from userspace may be part of a huge
> folio, even if all folios in the page cache for fuse are small.
>
> Fix the logic for calculating the offset and length of the folio for
> the direct io case, which currently incorrectly assumes that all folios
> encountered are one page size.
>
> Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied to fuse.git#for-next.

Thanks,
Miklos

