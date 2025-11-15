Return-Path: <linux-fsdevel+bounces-68560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019BC60190
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 09:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82B6935EE9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276252550AF;
	Sat, 15 Nov 2025 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2LoxIyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9726192B7D
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 08:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763195185; cv=none; b=eIwST7t40ctqntyiAQM0AVug2Bd95bg9PagaHANvbPgIaOwXAD50O+L5dlcWiYR9Jib25gIOHH0AOd9pTWDoKnvEvSFGTI08KSiuIIE2UA/IvUnmOrLRidq6qiAOqZJ9ER0wZATEHgR4oT8059TsWAIAprSoxTlVHDsVfHXhgYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763195185; c=relaxed/simple;
	bh=B8L+nXkLF5USUX3j1ymwWiuWTqLOWXY3ie0wtNbI01E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZS0lERHvozLhr+oAN7OqVfakZOmEo25TJ+Ok12TKLByOeBXz+z6pUMixQVbnL2AgF4kD9M3OyUPirEYXJJu+RunKQtLaGVli9V5vjaHdaRYuiTpJnhWfMtWGkGa+IrRHVyCBIrCrkaix7lx8eNAaPhzQpim9GqkL318P5P6YL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2LoxIyE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b735e278fa1so364306266b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763195182; x=1763799982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8L+nXkLF5USUX3j1ymwWiuWTqLOWXY3ie0wtNbI01E=;
        b=T2LoxIyEDFWdXKd4hXauVNC5ZvOmQS1X0xh6qCpnDdt2qwffpxrDeZpb0AJLBhSpi6
         jPj2HOYPIQl3iQIDU5o37QrOA0nCx6oxY+RXcapMHeIdrk5P36dAPOeh2luEi6rWIZ2j
         xiB6VGR4tD80ZSMAsxKehwgGHnEWzOE53twH6V3qjmXaZ/5Q4fmm5OuBw82r478bpcdf
         nn/sq/aljJl/xgTFsNEpvBXQgQWib3w+QtY5M0fJRHkgOCecw/gF0CkYCmlx5DmYDvO5
         nMXCMu3BVjkg/c41eqU/qibDWqf/pV1tqfVw3mNddLwaKROBeRbFTLLYXd3pk/N6q7Mi
         mhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763195182; x=1763799982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8L+nXkLF5USUX3j1ymwWiuWTqLOWXY3ie0wtNbI01E=;
        b=o8dg1+yNO2iq367UNa5pmV1QxuL9F24Tqvom9QGnIVdEwks86T+9le/CwOV9FVbG5d
         5+hvlS2nVb/BwJbe0SF29CYshfbPUOHJpAhFJ4pCnsJsgfX8UTscgoo8EVbbXc7sUfa/
         hq0L1VzXUBq8JNY77oRdO6kskFqSk/sz/XMTKmcGaSCTEaIKrTjy8yH67mun/zqxGHYG
         oRPsjfHAg9ic05vv7WPnAS9YE/jf57z2RzQT4u977hxKvvZl5kI9K2Q83LuMvKfsN1Zr
         2oG7tupRZHOcXXfd2fyRmOm9VmruSjT3E8jqTCvR+DtSGr2zA4Hhy20jIMdxB/V9Rjhf
         O7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWOZ3HpVx5KHtnM6ZGsNMruhp/QQ2+Xn4gfp783V6d0ukbovYSGUFRYZGsKr4H9iJMgpknp4pQIiYNfNnbA@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6XVIpCBb5IHayBr79TpG4uhw5jX8p2hFJrmPtPWJTSaa+WeF
	NG/FrgTxmbADCNZrq134M79K3nA9HGF+Hj8ck6T3YHCkKJyYuPD7QCbuso9RSA7w0GXw7y4XqGJ
	nOlhaJsky0iD/LisRAHw/lP2GM2f9J2g=
X-Gm-Gg: ASbGncvY5b9eCE7FNJ9Zk7vClr7Ef6o/lQVtiDKKYzKZ/pmECeQH22FZSmEGKnNn+NT
	GuyENQSHlsiw5PglZd3IRF9nI+feGY7oM5xkxiRsRPDZTaPq1jVVqiyr+gvZnz+tLZUWAK0dmRS
	XeZzXys95uptq5G6LHMv3Shf/t5TqxMzgQQB08fEcEj6uUa67rIQZA97XQYUR2aU/MmBBEuJIjh
	yWihgI4nyTxhxdQrpJRZvV/RToJZgyYXWqJWfsrsxcpuoV+Z4A9T2O82+hiGnNd7YiK9hc6uWSv
	kEQtFy+WlFY3dZT2V5s=
X-Google-Smtp-Source: AGHT+IEVA0BWNPAPDyO2G0+1S8lOolkb0M02iLKpeJuAWXeoyvxzpAD7R64zx59hZUe0elru2pwthJW+hFl0/Ql8y5o=
X-Received: by 2002:a17:907:7207:b0:b73:7325:112d with SMTP id
 a640c23a62f3a-b73732513dbmr432940266b.35.1763195182169; Sat, 15 Nov 2025
 00:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Nov 2025 09:26:10 +0100
X-Gm-Features: AWmQ_bmAMd2m3eohHlGgSc4k1bCVh3Z024B1oXoHlA7102uLPC1zCy0VuC1iCzE
Message-ID: <CAOQ4uxgZR6aGvemPFkEGAJ2mop1NJaEQVt-Rr2Cox6zcMmDXfQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] ovl: convert copyup credential override to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:45=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Hey,
>
> This is on top of the other overlayfs cleanup guard work I already sent
> out. This simplifies the copyup specific credential override.
>
> The current code is centered around a helper struct ovl_cu_creds and is
> a bit convoluted. We can simplify this by using a cred guard. This will
> also allow us to remove the helper struct and associated functions.
>

Nice!
Thanks for going the extra mile :)

Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

for this series as well.

Thanks,
Amir.

