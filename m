Return-Path: <linux-fsdevel+bounces-49092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A721AB7CD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DA41BA529A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 05:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8956228CF73;
	Thu, 15 May 2025 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DLDMmg/K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F088C1F;
	Thu, 15 May 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747285824; cv=none; b=KMgE3Qh3cuDu1rU30lwjYC/+/MZnCOk5MSGvu4EOTrvAOQluAWRvm9zCVBuGJVkuUzUwJUL7lHsvXPvwsACvA7jxMr9Jfg4vlN7DwXJs4mD+1P2tlLMnuAgMEAMQLmJNKbf5EA7Rzne0/VVlq53kqwSkug1CBPfSEj4TI54acBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747285824; c=relaxed/simple;
	bh=0XMZ8tuujHdepBgovBqsBf6wi9r6P7O6zU9Lk+ehLbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QiFcXZ9XDi53FmQTQvVAH6Nq6Ga5mD2ITawt/zSv64KyRah9jLNu3soeNgwsHahvUO9l5T9I66TBRCAVhAcCAdW5HQbEpa0TMLSpCVmT63bZembLkKFOWxO4+4hJ64LEMiEecNx+QCJx80aHrm8Vod9trUcMWt/q283DusNU3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DLDMmg/K; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jCVchJVcxo0HKLoKcLtSJi8O/dCfZtzD7m8N3jnrX9c=; t=1747285821; x=1747890621; 
	b=DLDMmg/K5GDjga5yF2CHXaqMJL6OK+52cJjQsZGj7bjw5cmuox6gucC8yYEl2lJvNSl0ltvg1oA
	O/X+3DcGFySRgzmV8DzxsxkmL+lvjSjEZnFai8az/C5Gq1dahqoH5mDFsQ2WZheJVfwoqW/4POSV/
	Xir/ZkqmeRjIxZkLVw3p0ltXDTcZoY4jI3oY566y/e604dWPMw92f4E41jv2JGd7TYCW6dZwl3mEP
	dB0Fr0FYnHvpGvRvQ2fY66ZT4/h8I+uMGkH30j5DPVR47GkRIZrE2YogJjTkvxKrxBoZtoiBjRFck
	RYt8xyPNMsMBsdC9WGFoXNPf97Lif6DdVDBQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uFQrC-00000002IZC-0H0z; Thu, 15 May 2025 07:10:10 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uFQrB-000000031sB-3Kgy; Thu, 15 May 2025 07:10:09 +0200
Message-ID: <05ed8008f9692916ff0b7f715a567b1dfe7eae81.camel@physik.fu-berlin.de>
Subject: Re: Subject: [RFC PATCH v2 0/8] staging: apfs: init APFS filesystem
 support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yangtao Li <frank.li@vivo.com>, ethan@ethancedwards.com
Cc: asahi@lists.linux.dev, brauner@kernel.org, dan.carpenter@linaro.org, 
	ernesto.mnd.fernandez@gmail.com, ernesto@corellium.com,
 gargaditya08@live.com, 	gregkh@linuxfoundation.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev, sven@svenpeter.dev, 	tytso@mit.edu,
 viro@zeniv.linux.org.uk, willy@infradead.org, slava@dubeyko.com
Date: Thu, 15 May 2025 07:10:08 +0200
In-Reply-To: <20250512101122.569476-1-frank.li@vivo.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
	 <20250512101122.569476-1-frank.li@vivo.com>
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

On Mon, 2025-05-12 at 04:11 -0600, Yangtao Li wrote:
> +cc Slava and Adrian
>=20
> I'm interested in bringing apfs upstream to the community, and perhaps sl=
ava and adrian too.

I don't have much experience with APFS yet other than using it on my
Macs and maintaining the apfsprogs package in openSUSE, but adding
APFS support to the kernel would certainly be a welcome improvement.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

