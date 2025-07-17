Return-Path: <linux-fsdevel+bounces-55207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB236B084BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC65E7AA7AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 06:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6652147E6;
	Thu, 17 Jul 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="des0xKRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE51DF248;
	Thu, 17 Jul 2025 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733022; cv=none; b=PR7k/UEdOal2+4aCQl4c8V7LqSEr3fMJ92HmxCmT1UmZpF+SCz3grYM8A+2w1FTXoZCmKyzjThvbji/KLtW9NHuAhb2co+PvBeaFvPFkAnepKjE1mymKrCM3n54umNCbMEExD4dBxNOTquw0if9z57yY8/P1SFfzIHh33L1cn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733022; c=relaxed/simple;
	bh=pOUduvvv8IqVho/r4vq34xao3uzR3ylA0X5OUm9CvcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TamBpmsHWYzuALAzk6EJpwSCHzFtV8l7JdO0m3VemMfWvDldv/OWS5+ejxK2RCC5jSqJykZI3tPszL7cqWmoCygWZVbRb9FBLQqP14oLjgvjot2cHpuIyu7l60Tl7V1eoedhrhdOAkVq1aOikddmgvwTJ3fi/p0kqk0de4MoAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=des0xKRl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so1067394a12.2;
        Wed, 16 Jul 2025 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752733019; x=1753337819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOUduvvv8IqVho/r4vq34xao3uzR3ylA0X5OUm9CvcY=;
        b=des0xKRlDNYG/VLwxBG64UtqCTVIa2IpRZQLQOvoj56tqhvygihRt3SGt5BmzRh1HC
         GENNt5U2maA2NgPMRfX3OxkVWKs5fJP2a9ORazye4M+R6KAx0z7EAajvCLzI98LKC4Ls
         pPApxZ0aX2dVu+Q9zuEZlvz0PO+FenG5tuAcuqbYCOb8dA1SZS+DQknxS5tPgSJlUOlL
         0I7ex14YbjVosHET8Gwr7ixEhJJwwdhFEmpGinVpgouhcTBcmg0DAiVLP/gF+vG5EPdI
         wMN6IpMLVPH/hAyfLG0WOFugBWQQujwfwCj6H8IH1GB4MEP6fsgOzVt1GT/7E6zutvEE
         1BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752733019; x=1753337819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOUduvvv8IqVho/r4vq34xao3uzR3ylA0X5OUm9CvcY=;
        b=H4iOcNZb6e8LoaqjQDlhp1VpGGrutMY9Msol5U/h92megfQRk6Lhdbf3Wx36GFCHjf
         K7Va8HpEFoTOsRjxaINW16u/uuNJ7uguSH3la9E14wVVgkv+iH+zA0xxI70NDkLcuy16
         80ln9JNTp8loOjDkga+jm9owEsbZ3vBhBlQWaEifFLyxdy/bhHP7H/H8JaeWOcGCqzDv
         kVxE0LQ+wcfNot68FSl1SKkm0djth1hBniKUYKRYW0R7XCvVy9dUPfzOYX2w0jBwjT2B
         OJAKKv14eqBV1IROQhu9duZl7y4F0mvxnrq+lT5hD/Iy9bGMOMNj5cs9YJsMmsHLWUMO
         YoJA==
X-Forwarded-Encrypted: i=1; AJvYcCUAdxoRgLV1wF6j3O+GdvuaTUVAJXhWp3rhh2YBzFX/xUZpuYYO9/Z/OkpR1Cgt3ejSQdyMb6r7GCZ5jBUG@vger.kernel.org, AJvYcCUfgIKLhugfZQshwpoPda/2g/hjNYIPHts9V6g+qev3YcZNnDXC3jGG/5RCt9O++nZjYVXOjmuXgt6VUNz9@vger.kernel.org
X-Gm-Message-State: AOJu0YzIB6pPqr85+bpA9sZNWMFmNiGufO+vll0sLhtSJxhW+ST4a0WF
	D+TAHR6AiJmPcslp7HJjE4YAHSbrisPO6NkbCVBwMn98O4BFKOwoLxxGvGxABkPUsPojxHkDC0r
	kAubZ+y4uDa8vcEnSQvy24tCNNRWX/oEyguGu
X-Gm-Gg: ASbGncunkZCydc7t09/0HlvMecMdV+A9jaiIVNC1Z13mbD+ufg3vjByZaR4BZfinZO6
	An9eZj7YtFn0Z3Lbl1SS/pf7+y/ln7TsXFcIny6lTwEH/wAZFMA8jcUDBs2jNuQ/ckjEsNcyx37
	Qcj08HQiOvs2CYD/E6wbw4pjAj8LK1gEzx2duJSQpcpCbheYWAnqt0OSPScbvnyvCujjwDr4g9h
	xok7fo=
X-Google-Smtp-Source: AGHT+IH1G/4ZnN9Rfkvx7O/rf7b4oXwcqQjohYok8MND7MGU1X3oNE2QrQKlG2fDKI0CPtNwMSNzdsMVa/2LXeHfj80=
X-Received: by 2002:a17:907:9605:b0:ad8:9257:5727 with SMTP id
 a640c23a62f3a-ae9c9b9304bmr524125866b.51.1752733019209; Wed, 16 Jul 2025
 23:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716121036.250841-1-hanqi@vivo.com> <CAOQ4uxi5gwzkEYqpd+Bb825jwWME_AE0BNykZcownSz6OZjFWQ@mail.gmail.com>
 <bd44135e-a86f-4556-8219-baa2f73c98c9@vivo.com>
In-Reply-To: <bd44135e-a86f-4556-8219-baa2f73c98c9@vivo.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 17 Jul 2025 08:16:47 +0200
X-Gm-Features: Ac12FXxuosx78WLl26EIxspaXi9D8dyLdnTAZdm0X7MUTpFMnb5owW9U35ky-ts
Message-ID: <CAOQ4uxgCi3nB4d7dLfhFRYdvH3+MHt+xDQQRKvaBN2U5oOuX6w@mail.gmail.com>
Subject: Re: [RFC PATCH] fuse: modification of FUSE passthrough call sequence
To: hanqi <hanqi@vivo.com>
Cc: Ed.Tsai@mediatek.com, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulei.rjpt@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:23=E2=80=AFAM hanqi <hanqi@vivo.com> wrote:
>
>
>
> =E5=9C=A8 2025/7/16 20:14, Amir Goldstein =E5=86=99=E9=81=93:
> > On Wed, Jul 16, 2025 at 1:49=E2=80=AFPM Qi Han <hanqi@vivo.com> wrote:
> >> Hi, Amir
> > Hi Qi,
> >
> >> In the commit [1], performing read/write operations with DIRECT_IO on
> >> a FUSE file path does not trigger FUSE passthrough. I am unclear about
> >> the reason behind this behavior. Is it possible to modify the call
> >> sequence to support passthrough for files opened with DIRECT_IO?
> > Are you talking about files opened by user with O_DIRECT or
> > files open by server with FOPEN_DIRECT_IO?
> >
> > Those are two different things.
> > IIRC, O_DIRECT to a backing passthrough file should be possible.
>
> Hi, Amir
> Thank you for your response. I am performing read/write operations on
> a file under a FUSE path opened with O_DIRECT, using code similar to [1].
> However, it seems that the FUSE daemon adds FOPEN_DIRECT_IO, as Ed
> mentioned. I need to further investigate the FUSE daemon code to confirm
> the reason behind this behavior.
>
> [1]
> fd_in =3D open(src_path, O_RDONLY | O_DIRECT);
> fd_out =3D open(dst_path, O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0644);
>

Seems like the server should be fixed.

Thanks,
Amir.

