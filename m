Return-Path: <linux-fsdevel+bounces-24253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F65E93C67C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B58F1F22AEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B9319DF4C;
	Thu, 25 Jul 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yB9IBZG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C519CD05
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921584; cv=none; b=FpuKYlOdbcP8JQYEapwX1EVwW8i4OF/rwQFRHB1J7lfekL91KdCGWwL7WemC9PAutA2x6rdEqNnv67SND7lBElnmj08P/w3bP1K6Jthx+01R2lvIvTknDsHNV56URnjJNGW1JwhpZeKSvm28L3JPWbMxtERNYHJtyOXMAMj51Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921584; c=relaxed/simple;
	bh=rAzZ8OR8HA2lv9tq0qWRFMaSclYocHJ11ucneTGkgnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLID4BxyZbJfMld/igfsd8juy7M2D+d/OzS2xh32oKFcFh0EvMkiJ1cw8GcZSa797bgoDpEbBp1aXGLTjUBHWt1gx1ipddIxpme7aaAncdfdJ2qExdOE+BbC9gVY3yrKshvmRoV6A5boxnLGq+dawNr6nQsQ+ItcH4qrHs86k00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yB9IBZG/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36844375001so604957f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721921581; x=1722526381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAzZ8OR8HA2lv9tq0qWRFMaSclYocHJ11ucneTGkgnU=;
        b=yB9IBZG/tzxDgBQvTqy8VnPyjKt2JG9W/T8X1/HKAAN+uQ5tqFGC/pmn8AWJpIrMtq
         UY9YsPLDvSImgyg4+isA7t3XNj384JtGaPaBwXeQb2m/ynlSb3nwDmvvtafjXt+grCu2
         tO10WGmzSNOUnejs4EWJpXQWgKN2cZGM0NJKLMowyUuHM+3+cIOMOssUg+lwODTlImyy
         HjIHcllarVJl1fohJ0gXXOeqq+viEwahUN/PCC1/I5J5YjJ/JZ159u9XkNXRaBJjsAQ+
         iVOSSWb8uj9PR64h5wKGEzB4Qkh+xi/VNAbHgw4sE0PU0oz2gwnzDQR5pU9g/HICbEhf
         xTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721921581; x=1722526381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAzZ8OR8HA2lv9tq0qWRFMaSclYocHJ11ucneTGkgnU=;
        b=vGvzFgebJxJ+xjOsqwL9TQ+dpX4HU/DxYJf29AW4Gkze50aZJBD5MR/QjGXfQEEhyO
         kIX1fn386GSqvpT7TQwFDMp7yfPMezCR1KiideNGQuaVopOHzz9SplOnGbjWvLaxS/5i
         25iM75hrhVB1blS6cYG2OptH1nd57eeG3yMphbzJwWimRzhujKIGFNcZMtXKP1B72D+o
         FY2hz/C+d4o1l6XVfyhhC+9TeoJx3KsLbaCtgEUw85UEHsEsYQ59uJxa3ffjh8e48cN8
         hOMjrpT+eX7wbqIbitZOzaC5Xu0EDS6e7U/tB5tZ1iEuAKLudG6Nchetp0DvAekL+cX2
         BC0w==
X-Forwarded-Encrypted: i=1; AJvYcCWHtY6r6qCmhYhdmuJdFiQ65G74ntTWs3WnSEirdf0G7d2raUaAIlEzmIYhS8Wxf+/YLunzzMMC2LmdpxrMs526pUuH4g9H2/uDaIW7Qg==
X-Gm-Message-State: AOJu0Yy8ZGcYWKzzaBo8wGVlqcAvVQnbBc6jSbVr2x8tZ3AF+XD1F2qA
	fnB67SskQBx8NMrXNjdAZ0deau0BezTFH1EX4pGEio1715ZeQXroZV/lTiFz0HSucsT0iAosSrS
	hanKfluKk/BEHuJPT52hgQwI5Qehpb/wFPMTL
X-Google-Smtp-Source: AGHT+IE+oKJLSV+SwpZjYkljCExA3SWvBAz+6jpHUme+koEV4fzTA5M1Wr3wMQqJLlJYDGASK4bmI8bYnHGBN+KnPrc=
X-Received: by 2002:a05:6000:c82:b0:367:f054:7aba with SMTP id
 ffacd0b85a97d-36b31a41d5bmr2143574f8f.41.1721921580840; Thu, 25 Jul 2024
 08:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-1-55a2e80deaa8@google.com> <20240725143714.GI13387@noisy.programming.kicks-ass.net>
 <CAH5fLggOo-TErSktC6qmyZpMGVu-M8rFXgvfi3N0Z_u63C3EyA@mail.gmail.com> <20240725153008.GK13387@noisy.programming.kicks-ass.net>
In-Reply-To: <20240725153008.GK13387@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 25 Jul 2024 17:32:48 +0200
Message-ID: <CAH5fLghpXuv3sgGnO4dBydnn8Agqpm0ZDESQcwrbWEu58AyGxQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] rust: types: add `NotThreadSafe`
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
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

On Thu, Jul 25, 2024 at 5:30=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 25, 2024 at 05:09:14PM +0200, Alice Ryhl wrote:
>
> > > As per always for not being able to read rust; how does this extend t=
o
> > > get_task_struct()? Once you've taken a reference on current, you shou=
ld
> > > be free to pass it along to whomever.
> >
> > Once you take a reference on current, it becomes thread-safe. This is
> > because taking a reference creates a value of type ARef<Task> rather
> > than TaskRef, and ARef<Task> is considered thread-safe.
>
> Ignoring comments, there isn't a single mention of ARef there. Where
> does it come from?

That's because the conversion to ARef<Task> is a two-step process. The
TaskRef type just provides a conversion from &TaskRef to &Task via the
`impl Deref` block. There is a conversion from &Task to ARef<Task>
elsewhere, and this conversion is where the call to get_task_struct()
happens.

Alice

