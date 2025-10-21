Return-Path: <linux-fsdevel+bounces-64934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB3BF703F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467C2545497
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB7A260580;
	Tue, 21 Oct 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nr19N7c/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC46126BF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056317; cv=none; b=g6dtdcN0JZtI7qOXRKZhnVA85j7VMwzR8HfF2990oUrjdCEDebCxL/L/W/zlfz/Dw7o8+mPk9oWlFev++iRyQvRjkQk3PysYucj53v5YJMQcT3CQy+A1QUukxgfE9+vNTaY1gwnPfGguOXga9LwV38pREl2Rp74qXV4IF4wYBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056317; c=relaxed/simple;
	bh=G2i9yWySi/v48Ebjji4Nj64nKEyYHuwWB9jaEsUT3DE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3AVTjGnuLDL3Uwzq57aZVV2hD4kDDQfO1exHV6r8MmNupnSKO1812ZnyGX5EnHcCfyqO9rx0it+nC9DCKxSVEagkABxketrcUo5uN1YhtaLEzpzaTbabhzR4aDwa+GEmmFMZ3jrjw02NE5UvjJNnR774tengcQDM3wNT61XXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nr19N7c/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471005f28d2so22009085e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761056315; x=1761661115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQdVaPHWC5nGyUNhdHevRrTzZGcav457nDokZnpXcmE=;
        b=Nr19N7c/h7d3fwRpb/h99ELNWkelev9MnkLSsHQYj/hgySVTaxLPQ3lmk+kYq71S+i
         HzaiYbdcMBNJuhqR181f/QT0wXfb8gW07E+jLF5DmJhtcYRN8Wy3rZsJx6JSlA0oB+Vz
         X+2b21zooj7+DO7qMd7EdzZ8+5LGQblVGExoBiI+AhkY3RGWl2iBllh2WKFF+X1Ofsnt
         ofq25V94OGZYabq7VzgjB5BivLb1QEqfYBVXEcNKIjRbPsSIQtQ//n5XEw25bftLAmH9
         TrAknecx76GQm0oLNJVUgPfT3hpQG5fTzdiC0V1Ww2R/FKqC3m633PO5BXoLKw81xUNj
         7P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056315; x=1761661115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQdVaPHWC5nGyUNhdHevRrTzZGcav457nDokZnpXcmE=;
        b=ATFLNoBcr1o82nr1gCvdKVnP1vQW9fYD/qCGBdf7Cz1xa8C5/5zsjzVWs6truRWZ/3
         jSLwPCvGmb3Zl28vtiv+iMcO7bFBLXsGWBriTedGFiJIDdUASyiWA9JU3Dngty1QWjI6
         3ljfcgYyr904asPtcrSWToyc2c0370+kIiRgpLwrzB/z6LsZA/PVTpsPTpix69RRTcby
         5Y12xeniRtImbTSEpy8doS83kib3Yv0QLAOTqGVEHWgr0qs4EvTv0DD6LftDDtLahQe8
         BpI6/oVtL22cZBcKqvHU5Z6Nzk57/znsmhJdPwwjpVhAY59PIMx7vQPuXDfSUnkkBugm
         tnOA==
X-Forwarded-Encrypted: i=1; AJvYcCXI0e0vntk2KWYkjg7E9wTdHNCSFF/y1bemvklqFmKDR/bM8xgi4tj68U9unpb28fIS3jpeAi6lDA6BYrf6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gTE+2gY6MFjYQUY5sKHefK02aK+LRCf1SdGRL4RL8ffbObwf
	JsnqAj9lTWVc0W069pNLN3I70hhmRS7mwLqrHJzHdemiGS/EgZ7Ve+deSfx0dUgZoFKr9BWytvA
	Gnt9MXkUfum6HyA1i5w==
X-Google-Smtp-Source: AGHT+IFrZyky49hPiz1bF4Hr0vaY0X6dj1C9mLZbtlTkEVUM0X8fV7t9NoWsF4Vvt3U68ZAUeguXBFFNKpmc0+0=
X-Received: from wmcq11.prod.google.com ([2002:a05:600c:c10b:b0:46f:aa50:d701])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f10:b0:46e:59f8:8546 with SMTP id 5b1f17b1804b1-471178afb7amr119090415e9.17.1761056314830;
 Tue, 21 Oct 2025 07:18:34 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:18:34 +0000
In-Reply-To: <DDO29UN4UBVV.E90DEBURH63A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-4-dakr@kernel.org>
 <aPeSCuFNrV-_qvBf@google.com> <DDO29UN4UBVV.E90DEBURH63A@kernel.org>
Message-ID: <aPeWOhycOIl_rlI-@google.com>
Subject: Re: [PATCH v2 3/8] rust: uaccess: add UserSliceWriter::write_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 04:14:22PM +0200, Danilo Krummrich wrote:
> On Tue Oct 21, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
> > On Tue, Oct 21, 2025 at 12:26:15AM +0200, Danilo Krummrich wrote:
> >> The existing write_slice() method is a wrapper around copy_to_user() and
> >> expects the user buffer to be larger than the source buffer.
> >> 
> >> However, userspace may split up reads in multiple partial operations
> >> providing an offset into the source buffer and a smaller user buffer.
> >> 
> >> In order to support this common case, provide a helper for partial
> >> writes.
> >> 
> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>  rust/kernel/uaccess.rs | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >> 
> >> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> >> index 2061a7e10c65..40d47e94b54f 100644
> >> --- a/rust/kernel/uaccess.rs
> >> +++ b/rust/kernel/uaccess.rs
> >> @@ -463,6 +463,30 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
> >>          Ok(())
> >>      }
> >>  
> >> +    /// Writes raw data to this user pointer from a kernel buffer partially.
> >> +    ///
> >> +    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
> >> +    /// truncates the write to the boundaries of `self` and `data`.
> >> +    ///
> >> +    /// On success, returns the number of bytes written.
> >> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: file::Offset) -> Result<usize> {
> >
> > I think for the current function signature, it's kind of weird to take a
> > file::Offset parameter
> >
> > On one hand, it is described like a generic function for writing a
> > partial slice, and if that's what it is, then I would argue it should
> > take usize because it's an offset into the slice.
> >
> > On another hand, I think what you're actually trying to do is implement
> > the simple_[read_from|write_to]_buffer utilities for user slices, but
> > it's only a "partial" version of those utilities. The full utility takes
> > a `&mut loff_t` so that it can also perform the required modification to
> > the offset.
> 
> Originally, it was intended to be the latter. And, in fact, earlier code (that
> did not git the mailing list) had a &mut file::Offset argument (was &mut i64
> back then).
> 
> However, for the version I sent to the list I chose the former because I
> considered it to be more flexible.
> 
> Now, in v2, it's indeed a bit mixed up. I think what we should do is to have
> both
> 
> 	fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usize>
> 
> and
> 
> 	fn write_slice_???(&mut self, data: &[u8], offset: &mut file::Offset) -> Result<usize>
> 
> which can forward to write_slice_partial() and update the buffer.

SGTM.

> Any name suggestions?

I would suggest keeping the name of the equivalent C method:
simple_read_from_buffer/simple_write_to_buffer

Alice

