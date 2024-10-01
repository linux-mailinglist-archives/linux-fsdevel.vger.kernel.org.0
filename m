Return-Path: <linux-fsdevel+bounces-30518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B96398C1EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 17:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E500B1F24DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34CA1CB50B;
	Tue,  1 Oct 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAsQfLLI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABED1CB319;
	Tue,  1 Oct 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797531; cv=none; b=gQdjRhbnAEKhwVPBTPxux4cS1JrKBJtPz1MJkEVp3Dq2ieEPqNBWM+fsOt8XnAZeBZsLuau1ltYmwbpByfdjWGgVfvO/ahyNGo32aVleFSLhBAyU0eMHcwXZzyAVMxZxF58YKLFnldL/R/aGl0x+JtN//K1UrcMbIpKGjvrrI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797531; c=relaxed/simple;
	bh=xyQHwp3xn4A0vnBHDqD22D1XUdk6vcpscDN0Tdf3Y1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcWHdsc9HipSATnQqddeexL8GyAEd7UkH3eAp3qLwHQlc6+3fvUMP0r+rEza0EoiSkUzpXa+jBYTkKL5U3WaTvqYkxG3v92bWn1QZT2+6bwhEXMzEmN1slpOIfkJFRnIVFB83o0WmMQ2cc52A4xImLx6LnussrtkFfgpQRe3tro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAsQfLLI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718ebb01fd2so829904b3a.2;
        Tue, 01 Oct 2024 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727797529; x=1728402329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyQHwp3xn4A0vnBHDqD22D1XUdk6vcpscDN0Tdf3Y1w=;
        b=TAsQfLLIMTyO5H49HrDEkC97gYeD/rzRcsBRNA+aGRSrubcKumQMD0Zx6BREOy7YtC
         n8JNQTAs7As30lGzou+rQvtPUNUTNUxBaL0yjSLmmvqrZWGX+360AC8Li6HDk2gMZOth
         FFklbFbnwawIEgKfJ+CvTT58MfNsU0an2mhVWHPoHFnbWJhH4Ui9PPSuXxSkWGrQ43KG
         lAUjUdA4AvISK+zJ61xljISv21ySl0cvj3t06XzoNUNyZeQLjawf7p+HTUeGqwXpgs4Z
         jD2pNUULJtKnHBvP4+MN/qJv1M64fJ6OhM+tN3GpLiym2pvShw9QtdZjLVVF7HaxS4S4
         Bb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797529; x=1728402329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyQHwp3xn4A0vnBHDqD22D1XUdk6vcpscDN0Tdf3Y1w=;
        b=BIlVEVS3PTR0i9D4DxGl7gh6037zHoosAkHRNdulwqYsnCCm5nTIKl5rhSp+RFi6Va
         qxslC3yHDyje4dCjhWNrkqc7tUar/dFifhf5k+UhsVHdXXD04F718hzqzzyB/y/S4xs4
         t83KSpVh++Lb/nAQTetxLyyYgsbvRkgip95dMJtrPlmQCaLOf2IYtT4nbFLazWfoudxA
         bO+/8CBZTuzEQPZ0T6AV+S2m6TkeGvnnX6IstPnCUUXvuh4zav6+RJjggfCp633BqzwL
         84dolsiMfWA0Ja6iUc9KLhP/lLYmnuhboVpHm9vCJs8UCbhsxpnhgcHxSw/mOVAts4x8
         yi4A==
X-Forwarded-Encrypted: i=1; AJvYcCV+qB1oqbWHxFLHbGC6diEJnKk0fQ+oHK/CD0Gwu76cKtiadXZMk5hv91mJwqrpyl24iIMvcGg69Kx/PR2F@vger.kernel.org, AJvYcCV/XQIcldxzn75n1g2ZhrBIsKGbDVuk34tPoHY9HqwdcJ7co6pqx8gzkSWyIqUCcyWWmYRq5Ymm6DklS51j@vger.kernel.org, AJvYcCWavijhevpD4db1bwYWYT0Y6fd8g4o/8SWZXpEuZrJYE1lRo1/yC+GdQvTT/W3jiCQ2D0yIvreJYBCa8ASh7nc=@vger.kernel.org, AJvYcCXt2rV7dqna6wVjwdwbjINes7+I2aSKv+zoQKICwV2Rj2e+7qJ+gpdGO57A4oT+qNzZfvTiwC+j37AJjuCR5x0SVugTXTSE@vger.kernel.org
X-Gm-Message-State: AOJu0YxhufVi2D2KgtMQ3JHqysD5nMlXbfd+K47YfKCytqbo5+CnAKuX
	BMMXV2yHjWzHIygpI7ZzTr1ay3Yc7nNPv+FLLIM3SrgYJG/l+NDZ4Pg9tjGYEm+vPxVSigps54H
	VnI2zlFK/pPEGy1y03pxepp18/qU=
X-Google-Smtp-Source: AGHT+IE0n7nBkU4o1TNQuEMarc+ya95A1sUSDNydwshQ7xr6NG+FiQipNnbeBlUVgb/XFESsDzfvJSSQM3IAfYSK1pY=
X-Received: by 2002:a05:6a20:914c:b0:1cf:4c3a:162a with SMTP id
 adf61e73a8af0-1d5db1dd854mr127501637.5.1727797528983; Tue, 01 Oct 2024
 08:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926-pocht-sittlich-87108178c093@brauner> <20241001-brauner-rust-pid_namespace-v2-1-37eac8d93e75@kernel.org>
 <CAH5fLghaj+mjL63vw7DKCMg3NSaqU3qwd0byXKksG65mdOA2bA@mail.gmail.com> <20241001-sowie-zufall-d1e1421ba00f@brauner>
In-Reply-To: <20241001-sowie-zufall-d1e1421ba00f@brauner>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 1 Oct 2024 17:45:15 +0200
Message-ID: <CANiq72nJbmhicsNqZHV9=j_imXPPZWxuHiqr=N4wTDxwGaMW5g@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add PidNamespace
To: Christian Brauner <brauner@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:17=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Ok. Why does it pass the build then? Seems like it should just fail the b=
uild.

It is part of `make rustfmt` / `make rustfmtcheck`.

I would be happy to make it part of the normal build if people agree
-- though it could be annoying in some cases, e.g. iterating small
changes while developing.

If we do that, it would be nice if -next does it too, but I think
Stephen is already building Rust for x86_64 allmodconfig (Cc'd).

Cheers,
Miguel

