Return-Path: <linux-fsdevel+bounces-10941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8C84F4D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036DE1F258D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE152EAE5;
	Fri,  9 Feb 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="00YtOFe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C312E633
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479365; cv=none; b=M6aVb5GpxJ9eF4SwUTO+o8NYEnIAuJWdSgjHC588nXZpHS7KDEXQLZm5tA57wfihO8gGLeaZqZc2FrXmQlwQ8WFGg16Rsn2EgcMEQY+mtg+AaxTanIq2S8iXweUljOaLPnRzvBBL3rGTjtxc+aXFBNHAK4vNKiO8q+r2wIJHbXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479365; c=relaxed/simple;
	bh=yhanlhyHf9vUwAPCSVHqqZzMUqMS696JtJ0CS6AX8Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laXWQYkVaTk+95yD+D5SuCPV3D9XdHPmnpslDbAfq1Bzr1t1rlPNdiTkzo9uyQmHo6Ut9w80/FjLl0rLUIPY2YixjZQZMoT7aG15lhGQecNKs2LAwMmCVFAqxaeOcK516KlfyylRQWFWg6ttddysm1SHxukzQ4KFdaVGUbtKI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=00YtOFe9; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c01ac04569so325289e0c.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707479359; x=1708084159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l++3fpOv/6kAkEAKZFY83iwVJR4LI0xsh9dQ+P6yYAk=;
        b=00YtOFe9KCUPwTrp7V68TNfnALSahkWowasBb6FIEJKxH5jML9I1ydKl6G8Qzhfmnz
         2hKmrwW1shDPz6lzFxNTcrh9/MxB/wKKWhU6pd6Pyi3+YUXoXvSllWY6n0Ed2z5PhBry
         fIi0DQ7LgFWeHrI+HB1iDwITmT9QpflKmLnTQqK3EX2DKxA4AhrF+bLFdSVUQwouVdEI
         C8cF95SWS5ws6F7z3H1ItI5VPwZdcaVnyoi/g8mk6sxnuMX6mdq01g7emyp5/UUgieH6
         678sTlROwjfcV62eqZCbsURIPTlCfn7R04R5kqMo4Nyk/1tkuQyM2KWYbzokW7S8CbtQ
         OQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707479359; x=1708084159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l++3fpOv/6kAkEAKZFY83iwVJR4LI0xsh9dQ+P6yYAk=;
        b=GSrQPkzYJRK6GE+uWeeKJrO4B1uPfgPq+30clG2ZCv0uH3SqhtRIU+2SNkRQr/5a3B
         0Ua4BR5IwhXz6Acl0caRQhBGgCxDdeBWHGtYMFrrT8J1mldi9nkyLGnveS2TmdUJM2i7
         08kCPQKFMY/3FuF/2m7LnuZxikwSf81wUMedaPy+mfQwEMv/CQRryzXmqw/4AR3TIWP3
         PuZWNr8+7sCEShOVTVAQM6wl2bXx4U31vvu4KZ/dSE43FQ8Rq2+SlWk/71BJmo0jFNHq
         zYFOA0zY24ojjQsLb/uG/m/gAmB0/MJ2WR7TtX6gbnZy/Mo7Wy39V413YiaHTtq0h8U1
         NRSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVryUDZpCMmClMGO1ck72LvoN4QNvBSThI9DnBTN1Ep96ScMeXAMF2eN3S4IyxQWo6MBF9xybcUrH4R3VwAMufPqjnykAoeaTvZffWl8A==
X-Gm-Message-State: AOJu0Yzsx9S9YW5iZNcdH8rBLSxP2OyV4IVQnu1xKhePh/ppmZATRNgx
	Bh9m48qwHo5xOPnOjhYNNd6o204PROf5NUZUZJWKgUXXpa+Ei8MYmA0NFFhkLWFdWXZBhgqGrK6
	hjQdU19ne3aRfgYKAF2RTfrOtHRi5HWr2bnWb
X-Google-Smtp-Source: AGHT+IGeozrhqlsnoi4sKjmwc1iTJHC3DWdheQh5u+tCcxJb1BYvfzzbx2OvfKUcWmt/yMinTt/VeLkRIu4BWCWdkl4=
X-Received: by 2002:a1f:ec01:0:b0:4c0:2ada:2f19 with SMTP id
 k1-20020a1fec01000000b004c02ada2f19mr1210515vkh.15.1707479358796; Fri, 09 Feb
 2024 03:49:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-1-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-1-a37886783025@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Feb 2024 12:49:07 +0100
Message-ID: <CAH5fLgiFzPcOH95tw9MwJmgfgBzE+rWxhk0050OTYmqgprPn5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] rust: types: add `NotThreadSafe`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 12:18=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> +    types::{NotThreadSafe, ScopeGuard, Opaque},

Oops. This one doesn't pass rustfmt. Embarrassing.

I was hoping that this would be the last version. Maybe Miguel can fix
the ordering here when he takes it? (Assuming I don't need to send a
v6.)

It's supposed to be:
types::{NotThreadSafe, Opaque, ScopeGuard},

There shouldn't be any other issues in this patchset.

Alice

