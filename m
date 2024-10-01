Return-Path: <linux-fsdevel+bounces-30462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E4798B80F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7A91F230F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CF419D894;
	Tue,  1 Oct 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWpspQiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4001519D09C
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773996; cv=none; b=kC+xEYE53WR24B65OIfeTVnAps8zu4ZFXP6UkfnkORq805zqpXJa0iELJC304gHUhQfNo4HCHXrVKyLa8IhcNUYR9r3E4O+Lv5zOG9rkgMWy6YGTUGr3HwuOThqDS7pvRKYkLmkafxu2zsv3KDW1zXw8ssTfvTu9PZM6jHRJQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773996; c=relaxed/simple;
	bh=icegb0pL2qbdDUASsVDPbVE5YcWxzi60TMK9YewrNjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avkIz8m8RDIZ8zjjPIRDuhHhzN09brJJTtlmQVxV/9IU+UvMX8YEJBM0ZwzD02UBcMHeRHHa3skDAnDDfIJ1OQa2duzjc8bzPh4Jzx456jY1PqnX5OW3Whwzklj3/QWE0EvkRfcFBWItdVTyMNgjcMh45/3uM/s8swoq9Tr4kXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PWpspQiS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso3577384f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727773993; x=1728378793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9fBdWWDj6fOst+uTdJOT76rvj+EDLa+s01mSNdgJp0=;
        b=PWpspQiSRg50gToc6umua05afvlx/n2ly/LH0bGA9bIoFb6MycaV6jLBwb92sDIHVi
         fZGyPZtpKy87T4Mx7wVv17eRXfneAq4V6cemXbTuHBShcoeRkyH5E0pBQKPn3JprMk1s
         tCPwYfNyKd8SBOX8hDGIAF2yZ8M+SawF6eS41H3Jbnp29ieBG3nUPWFS5l09V+2RAMzf
         K3Nt2GX4OUbZdbp8BDbet6UjsdXb5/XbwD/Rkaq540C+rgBa4G58j2T9MqxojGgKNdaQ
         WdM4QWuuqT2eGnD2Gi2n0n5uyBLaUWSaYMlGA5o+DM30BctIvN9N8hn7kPcSBeYtsGWq
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773993; x=1728378793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9fBdWWDj6fOst+uTdJOT76rvj+EDLa+s01mSNdgJp0=;
        b=lz9NoEsfqTe48JyCELkSD3sty3xaL8awUwL84yKE0uiANLRJ7n58qLZQCa3+h4ohJR
         4vf6fjAjnYHqoZ333Fu2wzPX/8SsjyyF2zhE5RTMHlG7RZFEBd38DYZQ3EotnJwWO6mY
         sde/04U7BTTA9UmvZJdPnpDisfKHBBY9FjUyDXeEF+BPIyQ7Mz5WYQqP+GZCgSPzpQ0G
         a6F3YvPK0A1gKOd6g6JtUwJ67C3eSKwLB8WVQNC5uyGm9f2g1juT54hOJ1Y2UC5jviKU
         fSyyoBA/BPy50MKgBmWAjkp1qMABq6X7K0FPd58H23xgzpTuom67IqXRaRFzoXGZP3Hd
         ig2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyFWNHFsQTkPOr9I3d/ieKMLAI8OChLfoua5BCQw9B7nFnKJmJvxwJ+z/BeGFcftGESJKgV3qZm33AJ+xe@vger.kernel.org
X-Gm-Message-State: AOJu0YznJ8r6jXpjEkYEA+cSES0/n650v7LOu1dktuVgEa3ckzEMP5rO
	feNlkjy/d8oLgcc+nafSRMPbo+NqVAKwW/93EUKpT+amzXPt81hE+24CgA5xzWK0zpAjIF6lzTG
	jnuPRj338MvTVb+cN7AANh3ImQki1xCJRkuOA
X-Google-Smtp-Source: AGHT+IFgU7zCWKFIxKy1DfT3m8rNSOqxhergloVQ6Xgu0kb9+slgAkmLbC7op6hq7zmCb+3at5j3LcLeTtFhS60Ms4E=
X-Received: by 2002:adf:f08c:0:b0:374:c1d6:f57f with SMTP id
 ffacd0b85a97d-37cd5a606a0mr7144966f8f.7.1727773993290; Tue, 01 Oct 2024
 02:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com>
 <20241001-b4-miscdevice-v2-2-330d760041fa@google.com> <755a5049-d6ca-41de-ba49-16bda7822fe7@de.bosch.com>
In-Reply-To: <755a5049-d6ca-41de-ba49-16bda7822fe7@de.bosch.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 11:13:01 +0200
Message-ID: <CAH5fLgj+KtgZWx8XxCLPCera4VaqfdyUucpj9HthFViq6_Df9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:54=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.com=
> wrote:
>
> On 01.10.2024 10:22, Alice Ryhl wrote:
> ....
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > new file mode 100644
> > index 000000000000..cbd5249b5b45
> > --- /dev/null
> > +++ b/rust/kernel/miscdevice.rs
> ...
> > +/// Trait implemented by the private data of an open misc device.
> > +#[vtable]
> > +pub trait MiscDevice {
> > +    /// What kind of pointer should `Self` be wrapped in.
> > +    type Ptr: ForeignOwnable + Send + Sync;
> > +
> > +    /// Called when the misc device is opened.
> > +    ///
> > +    /// The returned pointer will be stored as the private data for th=
e file.
> > +    fn open() -> Result<Self::Ptr>;
> > +
> > +    /// Called when the misc device is released.
> > +    fn release(device: Self::Ptr) {
> > +        drop(device);
> > +    }
> > +
> > +    /// Handler for ioctls.
> > +    ///
> > +    /// The `cmd` argument is usually manipulated using the utilties i=
n [`kernel::ioctl`].
>
> Nit: utilties -> utilities

Thanks!

Alice

