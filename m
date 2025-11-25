Return-Path: <linux-fsdevel+bounces-69751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F96C844F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4FC3B1169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4E2ECEBC;
	Tue, 25 Nov 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwYknVml"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4462C11D0
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064482; cv=none; b=IxFjG8R2jqUHOqBmXuHaKDL8Osa6hZrxpdmS55BulhB6CVzV08X3bvgJV2tGo62jVNmZIESw5dAQa+eLdP9fPsxjr9ZTtHVWaa/GxQqu37JyqehIOGszlsW19B7aSLRXre9tr1bWY/h4K0wd263kRkQ7f5jIyhtn8Dw/7KsZaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064482; c=relaxed/simple;
	bh=IjzI/mOpuMuGbpo27E0zEqIYJCR3JiYRZ9xXwDLd+Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=de4zBY6C0pDhW1ftx9yUFiB0F3JRoM8aNBY/T/1X8NtHTRzxUOcWi/9AU3mDAkl4JO29BW9tcc9BETWdvwaOSJdVH3K97jXAQfDnmipFUGCq/nudPDDcI2Po12u2Gzp59ZyX0YcKE8khOOmGflOU8+WuN/zkVDCUuXGbzHBv7GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwYknVml; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7636c96b9aso714478566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 01:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764064479; x=1764669279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjzI/mOpuMuGbpo27E0zEqIYJCR3JiYRZ9xXwDLd+Ng=;
        b=kwYknVmlb3GPnLqPIxxaGNpK6rOFMx0l93NTpBrBPxfJ5sJ2UKH2LyBq9unSxxFIvf
         eusfiXglbXvKEtIN3eCuGYV8woBfG/ca1tBqW4o8DrK43jYKVnF7OmvDaAchyDfYdTkl
         DqRfyTg04WfSs5ZbN3a7Iq6i8KbWpdABPJtTvzCa6nzU0o7V1gOqVUdiFpAqXEpbaDDr
         46wZZ7VdzMSLqG5KtrlBlwvb6FTCOZVzQl1IJ1YKJZyom7SnrY5U0Ir/1jWhb57aeAh4
         wHhfcYnls28uklTSnaRBr3xBTcfsY1CHB0CDNkUQEYu1bKlP8nqSH92XW//ly5GfJte5
         GF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764064479; x=1764669279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjzI/mOpuMuGbpo27E0zEqIYJCR3JiYRZ9xXwDLd+Ng=;
        b=I9AayUsF+R4KuK/hvGYp7t2adY83JCm6QwqFyT+tZie+k4dskEMwsnjmrikklaWrKV
         MX/TF6d21Wu1Ya4KncAjEbLbcIIpcaLu3UgQR1m0SvD7kAmYy54Ei60NitAlMG42j0dl
         DMRkxkCmN5UNk7+xGNUuFuoTxU0piwUQWbpMEW8mY9I36q/1yqpz+B6vi8CPP/3t8zGE
         w8BlwKMhsVaT5vaHWLWMWaStVoA7GIx20ZNzuzfCVwKLVlmkoL2YTCF/otQji3i6UPcY
         j1ZXsCkTXrSCGgKpL0GklaJQSiKxede/1Ux8If314Ka/8G6DPGF5KrtzMvuSDrWNITda
         gAKw==
X-Forwarded-Encrypted: i=1; AJvYcCWwtC6oEZkCghO9PLue9y8hAN77soBHz/gU8QHSdcK6BSbFRuLs/AD47LfPAOrtpfrIjJdiRnDv2cPJ3xZo@vger.kernel.org
X-Gm-Message-State: AOJu0YwHo91t0dIlod8fHn30qXOT8pfHbPzzvqYt+Y9pXPCMcQFPQjKv
	mtxEzzBSGGi6Hig1DullPbihGdJK322YifxHmzlQo4l/tS+/OYUp27m6oKgIgffyelrcE3yUqOM
	M8WsMuP4NCxGJwiFQvUQWX0rqTVuw/5E=
X-Gm-Gg: ASbGnctRZn0iU80lUu3bbiNTi/YpYQwTCICsjUk1upaspzUaTGZXCRrT8yw7MfRN0AZ
	cb0JOPs1UcpTmgEqet0IBxPDFZjUNlX5cTbs/LY9CweiF2xSXsSghPgWgJIoDvy9abKlmeWdXV7
	D/ICQeSs7cMBWIOOTl+62DDtoBV13Fada43srDT3OsJUzdxSErJUhDFe2tAj0OjoZfsRLSnDw6t
	c0LKtqdeVCvo9mEOV8GN+9gY/+EiLcMutyjp8O3OM3vUlVxKgZipz/NleCO1Bal7elA1KTFqJ8l
	HqIeWxe1nL9haWZWeZDwaeDQ1iKs3JNiKCug
X-Google-Smtp-Source: AGHT+IFL6OQt64R0ioMfYZ85MX7vLNiXiMf4UaziqctfuGzHOPu4Qff/S8I5MAhIZcVVvTBWjqunvCU6VSOnbFao5iE=
X-Received: by 2002:a17:907:2d20:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b7671549dc1mr1587744866b.1.1764064478137; Tue, 25 Nov 2025
 01:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119144930.2911698-1-mjguzik@gmail.com> <20251125-punkten-jegliche-5aee8187381d@brauner>
In-Reply-To: <20251125-punkten-jegliche-5aee8187381d@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 25 Nov 2025 10:54:25 +0100
X-Gm-Features: AWmQ_bm4NedID6rbDTeJNBQ_Lr0ke3ePIHYVs1zVXFoi7EXoqkUm24yR2JJi4D4
Message-ID: <CAGudoHHzXjvMXUZhCKMvdPxzwg71MOAUT+8c6qgiKhUfS0UoNA@mail.gmail.com>
Subject: Re: [PATCH] fs: mark lookup_slow() as noinline
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 10:05=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Wed, Nov 19, 2025 at 03:49:30PM +0100, Mateusz Guzik wrote:
> > Otherwise it gets inlined notably in walk_component(), which convinces
> > the compiler to push/pop additional registers in the fast path to
> > accomodate existence of the inlined version.
> >
> > Shortens the fast path of that routine from 87 to 71 bytes.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
>
> Fwiw, the biggest problem is that we need to end up with something
> obvious so that we don't accidently destroy any potential performance
> gain in say 2 years because everyone forgot why we did things this way.
>

I don't think there is a way around reviewing patches with an eye on
what they are doing to the fast path, on top of periodically checking
if whatever is considered the current compiler decided to start doing
something funky with it.

I'm going to save a rant about benchmarking changes like these in the
current kernel for another day.

