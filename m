Return-Path: <linux-fsdevel+bounces-28261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBB9689AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FB228498F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AD200114;
	Mon,  2 Sep 2024 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miNkKwNd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1519E983
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286626; cv=none; b=BVMZiU6gZAv5T9vS4wt0BExFwx8/gchHluHrstUoCnRgUOIaWurXmMyTRJ03mB8p3DxkwKVSza9qbDgXPX+pwm0iaK1eM29ocpnFdRo1oqObvRMR73KUeHXgIWijiERsTUPipGQ5rCZBWHsEhMWbw9Rd8VBrg5khQPRf//YAnKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286626; c=relaxed/simple;
	bh=vh2QgxSX2L75UOqalaQcbV73L5PLbsUphxMNDQ2BtJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVkmg2wxXkw0qbr3lgu7FjIE1Buz8usUkV2JC9STeu5PkJgP8aq7S9u6J170PUzS/8iYC85hh9ZdBef2J5mCyJlYTmkEHSS5HRgPOJV0wLGWk44OeTHpnOpDuFDrC7x6tYMd6N+Qzwcj4smIAOGaGyAIAPOEqTR4UcSYNYsi9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miNkKwNd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bb8c6e250so32641465e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Sep 2024 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725286622; x=1725891422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nZ+9fn7BwVDUG445G81+75wyZkpZMEfiuxhieME3PM=;
        b=miNkKwNdeWS4tpogmKrBjbky7evnbuusOAVqBFv5H0ON4npDnYvHnvTLNxlePMq+bl
         zQ3XwfiJ4QNcoVYKR+FtuicLJM8qCRdEtViJHzTFo17JvfXQ5VcfLQnCF8yh9LVZv4xm
         EvY7UkSTaMbTUmC2k1Ynlas9dWiYgWt0HnFuX2KfdSTvFbxJwA/X4j6Zhmr5NCQvj8zH
         eo8AAQIFys7OF0m1rYkVBMW71E+RZqOq1ZooFgdotdjtCch4wWlmWkZreRAVYOQeViSx
         FD206ABBeYdg7TMllW41z7ocWEIBR+CyNYJb2esN+tspWJikjNYdksJc01pEuBWZ9nzI
         4Qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725286622; x=1725891422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nZ+9fn7BwVDUG445G81+75wyZkpZMEfiuxhieME3PM=;
        b=cyJ0cIHQnLBgcH/UBv0Sao+NIQJZ/6Qyzg+yx4zOgWAX6jjImR1Dc54nqSeveIV7KW
         1kiSXT912EM6QTdL/iT4VCBNQrImt4P1SIBBmDLbNWiQgdIIG7YYuqi9wjUrMnCOs1xT
         9lB2712TJjuP1APwM1NVoVlBgSNSTzO/yBVcSCdZjCSNdBul4oggJKGONp5F8ZggMhpj
         K91wzBzXzQ5LaoqV+lud9Xuq3Tm61PzTc0HS3nhpc0X7ApBJikA0ejfZ5gBj43Y5CWbH
         IaT4t/NEmF5ezSySd3O+bSAymngT7wLDuSPGkNkqrodhB9W+oJakWZqtMyipayCIMpQZ
         0yqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhoiQEZihpA93p7KUqgwJfyhBHSe4TSjjlXx46MitSE2sNaWRCn6h6DNKveaTvb+22I1MM6VCWeCdOmmd6@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyfSQasHqKNUk7OOFS2+k+tS0R7EtgRb/87Jc0enjMBbADZ7+
	7cZ1xZtMiHqkSwwoOcD72yiLGVL6teP4bqRoCQ2NstuEQuFfbqpy7ixzE+xNEm7uIKWE743fiCu
	uD0R76kObLoFTE/wdAxkYkM4qrTscQy7Zsjw+
X-Google-Smtp-Source: AGHT+IGTiHL3dLiYbM7/qkPUXctMrWRqR8rS7ipP+OnuURlbIUWlRU6s9EcTEKznODPu2Frc6lmN7cFFpOek3NTUuYc=
X-Received: by 2002:a05:600c:46c6:b0:426:4978:65f0 with SMTP id
 5b1f17b1804b1-42c82f56727mr29036395e9.18.1725286622239; Mon, 02 Sep 2024
 07:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com> <20240902-dickdarm-zumeist-3858e57fb425@brauner>
In-Reply-To: <20240902-dickdarm-zumeist-3858e57fb425@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 2 Sep 2024 16:16:49 +0200
Message-ID: <CAH5fLgjho1p7EHkqpot4pXvrKLFkXLsw9MWcriNCOHXZ0NJ5bw@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] File abstractions needed by Rust Binder
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
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
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 10:02=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Aug 08, 2024 at 04:15:43PM GMT, Alice Ryhl wrote:
> > This patchset contains the file abstractions needed by the Rust
> > implementation of the Binder driver.
> >
> > Please see the Rust Binder RFC for usage examples:
> > https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba91=
97f637@google.com/
> >
> > Users of "rust: types: add `NotThreadSafe`":
> >       [PATCH 5/9] rust: file: add `FileDescriptorReservation`
> >
> > Users of "rust: task: add `Task::current_raw`":
> >       [PATCH 7/9] rust: file: add `Kuid` wrapper
> >       [PATCH 8/9] rust: file: add `DeferredFdCloser`
> >
> > Users of "rust: file: add Rust abstraction for `struct file`":
> >       [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binde=
r
> >       [PATCH RFC 03/20] rust_binder: add threading support
> >
> > Users of "rust: cred: add Rust abstraction for `struct cred`":
> >       [PATCH RFC 05/20] rust_binder: add nodes and context managers
> >       [PATCH RFC 06/20] rust_binder: add oneway transactions
> >       [PATCH RFC 11/20] rust_binder: send nodes in transaction
> >       [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> >
> > Users of "rust: security: add abstraction for secctx":
> >       [PATCH RFC 06/20] rust_binder: add oneway transactions
> >
> > Users of "rust: file: add `FileDescriptorReservation`":
> >       [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> >       [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> >
> > Users of "rust: file: add `Kuid` wrapper":
> >       [PATCH RFC 05/20] rust_binder: add nodes and context managers
> >       [PATCH RFC 06/20] rust_binder: add oneway transactions
> >
> > Users of "rust: file: add abstraction for `poll_table`":
> >       [PATCH RFC 07/20] rust_binder: add epoll support
> >
> > This patchset has some uses of read_volatile in place of READ_ONCE.
> > Please see the following rfc for context on this:
> > https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.c=
om/
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
>
> So, this won't make v6.12 anymore. There already were pretty big changes
> around files for the coming cycle so I did not also want to throw this
> into the mix as well. (Sorry that this had to miss it's birthday, Alice.)

This has also gained a conflict with the helpers split [1] in
rust-next, so maybe that is for the best.

I will look into whether any other changes are needed given what is
going in for 6.12 and send a new version. It looks like you already
added it to an vfs.rust.file branch, and it doesn't look like anything
in vfs.file required changes in this series.

[1]: https://lore.kernel.org/r/20240815103016.2771842-1-nmi@metaspace.dk

> However, I do intend to merge a version for this for v6.13. There's some
> wrapping of struct cred and specifically of struct secctx that I can
> only handwave at. Ideally you get a nod from the LSM maintainers as well
> but if that doesn't come in I don't see much point in making this sit in
> limbo indefinitely.

Okay thanks! I can look into that.

Alice

