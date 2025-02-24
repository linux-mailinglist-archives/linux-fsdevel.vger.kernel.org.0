Return-Path: <linux-fsdevel+bounces-42404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A2A41E5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 13:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 343E77A39F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A0219314;
	Mon, 24 Feb 2025 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQjSBLP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BE2571A0;
	Mon, 24 Feb 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398211; cv=none; b=fd+BDZumqx49IkmhYeXYdIaxjg++sSz8jlWvXMdJHdFkJ408cjKaWQWwGFi6vCUDBBpLSb7B6WPJKI3aqebq7EJNq8eqvqq1Hp1DDAKbGKjn9ut3FtG7bQP3u0jL9nuoyDw3H/UGC4LfWDZA3VzMx/TH2+KymDxKxW6STr9QZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398211; c=relaxed/simple;
	bh=jrJMMv7QlhqD3as+dpdi3pC7EqQjYY/WYCxkxkYYOnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdYT78Nf6xNlwqNZJAZKI7yalbSt7PWWCFe0u7ugCk0SXNr0Onve3Cr1b6FDJq0XSxDLs2kb0NEyS3Xa3Fk4jWbxihnJtbCEv+Amozz0ZwUHlvUQecMC1wgeMe4c4ZYQ6db1T6MhQzV083efYRfvTowU6BQacVnZ65OsCz2xGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQjSBLP9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so7848005a12.1;
        Mon, 24 Feb 2025 03:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740398208; x=1741003008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+96OHg2CNz3jsOPrD1SLwHF91Z9p7P3lTWK47GDeYo=;
        b=BQjSBLP9ay6qBWJGE0fl2U20OwxRuNkz3+m2Dypw74jT3kt3CEqDRwmMRWsPpKamfc
         u+T6vtjHuTq1ValodtdZ9BXMamc1nNYDehJnFDe/HDUvh82ey+zHjT9Ng4Yj27q4k3uC
         UphphDfIxImZsCPyaBXPUBZ7VA6SiFs7SCwYev0puSB3FCFTJXE27pWmyf5OwcKd+7U0
         SDlNBlp22+DNRducCNrl3DorMcF8CeKBGXiWKhFlPzFV3bxie8EsS27jTYwkUtOkIqoM
         soacfT10HL5XS7V7Cbu4xU+qBT11+Em8SHXDMUP3j4oHVCupqwXo0KcShC/YoEvBhvDP
         vcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398208; x=1741003008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+96OHg2CNz3jsOPrD1SLwHF91Z9p7P3lTWK47GDeYo=;
        b=CwdfYM5mSPYSLdUHXpkquVTuIQGGkDB0bplRZ+fJp3+zFJuKBRd6L5QSAyI4FSOBzw
         t10/gV/ky1eBz4xpSWaHWPYAx2CAq8dzadbV6p/w4+cmYMliPxNEmIn+4jTtnQnSiX6E
         607giTHSoBR1VJm1ogmyLmF2yiQE2vHyaJuGmTOIglL884S4pqMlXVqeZJB5xoYuf0gz
         7N2NQTbLePxgmQuuebffySMmqW5qhUtADRj6tD0hNLfGix/21jqmhTzKvI7AyXssGcHQ
         c2YyGRtmzM5HbcGFFkfL37CMSqaYFj9o1V0uXXpJhLA5Fj8+Ema1yxEivtRaNPlMelXa
         KOdg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ksqbh+slqmH74hg8+2MiHm/05SMvA1hkH4YF709shhikVFmDl6zVVc+cmZcl+ynvNZ8oHcQWvu+JC7R/@vger.kernel.org, AJvYcCWdb7rkEDxUisQnc2hgFHfnZ11Tqg2JyhYqbop71rxaPBZ2PGJGTfV8ICfxoIzHg2CEvEbUyfYefiPnRTabPBe4@vger.kernel.org, AJvYcCWx+94EPGshHAwSAs0uDS5RbpEzFxdVzxUotXf1piUzBJM/VXs3rJxsGfd5mKS0yrflgAfehYKkBHN16JFA@vger.kernel.org
X-Gm-Message-State: AOJu0YwMf6BEoHjb3UkqA2McJAPlXpMOajEl/7G4XOmRrhYx5gLqJdRg
	BQzoSvlnuE/j29ebf6TGE2sVbv8JmwhLaTueQ9pKTn7vsUJzSYnjzxmGELVymX2E7tbsO7QQLnE
	+AOQyP8Oc7COyr3p6m4jmLvFdJsKA3g==
X-Gm-Gg: ASbGnctJbA+U84Wzvui8IncJOQytrW6mCohvPpC4XxueoBUi9dNWpfI1ahFpmse4+FR
	wa6Ag8am5ozcqDsgRRTRfzqt3xgFjMqtCrg1BhUTwQnJBGY/jaZSmstENpXWBZyYRWvqanI38FL
	C5fqwF7w==
X-Google-Smtp-Source: AGHT+IFfaN2SNKlvzXfSDS/0dWDkjOwYmY4hEzsawg7LR8qMJl6zIGNNpDOGwhg8ARB5Ea4qbQKs8/cjQ4Fbh8sqz9g=
X-Received: by 2002:a05:6402:2683:b0:5d9:a5b:d84c with SMTP id
 4fb4d7f45d1cf-5e0b62df50dmr13283973a12.3.1740398208338; Mon, 24 Feb 2025
 03:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112095353.579855-1-debug.penguin32@gmail.com>
 <gfnn2owle4abn3bhhrmesubed5asqxdicuzypfrcvchz7wbwyv@bdyn7bkpwwut>
 <202502210936.8A4F1AB@keescook> <CAGudoHHB6CsVntmBTgXd_nP727eGg6xr_cPe2=p6FyAN=rTvzw@mail.gmail.com>
 <20250223001913.GQ1977892@ZenIV>
In-Reply-To: <20250223001913.GQ1977892@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Feb 2025 12:56:36 +0100
X-Gm-Features: AWEUYZk0hJ0VBk6bQ9jzeGHw6myi88ci7mUM4JWGUZyghXokOStXt-QAx-1lQhU
Message-ID: <CAGudoHHietV1tkgQMXup0PE29SeZoZXbaBsWEmxUsLgSA-U32w@mail.gmail.com>
Subject: Re: [PATCH] qnx4: fix to avoid panic due to buffer overflow
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>, Ronald Monthero <debug.penguin32@gmail.com>, al@alarsen.net, 
	gustavoars@kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 1:19=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Feb 22, 2025 at 01:12:47PM +0100, Mateusz Guzik wrote:
>
> > General tune is not holding the codebase hostage to obsolete (and
> > probably not at all operational) components. If in doubt, prune it.
>
> What exactly is being held hostage, though?  Do we have an API change
> that gets blocked just by the old filesystems and if so, which one
> it is?

I was speaking in general. Some code uses obsolete APIs, other puts
weird restrictions, some other has to be at least reviewed.

General point being mere existence of code is an extra maintenance burden.

If the code is beneficial to have, then so be it. But if the code at
hand is not even used by anyone (and it is unclear if it even works),
what's the point keeping it?

--=20
Mateusz Guzik <mjguzik gmail.com>

