Return-Path: <linux-fsdevel+bounces-64437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52319BE7F62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B281F1A622AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9131282E;
	Fri, 17 Oct 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eko32jph";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvhhlE5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27783126D5;
	Fri, 17 Oct 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695739; cv=none; b=bSkVYedLZdVX0ly2lhH2CoZACmruGRXmd+F+HJk3rbpv1GT58Nj31LYsMAPXzUgQNmgNjVLUSAydOgMDjDrgSPhv7baSZ70nJPWlbCJ9Y5kPGuh0Cyccsn7wkL21ZiKtBYGcrwb0F6WzLruw6nPQJ4dT9Hkms4etqJQKr0m7zJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695739; c=relaxed/simple;
	bh=uHjv+qmokl+WI06YfXrtTHcQyQsJW3f4tH1Gpik6QDQ=;
	h=Message-ID:From:To:Subject:cc:Date; b=ipb00oyHKEdhV+ADyxPyIgdTLPXD2srWd5KtWa1+VKqM0GLoA7ZJA5Eojr40XcvMi0X9BXzpTJXKfjtrDFyXeOz4Uh9KyrcoMz6Sb01y84eHfPKhWMQ2me3+yeJNzbHf1R5fEPHDN8+5LjHCjT9qyLpofA+dstiODM/zx4IBalQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eko32jph; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvhhlE5Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251017085938.150569636@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760695735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=sQjHTAU2ANvy0R8z2gg1idxWUOVjpB50pHnvfHruLTk=;
	b=Eko32jphl7W3Xb+zGpZ6phPdMdJwxHmnxeLrIJj9qdJitAWXAuSbzoODtPZR1exPSq4jMr
	Xn7ZTH6KgwcOGALTdCL47R8+MFa4jiWK8UogHGnp9QeK4hbWrSPeVPSRc3y9z6FMLcfPGe
	KbL4vt6K04JVr8neOXAHUbizdH9XNtossRpzFH+fjRoWAjYd4ZAa2/eiSueqkaHZBNR5/Y
	WgMiXtDNsPUyxQGr8DumDuVWYTMwSZ2IlWZkWq/cFKVncN/jALJBcLTV8IeVbKMcArrHJ2
	eizyzm/gJ8rGmf9GDpZ/1JOEQhlypSXGiWokxNij3wWrwzykELy0t6VKFNZubQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760695735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=sQjHTAU2ANvy0R8z2gg1idxWUOVjpB50pHnvfHruLTk=;
	b=jvhhlE5ZDsXkGj4CvFqtuuX6HrygY+mr5PHtByDjb6j+LIqTh5z4fS9wp9QqAIwAio4UlZ
	gHuITp9EO2Np+kAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V3 00/12] uaccess: Provide and use scopes for user masked
 access
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
Date: Fri, 17 Oct 2025 12:08:54 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

This is a follow up on the V2 feedback:

   https://lore.kernel.org/20250916163004.674341701@linutronix.de

The main concern over the V2 implementation was the requirement to have
the code within the macro itself.

The main reason for that was the issue with ASM GOTO within a auto cleanup
scope. Clang refuses to build when the ASM GOTO label is outside of the
scope and GCC silently miscompiles the code and misses the cleanup.

After some back and forth discussion Linus suggested to put the local label
workaround into the user access functions themself.

The second reason for having this construct was to make the potential
modification of the pointer (when the architecture supports masking) scope
local, as that preserves the original pointer for the failure path.

Andrew thankfully pointed me to nested for() loops and after some head
scratching I managed to get all of it hidden in that construct.

So now the scoped access looks like this:

	scoped_masked_user_read_access(ptr, efault) {
	        // @ptr is aliased. An eventual mask modification is scope local
		unsafe_get_user(val, ptr, efault);
		...
	}
	return 0;
efault:
        // @ptr is unmodified
	do_stuff(ptr);
	return -EFAULT;


Changes vs. V2:

    - Fix the unsigned long long pointer issue in ARM get_user() -
      Christophe, Russell

    - Provide a generic workaround for the ASM GOTO issue and convert the
      affected architecture code over - Linus

    - Reimplement the scoped cleanup magic with nested for() loops - Andrew

    - Provide variants with size provided by the caller - Mathieu

    - Add get/put_user_masked() helpers for single read/write access

    - Fixup the usage in futex, x86. select

    - A clumsy attempt to implement a coccinelle checker which catches
      access mismatches, e.g. unsafe_put_user() inside a
      scoped_masked_user_read_access() region. That needs more thought and
      more coccinelle foo and is just there for discussion.

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
      uaccess: Provide scoped masked user access regions
      uaccess: Provide put/get_user_masked()
      coccinelle: misc: Add scoped_masked_$MODE_access() checker script
      futex: Convert to scoped masked user access
      x86/futex: Convert to scoped masked user access
      select: Convert to scoped masked user access

---
 arch/arm/include/asm/uaccess.h               |   26 ++
 arch/powerpc/include/asm/uaccess.h           |    8 
 arch/riscv/include/asm/uaccess.h             |    8 
 arch/s390/include/asm/uaccess.h              |    4 
 arch/x86/include/asm/futex.h                 |   75 ++----
 arch/x86/include/asm/uaccess.h               |   12 -
 fs/select.c                                  |   12 -
 include/linux/uaccess.h                      |  313 ++++++++++++++++++++++++++-
 kernel/futex/futex.h                         |   37 ---
 scripts/coccinelle/misc/scoped_uaccess.cocci |  108 +++++++++
 10 files changed, 497 insertions(+), 106 deletions(-)

