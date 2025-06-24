Return-Path: <linux-fsdevel+bounces-52690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC9AE5EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C42B16DDBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752C258CED;
	Tue, 24 Jun 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGoPYd7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFAA258CD3;
	Tue, 24 Jun 2025 08:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752474; cv=none; b=Bui/XxNbbIs5p54eA6+pJyuBx/2ACgI6ZPweVTHNgSat4wMmT/ThnFMW8w+epjGE0rNNNg742ie7mc3Wdx2CAYfmYKlcfbv0Aqd6vdo9pSTOSINwSogCoFmWEK8i58EGOVF6LzD03sHTB5xvHifYXGJyyKAjHmQos/wFXDSLQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752474; c=relaxed/simple;
	bh=0QRWHiDqC8FV9e1rfprHiI4IeP9cKbV5jQQ+ztFKzJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIFx8m8cL/dadWPlNf1zxG5ffhG3vxj4T3dfkN2dlNuMIxd1DDgtSeHfEjn9vCwGrgXEc8jq2fM20cFb2Q7tUBUJQYp01AiB2e0W1GXnCwzI2NtKLGj4izRvr7JS7+xKgtQrL5NK7Tz7KSzKeX8BRm4EGx9+b8Ew6QZQ8G45eEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGoPYd7S; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f379662cso4098208f8f.0;
        Tue, 24 Jun 2025 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750752471; x=1751357271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEKaHr7bzVOBX6mtsl4IPvcEgrMN7hu031sel/DT8/Y=;
        b=AGoPYd7S6AZZlsb0FZ2wkrKL+9KbJhM/1rpYJR5aIiJG7tUsYWvjgQIy6IAax/CrX6
         uPyhof3OULjmssvgmo7s9whgGgsIPV/QmvB2OVV5rqm/K3lepdJUj6lKJqY+FeAmAYNp
         mKTs7E5iClzDiS2a7+2XSjLbcG/gG4Asdu4Pk1XH1X9hIEI8+pNVIh05itTz72K5JBoC
         PLo2c7cdiMBR9ijoCqhkRpqbG5K/1GwzT7us9xeYtnW06uJie7TsPmZvomgt0cGS+YmJ
         lEbkJdWDvNaFZ3PRoqcuv0eGd4EVfyxzq+CRTlpetUVtPjyQRQ8VlSWyfDpSfKjt2wAc
         22+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750752471; x=1751357271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEKaHr7bzVOBX6mtsl4IPvcEgrMN7hu031sel/DT8/Y=;
        b=gQXNRT56ZCy2Eeilg0PLXKpqS/9yob/CP/U4O9RtoMB8qjmokGgNtd5hb7PUF8X8/i
         rrstrCCB69UmFaD3StOg8WXtzcmgCnbBiTMwdm5QKwYZ/mqWNWVJSVaL5py3gOxuoN04
         z/fpoG21zvWXEm/CKAGHzoREjntUiVGi0aZDkulD8AzsqQNjVjdDKjAVQDXBl6mhF+gv
         Szm8QW4ZQB1xryY+H2COBRP69AGoKFMYf98xmaWEg65UbsC8EEa0PPPvupQzoDJryC9Y
         L9Z8GqG2iwn64LpdJp4WZF7hhv3Olu032jxKhsu8zSxTXw5NngGuKp+QOYQfSkIP3ts8
         /KJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJDYbwnPG1vjWWheocOn0GYwR6pcIJ5hDf1kWq6cdKN/SS/EJqWGdYpR7tWIDKWYE9HAN8XGLjLEq92To4@vger.kernel.org, AJvYcCVi2t5/ToeXjexedpACaTbTYyIP27mP4jEyg09e/v/qAC5JKoEBTyYWtwRcSVXppObKO06VeNEjE+KbGjL2@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkxRC+Lo42dbrvs/8liazFLELF4KOZ0HfQsvnyu2uN37RFeY8
	ULAkBCIeGs6FhkJHnGZ+qBh9ZMv33jiD2Xj/SkMCTRKIU5eeCRpcIqMK
X-Gm-Gg: ASbGnctYqdns3WhOaaxeQgDblMlkoWTxHYXwj7fP5O2DSwMfHHVVaVUYoNLbXi+n6En
	n2uziu2ZyVKR+os0SPemhGn6qMLSOoEJ2kBSGnw5WZmeLLEKAFRRceKs7EWvstiddbCBNZ8gtp5
	TGGofAzMI3qMIrD2PV9/LDq9eZKQD/AP+4ww7XoJpCoC7ni7dkl3XALvVkuf/JgZbPQnrvFdeZ2
	4f1R+wGebIt5H3vI6c7aaPx7Ba7tGxJYZkwFU25X/vYPrjCmL7nQcDcN6wg2ROw3xR5CE/35uPQ
	NFBFKTMfDOj4pruLXH+IYizBHn01Hn4m6ZiiUptTZhuqQTw4t289YjpdsCia7d6QhzUM2ExpNna
	agH66a/plr5X34EQl3dViM6aJ
X-Google-Smtp-Source: AGHT+IGj40J3gYQNZuNyHWQXqC5QGveSgT4VbYt/zXOwee83nuPUMNJqpNFfTApYGAVg7P7wmmNZYg==
X-Received: by 2002:a05:6000:4028:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3a6d12eb400mr12534935f8f.48.1750752470752;
        Tue, 24 Jun 2025 01:07:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45366b4d0adsm122345145e9.14.2025.06.24.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:07:50 -0700 (PDT)
Date: Tue, 24 Jun 2025 09:07:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida
 <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/5] uaccess: Add speculation barrier to
 copy_from_user_iter()
Message-ID: <20250624090748.056382c4@pumpkin>
In-Reply-To: <2f569008-dd66-4bb6-bf5e-f2317bb95e10@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
	<f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
	<CAHk-=wj4P6p1kBVW7aJbWAOGJZkB7fXFmwaXLieBRhjmvnWgvQ@mail.gmail.com>
	<2f569008-dd66-4bb6-bf5e-f2317bb95e10@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Jun 2025 07:49:03 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 22/06/2025 =C3=A0 18:57, Linus Torvalds a =C3=A9crit=C2=A0:
> > On Sun, 22 Jun 2025 at 02:52, Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote: =20
> >>
> >> The results of "access_ok()" can be mis-speculated. =20
> >=20
> > Hmm. This code is critical. I think it should be converted to use that
> > masked address thing if we have to add it here. =20
>=20
> Ok, I'll add it.
>=20
> >=20
> > And at some point this access_ok() didn't even exist, because we check
> > the addresses at iter creation time. So this one might be a "belt and
> > suspenders" check, rather than something critical.
> >=20
> > (Although I also suspect that when we added ITER_UBUF we might have
> > created cases where those user addresses aren't checked at iter
> > creation time any more).
> >  =20
>=20
> Let's take the follow path as an exemple:
>=20
> snd_pcm_ioctl(SNDRV_PCM_IOCTL_WRITEI_FRAMES)
>    snd_pcm_common_ioctl()
>      snd_pcm_xferi_frames_ioctl()
>        snd_pcm_lib_write()
>          __snd_pcm_lib_xfer()
>            default_write_copy()
>              copy_from_iter()
>                _copy_from_iter()
>                  __copy_from_iter()
>                    iterate_and_advance()
>                      iterate_and_advance2()
>                        iterate_iovec()
>                          copy_from_user_iter()
>=20
> As far as I can see, none of those functions check the accessibility of=20
> the iovec. Am I missing something ?

The import_ubuf() in do_transfer() ought to contain one.
But really you want the one in copy_from_user_iter() rather than the outer =
one.

Mind you that code is horrid.
The code only ever copies a single buffer, so could be much shorter.
And is that deep call chain really needed for the very common case of one b=
uffer.

	David


>=20
> Christophe


