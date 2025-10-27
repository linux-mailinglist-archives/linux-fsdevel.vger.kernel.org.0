Return-Path: <linux-fsdevel+bounces-65673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B2C0C682
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 09:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 848614F3C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521B2E8B95;
	Mon, 27 Oct 2025 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iGpxBn9D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGRlxXc7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4781553AA;
	Mon, 27 Oct 2025 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554626; cv=none; b=KqSObNPgmV1dwqkwofp72Fxpb+NQT7mhxSOV+jW8lijQo/zqf4b/n6ms+9ZcRVun5HCCxoqZHhwATHCFeANjFngWalhwzijH0yT8iO+UHyfH4cCs+H3O2FCe3+/gnY5dolU6q2F2tAUy6aU7DHu6eV3wIgKWbDbOYUPaxqHzuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554626; c=relaxed/simple;
	bh=ZHxLQkYXek6HHXQ5ls+E2bALK/kHDUf0oXDBDKXjjrw=;
	h=Message-ID:From:To:Subject:cc:Date; b=gmwo1RbCcoN4prNcRedEMG/ExvbOHXe+fUchqIOs/fCKTDriza7y+In1BtSFQdKjlMy5dJNZ+pt2hfBqgiKfCJCwSrf04l1GOZZLvUCS8H4rM6YAi+0vs2bECcKsAvMo8T3LEr57flTB5SzNjHsl+TFxE3KKniah7Da7xhgLgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iGpxBn9D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGRlxXc7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027083700.573016505@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=O22qaF58WF4tGgLoC6Og2ju8TL8XuvxgR3eoZKY2RJA=;
	b=iGpxBn9D31bepoX3FHP5IxFfDs5MNFXXJwqX00s5HifGOgVtnQBNtWlVQO67EBAqw5ZFNe
	jRyhkjcwumS8f4M4armAfDMf932m5kwZLGz6oowakDMrVHJzvvvwd/9RAPtBfWlGzRmEse
	gHNEi72Bj3wWNLUru0yqQR3WMCgyxQGzZOpZ2j0tRwHdogz/sx2wcjKo4NQKBCDIH+c7Dv
	M6bQlHP37PdBS0lJ7hmjRWkogKwMpxS9DNSPeAtvFcyeKirRANDrLqkiZGQwvhNKRe5C7H
	xZdPWOc+g630w3DfFMU/UvoidKO3Wl22xCGwvhnz3O9xIynKtbYCK7vgdMHxyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=O22qaF58WF4tGgLoC6Og2ju8TL8XuvxgR3eoZKY2RJA=;
	b=dGRlxXc7DXj9/3iHmX+iKPKx+vPqnQiXifrAOlfFvv9S86+GVFnxrCPovoOdbKKfgVviBe
	Sc3dSh9pQ+LjAIDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V5 00/12] uaccess: Provide and use scopes for user access
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
Date: Mon, 27 Oct 2025 09:43:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This is a follow up on the V4 feedback:

   https://lore.kernel.org/20251022102427.400699796@linutronix.de

Changes vs. V4:

  - Rename get/put_user_masked() to get/put_user_inline()

  - Remove the futex helpers. Keep the inline get/put for now as it needs
    more testing whether they are really valuable.

  - Picked up tags

The series is based on v6.18-rc1 and also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/scoped

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
      uaccess: Provide put/get_user_inline()
      coccinelle: misc: Add scoped_masked_$MODE_access() checker script
      futex: Convert to get/put_user_inline()
      x86/futex: Convert to scoped user access
      select: Convert to scoped user access

 arch/arm/include/asm/uaccess.h               |   26 ++
 arch/powerpc/include/asm/uaccess.h           |    8 
 arch/riscv/include/asm/uaccess.h             |    8 
 arch/s390/include/asm/uaccess.h              |    4 
 arch/x86/include/asm/futex.h                 |   75 ++----
 arch/x86/include/asm/uaccess.h               |   12 -
 fs/select.c                                  |   12 -
 include/linux/uaccess.h                      |  314 ++++++++++++++++++++++++++-
 kernel/futex/core.c                          |    4 
 kernel/futex/futex.h                         |   58 ----
 scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++
 11 files changed, 501 insertions(+), 128 deletions(-)


