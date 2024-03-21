Return-Path: <linux-fsdevel+bounces-14972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6598859F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906261F21960
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92584A50;
	Thu, 21 Mar 2024 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7Bh47gm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D083CCE
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027709; cv=none; b=Gi7WjCj7RFrknEsZyCE15EbUaii8ZBNk1SlSLMBBm/uMTq974lOuhmeYADLsGOLhP7kYVDkcLMGqqUPIhqriKwoUjCpod3MTot0OFuybrSbsfDcqnOvZ6PxcbE07Cdsbva/Wdo1waZcZNsOBqx0zN2hsA1/iddb0UKBybLp1LDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027709; c=relaxed/simple;
	bh=Fq8KLFQJSw1OvZB7PQpHngU+2ITGmNUv3F3KHyGJK8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHQBHtbPPXFGH7GHJkukrZlrxMtwZvJ1AAcJCHmI8mufyIdI25v7fu3rgDXYNIg958uJwD03VUzSwHEHyHzSD0u6UoWFNO2BrBQyIb1zgGYcdcxSY5KEjIWdg0SdO4QHFHYQWgv132CFQH6CFbm9jmIeHYt7LLZf/D2RcPN3dMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7Bh47gm; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-476025fde0aso320159137.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711027706; x=1711632506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWH+6eW0sGOMBcqq3GR/+5MQ85rnPGezuZLizVnSsrs=;
        b=S7Bh47gmFs7ZNPFCC1HtGc//w3tte6KUhETVhV1mXSi+p6SM7wAeHXGOm4s+iUmYZQ
         E0qfXt4LDO1ZHd3tkQb27pltMOxjJLtBgsbhgXRvm3OeXDZqlhf2/vfTkzfqEJ8kFozL
         KOpBVxR2K8n1G48KLUuWzEqa5lJKfFtkZ1FeM359E7orsTsxBTUwbHtBIG3frbL+QD83
         58FusM2sYlqZ+vbK7ShNAc9bzAvx4JA3+u5TR6ozPm7BadfQhsfm/z41qcvysxRQ0jpb
         R5aTZbRrDFyPipWnyibVV/G/a8En3MGb53+y4xC+Gl/KqhRuIyZ7SLIx1Tq9/0oVfrNA
         52Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711027706; x=1711632506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWH+6eW0sGOMBcqq3GR/+5MQ85rnPGezuZLizVnSsrs=;
        b=nGHJWLQDxlw4mOIV9U14If0N0TU75rRTkYRaVShmt25H6XGO70WOk1HjUVJ6Zny3jG
         3+uId6WUAyazYBOgDisUG00rpKVSwe6fsAD2INRhBStLCajZAmGBcOOpBwf3RqlkgRNu
         aFLGGPLjxVESpVFvuaa15hgIFn4IMuIWuUIt3e3uYP7bQ8qtdD/0gLGLUSQLX6w6wnah
         a45eAFVeDBjYQLqVr/rqWuIQxhjJOqGs2zNfmLBKUTCO4zY0BQCQdLsItX9td0mm/UBV
         Jq7jD7KM+IXDSVDLlzJo4jMF7+q8t+zeNY6XTyLRVmKTMqy8Rf8PleT1W62WFPX6nDtE
         80Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUWwe63SPJJCu7LLuGz+rqFAr4pR9xux8Jz21hmVZkhPBsQherZAIoRDdKAVXJdlcbCxdXptMkf9Qv1e3b7O/Dvw1qvBJ8jXXmx5CR+Sw==
X-Gm-Message-State: AOJu0Yz8obG1fvCYqKgTPG7izHDBwFTy/sAN3Yuqh8nAA+CIE2wRY2gY
	NcDFpIHbkofryN87SKAz1PwOw4Z0HrX5ftjo1Nr7bFsxYxsQfbwndR4n8XteR8kNzmYLz0zfFnY
	jg7VtqhxmCHRpY3wzXTyuozMXnpBOYN3eTXss
X-Google-Smtp-Source: AGHT+IE+j+Qli1XePxAilxL5R4FQhkJSRHtQ+wFvcX+d7554bq37l+EQBnd62M0HSJSkW5gjbHPTrWC84iG4Aiv+Geg=
X-Received: by 2002:a05:6122:20a2:b0:4d3:36b9:2c26 with SMTP id
 i34-20020a05612220a200b004d336b92c26mr20776441vkd.14.1711027706376; Thu, 21
 Mar 2024 06:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
 <20240209-alice-file-v5-8-a37886783025@google.com> <20240320-massieren-lackschaden-9b30825babec@brauner>
In-Reply-To: <20240320-massieren-lackschaden-9b30825babec@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Mar 2024 14:28:15 +0100
Message-ID: <CAH5fLgjeet1nhycCqdaKE9CSY02XW85jn302zNEjJNQaJ1czGQ@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] rust: file: add `DeferredFdCloser`
To: Christian Brauner <brauner@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:22=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Feb 09, 2024 at 11:18:21AM +0000, Alice Ryhl wrote:
> >
> > +/// Helper used for closing file descriptors in a way that is safe eve=
n if the file is currently
> > +/// held using `fdget`.
> > +///
> > +/// Additional motivation can be found in commit 80cd795630d6 ("binder=
: fix use-after-free due to
> > +/// ksys_close() during fdget()") and in the comments on `binder_do_fd=
_close`.
> > +pub struct DeferredFdCloser {
> > +    inner: Box<DeferredFdCloserInner>,
> > +}
> > +
> > +/// SAFETY: This just holds an allocation with no real content, so the=
re's no safety issue with
> > +/// moving it across threads.
> > +unsafe impl Send for DeferredFdCloser {}
> > +unsafe impl Sync for DeferredFdCloser {}
> > +
> > +/// # Invariants
> > +///
> > +/// If the `file` pointer is non-null, then it points at a `struct fil=
e` and owns a refcount to
> > +/// that file.
> > +#[repr(C)]
> > +struct DeferredFdCloserInner {
> > +    twork: mem::MaybeUninit<bindings::callback_head>,
> > +    file: *mut bindings::file,
> > +}
> > +
> > +impl DeferredFdCloser {
>
> So the explicitly deferred close is due to how binder works so it's not
> much of a general purpose interface as I don't recall having other
> codepaths with similar problems. So this should live in the binder
> specific rust code imo.

Hmm. Are there really no other ioctls that call ksys_close on a
user-provided fd?

As far as I can tell, this kind of deferred API is the only way for us
to provide a fully safe Rust api for closing an fd. Directly calling
ksys_close must unsafely assert that the fd does not have an active
fdget call. So it makes sense to me as an API that others might want
to use.

Still I can move it elsewhere if necessary.

Alice

