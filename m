Return-Path: <linux-fsdevel+bounces-65515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1BC06322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A89AD4E82AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C24314B93;
	Fri, 24 Oct 2025 12:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJ77kMA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B1E347C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308137; cv=none; b=ar23uhJTZZRdOU44njEZYlZknw2iusOOiyI6jzHlj2n4VDrhwBQUifue5c/pCY5vSdAOIVXr+l8Gz2j/tEurhK0QU5WnGAKhEwUa78SMyRtJcQB7fJu1E25LZ3oLrwbQz47ad3tsCQ7jUTV5OPKqrJIxyiPFYtFyHVrl6DrouMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308137; c=relaxed/simple;
	bh=1QYFOnhEDNlrBEyVN+IEYzwowhQlYIEJHN3U3pBB4Ck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hqR8A/zAuCqH220XlubDycW/97p2bLh5bgXgc7fODcs+jSKWYSF2Jx3VjqHSvxH5MuraWt0dN9NSLTB5r3SbGmg7HCUP8fVURkKA/3CQKCb11z+WOwkIuE2V8P/dZI+VtDvKAL6gcsNF9TLTShLTgKYhQMmjg5c1ZqmkxY+UBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJ77kMA1; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6305c385adbso2004197a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 05:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761308134; x=1761912934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYIbCMuRi13fdYnbnhpcKoD3rM3DmFSEXS9pBiRUSxc=;
        b=cJ77kMA1wwRM4RrnEvo6LlLMWEer+iJh2jplK4o2wNvSxaji2HKmbcLaVBP4If82Xn
         6VFSFU0Guoq+YCma+FsFNQdou38TKB+TUzYObcPSra/bloERvGs23t+a39Gq4lOlFEJN
         05N8CdGMed6ZTcgfQ/kFQMASsMlFAFUzkGozn9kgwBkc01y7D4bTy44G0VTgv005FCU2
         Hagfzsmfzn1pZR2PdvUGAP0wAR0YJV0f28CD8Qq5v+rWotIc1B9iGUdGHabQj6d/bbBH
         0UVQo8KC31E+avuIfouoEsRJ8m6EJnAOddJ2fHd4TTOPvA1P1TpdyvuON+ovgSAXqIxN
         uAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308134; x=1761912934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYIbCMuRi13fdYnbnhpcKoD3rM3DmFSEXS9pBiRUSxc=;
        b=ZWDe2LlimX1/yVnuA3M0Z70r2Efuedvc46fs+g6FeZbl9zMj93+h9HisOoHPBoqhVQ
         TktoEMMf1M9cOrdRh4NZ+RanjoBAjb5uppFAsC2d/flcRH1TurW6HwQ3oHkL5l3VRL/7
         q96djQ6XS6zeNX7JQI20SZ0teo45NmflMuY3tj+ITZw7LwrlRV1BF73Skm+1Xwgd50QW
         mF2Bn/wXfHJvlNqIBKJOKDA7p34QgejSB8cKuFXDy1PplTjNmjLfVrGIPIilScbyNSPW
         eMbAe+6rbm08oAiOPZxBm/5RECvDtKk8A3/k8Jv2Au1B8+B5M6rk8B1tFtBPuN71aQv3
         AFLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi6Drwfvd6PURnNAAICxnFGHaQAfTj4gGDi1u1k69DeGhXNCBIyxrPcvlJiyGjcuMcul9mQ9RAFIo17qWP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bASGa10gDVqAJpdihwyriL0yXMwD0XaRxv7+NZfMqDYz2aaQ
	yv8JsqWlhhoCcWKLhOQ6rAmhCLjs93ud6iTjF6eOIcJbTJF/j0a5E9yrOHPfNKgaSsg4tHydEOe
	a7XKpyJKW/fMeg4ecFA==
X-Google-Smtp-Source: AGHT+IFKGYbprr7tWKIreIWGEx72f2mseKaij75eArsKsTtRHf0EN2H2ZyWU9vKva3onEuRE1wLgAY5783wz1i4=
X-Received: from edt20.prod.google.com ([2002:a05:6402:4554:b0:637:4e1f:94b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:847:b0:63c:18e:1dee with SMTP id 4fb4d7f45d1cf-63e3e4791a6mr5530880a12.24.1761308134211;
 Fri, 24 Oct 2025 05:15:34 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:15:33 +0000
In-Reply-To: <20251022143158.64475-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-2-dakr@kernel.org>
Message-ID: <aPtt5XyE_pBoiarD@google.com>
Subject: Re: [PATCH v3 01/10] rust: fs: add new type file::Offset
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:35PM +0200, Danilo Krummrich wrote:
> Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
> using raw bindings types, this seems to be the better alternative
> compared to just using i64.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/fs/file.rs | 142 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index cf06e73a6da0..681b8a9e5d52 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -15,7 +15,147 @@
>      sync::aref::{ARef, AlwaysRefCounted},
>      types::{NotThreadSafe, Opaque},
>  };
> -use core::ptr;
> +use core::{num::TryFromIntError, ptr};
> +
> +/// Representation of an offset within a [`File`].
> +///
> +/// Transparent wrapper around `bindings::loff_t`.
> +#[repr(transparent)]
> +#[derive(Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Default)]
> +pub struct Offset(bindings::loff_t);

There is no invariant on this type, so the field can be public.

	pub struct Offset(pub bindings::loff_t);

Otherwise LGTM:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

