Return-Path: <linux-fsdevel+bounces-61784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED4B59DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80C52A7181
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2878372885;
	Tue, 16 Sep 2025 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tMTiXy8m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2X5FfAfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932730FC31;
	Tue, 16 Sep 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040396; cv=none; b=RP5Sz9dTWcNlSPwFOU4eHeWJVlhtKCZQcY+9nmVZ0gGy9wzTU77oLwF6gtmqKFnKN+SWYO9bzgRwjn2rPuEpQ3b4TUbAfHDUFNftI6DDkCHNMVUYDV5Y2nVvdolq2dp8qpjekj5mMpPodmxCMDoSvLajw2jbC/cLzL0lu8Bpz2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040396; c=relaxed/simple;
	bh=LmP1t1NEliIYRE1NqprRXU4f2LEUc9PuYT11S4SHt7g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oU5QQQ+6eYrv/t8rihe4Igujf0zFaaz/z035m+OaTqdDtiNt29cT/BoIfAZi3bi1MbUfaEGjCoTptpEnWuQMWnzTwr9IevSjI3oa4hW+kqF6A4ZN8DfrLYdhAwcTiYZtlISVAvgTxovKyeipDG2j4/2mM3hdakMdDOxuATdtSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tMTiXy8m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2X5FfAfx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250916163252.100835216@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758040391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=buXtarGTm5jtJPETYvya0klPdCPo5lg6x42RHvHcKok=;
	b=tMTiXy8mUOfJCFDjOKCgDFF1NRDxySWAX2O8TLSvs30T9S1E2AiTsQVgh458xzHMSqXC+2
	1kcDX0vVYCkmHTAnaz0FZEsRLQAAvYHzKDLzisOvelP0eqKwFI6cc4j+0qctuul9fH7MjB
	7wIpQIG4gAC6OzloTYfH8zv2oLDUVnHsmZuwknO78ukUXHESIfyJ7Ol0y+74ie0REODCVS
	J7WwfoNfO3O6ow0DP1vSfLqvfBAxhU8IVWtU3vBeuW07mt/gQmZw61yF3qXI8YHcyvsOIp
	13UYm6KCKQuy+rUfIT3REKlA5bOgbNNXmZZLG4ix/OlbvfXQOuxavMGPHieSdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758040391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=buXtarGTm5jtJPETYvya0klPdCPo5lg6x42RHvHcKok=;
	b=2X5FfAfxhvDIRItdbY0APY7iqOVIg/EJmgLkNdRtkF+wSl4K88PZjRMj9VVKNrzby18DHX
	Rzngsjl5TGRcEHBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 x86@kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: [patch V2 2/6] kbuild: Disable asm goto on clang < 17
References: <20250916163004.674341701@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Sep 2025 18:33:11 +0200 (CEST)

clang < 17 fails to use scope local labels with asm goto:

     {
     	__label__ local_lbl;
	...
	unsafe_get_user(uval, uaddr, local_lbl);
	...
	return 0;
	local_lbl:
		return -EFAULT;
     }

when two such scopes exist in the same function:

  error: cannot jump from this asm goto statement to one of its possible targets

That prevents using local labels for a cleanup based user access mechanism.

As there is no way to provide a simple test case for the 'depends on' test
in Kconfig, mark ASM goto broken on clang versions < 17 to get this road
block out of the way.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>
---
V2: New patch
---
 init/Kconfig |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -96,9 +96,14 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
 	default y if GCC_VERSION >= 120000 && GCC_VERSION < 120400
 	default y if GCC_VERSION >= 130000 && GCC_VERSION < 130300
 
+config CLANG_ASM_GOTO_OUTPUT_BROKEN
+	bool
+	depends on CC_IS_CLANG
+	default y if CLANG_VERSION < 170000
+
 config CC_HAS_ASM_GOTO_OUTPUT
 	def_bool y
-	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
+	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN && !CLANG_ASM_GOTO_OUTPUT_BROKEN
 	depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
 
 config CC_HAS_ASM_GOTO_TIED_OUTPUT


