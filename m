Return-Path: <linux-fsdevel+bounces-22220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872791407D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8291C20C5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573606FB1;
	Mon, 24 Jun 2024 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KX8RM+U5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6F4A2D;
	Mon, 24 Jun 2024 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719195848; cv=none; b=BYGl6V2YottxA4mmdJNhz2hxxF52DH/bDnFlcAyTh+Cff9M86lY3D8vwk4IAsfYn1ylvzG1G2mzdEnHIbaunY+J7ryXGs855/ASMvk953yQZKIIL+bXV6f84bXuVZDEgo6ETSUhR1xHrcmmJVvfm6Ah64HfQMO1rNKstPWJwd/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719195848; c=relaxed/simple;
	bh=MIZ+d9HVKB7l6t281umhcoUxFGn6SV9luOFbz0dNbIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOzWokqrh9oTPjOnbqIAjS+rVB8urnmNeJXybRk5eQrHAfWvWaSsyZeEYblF01ZesFG207AOc51nbDM0XRBgNCuC/mFLqJfUuHSWuoAOrTt0UaeBkWR/aV3TfPMr4pudDiQQ+runS8udtbELqeHf4YfZBt3zChtxRZei815u1wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=KX8RM+U5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719195836;
	bh=BKlnKRhf6nOKvpU2yiC5wPra7+gk0fCQGmL8XKcMn0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KX8RM+U5NabS/m3sC+tWRHbeSjKdVCYygRWRhGcNZfuATg8lPbu11OtJuslFGBGAC
	 Wz/fHPAOgow+LyxR89oZOXJd0a3f4dU9OFnc9eDWIjgE79UH+hrSeMYPjAAzI/IuFW
	 NuU2PXZTUObRBcXVLvLq9fW/iHCjn9gTJ/D/BDT26gm+5spRewoRqZDHnknbA28Ozg
	 G+STsT+QNuUpt0Ic340jHnh8m6iMF/pftiNpSUXevcqIiFEVW3/7qYFZEsrvdkpx2y
	 gsAsX1el1xuveLygKU26SOCWitwndKbI71vrgTKYRAdZkRGPPV6fF7EhY6RmMITXEm
	 8GV31u4x5U7mw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W6sGC1H48z4w2N;
	Mon, 24 Jun 2024 12:23:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 sparclinux@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Brian Cain
 <bcain@quicinc.com>, linux-hexagon@vger.kernel.org, Guo Ren
 <guoren@kernel.org>, linux-csky@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 libc-alpha@sourceware.org, musl@lists.openwall.com, ltp@lists.linux.it
Subject: Re: [PATCH 08/15] powerpc: restore some missing spu syscalls
In-Reply-To: <20240620162316.3674955-9-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-9-arnd@kernel.org>
Date: Mon, 24 Jun 2024 12:23:46 +1000
Message-ID: <874j9jqdsd.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:
> From: Arnd Bergmann <arnd@arndb.de>
>
> A couple of system calls were inadventently removed from the table during
> a bugfix for 32-bit powerpc entry. Restore the original behavior.
>
> Fixes: e23750623835 ("powerpc/32: fix syscall wrappers with 64-bit arguments of unaligned register-pairs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/kernel/syscalls/syscall.tbl | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

