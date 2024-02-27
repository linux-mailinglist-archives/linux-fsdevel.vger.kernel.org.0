Return-Path: <linux-fsdevel+bounces-12922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED1868A41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 08:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79201F23E4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031955E78;
	Tue, 27 Feb 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="UgaYbcSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913A55E5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020512; cv=none; b=FfuOPG4VFdOn3FeqcHLFzIQ5+QdGpTb/4mlYImuGfkmE9KNzL7MYShW2OkHIUp2RZVQg9ixTyOSwCGFedRTwMfzIYVTCeYwa6xMYxDZTqx0in802f9MwwWYpZjJ9VJcG8EYFrRbi8NCLaLaNRpl6dlwwXkcCDNXs7Bn6K8aV3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020512; c=relaxed/simple;
	bh=3YwsmNBwEGfFj80aTMlJdL8VkTAwnCvoWa6TqLDGUZo=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Ca8EnbGGqYKtSFaR2qI/SE0CDYaAz+c/q3Yo59S3RnFGDOFBwgvGXQEO00/BJfVJx68gMK6vgBzYe0BH8Tr3GEjSk0Td/Wvftv8PbHhP3Gb846qeTS7G5yJpc0gt7jG2c4wSjsi8NscdDaOHN7Obd4vbv6Xblo4Hvzv266spjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=UgaYbcSP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so4744065a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 23:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709020509; x=1709625309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YwsmNBwEGfFj80aTMlJdL8VkTAwnCvoWa6TqLDGUZo=;
        b=UgaYbcSPPuR0qfAeY3WHmzTx4KWfdJontpBGC9yst8NpamoC5+7xSGoJrweepUm31J
         Zk0FXqIA+MILtoIdXwkqtC5ybZrV/hwIvCvmltVrpftLj0I8gOtgYwNWbrY2mwBBuS2f
         kxu2XObfEy3/UrZXQCyWh6F0LCqkup95vVHDzABu4cqFJGSqxOKj3QaPFms9OEo7rGQp
         whCVXEeK9F4VtMAcN6IWwdp3aVjQg4j+iJk3XTLI/BidVl3JelGWfxE7MIj2Hcz2vJHD
         grGRDLhXyvwkJZqRHvrjheZg1Wgq7dPtQREmT9uH0K3aQwYztT4VO3vbnNMkbEZpoXeN
         T+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020509; x=1709625309;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YwsmNBwEGfFj80aTMlJdL8VkTAwnCvoWa6TqLDGUZo=;
        b=MzKmqo+38tvo+jpNOWpoZoOTIkkO8Piw2p1bIdxtmOms4T5ntPOsuRwHXe+KGLogMA
         K0bn0WA2Bw/HYbBRaosNSrK8D1llsehi5eYzHrLy9SuQAL+gq/bA3UDOPuhtngMurAbm
         JKSaSZxKAtiOHXKLKAlRw/iS8ebezbOxl86dWVJgLJH1xMTvNijC5EuQtoniT1FqgbAV
         BVAv9eENTOyIbRmKl8wcg4hPxUqz3rJvK3wNYIh1yeN9gWlVjmWKT5X63Tx7jpSXVJsK
         Ax4zEgfQNFmCu79k2nuF9Wk+2EoMVIqsSL9vTiH3FG8tE6QQoeY2k8bZQzVN13rJZT9z
         N0uw==
X-Forwarded-Encrypted: i=1; AJvYcCUGo68vDBrao2QSByS0F9UVyvQJpNiMb4J8BT6dBT5hlceutNzo9IejU3SObHzd1JsU6d71Ve6fouZsduMFH0eYK5O87FZvzsTGWTHrDw==
X-Gm-Message-State: AOJu0YyhS2vKTgt+Q6/GGt7NEGga5RV+NzUppd8S5EzXXJNn6neKG92H
	q/nrIYMrDllhDO/QDX95txhqFubHUVyq7JrF3Mn6C2llsm8MfaBesF4AnYVBqpQ=
X-Google-Smtp-Source: AGHT+IHZCKU4F4DqNwk9h+g7iJIh22fZJJ9J3NRhYCTuQGFEiinICXGF2Bdlgkihac4kau8kRK6vAQ==
X-Received: by 2002:aa7:d898:0:b0:566:44b4:ea58 with SMTP id u24-20020aa7d898000000b0056644b4ea58mr285530edq.38.1709020508661;
        Mon, 26 Feb 2024 23:55:08 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c408000000b0056200715130sm502183edq.54.2024.02.26.23.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:55:08 -0800 (PST)
References: <20240209223201.2145570-2-mcanal@igalia.com>
 <20240209223201.2145570-4-mcanal@igalia.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: =?utf-8?Q?Ma=C3=ADra?= Canal <mcanal@igalia.com>
Cc: Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH v7 2/2] rust: xarray: Add an abstraction for XArray
Date: Tue, 27 Feb 2024 08:54:25 +0100
In-reply-to: <20240209223201.2145570-4-mcanal@igalia.com>
Message-ID: <87plwi9waq.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Ma=C3=ADra Canal <mcanal@igalia.com> writes:

> From: Asahi Lina <lina@asahilina.net>
>
> The XArray is an abstract data type which behaves like a very large
> array of pointers. Add a Rust abstraction for this data type.
>
> The initial implementation uses explicit locking on get operations and
> returns a guard which blocks mutation, ensuring that the referenced
> object remains alive. To avoid excessive serialization, users are
> expected to use an inner type that can be efficiently cloned (such as
> Arc<T>), and eagerly clone and drop the guard to unblock other users
> after a lookup.
>
> Future variants may support using RCU instead to avoid mutex locking.
>
> This abstraction also introduces a reservation mechanism, which can be
> used by alloc-capable XArrays to reserve a free slot without immediately
> filling it, and then do so at a later time. If the reservation is
> dropped without being filled, the slot is freed again for other users,
> which eliminates the need for explicit cleanup code.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Co-developed-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---


Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


