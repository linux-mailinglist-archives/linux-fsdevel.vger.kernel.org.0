Return-Path: <linux-fsdevel+bounces-74035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC83D2A208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 03:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88F17301A1F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A383B33711D;
	Fri, 16 Jan 2026 02:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="A+ne60EM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F570818;
	Fri, 16 Jan 2026 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530524; cv=none; b=S8XIlX55l/SZ2oen6dAwIz0SaLfLjdE0oj+W1bf+AXppCgJJNZllgupjJ1QA6z5mrrQjsgaq25CELfONR3HoNTIZJVXpJVM0lerIIQxzi3n0KnpA5bd5XDWccLmYTgeeSc88YRRx2mM+NMPEhUfxlU1/djypwGOmLg9KI8fYw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530524; c=relaxed/simple;
	bh=RauHVqaV7yeDsVsndgbjixOhm3HeU+gdbfxRTJD1Xjs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJp6fPQjFf0lUyVDMxh7AR7xpCFt5bQ4AJPYeCT3Fu1UdEmKP1DQSK6kOcqnSCgOumslFN0tfcTh/ideHMVgsVNCPFo7ADwd7Tq/gGhhUtq9kxzfQkR41lZbVpmBdCmZgATqWIwWKJEX5AESWSpE8o/hyRnuN1G0DDsC67rkvn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=A+ne60EM; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RauHVqaV7yeDsVsndgbjixOhm3HeU+gdbfxRTJD1Xjs=; b=A+ne60EMDGAtb60eZdI0y7RDRg
	Zs0yglbxoVjo/fqdy5mmectp8PZOH1L4sSAMkifhKh3eM8JRETpaSuIAoe4GhKhB0pgXkDsjv8cgq
	uqRrUqJ+UBCit+KdB9BlbK8BusH2NpOYvXAklfXNkyW6TVtD3FgbBcbxJNdpzO4y81H0kuVS25KkR
	YJNB9i47Uoe4ArK5ILkCylpnE2hh6KdAnOYeYmqBZHphVkeQs3NQtWU775xNcxYKdO5Xvl4esyA9x
	6WznY9A9aIYR1ilzdnyD5qF8U+u4uEt2cbUgM7AqhNyhbop8WmXlSPL8AiwmIR/Qlo3w8PnO8gTPS
	uvs3OdQA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1vgZYt-000000003Ph-11qy;
	Thu, 15 Jan 2026 21:27:44 -0500
Message-ID: <2cab00c18ed7499e5ef143c7f3198c61d56ede25.camel@surriel.com>
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
From: Rik van Riel <riel@surriel.com>
To: Aaron Tomlin <atomlin@atomlin.com>, Dave Hansen <dave.hansen@intel.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, oleg@redhat.com, 
	akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org, 
	mingo@kernel.org, neelx@suse.com, sean@ashe.io,
 linux-kernel@vger.kernel.org, 	linux-fsdevel@vger.kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>,  Andy Lutomirski	 <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "x86@kernel.org"	 <x86@kernel.org>
Date: Thu, 15 Jan 2026 21:27:44 -0500
In-Reply-To: <zkl42ttlzuyidy2ner5sjfbg5b62l5mcmlcmardd534y2p2u2q@vz2w4nbwvbhf>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
	 <20260115205407.3050262-2-atomlin@atomlin.com>
	 <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
	 <6531da5d-aa50-4119-b42e-3c22dc410671@intel.com>
	 <zkl42ttlzuyidy2ner5sjfbg5b62l5mcmlcmardd534y2p2u2q@vz2w4nbwvbhf>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-15 at 20:53 -0500, Aaron Tomlin wrote:
>=20
> Based on my reading of arch/x86/mm/tlb.c, the lifecycle of each bit
> in
> mm_cpumask appears to follow this logic:
>=20
> =C2=A0=C2=A0=C2=A0 1. Schedule on (switch_mm): Bit set.
> =C2=A0=C2=A0=C2=A0 2. Schedule off: Bit remains set (CPU enters "Lazy" mo=
de).
> =C2=A0=C2=A0=C2=A0 3. Remote TLB Flush (IPI):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If Running: Flush TLB, bit remains=
 set.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If lazy (leave_mm): Switch to init=
_mm, bit clearing is
> deferred.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - If stale (mm !=3D loaded_mm): bit =
is cleared immediately
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (effectively the second =
IPI for a CPU that was previously
> lazy).
>=20

You're close. When a process uses INVLPGB, no remote TLB
flushing IPIs will get sent, and CPUs never get cleared
from the mm_cpumask.

--=20
All Rights Reversed.

