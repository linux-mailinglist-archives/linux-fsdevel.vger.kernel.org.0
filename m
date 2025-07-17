Return-Path: <linux-fsdevel+bounces-55219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123BBB0884C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52241AA6A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D3289E1B;
	Thu, 17 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ruIWxhz6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7GCbJK+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CA283FD0;
	Thu, 17 Jul 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742145; cv=none; b=uooOyKIjhyCz3GaYOhzs1iXAk3nO7O4niAKBYZ7Hy5kc2CPcgcNFfgOCfPcwFGlVzM++ExQFI0L+RPnsObvh0yjmxvQHZuG+4yyOtapnpkMKC4ek9V5keLLKl39VsCx3T8SRXGz3eKqezU5RT3e1HXNNB7/HhMgNlaTRjfW8oGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742145; c=relaxed/simple;
	bh=zShZPUvddV04nP7ePLLt+JfO552xNTacDebxpq2ayPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVSpdVaHGHEFudiUoTxE/uAQVuS3zVldAVp0RN73xuvRCEnNviVVuLKyVoF6sp09/A+8WIttb7es1qDLemWkTZtKljkZrSqwznm7+mVVOPmE+brlH5TQRiaRt9Xb/Zp/cwAoqx7BrqSD2nCiFzFZIQHJsYhCi7lA/dMMPyF1FiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ruIWxhz6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7GCbJK+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqEciMN5D1yrpF8pzbxqPFErBTdvvekVDOGyFqtNWdk=;
	b=ruIWxhz6iZzxbtyuGwYjw2YjWsp/jjOtyAwuJaUqFagDnhAdlZS6CdE+g2YknzQQo8hCl0
	b9wOSDMj48Zjll7gWT+t/eSN4SV6IK36UuKUZQn1JLVsLYstcPKu+CLbajBy1WcWzhS1HH
	6tkderBga6hzSP5+5Xzx44dcKVhgGtMspuM6kU2vo0o7GUxVY9uwdEabZbWpwDnPbI0PVh
	AQo7yNnm63df29vP0FgZ1lN4uf1hgXPrWXAqMmkZFEnH8G6DSgbP9dn4T3CMTDK8AEzswz
	h+8MZnduC21SggyRdrf7cpC/efwp338sXUk3urkMmKjmbHNP2nMHuj5eoKt+6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqEciMN5D1yrpF8pzbxqPFErBTdvvekVDOGyFqtNWdk=;
	b=7GCbJK+OmrqaSlNwI2OZDb6lxp0TKS8gqKA3TtlHY+5zhm3XvXAip6DqFgHag8Dx5LJc7F
	YIkVFa9A7k5lJ1Cg==
Date: Thu, 17 Jul 2025 10:48:13 +0200
Subject: [PATCH v5 11/15] kunit: qemu_configs: loongarch: Enable LSX/LSAX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-11-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=994;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=zShZPUvddV04nP7ePLLt+JfO552xNTacDebxpq2ayPk=;
 b=UBKD/xPL6CqWivmgfWaIC2N85F6b3+iQ2bezBOMjDmOU2pdgyLsDWs2kiw3Y6B0ovxsU/v0Jg
 R+DzM5jfM6eDsVf4lNMbsl53KkMhoZMmBITvOBBmyXhdinavxasECx+
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The upcoming kunit UAPI framework will run userspace executables as part of
kunit. These may use the LSX or LASX instructions.

Make sure the kunit kernel can handle these instructions.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/qemu_configs/loongarch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
index a92422967d1da9f1658ef1e80d0d7365ddbae307..1dba755284f11ffc94d8946105b0cfa49cb6f604 100644
--- a/tools/testing/kunit/qemu_configs/loongarch.py
+++ b/tools/testing/kunit/qemu_configs/loongarch.py
@@ -11,6 +11,8 @@ CONFIG_PVPANIC_PCI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_CPU_HAS_LSX=y
+CONFIG_CPU_HAS_LASX=y
 ''',
 			   qemu_arch='loongarch64',
 			   kernel_path='arch/loongarch/boot/vmlinux.elf',

-- 
2.50.0


