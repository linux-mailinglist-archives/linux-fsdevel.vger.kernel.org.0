Return-Path: <linux-fsdevel+bounces-47045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6EA97FDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 08:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C99189D9F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DA72676F6;
	Wed, 23 Apr 2025 06:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="eq7go3d2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707F826739A;
	Wed, 23 Apr 2025 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391131; cv=none; b=Qhrs4x+toGcCVGcprcgaz8xwn1Fakbk49zvn7tUF+Ter1xVvqFSSSenxXNwCYLFmF0KhKws27qW+47XB7+6MQPU312rLpzbUN1NprPwAUlucLXcmToqFnEKa2INrzffvr6o5VbJfWOeX/bqA/b2ZkYofjQjBGzy/f7m3OOm6EgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391131; c=relaxed/simple;
	bh=UCyRXUnb8teRZR7zj+5BxxuYt46cveL5YoWAZq9nkOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StTL5szl3nI5XPMxENocZb1SS4WFs2sO174wDLGbq85Y7QPFPFdQ4ihH8OZOc3ntKflh2NwtyqEnNUVJlcjBX0R8BxtY4Pl2nJjg7Eko4j3km5YTe72dj/1OkQE+3wBRQ7QHCp12dybWvRHoxzvJEJ15Ym85030GdGfslmBvK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=eq7go3d2; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O0bmeRHU0sq1C+VfFWlDhs+dfbhTFS32Axdh+/E3XJ0=; t=1745391128; x=1745995928; 
	b=eq7go3d2b7N2go9Pfs8xQ3IFHcrj8LdpanyhDwGOhDCMqajEhLqnGLnRhjuNqkisr3ZAMoBJ7CF
	9vLEZKmY4gQBZaveMneeGWJ77GDd+iHRrmSa/tfr4S7bmmAob6nZ4CazLN3dm3z2I0cIwYAAh4Llf
	AOH0FnoUgPUcovDbsNPcKII9sfiAUH3xMA3pKaNLUFv4cD05cNEqyvzooweRrweg8rbsHAqKN0JLQ
	NqDAaHUDAQXiTyYCnWesQ32WYGFtHJbKcIxw9w/cEQ+BZk25MPlqA0Os2o8M7NRRGIu29sivucOfZ
	DcJuLFn6OC0wym7/Cbbjp3qoNU9sUOdkViMQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u7Txh-00000002UPy-32yH; Wed, 23 Apr 2025 08:52:01 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u7Txh-00000002fIN-1zV7; Wed, 23 Apr 2025 08:52:01 +0200
Message-ID: <8f086de4f50b854c0fd7ba5d21770c9a6050654e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] hfs{plus}: add deprecation warning
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yangtao Li <frank.li@vivo.com>, slava.dubeyko@ibm.com
Cc: brauner@kernel.org, djwong@kernel.org, dsterba@suse.cz, jack@suse.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandeen@redhat.com,
 torvalds@linux-foundation.org, 	viro@zeniv.linux.org.uk, willy@infradead.org
Date: Wed, 23 Apr 2025 08:52:00 +0200
In-Reply-To: <20250423042448.2045361-1-frank.li@vivo.com>
References: <5e5403b1f1a7903c48244afba813bfb15890eac4.camel@ibm.com>
	 <20250423042448.2045361-1-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Yangtao,

On Tue, 2025-04-22 at 22:24 -0600, Yangtao Li wrote:
> Hi Slava and Adrian,
>=20
> > > Please let me know if you're interested in working together on the HF=
S/HFS+ driver.
> > >=20
> >=20
> > Sounds good! Yes, I am interested in working together on the HFS/HFS+ d=
river. :)
> > And, yes, I can consider to be the maintainer of HFS/HFS+ driver. We ca=
n
> > maintain the HFS/HFS+ driver together because two maintainers are bette=
r than
> > one. Especially, if there is the practical need of having HFS/HFS+ driv=
er in
> > Linux kernel.
>=20
> Do you mind if there is one more person?

Absolutely not. The more people we have, the better. I suggest that Slava m=
aintains
the tree and we're working with him to review and test patches since we bot=
h have
the hardware at hands.

> I used to maintain Allwinner SoC cpufreq and thermal drivers and have som=
e work experience
> in the F2FS file system.
>=20
> I have a MacBook laptop and can help verify and maintain patches if neede=
d.

Perfect!

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

