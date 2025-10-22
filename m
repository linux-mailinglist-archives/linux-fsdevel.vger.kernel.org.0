Return-Path: <linux-fsdevel+bounces-65090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B0191BFBEE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3854334C724
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A86347BD1;
	Wed, 22 Oct 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EtfaCoDm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ss9zZT1n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE93346E40;
	Wed, 22 Oct 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137353; cv=none; b=Paf/foHKbyx/KXxMFxV7+Hv9CSbn7dji7Kq4iOeaEtg4NkZEDNmffMuqP3UA5uBJNNE30dB+8SK/9ilJLHN51UaocDO4+BaPHGliPT6d7kvNOK8skkTkumif1wN2Mqh8t9QJwhQNJ1riWlpChbcShVj9FI79BFtrR4hUQJ/58TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137353; c=relaxed/simple;
	bh=AvjdMw2sCffsuBsINoV/J68QB1LlzUsen6SY/K/sTgs=;
	h=Message-ID:From:To:Subject:cc:Date; b=GSjBMjBmYGz4URh2rWpJLHGoLOqjJXnCmHjX9BXj33vDroDq3u9oNgQ22+OiGIXPEUkqGPH7OXDaFm4SMJ3EfyTG3+CyvoE7RXxsefABOFDk+yS+LAhV9xt5t682GjX3hel+wpttaQdLrOyq8nqZt86/tMrNcpxDWyogdfl9jVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EtfaCoDm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ss9zZT1n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022102427.400699796@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=GLXMwWXFIbD7cZKiqLR8SWn7Xt+iSqcrcxps9Q+G9kY=;
	b=EtfaCoDmFor8sSyXEn7oHgxdwynsxqOq3FyCVUuhPIgRs9x5vdmO92747Cz8TOKGl4pO+h
	ZKBXS45G2J7mtFB7bIbQVW+HUcOV3Y864eGZCPy97TDME/wSAWlPnheYnWGw8sDNUcEaqJ
	18ozfWu+ohRqajooCKIUx6N5b6VdCCo0mx4CHbj65zTzjsxNaXDmXnMkdMlfRmJWxg+7TX
	2HmOV/4/UrxLFOcsdgGb0UUsX1EeRuVxhh5jfU948EwHm7mOOaa17GMdraDdgMT+nOu2Dm
	Nh9yba2+vXILBG3SJv5GUZIWaa5XNotuqPRL+KLJqsLbbK0pDKlJWBfK0candw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=GLXMwWXFIbD7cZKiqLR8SWn7Xt+iSqcrcxps9Q+G9kY=;
	b=ss9zZT1nrdUlW60YnW7MoEIuOhi/H1ZFLAptXi6Q2OQGKph9Q1UEzducE2vpLJL3u2pCgV
	douIrhd397x/hWDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V4 00/12] uaccess: Provide and use scopes for user access
cc: kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Laight <david.laight.linux@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Date: Wed, 22 Oct 2025 14:49:02 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This is a follow up on the V3 feedback:

   https://lore.kernel.org/20251017085938.150569636@linutronix.de

Changes vs. V3:

  - Remove the superflouous if (1) in the scope macro - Andrew

  - Use asm_inline in the x86 conversion - Andrew

  - Rename to scoped_user_*_access(), remove underscores, use a void
    intermediate pointer and add a comment vs. access range - David

  - Use read scope in select - PeterZ

  - Fix comments, shorten local variables and remove pointless brackets -
    Mathieu

  - Simplify the coccinelle script, which needs still more polishing -
    Julia

The series is based on v6.18-rc1 and also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/masked

Thanks,

	tglx
---
Thomas Gleixner (12):
      ARM: uaccess: Implement missing __get_user_asm_dword()
      uaccess: Provide ASM GOTO safe wrappers for unsafe_*_user()
      x86/uaccess: Use unsafe wrappers for ASM GOTO
      powerpc/uaccess: Use unsafe wrappers for ASM GOTO
      riscv/uaccess: Use unsafe wrappers for ASM GOTO
      s390/uaccess: Use unsafe wrappers for ASM GOTO
      uaccess: Provide scoped user access regions
      uaccess: Provide put/get_user_scoped()
      coccinelle: misc: Add scoped_$MODE_access() checker script
      futex: Convert to scoped user access
      x86/futex: Convert to scoped user access
      select: Convert to scoped user access
---
 arch/arm/include/asm/uaccess.h               |   26 ++
 arch/powerpc/include/asm/uaccess.h           |    8 
 arch/riscv/include/asm/uaccess.h             |    8 
 arch/s390/include/asm/uaccess.h              |    4 
 arch/x86/include/asm/futex.h                 |   75 ++----
 arch/x86/include/asm/uaccess.h               |   12 -
 fs/select.c                                  |   12 -
 include/linux/uaccess.h                      |  308 ++++++++++++++++++++++++++-
 kernel/futex/futex.h                         |   37 ---
 scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++
 10 files changed, 492 insertions(+), 106 deletions(-)



