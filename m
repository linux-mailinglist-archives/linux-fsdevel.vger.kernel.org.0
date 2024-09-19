Return-Path: <linux-fsdevel+bounces-29694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81A97C56B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC96AB21B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA5198E7F;
	Thu, 19 Sep 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+xPWqwO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B29198842
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732609; cv=none; b=HVHC02/SYDLABMdAkmoAWb/RwdOxTN4BTxxvufJPfGlpzuUISeksp16nWo6nKsyUfov8CJlHoWrJOuh/Gc/mFlQK0TrkAf4GHoqlVusFACU5fLbALavhCNT3vfQoG2QH1qCDTvGM4o3yeOIJLrqIHgTTXXATU0tRcf0hCxq9uoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732609; c=relaxed/simple;
	bh=licP1aKu2lO31lzxZuFaxdBKh2M+wK8LBAdaKCY5Plg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RROVpC8WlcMfmaG2zcZixL6d9lrc66w/40TwcpMX/pXBXavSN2h9X8v5Mijwf3g+fpsn+TPE0Q5HJ69OTfFXwFtlqvT1cYBWvOpLBQbGm9NujcJqEPSZLdms7MGvq97Og8ngCbwydzAC714PXKnC4jABeeS0J9cnE46LIL7U1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+xPWqwO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso520204276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726732606; x=1727337406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2a4eRU49xX2INaiUTp0IA2e1oYGO5r7N/3DbhAJv4c=;
        b=N+xPWqwODKHsUmthiIGyTezlBk3rD1u9YnFtaR30d87kI+jLGAtYp80doTOuzxvnyn
         7viwLUbqihUKYmgpVWr5r3OUSQQYjBBWuEwXoPrON9Xbkl2/m0qCPXzEHVJJry2zbLJP
         MeN98aRA1VSusTVYQV8/DJgw0cloQ8z4QvRFIjrklFB3CNoGMPA90WPyon1/bo11Q+oJ
         1F3Lkf4togrvqtLXIoaCG2GMl5PyeNHWm4TbPuOkuezsdrl2YgMHDVkhqi4kyntET/ky
         5r3XZXCwsav9+C3e+0EM1nTFFnj7Ia2XtTPDDaed1uikGj6y6yuedasWvNYDA4DTDYMt
         wyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732606; x=1727337406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2a4eRU49xX2INaiUTp0IA2e1oYGO5r7N/3DbhAJv4c=;
        b=ClQMQuyLfPdNZRdYcCmQb270XOaXCMEkHz9rjxb4y4Fxv5m4KIj4L3KZWVBSxl9LTV
         aRbWwT+aoU8BJUz6ZZJaVPM95EunTc/1asDhBbfLUpGqS04PmGT50LGqbdX4KKLnbEZ4
         gXQ5wxEREsG9cYyU40DdhQ0BQmfV2X2hToTScj0aW6vAiUkbfxZEKyYMqmvvELVyjn6+
         LaxX2rdHCrki2ipN5CiDnWCnv809tKigc4M/tlmbGeurq/fmrrrfCxOGxRAmWMV9E5EN
         wZqDMovmzcw6d2wGRdvngrNrrvJiFuTnBR9s3tanHkj8uNcQc8QZHcoq9zpBKIeJ0MJk
         6QSg==
X-Forwarded-Encrypted: i=1; AJvYcCVI3VMffYFr5+1TKa7adj6ZmteXHwJUKf//Vk8tsht0EMFNyx0xtroIKtpamCfnj+MVvW5aV139YRHOSa7I@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmFcXb+pQ3NtQXMKbMSuXxSZro3iYIsEOyDtlwWm7U1Qp17BC
	jtjTk4FF/lG1xKlKpY9AybGqTia87B5d7d8d953+UIkGSc/jnFp+Jup0RoVMwMx2cOZIyS6eDnl
	6h+C8Uz4ST/NBo5u/wf1TsJamgB3igKUS3gKy
X-Google-Smtp-Source: AGHT+IGGUSzdO2I0anZLf3+uZThLjZFuPCtbBPnYMnHwjyRvn0j/ljOlNxpzQq6H2AStCXdo/UzmJxPrBrb4KTlZPh4=
X-Received: by 2002:a05:6902:1612:b0:e0b:efa8:18b6 with SMTP id
 3f1490d57ef6-e1d9dc412cfmr21057746276.45.1726732605952; Thu, 19 Sep 2024
 00:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com> <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
In-Reply-To: <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Sep 2024 03:56:34 -0400
Message-ID: <CAHC9VhQmgQP=WPGdg_2fGUAuKLQ0V2DF8FWXhfVrou=RdLE4bg@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:31=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Add an abstraction for viewing the string representation of a security
> context.
>
> This is needed by Rust Binder because it has a feature where a process
> can view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
>
> This abstraction makes the following assumptions about the C side:
> * When a call to `security_secid_to_secctx` is successful, it returns a
>   pointer and length. The pointer references a byte string and is valid
>   for reading for that many bytes.
> * The string may be referenced until `security_release_secctx` is
>   called.
> * If CONFIG_SECURITY is set, then the three methods mentioned in
>   rust/helpers are available without a helper. (That is, they are not a
>   #define or `static inline`.)
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers/helpers.c          |  1 +
>  rust/helpers/security.c         | 20 +++++++++++
>  rust/kernel/cred.rs             |  8 +++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 105 insertions(+)

I doubt my ACK is strictly necessary here since the Rust bindings
aren't actually modifying anything in the LSM, but just in case ...

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

