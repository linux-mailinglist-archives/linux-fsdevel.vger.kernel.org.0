Return-Path: <linux-fsdevel+bounces-65280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B1BFFE86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51D13AC0B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434B2F83AC;
	Thu, 23 Oct 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZ56sywL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3DD2F39B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207986; cv=none; b=PBgIO8oSjbEmuX5ZhLREJ1VKARqqKeaF2IM3eTCGdk04y76yw5WGm3E8PYoOykoyIC3VeFcUjXNcOaEYk8jC3Cwq4FBpjqaAGwWukoXkNMY+bvJopseVJJ0iDqakfZVkeFZu6i+MKl63Nnp8XnbbY1KLDOQjmjmL1O+zBTIEV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207986; c=relaxed/simple;
	bh=9Fg3vMFXwJtcWe+pZJoXoz30yGJyrxHbyL+TfUSepZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XavNZ++Fd1bPAu8kNzIbpWmyAmKig1FyhWEzPeuPAqVXOpLTA9Tjne+UhMclyS6b2Q4VCSyAmIu5ubrjU0igeEjeMP4COFY6ZE02Zy+ksveBlJv8ipD4yGhfdQkV0Oz/Gvvom+I5u3DcgGrUsvmny7YOMgcYLneospReohOfhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZ56sywL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46fa88b5760so2009585e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 01:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761207983; x=1761812783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF3XqRoNHj3sZR7wlPcBDSDjMHwfDCCUCqxTkrzKgUo=;
        b=JZ56sywLgKjFz0ylKSOJoQaAAuF9p3N1lKlh8SaQzooOdjz76LkM0vDIEN1lZNAbaT
         AgOQpT48469WkEP+mpEYsrJIsi5RoRnBZRNo1eZxleL2/34TfPpZ26sOxAnTSW8FgctE
         veHgdBOYX2/gXmXnsjJe1SSmVDUSrOJtJwXEpN0wFwsP1U9kJxrMPfSJOhnShaW9MPpA
         gP7PwXRDUoT+tQfUSKRX5I5iJYBWhADRBShnd5s6A8Ee58EWcMnHleeS7ALV0yfY/9NT
         YF3C3o4OEb7DgkhNpItzgRLhUPwT2R5qDrwjQY4awpVUnV+vfqcCZn/FcYE7Ew12WOko
         sRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207983; x=1761812783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF3XqRoNHj3sZR7wlPcBDSDjMHwfDCCUCqxTkrzKgUo=;
        b=OiEQomrkmzmw9J7bhLIbMRBUNNjiLvNWlV/rO89sNlAjqE0aEyluth1m78VCpRqhzP
         M3c+Zl56GRKFWDTTZUw9lZy3MDeAx8x68S4yyXQAepm9Scaf3nAacgsfB//dWM4UbNUa
         db1R6/hP+h5QD28XGB1PGaPMFXaWxGh/7QPZJlptW4tTzyP82ZgK7wjJPuQUnalc3FTF
         uhvo33MY9c7MG97OoGXYvcEqxLjKc0l5xwERqZ9WPV0g/zliuG1TbNhml2kqRbuOVuyl
         sbWUoiA9W9VvtZI4xh/UubVlcaOUXvuDFZgGZ547ZGP9rATzPUq681mYedPx7R5DJLwI
         BK1A==
X-Forwarded-Encrypted: i=1; AJvYcCWFHmunvsSFe5kW6clr3bdXJ94ONhVwmz5jtMYkg9EjO06uCh/m27oNjt821UEqWM9k8ynuibG6ZtrgPek1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NXXAfyAG5zJZwpjFb3LH98EUMGpKXZSy4tiW9n/o/JA3laMW
	LBdqAWo390xdGhiYYsnUH4D6RtH1C46TIX709vwaZaPfaVyHiK+dHKFzV6hhbUBlK+u0vsToIon
	nqB4YbBjqLDpTaKk+0w==
X-Google-Smtp-Source: AGHT+IFL9mUzN1PJl3xW0LdYWHYYrR/keeaUlrS5f2myPn0lmPkjh9byHtmWsbcyr63o7ILjU4oor7YsRWX3pCg=
X-Received: from wmwr4.prod.google.com ([2002:a05:600d:8384:b0:46e:3d73:fc5f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820b:b0:46e:27fb:17f0 with SMTP id 5b1f17b1804b1-47117877244mr173618305e9.9.1761207983525;
 Thu, 23 Oct 2025 01:26:23 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:26:22 +0000
In-Reply-To: <20251022143158.64475-7-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-7-dakr@kernel.org>
Message-ID: <aPnmriUUdbsQAu3e@google.com>
Subject: Re: [PATCH v3 06/10] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:40PM +0200, Danilo Krummrich wrote:
> Introduce support for read-only, write-only, and read-write binary files
> in Rust debugfs. This adds:
> 
> - BinaryWriter and BinaryReader traits for writing to and reading from
>   user slices in binary form.
> - New Dir methods: read_binary_file(), write_binary_file(),
>   `read_write_binary_file`.
> - Corresponding FileOps implementations: BinaryReadFile,
>   BinaryWriteFile, BinaryReadWriteFile.
> 
> This allows kernel modules to expose arbitrary binary data through
> debugfs, with proper support for offsets and partial reads/writes.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> +extern "C" fn blob_read<T: BinaryWriter>(
> +    file: *mut bindings::file,
> +    buf: *mut c_char,
> +    count: usize,
> +    ppos: *mut bindings::loff_t,
> +) -> isize {
> +    // SAFETY:
> +    // - `file` is a valid pointer to a `struct file`.
> +    // - The type invariant of `FileOps` guarantees that `private_data` points to a valid `T`.
> +    let this = unsafe { &*((*file).private_data.cast::<T>()) };
> +
> +    // SAFETY:
> +    // `ppos` is a valid `file::Offset` pointer.
> +    // We have exclusive access to `ppos`.
> +    let pos = unsafe { file::Offset::from_raw(ppos) };
> +
> +    let mut writer = UserSlice::new(UserPtr::from_ptr(buf.cast()), count).writer();
> +
> +    let ret = || -> Result<isize> {
> +        let written = this.write_to_slice(&mut writer, pos)?;
> +
> +        Ok(written.try_into()?)

Hmm ... a conversion? Sounds like write_to_slice() has the wrong return
type.

Alice

