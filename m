Return-Path: <linux-fsdevel+bounces-45098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2933A71CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126F07A5460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444F1F8922;
	Wed, 26 Mar 2025 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ulq3LNU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E81F472E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009189; cv=none; b=RPZehEFpH4iSRJhuZhKmBdmfe0qY6eo1pro5nBdz1xRA1JfG/PgSf8zX1ykQ7Jdgb8emlpcqQDqMIW3B7u4ZNRYKIEuiytctV3nRl3LFntnvHBUPbqJaHJ+pkmcmQTLedg+RfzOtdID/Xv5R7I9YTf7qhvbg29D1NdRtIhRx3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009189; c=relaxed/simple;
	bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQFdl28AP95XzISZqksgOb1hFRCczYPvjAsW8vEA81srb0urm1SrCCdkm3p4ZtqW/xEJ+u7kb/K2CgXx6WLmURxRQd1uMMjFnkGESDqLhg9qZJI8iR2rMPa+vNyauoSngqDrAdYMq+4a8HJaJh4qrv7qOL72ZFEI9hdNen3hPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ulq3LNU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2264c9d0295so12315ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743009187; x=1743613987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=2ulq3LNUbq8QlmlGGFHsJyljuyR3endfuqLV47tEye+OYOrJwCV85qm4mkFkiAZi0U
         0c4XJv7YGjfFcA7rB0v3qD4P1fhGIvN0X4AtFZmGJ4VIsi93w3bjFz6xu8DJTjql3JJk
         +QKDyBwF2yuvM3X9Qzh5dBImn1IHAX+stvGP8t62JN+ag3D6HfluNYbG1G10obJA7kln
         HnPEWvyiAZ6aZMlWfQMaPzq0ceoh7FJTK+iJfqU7tv4VnPDW4JYcU8BK6lL8m7EYLgNQ
         nvqMPmo0IrDpxmnNV8iNmvojvksxKbqP1i2IpUB8QfzKgbcfYY2ag7hXW4oSK3lutrYB
         HxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009187; x=1743613987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU4zVqjsmoIfqvS43cfmupX6NzIQQKSAzd5QQ/IuB4g=;
        b=IwRTuSyKhTwyjvymdhys7rkmIiBGypFQ4k0yd3CtSr7m8TUDC2i8zDxVI6ZhIwu/KD
         c9M20sepkOrdHbTJUuYLM27kIEaVJxhE095KVPARWCjMa3NiytI8q8cFWtkrqYzXuuok
         B3mWi6iKQ0IBrHpM+v2EN78/drAW06xNsfcbSozwpmXGqgizT28+StHjLKeffTmdpOhS
         qtgkK3WuQW1UJ4POIanjTOEvm6scxI6OIoAfDblknSVG+2BvHwZPFpZq9d/lEZGs5i1O
         op1QBDQ/ilDVzpCj1XB22/bf6LnHRrGgzv5RlG0cdGjvCqk2QkBmXuovt7RGK8eymJnF
         lSKA==
X-Forwarded-Encrypted: i=1; AJvYcCV9E9o1TC+p0fph6b3xvDmk8h5KPFwz0WfGy4eAOeRPpknhzP9TqkFcYKFvJRn4v8NJwYZ1f/We76F0AZvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzXM3qXqXx5GDRp0LEIt7MbMha6zEry+kO9DxwBaUvJUPw5s8CX
	mEjjAwY/+0trXEoMl4pbVe3cv0BVvpHK9FWn/DQcnd6HJ5l7W/bRkzmLIUkb//AqN/DMBxt0Cpb
	EHxPLMkS4F2Hok0LiOcY8+Sv92vUrwV0tgSEA
X-Gm-Gg: ASbGncvp3sJQHmkU+JmyzIuRPxt+2Isj1Gvnth2RrMIdQzZ9Plw095HawTKlfBSyKeA
	6AmV7ROnHebqMIDKembKWtedZNYOLiNrQ/MACzICuwNlqRlDaTbwep1tEd5YaePeDBJ86FjbCKN
	eb2TzZGYzvcBa8CWFDPlQBadTDT8vJI4/AfTCCeMPcck31mGqK3aA0+3sX
X-Google-Smtp-Source: AGHT+IFvk39LnkeMkX25OX1JcG8F54jZn2W19dDnfX7iWusa4FMz7ouKzjv48eaBIVtkQbCfKLgP4xKq2VNnjn++uzA=
X-Received: by 2002:a17:903:13d0:b0:223:37ec:63be with SMTP id
 d9443c01a7336-227f365b723mr3316495ad.4.1743009186911; Wed, 26 Mar 2025
 10:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325015617.23455-1-pcc@google.com> <202503251242.FFDB6940@keescook>
In-Reply-To: <202503251242.FFDB6940@keescook>
From: Peter Collingbourne <pcc@google.com>
Date: Wed, 26 Mar 2025 10:12:54 -0700
X-Gm-Features: AQ5f1JrGljJm4PeWBnKXpI12td-rU59plY-cd4apU9o-HArGlIBfJwqu8UHG7l4
Message-ID: <CAMn1gO5Ero80wm=P3_-BQAFPuefUr_VUBV-msTN-FD6oL_1Gig@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
To: Kees Cook <kees@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:43=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 24, 2025 at 06:56:13PM -0700, Peter Collingbourne wrote:
> > This series fixes an issue where strscpy() would sometimes trigger
> > a false positive KASAN report with MTE.
>
> Thanks! Should this go via string API (me) or KASAN?

Let's take this via string API.

Peter

