Return-Path: <linux-fsdevel+bounces-23058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E806F926750
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251171C20E10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 17:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933551850A7;
	Wed,  3 Jul 2024 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KfRfMCrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C9B1862BA
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028456; cv=none; b=TpieAW449lh+gMHvu+AKTSgKaDBBNGG2ei/Zeo+89V3XGfyjVtVPgHRdJkpgXGlgmLzOCBotBQeWHFl1smQpq0Z951NQHUaRbz3M/AFsZan/4eV7VRKpabA2qt3ajYcbMSNbeg431BuujXWVZnmdjlUksxNFqzZ4dt8RQ50UHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028456; c=relaxed/simple;
	bh=OmJgZmMNMA+vqsqmuMadaQXQgXYtB0kLJuTl566s2uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F14/771q07sACr6IAmcIEf/4QPLb4lUD6JwJlPiNGX36cXzgKx/+zVYK7A4Otq+YjzRSctDwLLqMCvoMfJ5j/W7DFENbRP8CBOiwdZMvlXRJP05Omjc52nxGJOAfqC8be4TqAXN2cCLH926sD8FY1Y08qeXWIfF23SSdkv2xg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KfRfMCrW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so61289341fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720028452; x=1720633252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNRq2xwEntheuQ6TeaPDnSkqCd5DNGo6bKIeeb/W6x4=;
        b=KfRfMCrW/RT0k7BDjpX1YrU8T0D09rsK7HwOqK2wGXgNygr+Yy1JBoD2NLZpWBdJOi
         e3p5mGB9O9wcBq7KSPodPecmUOYsdaMWBCHVORuxpiC6Gn9FQkqTq3KTEW9SS5pCpX5t
         d9mzgjGYUACSj+AMxwm5vMlhdSQi2nnrXGKVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028452; x=1720633252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNRq2xwEntheuQ6TeaPDnSkqCd5DNGo6bKIeeb/W6x4=;
        b=nAVrC0f5oSJWB5w6/sJnKK/qjjQ8/xRqJkQi51fth/8fRw/7TS4Xqpqa0bkMPDupiX
         hTyufvdsAQS1v4RGUAdQfo/osP2bs+Hxop+BNFKcLVMWHy6F7s9T9YytpYfTzlVZfVKn
         tyJ0FzVNIdB00f9kyS7rHdRRptugRKUgZ2RlJzzfw5YnKehOpwV2hDNQkRZw0710FOJ0
         +w4ABNB7jO7sjceVPm34zLFB1/jkaTRBYf/ey7PW7Vl21dxZ0oGRASBuQKat3yy2xjmB
         G0UJHP0yz7/MPQTDyhx1sxjJa8oe3erHc9NisdQKF7JYp/ErzOSUeoFc1v7uyPbufU1R
         R7Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVdi7qv87l32bSdwRSP16TNzeNEdXk7rCnugje6ZDeNBhHwMEt4PxXkv2VlXuVWy9Q2Yd6d64O/z8QVN4dAbwSj/aBF0DSltHbGXFIa5A==
X-Gm-Message-State: AOJu0Yz+SbSNi7udo4R/q3TDi29vFwQ7fHQ6dYoL8ti6GbmB6bcwZ+Tr
	vyZ6E3ajf/K7zkgGW2J/yhTz5YVMjmI0mozB2GYvU/Abfy8trrcGvrgs+j4FU1RJx+ioYemEbtw
	HxS0l2w==
X-Google-Smtp-Source: AGHT+IHRt6cv38sSQ1vL2XwIVWVyzPapK5aSuuNzbwXQ1XA4HBt972oUaTHqTucyLDRvHfb1UfZ5FQ==
X-Received: by 2002:a05:651c:1694:b0:2ec:53fb:39d1 with SMTP id 38308e7fff4ca-2ee5e345910mr69144511fa.9.1720028452323;
        Wed, 03 Jul 2024 10:40:52 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee8ab3ba07sm619981fa.126.2024.07.03.10.40.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 10:40:51 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee4ae13aabso59801701fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 10:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGVBJBDizOqIToSqi6ylRwNao6/3xTdWApYCQ6rgun0B8FL5EcYUxAtDNeutsOQImkuXUVbhyW8DYssBZEALavn8XzBlKkukue0vBPag==
X-Received: by 2002:a05:6512:ac6:b0:52c:d90d:d482 with SMTP id
 2adb3069b0e04-52e827459a3mr8256135e87.66.1720028450692; Wed, 03 Jul 2024
 10:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com> <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
In-Reply-To: <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 10:40:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
Message-ID: <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christian Brauner <brauner@kernel.org>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 10:30, Xi Ruoyao <xry111@xry111.site> wrote:
>
> struct stat64 {
>
> // ...
>
>     int     st_atime;   /* Time of last access.  */

Oh wow. Shows just *how* long ago that was - and how long ago I looked
at 32-bit code. Because clearly, I was wrong.

I guess it shows how nobody actually cares about 32-bit any more, at
least in the 2037 sense.

The point stands, though - statx isn't a replacement for existing binaries.

             Linus

