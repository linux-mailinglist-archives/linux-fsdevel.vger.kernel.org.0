Return-Path: <linux-fsdevel+bounces-23066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E89268C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2977428D726
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75241178367;
	Wed,  3 Jul 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L/kBUet1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161D18754A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033259; cv=none; b=RKIfg1jR4tb3EwBjbTILvsDlk4fU3x45co5Uj3fpYLTL+AZvAcyj3k2zbCMpCTp3cjwrcttMCTWvqtbFXo81pc0hUIQaicUZ3ZJ65lzrtmr83WaAQXj1BG0FvnRpa4+odC7Kyhj0Q+D8VSfKuGc+dw6vxD2fVNJh6obAY7Kfrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033259; c=relaxed/simple;
	bh=UYxPNFpMcGneQ/ECP3GOas6d4yYi/uC/3SPT66tF62M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgUHFtkYMg8bd+txbHKDf2S0yt46CRZqffwgbYrGGkmueVs4RFenHb9KZCzxHL6GgxrNtVANFKOaZZ5SkF+ursF6x0xZxE6gZxBCM4+Vw4mgoOaZQU37me79uclKPgd8hoEE8yWnkK/qYkh5MmgxDuggE0QUlqUuVlpd3K+mKEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L/kBUet1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso1554171e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720033256; x=1720638056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AwbTD1jwFh01l2fYaG95Vp8QD2DPYGRJu95WiulxKsI=;
        b=L/kBUet1xuXI1046My7U1Mbtv6xBMQnJYrK+xREHhjo6jFSkv8bsQ2H9R613ZAO9us
         PJ0/vDgjmxDkbKBhvrh1/GuhP2eMyB4Lv5hPgEK5nrDUJhyFafxGs1nF+ezOgeRj+XJT
         +yTx+3KWmm3CeJsl+NGtlCWOmlTK3/1NDa9O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033256; x=1720638056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwbTD1jwFh01l2fYaG95Vp8QD2DPYGRJu95WiulxKsI=;
        b=B2LunVT3tcAtscR0PQxUKFRuAot/M9eYEzq/DdkBG5R+/R91+Lo6vq5Tqk5XyrOegy
         rQISpSpaxDWdFklJ94S8MNVUL2iQRcitFypQfJ1GXqd2lyAr1TeV2oxuCwoFZvFgu5Mp
         JE0GeW7Isrrlb//89f0AT0W1tQ1MV84y7ATP5yaHdrno1ujtV9znDbqXW/pPTSiCQWZY
         o47tu0nps4TA4FiX29PmUWDSWhFrO00xnshEwrUchey/C6RDoJ0EcBlwKfosqrvcP4KL
         P5eepWfv80xvLToG3NxsqKLiwxVCXiEHswZjju8H6xEsC/+vpyt0l+tVcpP1A7EdiyV9
         FKgg==
X-Forwarded-Encrypted: i=1; AJvYcCU+fSyZFChZ2i7qlVQNn9gvt3y6D8IQRwjGcfHob6yA+/p+ZfpFBcxToy4rXxPbC5hUB7XaUOfcGlApTrzfhkLbyFjfDcA4zYEXCjWDeA==
X-Gm-Message-State: AOJu0YzCcVb8dwq8VzeESSQj1IMgBFhd81fkadVpTaP/nwwFt1CkaONa
	4gQtPi7kTmqgEZu1xmjkoxisK2fwMPHfsBNAJaRPpjMw7680y5MhSwGPKeJAvsG7LBncbZQEBbD
	5HAJ6Jw==
X-Google-Smtp-Source: AGHT+IGR9QiWuMWZ3+vsJiUOFzJD8mXbmefYmrDyr0ko8TMb0554PoqIRlQ5w4micNB7oKFtSUOQCg==
X-Received: by 2002:a05:6512:78f:b0:52e:9904:71e with SMTP id 2adb3069b0e04-52e990408d7mr1474624e87.28.1720033252311;
        Wed, 03 Jul 2024 12:00:52 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b11asm2242860e87.252.2024.07.03.12.00.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:00:50 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee794ebffbso31354761fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 12:00:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8nA03wDzyezu9YfFHVinMQ4zgcOGxg97gyNSDUir5X+45PtvV9yDxPeB/vToLarCiqz4NS0YGvzZwybxaRGrgwFR2hiApePkTaWkqzA==
X-Received: by 2002:a2e:a7c9:0:b0:2ec:56b9:258b with SMTP id
 38308e7fff4ca-2ee5e6f60femr110934241fa.33.1720033250138; Wed, 03 Jul 2024
 12:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com>
 <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
 <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
 <8b6d59ffc9baa57fee0f9fa97e72121fd88cf0e4.camel@xry111.site>
 <CAHk-=wif5KJEdvZZfTVX=WjOOK7OqoPwYng6n-uu=VeYUpZysQ@mail.gmail.com>
 <b60a61b8c9171a6106d50346ecd7fba1cfc4dcb0.camel@xry111.site>
 <CAHk-=wjH3F1jTVfADgo0tAnYStuaUZLvz+1NkmtM-TqiuubWcw@mail.gmail.com>
 <CAHk-=wii3qyMW+Ni=S6=cV=ddoWTX+qEkO6Ooxe0Ef2_rvo+kg@mail.gmail.com> <20240703-begossen-extrem-6ed55a165113@brauner>
In-Reply-To: <20240703-begossen-extrem-6ed55a165113@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 12:00:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCttiyp+3BBzhqKv+uXuUr-fzw2QbmH8kXwO+sB+FAaQ@mail.gmail.com>
Message-ID: <CAHk-=wgCttiyp+3BBzhqKv+uXuUr-fzw2QbmH8kXwO+sB+FAaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Christian Brauner <brauner@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>, libc-alpha@sourceware.org, 
	"Andreas K. Huettel" <dilfridge@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 11:14, Christian Brauner <brauner@kernel.org> wrote:
>
> In any case, which one of these does a new architecture have to add for
> reasonable backward compatibility:
>
> fstat()
> fstat64()
> fstatat64()
>
> lstat()
> lstat64()
>
> stat()
> stat64()
> statx()
>
> newstat()
> newlstat()
> newfstat()
> newfstatat()

Well, I do think that a *new* architecture should indeed add all of
those, but make the 'struct stat' for all of them be the same.

So then if people do the system call rewriting thing - or just do the
manual system call thing with

    syscall(__NR_xyz, ...)

it is all available, but it ends up being all the same code.

Wouldn't that be lovely?

Of course, I also happen to think that "new architecture" and "32-bit"
is just crazy to begin with, so honestly, I don't even care. 32-bit
architectures aren't really relevant for any new development, and I
think we should just codify that.

And on 64-bit architectures, the standard 'stat' works fine.

            Linus

