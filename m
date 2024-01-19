Return-Path: <linux-fsdevel+bounces-8296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2383270A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F21C233F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A013C6AB;
	Fri, 19 Jan 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlJihD6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CD63C48A
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657949; cv=none; b=KkOkCitl19/16IYSKhxTglspLhKuivbPzQlgZ6sKWiHqdGwQ/VWE5C1Bdx7qndKjiWoJUcIqdtKaJNJGaOov4p/6vO7B28w+KC2W8UWu3Mn3ZdsLb1cM99Hnbnzt6iSp4cGW3IWV/4USGp6TayQtj/AYYNURya4+DVR3kkcvD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657949; c=relaxed/simple;
	bh=4krpjVDy39+BaCdqjgBpFliEyfbWXCrM5v68+sqUCGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNYPnCAqrTDj4Sv5/QOZXc9BfRFpnHNJxN9ox933pZj72cSR1V1HGs7fq1zqawPlyWI4HAGvXEEQ9C98RSR6Z/VTmY23AvA52ljhCZR8ixAdv940kwZd7GPkE9Y6/w1s3EzSVLy0cfI6w5cNJogvDmu6/7jR+gSJcg/w3Urf9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rlJihD6H; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7ce603b9051so202582241.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jan 2024 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705657947; x=1706262747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5PLnpg3dx/RHO4L2qWMlMZTP59sZfzpZ1R+uj/KM4g=;
        b=rlJihD6H906xT9cONoRvb8UOMFDpne8SpK4It12CG5vU45xPHn9umv8q3JDUb97Srb
         hOCV5OCZJaCyHYE8pv8MDVMreErdPWf16LWI00dzkdxfwtTVCfwi6W45Ech4YuT2rp+j
         eqhvL/J5OSIPRA6FrurteOKBqj/K3MVxHvZDLqT08ztQP173u5cL0pAx/bTfS3Ju89NX
         a+xf6rQFdS7zkB0Q5RY7iTCzgqsMInOaTOH75rGUMrSL6x3BLt2J0TkeYwf0rxt18Iqb
         k0rUz/pecljvZyr+hS5/mWn2UKn1t4SEUpyUQFCzw4mvmPxXQTpPd652tuyrrDlXoe61
         TAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705657947; x=1706262747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5PLnpg3dx/RHO4L2qWMlMZTP59sZfzpZ1R+uj/KM4g=;
        b=JRhynyhyN1KAsIchTDeE4IvorY884W4kleyQRTFxxQJ9cVUYhBxCB0CDU3y6J1ODTT
         vgeLZlA7/1CX2PjmS7+4pB1c9z9whSUOEhcxKpeJ+FNW5DyySA6txph5YZeMr7Izj1wu
         SOi2g0vvzShSooHygE6rosjtE4QTwuf4sfbktYnVkXQLBhclqksRjrS1rbe7iIOs14vh
         ocDLg3zGrDy30mk4Jn7K59eAwhcacyykw1TvmCLDgAB0HTwdkb/SJgxcxDlTtZmJ0qep
         KNaTVEIz4Eg2bTQVc+Bs7oVOjO4KF98vOrpE8bje8rFOPlA6yQwogph7bPwH+Qq6Wivz
         rLTg==
X-Gm-Message-State: AOJu0Yx1SCylVK8dwkN+GD3HC3N4EXU+fhZJYVGiDe5LhGDvh2Wv4q6c
	0Y2IBx4vpiwB9TKURm/AkBNWtAH8mqjCHkLZhXAPgo/Hr23AT0cJyXWMuhT4d+OQy8fdJ/KiNPe
	NO0EZ3eKxEepMs9E629NL2oPxLmKcRyzdYjuR
X-Google-Smtp-Source: AGHT+IE47HirggHtWWcHrsL/T8Glqyi/a/BE6pVGUL2OnFgkGUJp3QbPuz8i8JvcaSocKz9x2uaTryLyTo6uJ/kBC2g=
X-Received: by 2002:a67:fe17:0:b0:469:95cc:dab7 with SMTP id
 l23-20020a67fe17000000b0046995ccdab7mr1267491vsr.8.1705657947288; Fri, 19 Jan
 2024 01:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-2-9694b6f9580c@google.com> <67a9f08d-d551-4238-b02d-f1c7af3780ae@proton.me>
In-Reply-To: <67a9f08d-d551-4238-b02d-f1c7af3780ae@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 19 Jan 2024 10:52:15 +0100
Message-ID: <CAH5fLgjKVQoTNZAJienaJpDrAPHoC+bAJdCzHsjjzme36h6wBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] rust: cred: add Rust abstraction for `struct cred`
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

On Fri, Jan 19, 2024 at 10:37=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
> On 1/18/24 15:36, Alice Ryhl wrote:
> > +    /// Returns the effective UID of the given credential.
> > +    pub fn euid(&self) -> bindings::kuid_t {
> > +        // SAFETY: By the type invariant, we know that `self.0` is val=
id.
>
> Is `euid` an immutable property, or why does this memory access not race
> with something?

Yes. These properties are changed by replacing the credential, so the
credentials themselves are immutable.

Alice

