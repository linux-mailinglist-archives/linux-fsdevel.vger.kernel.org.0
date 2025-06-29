Return-Path: <linux-fsdevel+bounces-53226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336BAECAD8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 02:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3151780F6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E201A288;
	Sun, 29 Jun 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b="UnXSVCY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE010523A
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751157603; cv=none; b=iA5NEhKS0DJWLs2aW5CL3U0hHF4p3nHJwPIAiqjbRzrAHVNGsYcU8olVCZYyvQzCuvA7GLbIEk5v7E5ETaeUFWeq4lkYJXvMICCTD0zNJdNutaXHwemzxeNVv/SNtYKbYyYYPlTsMRi1nMfvFUypmEwzoP4oqfH/6JqX31dr1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751157603; c=relaxed/simple;
	bh=QnHTevfYAc1Ghk0Aknd/fmYNxq8NR8a6sznBdkS3OKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WO2nD96yt10QYHNXCluKiUUKBpw9LA8OtM2cOWXKqtpELW15GVKrtkS38UoXDLHep+ol4aP0kqUjjYeWCNYoRsgQMiQO7lUXHQBR0YEEe01e6RUGz76vaUZT1U9QEH9qACYb6vIP2O+xzlvaGOVt0vem03LKkBQyYt09GiriNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com; spf=pass smtp.mailfrom=yshyn.com; dkim=pass (2048-bit key) header.d=yshyn.com header.i=@yshyn.com header.b=UnXSVCY7; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yshyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yshyn.com
Received: from phoenix.uberspace.de (phoenix.uberspace.de [95.143.172.135])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id EE83860A05
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 02:39:53 +0200 (CEST)
Received: (qmail 20283 invoked by uid 988); 29 Jun 2025 00:39:53 -0000
Authentication-Results: phoenix.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by phoenix.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sun, 29 Jun 2025 02:39:53 +0200
From: Illia Ostapyshyn <illia@yshyn.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Illia Ostapyshyn <illia@yshyn.com>
Subject: [PATCH] scripts: gdb: vfs: Support external dentry names
Date: Sun, 29 Jun 2025 02:38:11 +0200
Message-ID: <20250629003811.2420418-1-illia@yshyn.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.99877) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.59877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=yshyn.com; s=uberspace;
	h=from:to:cc:subject:date;
	bh=QnHTevfYAc1Ghk0Aknd/fmYNxq8NR8a6sznBdkS3OKA=;
	b=UnXSVCY7X0Rj+ELxqWIr5yBTGR0L/kbqcFusrllVLknh2UcQlCvfyZTrMuQq26zYn1/PFLV+a4
	pjoUcTGSDmI43/MwR1fty5zBaU4nQnFzNV1XWFXlvD2KBU7DWPFDBioG7uo4cJmKOTJBKyLkW+x4
	XJjmfrDuevDsJBwYUI/9sxc8tfarJDkKTWH6wczeeooNy+OH0usFMVlL8EZ4NezqM2gCp5cyjagP
	qPfet5v9OZkJxTiSaa8YYjgSpHHZ9h9NDniXyqC3XQCz758abx8lE3V2+mbBWF/iCLBDw8VFVCPu
	4+MmV69A3a63Kf/Xcd/DZYFmfEvfoJy+Ugqe5Ksg==

d_shortname of struct dentry only reserves D_NAME_INLINE_LEN characters
and contains garbage for longer names.  Use d_name instead, which always
references the valid name.

Link: https://lore.kernel.org/all/20250525213709.878287-2-illia@yshyn.com/
Fixes: 79300ac805b672a84b64 ("scripts/gdb: fix dentry_name() lookup")
Signed-off-by: Illia Ostapyshyn <illia@yshyn.com>
---
 scripts/gdb/linux/vfs.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/vfs.py b/scripts/gdb/linux/vfs.py
index b5fbb18ccb77..9e921b645a68 100644
--- a/scripts/gdb/linux/vfs.py
+++ b/scripts/gdb/linux/vfs.py
@@ -22,7 +22,7 @@ def dentry_name(d):
     if parent == d or parent == 0:
         return ""
     p = dentry_name(d['d_parent']) + "/"
-    return p + d['d_shortname']['string'].string()
+    return p + d['d_name']['name'].string()
 
 class DentryName(gdb.Function):
     """Return string of the full path of a dentry.

base-commit: dfba48a70cb68888efb494c9642502efe73614ed
-- 
2.49.0


