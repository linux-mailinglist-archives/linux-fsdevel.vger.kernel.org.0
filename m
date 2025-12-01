Return-Path: <linux-fsdevel+bounces-70322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B644C9699B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD4674E10E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A73E30217F;
	Mon,  1 Dec 2025 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW3kaNtL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC183019A5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584108; cv=none; b=LoZXIwtpMfIXBWJKBerlNAm/lkRQ7ocRnl38XjHPHurw8RtMxtknh7oMKHFXlLlMb8WvAbUr+ltGYhNXjr/NWMZv+T4YQorMXCq88wiKuKDIHoT0UiiMtWl0Tul0vXAprh9U5IExq0LDj9krwN6/BVwekYmQgfaOZfNn2Xk66Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584108; c=relaxed/simple;
	bh=ikaaUF2/JN45fY9WMI8iz4no0LJR1nDXhV8kfKqS0h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFqtruVfOuq3FCN4EUBBWRjQiz18E6OVZyKT1qakk4l5KEDEj363uJcCJ20auIHpiOrhMcHLZgNMIuAXyRNzwnXLOt7ewXYVysdDavOqJ4NVLU8LnBRivA0IZVynHuKYd2Sx0/IwtAcLJG9mTGAQA1bT3c6rOLKSsjq19cWs5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW3kaNtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CEFC2BCB1
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764584108;
	bh=ikaaUF2/JN45fY9WMI8iz4no0LJR1nDXhV8kfKqS0h8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hW3kaNtLTtI/iUQl6oYEkSKbMnBYbvgkvMNVQoCzueQhWAZUKTMuH11/2Ccd3YiT9
	 iUT7QSzDSlchQsNjv+8pm2nsn+i/Z32zmHhJMxzyicaV28tbVWgaQZZ+zMHSwo95CO
	 LU8pfcWcTeK6Glt4HnVBdLFI3zyIzttGbgVhaeNWDfz7pymQSWiPD7zNTQ9gLs7PtH
	 naJ1GgWe2112olwgM+8HiAo2IPAUv6PkmuW7/AsfKTjprCNa6aI3RcQK88ke4p67Li
	 Hr6odk/Q0VNwQVLDhJvT0O+KzvpUgVbTaBuhjwXnMRelzU0vMxaATI7709nOFEEjQJ
	 PYdKD2KR5zX8g==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so349549a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 02:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqyKGa92uTUsm/51KPD1+7IuuDBlsRBqfN+Qr8nH9c5uAYgLurUgHKhyIhjaA1ZSXyI+tKG998YO//kdov@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4B52EyygjMnd6NV+AHuy1739K1UlCzEdeDpkqSQn+3bo4KzZ
	HsW8aBpPT6pshgANN4N+dfvV+YfoYMjKS26H/aaAdrlhk0S6oePn5JFpSyJ1A8rpC94zgMdW3kJ
	5PnEDehPVANJSuWnjmOwMsF+LL5e8s9A=
X-Google-Smtp-Source: AGHT+IGJmxMOcMKTXwenMXe9ALgrBdLD/0fTmxvOi+iGlYkZ/XIBCTUEyDQOP5dzusxE3oFJEEFT6HXnXCB0vGYYvEk=
X-Received: by 2002:a05:6402:3594:b0:63c:3c63:75ed with SMTP id
 4fb4d7f45d1cf-645eb2a83b2mr23265459a12.22.1764584107001; Mon, 01 Dec 2025
 02:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org> <20251201081942.fchmydmpygqk7rzr@pali>
In-Reply-To: <20251201081942.fchmydmpygqk7rzr@pali>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Dec 2025 19:14:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-cheucFArdxs8ChPvpQ8L9OujnjEOQXXXr5L+_As-Meg@mail.gmail.com>
X-Gm-Features: AWmQ_bnfVy5qYUhBxvT2IjLrJptK9jLyJjlYopggMnXt5f4eEEM_gerFZ0xhuMw
Message-ID: <CAKYAXd-cheucFArdxs8ChPvpQ8L9OujnjEOQXXXr5L+_As-Meg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and headers
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz, 
	djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net, 
	rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, ebiggers@kernel.org, 
	neil@brown.name, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com, cheol.lee@lge.com, 
	jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 5:19=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Sunday 30 November 2025 23:14:24 Christoph Hellwig wrote:
> > On Thu, Nov 27, 2025 at 01:59:34PM +0900, Namjae Jeon wrote:
> > > +iocharset=3Dname             Deprecated option.  Still supported but=
 please use
> > > +                   nls=3Dname in the future.  See description for nl=
s=3Dname.
>
> IMHO this is a bug in documentation. All fs drivers are using iocharset=
=3D
> option so deprecated should be nls=3D option and iocharset=3D should be t=
he
> primary non-deprecated one.
Right. I will update this comment on the next version.
Thanks!

