Return-Path: <linux-fsdevel+bounces-47087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B59A98989
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 14:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC4A1B65B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65752201032;
	Wed, 23 Apr 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="NPyVdkvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69531F152D;
	Wed, 23 Apr 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410688; cv=none; b=Bj4FlErebrUa3x/E5VIYR/otm+NRhscb79jWOoVtLAWs/h/GKaPa3VbwgLO1I9OpTJR4zzyedad7hdvL+LgMsXIHsKotx9ll1fO1HhQuToXf11hs0u/vqBM7f9C1LDjw4U8p0xPYQZkp15t0IX2dbS8bCXGwkgKDJwN7t9DL7+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410688; c=relaxed/simple;
	bh=KkeSYPzXaY6N5fOrKRdbA/60wFGZnujCv352iWn4XCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptp5WrAUqgn2bHwDllvZ4ipMfF+491MJFZkASVHHpn0Hb7UoUWW3fQ8n0Yttc8LQZAxAHJ9XIxdWTe1R3e+vcqPI8Bi07rsBSzltO8UU/4YtJZ9Cm5bTbxif7sgrJiEbBIzLVhyeqphXA1Unypjoz7aTnXqx+Iagt8wDCrWNNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=NPyVdkvU; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GiLnp/TP8jnnUsqiwiVDaQMRybnuuYjUp7Q1eSCwMJU=; t=1745410685; x=1746015485; 
	b=NPyVdkvULcSlgl/uLz+jSzZ3rP3ffJQ6wMQhToGo4mdIZWthNUB7iHAyJgUrITeh3jXearQbb/T
	+mfwSEhjNuzu8gBbWuQFiwB0/JN98kYpT5FeHfo2Nff+A7S3yi1gbLIBstDWbGFDoR7AXCzuntN87
	jEQkDhnPLpdaA1u4BaBIfymCM9uqUiZaDeQBNrq78G1Teykh2dhOrU1vRW5/BHHkfeGqcCtA1R9FP
	wYvdv6JlIulp3V28FgO4qEex5I16Pam8K5XKTH9Nl5+WEv3BReCGxmJ8i+2WY7pY3L/l0H0jZfTOz
	2XEg5/BEAIHByfT/eXYql/6WpQpDxn1lAMfQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u7Z35-00000000lk5-2l4F; Wed, 23 Apr 2025 14:17:55 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u7Z35-000000041rh-1jHL; Wed, 23 Apr 2025 14:17:55 +0200
Message-ID: <97810e02077b81ad7c54b73e1b3e90c70dd7b81f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] MAINTAINERS: hfs/hfsplus: add myself as maintainer
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yangtao Li <frank.li@vivo.com>, slava@dubeyko.com,
 Slava.Dubeyko@ibm.com, 	brauner@kernel.org, linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.cz, torvalds@linux-foundation.org, willy@infradead.org, 
	jack@suse.com, viro@zeniv.linux.org.uk, josef@toxicpanda.com,
 sandeen@redhat.com, 	linux-kernel@vger.kernel.org, djwong@kernel.org
Date: Wed, 23 Apr 2025 14:17:54 +0200
In-Reply-To: <20250423123423.2062619-1-frank.li@vivo.com>
References: <20250423123423.2062619-1-frank.li@vivo.com>
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

On Wed, 2025-04-23 at 06:34 -0600, Yangtao Li wrote:
> I used to maintain Allwinner SoC cpufreq and thermal drivers and
> have some work experience in the F2FS file system.
>=20
> I volunteered to maintain the code together with Slava and Adrian.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8d1e41c27f6..c3116274cec3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10459,6 +10459,7 @@ F:	drivers/infiniband/hw/hfi1
>  HFS FILESYSTEM
>  M:	Viacheslav Dubeyko <slava@dubeyko.com>
>  M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> +M:	Yangtao Li <frank.li@vivo.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/filesystems/hfs.rst
> @@ -10467,6 +10468,7 @@ F:	fs/hfs/
>  HFSPLUS FILESYSTEM
>  M:	Viacheslav Dubeyko <slava@dubeyko.com>
>  M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> +M:	Yangtao Li <frank.li@vivo.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/filesystems/hfsplus.rst

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

