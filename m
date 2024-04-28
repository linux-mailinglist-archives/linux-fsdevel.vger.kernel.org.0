Return-Path: <linux-fsdevel+bounces-18019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4201C8B4D80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 20:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC611F2149F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1ED74438;
	Sun, 28 Apr 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OD+kJilx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24C810F1
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714329986; cv=none; b=aR0c1WaU20BauZ5zFAvsBIeaX068XUiAQBTQpvKOwJzONK9utmqd3TKcq2VIh9a6IEPqENQ+C98mC+Af6JbFBcHO+TArgoGxECRm6lC4Utq0YLA3b+hA88m2HknACK8hNGwDFHHAa9jb4VwHbtg69/6mS/VajOZ1RNg4lL5DpvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714329986; c=relaxed/simple;
	bh=UCyUGbVStsQ4PqcA5v9cIrp44bn4QBwbJ1SKpM09zOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXgR0vVR+GABziq7Y04tFEPgUzk4jjAxViMwwZ9lLBjzcc6ooOqRhweYMkBupXflNz4K9yWg53TBY4vTfr/Gd5UmfuC82uPm0Az3Y6r2nLpvS0ghR122hMM5Ji7Mhv+j+lusYrZm1q7n0QH3kqcwsvSbZVrpTElX/R6fiUxcyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OD+kJilx; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5872b74c44so410542566b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714329983; x=1714934783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=OD+kJilx9xZ9IEnsJx70FScd6agDuG5vRjpJ0LOL784/QHP39vMTjDMQvdRcOeThli
         4WI/T/8IxkN0k4h+Y7p98Sq9F9JeqIOc61MG5SLD6Jj+ZKAUlL1hilvyPcJa9z0IRV61
         ZND9lUMZ4R4febOMl3bHzZyfJ/6NkBW/fNS2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714329983; x=1714934783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGHcgF+VuTvfty4lb510NeRVdXMmfzGhEByfgWFXZww=;
        b=w5DN57gqx0i+h+l+bKJCEL9oZEI5XHbdg4hpLbZXkYWuPatSSmA5ac3gRYP/aSyTx2
         Sgzt+mQYAZBlO0me9PxAXRfzftWRqs28jgcKq5jtUDiMllOnARf1cLJzt/ZkCKUB2U3D
         SL4wBlz61RdNFQvxYUgZfQioQbd0pUFORMwQJWOo24FI3pbjpKkW30RiWvl3gSluXNGu
         vYKedAblEOJq0FSLeHakoZes9uQrVseTmXoyW206ZeUqmaU40NC2PYB0dIVWNxRlrWcu
         Ix3AWlpY7+azyYvfNxiwpr+aVjzFXrJDjKEGrR1+eNRO9EJzDw/xn4oLOMCTjv9Ii3oI
         gjTQ==
X-Gm-Message-State: AOJu0Yw2q928KfrnQQtQfLTqsyiePg5HSqQspOGhs6ybb17XSuh9+NOh
	9N9Wx2g7OM8ELxKAQeDMDOYFbivBx5b2NZD4rbKizOGoFnsh9o9Zc5pxXKK6RC15Vl8E1wRvuPV
	7gCUh/w==
X-Google-Smtp-Source: AGHT+IGRoudl4DrJ7NZZBuBp/Ux6zBJm3EqWbRB2xsRE+jxUTsDcNj1l3a/IO4183lvaV98Gjpfm9A==
X-Received: by 2002:a17:906:6b86:b0:a58:bd8e:f24 with SMTP id l6-20020a1709066b8600b00a58bd8e0f24mr5845833ejr.39.1714329983024;
        Sun, 28 Apr 2024 11:46:23 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ld14-20020a170906f94e00b00a58ff5adad2sm524624ejb.90.2024.04.28.11.46.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58ebdd8b64so102540966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Apr 2024 11:46:22 -0700 (PDT)
X-Received: by 2002:a17:906:c7d6:b0:a58:a13b:37b with SMTP id
 dc22-20020a170906c7d600b00a58a13b037bmr5288677ejb.56.1714329981787; Sun, 28
 Apr 2024 11:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240427210920.GR2118490@ZenIV> <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV> <20240428181934.GV2118490@ZenIV>
In-Reply-To: <20240428181934.GV2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 11:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Message-ID: <CAHk-=wgPpeg1fj4zk0mvCmpYrrs0jVqrFrRONNFgA8Yq6nLTeg@mail.gmail.com>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-btrfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Apr 2024 at 11:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, pretty much the same can be done with zram - open with O_EXCL and to
> hell with reopening.  Guys, are there any objections to that?

Please do. The fewer of these strange "re-open block device" things we
have, the better.

I particularly dislike our "holder" logic, and this re-opening is one
source of nasty confusion, and if we could replace them all with just
the "O_EXCL uses the file itself as the holder", that would be
absolutely _lovely_.

                Linus

