Return-Path: <linux-fsdevel+bounces-16344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1BB89B96C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 09:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E9C1F2179D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 07:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BA52F71;
	Mon,  8 Apr 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfb+39Xl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E93FBBE;
	Mon,  8 Apr 2024 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562660; cv=none; b=WSLkDiTkjuUuTQMwZc4L7RSjaIsE7bWkdrIHjW2yd4COA+Ia8Ya61lARs7TWEsSlpOMcMFW/mZBnaaXiWCmtWMBWYZIAyMfWQCcKaJ8zQZYQ6rzXkjZLTakOSJcN4uhBuj5WsoUsGifjd43ze8+8MvRD3Jw2zWkIB2PcHknd2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562660; c=relaxed/simple;
	bh=Sy3R8RuQUUkFGVRDCafN6jNVV9G0now3vVyvkr2ESKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAFb7qFKJ6rSxmBAYUAiEFOnfMhQaSEzbeAS51EAszLPESiEdt3kKzV1OkyP+45JYaLXpvcSOYSiKU8cmZ5qFuTSOJRooLBUx7Lsmjj4MlA2bXBjJHUIY7eqA+VdLjWQKil9N5tYAnlC5Miy9s5yhJziD8QxQwdcTdwf84u9fW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfb+39Xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D76C433F1;
	Mon,  8 Apr 2024 07:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712562660;
	bh=Sy3R8RuQUUkFGVRDCafN6jNVV9G0now3vVyvkr2ESKg=;
	h=From:To:Cc:Subject:Date:From;
	b=Gfb+39Xl9guNPyQXSF9BkLxBukNRtrVkNk9Hb7e1F7li8U4HL1qrC4OFQRyoR8Drn
	 Txmfw1efRHrZXEOqg6dQKBI8rKzyeABRCWD20gppG/dS/CUdsXsZg4v/QOGt/a+SMt
	 NBHMnvNAmkmNBFgcurJo5aO9AeFA7Prm89AOEpHzZpUGKRsc8uJQ9NggYCb/LywUsp
	 ESGMRwwl/50xtirsNJDV+kyXlriGIIkOQXXU+BZDeyhf5UzCBZHpz+eVQamaWzPzab
	 3MH6RTbuYNWDUhxNxdt/D0hmOAh3lMK5i9QK2Wn9oNfWjUsF8Q1X2qJGnmJdILDjp4
	 8O1D8N9VfrKQA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Martin Brandenburg <martin@omnibond.com>,
	devel@lists.orangefs.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
Date: Mon,  8 Apr 2024 09:50:43 +0200
Message-Id: <20240408075052.3304511-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

orangefs_statfs() copies two consecutive fields of the superblock into
the statfs structure, which triggers a warning from the string fortification
helpers:

In file included from fs/orangefs/super.c:8:
include/linux/fortify-string.h:592:4: error: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

Change the memcpy() to an individual assignment of the two fields, which helps
both the compiler and human readers understand better what it does.

Link: https://lore.kernel.org/all/20230622101701.3399585-1-arnd@kernel.org/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>
Cc: Martin Brandenburg <martin@omnibond.com>
Cc: devel@lists.orangefs.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Resending to VFS maintainers, I sent this a couple of times to the
orangefs maintainers but never got a reply
---
 fs/orangefs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index fb4d09c2f531..152478295766 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -201,7 +201,10 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		     (long)new_op->downcall.resp.statfs.files_avail);
 
 	buf->f_type = sb->s_magic;
-	memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
+	buf->f_fsid = (__kernel_fsid_t) {{
+		ORANGEFS_SB(sb)->fs_id,
+		ORANGEFS_SB(sb)->id,
+	}};
 	buf->f_bsize = new_op->downcall.resp.statfs.block_size;
 	buf->f_namelen = ORANGEFS_NAME_MAX;
 
-- 
2.39.2


