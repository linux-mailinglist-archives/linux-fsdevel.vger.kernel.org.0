Return-Path: <linux-fsdevel+bounces-54860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B19B04228
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 16:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220CF1A632A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565912580F1;
	Mon, 14 Jul 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TocMJWKb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DB7262A;
	Mon, 14 Jul 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504657; cv=none; b=flZv/x/J5fTXKkyg6LW0qhsvYUBckxXp5TX0Qy2k1Ecgo5T4asfBPY0Sb+P5Dnc8rjRuQYchN0LianwQI2oYMq4lDi9tw3mi9BQgscAGeKE+f/QBkhbm/8J4ccZbt4yQtWE29CQY5d0jxe80BRw5PqyYJmL555tz/GbDFM4KWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504657; c=relaxed/simple;
	bh=X02qYMcefX2b7B0ykVuLjAqmTZuPe7scNBrQESqg9lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JvYI6z83V8hM4wjEYdc8m7yULlKyNMB6c4Yd/PNvcGGvaS8SiXohA26eAYqaR59HVKtz1U/HeKbcmz4pxWHvMkZAaEWAsTG815Uldih7c3Qpjbhlsq1s71PEvWSlUAU5pwHi4wKrP17xQw3i9fGcmH+DK4ny8IUrjWoEA6aRKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TocMJWKb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-313067339e9so848424a91.2;
        Mon, 14 Jul 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752504655; x=1753109455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X02qYMcefX2b7B0ykVuLjAqmTZuPe7scNBrQESqg9lA=;
        b=TocMJWKb3xTwSZUViPXBFh3QjtGYTI0ScC8E1+zwp4oksMr572+UamVywOTaS6gUXK
         HO4oEtM9GZKL1WfZVbMHh7uEQ+LzkeO4I5C7W1Ryn5uqRTwJ308IxB6LSugOiTkuFaZK
         KJykm2qpIipkwi4RsS59VdDOo3e3Gojx2BNh2+DCRwmGvs/upvomNkFB7u+s41zWOkFR
         ETISbL1MdjTyn7V+gvxpvIVINi8wnpgEdQAIlD1ZiOCNV+ae6qa9G+0XhmmYZPaLbEvL
         pec4AiF/LdZOsl3y0iwWYnKf9XRz4WLh6mcO+akki49Co0N28iyR6TAnwNpselabeJUU
         B/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504655; x=1753109455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X02qYMcefX2b7B0ykVuLjAqmTZuPe7scNBrQESqg9lA=;
        b=AadBJ29UINGFm9k38q5IWyI0soh4bmxynd2I8JCbCWvb5k0N/OmLmrXAZG4SzReUrc
         XPnL6TsG/zatB8ZsGAP66FJLmGVCf2a6gbTdhhlTyw+3k9G1MKROhG4BShl2u2rwIkGl
         tOeeSOzp9mZQE4CJPFpj5XBcNsNW/YbuolxzyuPIseoeNP8T91sJJGRmJJKUlM3tnlH5
         ZDfRbnsKp7wNwQjllTiKZVcoLcYJeVJhkjqR9hNvEBiufl2qa5cjKt0yePd5db0sZb8x
         ND9h85RNykHodaYm6q77l2Y37/o/70esGH4LjsoOJkUTJDV3Xbj2Ne1DuXG+ksLyCAgD
         CxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJZeNThUg+4yMhdM8owaN+42M3UDyEkfz4JselnRkI2u+3o9xs63HJmft7Zte1oNBm4Z0AY8zt/olhuOiF@vger.kernel.org, AJvYcCVQlH85BMh9ttSx8/eg42jPki+wzvVUE/4vyXaTsCXytQ/DUTZsHBReQ6I0sC31Biey32ooclGZLn4HBoUQ@vger.kernel.org, AJvYcCWv16iuEWcgn2EYDnGzTU8HgxE4A7XrFr8EaHqc0TVE3pxz8rrcedPgsNVThn+g3UYrr54JuLfvkzCpmMqV2hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8IvBf6oLGhO2y3LBcLU3C8xIqOSWrmEiQQE8XHtbG16NA/Rx
	XJ3AN4LJpyoAbP/Yo9hAw9do70/zKtZQnmvfgsgmcbd6KIVcU5fUkyGB0d7u5IX/Z7JG+VsOTYa
	TKf2+1+uyvjT6Izmk/3oclmaHBT/1WEku76Hb+fY=
X-Gm-Gg: ASbGncte2mne3iR4drpnlmUDZCNWPxUUScM8H80BwdsRu2RMSZ4jtFPn1BgOynS44PZ
	uTveGYKxeTF7egA9BSLwN/MQAXuSRLFFBiBhxpVDBdm0SOKDxDoFHbEQv45WWDVoKPAlNArhrOs
	LcCSC1ixJxer+WAR2FvJRevxwPw675RS76MQagJe/oux/GAiIl38EbGpEDw8+BHO6xJiTHS9a3R
	iJ0UHZk
X-Google-Smtp-Source: AGHT+IHyw0Y16Q+BsAKTL4kOsmExJ9tG0TZrR0YAQHN4gzszpuHwKwA9UZ8qteYLhHrtFt7pV+gGLhvIKNBmHqX0s1A=
X-Received: by 2002:a17:90b:1f91:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-31c4f540cc2mr8660688a91.6.1752504655272; Mon, 14 Jul 2025
 07:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714124637.1905722-1-aliceryhl@google.com>
In-Reply-To: <20250714124637.1905722-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 16:50:43 +0200
X-Gm-Features: Ac12FXwKaE_WisKSm_rccGOTB5dL3B4ixH2bnOuWPbc-JW7Ehi7gx7hIjoGc314
Message-ID: <CANiq72kztG1xmbDF0EJF4O3h0N1vOHSgMn3MVguDXOEXQJdPmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: add Rust files to MAINTAINERS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 2:46=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> These files are maintained by the VFS subsystem, thus add them to the
> relevant MAINTAINERS entry to ensure that the maintainers are ccd on
> relevant changes.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I think this is indeed what Christian wanted/mentioned a couple times, so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

