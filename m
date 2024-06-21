Return-Path: <linux-fsdevel+bounces-22084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FE4911F72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A685D1F25CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AE16DEA2;
	Fri, 21 Jun 2024 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GgpT32tD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696116D9B3;
	Fri, 21 Jun 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718960054; cv=none; b=Ncmk9yBpbw0hxUxl/2XvK1z1JO24BrDyMZu+e+ofqQyvhdARxUl1hUEa3wyCZxmx5XsHAW9sAeT7CEb8o+nttVpmDnxx3TVK6mhZ7NWPVCGiHgZyZdljis+gayWD6e+HamWj7Jzw9EEDy7ZoHuhIKCniQdTna4gU2AGOCOT9odc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718960054; c=relaxed/simple;
	bh=pyFA7AU/2GhI7wvm0cKEdUMzUTfxvRrJTX5svXYqMYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=on1QVVvd72cxPQLNE6UjwSP8QAKRDhpmD6ohfV1o7sg9X+Bpudrg5L5v9RDfPc1aBI9g4lRMgxvJzsr0Gm4aIz7LCQWW/crSy+6kL33NiWUpcG0ZFyqbGl8iN/b2lzKz18/0NiMbBy6XS14KD4Z8Y1Z3/2anwlFzgMomAgqaELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GgpT32tD; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6ux19xNP9Z9FPgP5f+00+S+qPS6imbskeOogbDqAbYA=; t=1718960052; x=1719564852; 
	b=GgpT32tDYKk0Yi1M1RpDpWXoAIPXQq59InsRWpEqpmxvxsnXQvZ9i9OW+qKxbDxoKWZyB7KvLdK
	t7qnRRF24IpHGSfmPiSKkbFq5SC4II24v6wjgLN43u0rvJH62moiOGoYZGWoGO7cRqEAVoKmk/ymo
	kiProdosDLxoa8b/LoBwcJSx9S6S/q575JwKWNFUZdJXemoKaKOybhqt9jZ+XK+uGADtekYXkU4jW
	2tAq8GxMRrBjuXbnPdbYsUZ22QQwlyRH0W7j62ZU9ngv2i6DyNAlgsibX9nCMxLN39vtX6qx5Emzl
	njWfjx7upWXEql/eG2p2X6hOrz5Ef5JICasw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sKa25-000000020GB-1Me6; Fri, 21 Jun 2024 10:54:09 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sKa25-00000001eAa-2Euu; Fri, 21 Jun 2024 10:54:09 +0200
Message-ID: <3444b93ce46c7e7c156f912495e5c35ccf275549.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@arndb.de>, LEROY Christophe
 <christophe.leroy2@cs-soprasteria.com>, Helge Deller <deller@gmx.de>, Arnd
 Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>, 
 guoren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, "sparclinux@vger.kernel.org"
 <sparclinux@vger.kernel.org>,  "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "linux-sh@vger.kernel.org"
 <linux-sh@vger.kernel.org>, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
  Heiko Carstens <hca@linux.ibm.com>, "musl@lists.openwall.com"
 <musl@lists.openwall.com>, Nicholas Piggin <npiggin@gmail.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, LTP List <ltp@lists.linux.it>, Brian Cain
 <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Xi Ruoyao
 <libc-alpha@sourceware.org>, "linux-parisc@vger.kernel.org"
 <linux-parisc@vger.kernel.org>, "linux-mips@vger.kernel.org"
 <linux-mips@vger.kernel.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, "linux-hexagon@vger.kernel.org"
 <linux-hexagon@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "David S . Miller" <davem@davemloft.net>
Date: Fri, 21 Jun 2024 10:54:08 +0200
In-Reply-To: <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
References: <20240620162316.3674955-1-arnd@kernel.org>
	 <20240620162316.3674955-8-arnd@kernel.org>
	 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
	 <e22d7cd7-d247-4426-9506-a3a644ae03c4@cs-soprasteria.com>
	 <1308b23a-d7c0-449e-becd-53c42114661e@app.fastmail.com>
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

Hi,

On Fri, 2024-06-21 at 08:28 +0200, Arnd Bergmann wrote:
> It's more likely to be related to the upward growing stack.
> I checked the gcc sources and found that out of the 50 supported
> architectures, ARGS_GROW_DOWNWARD is set on everything except
> for gcn, stormy16 and  32-bit parisc. The other two are
> little-endian though. STACK_GROWS_DOWNWARD in turn is set on
> everything other than parisc (both 32-bit and 64-bit).

Wait a second! Does that mean that on 64-bit PA-RISC, the stack is
actually growing downwards? If yes, that would be a strong argument
for creating a 64-bit PA-RISC port in Debian and replacing the 32-bit
port.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

