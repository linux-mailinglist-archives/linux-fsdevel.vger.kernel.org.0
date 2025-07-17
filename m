Return-Path: <linux-fsdevel+bounces-55229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 981EBB08899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215C118879CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFB288C9D;
	Thu, 17 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OPzjx07J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xAUGO+Gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BF2877CC;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742689; cv=none; b=R+UPNO17grw+Qb4slryYN/4njDg96q37HWp8v+rj2Zm/3cXEa6vBq1y9m85QIs/eiOhG0s2vcoeCQyEyqeDDCd0GSF05r1ppqOHLPtGJSfh7qDwvK7nkK39arg/V+Y8xAP653iRVDjO9TOQnoPQvsrOnVlIW4P/pLUqVJguL0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742689; c=relaxed/simple;
	bh=cfu3lghX/dVKMnf+oTJvUQeZzazAXiEvWWJO6QHDXlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3j/NaXiajBt/VFrgDD+K09vS5Md++fplREqPaabQJtluReYOxyxpsY30yFNlPCxAfP8RDK+7sTUG7pm5u9hblqYpcb/TvqqZEZ5AhuZP/q15dSwlJV0S61yPZexBGkGbweguDZ0wiA8CE0kdWczuYRn12Dxgfvv6zsdVlX6svM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OPzjx07J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xAUGO+Gy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN4BVFhjUpkxABwqqODMy02TSfofXF5j7xQt53A5sBo=;
	b=OPzjx07J6hoGGcvsU2fCdpXuPeKld8KiH2ZENQmPI2YiE2BGny6t4r799olu5TWHi1Krks
	vf1RzZf/cyyF2+lHBNrPIGfMPZlqgG3992ql0ioDlMNb5hqwrf0D998VMLPbkGdIZucc2H
	D7K1KWy1RGa3sKnuTWGj1yoGcBih2IGdvL0VFpMH2ugPNfrVvvJyOhn6es5nWGFSPteRpG
	G1rPVzCXrSfufAe3G6rO/8uSbIqcFLLvQ5XV7aVUBi0qnXVdO74jKzFursgCQ+t4KdtD4i
	ckaB+oil+xGeV78osbYLSa74xduTwIGoFeBXzhkUiMzM6LiAk3EjzdSoMdz6aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xN4BVFhjUpkxABwqqODMy02TSfofXF5j7xQt53A5sBo=;
	b=xAUGO+Gyfr4tVFpKJ1JIrlbkIcDic4DfuPY2wBG5AwxYAafFn8F5+So7p+Jgk5vnTH6f4D
	m+iIN58gwWCUwIDw==
Date: Thu, 17 Jul 2025 10:48:03 +0200
Subject: [PATCH v5 01/15] kbuild: userprogs: avoid duplication of flags
 inherited from kernel
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-1-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=1281;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=cfu3lghX/dVKMnf+oTJvUQeZzazAXiEvWWJO6QHDXlY=;
 b=Vd8KNi0o39hC712kNsh4HqtZ1iWGgJyUvVmox4SD4cDv9sM2uVDnNecFKnQbmIaGuUnS+Xgw7
 H4Ox/ALXHZXCJGKfU1HzaPiVb+/itP7PQ4yTl34pPGNDMfWvjc4EzyJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The duplication makes maintenance harder. Changes need to be done in two
places and the lines will grow overly long.

Use an intermediary variable instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Nicolas Schier <n.schier@avm.de>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 35e6e5240c61a8a329011929fcd0352b881dccdc..c4293cf91e968ca8ee64452841fb266e24df63f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1130,8 +1130,9 @@ LDFLAGS_vmlinux	+= --emit-relocs --discard-none
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
+KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)

-- 
2.50.0


