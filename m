Return-Path: <linux-fsdevel+bounces-9833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF17845454
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4E1C26BFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A552F4DA19;
	Thu,  1 Feb 2024 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/oudCBY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403D4D9EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780532; cv=none; b=dEQfp/7f5hBuG7+03ZKtaLCezU5FdrRlKMaXKA1kZmOF2myxTKR/F9s9nbpoTu2/saKR/MyloeJXnC7fI7vLbYTgM14sKnVe+7fEa5FkQlVXg29012TYqUI4/pVluOi/k+CMxncILwJAAynFqaBKfQ2m6zgCqJ/mPaA0Ddt9BxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780532; c=relaxed/simple;
	bh=RI/xh3KG3rWCEcP4eS2L4B9Piqu6OhdAZcUZ2rjfAy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MspgXRLdFGO43c2XEalwFLcd7eGBc5gzRjFeaLDeP6aTS5/i1jVfC6AC600rprotyRA1myE+K2RjWZ+Ur6G5GFFAlrgmRGCyUVQAcJYQ3eoPlLtLMQeyrFseoWBE+/dCRcAKMdIzDO2cd+oQCsiDwbVWxNX4M/BmSbhb26uxE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/oudCBY; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b739b49349so272786e0c.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780529; x=1707385329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuPOrdCb6HbBTgaqgsjDT3E2Mco217B1+thjHRyFhms=;
        b=c/oudCBYQbUpkiq2xbEoIFZdtO6CjG5l7EZOxx8GbJZPDYmDjqittyLjIzjtDCDKia
         aKyX4ngVa72r7TZyqCpQ2JSmV7OYyFqAblW05k2+TtYFEPU+99UENoinKatd1ZrVOghn
         +TVSCg9dEIshG7zYSAhiaxn56jnTa4Xi2cehRRYJAIwzSCN2BZIkqpK3jmPnsMlToIHX
         fWQeedSw6+SapD4igDYIvEIvKI2wLrGsXz8dnQZJinWliV8x3uAOO3MWIFxvO14RZPMF
         RX73ekI5dHT//VGI6D9+3S6vKdatSYQLNyYEgwlGsu2UuVBOohST9FV6vV+JQ0fz9XWS
         Otyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780529; x=1707385329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuPOrdCb6HbBTgaqgsjDT3E2Mco217B1+thjHRyFhms=;
        b=tFq8ntTPXwfAq/5v8tJfiEfo/dLYbl1JcItnKWL/HAVzSuYv2ZiMMbOu5QmVA720Mv
         Yd/7QD4+PrXWJRvlVDUl9hkI2t4pInOlKkA3dN4Ie/kVz2RZMJ1yq6VQvBkiRI2aeme+
         Oa+M8jmAZsost3b4rjMvxEi/37fGqU/608YY7rwEt+0VygaT2pMe6uMgfk21kgbEyJHw
         8zyloSdSc1AZtHfcnCy15CsIhKoBoX0VG1f+uqkAquBjQOihwxwa/1Zc7zPGb5G2PhPk
         +FGJj7oXB+IB5NdyrkO1ugqnl1C5UShXtQozm8lM2MKaKE/kl5RQFXIv4rUsok/cAJVS
         3w4w==
X-Gm-Message-State: AOJu0Yz/Fs7trO5IoNI2EGYnylgqJ8SRY+TUPYQazth2NSskvkQy9PLp
	7AL/RwtUQPuMHxzHkvmms0uHJNWrgWLVbOpV3AdEvZ+hK0w5cHBaE3LPXkOj5KNz410U1Q2sm59
	6pi/qKvDSAZvDcfYEZiBLRAnGApeXZBpY9n5C
X-Google-Smtp-Source: AGHT+IECDgqCaXC3D95Pns2tEui0S4X58vEeWJ4hsISY8qGpjuY6uBTkGlgBNB8UM/Un2o8+WkkkZboJRfYbLKHc2+8=
X-Received: by 2002:a05:6122:4085:b0:4bd:9cbc:a5d7 with SMTP id
 cb5-20020a056122408500b004bd9cbca5d7mr4603391vkb.13.1706780529128; Thu, 01
 Feb 2024 01:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
 <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com>
 <84850d04-c1cb-460d-bc4e-d5032489da0d@proton.me> <CAH5fLgioyr7NsX+-VSwbpQZtm2u9gFmSF8URHGzdSWEruRRrSQ@mail.gmail.com>
 <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me>
In-Reply-To: <38afc0bb-8874-4847-9b44-ea929880a9ba@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Feb 2024 10:41:58 +0100
Message-ID: <CAH5fLghQAn5JYeeG0MDO-acwQHdX7CTkr_-5SzGOzrdFs2SfNw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:38=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 01.02.24 10:33, Alice Ryhl wrote:
> > On Thu, Feb 1, 2024 at 10:31=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On 29.01.24 17:34, Alice Ryhl wrote:
> >>> On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> >>>>> +///   closed.
> >>>>> +/// * A light refcount must be dropped before returning to userspa=
ce.
> >>>>> +#[repr(transparent)]
> >>>>> +pub struct File(Opaque<bindings::file>);
> >>>>> +
> >>>>> +// SAFETY: By design, the only way to access a `File` is via an im=
mutable reference or an `ARef`.
> >>>>> +// This means that the only situation in which a `File` can be acc=
essed mutably is when the
> >>>>> +// refcount drops to zero and the destructor runs. It is safe for =
that to happen on any thread, so
> >>>>> +// it is ok for this type to be `Send`.
> >>>>
> >>>> Technically, `drop` is never called for `File`, since it is only use=
d
> >>>> via `ARef<File>` which calls `dec_ref` instead. Also since it only c=
ontains
> >>>> an `Opaque`, dropping it is a noop.
> >>>> But what does `Send` mean for this type? Since it is used together w=
ith
> >>>> `ARef`, being `Send` means that `File::dec_ref` can be called from a=
ny
> >>>> thread. I think we are missing this as a safety requirement on
> >>>> `AlwaysRefCounted`, do you agree?
> >>>> I think the safety justification here could be (with the requirement=
 added
> >>>> to `AlwaysRefCounted`):
> >>>>
> >>>>        SAFETY:
> >>>>        - `File::drop` can be called from any thread.
> >>>>        - `File::dec_ref` can be called from any thread.
> >>>
> >>> This wording was taken from rust/kernel/task.rs. I think it's out of
> >>> scope to reword it.
> >>
> >> Rewording the safety docs on `AlwaysRefCounted`, yes that is out of sc=
ope,
> >> I was just checking if you agree that the current wording is incomplet=
e.
> >
> > That's not what I meant. The wording of this safety comment is
> > identical to the wording in other existing safety comments in the
> > kernel, such as e.g. the one for `impl Send for Task`.
>
> Ah I see. But I still think changing it is better, since it would only ge=
t
> shorter. The comment on `Task` can be fixed later.
> Or do you want to keep consistency here? Because I would prefer to make
> this right and then change `Task` later.

What would you like me to change it to?

For example:
// SAFETY: It is okay to send references to a File across thread boundaries=
.

Alice

