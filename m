Return-Path: <linux-fsdevel+bounces-61829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574CFB5A37E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 22:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013131BC363A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491B283FD7;
	Tue, 16 Sep 2025 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOLgRMgn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MFtM5T/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9431BC89;
	Tue, 16 Sep 2025 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056201; cv=none; b=OpxBlBkM39J1Qm+RR3agoh/g5P6qOuer8XnfvfDR1sxNI8Ym8fHzFXJFZVw6HyH8EMJivuqoiHfthPalkfq9FQW/z9rM/c/zwElbA0HkAyxYAMtC1VS4yn+nC3s8RK7BVKla13b5loELOQYc9pKr2zMC3LLziiDn/z8jBrgWKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056201; c=relaxed/simple;
	bh=koQDNjlXuAxFNxiPa2xHUdVqSkQnErvMuXgbqWZmMN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mR1TI6yjzyW6Y+1NvwK6wakVh0ESx3lAnEXGvSjP9nlnjBz92GYDW3quWCHtTfmaFiDBLnlZihf5SPUrde+pLvuX8F9GtKY94GwY6ivTPyjUDuEhPwKnNAj+GKHZlFIxNWrv/kcD48GfGqZFSBhXI3ZY+AZa5s1eGKD/8AksNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOLgRMgn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MFtM5T/Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758056198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xUyqhsEiyiUoxhJieOdMTcH66oxWdRq1GQhqVdXzx4=;
	b=yOLgRMgnYE69+7MlYv3qCTagaN6kVQQCjqUEw0JlvAlnaNwzk/bGmJ3rTHtN7JjeISB+jL
	mv+meKS0TlnU5SVG/SgMlwbTkAm359ew/MyEUJ5/eC87h1UxbKKNDPr9JIXMLhhGxP37kJ
	Z9j2QuWaWNM10eyAyULEp5yuzjc5SxupVQHIqzbyAlWA/hDW6VqMGzo+yw6QBYszEo15+8
	XYFDG6ypTWzqzTC0tu8oFlgFAj1qP0c++HrNFH9jDrEp/AvK1Wmea2CJ5+jW0W74Z2eg8L
	/Jp6cte4T9TsFdscMLpIwBTThoJjhc02ubExYMXQafm24zgdgYPwF+Ih4LRBfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758056198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xUyqhsEiyiUoxhJieOdMTcH66oxWdRq1GQhqVdXzx4=;
	b=MFtM5T/YeW0GGddiSAFphbAmE/KU1rx1JNt3/rcSiWFowx9AM/VhLqeqVeXdFSY84jYUx4
	QiFRM/gYAMBeeMDw==
To: Nathan Chancellor <nathan@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>, x86@kernel.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [patch V2a 2/6] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang <
 version 17
In-Reply-To: <87ikhi9lhg.ffs@tglx>
References: <20250916163004.674341701@linutronix.de>
 <20250916163252.100835216@linutronix.de> <20250916184440.GA1245207@ax162>
 <87ikhi9lhg.ffs@tglx>
Date: Tue, 16 Sep 2025 22:56:36 +0200
Message-ID: <87frcm9kvv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

clang < 17 fails to use scope local labels with CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y:

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

There are other failure scenarios. Shuffling code around slightly makes it
worse and fail even with one instance.

That issue prevents using local labels for a cleanup based user access
mechanism.

After failed attempts to provide a simple enough test case for the 'depends
on' test in Kconfig, the initial cure was to mark ASM goto broken on clang
versions < 17 to get this road block out of the way.

But Nathan pointed out that this is a known clang issue and indeed affects
clang < version 17 in combination with cleanup(). It's not even required to
use local labels for that.

The clang issue tracker has a small enough test case, which can be used as
a test in the 'depends on' section of CC_HAS_ASM_GOTO_OUTPUT:

void bar(void **);
void* baz();

int  foo (void) {
    {
	    asm goto("jmp %l0"::::l0);
	    return 0;
l0:
	    return 1;
    }
    void *x __attribute__((cleanup(bar))) = baz();
    {
	    asm goto("jmp %l0"::::l1);
	    return 42;
l1:
	    return 0xff;
    }
}

Add another dependency to config CC_HAS_ASM_GOTO_OUTPUT for it and use the
clang issue tracker test case for detection by condensing it to obfuscated
C-code contest format. This reliably catches the problem on clang < 17 and
did not show any issues on the non known to be broken GCC versions.

That test might be sufficient to catch all issues and therefore could
replace the existing test, but keeping that around does no harm either.

Thanks to Nathan for pointing to the relevant clang issue!

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1886
Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a935c041835d14
---
V2a: Use the reproducer from llvm
V2: New patch
---
 init/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
 config CC_HAS_ASM_GOTO_OUTPUT
 	def_bool y
 	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
+	# Find basic issues
 	depends on $(success,echo 'int foo(int x) { asm goto ("": "=r"(x) ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
+	# Detect buggy clang, fixed in clang-17
+	depends on $(success,echo 'void b(void **);void* c();int f(void){{asm goto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))) = c();{asm goto("jmp %l0"::::l1);return 2;l1:return 1;}}' | $(CC) -x c - -c -o /dev/null)
 
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	depends on CC_HAS_ASM_GOTO_OUTPUT

