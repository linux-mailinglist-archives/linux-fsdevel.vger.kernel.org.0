Return-Path: <linux-fsdevel+bounces-22086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233AA911FFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 11:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA85C28264F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 09:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07816DEA7;
	Fri, 21 Jun 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="TMbHACwH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CCB1C02;
	Fri, 21 Jun 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960632; cv=none; b=Sj8zLRBszASgs3HHxWdl99pxo4D4j5cYkzOrV//XnQLLEniMF10TQ6g39SGpcY1nWzvQrBMXLPHHkHJ1ZTO6WRVSjOm4V+BZciedjdvOqxaAw2UVnSiTLIpo/956ml9kK3sDEqPHZAM37LcH2jTbG56C/b3RhDTetpIrUSl7jaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960632; c=relaxed/simple;
	bh=I0zfmPIPdWucFGUWqrrjV/VMbgOjve+/Bk4AJ4J0PIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qL6n7cZUPFrIdQQRv+/A+la1SWBkixx3F+R1156Nt1RMTE/dLHxRivB9Bd19teKoKQv73kC8ZXDCx/ETxGE9iFU9ZCtli/CZ+/M42lfHEGvRX5NZe/DTuagCl8t1x6/ZBcnlAHdM5JlW25wWZovTsBN71yCmmVMCWUK18Yfc+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=TMbHACwH; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e2hpe1iGw8BtPBrOiCtpgk5Mrgh2fKvph5/Cmhjmvig=; t=1718960630; x=1719565430; 
	b=TMbHACwHIJlMy5bVVyPGLK4lWdtzwiTWfCk8RFgN2YzSaGHitaoH/bOL1FcNXVAPQ1XbaW3Es6u
	1BKKqcxMICd0ddqNjf9oMH9aJNNSt2WYTK7xEPycYgxYX/8SOE5D3kBJrHWokNeialE/5AwYq5wIC
	SN5s/GDG0B6HCMpUBlr9TLWZcWlHy4ujWPOaJRWBk5M7W5tTY/T86XSJTa5ajD25T99WSGz9g4qxR
	OHvwOIbWc74+aFBPktD9n4zF+/fdfe18wsEk7X0x66OJg3B7knH6ElT1fxJVIDJK0adRQCiRS1tM8
	uFBPqFWYQXH7KiVFBQfzKVnENsETUwO7mnZA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKaBO-00000002A8I-1bJM; Fri, 21 Jun 2024 11:03:46 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKaBO-00000001fU8-2TCt; Fri, 21 Jun 2024 11:03:46 +0200
Message-ID: <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>, Arnd
 Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, 
 linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
 sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian Cain <bcain@quicinc.com>,
 linux-hexagon@vger.kernel.org, guoren <guoren@kernel.org>, 
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>,  linux-s390@vger.kernel.org, Rich Felker
 <dalias@libc.org>,  linux-sh@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>,  linux-fsdevel@vger.kernel.org, Xi Ruoyao
 <libc-alpha@sourceware.org>,  "musl@lists.openwall.com"
 <musl@lists.openwall.com>, LTP List <ltp@lists.linux.it>, Adhemerval
 Zanella Netto <adhemerval.zanella@linaro.org>
Date: Fri, 21 Jun 2024 11:03:45 +0200
In-Reply-To: <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
	 <20240620162316.3674955-8-arnd@kernel.org>
	 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
	 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
	 <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
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

On Fri, 2024-06-21 at 10:56 +0200, Arnd Bergmann wrote:
> The patches are all independent of one another, except for a couple
> of context changes where multiple patches touch the same lines.

OK.

> Feel free to pick up the sh patch directly, I'll just merge whatever
> is left in the end. I mainly want to ensure we can get all the bugfixes
> done for v6.10 so I can build my longer cleanup series on top of it
> for 6.11.

This series is still for 6.10?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

