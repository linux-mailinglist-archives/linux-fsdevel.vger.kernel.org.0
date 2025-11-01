Return-Path: <linux-fsdevel+bounces-66671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DAC28145
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 16:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48354188E85B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787382F5338;
	Sat,  1 Nov 2025 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks7WCdDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAF1E991B
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762009621; cv=none; b=L2s5yOa2YPg87VSQ6v3N6+VJlfRhvlWtoynaAEGwBmikjKIP++AvOzeLmvD4P5T9ANdaQJtxeUETI1X/2H9bF1xuKY5yP1UYlulD6H9QBu/Yrrit0Aj8jQfzgss+bHTI837dsHo/Qxl7dHxlw8DbMm9MzeQO6WTEnTH+LMYK45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762009621; c=relaxed/simple;
	bh=becdGP2alRJ2u1AdEeRmaLP7ThHZQI0eIuX4AXNQ4Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYSh5qh7Bkea8Pd14VubueckB/s6K2iNhS6jIIX0Pfhl///+dMiGetQoBRW6+iShwKiN+1q8xvz0MDQNa4nyJ8SMyWkWrpyVu8KnczNr+0LASctTlAcUjyVJvmgNAtqpNWv/h2VVNf46Ho9BOpJm4z622G5eM/AQcemi6z8HOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks7WCdDl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso507513b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762009620; x=1762614420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YiAzuZ3UregSrMpF9J31H4Yx7ePy+2MOlCUjA8nJCA=;
        b=ks7WCdDlLigxXHjPcJDq7rRN4iM1gi975yI9wejfBe1LEToibzFS0ChatgRmyTzoae
         XLOCzoxzexqMKJkn+qf8/0Yri9P5qWy+4GjtuM4mzQIUZUryAiFUulQSlBda/Y5f8JOe
         gpMVz2vBi0+Ng9kDf9V5/cz+C9urIxoeSTWLcC4YP9N25m+cDDKDRcu01h+RLZK4ACZl
         2vCZ/v0mA4Y/W8Mm8/ycdSz8UhoAZyQmqMk6S80208QggdpnjVNDMGaC5AcNus78VzvO
         FO4xOVjC63QhjQxNfrMKdSOO65p4epi6t/YHvTtZZYp82MzVVN+gaoHfVfevoQMUINo2
         Y1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762009620; x=1762614420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YiAzuZ3UregSrMpF9J31H4Yx7ePy+2MOlCUjA8nJCA=;
        b=pbksQlJjuLt/2E+3yZZC+p8PO2MeXhvshhJvfkB2L2r5yraiODLN1cTCFRGRAjxCnT
         nvVJy1BQvy59THLbvPA0bPrQyC4jPIY2wLL1wFJoKR2v9+Gx/12ER15GHUPRGXx4v/vN
         Vv/CvtSudc34gfdazGihSIrdd4SciIOPp55pXbIMb5FgiMaD4l0C40hSzuBeSXWZUZyg
         82vSl2zQ8iuXeG7W7eV4ZRo7zcevsv6npN0DUcyLYVdu7jv0bFdUkEMiOD+/R+LMv0BQ
         8dQ78ThveHheYV/0fLFJWAdUogpBoIce56UvWy42URQ3t+WnzG4fI9feVKSrERe/E50w
         M/TA==
X-Forwarded-Encrypted: i=1; AJvYcCUqT42gLtd2YztKYS8YLvPqGupfg26MPSQ4OG+a5mn9JMErXZqu/BBKiB9xbcrIDEsx2kWo/fK/The0El8t@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMJoZiMghYJjYuZyo/zXGLgH9LwYp1xw5kKBjVy6kPtPS8RhN
	KDf+dJZC0ETNxOZ4kARlU1pQ5dB1caC0/BQDIo7QLC0Y0+GmiHIaJbHlWU5kp8+JfWk65JSnytJ
	BwgIE3pcpMGCuwA9qy7VeWMWTGySgBVU=
X-Gm-Gg: ASbGncsOMj6sIrMZ+/SXdKeRV7jZPfY4h8p7uuwmdXEpzDRJ0xFf/V+JOiRoLReTusD
	TmHIJ49+dRc3r0WVjoiFmU3uVNdO53As2Sxj1Q7EmmESqKygauBaIM3tIpV17oCmU2HUVeiLTLr
	AWv8u90KkTM1fJwckCsNj3oELIcKfkJNVcMZfZYsDyiVr9w0NtoUzZj0R0AAP7gwv0e+dJiMeuy
	a027xylRJUtq9WhTdszmNqZmM+zjJHOv5kz7v/3dAziWXr+73awbgqHeETKNhEDms6qrVmMPpFz
	GIlw+YbEXsYQt1KLHj2w4VqIvVEboqJaor9N/6lVi0vNcqYeP/FUVwdDVN7QHmQGSjtc8Jbjpjw
	2V224TRN7XSGFmg==
X-Google-Smtp-Source: AGHT+IGi6G3P46MnlLa6pHrqzoZMNbq5z4mcGHcJTxA29pvYP66KNHtzQiBAWUFWhhFhSjojWQFNPtYK8TTJX1H3rRs=
X-Received: by 2002:a17:902:d2cc:b0:295:6d30:e26e with SMTP id
 d9443c01a7336-2956d30e5famr6001545ad.8.1762009619849; Sat, 01 Nov 2025
 08:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com>
 <CANiq72k8bVMQLVCkwSS24Q6--b155e53tJ7aayTnz5vp0FpzUQ@mail.gmail.com> <DDXFFQCZJW8Y.3GMX8666EJQ2I@nvidia.com>
In-Reply-To: <DDXFFQCZJW8Y.3GMX8666EJQ2I@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 1 Nov 2025 16:06:47 +0100
X-Gm-Features: AWmQ_blyOPSYdkZpX6T0yNaf0355JZzLQBA5jSJ7sUHzLUv-DNemVpz3bwTrLh8
Message-ID: <CANiq72=MetoQajmJ5Hwmopp32YZZmbNu5a5EtQve5rxP7z0uMQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 3:27=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Are you referring to this discussion?
>
> https://lore.kernel.org/rust-for-linux/DDK4KADWJHMG.1FUPL3SDR26XF@kernel.=
org/

I saw that one and the patches  -- perhaps it was in meetings, but
dealing with guarantees that are only true in the kernel (assumptions,
conversions) has come up before several times over the years.

Cheers,
Miguel

