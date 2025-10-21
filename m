Return-Path: <linux-fsdevel+bounces-64932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BFBF6F66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 16:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0959E505878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656333B941;
	Tue, 21 Oct 2025 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P4ieSrPW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D29239085
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055397; cv=none; b=bvSa8AJo2a560doYuD/Dv2ShnGkzpv6CkvW4uVNtHWJ/RtY9D3obC5dnSU+Kb0El8datRZkbW1yLeJo2CKLkeMSOHnLyb5dE4xcgQumpQ57qcnEknK2srd5Fyd9vZlDMATjMEDVtIyRxhIZh+9s8ufmkRi/Y/n0LCo4FnUcG8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055397; c=relaxed/simple;
	bh=7G4waim0VeJfYc5UImM1ILNYZsWnKxbZqSwSOW0PnuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gg5b/R2OQWPLx/zOCQGiZ+lZG+MJG8l7dU+rHtrnyLPDuheAevU8n5vk+bxcD9t7bbdXjeJ7qi4spxiJ+xjjD4FgSgESAqWEu52WCv30gS2rQICG5iDbmbhAz6CTv1oKqTQVUFWl42wVWppVcsH6j31jwO0FiGXp/JJUkht2HxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P4ieSrPW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4710c04a403so59280395e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055394; x=1761660194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=shyGPfyT7UZA3DJZBC7WKsd1LwTAS0uHQ5zFBJIRGN8=;
        b=P4ieSrPWVKoIm/lC3yWjg90PbSAHzu3T6Sau4hmFsN5Jl9CtRaakSvc7ZkOI6QTOQe
         XKgoscI/r/u0QTnA7/0AkCw0Q/TLP0eduwPoMFecMAbE71mpni7DRRuzM8H/a5eXOv9a
         rrpU7GG2nl0LREd8G0LXkWDNCxyF+MsYGCAsWojwBdraHihmkAx48xnyea76gWYHprS6
         cWB0mVcViBFFvnr9x6hSSYEIGjRSzYvkCelD+okad2MoycQl8oOWJIqIZpObxJ24SEDc
         pFG9P9g9dBAmKUUHgGVfpaOdGCSi8UyNmPSCoPdN5knzuXF0+0c9hN7CZEjIIAfbutbe
         iQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055394; x=1761660194;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shyGPfyT7UZA3DJZBC7WKsd1LwTAS0uHQ5zFBJIRGN8=;
        b=cPgulqYhsNXHXHIf53CW4TY/UoIMMZBnlxHAx2rRZxTcRYseYRrWDz2iUKYwaB8kBw
         aZK9KIYaOwT0+qOIpvpXmlL6m1LquVAyV7ti8sQMzt0pFVS8302A57ldunJX7s6/0WW5
         NRlf2yVw5JRDYw1dEkIQj4+5xEzkbZXZJvCHQb7RknrqWuI5TiDMrQb5JuVPmkPSwktW
         FszJ2UppRY5U9gJy2LgdFzMYD7O1gCnnDdxiT852fgdv4UgqbpMy7P52jQ8ND0lcWwA4
         Ffr3OMkTo+NxWpQBwEMclD1sRy5q8gJaQLP0o75BM1S1TQuC5sprHaIcB4cnBsPADkhR
         cf+w==
X-Forwarded-Encrypted: i=1; AJvYcCWR3fQ3Zrk9rdd4bxTfiuD+aFKwijJHumcAPsunbJS/QpjKn0iATFDfxcZbJk+ycwoHrkmaA/OIikLEEY1U@vger.kernel.org
X-Gm-Message-State: AOJu0Yykn6HjNMgIJGT87OfglcCpHSs9FwXrPOwLf/pKm2p6LicB7Zvo
	/64rACHGr3BDtFz0mFRZiJaoQ12/HbvWqeR7yYZu9YAw5xNamnrhV/QAj3WxC2bXpMKpkLDWlvM
	ARElY2DKz2DhXok2EJw==
X-Google-Smtp-Source: AGHT+IHLLpKviw22ar27K/HuMjAHYEeLK4Z0OurwlILZBXJxSn9ItdjvEht0eB96eARzWNyuDiLwIyb22ASCFMM=
X-Received: from wmc7.prod.google.com ([2002:a05:600c:6007:b0:45f:2b4d:3c2b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:681b:b0:45f:2ed1:d1c5 with SMTP id 5b1f17b1804b1-47117925e39mr133621965e9.36.1761055394121;
 Tue, 21 Oct 2025 07:03:14 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:03:13 +0000
In-Reply-To: <20251020222722.240473-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-5-dakr@kernel.org>
Message-ID: <aPeSoet6KY9kxzqX@google.com>
Subject: Re: [PATCH v2 4/8] rust: debugfs: support for binary large objects
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Oct 21, 2025 at 12:26:16AM +0200, Danilo Krummrich wrote:
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
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

> +/// Trait for types that can be constructed from a binary representation.
> +pub trait BinaryReader {
> +    /// Reads the binary form of `self` from `reader`.
> +    ///
> +    /// `offset` is the requested offset into the binary representation of `self`.
> +    ///
> +    /// On success, returns the number of bytes read from `reader`.
> +    fn read_from_slice(&self, reader: &mut UserSliceReader, offset: file::Offset) -> Result<usize>;

Maybe this should just take a `&mut Offset` to fit what I suggested
under the uaccess slice patch?

Alice

