Return-Path: <linux-fsdevel+bounces-52515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ABAE3C35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102FA3ABBA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F53C23BD0B;
	Mon, 23 Jun 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG0sZ27o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4F23AE96;
	Mon, 23 Jun 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674319; cv=none; b=NwMy96sTZ2V7mYL6TRDi8+4sPJoQvQIAwf9r+E2kHwpCwc8PwNcFYcF+M7zwbXZvmvY+N/vOxtPOvNohmGwH+osIlWfsUOlf82FP7FhBnbV+u66R0V51BTN0CRjL4EPIHzgF1JUn1xATNTacWlVgduOIYyMapcfC1gefvR1R5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674319; c=relaxed/simple;
	bh=JoF13i0LZyapjKFIIUhrt3kypJwlGw4vYPJDGezJMJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJHbKwj7Z+0kRPbq/bh8nW05aK5OmEUjHhGOjCS3sJx+z7YS31adsAt9SGHPlHP3ORYaircLY4fhsW/0WoET8dr2mBgnVsoobcdbnZ2596ypaM3zmUDyC+kn/P/ACU80g5EmRzMtN+OuWBKHi+tOJhf3oS2Lq8aFpA5crrwY6ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG0sZ27o; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so423515a91.1;
        Mon, 23 Jun 2025 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750674318; x=1751279118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoF13i0LZyapjKFIIUhrt3kypJwlGw4vYPJDGezJMJ0=;
        b=AG0sZ27oYKLYCskCpqw/19C9zxk/oRlNkoBSqdRu9VTWGlYL5SDrvQbcR82ZdcTCaF
         hq95ys4wgR6wKNn7/ZxVtN+0m5v9jJ1n3KIRLGLfY5WHDb7JeLZNhJKsQCmigt8WsB0s
         C/ZdJgnKejLL4rJKWHZE/4bbdWfQb1xl/H8+F5IYQTRRkZVWLg9WbGol7+VhQ0FIWtEH
         KQvAHKsfhBQf+o+3CE7VN4zsXlp5O0PACKJuTL/OLWiHKVqTVaODB3RvnILX38+V/R/l
         OlOG0DuwFal/SjrMtg31FugiKmjf+YcjTkH/vbDE1tkghVUGSweaS7XtTgslxNBEkF2B
         TEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674318; x=1751279118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoF13i0LZyapjKFIIUhrt3kypJwlGw4vYPJDGezJMJ0=;
        b=Pl8wUZx+F6U4NvCudfV1d+8GzB0+ieDAaLBdxnwZpwRBjFnLTXJ1vavc89WgVTh5BY
         Z1nMWBkZ+OIOfeOG6OypPQlMKn8Izjr9TTpEi76DpHp0S19kjoizPKBwCWpWqd19AEM9
         90WanN+ClixOx4rwrfElhN+45rhtn7Tib1I5dc/wyTlGaUjAO70tdxE37AYpkMeG9O7w
         LVNA+cDZW7CAouI/40AV0IeKPwGoSVR9rYhaDwMGjx0cqs3Ou6+Fd0/DiSygYLdem89b
         BxXxNOiQryo2Ee9AdfZZkj+5O26kSig9ULrW1eAM8EtIp7jRq6qSr6RIvywDWvpPrUNg
         V5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8HnDqAXUsFZW8kHzIc21mlB1EtefEApOohnPfE0KWbMxQkhKYFJvHS8jGwMzBmpsKktBR/ao14xctnika@vger.kernel.org, AJvYcCWwi/Iki4t65RwBVmy/PlJ++ZQ2IFOALfka9TeJRjN4H8Irh9cEsVPW9BGS27UrmF4rb/3046EicWx55hJhfog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LfiohZAsFNqHR2hb0ZANW6DUvDiDYcUT2VIE6KuTltvgbnFh
	sOkYx/dj69pRGHE/HHrYCIZfw7F/N9N6zoUCiNLxVoNOd5QDcJkfI8FeUMMCZ44OtTi0uzCyFhX
	ijfNQwqvw36PtfCEUKApmDbzbxFTHrMg=
X-Gm-Gg: ASbGncvCqHa+JxIZkcC3c02BlxY/LN3GL6SYELsjSVBqj8xGBqw7R7guOYYBqny4iFQ
	didyW8ve+5t+KHVXCkC6zvOjv6E8HZu7bmc44CAPWBuIh7XyO6e5UcWxOS2ThdF/OnKZUSCvHE2
	3AIeGeYEv6ZfsR9x6UCuv0PBp6bNzAvhwHD86YFF94/8M=
X-Google-Smtp-Source: AGHT+IH44uRazgYKeg/GGdrY59Bo9M/r/97fGJnTNsWpvOYZ7ChsmOtK+tWEjUo35Ks++uUA4nWruzq2q28En6iagws=
X-Received: by 2002:a17:90a:e7ca:b0:310:8d79:dfe4 with SMTP id
 98e67ed59e1d1-3159d8ca488mr7598352a91.4.1750674317721; Mon, 23 Jun 2025
 03:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com> <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
 <DAQREKHTS45A.98MH00SWH3PU@kernel.org> <a9dc59f404ec98d676fe811b2636936cb958dfb3.camel@ibm.com>
 <DAQV1PLOI46S.2BVP6RPQ33Z8Y@kernel.org> <39bac29b653c92200954dcc8c4e8cab99215e5b4.camel@ibm.com>
 <CANiq72mUpTMapFMRd4o=RSN0kU0JbLwccRKn9R+NPE7DvXDuwg@mail.gmail.com> <c3786491d6ed5fa10a27e307631253e97c644373.camel@ibm.com>
In-Reply-To: <c3786491d6ed5fa10a27e307631253e97c644373.camel@ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Jun 2025 12:25:05 +0200
X-Gm-Features: Ac12FXyW8_J8gCT-mZ5VYNdxGGkNCz2J6cxnbaUtXI0z17b1symQrSHeX7OJMkY
Message-ID: <CANiq72m_T02Rh5LWCtHYjpn8-fF5b7gDay0aOxp+-RFCdDqrAg@mail.gmail.com>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ariel.miculas@gmail.com" <ariel.miculas@gmail.com>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "lossin@kernel.org" <lossin@kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2025 at 12:39=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> I completely see your point.

I think we are going in circles.

Yes, we understand the engineering value of taking small steps and
replacing small bits each time. That is not the issue -- we haven't
argued anything against that.

If you are talking about replacing code that is local/private to HFS
and that does not have any other users (like a custom data structure),
then it may or may not be a good idea, depending on what is it and how
you do it. It is hard to say without knowing more or seeing an
example.

But if you are talking about using C APIs shared with others, then it
is different, because the goal of the project is to provide safe
abstractions for modules to use, rather than have every module call C
directly (or have everyone reimplement their own abstractions
internally, and possibly unsoundly).

Those "abstractions" are not about reimplementing existing C code, but
about allowing Rust callers to use the existing C code _safely_. That
is a big part of the reason for using Rust in the kernel, and why we
are asking you to take a look at the existing abstractions and the VFS
ones.

Now, there can be exceptions, as usual in the kernel, and we can
discuss them, of course. But that is the general principle.

Cheers,
Miguel

