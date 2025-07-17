Return-Path: <linux-fsdevel+bounces-55222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2AFB08855
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7040F4A85D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D828B3EE;
	Thu, 17 Jul 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0r1anL2X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BY10f4Cv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AE285418;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742146; cv=none; b=D0WPskpitWv85rUzCkxT0Tw8vNcwrZbrQP1AJEVSur+qPdiX95LO1UBesMLgklEpd7/2fEa5KHZXtxwq/1i2S3ftYUmFqNRfqcAiYihBA1Lyd7XUaXxTlkmr9U1SlcCPp1ryPTlOxnSCjbWoMyBy5tsWGHLAeXM3iwL++17Sfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742146; c=relaxed/simple;
	bh=jzd2GUyiQxguW35ue6s9/EhpHIGuMVbD761YRMKAxLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJt0iAdx0xO7TRBTz+GO5ZsN6+wJXEvbjk3P/zn1ieGiiREIK1WSiVAHYXzP11+ajNGwNUUHqcEs3Seu4wIQAYTWqR3sI3+AXBz8jLvVsAaiS9M6SZkmFBeP5335iB/taKijHpnFjrT1mf9pVkCaFu/k8jG+bs6gx8NbhagTvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0r1anL2X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BY10f4Cv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBDQvUHybVGdnxlnUf0GHbOvIvdhQLf7DfYi3dD2ndo=;
	b=0r1anL2XdznoHnt0YQNzoHoVPgouB7uPz0KjE2zGIk0E/YL1f49fBnD8gB/zF7on6U2IFc
	I7f7ZzsaeLfPBHbQgnvz5qw/FvYYnv+YsTLzm64rR2mzWZxbJQdHm+sg4ivTr3Efyl8jIu
	UyLHVFLT/RAXXhxsRI5LHn7Cye5b+h05WJY6UpnZ4XahvvJo0ADVob9j3D+81Z9QxvLVYM
	Lveq1/WEZMSxEqvMvxfaeJ35+eo5rUfzA0rSopge68bAjTIBAsqPwROKlTbsijE1PBb5h2
	3mRt3my3r+LdEY9DtR8DE3ThSjB1bqyxOLZHGDUM0cz4z/laJ2WcvRO61wgPzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZBDQvUHybVGdnxlnUf0GHbOvIvdhQLf7DfYi3dD2ndo=;
	b=BY10f4Cvo0dik2q5QxTr5XWE8yAT2Bjh0+VuB/YSdoYqzwursG5yWt8pBlvUwfel/bM2PB
	Olx3ZbtWGa2Ge7Ag==
Date: Thu, 17 Jul 2025 10:48:07 +0200
Subject: [PATCH v5 05/15] init: add nolibc build support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-5-442b711cde2e@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=3172;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=jzd2GUyiQxguW35ue6s9/EhpHIGuMVbD761YRMKAxLU=;
 b=dmf4tJQr/51uuhkxdme9I0cExjnXB3IbgezIgvUWGaA7uD3N5c2wOPXgZ2+kxEhd8DOop2TGb
 1ZHq7+H/KUDDVgv3r0H8ACgHCzcWbBg4ShFzTvi32/oMIT08FYCpnTG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Building userspace applications through the kbuild "userprogs" framework
requires a libc. Kernel toolchains often do not contain a libc.
In this case it is useful to use the nolibc library from the kernel tree.
Nolibc does not support all architectures and requires compiler flags.

Add a kconfig option, so users can know where it is available and provide a
variable for common options.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS          |  2 ++
 init/Kconfig         |  2 ++
 init/Kconfig.nolibc  | 15 +++++++++++++++
 init/Makefile.nolibc | 13 +++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163f9fe8fe3f04bf66426f9a894409..e806158cc6798cf97a4aab58c038fb5351d469aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17702,6 +17702,8 @@ M:	Willy Tarreau <w@1wt.eu>
 M:	Thomas Weißschuh <linux@weissschuh.net>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git
+F:	init/Kconfig.nolibc
+F:	init/Makefile.nolibc
 F:	tools/include/nolibc/
 F:	tools/testing/selftests/nolibc/
 
diff --git a/init/Kconfig b/init/Kconfig
index 26cafbad4f1560fb56b4bef31ae29baf54175661..0af62f135192e0470e16eb6bb2fbb45ac38f4b81 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -92,6 +92,8 @@ config CC_CAN_LINK_STATIC
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
 	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
+source "init/Kconfig.nolibc"
+
 # Fixed in GCC 14, 13.3, 12.4 and 11.5
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113921
 config GCC_ASM_GOTO_OUTPUT_BROKEN
diff --git a/init/Kconfig.nolibc b/init/Kconfig.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..29cbc5437e70cbc5e256f00b74d0ab4801b40de7
--- /dev/null
+++ b/init/Kconfig.nolibc
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ARCH_HAS_NOLIBC
+	bool
+	default y if ARM
+	default y if ARM64
+	default y if LOONGARCH
+	default y if M68K
+	default y if MIPS
+	default y if PPC
+	default y if RISCV
+	default y if S390
+	default y if SPARC
+	default y if UML_X86
+	default y if X86
diff --git a/init/Makefile.nolibc b/init/Makefile.nolibc
new file mode 100644
index 0000000000000000000000000000000000000000..dacc78ab4c81c93f3a24ebeb70e34253842f9a53
--- /dev/null
+++ b/init/Makefile.nolibc
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+# Compiler flags, which are necessary to build userspace applications with the
+# in-kernel libc "nolibc".
+
+ifeq ($(and $(CONFIG_ARCH_HAS_NOLIBC),$(CONFIG_HEADERS_INSTALL)),y)
+
+NOLIBC_USERCFLAGS := -nostdlib -nostdinc -static -ffreestanding \
+		     -fno-asynchronous-unwind-tables -fno-stack-protector \
+		     -I$(objtree)/usr/include -I$(srctree)/tools/include/nolibc/
+
+NOLIBC_USERLDFLAGS := -nostdlib -nostdinc -static
+
+endif # CONFIG_ARCH_HAS_NOLIBC && CONFIG_HEADERS_INSTALL

-- 
2.50.0


