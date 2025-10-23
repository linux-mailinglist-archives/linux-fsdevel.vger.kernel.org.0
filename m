Return-Path: <linux-fsdevel+bounces-65279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415EBFFE77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C47F4FAC95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381752FD1B5;
	Thu, 23 Oct 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSgWDDHn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8B2F39CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207882; cv=none; b=hziIgMzcEuxbi+sejwbyJliHGcwaDdxZZU2BaWtNIX/t8ZNt+lmGVpy9hce7A34zFapBIUgG+CVFz/sQkU3EPtdRZU71uq8HnrFpzOmn5XXpvkkTppWxqQoNjKczNnfgc1PR9qG6PNSA6gcxkDEKHNW5FWmnXxSHvLmCAdHyOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207882; c=relaxed/simple;
	bh=mPm/G6LF4D7ftdatB1aDagh6p6TkQy5ofCUYvdeEZZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UPSxHPPsXWJiubkpeHSChlEsEgYsa4NoXnCZMHfhU9j4zYcWpPyqLLuVvzh1mgTvHxRtPxBCQSDtyr282kJCOm8CZfBC5s9/7MdcvphYRrnnEq6d96xh+8KEs4oAGJWgoGI0GVvH57GVmJATUEE1cLyWqG8IHQBKqxka2w8Eiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gSgWDDHn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso1920065e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761207879; x=1761812679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWL5Ken7nj71m4OC5w42brfuU7IImlNx1mbsco2vxt8=;
        b=gSgWDDHnJGYmwGIdrypEmDfwxnwApsgt5olDxGaNmLchNQkxd3U386wYSPuwGuD3Wb
         lVJ+VIGL+XENccQk2WSCNOv+dA/KaGobnkX7/wehuacDNggG8592qIellNTkXZ6uwKCi
         6BtaoCWE9Dqy8jKV4QnYT4KedW4vEpzFXDm4WbkTbg2MmRg2OKyQT0xzqOw7Dr/dTmaL
         hjRIC7/eVY6bRTOG2dyVGjeFdZeG7N4d19j9NRT88eiDDHzrAYiEhvQV+pMGnKC5kI6q
         NUKCuhKB04gqEXazZ63QyCLQi/n7w/bc5HH0qFl9yI1KQgU6Ymxwl6iasovtNsHolLnJ
         S27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207879; x=1761812679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWL5Ken7nj71m4OC5w42brfuU7IImlNx1mbsco2vxt8=;
        b=aubdpsdhLxbbn3K7xyX9287WCPDWZAuAcgMoFN0Roe3MMMAv/eFAR4WkavGLLHkKYY
         SozWCgJIIJmOqh95otqWMInAt8jA6+duJEtdeCJjGymuh4Ryj0z64O8Kf+MDon2EyLOE
         kBUejSTwZkd8c3vX6DWlW8TKcYDuB5y8MPJiXuuWV58kl/X1d5kXvdB6s+SpSU2OPCXO
         esjCeMAWyVh4Opcm5Lch8L1DwjhvYvJDUVDvVXS3KnzgfFEazax1kpAS6LUT5voGyTbE
         jFjzE1JUSzTi2AYq9wXruGeINL43/aACpZjdRlZw+7iHykGG8wOKLgWOTLEBCmLEfwYz
         i9Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVU/mXxJllYxQnVsH+vOs/miBBb5WJkzAXNYmu3yIujRYu4o8Jztj2QS7l6ssTQ2mA5XXUtF+Ccbh+R+9qi@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ891Gj32rp/VGRGDjzbxAUp3Kg9WUtD6bmDFt2vZB9eWXsTdz
	2G3zd1QwIHsFt9RWpi1gKVv4HRCuZAzQ+3kgqipW0cSRK9J7+VTVILXMArO86Rs26SiYwdET/Ij
	+oeoFEvlmcFtWObvnLQ==
X-Google-Smtp-Source: AGHT+IG9CY0EOkHtRRihqXWBOF4xpRsbIyChrOM1QL3oPkUpG+EWq+Zl74uct5FqSuMTOhxCZDqRJe4FTo9EuzY=
X-Received: from wmwj10.prod.google.com ([2002:a05:600d:82aa:b0:46e:3212:7c8f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5299:b0:471:95a:60b1 with SMTP id 5b1f17b1804b1-471179192d4mr213973515e9.32.1761207879258;
 Thu, 23 Oct 2025 01:24:39 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:24:38 +0000
In-Reply-To: <20251022143158.64475-8-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-8-dakr@kernel.org>
Message-ID: <aPnmRmTHLQn8FVyy@google.com>
Subject: Re: [PATCH v3 07/10] rust: debugfs: support blobs from smart pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:41PM +0200, Danilo Krummrich wrote:
> Extend Rust debugfs binary support to allow exposing data stored in
> common smart pointers and heap-allocated collections.
> 
> - Implement BinaryWriter for Box<T>, Pin<Box<T>>, Arc<T>, and Vec<T>.
> - Introduce BinaryReaderMut for mutable binary access with outer locks.
> - Implement BinaryReaderMut for Box<T>, Vec<T>, and base types.
> - Update BinaryReader to delegate to BinaryReaderMut for Mutex<T>,
>   Box<T>, Pin<Box<T>> and Arc<T>.
> 
> This enables debugfs files to directly expose or update data stored
> inside heap-allocated, reference-counted, or lock-protected containers
> without manual dereferencing or locking.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

