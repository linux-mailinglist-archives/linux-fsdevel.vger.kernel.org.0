Return-Path: <linux-fsdevel+bounces-64931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45DBF6F0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D5C19A0FD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED21033971D;
	Tue, 21 Oct 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClTinW1B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358B332EBA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055246; cv=none; b=X8CZc7op5vfr8QfmETIOkTJjQGaGqav8m9+8Vp/xrwh+GBYDj79jvTrx0Fi3Ax2GG2cepRlH1ohPeUqPMQGhEynACIk8yQYub0FLrj+hWH/CnNjk+FTlr3B1Y71FEygyHnTt27XPydBNDMVuqMi/Mt/afGPKtkZKaK5OJP1QDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055246; c=relaxed/simple;
	bh=kiZCwxxshu6Lm69S6km65+B8UcKV+CURToWSIuLBfYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E1qtcofcOGeF6V1OF+MpIANt3TT5OKdMtDivxmnDW8rj7dyE3s6b7cao+4ex6gdAKUGp8BMjOeI9vJUJG78PGvIc3KutamBEkbl/+cefC+DSk+D65nzGm6eupm/wO2h4HM/WjeQBQaWUyFzgah/DvphWfOKUxMRYNdRpWi2D7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClTinW1B; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4270848ceffso5719103f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055243; x=1761660043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1uPpgCzD3AeHCNNke18aEjl14Z6hp7FAEQ6jf9bPwA=;
        b=ClTinW1B4CbR+P+Wl0MiOlFvDtyt8K8XGhkqBZMLPMV0s5LtPXodrkQWM7iSwVQKZb
         lX7D6au114M2W/dN46NrqiYTqjQdKw5lw74bFWczSj4GzEaDB3PocB2BCpXEsK3lArDq
         vCkWd1Lj2TVTDfxMPLfgOZldWJ4FohhvlHBY0Lj5sEJfvvCXSdS9m/EOEN6pCsrqomXy
         PweOXZLgC7bkSGqhMb33wwzszkKYiyNcMdAebr9rEpiWee46VhQspKe2IOkqZJSSA5nT
         CxR8jx6+zFNFi5f0/4I2ygW18BIZYdixBGbutzLb8IgFKoCSThrL1uYo+rU2OQrPFTm9
         jYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055243; x=1761660043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1uPpgCzD3AeHCNNke18aEjl14Z6hp7FAEQ6jf9bPwA=;
        b=RYWTDN6+Agga0Wd25W+Rgi7XLhCEC63PKtstzU3f/1pKZZ5QYFtFRAtBTEkk8O38mG
         i1bd2tYLpaTUqxpK9UJXf8Qcv6do2XqxVYJjHY6HNsnGxhVkriiF3YPWpVZwb5E6ZJua
         rL8vZeeOWcJpfI5tulYKDS2Y5PeA8UN8Jq43ASI2TWRoKbeAiG32c81qeFakw5urqtSu
         l3lwCOMTIbiQnuq1aHStJNIMixPMLwnH2W125luc3FHECMWgP5bzr/H2+vBBKhkVDZKB
         6O0lV5ZX6PchzwsYilNDLgOwQJdsBn7ZjbAB1mNdYobISp6Tc2Fke7fcPHHEG6LNGbW8
         PoFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3sw+PGqROE7SSo4vsWOPpKgA85rdtVWis+7EybEtxJSCnSJxZ1O4HwHafvwVT+JG4phPrL2T0F6ooCzvO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy8k3bw/tmxdVB0zGXkbbJkIYxCO9AuqztLT1Xtp/xfUJh9yvQ
	E8rd5tMHFFTuSHagjZjRMBX5oB0z3Fk9plge2wHNyUAa8kBH3K5f53+Md9K5hszwC1ChBiqYo64
	lZQFPz5QJ7pRKetNXgA==
X-Google-Smtp-Source: AGHT+IEtB1Qc0jTjwzDO8cS4TUljoRm79vtwAIZ5o+NF+DLCupiUBxJPL1hs+MOJ512/JaHGq8aPH6579INvszY=
X-Received: from wroy9.prod.google.com ([2002:adf:f149:0:b0:3ec:e12a:e26])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2084:b0:401:e7a8:5c8d with SMTP id ffacd0b85a97d-42704d83e2bmr10026051f8f.6.1761055242809;
 Tue, 21 Oct 2025 07:00:42 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:00:42 +0000
In-Reply-To: <20251020222722.240473-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-4-dakr@kernel.org>
Message-ID: <aPeSCuFNrV-_qvBf@google.com>
Subject: Re: [PATCH v2 3/8] rust: uaccess: add UserSliceWriter::write_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 12:26:15AM +0200, Danilo Krummrich wrote:
> The existing write_slice() method is a wrapper around copy_to_user() and
> expects the user buffer to be larger than the source buffer.
> 
> However, userspace may split up reads in multiple partial operations
> providing an offset into the source buffer and a smaller user buffer.
> 
> In order to support this common case, provide a helper for partial
> writes.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 2061a7e10c65..40d47e94b54f 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
>          Ok(())
>      }
>  
> +    /// Writes raw data to this user pointer from a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
> +    /// truncates the write to the boundaries of `self` and `data`.
> +    ///
> +    /// On success, returns the number of bytes written.
> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: file::Offset) -> Result<usize> {

I think for the current function signature, it's kind of weird to take a
file::Offset parameter

On one hand, it is described like a generic function for writing a
partial slice, and if that's what it is, then I would argue it should
take usize because it's an offset into the slice.

On another hand, I think what you're actually trying to do is implement
the simple_[read_from|write_to]_buffer utilities for user slices, but
it's only a "partial" version of those utilities. The full utility takes
a `&mut loff_t` so that it can also perform the required modification to
the offset.

Alice

