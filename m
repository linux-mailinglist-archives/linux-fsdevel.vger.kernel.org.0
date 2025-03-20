Return-Path: <linux-fsdevel+bounces-44495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480CFA69D1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D45E8A6AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EE189F43;
	Thu, 20 Mar 2025 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="XZ+/4QWH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35A15624D;
	Thu, 20 Mar 2025 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429674; cv=none; b=AriMQBHwe+vusBZcU65D3eSAIpyGWBiXMVO4MNaUajOMhEf0kf5W4zL5SCp4Y2cJSba05S1zzG3qBomcu+leDj8pyBlNtJlabe/YzycZBgzzJuguysEWNhFyiQ1n7rA37RJ84JP7z2y2H3IgBi7HY2gQwVAXykjRuow8vrbXVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429674; c=relaxed/simple;
	bh=CJIUNsN2dt6EooxWuuLZH7hIJ0xmNFThGGO3qOlozWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UlKi8SToyun5wtpW3C9dXds7WCd4P9HldIMR2N/h+mWTKfQkj/0IOqdWbnVrnPVovD2rirkWZ8U3HKSV3b8pYpy+IB4U5D/j3pN/ApQlee6XWJzmf9kjfNuxNbnILTGapBRSgLIwbBGoAmPfL/x7FrOU/FP0KQhRw/Y5fX6VKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=XZ+/4QWH; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZJ5fs4tZ4z9smm;
	Thu, 20 Mar 2025 01:14:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdPxQYjtyqv8ccDDNGwiGYeCL+sP9QbuGvXip2omb2s=;
	b=XZ+/4QWHb4KU+dh+HSBGU8+CtmUZynY1m0LvMRPWjZqD6fftZcpZxCoTlRpJxqSmOxIsI7
	fAuptLQvQ1v5hyzo9jAx7b/wmnVlsskWuFRl58pBg1BTxm5vEH9Pi1YvQpKCADmUrwXwRC
	yHtwIomWubYpbkZTw6rDmxlqKxAWF32/aUiuLz+Dby4xclRliGCcN3bgToGHKbPES1kEV2
	ZknQh1ekvXO1sTEVCzlu/azU4nJuL/dxr1hei6xpl+ZROq5MtMIgKmykbZEY7YHE29sTro
	ja65aVn6okD8yVS1D/ZMQ93+tKRy4LXqIvTN6mxpfqEorWescIP4ArNsYT9wyQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Wed, 19 Mar 2025 20:13:55 -0400
Subject: [PATCH RFC v2 6/8] staging: apfs: init build support for APFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-apfs-v2-6-475de2e25782@ethancedwards.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
To: brauner@kernel.org, tytso@mit.edu, jack@suse.cz, 
 viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=CJIUNsN2dt6EooxWuuLZH7hIJ0xmNFThGGO3qOlozWo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK09QWEQzVW1YZ05EdWRkSmFVSkgvdGZXdlhOc2ROCit2UnoxdVlUdnFXTzN4dHZQ
 TnZXVWNyQ0lNYkZJQ3VteVBJL1J6bnRvZVlNaFoxL1hacGc1ckF5Z1F4aDRPSVUKZ0luTWltZjQ
 3L2I1NWMybGNpR2lHNitFM1BDU2xwNjVVN1k2TE8vMTQ4Tyt5N1l2Q2RHdHVNcnczN3QwZ2xHUw
 pVWjNTWHRaWDYxVit0Uy9aWU5BODlkbVRzZ216R1B2bXorSHFaUWNBQ0M5UllBPT0KPXhTaFgKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

APFS read support is stable and functional for unencrypted, non-fusion
drives. Write support for unencrypted drives is somewhat stable and
supported. This commit adds the relevant Kconfig and Makefile options
to build this APFS driver as a module or kernel builtin.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/Kconfig       |  2 ++
 drivers/staging/apfs/Kconfig  | 13 +++++++++++++
 drivers/staging/apfs/Makefile | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 075e775d3868b3449922a25df1f79dec5a83a42d..2a063a9b759091eba8b0d5486976552d3a5df0a0 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -50,4 +50,6 @@ source "drivers/staging/vme_user/Kconfig"
 
 source "drivers/staging/gpib/Kconfig"
 
+source "drivers/staging/apfs/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/apfs/Kconfig b/drivers/staging/apfs/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..55de44bba9ef29c79a1647d722caa57ba813d189
--- /dev/null
+++ b/drivers/staging/apfs/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config APFS_FS
+	tristate "Apple File System support"
+	select LIBCRC32C
+	select ZLIB_INFLATE
+	select NLS
+	select BUFFER_HEAD
+	select FS_IOMAP
+	select LEGACY_DIRECT_IO
+	help
+	  If you say Y here, you will be able to mount APFS partitions
+	  with read-only access. Write access is experimental and may
+	  corrupt your container.
diff --git a/drivers/staging/apfs/Makefile b/drivers/staging/apfs/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..2fa127dd126716f0159baa514ba3194688ec1c0f
--- /dev/null
+++ b/drivers/staging/apfs/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Linux APFS module.
+#
+
+obj-$(CONFIG_APFS_FS) += apfs.o
+apfs-y := btree.o compress.o dir.o extents.o file.o inode.o key.o libzbitmap.o \
+	  lzfse/lzfse_decode.o lzfse/lzfse_decode_base.o lzfse/lzfse_fse.o \
+	  lzfse/lzvn_decode_base.o message.o namei.o node.o object.o snapshot.o \
+	  spaceman.o super.o symlink.o transaction.o unicode.o xattr.o xfield.o

-- 
2.48.1


