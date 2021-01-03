Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B952E8E93
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 22:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbhACVon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 16:44:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbhACVom (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 16:44:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEC6A208BA;
        Sun,  3 Jan 2021 21:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609710242;
        bh=NUvOstWAZ2abHlSEN0ENegwqm1Zl/PfYh383yi9X/Ac=;
        h=From:To:Cc:Subject:Date:From;
        b=XYbJ6QMdOKMEVEVLwSZu+iTicaUyoczacElYeThoJdWw6td5isOyboGGmYrnaoBE5
         H6gdfJWFFvHtGjvFmyoU354BTHM49ojP5QCnAgoOU4ZviATxr7NJI1wvd/LOteK/Jy
         8mLmXoAw3HWoCIvDTTagFGYFNDGayJDwh4q/E9Ty6weWO23fTaMQ2XkypNhVhMZC3V
         9MICdwi3B19rhFs6FL0wEwGJkF+hkzEkWQcjiRB2JA8Ek3qM1wbTRl9olAUaiHf+7Q
         bNs1hEXOR41dMwxlabzq4fSQ+Qr+pR0Ft/xgov9OCfa0gwJ+u1Fe7BDxKTsoGysDsn
         izRgQstWP1USQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zonefs: select CONFIG_CRC32
Date:   Sun,  3 Jan 2021 22:43:52 +0100
Message-Id: <20210103214358.1997428-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CRC32 is disabled, zonefs cannot be linked:

ld: fs/zonefs/super.o: in function `zonefs_fill_super':

Add a Kconfig 'select' statement for it.

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/zonefs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig
index ef2697b78820..827278f937fe 100644
--- a/fs/zonefs/Kconfig
+++ b/fs/zonefs/Kconfig
@@ -3,6 +3,7 @@ config ZONEFS_FS
 	depends on BLOCK
 	depends on BLK_DEV_ZONED
 	select FS_IOMAP
+	select CRC32
 	help
 	  zonefs is a simple file system which exposes zones of a zoned block
 	  device (e.g. host-managed or host-aware SMR disk drives) as files.
-- 
2.29.2

