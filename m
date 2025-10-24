Return-Path: <linux-fsdevel+bounces-65439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204EC05A09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07161C2126E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A536311949;
	Fri, 24 Oct 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLESs5Xv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D413101C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761302355; cv=none; b=RVmxr6FDR9RViXqLitOXt9DZCn9IZvqmj7v3OKnWEjHub2lV4wLD790BS5/vcuWHq1NmCq5orRvitm9hwa+dYYBBCSBplLkCJrKx2e4KKr0fCknGOXxvNWNnjqCREs0gYLtDwL0xRRGzC3rANYUyKQo0ccsnkB/ZVLZnW2HH7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761302355; c=relaxed/simple;
	bh=hLqLEQW//H7SR70Dq2KNBUCQqAo7BcQp3/CyUvMooiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIEzDBfWSwIgPM+M3wNsJngiYR35Mog3odPbvuevg24QbgDvXEnhP3l1UYWiDbqUTotvAULFC9kYubW1oqyqNwOTOwd3m3M0S49CTtKbVF1juJ+RfRis4vRRU92F4VPg4rdOvKPwMP3quSpoxkw6qRUVZJX37iwHojl7xxQ9m6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLESs5Xv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-471168953bdso19646585e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761302351; x=1761907151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPF1f85/FJM+wJtbt8GtXxyRXGLXZOfe4gspjYrW5Wc=;
        b=vLESs5Xvgn7efmeOlvp6xX9blc8ilJaQ9lJdvkq5HWqacHjOosORm+SSGVgmGH8RZa
         TRADfzW4mWJPKxmCJ+VwVQwNYyBSKnN/vhjNiyziagbkfPNiU9bH+jwOAVxyKP9Zs/Kj
         RaREpeNgLHzMyILrC3BxndzX03slLFdvNi9eXCGvR3QzZy9qwXZzRHxSwnD0BG2AQoo4
         LuzCmnnH1YhvwMBg7HtusMgYwb/eRRJf/TJTLrzLnaN1dA0J9JNZ4tajR7e33ssHQhmG
         WBfr5dflYR0o0ArgLufYrd6L+fFQuP/wh/0WMeYvg30B877F/x/Zg+00xFbA9eVmFfqj
         P+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761302351; x=1761907151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPF1f85/FJM+wJtbt8GtXxyRXGLXZOfe4gspjYrW5Wc=;
        b=sKAnAOM/3FmWMaAvK3fa0xHths/ymGf2uOc9AdDrYyIz8UbqVyfRKZCHvLF8kmkpvu
         QEiEfep6QcYPlYtS7AOhAwzw3M/b43RlagAMvgrnhjE4OGer0dHqCNava/I831CpODQs
         zgoBHKTEIjVDGpPS2hv+JtIYh9TXuszhNZbjsJfA/F/871T1gFEP70pHEMKdx/zA3RK4
         NTtCJtd6/8firqYagnz+IiLJ2ZRhlHkOE1E9e8w2Hs8c4c2y+h5Fx5xUp6zDTMKltyPk
         dQd3cIAuM3VFFibtxsOi2Kxn029wDDuuaRMJtBznspCEFqYKRny6aYhEDnI2FlYzL/O7
         KpGw==
X-Forwarded-Encrypted: i=1; AJvYcCWo4pp6/DBxgKJJsGIsbguBNIJfSaT8x6jgQUWZRlVXZnCWNeG2Ci+7NqODFNXe8zjqqVVj8B/IB1Q65Mlt@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8FEB+bCzPldKeNCVENuwhNmM0ZzT7bn1COCzcwLvmKTWfmam
	V8jAgM5jmJI0ojboe+gU1tBPmGwAjzUMoHq2sqQT/NL+JxI6L8QW+asLhM1zxJQsez2AsP12GUh
	5GZnq8IeEdkdLGhFnwg==
X-Google-Smtp-Source: AGHT+IEjUBMQGoVxUfyDuWsIaZh++ce8Z93gQtTGPdxEJaJNt3LFU5j/zdaAt8Gsv0XYS4ZhQjjGAb/v4s3GhzQ=
X-Received: from wmgg22.prod.google.com ([2002:a05:600d:16:b0:46f:c7ab:c8ce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:295:b0:46f:b42e:e362 with SMTP id 5b1f17b1804b1-475d244d6f1mr13867525e9.19.1761302351572;
 Fri, 24 Oct 2025 03:39:11 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:39:10 +0000
In-Reply-To: <20251022143158.64475-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-3-dakr@kernel.org>
Message-ID: <aPtXTsbU07VSGDDT@google.com>
Subject: Re: [PATCH v3 02/10] rust: uaccess: add UserSliceReader::read_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:36PM +0200, Danilo Krummrich wrote:
> The existing read_slice() method is a wrapper around copy_from_user()
> and expects the user buffer to be larger than the destination buffer.
> 
> However, userspace may split up writes in multiple partial operations
> providing an offset into the destination buffer and a smaller user
> buffer.
> 
> In order to support this common case, provide a helper for partial
> reads.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index a8fb4764185a..c1cd3a76cff8 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -287,6 +287,22 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>          self.read_raw(out)
>      }
>  
> +    /// Reads raw data from the user slice into a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::read_slice`] but considers the given `offset` into `out` and
> +    /// truncates the read to the boundaries of `self` and `out`.
> +    ///
> +    /// On success, returns the number of bytes read.
> +    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) -> Result<usize> {
> +        let end = offset
> +            .checked_add(self.len())
> +            .unwrap_or(out.len())
> +            .min(out.len());
> +
> +        out.get_mut(offset..end)
> +            .map_or(Ok(0), |dst| self.read_slice(dst).map(|()| dst.len()))

Same comment applies as write_slice_partial().

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

