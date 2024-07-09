Return-Path: <linux-fsdevel+bounces-23402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A2F92BCE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B431D2826D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0231922D8;
	Tue,  9 Jul 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N7nFqwjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63D28E3
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535320; cv=none; b=l+RTnCPfM93ETDOILF6wWC3WJAYX8PFDITF9C7nDahClxXSGLvchCc6APQvS8BTHelO1zzPN7Hu3NmEJDj3K3Y9cEKdEgvrs2UxkP0fgZMw4a0dEGj6UfBx2t20SGk0vRMnU/05eFFYKnt7VU7EXpeft3AZHIwQgN4ifJWv9SZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535320; c=relaxed/simple;
	bh=N51YY50iZM2xd0G1g1J7sL7mFACPG6CXFw/kqmSAsFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiAZn/pCC2BRw3mL5o0DRU4ll9LbJ0XLh4xn1KSh1GONq5D4iHR4gsdLxG7LzXGJdcfPN7kf7FE8/PqgiijcgBNvFK2sE/140Tpcl2sd5kpIgT+Jsw6fuoT8teSBsv5cbxZOiPBqddhAlN0f/gqAuvff4eiNxp2T9FTUnuT5hNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N7nFqwjU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso6598404a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720535317; x=1721140117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wU8bklL5Sk+P9jtPWt71PuRxvvqxwIqd0UA8CuZijlc=;
        b=N7nFqwjUwnzzlxroDNzxU3lx806q59P0H3rKjeKXO1zVjnSDACoDDskpWce9E3f1XI
         dxeFnnNk4ZDlqLTdo5KNZm4+OxwdNPsYF5ECY+BcqG0E2+eqaZkI774JLXhveQ9oD1Q8
         aDMYojZXDCx6iZRtqhiEn/27KPBXa/Pu9dQP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720535317; x=1721140117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU8bklL5Sk+P9jtPWt71PuRxvvqxwIqd0UA8CuZijlc=;
        b=aj8pMmcU1OUhs276MXHZMHZTPpSIF1H6t+GzDs5wTtWE9oNVrKYUUPtB52RxiFcARH
         UcuU9CAtF3DoLD2oG4QVbWGnontPUGhY70FD+Wz7T4rtaKwJv+WU5WXBoxMkr3YgMlXw
         lxoWSnnpj/+omVtp6ssy1H/17wNVWfjfGeDzeWpEH3XS64scwVloOb1mmO2RXfKl6+vs
         xOwVbOd3dBg/UOJJiOu76vp/CDIFj2h+RA6hW/MDZL/Gqd27xHpDTHEn1/FXk5UegIz2
         EcYn3juY5BzVW4lgMrE8axLWTVTlnumbWQZkagc8KCe7PCAq0BuVx1mbVEotio2Ikv/X
         xsAA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYWIC8moQYwj1axazGGXZXYUvtmvl9+jfAHLiVA1gYom+Hisvo8i0FRNqp5gDL6pcG89iKqMcWGtOcQmxt90WH2ucY/YRGNkYyN8tTA==
X-Gm-Message-State: AOJu0Yyqi2rQKYl9dXjGmLFwsBF02h1wl0xcprvkrwUEXWn09W40DkV7
	qH1PRV+N5vygenWJJsOMAcQcbUSL39zEQitbIk52GAZQcnit7ZXq1W6sQ7SUwK2q+13QzM/9t+3
	MiOE=
X-Google-Smtp-Source: AGHT+IEUDHy8lPKYzRC8fdaJItWQwN4lPREA6fPpbLsyn6pxXhkznNGfD97XdbKLEGBqF8EBgsW9mQ==
X-Received: by 2002:a17:906:6857:b0:a75:21d3:60a1 with SMTP id a640c23a62f3a-a780b89ab19mr168447966b.75.1720535316877;
        Tue, 09 Jul 2024 07:28:36 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854368sm81181366b.155.2024.07.09.07.28.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 07:28:36 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso6469590a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 07:28:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvlUQP8oKmJW67Fz4ZBXUzrtFgfTN+ZJEqO1PJ2lnSBGgMQX/RKPIkLt+0lSC5eeftt8fvS8CxLTyBzzD9kBbwgZUP0+8LyKMe2gOVVQ==
X-Received: by 2002:a05:6402:26c6:b0:595:7640:ee79 with SMTP id
 4fb4d7f45d1cf-5957640f148mr1296551a12.17.1720535315869; Tue, 09 Jul 2024
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <Zo0LECcBUElkHPGs@J2N7QTR9R3>
In-Reply-To: <Zo0LECcBUElkHPGs@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jul 2024 07:28:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
Message-ID: <CAHk-=wgAKfXySpKFcJUdv97Rqz7RxPF-uc6xsue6Oiy=tP65oA@mail.gmail.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jul 2024 at 03:04, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Looking at the arm64 runtime constants patch, I see there's a redundant
> store in __runtime_fixup_16(), which I think is just a leftover from
> applying the last roudn or feedback:

Duh, yes.

> For the sake of review, would you be happy to post the uaccess and
> runtime-constants patches to the list again? I think there might be some
> remaining issues with (real) PAN and we might need to do a bit more
> preparatory work there.

Sure. I'll fix that silly left-over store, and post again.

           Linus

