Return-Path: <linux-fsdevel+bounces-27340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99261960650
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C3D281A0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1419D892;
	Tue, 27 Aug 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lYJCSq4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A5C82D91;
	Tue, 27 Aug 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752498; cv=none; b=IneYrDEfKhwH2Kdf1pPAr2DSC5WidfmAe7pD403DszKZMIq+5xJabDgUHCobQW5OOR/sWTgOp+sNsZNmLYaZHx+mgJo9fP+G3rW7z88NTkT9DJfoLwmMKiq1th5yXHw1xyq54yWzePM8nmp3YGBKCaW0cNt66Dh6PbQ0nS2E2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752498; c=relaxed/simple;
	bh=FI10dEkXRoEqfg6u3Q2Dk6B7FUz2tABo2Vlbk9C316k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F248bkgsBXd82ykfggDMSXriU9ffNQH8wQByn5um6MogsiLn4Hx6YhCQXMCARRo9+TVZrq94J4GcWzwl4fCWW6y1ObrAfL+qg7sUw/Uoo4WbOZEao6KFEvKq8ZpDIEDOWGEx92WyXxYe++Olf1SJpoDfggSlfewZWD5iMht4xWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lYJCSq4x; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724752485;
	bh=FI10dEkXRoEqfg6u3Q2Dk6B7FUz2tABo2Vlbk9C316k=;
	h=From:Date:Subject:To:Cc:From;
	b=lYJCSq4xVpHE+cQK3ydTfc7R+h08/E3nryaC3+wegsJUN62L0jB2LSgT0Vumi3Ti7
	 mKZ1Tcw3FG3qMy7Z3aw3DRVTImtVXNGXo99HKGJExWe9Gc0LtnhHtsmSA5OSBLgsey
	 Tw4RRdtrMgIEr091KB0I0ygsmDvAp/6mZOQWKHvo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 11:54:43 +0200
Subject: [PATCH] sysctl: avoid spurious permanent empty tables
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-sysctl-const-shared-identity-v1-1-2714a798c4ff@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGKizWYC/x3MSwqAMAwA0atI1ga0+L+KuKhtqgGp0hRRxLtbX
 D4Y5gGhwCQwZA8EOll49wllnoFZtV8I2SaDKlRVdKpFucXEDc3uJaKsOpBNCfnI8cZez13ZUO2
 smyEtjkCOr38/Tu/7ATpks/FuAAAA
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 llvm@lists.linux.dev, kernel test robot <oliver.sang@intel.com>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724752485; l=2962;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FI10dEkXRoEqfg6u3Q2Dk6B7FUz2tABo2Vlbk9C316k=;
 b=P41gnbdv8wnYCR3Jy/tGAVFr6kZg1Y61NS35L88Tmn9hFgmek9RBBh+ZeYOgYD73HwW/DRQds
 LZWja3uU0A4BTl4eJU7IQIqwWV15p75mh1h1wz/XdwM9FV8jNo8NIe8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The test if a table is a permanently empty one, inspects the address of
the registered ctl_table argument.
However as sysctl_mount_point is an empty array and does not occupy and
space it can end up sharing an address with another object in memory.
If that other object itself is a "struct ctl_table" then registering
that table will fail as it's incorrectly recognized as permanently empty.

Avoid this issue by adding a dummy element to the array so that the
array is not empty anymore and the potential address sharing is avoided.
Explicitly register the table with zero elements as otherwise the dummy
element would be recognized as a sentinel element which would lead to a
runtime warning from the sysctl core.

While the issue seems unlikely to be encountered at this time, this
seems mostly be due to luck.
Also a future change, constifying sysctl_mount_point and root_table, can
reliably trigger this issue on clang 18.

Given that empty arrays are non-standard in the first place,
avoid them if possible.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202408051453.f638857e-lkp@intel.com
Fixes: 4a7b29f65094 ("sysctl: move sysctl type to ctl_table_header")
Fixes: a35dd3a786f5 ("sysctl: drop now unnecessary out-of-bounds check")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This was originally part of a feature series [0], but is resubmitted on
its own to make it into v6.11To.

[0] https://lore.kernel.org/lkml/20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net/
---
 fs/proc/proc_sysctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9553e77c9d31..d11ebc055ce0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -29,8 +29,13 @@ static const struct inode_operations proc_sys_inode_operations;
 static const struct file_operations proc_sys_dir_file_operations;
 static const struct inode_operations proc_sys_dir_operations;
 
-/* Support for permanently empty directories */
-static struct ctl_table sysctl_mount_point[] = { };
+/*
+ * Support for permanently empty directories.
+ * Must be non-empty to avoid sharing an address with other tables.
+ */
+static struct ctl_table sysctl_mount_point[] = {
+	{ }
+};
 
 /**
  * register_sysctl_mount_point() - registers a sysctl mount point
@@ -42,7 +47,7 @@ static struct ctl_table sysctl_mount_point[] = { };
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl_sz(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 

---
base-commit: 3e9bff3bbe1355805de919f688bef4baefbfd436
change-id: 20240827-sysctl-const-shared-identity-9ab816e5fdfb

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


