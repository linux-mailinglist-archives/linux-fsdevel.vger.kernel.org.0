Return-Path: <linux-fsdevel+bounces-65438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1038C059C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A4E1890F85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F653101B4;
	Fri, 24 Oct 2025 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWLLkP/I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9221303A1A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302262; cv=none; b=KYE+Ou7cZGJmeWmcsJ21DOClFklJ+vIzQic75SU6fz0FRS7kIebX/VWWp1nbii50AT4NnFUHeOJKecuEqVaN5Kq0XWXXqVS5Zaj/Lxbwmg+nB7GrKN5XYLHTQ3JHOmPVUUWhWDm9U0gHrAJa2ECFJEjXh1h/NtXqRhqC0QkMGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302262; c=relaxed/simple;
	bh=Sr2XyRdzXeMhkuNYfkb6Mn0UTZOqFz33nE8+nQ5o8Ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zjq9jEQ+NxNbYoT36vPktddiqxwu+a5EwfPH9uItPX5bahKdv3niDDlWHjsiX8e9xTHWAbFerdnXOCuCZAD3Jhn5QLiuDwE8YM+KXUhvbIxIcWLSAWbQDvKvfqJdS4ebw3RbOsHNwfGcOCtVDc2/XmGfg09x09WJTKZbOGtLGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWLLkP/I; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b6d5a2f69b7so147510466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761302259; x=1761907059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxoLsZ8nIFnPas/1M9DEkG+zqI+s5pFPa6Jdb9VgZ5w=;
        b=eWLLkP/IkR/LgOiTzbQ1JLrYcZlOm4LCKUJnbiejVk0dF0xwFnYQ2qyhRujHSQEDHN
         uehNoTZE9ZBuuGNfNdeuJpNxZFxy5eLBM+oFxtmr7bWvOvWUwOP53tGpUEL7qreesCR8
         cbDVtJpjpbL8dXOf3LNuLtq05SW0hjPmErXPzlZgHlAHOivGCd3Lu7fOs2Z/fRzev+eT
         jr/rr+SpuV9FOBXthw/P9VEgTXs4oqsQa+PYtiIm1jyGHhYbeCs3dwcwBmFAxwPQho0y
         2YRm/GsoxDOm21nqMeQbtfxItItB4rZ/+3ac2SC7go6qQbGZGHFkxpg4mPb/ClI15GPA
         RA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302259; x=1761907059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxoLsZ8nIFnPas/1M9DEkG+zqI+s5pFPa6Jdb9VgZ5w=;
        b=ET5e5EXp0Pn+SPFGWXQFexm4iiKP8CBygOmTekfoLmlK840/hgi/hsct0HBDSQdXfJ
         ihChh24ubpPJj69jwkzYeWz6UHov3wjJ/OS0DM/RFVDKyxFbAwgSAVIfnIdKvmOfZCWi
         ddoL4X6/CKAd3sTaBS1b1XBNOBEnLEGPuE1pF1F5+W58t2KaszrICok63066wplqBQgM
         UkOtJdB6AB4/1AfkK4ijGdJ45ODWqz0Sioo9+NozrxPt5UgYwnyF0gN44R4MC64nPyqw
         G0jC+17e778sCkevyp3UGROd07HQI8slqb9MHLx9PPOyGKZudwBHXm0nvEzpAy98fMO4
         EqMA==
X-Forwarded-Encrypted: i=1; AJvYcCXckC26jHNX1J1yGUBWx784f9G2HOt22lHKfJAimJeOS+lFNCd6YwyGyfNTkoMlEwIJz1VvBRtHt4iZxkzs@vger.kernel.org
X-Gm-Message-State: AOJu0YwXmaqkZDkH89A8rALpOWaeaYJ73V6TcR2CU02pgH0XBIajVoAP
	B5BD3B/HgSy9rtdhhRKzEq/L9VLnacBgo3yHg6cfT4dnK4/UrmYLdz25aiws6BSsnkHnCku5H80
	pb5B0u3X//WAjzt01gg==
X-Google-Smtp-Source: AGHT+IG53cNmqGsinKn0h9jaCGCn5QFBNWSJ/tDDHGbExfk/RNWZz5TkIUXXZ8YEkSofsYQU+YELva3WjgON5co=
X-Received: from edf24.prod.google.com ([2002:a05:6402:21d8:b0:63c:2d17:f4a8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1941:b0:634:cb54:810e with SMTP id 4fb4d7f45d1cf-63e3e586b6cmr5620231a12.31.1761302259027;
 Fri, 24 Oct 2025 03:37:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:37:37 +0000
In-Reply-To: <DDPPL8HKEERV.2JXDADIJPM6NY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-6-dakr@kernel.org>
 <aPnnkU3IWwgERuT3@google.com> <DDPMUZAEIEBR.ORPLOPEERGNB@kernel.org>
 <CAH5fLgiM4gFFAyOd3nvemHPg-pdYKK6ttx35pnYOAEz8ZmrubQ@mail.gmail.com>
 <DDPNGUVNJR6K.SX999PDIF1N2@kernel.org> <aPoPbFXGXk_ohOpW@google.com> <DDPPL8HKEERV.2JXDADIJPM6NY@kernel.org>
Message-ID: <aPtW8cT5YoIGVIH9@google.com>
Subject: Re: [PATCH v3 05/10] rust: uaccess: add UserSliceWriter::write_slice_file()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Oct 23, 2025 at 02:43:20PM +0200, Danilo Krummrich wrote:
> On Thu Oct 23, 2025 at 1:20 PM CEST, Alice Ryhl wrote:
> > I would love to have infallible conversions from usize to u64 (and u32
> > to usize), but we can't really modify the stdlib to add them.
> 
> We can (and probably should) implement a kernel specific infallible one.
> 
> I think we also want a helper for `slice::len() as isize`.
> 
> > But even if we had them, it wouldn't help here since the target type is
> > i64, not u64. And there are usize values that don't fit in i64 - it's
> > just that in this case the usize fits in isize.
> 
> Sure, it doesn't change the code required for this case. Yet, I think that if we
> agree on having a kernel specific infallible conversions for usize -> u64 and
> isize -> i64, it makes this + operation formally more consistent.
> 
> Here's the diff I'd apply:
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 681b8a9e5d52..63478dd7deb8 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -125,6 +125,22 @@ pub fn saturating_sub_usize(self, rhs: usize) -> Offset {
>      }
>  }
> 
> +impl core::ops::Add<isize> for Offset {
> +    type Output = Offset;
> +
> +    #[inline]
> +    fn add(self, rhs: isize) -> Offset {
> +        Offset(self.0 + rhs as bindings::loff_t)
> +    }
> +}
> +
> +impl core::ops::AddAssign<isize> for Offset {
> +    #[inline]
> +    fn add_assign(&mut self, rhs: isize) {
> +        self.0 += rhs as bindings::loff_t;
> +    }
> +}
> +
>  impl From<bindings::loff_t> for Offset {
>      #[inline]
>      fn from(v: bindings::loff_t) -> Self {
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 20ea31781efb..44ee334c4507 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -514,7 +514,8 @@ pub fn write_slice_file(&mut self, data: &[u8], offset: &mut file::Offset) -> Re
> 
>          let written = self.write_slice_partial(data, offset_index)?;
> 
> -        *offset = offset.saturating_add_usize(written);
> +        // OVERFLOW: `offset + written <= data.len() <= isize::MAX <= Offset::MAX`
> +        *offset += written as isize;
> 
>          Ok(written)
>      }
> 

This LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

