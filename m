Return-Path: <linux-fsdevel+bounces-13060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AF86ABE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B72E283D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D9364CD;
	Wed, 28 Feb 2024 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FA99N09D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BDA36139
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115003; cv=none; b=HQcwCsSAJ83N9/Z5ySQj61okAmEsy9ZyVOjWd/Kx6iQypxqrlVZHkQ+xw1jeQV99PP/RtuqPCH9MDiGgp5DaAxic9fTelaeXAQYSI/8ZatAjsm4aj9salmMJYoi3mGN/qhKdae7cB1aV8qwcFRm7Zb+BwI+rLuH/aAF8JYhVLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115003; c=relaxed/simple;
	bh=PTIhoZ7cZRDnibpTWA41AYPiGAUR7wb+Y1RYUNJTp5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmqeJ8lYlZIXTCmEV+QMkOeL4pWNM5d4FtSmAkoH43SNSfmwd5dj945pcI3tnbVLDLQiQg0rv15R9PsrBsel7vQt2iN9yR02fzoxGdn/SmTc/kahj9P/cz8ePFTCzJMzpYTicWmVVLQi3YbyRTCiTCaqlKxSv2IEAUHK32XG9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FA99N09D; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso3117224241.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 02:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709115000; x=1709719800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTIhoZ7cZRDnibpTWA41AYPiGAUR7wb+Y1RYUNJTp5M=;
        b=FA99N09DN4PYhxIhYiSRFy6hcOet697tvIiFFRwOJAdqbxj26iOVXe82tYJ4zRs6j2
         UbTmuiMZSlpHTnmukXw2BEK0EVgJtcTshE1SNmSFre9VciHpR3uIy/VTdKEXfP6owaFN
         fSAm3ZlGJ28PH2al1GMaEkQv5WIJUkquph1w/kRQbYxHR0ZIJvWj3eV3NWIYomGUgOPu
         YqFuiskOT7Yrh9O2VNOOFeIhBv23cKVAZ/GsRpXRl6RJdjylHtPr3KpHHCvrhuXr0vda
         3gcuX3OiYNEEDYmStEDwxygnhe+ZzWuW0WLBk+uvZILSCAPxDz446Fi3Zker2j9oI63E
         CzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115000; x=1709719800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTIhoZ7cZRDnibpTWA41AYPiGAUR7wb+Y1RYUNJTp5M=;
        b=g9BTmZ3I/6zuyxRJMZ95MHFhxobRgcqUsRPowpQE8CoK0CFkJqgNAbps2MzKbSLBmi
         5IldR5Ihs3chrycOEWuOk/bYZmsAilvUTGrMftuhKZvgajpR8qOFAFyz7lEua+rEV4Y0
         rVYIj9HkNLALm+mdJ/cufMO2uaMp8dOVkhe3Na4J1OUnh1ahcExl5j/QZpNcwaSWOw9q
         LkCkuUmAGibWchv2Elupu+L91fuV0Ig/tPROiK1r190QvCuYRh1/1RP0/VBrcl7NuA53
         QZurdNDSfej41yLMrA5nmDQBXOz8ZFDexCsbox7Cr4WZckMFvDiGXbJYlmbjkIxOhLFn
         HRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpyVVYE0B/7XU0BicDrds7NghacKCZ2wLKFgGQsifdmI+aNQK3b/wOtdmkrLBSY+Wfd91ABQG5yfUmhn5u/HoEd/j5UeQqyF1Zr8syIQ==
X-Gm-Message-State: AOJu0YyTbR+J9FQ0QHPVKgb0aHQkUfl6GoH5np/HoWd4AFmFl6Io4AkX
	YVFfshs84iA5VXSAjDffM9EbOwKGr9oiL6dZ84QfIUqXj+XAcnQ+UC+p/UZ0M5sxwG+vRdFA2Nm
	R3geQag78T/kQnl6MQB0b93GnGcUoj/kOn7jf
X-Google-Smtp-Source: AGHT+IE2lL9iJ1Cs1YkXmPLJIM3HLDT0RD+3kSslhg3igF3N8clsEXikxaZM9E/LYc1zd8wIlHEYxuBRKkPOZ01Pmac=
X-Received: by 2002:a1f:4b42:0:b0:4d3:345c:6a6b with SMTP id
 y63-20020a1f4b42000000b004d3345c6a6bmr2775383vka.16.1709115000333; Wed, 28
 Feb 2024 02:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209223201.2145570-2-mcanal@igalia.com> <20240209223201.2145570-3-mcanal@igalia.com>
In-Reply-To: <20240209223201.2145570-3-mcanal@igalia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 28 Feb 2024 11:09:49 +0100
Message-ID: <CAH5fLggCtnge7oEpzsd86Hdn15gck1U7Upq3Kf21B5WOmsr2-A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Wilcox <willy@infradead.org>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 11:32=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> There are cases where we need to check the alignment of the pointers
> returned by `into_foreign`. Currently, this is not possible to be done
> at build time. Therefore, add a property to the trait ForeignOwnable,
> which specifies the alignment of the pointers returned by
> `into_foreign`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

