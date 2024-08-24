Return-Path: <linux-fsdevel+bounces-27010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A70A95DAAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17AFEB22524
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C0828E0F;
	Sat, 24 Aug 2024 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Rpf+v7To"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6A15E8B
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466960; cv=none; b=jWNCJunDrhwR4uOOfqsE5/kmEcIDnTtsBl3PJMAl48uq0D2h3K6eD1sd5btV3pZ9LJdAiFyaieC56dVgMX88au7UVUsQ6BN8iFzOukNqzSwe23j3j/4PPloBnIm7YRSq8GGBe6e8kptF6VcoEUXq72sYnAJaSnlwx3u8biEq75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466960; c=relaxed/simple;
	bh=fpOTYeaTgYEfTyZLe6LL9YNO65uUXscpke96JBbH5Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uygSoVlEb1vCSsluHasjQA5fJhl+0LOLNJZOQ+FRG+5tt74nr+fVs3VZ82YBrjYn0ueX+Rzc3HTm9mth1mMHXYNv3tRu/Rq0bL182wbEiKhoaL597lnWFlD9QnauTEjUlB9/mLMaP3ue++58AqDwV1NsdNKA/6ruBDmTd/gmKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Rpf+v7To; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f409c87b07so25849881fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724466956; x=1725071756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iIZTNjIJCLen0zby3onx36YZi/MddADrcfReM+hGJ8=;
        b=Rpf+v7Tojz7M6zH4VKSvcAdHh1+fjaF0WZO73U0nj45nr4uMZjfkdOgXl6E5+ijjop
         PSs6bgkTXagKDyM32HIpUpXZXLFak9X+Wq7KIYHtRxZIUAosaJUykDuCttFv9mOugOaH
         EuJC6Wcs6XvnNUFTzjThkV5N1oAdBgdOAJsUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466956; x=1725071756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5iIZTNjIJCLen0zby3onx36YZi/MddADrcfReM+hGJ8=;
        b=sKH9j9EqOtPEOjEnmvgEOXi/NocdLw9xvrC18vcYjsAZsfCNS+a5cnIuB44pe7oTS5
         zMt8VYOUluYYmpPNu1lRRTrEiChDWYbiB5daGA4RqERFs9zTRdCRZrjleUhNeZmsa169
         4WUS8S9hoNgU4VdyrMms+oVUO7INgqkSUceyAM3FhgKbYgSYAXCRHUqtNzBuvESFb2Wp
         1WdtwIAQ1oP3DcoA9LSr9BMl55EqSTZ25PZbTu5qgv6c+OFaIVwlqFvgLkgkIGNr6mOd
         4NgaxqhbuGvKOdVvjwbbS0hSyBAfegKKuj+/s3UeaRixPX3JUmV1LzIICd79e3wW02aq
         y3hg==
X-Forwarded-Encrypted: i=1; AJvYcCXlU26muAFKcjmGItvF4rGTKyjnYNMMj++Xem7uSh6sdhAJ9EjR454buQvRrlOIYOcseagY2dI4rG+pDV2M@vger.kernel.org
X-Gm-Message-State: AOJu0YzXFP4AhDPiTQRiKpL620VziyzCSajEQWD1V3u4ux79kc8LivcN
	FUGW8JpSZHHbqdSIbMuOMZIchQE1YrDz0rv5nmN04rPsqwGuGoNxluV4s7bOY1aNIQFWTJ2cGgI
	7ECXF5g==
X-Google-Smtp-Source: AGHT+IHHfqCMhBMVFZjC6FSDdeXRKyC51zNq/Xn/KHnasTGmpICDU9XHJDxPYVMmKoPIfH1ZBRNwaQ==
X-Received: by 2002:a2e:b8c2:0:b0:2f3:e5de:7ff1 with SMTP id 38308e7fff4ca-2f4f4733210mr26040271fa.0.1724466955868;
        Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c43f2sm2771527a12.77.2024.08.23.19.35.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bf068aebe5so3624127a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW40RnijVj/+p87SDPja6RdKKzh6nnwVUfpSZKvr7EtcAID+A6ZnLcahuf5WnU6/kR5ORcym58TBILGvAp6@vger.kernel.org
X-Received: by 2002:a05:6402:3608:b0:5bb:9b22:68f4 with SMTP id
 4fb4d7f45d1cf-5c08917592bmr2570008a12.18.1724466954761; Fri, 23 Aug 2024
 19:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com> <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
In-Reply-To: <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:35:38 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
Message-ID: <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:33, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> What is to be gained by holding back fixes, if we've got every reason to
> believe that the fixes are solid?

What is to be gained by having release rules and a stable development
environment? I wonder.

            Linus

