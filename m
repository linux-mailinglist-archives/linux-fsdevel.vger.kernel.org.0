Return-Path: <linux-fsdevel+bounces-61283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1DB570E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 09:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF07A6E34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36012D2494;
	Mon, 15 Sep 2025 07:11:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087228E5F3;
	Mon, 15 Sep 2025 07:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920274; cv=none; b=n7+hM4hq71YvnGB87IX86+FPf5Ego1GXZdlYZkizjVdT0Cs3yhGzfdWHL//g+Z6FWEkisdxcgib0d1Q0xQOuH424MqxncK9g3mHV2YnlWo5buDYXuBqZYEc2Fr2NqXAINgeGVcBu9ZA4ujicgi6TxiVsFqa3YpiCL6FAviCQp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920274; c=relaxed/simple;
	bh=eUZ+DsYmHslxxmaL0GyfJwm4AQ5QdzZojAnv5hPdEDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDexcFXbwZ1H5V+iyLEzWx4k9+xtLBQPX9kdHi2RjV+N91430unNLlJoigz21TqFYCqexOMGRH8sKPW+iEWXllb8c35j0xKWcTG4six+LVPV10h83W4SZT3BwSn6BMrcgvcVPF9tZM8mpH4vqG18CrL4Gdq6qeSVxJlmD9oJsjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B9C4CEF1;
	Mon, 15 Sep 2025 07:11:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Disseldorp <ddiss@suse.de>,
	Martin Wilck <mwilck@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Askar Safin <safinaskar@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] init: INITRAMFS_PRESERVE_MTIME should depend on BLK_DEV_INITRD
Date: Mon, 15 Sep 2025 09:11:05 +0200
Message-ID: <9a65128514408dc7de64cf4fea75c1a8342263ea.1757920006.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INITRAMFS_PRESERVE_MTIME is only used in init/initramfs.c and
init/initramfs_test.c.  Hence add a dependency on BLK_DEV_INITRD, to
prevent asking the user about this feature when configuring a kernel
without initramfs support.

Fixes: 1274aea127b2e8c9 ("initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 init/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index e3eb63eadc8757a1..c0c61206499e6bd5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1501,6 +1501,7 @@ config BOOT_CONFIG_EMBED_FILE
 
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
+	depends on BLK_DEV_INITRD
 	default y
 	help
 	  Each entry in an initramfs cpio archive carries an mtime value. When
-- 
2.43.0


