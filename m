Return-Path: <linux-fsdevel+bounces-9953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE04484666F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FFA1F24153
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 03:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D039D514;
	Fri,  2 Feb 2024 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UTwYXlLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAAC2C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843770; cv=none; b=Te32hwMmvgh2TrIm4Xpktp6p9CFEYLoGrNraxz2F4nBSTgsu6N8jZLd/fX37IOdBtcAoNMIJrYjNnii1J0fUJmsiePT3US+ptdkEZqDDcVTql+F+bbJ2tjQWUXaGSeCpWNyJ7G6bAMPXfQGp+lrfkC8ONxc/I182UpoWY2mtak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843770; c=relaxed/simple;
	bh=lmKganrCDfRPsqDCh+yUbHYT43Bc6KQUR1LqIUskJ7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6K7wUsUmEMp3sYmQ62UK3mwKG0UV9WRyAT5ZTc2f0zXRIxeKDzexqtHF/RA0NwoYj8HU0JY+1s37cdSeoNzLVR9nBH9U5Gp15Z/63r1mR3WzSwtqnkj5CAaEgEJM4guwHgscGQuXAJDgM2rEsv2rEynEQK8+OJ1hLFncvavQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UTwYXlLm; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a364b5c5c19so272087666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 19:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706843766; x=1707448566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr60hQses4C7qPIpWX7Pk8oBCIoPSvq+zV4pLC1HFKM=;
        b=UTwYXlLmYm67Zh7ClAG5u1ngQ0dxWhlbrlIe3E5Y9JxDBfPLlvlXWzuKwTlwcyaDyK
         he5B3YRGJ0DKDuhCiJwbQqy5fXg7CA1PhastP1HJOEjfrUoGH0miSry+yeL+FPrSfJev
         ufoM8tEGRTPXL9S5ZbrHVNkQsgdPmZ4DCpE+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843766; x=1707448566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nr60hQses4C7qPIpWX7Pk8oBCIoPSvq+zV4pLC1HFKM=;
        b=pjW4nvDESPBvr8pjmEISwKY4mhSMuWy4YKzc/fItKyjYs7bR1qeXtR4QmOssl7sb0x
         UGGUDXvqkjb97rvOY0H1hWtg53owJArJMuaVRXeTIp/6MhwHhyIAoDDi0s9xw8oPrstY
         tpOXRVdKpIbMHp6N8DLD6puygqcf9aPf9vDAUjO9DE4BDD2z45EnM+zyiProDlw2RPRq
         jN/zbjiNoYT8P+62P43OckVLDIa5HiDLIPdmtbWRxAfquca1DkXGNjtXeKHz2gtG18cs
         IFi3crIbyrI5rZcKd9NgRQ3mEN+/ro2Eq/gvz7bwepGDzqT/qTLZ3znz301FFBIewOiI
         LHTw==
X-Gm-Message-State: AOJu0YyQnU+JYabDCKV4yR+HDAs6A4SVj7PTUtQQV0JvZn7ClVBzYtb6
	fZB85CvZrsLpGVjd5vmGDXuIUE/62/AyIwslH7s6WksdXoT5B4u0f4f37Olgip+5fWGBZf+3xsz
	2LDEm
X-Google-Smtp-Source: AGHT+IHYSjg6mwq9b0HMdeC1es1euXRWOuurEuX/2F28Yxh4ya2R64ja5TkyGZ3qYEHAIoJyqI0/yg==
X-Received: by 2002:a17:906:680a:b0:a31:6587:8abe with SMTP id k10-20020a170906680a00b00a3165878abemr4672259ejr.48.1706843765978;
        Thu, 01 Feb 2024 19:16:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXBiC+ZfAFqV8WeAQsONwlunaXY4vOth1UqLG8V/nDtgOIZGuhtq1pizC+YJ5J0ixnS8utUjElHFwk8G3Gf3omZAYhqcV53xtwgdibuQw==
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id l13-20020a1709066b8d00b00a367bdce1f3sm402730ejr.25.2024.02.01.19.16.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 19:16:05 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so2985a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 19:16:04 -0800 (PST)
X-Received: by 2002:a50:c346:0:b0:55f:be05:8f21 with SMTP id
 q6-20020a50c346000000b0055fbe058f21mr46623edb.1.1706843764683; Thu, 01 Feb
 2024 19:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
In-Reply-To: <20240202030438.GV2087318@ZenIV>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 1 Feb 2024 19:15:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
Message-ID: <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 1, 2024 at 7:04=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Feb 01, 2024 at 06:54:51PM -0800, Doug Anderson wrote:
> > >         What the hell?  Which regset could have lead to that?
> > > It would need to have the total size of register in excess of
> > > 256K.  Seriously, which regset is that about?  Note that we
> > > have just made sure that size is not greater than that product.
> > > size is unsigned int, so it's not as if a negative value passed
> > > to function could get through that test only to be interpreted
> > > as large positive later...
> > >
> > >         Details, please.
> >
> > I can continue to dig more, but it is easy for me to reproduce this.
> > On the stack is elf_core_dump() and it seems like we're getting a core
> > dump of the chrome process. So I just arbitrarily look for the chrome
> > GPU process:
> >
> > $ ps aux | grep gpu-process
> > chronos   2075  3.0  1.1 34075552 95372 ?      S<l  18:44   0:01
> > /opt/google/chrome/chrome --type=3Dgpu-process ...
> >
> > Then I send it a quit:
> >
> > $ kill -quit 2075
> >
> > I added some printouts for this allocation and there are a ton. Here's
> > all of them, some of which are over 256K:
>
> Well, the next step would be to see which regset it is - if you
> see that kind of allocation, print regset->n, regset->size and
> regset->core_note_type.

Of course! Here are the big ones:

[   45.875574] DOUG: Allocating 279584 bytes, n=3D17474, size=3D16,
core_note_type=3D1029
[   45.884809] DOUG: Allocating 8768 bytes, n=3D548, size=3D16, core_note_t=
ype=3D1035
[   45.893958] DOUG: Allocating 65552 bytes, n=3D4097, size=3D16,
core_note_type=3D1036

-Doug

