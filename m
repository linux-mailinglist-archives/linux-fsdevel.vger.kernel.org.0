Return-Path: <linux-fsdevel+bounces-45705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A8A7B0F9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726A9881924
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 21:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ACE1F4C86;
	Thu,  3 Apr 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7V+SNqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161762E62BF;
	Thu,  3 Apr 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714929; cv=none; b=B2nyCqdvcfkcE3J3JW0gd0xpUaP09SGR4JelU65U0V7DPYP5ghBaTuNq07lFHLQTvdI13W1cY1HS3YJhIxTXN02FBpYRSEONuyL7PYFQ3SGEa+1A9gNFttwx0v0iZUcHZX6MlltjWUsqXNeLp3ycqR1pne9LCoveSMIQZIv4v8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714929; c=relaxed/simple;
	bh=HwCQpAQIh5B4VTTn8FN0DhJiCQM3f6//dB8KKhrCFJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXjkSWOb6cwyRJMdfW8HdjRxr3Qr/PwA1IFzfVJ+upSXSygK0iIk2peSZ+C8sgIBg2+L6LOLKFAr7QNZAsMINFKYb+qPPWtH8nEkDekjwyMmElNsyJvleF1OD7Gq80QP452BkdiBSTwMF3of8o9o0s6o+Py8UW7qnGtnfBIji8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7V+SNqS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so9397135e9.1;
        Thu, 03 Apr 2025 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714925; x=1744319725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvD1Km7wGFLtWOqgEFNWRLw6eJ4esFFynlnh8JehOFY=;
        b=V7V+SNqSGYdah8Jilg6dLHkREWfB1Bp9/f+yy643BcEceO0ewH1rWVTAAlr+C43zOV
         UBKfIOsidAlQDYQoG+mHin9muwkCFEbBvSZ2qNIB0tL9dgv6lCOXq0KudLJsjPRJgU61
         k8jNtwH35PCKSZT9H/feQjtLq1HPll60QbtdMPGD5hz5oPQR4dZLhjQwouaVOsz8sR4l
         yYX7s5niyvqlsV7SHrPM5/N4qsRJdjlvA6TAz6Xgd3bxBRaMGiDd+HmjYGH/PiA4q6Q8
         NDNYbwynT142i/gGhPVGUSxusCzQ+dulstxEDSR3F4+p0KwJve++IlM6yhrbrl+YNuj2
         m9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714925; x=1744319725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvD1Km7wGFLtWOqgEFNWRLw6eJ4esFFynlnh8JehOFY=;
        b=b1c2ZzQZUobnhp+F7VV2itBpSfFf0xKIqV/1E0dyq+FpWXfDyha2ApNXlzs0PRMpZw
         2FP7JEkVfUyAXpyhdfUd/IfNHbC9z62ETDqlckU52CA+vE6O1xmPHS+59keUycGGkhp3
         896vcbG5hri4OK12S7dKgkyMLlLPEd+eC7AO9lLot0pId1yFCVSUAsTRJ/hZwF3UbkBV
         tFD0zGrpsoAzJY4B83+Ppvu5R2cTp7TW2vPP07m5o1Ot0g5AorOxM3yZnLiI44SnF75i
         2aPY1j86byKVHn80fuB74GvmXGsjIvZwu7uIMQcYM+A+PS9oy42bvdKB7rEi9OX4n1kH
         pyzA==
X-Forwarded-Encrypted: i=1; AJvYcCVWB4jeDaQaErJHAwZ+kCrbP0lYQn1Fo15rO47hJ0eqIPeQ6Mf3NLVnr46OPxc1R8HX8s1Xw8yoDI0C2G0X@vger.kernel.org, AJvYcCWMb4hKZ0fHutHYCKzEXAtcwe/E4r+/Crd4ZgVDGXFgRbwmWx+3zuM++MPnioI/kDunzSDQgs1WyvnO8o8ktGO3@vger.kernel.org, AJvYcCX+Q7lv5auI0QlaMJwGTnw/ho2JP7dn2VK3+g+MPdci59WNVYc4nb26zrxcwFVbjnMwdQhPHPYt@vger.kernel.org, AJvYcCXe5k4Yxx2rxJv0GrskGsdgbMtDnuhgmQ+/+cIkg4mdgQhpcjjdJeu5J8AmSHf/IkCMv8Z6pEAgsKEYR8IW@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbbjFVuIsfHwN3hdUX5WsKWUHyv2MO7IbSotEVjYzanTFudGF
	TEdIwmGo/B0nngG6DL3/n7TqyMGU80AvVtxQ8cRZCVEf0Kie1yQa
X-Gm-Gg: ASbGnctQkMd54GTd6M3wkuAHBbnfVSI88c+H4lfPxG8sfYQwoBa/WjCQ/TgTjZthlBY
	sNAI9tOAbiS2g7feT/llX4CuCBnBWnL5VyMzjXhmPiNOCMa7LAEO7oi9PzilmVf6Hkl2+jTj3eZ
	+jP1MN621LfdOtAYhxG38K0j/sASxAleinduGZsm9GjAZ80rYCE3PltDxKOMVPJXZnWnClH+Cpr
	Jdm+FKolxfKJb/QksgNgKDpa8J1Xuns7wizZ43QhZ+9pgOMa/6Uf7pJrBMjuUcDw7Vi1bBLFC6A
	tTgcP4QRcFdiAkkgbfqteHIyJ2++8Y0Lgahf2jl5Szamfro/9g7y9jRiQdIku1Be6Dba8aQwHei
	A7V6PF6Y=
X-Google-Smtp-Source: AGHT+IGBaHYjceQBSmbH3010b6NTsG3JdQrqaS3chq0W1aRj/OYqtwyl5jYbNbbhjuezGo2AbkFbvg==
X-Received: by 2002:a05:600c:3494:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-43ed0bc8d96mr2756455e9.9.1743714925141;
        Thu, 03 Apr 2025 14:15:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b0a38sm31305665e9.34.2025.04.03.14.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:15:24 -0700 (PDT)
Date: Thu, 3 Apr 2025 22:15:22 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrey Konovalov
 <andreyknvl@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] string: Add load_unaligned_zeropad() code path
 to sized_strscpy()
Message-ID: <20250403221522.328b174b@pumpkin>
In-Reply-To: <CAMn1gO55tC78BpD+KuFgygg1Of57pr16O4BvKsUsrpo830-jEw@mail.gmail.com>
References: <20250329000338.1031289-1-pcc@google.com>
	<20250329000338.1031289-2-pcc@google.com>
	<Z-2ZwThH-7rkQW86@arm.com>
	<CAMn1gO55tC78BpD+KuFgygg1Of57pr16O4BvKsUsrpo830-jEw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 17:08:51 -0700
Peter Collingbourne <pcc@google.com> wrote:

> On Wed, Apr 2, 2025 at 1:10=E2=80=AFPM Catalin Marinas <catalin.marinas@a=
rm.com> wrote:
..
> > Reading across tag granule (but not across page boundary) and causing a
> > tag check fault would result in padding but we can live with this and
> > only architectures that do MTE-style tag checking would get the new
> > behaviour. =20
>=20
> By "padding" do you mean the extra (up to sizeof(unsigned long)) nulls
> now written to the destination? It seems unlikely that code would
> deliberately depend on the nulls not being written, the number of
> nulls written is not part of the documented interface contract and
> will vary right now depending on how close the source string is to a
> page boundary. If code is accidentally depending on nulls not being
> written, that's almost certainly a bug anyway (because of the page
> boundary thing) and we should fix it if discovered by this change.

There was an issue with one of the copy routines writing beyond
the expected point in a destination buffer.
I can't remember the full details, but it would match strscpy().

	David

