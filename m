Return-Path: <linux-fsdevel+bounces-44088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FBA61F91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8AB3B7673
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95D205ABB;
	Fri, 14 Mar 2025 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="havB/QP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7902205510;
	Fri, 14 Mar 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989532; cv=none; b=YI4pd5mvLmkdSXV+bHP+rHWQrEVOUY3VUNS+X0WIvB07vaHJ8Uk0HnFlMyGLC4Jbq9NaAuuhvmCkrsDNUZXdLFxVEi26mOCiGjQXj/tS+Y/SRrijs3UYmwaovtbsQ5uv0dwCkYF6rR4pVLedCPjtUdmENgv9WmogOms8NAkJODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989532; c=relaxed/simple;
	bh=CJIUNsN2dt6EooxWuuLZH7hIJ0xmNFThGGO3qOlozWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIA6IJNu7uNVd7gPven+Md+10sFLYSqkpB6skCaYbi9PBx6ZvCfcs5RwzxGCKQ6nhXdxOlT6B4VYcaQxEXYTH6XuZZPsHceAqDqn6Dojq7Stibc7acT7naQsbQTTgjxoNP3EfkNHT9WGdeD/VpAVJZQt9lJA44aHfWheQK7DnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=havB/QP0; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZDytb3g9wz9sm9;
	Fri, 14 Mar 2025 22:58:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741989527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VdPxQYjtyqv8ccDDNGwiGYeCL+sP9QbuGvXip2omb2s=;
	b=havB/QP0w4Vw0eE03bGGBbKqTpEg5CtGKAU6ahLVIEVWm2zuQ5ERB/HVbcMI/aDTKueWir
	adIuGuWrSCjJmeY7Nr4NYqUVQvNe+CGrNUcPEpMR0OGQisCex4A+A7j+QVUCZZVg0LJULX
	V1OtB9GKkL9GH9nfuiBT8lbnLKZ02mT0673Qq3e1Vx+rf+05VPkgOo8G/63rER6YNe29nC
	mh6a4NmVTNQIEmaK6f/zaEMBNAVLRaF0B2SRcgCUN8JS33Q4UjdFMqZO5it/vWh5PbFIa5
	NvkbJ3AfvY2thWeT1GsJ4KAWOochdb9w2l0MxvWPi4BLkWuWNPm3765LPW/AGQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Fri, 14 Mar 2025 17:57:52 -0400
Subject: [PATCH RFC 6/8] staging: apfs: init build support for APFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-apfs-v1-6-ddfaa6836b5c@ethancedwards.com>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
In-Reply-To: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu
Cc: ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2262;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=CJIUNsN2dt6EooxWuuLZH7hIJ0xmNFThGGO3qOlozWo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBGOVpWckdpOU8vYXV4dzZzN2FzdjlXMHUvTnI3L041CklhZDVBdmRrMi95L3YxN0FP
 UFI2UnlrTGd4Z1hnNnlZSXN2L0hPVzBoNW96RkhiK2RXbUNtY1BLQkRLRWdZdFQKQUNaUzRzN0k
 4R2hUMGN3VTRhRFBwZFkveFc0KzdmellmL3Y4OS9sekdROW0zam02eTUrdFZvNlJZZS9zK2pPUw
 plMTRzKzFiUUtSMFZ1YS85OForUEhGMmRjYS9LUkFQbkxhNVl3QXNBcTg1VHJRPT0KPTZQVGEKL
 S0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZDytb3g9wz9sm9

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


