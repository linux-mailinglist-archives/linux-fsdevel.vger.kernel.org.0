Return-Path: <linux-fsdevel+bounces-44803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A84A6CC57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DF7ACD1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EC6236A88;
	Sat, 22 Mar 2025 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJJeHfYl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FD23535E;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675715; cv=none; b=BCNSieuudBGqKiPkjhR8QVK5aCYdXlDNAcjOSne7eRxTY1Of/fdyCN4yGDZXOfdoS2ziO3VsPH/P5Q5qsls+nGk8OOqbsw4XkK9kfSQ9H1YXooSfVABFRBJxnX7FeZf4ZDNOLx/MFpRO++Ege7AGuCGdrfMIz1zNBrAy1AUKXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675715; c=relaxed/simple;
	bh=p8v3JQ4emsUMjjvSBjOOzwZTgB1SvlkW9F+SuuyZM1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pvAHUSUcJTNGaYAwvqelvHUg2f8WvWhO8FjJ4xT4RT5zsar8qRjEilSZ/eAgvTAu+5QF7WDli3pqBdWm9J9emhBpKaZ+WRRnjIDq8KThg5HXd/NADUvFd0DHO47K/edtQwttQ0gL840BlfTsvplwdg07YAu4j8De6JcDuRkz/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJJeHfYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1643C116C6;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742675715;
	bh=p8v3JQ4emsUMjjvSBjOOzwZTgB1SvlkW9F+SuuyZM1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KJJeHfYl3yzGUIwImmqR8xWDh/xoz41CsGa2N3ZvJ2+Uzr9yIFnrtV8JlkuUcu0YQ
	 Ouy2RN/TdTY0RARXo6QMN15NBmtZcraSr7+++reLI0GQatQ2TyP+c5ShKH7ZlhQLYQ
	 FGjHO4/bBEz4+ZPz1PClqYTh1gnR0t3CyDrJJF6o76jHw8qDRlrbPotMmzleV6W7po
	 rFBm5TmGLxlp3tpY6CgnOUWJAl84hVyGVBOhpURoeF55YpqwGaazTzEakbPTaho18u
	 OPt6mO/stFa+IIWM2wA+mfY/PmSmHIzKhBoWIWvx/pJfMWrCr7lz4PASfk8GEBS5bm
	 gddTVp2bOti0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E4C36008;
	Sat, 22 Mar 2025 20:35:15 +0000 (UTC)
From: Julian Stecklina via B4 Relay <devnull+julian.stecklina.cyberus-technology.de@kernel.org>
Date: Sat, 22 Mar 2025 21:34:21 +0100
Subject: [PATCH v2 9/9] fs: erofs: register an initrd fs detector
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-initrd-erofs-v2-9-d66ee4a2c756@cyberus-technology.de>
References: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
In-Reply-To: <20250322-initrd-erofs-v2-0-d66ee4a2c756@cyberus-technology.de>
To: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Gao Xiang <xiang@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, 
 Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
 Niklas Sturm <niklas.sturm@secunet.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742675713; l=1748;
 i=julian.stecklina@cyberus-technology.de; s=20250320;
 h=from:subject:message-id;
 bh=3yTdTgTHrBXPDCzHQY85SoPI2ekHfJ9SwSVLMJjjpHc=;
 b=gbKgVEbkExOOnYyBMICxer+0rrpqPN7L6a11TGtSHg9nUJDPcH1Az1Dcltfti9MOJD2CWO7NM
 iXnPdA1cJA4Ct+v+ehZ5rvSbO6BmO84OPaQLlG31oC9XmPYYKZEvguk
X-Developer-Key: i=julian.stecklina@cyberus-technology.de; a=ed25519;
 pk=m051/8gQfs5AmkACfykwRcD6CUr2T7DQ9OA5eBgyy7c=
X-Endpoint-Received: by B4 Relay for
 julian.stecklina@cyberus-technology.de/20250320 with auth_id=363
X-Original-From: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Reply-To: julian.stecklina@cyberus-technology.de

From: Julian Stecklina <julian.stecklina@cyberus-technology.de>

Allow erofs to be used as a filesystem for initrds. It offers similar
advantages as squashfs, but with higher performance and arguably nicer
tooling. If we support squashfs, there is no reason not to support
erofs as well.

Suggested-by: Niklas Sturm <niklas.sturm@secunet.com>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 fs/erofs/Makefile |  5 +++++
 fs/erofs/initrd.c | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109550a0518f2ed8df456deecdd2f8c..cea46a51dea2b9e22e4ba1478dd30de3262fe6cb 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,3 +9,8 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+
+# If we are built-in, we provide support for erofs on initrds.
+ifeq ($(CONFIG_EROFS_FS),y)
+erofs-objs += initrd.o
+endif
diff --git a/fs/erofs/initrd.c b/fs/erofs/initrd.c
new file mode 100644
index 0000000000000000000000000000000000000000..e2bb313f55211a305e201f529d7da810898252ac
--- /dev/null
+++ b/fs/erofs/initrd.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/initrd.h>
+
+#include "internal.h"
+
+static size_t __init detect_erofs(void *block_data)
+{
+	struct erofs_super_block *erofsb = block_data;
+
+	BUILD_BUG_ON(sizeof(*erofsb) > BLOCK_SIZE);
+
+	if (le32_to_cpu(erofsb->magic) != EROFS_SUPER_MAGIC_V1)
+		return 0;
+
+	return le32_to_cpu(erofsb->blocks) << erofsb->blkszbits;
+}
+
+initrd_fs_detect(detect_erofs, EROFS_SUPER_OFFSET);

-- 
2.47.0



