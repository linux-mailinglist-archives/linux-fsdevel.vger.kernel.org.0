Return-Path: <linux-fsdevel+bounces-30489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A694798BB08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2881C232D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFA1BFE01;
	Tue,  1 Oct 2024 11:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adaidGRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3C1BFDF4
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782150; cv=none; b=VbpjRx2Yknlkf9M5AnSEHkZPgaBB5vDd1o1OPJOw0wuWTZs5L59k8lTLol58yyGkc6WriOljid2TFMRf5zqHTZYlyqoWycD5Z7bgodmq7v8C6SaDVa7lCEHiiudlhSA4dAy3HofPCcbJNEL9+HItYxZ2rjsmKl+P33NF8fC9dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782150; c=relaxed/simple;
	bh=wRYe1vcQI0lZ4YwSx4XKpg3rYqAFEJunm9v7pgh1H1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti3CN1RnWjJKRwa5vUf+j4QgGERaQ2LtHbiii0NR1guB4nubL2EUDG8jqM7TYHMABoglX/kEwx032WnvppzSo8hExpE4YZzhiC6Fs2R+YXRVvWhPZW4K1rCfdplryPpc+pkdffV+g/6/sjJPsZczjLtRqXXKS4JZL7Xb8J5O1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adaidGRe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ccd50faafso3480304f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727782147; x=1728386947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0EGqao/z/3uTPQ94VdscyZy2iIMPcbVgjbB5vcmiAM=;
        b=adaidGReAMjv7H+AYMtEOGAOHxoiIgw7QQZ/eKSOTS7vYtqAECZfnWBAb/DFkAQrjG
         F2vEgnsC5R8VjAO5m5ttTytaPM1quKVO857VCyX7GmOsH31GS1kD9L+A6hTuauRYN/DH
         Jyp62jAjEfKt74PB4blJtCyxNzLFHiRb5f46P/QTg9k5WgmbZKtnnyaC1SqHwM6e1oUX
         nNmVjr5hkuHJLOkXUYhNIxN81iUHzBuSCsQoW3o0Gvk2jRqglISsd+C/iWZNWdrOt2jB
         5/00aD9cVV2H7v9m78cp3SG3gYFQOfo6lBTTAxEsCF38EaezACk9YwuJ3bJAUTi4h6NR
         Nu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727782147; x=1728386947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0EGqao/z/3uTPQ94VdscyZy2iIMPcbVgjbB5vcmiAM=;
        b=WJPoWdDQgYYVPDQ+QHXT7FmZ9CXbiFwILlUUW5syn/wgRUlI+EVqipImjMFxKgzpad
         z6Bcw21Q52P7Y49kYPZ9FgwtlN2FdbiF6e4RNzPM8zfL1OyckQaIcZivFmrKbzk5B/aJ
         Y8DuIdswg2Y5YeJKZIJzzK05ilXQtTER9a42HQ+gIR9w7SM6Y0x4n9ooSpF+jN5s/kKS
         xnwA7ShYXxmh9bgboGRbWFfi6atd63IuBRjg3qVqp1uUXHke2Ie9DkcFS4gQ0TwrLawq
         GAIPiIfwnHnzHimKd0GBC2bPpHXUDSupcBDWQk46AAVWKjDUzrllgV4yuzzVCiUELbiQ
         zSyA==
X-Forwarded-Encrypted: i=1; AJvYcCWjgmmUgVUnWbx11+8aBuZRaImypmsGaDtWolCgtHInqe7RBbag6unkFr3TuyXFHA/VcjxM8RBKev0uQDA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2JRhcNWS1onzArGJoitENbF/O9+w5I4KZ+H+5DyBo4oPZ0nNg
	ZVb78OSbyKUwd27Wx3X2oDsSZfrvQf152+yznSwwylMeAwVNjZb+x+nfxLvu332dPIkneb8jTzv
	yXu+ancOAAo3QobBY3zn6evu33ynHwdGi26j9
X-Google-Smtp-Source: AGHT+IHdJuezNC+cQOgCWdRYkNZbxrqMXbT01e/SnhIAXkrXy+UEqZN+0xO+ze21oJFFoxqcCO/UzF62jVvVTatBwGI=
X-Received: by 2002:adf:e709:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37cd5b3cc45mr8866453f8f.59.1727782147358; Tue, 01 Oct 2024
 04:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-b4-miscdevice-v2-0-330d760041fa@google.com> <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
In-Reply-To: <20241001-b4-miscdevice-v2-2-330d760041fa@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 13:28:53 +0200
Message-ID: <CAH5fLgjCA77nAYqZLus7TWbW7mOKC1MKn+jJL-_tpQSR-h-r8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: add base miscdevice abstraction
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +impl<T: MiscDevice> MiscDeviceRegistration<T> {
> +    /// Register a misc device.
> +    pub fn register(opts: MiscDeviceOptions) -> impl PinInit<Self, Error=
> {
> +        try_pin_init!(Self {
> +            inner <- Opaque::try_ffi_init(move |slot: *mut bindings::mis=
cdevice| {
> +                // SAFETY: The initializer can write to the provided `sl=
ot`.
> +                unsafe { slot.write(opts.into_raw::<T>()) };
> +
> +                // SAFETY: We just wrote the misc device options to the =
slot. The miscdevice will
> +                // get unregistered before `slot` is deallocated because=
 the memory is pinned and
> +                // the destructor of this type deallocates the memory.
> +                // INVARIANT: If this returns `Ok(())`, then the `slot` =
will contain a registered
> +                // misc device.
> +                to_result(unsafe { bindings::misc_register(slot) })
> +            }),
> +            _t: PhantomData,
> +        })
> +    }

Note that right now this can only be used in the module init function
if the registration is stored in a pinned box. We need the in-place
initialization change to fix that.

Does anyone want to revive the in-place initialization patch?

Link: https://lore.kernel.org/rust-for-linux/20240328195457.225001-1-wedson=
af@gmail.com/

Alice

