Return-Path: <linux-fsdevel+bounces-65282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2869BFFF1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7373A98BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8880301036;
	Thu, 23 Oct 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn3uAyTp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE12F60A1
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208401; cv=none; b=uOwLzh2vJdY2oY9ZoI+o1tFWdULBIezmpN69kuEGlmQgvGrxmwmxKE0GMH+RU8fqtyX0YFr7jwyLKdKHzF7Bt4h//fb2C4cRuKK86CrRhPABTZRaBrqy0Sk33l4gRF0KJlSCBbt/yj25G2GxU1pOhxU8yNn3yXZlu6bljjbg48g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208401; c=relaxed/simple;
	bh=95BBx0N6TTDSlDipX2dEd1oikvREJqh2uSWq00ZjafQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LS5sIEfbCxf8f0mMMeFd52oImdTP/IS8T18HBF7WLPVMihJWGrUGo89AkpqAoFR0Q4BOeLCyI8tIdZW+8NwuOkhJ2QbDlxuSCkUdXATyTOJ5/6mxxP0HuX9tt503X2NJKpIbxQBZ25DMc7QZU38nDVBCf/P4f6abVzHt4uAKT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hn3uAyTp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47114018621so2538685e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761208398; x=1761813198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ie4N2D7WeIm5MD0Mtp2EzbYFuA7xB5fPMSvsn6jA/5I=;
        b=Hn3uAyTpgM6AxQwBhn79nMJJpIGmutBZP7OiQ/6je5F1gGtQgFTwS3c2vCl+kdm87g
         adymo8b+gouE3YfDnJ9CsPL81M4r+nwx7MoprZgX2Xliu4c1s0IeGp+1ce0pS8GISy5J
         zOdKRxEsb5SPdTpp0xMj+w5FYJpjNImT+qGbDeR/aqIHOm2rp2iNX2sdMDSoI/J03JyW
         CSgT1VyXE5z+83Nu7fDnlXbxTvKVMhLgP+wUAJYiHNEDq+Un4oCLM6sijCOtTh8TkqnE
         EX/oNt2Tx82jhpHpDuTGSZ8O1GvfKZnXFdBGL/KnSR3d5bxbwb9GjD0srJz+I0IN5C2P
         K8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761208398; x=1761813198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie4N2D7WeIm5MD0Mtp2EzbYFuA7xB5fPMSvsn6jA/5I=;
        b=Mx0xL6OWLF5jd3G3Y/7gls0iUVcTxBsj28NR4ePBDVEjdSKdDBpVq6CsqWcClDMmG3
         PTIcBGXMrnPYkB06N+gvFp0YfKwEzew3Psy+xNvfjMHibX/Y4KLkaLBdaGJNFWBa6s/f
         6INrHdjW0esydKrOKgPWP9/+D7mxUytj/GJ2vHLsiR3aAhXLVsacOMJANnHIfHA6lfWj
         8bWMFAAAgBYWSuYtE7tJkw4vzbW1i92qKgdOrGBoXicGYj+G/RFwuxTcjLBR/KgNk0gv
         Nma8woXWazm+oHqVf8g7+4vTdgf11wWytxGs5C0cU0T88mVLnOSxKUjxweMafVPGnOxg
         5I2g==
X-Forwarded-Encrypted: i=1; AJvYcCWoOAYoiKnceXNTAz8/LGalrRKmYAH+UyzXxY4SKQQ42KhnkpQfzXYXZ47DwTpjw6fosFw2TaBuIud4E3DG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9d9pP67h/XcOJzbM0VCdk499c0yN9USOTQJq84T2114veaB2H
	9XRyqZwCUmRpRJ3kWVypjHwcO0V/OdIiNRRhiraNHNQRyyVI74km558sffCmIDh3jAlnDbZK+9G
	VHUYNrM5VYmBBey16HA==
X-Google-Smtp-Source: AGHT+IGHUa/yiToOj16eIMkm1RBlK751eMwtuxfS81sGj6nLXimsltw19mYAVHQ2QyRYiBwmDUvGAwA04Or+SbA=
X-Received: from wmmr6.prod.google.com ([2002:a05:600c:4246:b0:46f:aa50:d702])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e07:b0:471:c04:a352 with SMTP id 5b1f17b1804b1-4711787674fmr164862685e9.4.1761208398380;
 Thu, 23 Oct 2025 01:33:18 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:33:17 +0000
In-Reply-To: <20251022143158.64475-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-5-dakr@kernel.org>
Message-ID: <aPnoTV4kPz5NHGBE@google.com>
Subject: Re: [PATCH v3 04/10] rust: uaccess: add UserSliceWriter::write_slice_partial()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:38PM +0200, Danilo Krummrich wrote:
> The existing write_slice() method is a wrapper around copy_to_user() and
> expects the user buffer to be larger than the source buffer.
> 
> However, userspace may split up reads in multiple partial operations
> providing an offset into the source buffer and a smaller user buffer.
> 
> In order to support this common case, provide a helper for partial
> writes.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This code is ok

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

but:

> +    /// Writes raw data to this user pointer from a kernel buffer partially.
> +    ///
> +    /// This is the same as [`Self::write_slice`] but considers the given `offset` into `data` and
> +    /// truncates the write to the boundaries of `self` and `data`.
> +    ///
> +    /// On success, returns the number of bytes written.
> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) -> Result<usize> {
> +        let end = offset
> +            .checked_add(self.len())
> +            .unwrap_or(data.len())
> +            .min(data.len());
> +
> +        data.get(offset..end)
> +            .map_or(Ok(0), |src| self.write_slice(src).map(|()| src.len()))

Isn't it more readable to write it like this?

	let Some(src) = data.get(offset..end) else {
	    return Ok(0);
	};
	
	self.write_slice(src)?;
	Ok(src.len())

Alice

