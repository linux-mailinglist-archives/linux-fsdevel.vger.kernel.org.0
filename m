Return-Path: <linux-fsdevel+bounces-52260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F00AE0E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5823BA6BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 20:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E756275B08;
	Thu, 19 Jun 2025 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/ijAzAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACA209F2E;
	Thu, 19 Jun 2025 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750364577; cv=none; b=pbQxS0Y4HyJfu1mc/ynS+pzSeiJHppw7wO/5u49AnI1v0R7+a/jd15eDTXep74PTlugox/3R7TnQt4DskRsqI3UQXS4veqqU6h5MgS+tKJWXP7fGAQUatohx01a9ZhXJTePHIPQGv9wz3U1wfcGaQxxcd6+yE3QN5KEhLsXPa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750364577; c=relaxed/simple;
	bh=U0Vtx0FEbrVhYxJW7I5M8RXK6uibaQf3BFnv9bPRzWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1w6EyFfr88NLdIkda4r/APx34hCW+2pqdZYk7KLPzS2QMhyLjsL1gADngZT7SsFh5UIVqMCThZ4/+WvoJr8TQ/+GxAN2PsgL/SH6YQJpFvqxZmog8KhfMPUrc1hc9jsOzf+uDg2oQinGnVg9T1NGzqhU1b8cQNYF6BoSJYbC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/ijAzAQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b2fcd6fe970so170407a12.3;
        Thu, 19 Jun 2025 13:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750364575; x=1750969375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Vtx0FEbrVhYxJW7I5M8RXK6uibaQf3BFnv9bPRzWA=;
        b=h/ijAzAQlwlZVaZ5osOil8VlXfK9UQmGwBrRr1JDnwU8euD9XB5AEFXkmnx+O63EYa
         rZYiuc20WStOtdbs4CvN/lyI2k6h7GqbBS+OCP3APbgo7mXuYyqyWyJ9bn7ovwm2Lhyu
         I6QAwqti7qJRbXU4cRornPxfvZocChya9fFrWRT0sO7MldDzDhggGbQeqD3WPyZrM8l1
         ctBX2s3uGfflMayu+ndYu8kY/NVJEDJ+5TrSBeVpkfTvd51nPnDfBObHOzcZ4fnu97Rr
         Q0MOgaJ1V5rmit5OfxeTtfBMOWa6Dz6+NPmNouahMCdrLa3CtJSyCx/cDOROlueVmtbq
         nlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750364575; x=1750969375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0Vtx0FEbrVhYxJW7I5M8RXK6uibaQf3BFnv9bPRzWA=;
        b=phgF8LLfJLrOItQboIJaK5QC8TGY0IAC2VsyP1uWGSxD3zY38hairkzwV/c2hCyXpY
         veJKxVaSDKL7w5tmCYXbSIQDbh5Tc1zb25G5DgqS2rVMPZkYSGBLTmSsu3eBQV39CSRc
         SR8R5o3J1QaJ6DszW+S1Ot1H+70jxZuUf2TenJhDpBv4gaBqLAvs76IZ3Hhqp7VDwmrx
         +KZ6cZeZuqtgVCz7DNEnyMe/VcTMsB28ZfyW7z70O9mc4FjoAHnMmtusKaOpoeCKOlU0
         zYeXTk0jaxEe7cYrY8FS3C11klYRaRNDk5MLqvl2jWElG9f9oP1jgtQkb4tUIiYguwsS
         0rxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+5oHYQbs3GjnahZ25P4fL1/rvJhKTk80u/KhlpuHyZWjm/LtAEM6xUgnI7TyXxfBGv5uDtgNaX5l89FoYq0s=@vger.kernel.org, AJvYcCV0vF8OdSiB7M9Izl/1Fucrq5RffMcoOJh5qoTXazhxbvh96BMzHTEkqckcD4ASkOLmL8r/pUqCu0fskFeM@vger.kernel.org
X-Gm-Message-State: AOJu0YziWigDRd52VLkS6IckAMyVF+Ds2R5Nvnl2i37hBqxhGbilp8v4
	ARm/qUDVkjwpQfmG/Ef+4bYSk6aqJISk9wFKqViM7p1vXYqShfBkr+KXTrWxoXlmUjFu3Fluu5K
	zKjrDLAHpeCaX2JvXe+Ien5ilLvSEkXc=
X-Gm-Gg: ASbGncv9NAcni43apVUTYLloxS+NbeODhLYdFlUz1EYYM16m840FX4ljyQqCCbu3m9S
	rjufyOC/gGRCZcz3UHyl5rq4fJl+e/V/p3cPx7VamqISeLb0aDZF77sdPmr8Eg0ugwLc5n8Rhlg
	vfVzWNLIxWQi12m8et3bIQnLPw9ysKch0w9OqlJzhmcrI=
X-Google-Smtp-Source: AGHT+IEh6myrEwUkA435ejIGULYab5ub7ignTbK1wjyfFIpXjVU3mUfphk47lEi/J7AeJJGFx33OKUAoATi8c6pgITg=
X-Received: by 2002:a17:90a:fc48:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-3159d8ca80dmr288337a91.3.1750364575448; Thu, 19 Jun 2025
 13:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com> <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
In-Reply-To: <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 19 Jun 2025 22:22:42 +0200
X-Gm-Features: Ac12FXwugJ7GABVDW_NvhQGGyyfAKlqw_soyIPdtxvwOrvQ8JPGchYrxrPC8hqQ
Message-ID: <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Benno Lossin <lossin@kernel.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:35=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> There are some subsystems that go for a library approach: extract some
> self-contained piece of functionality and move it to Rust code and then
> call that from C. I personally don't really like this approach, as it
> makes it hard to separate the safety boundary, create proper
> abstractions & write idiomatic Rust code.

Yeah, that approach works best when the interface surface is
small/simple enough relative to the functionality, e.g. the QR code
case we have in the kernel already.

So there are some use cases of the approach (codecs have also been
discussed as another one). But going, in the extreme, "function by
function" replacing C with Rust and having two-way calls everywhere
isn't good, and it isn't the goal.

Instead, we aim to write safe Rust APIs ("abstractions") and then
ideally having pure Rust modules that take advantage of those.
Sometimes you may want to keep certain pieces in C, but still use them
from the Rust module until you cover those too eventually.

> One good path forward using the reference driver would be to first
> create a read-only version. That was the plan that Wedson followed with
> ext2 (and IIRC also ext4? I might misremember). It apparently makes the
> initial implementation easier (I have no experience with filesystems)
> and thus works better as a PoC.

Yeah, my understanding is that a read-only version would be easier.
Performance is another axis too.

It would be nice to see eventually a 100% safe code Rust filesystem,
even if read-only and "slow". That could already have use cases.

(Wedson was planning read-writes ones too.)

(Thanks Benno!)

Cheers,
Miguel

