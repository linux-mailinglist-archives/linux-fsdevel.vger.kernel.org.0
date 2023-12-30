Return-Path: <linux-fsdevel+bounces-7040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540A82083E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23B71F2296D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 19:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33781BE6B;
	Sat, 30 Dec 2023 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=sapience.com header.i=@sapience.com header.b="1nhNBXQv";
	dkim=pass (2048-bit key) header.d=sapience.com header.i=@sapience.com header.b="TO0XcrPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E14BE4D;
	Sat, 30 Dec 2023 19:16:38 +0000 (UTC)
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
	by s1.sapience.com (Postfix) with ESMTPS id 8D4C3480A25;
	Sat, 30 Dec 2023 14:16:37 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1703963797;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : content-transfer-encoding : mime-version :
 from; bh=1pXyoFmz1lTgRA1zLZsIStCGbbxT6t//SqJToS9e4ck=;
 b=1nhNBXQvm4m6bQhdzTmfQ4+kduqcgCuKhTJY6bvKIppUy7h+dYSUn+wsCGyBCodC5YXsN
 QUfscGjXQ8pvUUxCg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1703963797;
	cv=none; b=Kg6/hIVi7se7LPvhdKoewOhSp+tq1dfMyh3PRgyqEcEOt0Fi+dUkxZYgJFNqq51zwbO7wScs40MGRb9W6bx2rfFng0HL03NDFvZykhTckkznmaIVUZ3FHBLrpIr6mY0TabLnJ4SGf1NtfzpvEjp+nlAgQS53mgm5ky6CLsw7+BGWMJrOvaQPnpwDzr8N9yYzzswGoinoTdDWcOURltMPF1qPWz1kjVKHgH3D5745wTnkwUEWEvzezYbaX69Pg1bbpfxYEjikAXUqjxvg5p9JBpJQQ5PeN06aYdrq43wUoi8zyPMffdi93Aj5GB0DlYCaxQtNmtTSexDR2gVRmAPGow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1703963797; c=relaxed/simple;
	bh=ZSEN9WdxrSB4Yv9vUSNhbHsmt9jvdauFgZdtTySjXfk=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=bdYm9PaJadbQKNI+IJrAJrwBxpPKpNoVNmS7JsZF62sTQ/4+iOS+pEvs/ZoVFNQjKISzjSFWuurh2YssYNukMp2IDuajrnTTkhnVXXE0kmoLFr65QreIQAtNKJ5f8MrXoxs0oa2fDVrnSfc4pKHUeEy4ayeLXdoVCjbv28JLSijqjzIUgnaUPqdjWffGjR9ZVxhtYOv0J73/UT362dpsNqQxxgfVIv2lGWAorIBE9Z0pznM6UEU5Ea9kUbN9GwG+9LD47gma6F0H5ZL40h4IFg5URS/DYajVl4zR3SN0iOIUxC6qd2SMhlY5aAgzCNzWhG6Kr6iz5X8Fd2gcnRSjWA==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1703963797;
 h=message-id : subject : from : to : cc : date : in-reply-to :
 references : content-type : content-transfer-encoding : mime-version :
 from; bh=1pXyoFmz1lTgRA1zLZsIStCGbbxT6t//SqJToS9e4ck=;
 b=TO0XcrPDBH0phrT/CuAAmEBwOZF9/2Xe0fXfYM4NBrkY4eEogWlhSOBm80m6xcavh4NXw
 qbqCGUSYJ52ZVi9d0aAnZ+zmDDcUQdIbhcoYMj96dVCyKp7e9BdRKcAa4osO9gz62VzYcrV
 Mto16gEYCBPHvo96hIXBaq+5r0+zz1B3As7Pnjri8WZcM6MK+lvGlX72aZiEbqKpouGGHYJ
 xMo3mxJpfJETVmUZi0KJWuvTPNNRGixF11yphbaXZ2t4oe9pPLEOmRDn3lQCxBOOpq5QiEF
 YlHYJKR/LameUzj5i9EyPUMjsnYYADhyGSd6h7FFyS7pPeV0/p3CxAC2V+lw==
Message-ID: <0a03664f3adba63600bddebae5b5fd299d4ebbf1.camel@sapience.com>
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
From: Genes Lists <lists@sapience.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
  linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date: Sat, 30 Dec 2023 14:16:36 -0500
In-Reply-To: <ZZBbNm5RRSGEDlqk@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
	 <ZZBbNm5RRSGEDlqk@casper.infradead.org>
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

On Sat, 2023-12-30 at 18:02 +0000, Matthew Wilcox wrote:
>=20
> Thanks for the report.=C2=A0 Apologies, I'm on holiday until the middle o=
f
> the week so this will be extremely terse.
>=20

Enjoy =F0=9F=99=82

> >=20
> Dec 30 07:00:36 s6 kernel: CPU: 0 PID: 521524 Comm: rsync Not tainted
> So rsync is exiting.=C2=A0 Do you happen to know what rsync is doing?
> .

There are 2 rsyncs I can think of:

 (a) rsync from another server (s8) pushing files over the local
network to this machine (s6). rsync writes to the raid drives on s6.

s8 says the rsync completed successfully at 3:04 am (about 4 hours
prior to this error at 7.00 am).=20

 (b) There is also a script running inotify which uses rsync to keep
the spare root drive sync'ed. System had update at 5:48 am of a few
packages, and that would have caused an rsync from root on nvme to
sapre on sdg. Most likely this is this one that triggered around 7 am.

  This one runs:=20

    /usr/bin/rsync --open-noatime --no-specials --delete --atimes -
axHAX --times  <src> <dst>



> t looks llike rsync has a page from the block device mmaped?=C2=A0 I'll
> have
> to investigate this properly when I'm back.=C2=A0 If you haven't heard
> from
> me in a week, please ping me.

Thank you.

>=20
> (I don't think I caused this, but I think I stand a fighting chance
> of
> tracking down what the problem is, just not right now).


This may or may not be related, but this same machine crashed during an
rsync same as (a) above (i.e. s8 pushing files to the raid6 disks on
s6) about 3 weeks ago - then was on 6.6.4 kernel. In that case the
error was in md code.

https://lore.kernel.org/lkml/e2d47b6c-3420-4785-8e04-e5f217d09a46@leemhuis.=
info/T/

Thank you again,


gene





