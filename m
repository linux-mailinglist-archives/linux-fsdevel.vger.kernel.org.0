Return-Path: <linux-fsdevel+bounces-55228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96059B08897
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A92A43FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F8289E0F;
	Thu, 17 Jul 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iyM1zKKI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7NzxRth6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615D2877C6;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742689; cv=none; b=Y5vKRpx0QI7Jb0VWaPx3BSqjuNoI2u60YmrkUXGoppVeel45IrPRd+UMParL+5zzJDq+egoyjx7K/xF1/wSHA41tmBGMUWwZt8CiwvQS4mUyeLfc1wQUsv4+J1W0wLxRNbMniwiUdwCgPuZbWoqlxshiOjJazDHdKjInGpHtTbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742689; c=relaxed/simple;
	bh=2jMdX6j55NT9eihyocsisG6oF4T76N5o4zc+QU5NAAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgqOT6G9u57H2VT1fG0h+UlKNicstwaxjCoEarVglKtZD6SBTMaEv3nzh3bv++cV9IZvsUuccTTFCqRJcW/2SP6YbVKlPIWN++EthOXH9psDQD9rlbC2EOdCxbaaSxfsPOTQCqfw+gnrhRiUgkhch2fRPwIhGgB/5J8Hg+6fh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iyM1zKKI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7NzxRth6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWbDBIIXVL3ZWM9iRY5xS/P3YT+spaFoacgu8gc6A0w=;
	b=iyM1zKKIkm8FsKvW1XpLqiIs0+6vNqb26PlBs1dckBn+rPECfpE7rV50zGolGtlNG84k7M
	8tW6dRW9xYhUr7ePkQm6zX94jVSXFqfBVGWwRgmy0oF6weXs1+CmEYwmiOLupy31QbJ40/
	qEc9VcHdz86LQOAwhBfxODdlV+aLtbWMqTnGR3jnLNaQUMKQ6zrQYNCkeMqS5C1TU8tYVY
	9URM33pKqrZv9XNAI/XhyBLeC65HoEXgXm368eN3kc3b02OwQK3jHxK9I8B/YJXc80lyA4
	QTK60AC68VZsJ4vXCh6ZnTu5C5uRZQbbamhi2CjIJ/ANMwQypeC7nLpGfzJFrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWbDBIIXVL3ZWM9iRY5xS/P3YT+spaFoacgu8gc6A0w=;
	b=7NzxRth6zWVV/6I4Dq1iHBWA9/fd5z/WOJ49OSIcjU2VB/cZiJ3oAh1IqTKWw4HSAjRS11
	vimlphpNeiIQ6+Cg==
Date: Thu, 17 Jul 2025 10:48:05 +0200
Subject: [PATCH v5 03/15] kbuild: doc: add label for userprogs section
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-3-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=891;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2jMdX6j55NT9eihyocsisG6oF4T76N5o4zc+QU5NAAM=;
 b=+3aySTgi6hWn9mZEvgNetw07NXKrm6NyhIOGMeEqfgPL0d3Qqs8y7i99gbydKBvBgqLxdXGEo
 Le7o3xihKh1DCfAS37Y50FC2L5PE8tOSeM12h0u6XixSPfJUZrXhOYI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some upcoming documentation will link directly to the userprogs section.

Add a label to the section so it can be referenced.

Reviewed-by: Nicolas Schier <n.schier@avm.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
---
 Documentation/kbuild/makefiles.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 8aef3650c1f32b6b197e0dc777e26775d371a081..c14c1f632f6069c8751c8388a35bef539e19f9e8 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -891,6 +891,8 @@ This is possible in two ways:
     This will tell kbuild to build lxdialog even if not referenced in
     any rule.
 
+.. _kbuild_userprogs:
+
 Userspace Program support
 =========================
 

-- 
2.50.0


