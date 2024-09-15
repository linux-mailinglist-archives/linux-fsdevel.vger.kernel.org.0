Return-Path: <linux-fsdevel+bounces-29417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005797991C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 23:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43358B20150
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9271B3A;
	Sun, 15 Sep 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHY4Pwzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5102C853
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434456; cv=none; b=IwyMQ6XjPfKs2ANr7icoQiTWepjSAnvxXwGf94zBPhLJsTlo8NzTU3sBIYYrS7MXXbVyj0BrQgkjYuqM9zN+UW8+2cB6zzd7pTpqq5CZZgOr6/BHS1xbMhrrUxV4TENtb+Gw8BaHN5NpTdAQcRPWsrIaq8r+BnCEwEr4g51HbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434456; c=relaxed/simple;
	bh=u0mauue4pFbpJvPlGNnG8KmtJCv5osrYKUh15cf2xQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl2sTeyJ2d9Tl/MFTcl0U8q+jWI0jZ+XA+5vIafb7Xhj1ncICXpahhNjq6bEeBvyMHTdFmOhSGXGaZYaa/WmSNBbzD/47dTbObhdMGgtSjbB7V4tInFfuT3bL+D+SC85FfposOLpCklKwdHChbe6rd2gqo2JTIt2dYqEfqY5Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHY4Pwzq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2294005f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726434451; x=1727039251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMSCaCClJjZ0q/vopdrKwBeXnkKAsPzQyB/3kJTnFhk=;
        b=MHY4Pwzqh5CGlH4wC/IS77bKhiHWywWFmRUFNuzLfK2rzG7Kqgi7VQMs5Gew/tQ9PZ
         RGfaDvvMg9OmGHo5mkpIZU3YfFTcOrrZbVH/XsseHfMpUTyO8vYXBzGSYyU3Hm/BYEJs
         KYT5dqzf3twXemIzQWuG3YzWmMEvknhYadBkUYmj9FV6RU5E/EvUNuDDwHeYXRzrLLzl
         washlT17OTkQnEkEl8+8lZmob7wU+TPq0bhhnpKzFGsUxYNgP0SCN8OxFfiP7C8ifuDk
         zGSVV4x8rS80PF0Xa18SO69HK6vCOYyaX8hFhZUgIxsAHDjUzsvYsaKZFptHtvpa/Mtg
         EATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726434451; x=1727039251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMSCaCClJjZ0q/vopdrKwBeXnkKAsPzQyB/3kJTnFhk=;
        b=HhIGxvxV1muWzMivgqaj2uPh2lAIirip3ww8Z2CJUoieQ9Pb5swcsozTBrnuDPbHdN
         7RTo5fkbiv37Rjhdin8qpRrruePUQ04DMNuDUQ7gN6TW2iOEMoG2r+//86QtGstt/j+Q
         g9qriBCVH17AlN+LHpq9kJ2ePw/bWrtu01euN6E3KctCkx7bB6Zl++PLkBEMngp0P8BN
         1i0YurqxOR/obvEiNEGvKbBkHIBp5FqDTn4eEXTLvkOpUm9CleMxNEcmT2/5Ij5RmNXR
         w2EBpUOk/DIOyCeUlRMzpffRXmsKsv25EPrKhrUEZ43J1MAWRhkQ/bbUHHZswz6+rNWE
         d93w==
X-Forwarded-Encrypted: i=1; AJvYcCWX2SxfyCUhJJGoBlBx15Ga9bYuLFaiDdpklBzrZ40EgkwaFvFg60XJiHhvLrxzFFHcfhMRQcykNp6Dsotx@vger.kernel.org
X-Gm-Message-State: AOJu0YyCNz7sRFwg2/n36lWN5b++NOj6qSoVJljINA7qtAjCUOXzx4QH
	f8xCZxjqGV3vTTdC97niDg5/n6N7w8f92fVkLH6CeScKLWzQ48z9Oqq4v18/oo2vuzGvv2qHWcd
	qWt9kLAdwKB/azntFIU6heKtLAS1Ot3+s+5Fa
X-Google-Smtp-Source: AGHT+IHHL9ci38l3QyRKB9ijCz+Na//ffly7AGZW2nAho4rRP9TW1RbmkTpcC/P3ssAUOSVor4hTQsXWMTlb9HHx0V4=
X-Received: by 2002:a5d:4983:0:b0:374:c1f9:ea79 with SMTP id
 ffacd0b85a97d-378c2cd5e5fmr7840237f8f.5.1726434451067; Sun, 15 Sep 2024
 14:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com> <202409151325.09E4F3C2F@keescook>
In-Reply-To: <202409151325.09E4F3C2F@keescook>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 15 Sep 2024 23:07:19 +0200
Message-ID: <CAH5fLghA0tLTwCDBRrm+GAEWhhY7Y8qLtpj0wwcvTK_ZRZVgBw@mail.gmail.com>
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 10:58=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> > Add an abstraction for viewing the string representation of a security
> > context.
>
> Hm, this may collide with "LSM: Move away from secids" is going to happen=
.
> https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.com=
/
>
> This series is not yet landed, but in the future, the API changes should
> be something like this, though the "lsmblob" name is likely to change to
> "lsmprop"?
> security_cred_getsecid()   -> security_cred_getlsmblob()
> security_secid_to_secctx() -> security_lsmblob_to_secctx()

Thanks for the heads up. I'll make sure to look into how this
interacts with those changes.

> > This is needed by Rust Binder because it has a feature where a process
> > can view the string representation of the security context for incoming
> > transactions. The process can use that to authenticate incoming
> > transactions, and since the feature is provided by the kernel, the
> > process can trust that the security context is legitimate.
> >
> > This abstraction makes the following assumptions about the C side:
> > * When a call to `security_secid_to_secctx` is successful, it returns a
> >   pointer and length. The pointer references a byte string and is valid
> >   for reading for that many bytes.
>
> Yes. (len includes trailing C-String NUL character.)

I suppose the NUL character implies that this API always returns a
non-zero length? I could simplify the patch a little bit by not
handling empty strings.

It looks like the CONFIG_SECURITY=3Dn case returns -EOPNOTSUPP, so we
don't get an empty string from that case, at least.

> > * The string may be referenced until `security_release_secctx` is
> >   called.
>
> Yes.
>
> > * If CONFIG_SECURITY is set, then the three methods mentioned in
> >   rust/helpers are available without a helper. (That is, they are not a
> >   #define or `static inline`.)
>
> Yes.
>
> >
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Reviewed-by: Trevor Gross <tmgross@umich.edu>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks for the review!

Alice

