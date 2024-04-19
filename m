Return-Path: <linux-fsdevel+bounces-17322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE78AB75C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 00:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADFD282564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98913D60E;
	Fri, 19 Apr 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="czXL2rca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110E13D277
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713566891; cv=none; b=YJCDVV2qbd9mfHQE8iLEwXhFlXv/SYCtZNWwXJw9O5rPOxSxxGHwIds+ppGhtYQ+GFkalGbe0v3zOtFq8yXYVVf6UdwnUxIHjgeaPd0HDNw3udW+xbNJyXIKxN0xDcIw04CHremEg9uV5/cG3nI7L+jN4r8eTm0qazbwQWDyFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713566891; c=relaxed/simple;
	bh=rQyXA2gl7dPSGbROvXLzBJ0EdN66K7hmltYz/477/Ys=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMMFEv6D8jQO3uO+i2kaH2vyaw5XR4w3lq1FZ7HJxM/1XtBC/xiqPooMvfpttgJxbxDuA+yXK1rKaJegLhRIFMHwjWMXorW5aRb5LxvvyzgV3HZ/70PNGXm1gQ96XxXEouZ7s6ndJnFwuKJIQPwuLjv6qmIByAHn+WcsJ/HCO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=czXL2rca; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1713566881; x=1713826081;
	bh=rQyXA2gl7dPSGbROvXLzBJ0EdN66K7hmltYz/477/Ys=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=czXL2rcafP5uslXFDvqfsGJG+qrZ4EVBV7zuPcw1Ckb70TN6e/8/9ML4l+m5sFh0E
	 aoeO4lmRbaS23YQ6wRgsYfznIFQoDzMQ309GdjQie8i4n8jMXijnwfNaKT+rUyzXMo
	 2pow6WQ+gdvOvg+g932mNIUCSDWCtSJC9cmzIBVWDoyVVpmP+nsNtawUrsBdXZyfWr
	 4DxoFStngyJJtTB5ytbEIdJUvr75R1hJctp2qyDmkPrGB1kq4hYmCLK183fdfrulcp
	 YIF/N3mM7Ts8UYQmSWUYKDXJEKjc77srnSBWFdfOr613tkDxkZShks6sDrYSWDI+sv
	 PpQHhgsadZo2g==
Date: Fri, 19 Apr 2024 22:47:57 +0000
To: The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
From: Antonio SJ Musumeci <trapexit@spawn.link>
Subject: Re: EBADF returned from close() by FUSE
Message-ID: <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
In-Reply-To: <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de> <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link> <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de> <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link> <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de> <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link> <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de> <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link> <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: a7f78a178ce498bc065591e2d725796a2fb55532
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/24 17:04, The 8472 wrote:
> I'm writing to a linux mailing list, am I not? And referring to linux-spe=
cific
> manpages, not the POSIX ones. The way the linux kernel chooses to pass
> what FUSE sends to userspace is under its control.
>
> I would like linux to adhere more closely to its own API contract or impr=
ove its
> documentation.

And you're talking about FUSE which is a cross platform (Linux, FreeBSD,=20
MacOS, Windows) protocol. And that protocol defacto includes what=20
happens when the FUSE server returns and error. If Linux suddenly=20
changes what happens when the server returns an error it will affect=20
everyone.

> I don't understand what would be broken here. In a previous mail you agre=
ed
> that FUSE servers have no business sending EBADF and should have a
> bug filed against them. If that's the case then sanitizing problematic ca=
ses
> should be ok.

I said: "it is likely a bug or bad decision" but I don't claim to know=20
the mind of the author. I've seen FUSE filesystems designed for fuzzing=20
apps via filesystem APIs and they by their nature desire to return all=20
kinds of random errors. I've seen non-standard errors to indicate=20
special edge cases or more accurately indicate the underlying resource's=20
issue (like when interacting with remote system.) Or even uncommon=20
values used to indicate something to software which was written to know=20
it was dealing with a special filesystem. Filesystems are just not=20
uniform in behavior generally let alone errors.



