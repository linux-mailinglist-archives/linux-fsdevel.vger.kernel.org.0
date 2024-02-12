Return-Path: <linux-fsdevel+bounces-11098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B720851049
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4821C21D4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 10:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2E517C70;
	Mon, 12 Feb 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC1o0ssq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9417BBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732300; cv=none; b=eJ8FzdD6TUnyTCpu1pyxmPku8bNJCRADsyMdMOG8h/AdxvP760iFAnEyevqrN1tLkfUFlNTU+5JEMMLEVKBonSQB/GSyL6eG4iUepjtfBuVL/ZHkgc1Yhw1j5Fat1Oh44VKhbEHxL5Ip4cx7D2IcGL/h9UkfgWnV5UjRKMrUr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732300; c=relaxed/simple;
	bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4IFhUAgYO0ORUkWzQYRJsHTvXbjCinoFgMGFd3WiqRVLIBLak9hIXk17Ggx1R7jaRz3+8M+JY9ea/utN9nVdkByafMzYrUZqvqMHQ12d12h+onnYim8WPoKY1jmgdnyNoGpSSHqiKyP+kqh481WJATdkC2nmtbW93cbtc1wPVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC1o0ssq; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so1735964241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707732298; x=1708337098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
        b=iC1o0ssqIXRXXD8GfJHqXimLiw/iVWyakgdgApwtkSjSLJSZuDxmYqDVFaROpR6znS
         c9I+mwoUjARm+lO5dGG9ROKrZveRQXbxhPByIlnitJSC+nhrWs2lrhpwkpY7lqi2fqfb
         XDsODwFuZH+2GbaSbSmHiad95ciCHNekTm7rWhduAhcTxhPlK+zHLcDqGeCYgDFYgQjZ
         b321VahMNBNj65aiJxr5Hr6K/pi2SIV9bnFgqDjI9DoDe6faOrXczdkgeTo/3LxgwRNq
         NaFH5ASoeVqVYicvLcpB6zKfzJutUwT1Zd0UWXaWYGY3kky9ap6WNwUhWo705sBrzJQ1
         QmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707732298; x=1708337098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggduzU9L1RUTLLiPLM4EOtwsbNI4tWctUrmL552s1jo=;
        b=dWJVK+ZCusVTtdwE1MZFRa6H/qmgyZjyG0W2rUHDe7R2ZNmcpoy20vojCFEyH9eqyS
         4UbrFmSoFAiqK2FJ7ggS0xJpz7YbXw/9/j1WdSnaA7vSDoyNVkFd7YCa/6fA3KjgcqD4
         RsNWsn0VI8qsJnl2Lfd9Z2J2khLhrFjjV1A5cIE9D9I9xF3EZ6TtIbts+uEvaR3BWpFw
         knhrIbd8g7NLa92Zs1hRk2PP3dKT1CjBL6msAnBSjmN8dJew7b5NGpLfYq08e3bMjSwL
         hHgl8SmjGza+pDFprIa8YQcjmQ7BsLxRWA1ECiiGGATyp40Fo8DM6hfr/H2InAD44qKo
         Fv/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEXgfeUCGAxJ5EEuK7yiMB45qyN8xUuGxETWdhdwDmi0E4Nh/8eXCg2SSrMRdM/xYr/fGyeHnB3R0r7JsHrXDQTglqERLCp9X0KJ+XRw==
X-Gm-Message-State: AOJu0YwEd81dvy7e+lZh3a6lqaEdLXoToy7JCs5IVZFlIpZY8K6yb0aD
	/+pgLNEJf9wHdX4mSTokv8eqqOv8JsK7VufRm92ByIfPMWFh0AzFd9VHJntKrmOG7hFl+PXPeFj
	XcArAlpERLBgYPOV05sKJ4fLJoTo9fhXwGI9V
X-Google-Smtp-Source: AGHT+IEd49py4OLNX4mf5CeRvn2sftXgoKqJgVKe0kGtx19XgPRbHY6OUXT+lpg/lNJ+Ows2+YxSA63IQJz7omMeAsc=
X-Received: by 2002:a05:6102:2a59:b0:46d:61e8:46a with SMTP id
 gt25-20020a0561022a5900b0046d61e8046amr3708124vsb.28.1707732297773; Mon, 12
 Feb 2024 02:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-7-a37886783025@google.com> <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
In-Reply-To: <CALNs47tTTbWL3T9rk_ismPT0Bwi8Kcm5aT9k8jfPsh=1wKvrPA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 12 Feb 2024 11:04:47 +0100
Message-ID: <CAH5fLgj8u925_5qW3n7OBd3tPxxdy4=BR=yWvzhyLN6TT6M+dQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] rust: file: add `Kuid` wrapper
To: Trevor Gross <tmgross@umich.edu>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 8:43=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> On Fri, Feb 9, 2024 at 5:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > Of course, once a wrapper for rcu_read_lock is available, it is
> > preferable to use that over either of the two above approaches.
>
> Is this worth a FIXME?

Shrug. I think a patch to introduce rcu_read_lock would go through the
helpers as a matter of course either way. But it also doesn't hurt.

Alice

