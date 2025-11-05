Return-Path: <linux-fsdevel+bounces-67089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84902C35130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD3D64EE90B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0AC3009E9;
	Wed,  5 Nov 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="keQWsQf6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D402FCC02
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337996; cv=none; b=EoFsz0c+Zgi4z3hqYXMwYGcdxarsabsLdFUtCbFYOd+QOHvPdI8WVyCXgAHNUGBfu8GtwogUUBSQPo2RaHsVugpyI6AV51WMnNIJUza/1mHEy0aU8DZbSWgU+tvmpyqyrW4c14AO89D0o6OhZJCUe2ZbHT/IKpzrNz+/61JOdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337996; c=relaxed/simple;
	bh=zcwOyR3i+iQCu6dzVq9q4dOF16E9XrrQF46JdXsYiRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PYW+8+Zrd/kbLMa9eCh+uA0TRj6j2Gz3m2Lu2i77pCyYcZoyfxju7OTjaxwsdChfjEZyYEEnT3pwvhtXhlwJ4OzusY6OSpVeeubqt36V5QWG3ke4h0IiX67cITSJclYbohxW3RVSdN6+hIb3Vq4x6qKUderysQ9z9kg9d7/M3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=keQWsQf6; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso74509775e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762337992; x=1762942792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSDrC2UXjvRn1x7EpScqa90OTfMWc8Syuy/AT16lrpE=;
        b=keQWsQf6ApTiOtYPl2nl2wskeXvnbbMnImbJLA/NAft85epBW6XA1mGcEDHbLnuvTi
         mnAIZymYM1MI2tYxTgvRU5zhNoE3PmbNIsuwx3wVa2VuDTkSmNn6oY9fxkW3culCDkzq
         sbMWof1tTKxqIvuv8KNnBd/Yne/37x0dkCEvGlK0o7M5DiNdvIISBatao5A+LfFtJBPs
         znq2XSR9m9bq3WPDhxtPjbYU/uMkrM6sSWQGC6Fl1zw/kt2QzcAUu17n1zdTddpS1n2R
         /L81M6rSK00nI4nWZlAsbPr6PHXcK/ZvUz8t6oHI0eInVi/jnHRgjClbh7R9BHeKM/p0
         eepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762337992; x=1762942792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSDrC2UXjvRn1x7EpScqa90OTfMWc8Syuy/AT16lrpE=;
        b=agW+jKGF0nX7Acv1kvLI0zE9EiNKrRqOlKhFysi/wzp3HSVZvxZfhqXaYBPou5jgsr
         9HgswH1YlOzbp04VdntQBBdDNwlMrvkqmYyYWXyiYthnbmeXtarn1xau0oEc12ZPtkfa
         yptWd8/0RynjXdGa/bvcblT0ytvwsGnF3i6dY7sjGRzvq7XCibYWmGPUbShKHd7GIYV4
         0zDfl9mTDnDy2rc9DkEHKZ1VRimUNg3/wMzJYN3k12oj0bp32ZkxqQMYG7OAXEE5iOZ4
         soOEWbyJ4Yc6qckrRNlZJTWOpYg9wAq0XDzM2JlB13ZfaINK8xSx76x22DPPe5mdnmO6
         8Z0w==
X-Forwarded-Encrypted: i=1; AJvYcCUn3x0qE/MJkdxhU6TwWHq39TLcm5BljxKvcQEmjV2K8FKnQFAaxpwWv+RSYW/lzIxeKMG4d2SMaSUxnWmN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhs6TtDUrNDmDkJgZ66NzOSUXXa4K+vjVlkQ78Y1zRP+gLVPeS
	GDLj4UXeV98qkoDVGeYhn79vG9ZoUEqKPxIjvgaqJnyhCvz5mVubmfwUCRbjIEVI6jusnCLaMKO
	qVj7NwX/X3t+Zvc7QNA==
X-Google-Smtp-Source: AGHT+IFy6HLdLExBzNA/9DKpfS4LGeWapRstwfkqLi6/dGNf+Wnlmn+SJmKmH4X1ieaDRU09v81ykT8v7CEixB0=
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:475:ddb0:71ba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c8d:b0:46f:b327:ecfb with SMTP id 5b1f17b1804b1-4775cdc5348mr25817385e9.9.1762337992754;
 Wed, 05 Nov 2025 02:19:52 -0800 (PST)
Date: Wed, 5 Nov 2025 10:19:51 +0000
In-Reply-To: <20251105002346.53119-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251105002346.53119-1-dakr@kernel.org> <20251105002346.53119-2-dakr@kernel.org>
Message-ID: <aQskx-CkI1HNycQS@google.com>
Subject: Re: [PATCH 2/3] rust fs: kiocb: take advantage from file::Offset
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	arnd@arndb.de, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Nov 05, 2025 at 01:22:49AM +0100, Danilo Krummrich wrote:
> Make use of file::Offset, now that we have a dedicated type for it.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

