Return-Path: <linux-fsdevel+bounces-30058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D440C98579B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F94A1F24F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87265154BFE;
	Wed, 25 Sep 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0qoZkaG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067913212A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262386; cv=none; b=gIqFRr6rpn/XkXkcF/ixNSuhP+34hm9lmxxVPMyebtgaLxl7xcgKDNRB7T/k/eNQr+zmmNYx0sdukXxeXwmw7sGlGmEaO/6NZQII5GsX56q49LkeonZZC6AxnmVHgv5gPGQtHIef1C7QFTOXypmgq/c4sPsdJzFdKX98W98/B1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262386; c=relaxed/simple;
	bh=v9SOENpp+GEqMEfpbzjHUOzd9Uxz8a8eI7GUtlWQs+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTni0YI/EgV8TkiAV7gwNrkNuMxV+aKh6umIebvE7CSb9jHdwskz9MLGSFxcynmcO4plInUx/hAyHJYbKzA/+NsY0lZLezpxAi/Dj6+v3JgSYazoATUjLKIuKDnoIMdZ67wS7XXm+zpPKgS1iqkspJGMEH9G5y9HV7n/4cBOJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0qoZkaG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso84107205e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 04:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727262382; x=1727867182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=Y0qoZkaGAi7LcUT3oJb4NisLSJU/jQJH27zodADr2z0dvPpCGPDg5u7nQ4RIsCYMak
         le/mIhlmqZ8X6+GmN3PP2QMCKp6vbmxzotaBm1Yuw0RXmtw32VA+G7yMyWtf4xmzAhKM
         UcGaIYxfzd8JowKxx+i3zJ6nNRBJXXxEklTgZMxjg+YgF1Z3ofeLDp/41kfNnENqDcCI
         luE4FdlQEo4BAdOUU66phuSQdN3pka/+v/NSGPGVtV4o41NqrBDjLgAdZqbjZXl89pIh
         tYk0Dth2KHO+fllaG9Qs7ETkDZAIAD0pLvwMM632vU9VIipk2b6BElfMGUO2065bcTEx
         X8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727262382; x=1727867182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhQ4TPCHuI58LZ38MBixhcUn27fdFhOzEs54JQFmEu4=;
        b=ZDiPZ7BmNh9iEhV5FHCsInYzy1LFXvmER5RMST/GbJq3+LEiTe3BSbaEeDLvGMAuAC
         obzX/cXWz6nj0tH8GROcExJVt+U0BgQ2GGvRlR0RYCTA8VUOkSn0ycv/Nc5enbtefGHe
         S8xZhUJ7OQEkpJWj2uSeJqKfyQhpLcvTEaI81NWqD3sUqmwVlh4VV0I7kxviIYfFZZSc
         u9N758hekZo01U9wXMh9VDj5WBXRzED52uJFCUwAMYRIOdWsuyyMeRjxYjpuPo6bKqGY
         8nTfdUdk41hf+dbVfvCoYCVrGaXK1ogdb1HEQJXH9n5srd8RTQv9oIE8dXpPytpsJY/2
         PfNw==
X-Forwarded-Encrypted: i=1; AJvYcCXGbmFnpw9GmqPhhdL7lqkm1eHwhObQaiVJReY79Cc3pPjgh+Oyv0QY61YMUu7MJ0jxgtTANaCODNfgG0LY@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+6tgdZzEnBc0pN9YrQAIqD48Qlc1T2lKE2duPsTg0EcP5ip8
	NbxN9CDRxBIqLPXsTxof7V+eJ5wDDx4GcqVSZAjtaygox08et8qopdqy4wHB0ixLJjuSz54HnuR
	hC0sTb2lEWKF9I2CpD95KGtG1HXIcCvYvMH4/
X-Google-Smtp-Source: AGHT+IGFAj+j04oaHOFqsP7FAM4DEPPjCdbCbDCCKy/XEfJz3JFRtsBnFMPeIPy5+2A+yRs/huLSjBw7dGu97fMWSko=
X-Received: by 2002:a5d:5d86:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37cc51b8ee6mr1224327f8f.38.1727262382323; Wed, 25 Sep 2024
 04:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-1-88484f7a3dcf@google.com> <20240924194540.GA636453@mail.hallyn.com>
In-Reply-To: <20240924194540.GA636453@mail.hallyn.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 25 Sep 2024 13:06:10 +0200
Message-ID: <CAH5fLgggtjNAAotBzwRQ4RYQ9+WDom0MRyYFMnQ+E5UXgOc3RQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Tue, Sep 24, 2024 at 9:45=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Sun, Sep 15, 2024 at 02:31:27PM +0000, Alice Ryhl wrote:
> > This introduces a new marker type for types that shouldn't be thread
> > safe. By adding a field of this type to a struct, it becomes non-Send
> > and non-Sync, which means that it cannot be accessed in any way from
> > threads other than the one it was created on.
> >
> > This is useful for APIs that require globals such as `current` to remai=
n
> > constant while the value exists.
> >
> > We update two existing users in the Kernel to use this helper:
> >
> >  * `Task::current()` - moving the return type of this value to a
> >    different thread would not be safe as you can no longer be guarantee=
d
> >    that the `current` pointer remains valid.
> >  * Lock guards. Mutexes and spinlocks should be unlocked on the same
> >    thread as where they were locked, so we enforce this using the Send
> >    trait.
>
> Hi,
>
> this sounds useful, however from kernel side when I think thread-safe,
> I think must not be used across a sleep.  Would something like ThreadLock=
ed
> or LockedToThread make sense?

Hmm, those names seem pretty similar to the current name to me?

Alice

