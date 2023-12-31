Return-Path: <linux-fsdevel+bounces-7050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDF820E78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 22:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D398B21507
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D123EBE4D;
	Sun, 31 Dec 2023 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="W8PAtCxa";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="YqDerqLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A623BA3F;
	Sun, 31 Dec 2023 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sapience.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sapience.com
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 8D149480A66;
	Sun, 31 Dec 2023 16:15:53 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1704057353;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : content-transfer-encoding : mime-version :
 from; bh=tqONUJACyYw/DIVmJ+UArPGNxteTgWA7jMp7vJMLLtA=;
 b=W8PAtCxawKK0Ef143I/QvPQQwhnXcBaYJghW6E125ovc3ujcadlANiMLuFPRgEhRQMsuK
 Bpd3KdpKTwj70s3Ag==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1704057353;
	cv=none; b=r8NFuquxK71EN6/GbQgRcn7S8mIoIgI3yXvVhOnyYueqSmcTE+SQDTWO0R6EBgh4OYMdzsP8AHoGZaXcfMBCiYPbQagKLMrIWtdSAHd8w/ViQip8DgIojg4ELQx8kBULVJpEBsYTX0jOWYP5twyqMpasJCwma6kWwlJon1Obqfz08fzy0N1rdHfcaKPU/adASjs1my62Phc+1CCSZDNIPnn+PebGLA5xrwOThsx82w4aoGnPOQDHX9shAmQIiPP0hJQFFraCdbU+f0pJhSvEr8m7MXVsnsZ1GnQ7np8RtuSH8MfryeKy1Xwmh6GX2CLp+GtrYclgxSgiGeGOy2ayLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1704057353; c=relaxed/simple;
	bh=tqONUJACyYw/DIVmJ+UArPGNxteTgWA7jMp7vJMLLtA=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=dkZQZXzxOgiXJ6SDpnBciK6sHjeq0PDyOAVtfdxfDs7kfSXRTQEFKlMcUDRDowExcjoM4HGRX8uSN6s1gqO/RIS8+MdBpCGjG+J86fhyG4rxX17uUl9MuYgLITSwFu0fczARisfqwF8BmLYIw7eEgw6LESDYRg8RIMTGmfcdDscdzmnwAhQQ71srtgRkJ0s7Ma0MHQU49CtM/tl5TkEXn2BJlkf5UQ8zxn72ku2epEhAIXM+QbM5I1kmgd9q/hMyAucvZmQNVqqsrJ+sPhAwE+cXNPfsDXfYCRMysKwLW1EQJWCDDnCGtATs0GoLX+lJsjJiKv80MdyCxFkZAoqh3w==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1704057353;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : content-transfer-encoding : mime-version :
 from; bh=tqONUJACyYw/DIVmJ+UArPGNxteTgWA7jMp7vJMLLtA=;
 b=YqDerqLBsYC3vRHBoLLEKDJngsy/bXteZyOsNnvxuMxrEEhD0cPyde3g0yikCdUJzlnbg
 zWZTiLuqcEqjNToFBmWflM+khiW9OXi9aWqFeuDyR/FArLJXEUHpm6if9ZklpC0+24IsETK
 fxrkmkaRl76Z8v0d/OoYxARmBR2YtZPqRB2SJVE6vKTk45h/SjHyvinLLnBGBlQ4Ss/9bQi
 ZIfRBjBxj+SanX3vaFsEhHENu2+vbVijgaAmXv41kP+jMzv3w2LAp2vYD3HbIjmNBhvcyps
 ao9rzsKICRCHOPN+wDcqTfU2v4b7Dqz8DQvIGeJeHV6uncy1XLMIn/FBRNjA==
Message-ID: <aa48ba5e60ba3bed668da7c8d0288bb0edebc753.camel@sapience.com>
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
From: Genes Lists <lists@sapience.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
  linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date: Sun, 31 Dec 2023 16:15:53 -0500
In-Reply-To: <ZZHWFOJln4I1A0sd@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
	 <ZZHWFOJln4I1A0sd@casper.infradead.org>
Autocrypt: addr=lists@sapience.com; prefer-encrypt=mutual;
 keydata=mQENBFx5lqsBCACnoqPWNljBVS+eM+AiVpFn25csowDVqjLKEmCxJ0CWD/jj4h0opv2278TgyPrAny9Zw0Vrtb38ho6i0LqKE4mptFDxp/aRP9v+ywE8Ax/XCaOYeQ2u8eKKI4iLyjFdlzETpMfF4Xs5HKklugmhPxqcQs1S+4pzrQoch5z0aBi8A3MiGc9QVZEjfiK5NmRgibg3cHXMGcuODeijoYWDjcU/Y+yTyQ9MG4p95pUMPYBEVufR+Gaksk4xULurOlciphQC8oO9uV9X9f8CvEOBilM1eo98NL0egnOWg4hJgcBgHJ6vjalW7v+3gjoyLxbqzRDTjp63nMAF08C5RAY+ylCdABEBAAG0IEdlbmVzIExpc3RzIDxsaXN0c0BzYXBpZW5jZS5jb20+iQFUBBMBCAA+FiEEc/TBPYz5PhmLF5p8HgSPILb7+v0FAlx5lqwCGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQHgSPILb7+v38fgf/T0t7OSNSi6AfSdZrt1Uy04mY7A9MqLhRn00gJMXQMiZRdlkFROUXLkLYLiZUVJRLCsXXDGHMl44EsWddwwTqx0cVGBjErT2AkKnN+o72Uc+fyI5XCMjgQafFIHXVcOBmbM9QjruL6zgbmPO8EtndHGsQ7pVhN3ysZxQfcN+wxdaufXXi8ZQzNvCMyE9dVnVWBpKRSxgN1L33SyjPnuJIdGCYz1ZIgfyUyB3AF/dK8ZQ05NW8TxFcsOF1lsku4WINNBMkd+WaSaxQ+lsCPhRiw+aL87HWccUI4wnNOdvo76f1Hork6Abd6S0UKlBDrknaNsFERvErSguAmqFMmIxhd5gzBF0mPRkWCSsGAQQB2kcPAQEHQMMxX5qfptJXZdr4Jm7Twv1ze/5Ob7HKQA6twZkcuUe8tC1NYWlsIExpc3RzIChMMCAyMDE5MDcxMCkgPGxpc3RzQHNhcGllb
	mNlLmNvbT6IlgQTFggAPgIbAQULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBOWDKFMXGxIEDrzjCnPnZQr+j8UABQJjyX6KBQkZb0RxAAoJEHPnZQr+j8UAHP8BAPw25oPdQzhl5ZdDltRimmUBkA5e3x4mzDikRgul/3pqAPsEEeRSMwZ1fz6122qPC0v4dLUpHl4D7GMa8732SJyAArgzBF0mPVgWCSsGAQQB2kcPAQEHQB+8yWRF3SUA9RiXZR3wH7WZJ3IH09ZiCLamrdomXGXmiPUEGBYIACYCGwIWIQTlgyhTFxsSBA684wpz52UK/o/FAAUCY8l+sQUJF44Q2QCBdiAEGRYIAB0WIQRByXNdQO2KDRJ2iXo5BdB0L6Ze2wUCXSY9WAAKCRA5BdB0L6Ze2+tHAQDDg1To6YZVGo2AorjOaX4H54E08Avh+qttW+8Ly8YwGAD/eEZvKAxdDj9SvNGqtJh+76Q/fso19FpN+CRYWc+9wgMJEHPnZQr+j8UAwo4A/184tkQWY8y8K1kumSuhiSl6tbXSHNNKA3g/dsxns0UgAQC1MAJo2MJzCrIV5pyVnmHfiNDFPctA2G1RiLo/9TPnB7g4BF0mPYwSCisGAQQBl1UBBQEBB0BAXvdh6o1D7dZqc5tLM3t5KMVbxdtbTY07YFCtLbCNCgMBCAeIfgQYFggAJgIbDBYhBOWDKFMXGxIEDrzjCnPnZQr+j8UABQJjyX6xBQkXjhClAAoJEHPnZQr+j8UAgpIA/0trNf9NrQszYGZ1cq27doPaDeWDbp5HwQFdCcxTuIIRAP9x4Ia8td4dbauGMK343i+xViosCxWwh49r1gqZULEtDg==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-12-31 at 20:59 +0000, Matthew Wilcox wrote:
> On Sat, Dec 30, 2023 at 10:23:26AM -0500, Genes Lists wrote:
> > Apologies in advance, but I cannot git bisect this since machine
> > was
> > running for 10 days on 6.6.8 before this happened.
>=20
> This problem simply doesn't make sense.=C2=A0 There's just no way we shou=
d
> be
> able to get a not-uptodate folio into the page tables.=C2=A0 We do have
> one
> pending patch which fixes a situation in which we can get some very
> odd-looking situations due to reusing a page which has been freed.
> I appreciate your ability to reproduce this is likely nil, but if you
> could add
>=20
> https://lore.kernel.org/all/20231220214715.912B4C433CA@smtp.kernel.or
> g/
>=20
> to your kernel, it might make things more stable for you.
>=20

Ok looks like that's in mainline - machine is now running 6.7.0-rc7 -
unless you prefer I patch 6.6.8 with above and change to that.

thanks and sorry about bringing up wacky problem.

gene

