Return-Path: <linux-fsdevel+bounces-21670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73B907BF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622DF287E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 19:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB5F149C6A;
	Thu, 13 Jun 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GURyw/7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61604F9F8;
	Thu, 13 Jun 2024 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305391; cv=none; b=r43EstKY0SyQpB1frZt+TiThx/H0UI9eiGsKBlguxXpz2mD8xgwePXQii6t8o/b8oiSpb3qGc0yetrBSPbsLtTFetQGFlnbHZCskQ0cYLz+EVEh8p34+Y3dy+9G+CLXkdr5gd5NbypqFHTFYu94I2ZVEZTwjlW2IS45+M/9mpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305391; c=relaxed/simple;
	bh=2ColOHilvAymurU4w1OWFs4F4z//pAKjnBGR9Fvov6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HnapLeHm7pA2v3Tki48kF98Jf/g2BzK00l1WXFawhqVd82rqLSlhHQ/VP+Dmi1lDM1UpXTbmg0/EC/PzCnBA7OzXQDy6nTvbxBpz12dSfw4X/qQcWePY/lJD4Mf6jxLXaLq79hFpw2KDEzV6vMEhVZx7JT/XCOY+j5rCdBhg4oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GURyw/7o; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6efae34c83so186239466b.0;
        Thu, 13 Jun 2024 12:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718305389; x=1718910189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ColOHilvAymurU4w1OWFs4F4z//pAKjnBGR9Fvov6o=;
        b=GURyw/7o+M0eDYcYf5PJaCOqwqdPCOJbAgJW3SAhVJc0J2nWXCag2uKHRADCOrNoyd
         Twofwri5kKng+2Fi3OIZzwe8fbk4KghX9tLSiVplhKiBjhMNFRGFPH0r0CCohuI4hBQW
         wrwk1JqfOPdwVk+XhEQNUFbIH75N1vyhMRSmts0bEtcYkAva0BSNGBeqcZhss485057G
         hc4lrdpXLs7FIZAS8jjwd/9wqNAIKF7mtWrOjcFfUNX/TYpcbpLeWeTrwfKu9gZMnAmV
         VjTmCvEHPxHXuxrhXTj3NgeqpOefc/XYHPNj3exbD6kPuPiNW21HDyYwk1zYb8/E9s/Y
         x+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305389; x=1718910189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ColOHilvAymurU4w1OWFs4F4z//pAKjnBGR9Fvov6o=;
        b=K4DiSyq9NgRa2c7lw+7b9qz7gco4TYJ0Mg84KWHCNalI4u5I6i3sTcREuLTdDFkBDt
         EonSxDpy01zVe+HGl0c9dFzUH1PYNq/0npgAwrt7M6radTQctxAG0xVc9Y4TpowtKul3
         UMsWGyAfDldSagKL8MPbATkbBXW7Lv8jEeIWu5XkCtHpIhPlbsvZQNGwEXAZ/ezxPleu
         f54RaVEhboftd46Ch1nQjFtaY8mebGkUx9CIwaXs6WqzbEWkHcucFWnHAblQ9KUKP32e
         29tiGRUIABW3i5tpAMye3xcTEbb9xVvwewlTrbNncuCvXpvtqaiCEVyPPKTi23vNzSmb
         Rp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEmcOYb++r1AJ+zPFSn4p6YG0EpBfnQpw4tjHdlkdmo0QdAR9vm1vKQzPs6nBf3qZ4xEcZKdCZH1n5wwVl+GYJ2qkKy0v+xnCv6Xmh0if+r4bKXPezu36lWzfkjdHuThkIdIfx+ujVCfiJjg==
X-Gm-Message-State: AOJu0YxAKGainh+AgK/ZSnEsJ72mmVO7sEFoM2GObSXL5ppzIP6gatJ6
	o393dL8xYH68wzBkYfKjJbX+fdhcdMVW3JOBDZ8u+17/JMDUMWO9y7Ve1kPBk7tBbfrpqk7piFm
	2Ssn8JDKZrYtmQuPjdnZq5UxcXsNsMPlw
X-Google-Smtp-Source: AGHT+IH1cjL5yZRWt2b1Phzo67bgNGK9oJaaZGjd6lIEGOOzuMWjo+6fJjVIQAtLebiJD3oeqKux9SpAsn2W4gRAz3Q=
X-Received: by 2002:a17:906:398d:b0:a6f:feb:7f1c with SMTP id
 a640c23a62f3a-a6f60cf404dmr46211166b.1.1718305388297; Thu, 13 Jun 2024
 12:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p>
 <20240613-pumpen-durst-fdc20c301a08@brauner> <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
 <CAGudoHHWL_CftUXyeZNU96qHsi5DT_OTL5ZLOWoCGiB45HvzVA@mail.gmail.com>
 <CAHk-=wi4xCJKiCRzmDDpva+VhsrBuZfawGFb9vY6QXV2-_bELw@mail.gmail.com>
 <CAGudoHGdWQYH8pRu1B5NLRa_6EKPR6hm5vOf+fyjvUzm1po8VQ@mail.gmail.com> <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
In-Reply-To: <CAHk-=whjwqO+HSv8P4zvOyX=WNKjcXsiquT=DOaj_fQiidb3rQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 13 Jun 2024 21:02:56 +0200
Message-ID: <CAGudoHFYr7X7u5pXdnt5A5ALLrG6v7gobso6NjP3ctOv31X3_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:56=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 13 Jun 2024 at 11:48, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > perhaps lockdep in your config?
>
> Yes, happily it was just lockdep, and the fact that my regular tree
> doesn't have debug info, so I looked at my allmodconfig tree.
>
> I didn't *think* anything in the dentry struct should care about
> debugging, but clearly that sequence number thing did.
>
> But with that fixed, it's still the case that "we used to know about
> this", but what you actually fixed is the case of larger names than 8
> bytes.
>
> You did mention the name clashing in your commit message, but I think
> that should be the important part in the code comments too: make them
> about "these fields are hot and pretty much read-only", "these fields
> don't matter" and "this field is hot and written, and shouldn't be
> near the read-only ones".
>
> The exact byte counts may change, the basic notion doesn't.
>
> (Of course, putting it at the *end* of the structure then possibly
> causes cache conflicts with the next one - we don't force the dentries
> be cacheline aligned even if we've tried to make them generally work
> that way)
>

Look mate, I'm not going to go back and forth about this bit.

Nobody is getting a turing award for moving a field elsewhere, so as
far as I am concerned you are free to write your own version of the
patch, I don't even need to be mentioned. You are also free to grab
the commit message in whatever capacity (I guess you would at least
bench results?).

As long as lockref (the facility) and d_lockref are out of the way I'm
a happy camper.
--=20
Mateusz Guzik <mjguzik gmail.com>

