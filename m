Return-Path: <linux-fsdevel+bounces-55231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B716B088A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5048B170435
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD20228A725;
	Thu, 17 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFYBhHDj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3F05fl5d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB562877D0;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742690; cv=none; b=ZOeTQpaWsMrfgStWQGunUkkXBVqz2+K2jEj8RY/kXUJ+9P1bn0c8kBGga71W/8ypSMvRby1uBXyfmBGgmkSJtKHAiTSqEilz7hc4VgN7OORVw5+HpK9/IFEbfd7azy9FTY65BxDF9APFacDrHa4/qp4dxFa8uL9e048Dug/vMvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742690; c=relaxed/simple;
	bh=dIUE6tZrTNTxC3+u6IFHyxs2sPvw2ecmLqykRiDqz8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfWggGH303kZhqVaxhwOK579FgEJPyWiDp4b26NROOQc+Te5jMEWL094YkmzgezV41TDnPR+t/pChGk2AT8S/7HgRRv/UlMC1X8X8U6FyZqiQwowDekYGkHwGvpdpfjXyUXpijWI9hjZAUF9fLRcVvcYQxUyZyMyCWLc4IiagsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFYBhHDj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3F05fl5d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fvHbbWayxoLaIlEeiWIWwoowc66jl/1QEnNwzRl72c=;
	b=NFYBhHDj+5vC0apu+11p3HC6Bj2Z33ovApsNFofSqJawsmrakJ29w+3HzANzC8APMKdwvY
	xmAjwmkV8sIolJMM2iqqA5VTWGhoaV7ZfU0vkEQOZ7l5pzNxDqaT/dL2aCM3kale/TgBpz
	G/RggqZJez5aazdgwzoctP5hPKB+j4Em85X8p2HvHgxCTHVv8YdFAsIwLPOqogIyevD9zg
	YEPRCeg4yVy7N1fHeBpoNoqn2YQyefZH6hifjHPa5T4/nFe3ZSVZnwO3FkQ0MAR1bbisuf
	A6bhdbX5VKywI9cFEycZlNU8KqNT+UwpgPiX/Hr3lME9AR6gO5mUqHNhmuVMAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fvHbbWayxoLaIlEeiWIWwoowc66jl/1QEnNwzRl72c=;
	b=3F05fl5dvW/9fmYbgnK9lprIg2y3za18t+pFe4KZuCBQQu616nRklOcBwiew7Yg4cI52cm
	oNNwA0o9pQd1e5DQ==
Date: Thu, 17 Jul 2025 10:48:04 +0200
Subject: [PATCH v5 02/15] kbuild: userprogs: also inherit byte order and
 ABI from kernel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-2-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=1274;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=dIUE6tZrTNTxC3+u6IFHyxs2sPvw2ecmLqykRiDqz8A=;
 b=8LQUp/nSE/ybRwiXPcHvCz5equrF34qvOUZqTx+PG8THmHxyI9O6UNJ0QjzRMHBKGbO1phZ1Z
 Bzr8vyvrh+mDJVCJ37DsumVYtf2Y9/PwTESa44N85y9P6gO04dAxeRA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Make sure the byte order and ABI of the userprogs matches the one of the
kernel, similar to how the bit size is handled.
Otherwise the userprogs may not be executable.
This happens for example on powerpc little endian, or riscv32.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e45a2807dfa257f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
 LDFLAGS_vmlinux	+= --emit-relocs --discard-none
 endif
 
-# Align the bit size of userspace programs with the kernel
-USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
+# Align the bit size, byte order and architecture of userspace programs with the kernel
+USERFLAGS_FROM_KERNEL := -m32 -m64 -mlittle-endian -mbig-endian --target=% -march=% -mabi=%
 KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 

-- 
2.50.0


