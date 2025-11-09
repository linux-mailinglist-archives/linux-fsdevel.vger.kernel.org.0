Return-Path: <linux-fsdevel+bounces-67624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A55C44951
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 23:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40773346239
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 22:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E0026C399;
	Sun,  9 Nov 2025 22:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm/ZXnqL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73B255E43
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762728009; cv=none; b=uvZogzH48ARRRTvbLHki9ngQ/+Nk/XfaDxQqMDOa5YptLYLifkCMaomQA33c+roV0abwuHwiTyfgIJg8PuiQCovhbadBF1s8QudajS4K+7F6x7AjBaP91QPhA4P/O5S0urGEUU3QpmFHic/iCwIUo3DPZ+BfE7jOYGwm3Lp/vG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762728009; c=relaxed/simple;
	bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhwD0DtDWWRkq9++coicXHj7qbWJ7mY10kURkfCdhiv4DN6xk1PrKUzPJt75l4oS3gj2xnc2yCxNagPWk+ZYBJ12jOY0nEDci8hnqSa3RxmW4rp/hcrXhpJRbQKL7yjGlcm13AJHPl5lpl8GB0039znHhYe+1s0gDEy9pb7uZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm/ZXnqL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b72e43405e2so190468166b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 14:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762728005; x=1763332805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
        b=hm/ZXnqLeWIkLRXqpmqqqjAVkNtWvpAoYc4xya6uI0mJrk2a7gM9QAerILpH6Mu6Li
         dOxlReETQNYnRRfRwXVpcVvRq1hi8WfKyi4ny4mrkxpqwLcX3qEZQbdkTj6RSASb5lao
         fCc/aDC8H0owkjusWW4nDlpBl2nyvw2IQBvC1+5mZ4b+0ifon9Nx6CPpxJ3JtHK79Tsq
         jHjWzP2ppXQC6g1b2kUDW55NuOu5fHsTcnrsnJ7yjC4rsioE8r7Wye+GXj7ChtrpFbO9
         7inDbkRVthpXWyZqk3ySGO9dDL3F0/j/MTmpFLsQwoWWv29LCg9znLefrV88a2kaTcCr
         jEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762728005; x=1763332805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zz/RLnXj/ZlmR8T7NF7hLX/IgWqO3vnZx7+cRUL2HaQ=;
        b=VbdxbtvJnIk69k6go6PPhgFIkLSLwByfZVBZIyueOvoD5lcSBUlpDR8KQxghRlafOr
         WVykmQnm/ktDN2nhl74hFE2KkOoxY0iXUIsVZ+fAitobdgFxagiTHi1E+RfwqEhjXP3H
         XIYh2U4T+ZIFOjU1zKQ75DUo0QLB4oV5huG/zUN/GSmz/L8t7c6o+Cdr8bft4gONLIYS
         XI4yYxA1sK9eV0CKMuYyyQfZHWg8fchhuz3PexmfcK6C/hMbbifcDP3vSr71wZ/so0DS
         DLmfkJK+I0wJrO0Yjer/WWktOa8vCTT4Fls3HIUb8n/cA6LQMHH3WTXAUn8SnuBaS5Zw
         Uvsw==
X-Forwarded-Encrypted: i=1; AJvYcCWw1K9na9YDejqXa86bTERG4aU00yNiTqQRqp8RG7PLkgUnG7tlUTHR5TOdwGZm6h+8UURIWsEpn6XkJ/0q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2udWrhrc8z6qaqkgn81zPrzT1q0/BhS4C5KEr8fPXCfZamC/7
	4R72EJ7cAwDDEs60ybz46LHzZSa5VvFV7JDBi4f54o88O4QDXAB7QyJi47YChJuPNz9JzUYD/fj
	aMjVbkOxOoB3Wc8pdF9LhTK0MrhWmli8=
X-Gm-Gg: ASbGncsOhDZoCUsPBm2tFOn1BOOqL6c9ngKBqSvXYdWqKt2laWogBtkS1fWyDeJmwJs
	E6aYR929Ox4BuGdHsKpfMdiYtO+WzYxD57T73higEFWolepgegk2e8Q4VrDYiRI+OhtFDgutUA8
	rYlydpB/EpJePIwLN1b2morxO1i3SwGaP82217A0Z1xkbrrpa46T4zRhcvuiUYoD/HajR3G9iOn
	RMr1sFjltVlMwFBeGVv2nnOuu04M2a3k1Dm8xqhe1ViHlneaxhKhZw1u29m48M7L0n/A+TlhvyA
	kWkn5kf5NNU2t9Y=
X-Google-Smtp-Source: AGHT+IEf2G3FM0i2bVmOUG7+vPY37y6f5todMu8F9N/qNHio4HbRPNWL68hqLfVk+zbwZK2GIQZm3Q4XqlDpU7RXT50=
X-Received: by 2002:a17:907:60d6:b0:b6d:545e:44f6 with SMTP id
 a640c23a62f3a-b72d0954176mr884727066b.12.1762728005401; Sun, 09 Nov 2025
 14:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109063745.2089578-1-viro@zeniv.linux.org.uk>
 <20251109063745.2089578-11-viro@zeniv.linux.org.uk> <CAHk-=wgXvEK66gjkKfUxZ+G8n50Ms65MM6Sa9Vj9cTFg7_WAkA@mail.gmail.com>
 <CAGudoHHoSVRct8_BGwax37sadci-vwx_C=nuyCGoPn4SCAEagA@mail.gmail.com>
 <CAHk-=wiaGQUU5wPmmbsccUJ4zRdtfi_7YXdnZ-ig3WyPRE_wnw@mail.gmail.com>
 <CAGudoHGCkDXsFnc30k10w-thxNZ5c0B9j26kOWsCXkOV8ueeEA@mail.gmail.com>
 <CAHk-=whxKKnh=rtO9sq0uUL76YGLB3YTb98DVBub_84_nO6txA@mail.gmail.com> <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
In-Reply-To: <CAGudoHHA_dDXMZFh1=U=AjPsqK9PRUGq3fQ_GjOdebUBK-sn3g@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 23:39:53 +0100
X-Gm-Features: AWmQ_bm4fdxC6v1rOIJ15dLgNbIpqHp2QfAR172JK6y5Y6KlspYKYyOefkgBoCA
Message-ID: <CAGudoHHMgY0NnN0FX_OQnV578Wu1e03VjO8+3tUA8XDxwy_Smg@mail.gmail.com>
Subject: Re: [RFC][PATCH 10/13] get rid of audit_reusename()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, jack@suse.cz, paul@paul-moore.com, axboe@kernel.dk, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 11:33=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Sun, Nov 9, 2025 at 11:29=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Sun, 9 Nov 2025 at 14:18, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > You would need 256 bytes to cover almost all of this.
> >
> > Why would you care to cover all of that?
> >
> > Your very numbers show that 128 bytes covers 97+% of all cases (and
> > 160 bytes is at 99.8%)
> >
> > The other cases need to be *correct*, of course, but not necessarily
> > optimized for.
> >
> > If we can do 97% of all filenames with a simple on-stack allocation,
> > that would be a huge win.
> >
> > (In fact, 64 bytes covers 90% of the cases according to your numbers).
> >
>
> The programs which pass in these "too long" names just keep doing it,
> meaning with a stack-based scheme which forces an extra SMAP trip
> means they are permanently shafted. It's not that only a small % of
> their lookups is penalized.
>
> However, now that I wrote, I figured one could create a trivial
> heuristic: if a given process had too many long names in a row, switch
> to go directly to kmem going forward? Reset the flag on exec.

Geez, that was rather poorly stated. Let me try again:

1. The programs which pass long names just keep doing for majority of
their lookups, meaning the extra overhead from failing to fit on the
stack will be there for most of their syscalls.

2. I noted a heuristic could be added to detect these wankers and go
straight to kmem in their case. One trivial idea is to bump a counter
task_struct for every long name and dec for every short name, keep it
bounded. If it goes past a threshold for long names, skip stack
allocs. Then indeed a smaller on-stack buffer would be a great win
overall.

