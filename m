Return-Path: <linux-fsdevel+bounces-13058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730C86ABCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76DB287125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 09:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306A4364C0;
	Wed, 28 Feb 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="icAGfAtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08CE36123
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114337; cv=none; b=QlvFsNE3m6wQE9QfJ6Odf5+ql7GKnLIbZHDKNug7GEjuDYZlf7rSvSeDDMo7AGOowJXNHVhQzMKniW6+ig9Fnl3t/fAARpP4NMr4u61l1RHdAVBK+lw2EUttylJVHVoYR+3jAlcA/1Sa4YFQ3IKcbZOlFEi6jl910umI3hCruxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114337; c=relaxed/simple;
	bh=sleA26mV/tde50MP5rnI4lqz6QKoKHWgsEtYcy8hAeQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=u5MXzDXPyttpd1BVgPaYxudOHuAvB2DJPgJKL+dYnioKj72nO2ES2j/058WgnOHdp884zbp8ZCFY6V/sp1dtUsvgVBOjoIhIiZhEVMn6YUTpJlHYlIjlHD+7kjQ93eCWb1/8nYzPPEPJc36JcLfABsc1QqG1YXhSZOGmM7WgbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=icAGfAtG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a293f2280c7so802937566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709114332; x=1709719132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tZSFA9TNC8Nuqr5EXNMkcxxuNUWYaw6b2s8R1XXBEs=;
        b=icAGfAtGBoyiuE+sXv/sfMoq5UqBO7EDQuP9lHWh3F4JAGfOaRcLrSeoOJqqKCpS9W
         mA/JiyD66pDLWyA0SQ53xr7TZChPtdp2HZFXQK0Oid37TgW/6bIufypipa/4T0u5Syb8
         4jbEUuwbtluIVPhDzICyNtUXbJRZ80KzmFPWY2upLHiKLt9ox7pawZQ2FZqXWOB/iH4g
         hoPKtfFPX8lt9RZhhf6eA9cpzQz5ZkzfDLs82QoymcmF7aOaT4UCHeWUBqC0L/Hwc9Wq
         sgPwsYt4VyWfHxaBK9tmIgfoC4Q2ay1FgRtf7IrhFyJBM0QjaKkhwo/YuCIWrQxOX+y1
         YYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114332; x=1709719132;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tZSFA9TNC8Nuqr5EXNMkcxxuNUWYaw6b2s8R1XXBEs=;
        b=SSk5wZ/4r2C+u9B0y8kxLNVx3S3gQX2aWjD4Zbkm22IMf2iXNSOpkjz047pAkeNuFT
         NFBxmw1ydXXP2i/NZH6SDHH1U6TwQXKo0DfTC9+uFwWUyovHfW9ehWCfCT9H27nahZLl
         /nD6b4WxrhB4DiLd6bBngBIEfmIvwewHTEQBXluzGIENs5pIqeLnuQ3J+VE+/oqVam9P
         VqP2RBzijr7ifJOr4YOdfbgStPNmsUBN4/U7pM3a1bD3nBzsNXX6QUGg/jB7y7kgAHno
         2wtaLcpjMeheiaMdm36oP0YxFR/OSzbFQheKQ6hpJvGxqNyD2+NqSpo943U57SFuxiZ6
         qIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpTfISziijLh4Dl/UVNq++VpYFuDzXtF5u0Il+yGCudLortUakAZgrmVA0OJ/oHgZubH679Izq7cuystf6Di8tiw6cyEjcMx6cC7QyTA==
X-Gm-Message-State: AOJu0Yw1zaAQ6x3i1eB4Wo//0fJY7cDsbIrtTlNcm+eGmOv0w+4oO/vC
	Na62S95kCzjWSNNfjXgMXN2Zw9x79eNw+NUeZKW5IjSwYTOmspe9wTMTLhB1IyLPUhWzCkYnTUS
	g
X-Google-Smtp-Source: AGHT+IFXvcS3SdW+x9XVkAFE4CV7oMvqgtzV0IZUMaJ7OLxvJfmzwEJF8ZwFxnNeHHgrppTXGMcNyQ==
X-Received: by 2002:a17:906:882:b0:a43:5dbc:4c04 with SMTP id n2-20020a170906088200b00a435dbc4c04mr4818890eje.48.1709114331601;
        Wed, 28 Feb 2024 01:58:51 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906c08800b00a434b5fcab6sm1671082ejz.221.2024.02.28.01.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:58:51 -0800 (PST)
References: <20240209223201.2145570-2-mcanal@igalia.com>
 <20240209223201.2145570-4-mcanal@igalia.com> <87plwi9waq.fsf@metaspace.dk>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>, Asahi Lina
 <lina@asahilina.net>, Miguel
 Ojeda <ojeda@kernel.org>, Alex  Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy  Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Matthew Wilcox <willy@infradead.org>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v7 2/2] rust: xarray: Add an abstraction for XArray
Date: Wed, 28 Feb 2024 10:56:41 +0100
In-reply-to: <87plwi9waq.fsf@metaspace.dk>
Message-ID: <87cysgap0u.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Andreas Hindborg <nmi@metaspace.dk> writes:

> Ma=C3=ADra Canal <mcanal@igalia.com> writes:
>
>> From: Asahi Lina <lina@asahilina.net>
>>
>> The XArray is an abstract data type which behaves like a very large
>> array of pointers. Add a Rust abstraction for this data type.
>>
>> The initial implementation uses explicit locking on get operations and
>> returns a guard which blocks mutation, ensuring that the referenced
>> object remains alive. To avoid excessive serialization, users are
>> expected to use an inner type that can be efficiently cloned (such as
>> Arc<T>), and eagerly clone and drop the guard to unblock other users
>> after a lookup.
>>
>> Future variants may support using RCU instead to avoid mutex locking.
>>
>> This abstraction also introduces a reservation mechanism, which can be
>> used by alloc-capable XArrays to reserve a free slot without immediately
>> filling it, and then do so at a later time. If the reservation is
>> dropped without being filled, the slot is freed again for other users,
>> which eliminates the need for explicit cleanup code.
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> Co-developed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> ---
>
>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

Actually clippy complains about use of the name `foo` for a variable in
the example. Fix:

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 849915ea633c..aba09cf28c4b 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -185,8 +185,8 @@ fn drop(&mut self) {
 /// let arr =3D Box::pin_init(XArray::<Arc<Foo>>::new(flags::ALLOC1))
 ///                        .expect("Unable to allocate XArray");
 ///
-/// let foo =3D Arc::try_new(Foo { a : 1, b: 2 }).expect("Unable to alloca=
te Foo");
-/// let index =3D arr.alloc(foo).expect("Error allocating Index");
+/// let item =3D Arc::try_new(Foo { a : 1, b: 2 }).expect("Unable to alloc=
ate Foo");
+/// let index =3D arr.alloc(item).expect("Error allocating Index");
 ///
 /// if let Some(guard) =3D arr.get_locked(index) {
 ///     assert_eq!(guard.borrow().a, 1);
@@ -195,8 +195,8 @@ fn drop(&mut self) {
 ///     pr_info!("No value found in index {}", index);
 /// }
 ///
-/// let foo =3D Arc::try_new(Foo { a : 3, b: 4 }).expect("Unable to alloca=
te Foo");
-/// let index =3D arr.alloc(foo).expect("Error allocating Index");
+/// let item =3D Arc::try_new(Foo { a : 3, b: 4 }).expect("Unable to alloc=
ate Foo");
+/// let index =3D arr.alloc(item).expect("Error allocating Index");
 ///
 /// if let Some(removed_data) =3D arr.remove(index) {
 ///     assert_eq!(removed_data.a, 3);


BR Andreas

