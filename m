Return-Path: <linux-fsdevel+bounces-65917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E78C14FB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 14:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EF26418D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B65225416;
	Tue, 28 Oct 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmNNPfWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53321507F
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659249; cv=none; b=p6X8Ze4tbenCNZdxhPNOI/UXPfyFd6SuthLwlxPoUmHRLxTEZpNswGSINUCqSxZXWRHgNLEn+w9FEQrn0e9Pq4Ef9zCY5J/ymYIqHQxXyAuMWWSzgKA5nb7SgMqINFWLZ6tIp5sogivdFwnWr8N+PnBP3mAAtwn0rum3D4YoBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659249; c=relaxed/simple;
	bh=zawK76MtmH8ufrxR4rfg/Ht+VnEdIN5K5P/OxQhqD1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqL1n1rnBbLYFQC1wvxFfG5nJwDVcbWRac5NeFxWJ9Rc5vhZNEItO+aofyxPUePPwuB8/SXqfy0bPsXQLQwGigf5DV8Ed/aoIfaU6wIyplASPiXz/BNQ+UYJwX1pf+Z+yFDDSw8PfIkB5EC7h8oevybdN6MIpSLmsRi7sEjphto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmNNPfWz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290a38a2fe4so5583105ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761659247; x=1762264047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lck/qUF3K17/QD681a6Qx1V7al1MyFus+/Obtk7sHTc=;
        b=KmNNPfWzC511RqEJz0m9q2LzoZkyd1bSlK0vzRAVWE9z4HA3FSf5E/aqgOsN+8IkDd
         txRYdkgDX+L1C/r1c7VW0CaFcXf/2C1qXGfuQQ0qFcb8+eMavq7iF8DocJcPoAFMPd2M
         deMW5RVAPvJXrIj60fvQQ+HFzeqCCWam9mhitxsxdnY73wlLNG9ft1I2vM0TdBFaCBQE
         jXjBgs01ddWuch6q7rUoOBUADpguZhfi+NUPUSLp35vLnrVd5Fr++nU2ek71C64TxwvX
         KDTyRUrgJB73Om3XpoBms5n5azVhAGTGFbTzMO1Ty4EW8NDO06Qp8sPDl5wuViBTdsjC
         qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659247; x=1762264047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lck/qUF3K17/QD681a6Qx1V7al1MyFus+/Obtk7sHTc=;
        b=R1OZ/MFzx5VvrchWUAt9S/ULetrMb9Pn1xEHkLWZZCPnDwGTKIDJ2Rld3RyrcbvGZo
         8AjgkYIp90z3D1YwnRDShIdvnf1tkg0lh+rAqdqPi2Q7x3Or8T6x5MC2YD32crP9gPtv
         OOVZsqtzdjt9dgB/WRArBr7uuyZd+3JZcV0hOBoYPTRzDSzUikT+VokB2MWXPvsTgUEh
         UrIMNkRIIHSAOHME3GaCqSNI9UCvan2LDI8P+o7sLgRB03i8WQZhNbHASgMJzttokqTq
         q1aleaV1ro12m/uD+rNwx8Ei+H1x+xtL3J+l5ChAXvKBVRhlhSclRtZtBMcpDly8bM0v
         Jodw==
X-Forwarded-Encrypted: i=1; AJvYcCVyHIFhk6LPiUM3M8dRpjDuNeD/BqdNZRFnvl6P3q8+3VKZbrwsAivm2lpukdRFecfh8KvNyNyHEoC/rANh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0KMHHAr/uAd5Nlf+BwgEsDxO7Cwa/wGGXd0eGlOAMTqdFwxfc
	R/qtQRxMox/Xm3gP1fvtpn9aFY7F0ahgLjA8Gut2PGJStwP/hgopYoJgCVORDBwyrr8yUj/mBiZ
	IlsPOzvV5rPoTCU6UXU0l2XVwp4iJpzQ=
X-Gm-Gg: ASbGncsUWzuOlBEWUvoD9xjMK5PwNFIBh9UMTWGUvH9IXNCUQuNAI3e5c6pInswyEbB
	9qwiKnNnE05wMFmrAfUM+zcvqNFKmC/cfmfWjWskdYu5WlcPeT6euaunnHNj06RJ6+DRRtGN24F
	D2vqPObYSTAP7HTLBx+ZyGxfr5hePOLjeka6+i5olymCGY4eU6xp+5LcMqznecapqmgxWuZNZ3v
	JoUAb8+7OdXNSAnJWINrzbfwYGq5Dcafar1Qo6rPNlNDAAvx1wkq4XyUpGs8FgFmYynUM+cPcFU
	12yONZDKc13aRc9dJ/kMW4pEqqlp/96Q6Szl4agsKg5lBj0cmlbaoRjUujPubkQLfItpFVffpMz
	Xtz8=
X-Google-Smtp-Source: AGHT+IESXoECX6lb+KHpmsbAfcJAT0GbZQiS04Og6y3R0qXxL+rFcZNSFEWU136JZUGwifFE09Yqi8TDGf+dQjOFZ4U=
X-Received: by 2002:a17:902:db11:b0:25c:9a33:95fb with SMTP id
 d9443c01a7336-294cb502797mr22038715ad.8.1761659247125; Tue, 28 Oct 2025
 06:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-1-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 14:47:13 +0100
X-Gm-Features: AWmQ_bludoF7dxQQKoaDhrz1B9YQeI7e37qaHz0Oa7sW-yAdS1QG2o8R7Wm1Nqs
Message-ID: <CANiq72kjuGDAkwhYOM0BTn_WRruYn88C_MmYqytpJW=UMELV_w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Binary Large Objects for Rust DebugFS
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>   rust: uaccess: add UserSliceReader::read_slice_partial()
>   rust: uaccess: add UserSliceReader::read_slice_file()
>   rust: uaccess: add UserSliceWriter::write_slice_partial()
>   rust: uaccess: add UserSliceWriter::write_slice_file()

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

