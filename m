Return-Path: <linux-fsdevel+bounces-22083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4F911F5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045851F27BEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BD16DEDF;
	Fri, 21 Jun 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oFqUcFAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6917916D9C8;
	Fri, 21 Jun 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959936; cv=none; b=tcRVoWk6vTWStxOR8wLCYTeOqj2DjdS0JlCc54asFFpv2aVPN9Bzp2ehELkwzygHfByotwUxRb3wl9OWVCJWIxahxYFWYuLNSkg5LTy204YqIzdF8KvI5Lt+pTpw4SxxqfwytfHnyeKSqBAjDcX8JME/Ka4Swry6TJ3RiTkpzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959936; c=relaxed/simple;
	bh=OXpw1xUICMAzJQCRysi22dc+8HN8teDI4jqllRp8u2A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GK7Wok6U+A34+q40KjP/PqZ33WAaWST/BuV3UijIpB+I/b7yMcQzgAwDgRdsc8RDdxEXlH/Cm+iCJkrnxU6MyVMf4GsNO4g3/m+f1WA96xKz2mVYv+e4FQ+hIqvtbg+EG9q8Uozl9cG9ib+4rEzQgLNGdjqIO1WR+sPinuebNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oFqUcFAA; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E4Wi5d7bXBV7z5XVlT8JIza/vfQrRm742lmMk6jnmUc=; t=1718959933; x=1719564733; 
	b=oFqUcFAAjK8lMsyAxWZU36WLF8ez+1fnAZnXwhspjmpJk/yTi83lg+6tCZPqWGKYzYyT1UiSGFq
	dOnfJh3ysIbcNd1MZVb0vCEYAJmMVGnSuUiR/GyC8SGDVFzuGN3a8+71Mn7jZ13sM9ngnyg82Ge4l
	zq6660EphKPszy0k5FAAheWe6Z9x4FYrONOYslVBg6sfox8sl2KafsKpbSkqYI/fkOOJMoKudFGIU
	y/ZZeT8IDgs0Bl18wEwnICcMa3r8ekPzi5mFR4jOsS7D6S1oxRdzql81K98Tg5PMVTbwqeftmgeQr
	q6vH8tQVe3OOiHrqAcI47nL0E9ClRCRsD9eg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKa09-00000001yDB-3V13; Fri, 21 Jun 2024 10:52:10 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKa0A-00000001dsi-0AE7; Fri, 21 Jun 2024 10:52:10 +0200
Message-ID: <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Guo Ren
 <guoren@kernel.org>,  linux-csky@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>,  linux-s390@vger.kernel.org, Rich Felker
 <dalias@libc.org>,  linux-sh@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org,
 libc-alpha@sourceware.org,  musl@lists.openwall.com, ltp@lists.linux.it,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>
Date: Fri, 21 Jun 2024 10:52:08 +0200
In-Reply-To: <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
	 <20240620162316.3674955-8-arnd@kernel.org>
	 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Helge and Arnd,

On Thu, 2024-06-20 at 23:21 +0200, Helge Deller wrote:
> The patch looks good at first sight.
> I'll pick it up in my parisc git tree and will do some testing the
> next few days and then push forward for 6.11 when it opens....

Isn't this supposed to go in as one series or can arch maintainers actually
pick the patches for their architecture and merge them individually?

If yes, I would prefer to do that for the SuperH patch as well as I usually
prefer merging SuperH patches in my own tree.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

