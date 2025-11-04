Return-Path: <linux-fsdevel+bounces-66901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47041C3025A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 10:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 037BF4FE3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24232BCF41;
	Tue,  4 Nov 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7ZooYB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A73A41
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246634; cv=none; b=QVzkrnEGTUjKAHkVymrKyXaMN57fFaJeJD41u2I1bI1t0Nb/vIfAT1oQ0Q30ANr/QkqHhVtcNLadTcxwtRU1XfKgRXZlxQeg/UZbT14FZD18Siu7j89F4Gi/RWPPmWOgPEEEuIYkeYqQkGy7ASf2CIff8oigelsjv9RUXEzS7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246634; c=relaxed/simple;
	bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV6IbQ5hUMlTxsP/YNgvXvJ0iR/VrGm62GyF1PiIeEN2nYC6IpbuEurYFJ10mu6hFmkOkJYXH204vPmem62zFN/tEVmnC42YXb1A9NkNOFWuRZ17ZN2yVTjXrD34tFtMeG5t98HcxbVcBbrLBMCNey2QI1w2OIBPyaWQr0n8S20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7ZooYB+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b70fb7b531cso297313866b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 00:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246631; x=1762851431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
        b=U7ZooYB+TLZ2U2mSLv+d9MUNvpKaAm3HLw2QEQWr5s4UUjiuB276934Boz0c9arn+q
         JJ/r9reKNka8uv4GCaWmCjAghPCbgR0XMnd5ruvrgWMI6ZuVkxCmpTFh9fUbsdA37XQN
         +4cG20g2Vjtn8qIfhN0202ATuSZZAp2dlhiltvzIIRpTk+IgpDLg4V8sHapnW17v5SqX
         TR/zHsgPRLhhmvIThyADAailp5KTtA+CQTs4VGlrV5F8XFz8BZfCorWGJUgBDUyIUXND
         s/Oqvfi1tYvBRJ3bql9W71SnseiKzK5xLdUGuajpYOczIdaJwM2rz1EJWVDzJ25x/daB
         HTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246631; x=1762851431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+jj3ziLRLynG+wa+K+2Apvi2QZl6via6pOPc6M9QTQ=;
        b=SbSTof66Xqhg8erzLM4LqYUkix+WfI0ET3CVvrqK3W4mrqfb/qhDy2n01SU3IaFo4g
         ViAHN6ljZLfz93rYcjhjdarXEpXpcIELuHuxwUZt396Xm04Rd0OLzCVZ9gsZbndZLQ+9
         Nz/LAMxogXQkptZzeX78mUsKLWlKp+noiLPU7fTlrwrJHmL2mXpSRoNSZ1QDM7iAGfS3
         Hw9bV4Pt0vxFQKe30n7hlGihpD1biaegfM+YGWT6bHH0s/GvPgn9MUWtIVcxUc1e0IAh
         b2F1CgAhfINh/hS65SOR7bqA/AeY+MMOKZzpP22bQ7W907zkX1Z2YSA2bOfOlDSQKeZV
         /bxA==
X-Forwarded-Encrypted: i=1; AJvYcCWilFrRYLsZbzWgataI/0SiuAoWmTrnMNiVzs3DExEOsgpJwUcTqZPOIGmhSjre1gWdtVNhVUjc72K+/jp+@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLEfnALnzrtSf4r/Ilp/uVEzcaK0ROzFNQsLVi1OFRlEm/iv5
	YHtbppZUu6NfggBInI+HT1PLyKQupTbLiyNlFbTkDVtv2v6oS5U64MeSx/TYTewasWx9Z/m822L
	BQiPLS9XtIVNeHyHSXK4Ml5a7MXkMLuQ=
X-Gm-Gg: ASbGnctwAUjslMUegGgZDW7TlwCvwWTbQLPGo2enZvt6KHNNHutFx9VEmFz64ea2jGD
	2e0YhW2DCCXFEvhwJxaRRD4Nl+FcDO0ynh0M4m4HOQ7fU2YGK1WHyBZVMzoFULX1TLgendxvBT6
	VaneJPQ2gKFWPnFBeivhI7Cik8sOquuivxG9B+t2vHC1O2ir/TOhfhDxhlThpf5er60ylew1MUv
	JEsik6mm27tgEtxDukFL6kxz3QPKDone8Z48fsYx4sjTYEvgmmVLYB58aMPF+4IVhorovWOQywK
	sWUoZq9Cm5MiN1w=
X-Google-Smtp-Source: AGHT+IF6ueQYBNM1+RNhYOYIFnfLiX6oNuy4l48G1lx1VU0ywiXQgL6tqvYLuu3FO24uXys20ArxBAmkiPLr3hbeIKw=
X-Received: by 2002:a17:907:d26:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b707082bc03mr1630568866b.52.1762246630824; Tue, 04 Nov 2025
 00:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
In-Reply-To: <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 4 Nov 2025 09:56:56 +0100
X-Gm-Features: AWmQ_blcze5b2JDvf6rk7zu8ZSgiylBvNU6Ne1vkeCMvYkjZxqkdx2SqKkvxo3M
Message-ID: <CAGudoHESYkHNdZZ5j1KfZ3j23cEvPZUNWVuc7_TTKds=qNWt6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:25=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Mateusz - I'd like to just credit you with this, since your comment
> about modules was why I started looking into this all in the first
> place (and you then wrote a similar patch). But I'm not going to do
> that without your ack.
>

I don't think crediting me here is warranted.

I would appreciate some feedback on the header split idea though. :)

