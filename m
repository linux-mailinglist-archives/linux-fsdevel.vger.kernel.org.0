Return-Path: <linux-fsdevel+bounces-38878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B74A095FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE54188DCA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A6211A2E;
	Fri, 10 Jan 2025 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BeVDgVwJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B3211701
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523574; cv=none; b=F6l664PIRrdFoAg6OU+CfW9R/1dHl4BsKd0OK0DuA4fCIp7JHi1tsZR/tFMt6JWTZrp5yyp/hXyHhOtyWYMEgpTBwgzFkI9/yy8P/59E/+XczmA3LnXIkvl7FOmWjUz7Tp2cLyQxcEf6mP07Mp1R+H4rvq9AdHvA0dLoY+HACSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523574; c=relaxed/simple;
	bh=V1yAhAaw7cF8jS7hyOsRxEsq7v6QEh7ic+3H0uTdT3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p5R5PslcX4EIZcCWTIFlxgQuQZIBkVVxzLv0lQYTU2CsWgbLUf46Ajoz2JdVgusc1DlX6djgnHgoJznMRHuQvrcl1CqKVDI0nsMcSjbfmJpgQZsm4okYx6qyWW5shEV4PHLlw61xYxhaWSmkZU/Ewry4//AN2ytvSfz89cKpIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BeVDgVwJ; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YV5Ry5z60zLQg;
	Fri, 10 Jan 2025 16:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736523566;
	bh=JwMC7dDoGc9u/Z/aQtgLAFpqqY+jSE/ZJsPCOI3W4G8=;
	h=From:To:Cc:Subject:Date:From;
	b=BeVDgVwJKKzuQT5k2gA5zpnese2Vq1YA5NAjLifF4F0qXv4gOhvbYerZAmi1qzIad
	 J7Xv6iVsld5ZAocmbhT9dN5KwFFRBHBtm1uWO0mHpALZElesk+wmLZSCN9Mn/82SC4
	 Bwa2lWIPLibEP3inyoHAnFLlmOIWYGFe0H3gsVwE=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YV5Rx6CZHz6L2;
	Fri, 10 Jan 2025 16:39:25 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com,
	syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com,
	Ubisectech Sirius <bugreport@ubisectech.com>
Subject: [PATCH v1 1/2] landlock: Handle weird files
Date: Fri, 10 Jan 2025 16:39:13 +0100
Message-ID: <20250110153918.241810-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

A corrupted filesystem (e.g. bcachefs) might return weird files.
Instead of throwing a warning and allowing access to such file, treat
them as regular files.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Paul Moore <paul@paul-moore.com>
Reported-by: syzbot+34b68f850391452207df@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000a65b35061cffca61@google.com
Reported-by: syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/67379b3f.050a0220.85a0.0001.GAE@google.com
Reported-by: Ubisectech Sirius <bugreport@ubisectech.com>
Closes: https://lore.kernel.org/r/c426821d-8380-46c4-a494-7008bbd7dd13.bugreport@ubisectech.com
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175..7adb25150488 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -937,10 +937,6 @@ static access_mask_t get_mode_access(const umode_t mode)
 	switch (mode & S_IFMT) {
 	case S_IFLNK:
 		return LANDLOCK_ACCESS_FS_MAKE_SYM;
-	case 0:
-		/* A zero mode translates to S_IFREG. */
-	case S_IFREG:
-		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	case S_IFDIR:
 		return LANDLOCK_ACCESS_FS_MAKE_DIR;
 	case S_IFCHR:
@@ -951,9 +947,12 @@ static access_mask_t get_mode_access(const umode_t mode)
 		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
 	case S_IFSOCK:
 		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
+	case S_IFREG:
+	case 0:
+		/* A zero mode translates to S_IFREG. */
 	default:
-		WARN_ON_ONCE(1);
-		return 0;
+		/* Treats weird files as regular files. */
+		return LANDLOCK_ACCESS_FS_MAKE_REG;
 	}
 }
 
-- 
2.47.1


