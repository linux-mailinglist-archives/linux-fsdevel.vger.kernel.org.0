Return-Path: <linux-fsdevel+bounces-6606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FB381A808
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E04C1F24013
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077E48CEB;
	Wed, 20 Dec 2023 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oj0k0QMO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FAC1EB5F;
	Wed, 20 Dec 2023 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703107415;
	bh=eGxGqbgZVGIrrxZL930kVfU1Amr5jFALwZNRXLWU63g=;
	h=From:Date:Subject:To:Cc:From;
	b=oj0k0QMOV9GFZVIpf9VqELx6KED+CigzpIisTwuzySWkPIU9qTkchVSWnMFy7xi6I
	 SRC6XScGpix2e7dK3K2ApuEJE5vwBduyQNL6mw7zp3QE4DMUwEFOjZzs/VnIXzW2RN
	 +RZIeNMOOB+MHOy3NfULEIs2FtxibfXNXh3gFhEc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 20 Dec 2023 22:23:35 +0100
Subject: [PATCH] sysctl: remove struct ctl_path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231220-sysctl-paths-v1-1-e123e3e704db@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFZbg2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDIyMD3eLK4uSSHN2CxJKMYl0TcxMzS3MLU7NE4zQloJaCotS0zAqwcdG
 xtbUAw0yA014AAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Iurii Zaikin <yzaikin@google.com>, Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703107414; l=1160;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eGxGqbgZVGIrrxZL930kVfU1Amr5jFALwZNRXLWU63g=;
 b=hydLABjfaS/oS5Pmgp2zJLXbW3W8u1NPMgqS/2oT15ZCRbIv8QPw+Crgq6dn+CB/TeylU7GvM
 ABjLgtGys6QDSrYuNRnQKkWGOWGNduUVpTbm+4MxLfiqXDNxk5JZ16E
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All usages of this struct have been removed from the kernel tree.

The struct is still referenced by scripts/check-sysctl-docs but that
script is broken anyways as it only supports the register_sysctl_paths()
API and not the currently used register_sysctl() one.

Fixes: 0199849acd07 ("sysctl: remove register_sysctl_paths()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/sysctl.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 61b40ea81f4d..8084e9132833 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -210,11 +210,6 @@ struct ctl_table_root {
 	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
 };
 
-/* struct ctl_path describes where in the hierarchy a table is added */
-struct ctl_path {
-	const char *procname;
-};
-
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 

---
base-commit: 1a44b0073b9235521280e19d963b6dfef7888f18
change-id: 20231220-sysctl-paths-474697856a3f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


