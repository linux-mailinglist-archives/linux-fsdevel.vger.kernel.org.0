Return-Path: <linux-fsdevel+bounces-49949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B6AC62B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 09:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CD4A25D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 07:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E657424467E;
	Wed, 28 May 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Ks8WVOCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792A229B0B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416301; cv=none; b=hKz/PFt+MLZTyW7EIm9LIvCdPIxTK1scIpyvY5kDw1KTC+P2L0+/T1pnygWGGG5NzcwhREpj315fSdrdffd7MZ8C8x15mYckwE219K7uiI5m09d5q/XkcMSB6ZTrTGmtiIYPPwiAWZexkL2YLXSHiCPnPEcuGXPQqyP7mDuP+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416301; c=relaxed/simple;
	bh=9zBBV1tAHVu5opObkDkerG1uR0+XxsoMHLJFFH8nTc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d0/FmZl57J8MqpEuZRVDx9cMPI8OIKMZjM4rCBEknKREr8dkbg2HhjUyTTFptXj1qtRipWb2OD8GZA35jjEKPkleEawAcnJn6H1z6v6T2NMLS4mD5gfguMsArOnmBxgy0PGLOHfBz20sPF+VHQZCkqLsxWQr1M1yn4Lv8HZfZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Ks8WVOCl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mhF97XrnDsl77lnPLpdvUnvgqz8NBE2uU2ZdR7iZsEU=; t=1748416298; x=1749021098; 
	b=Ks8WVOClzxyOC9DuGSlHvEQbZg46daOeXDG3y6jW62fXB+ZP/o6EFMHcOxR+7md1an2GEUUjT7e
	cwbtv+jvd7jNIcvKOFkP1+0+fu9dut/NiPBxiIcUKiciParRIO7i8+w+/gJeAWJwy5tQyXNJ3UprQ
	CFg6kp9gFcW1bk2IJYw/7Sib85ThVhC891doM40OXawGNlFYw07mVMGoFyyBL7MEFp6b30sFHUMxh
	jLJWCgg+6hJPiXh/QUuXvQqdpb3yiN8qFTbgt3PzaK+nWM5ncRNCMMp7QXP3eDuZj8CvQa1Db/czl
	+G8GY4nQOFEYxc7Z4eX9yQNrw0F41KKfaeAg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uKAwj-00000001ZzG-2RcX; Wed, 28 May 2025 09:11:29 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uKAwj-00000000zJg-1gj2; Wed, 28 May 2025 09:11:29 +0200
Message-ID: <885465574facaf3fb0481fc0364822b8230b13b0.camel@physik.fu-berlin.de>
Subject: Re: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "frank.li@vivo.com"
	 <frank.li@vivo.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
 "slava@dubeyko.com"
	 <slava@dubeyko.com>
Date: Wed, 28 May 2025 09:11:28 +0200
In-Reply-To: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
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

Hi Slava,

On Tue, 2025-05-27 at 23:39 +0000, Viacheslav Dubeyko wrote:
> One idea crossed my mind recently. And this is about re-writing HFS/HFS+ =
in
> Rust. It could be interesting direction but I am not sure how reasonable =
it
> could be. From one point of view, HFS/HFS+ are not critical subsystems an=
d we
> can afford some experiments. From another point of view, we have enough i=
ssues
> in the HFS/HFS+ code and, maybe, re-working HFS/HFS+ can make the code mo=
re
> stable.
>=20
> I don't think that it's a good idea to implement the complete re-writing =
of the
> whole driver at once. However, we need a some unification and generalizat=
ion of
> HFS/HFS+ code patterns in the form of re-usable code by both drivers. Thi=
s re-
> usable code can be represented as by C code as by Rust code. And we can
> introduce this generalized code in the form of C and Rust at the same tim=
e. So,
> we can re-write HFS/HFS+ code gradually step by step. My point here that =
we
> could have C code and Rust code for generalized functionality of HFS/HFS+=
 and
> Kconfig would define which code will be compiled and used, finally.
>=20
> How do you feel about this? And can we afford such implementation efforts=
?

I am generally not opposed to rustifying parts of the Linux kernel. However=
, I
would still postpone such efforts into the future until the Rust frontend i=
n
GCC has become usable on all architectures supported by the kernel such tha=
t
rustifying a kernel module does not result in it becoming unusable on archi=
tectures
without a native rustc compiler.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

