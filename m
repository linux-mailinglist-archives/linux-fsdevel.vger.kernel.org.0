Return-Path: <linux-fsdevel+bounces-74148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3523ED32FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CED9230D7E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F743A1E6D;
	Fri, 16 Jan 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtsgnLat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999A1E0E08;
	Fri, 16 Jan 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574819; cv=none; b=Z7l6i29zmo3Docmgz9Hjh/z2E42cmDhx/6UuRK0AVCAtb0FdGeO3SwPaokiXqR8yc1p4+5WcYidJdp2pdET3v/RIMpz3fzT8BkIDG2WutUAgh7w8OESNgh9dhv7ueMVeS5imwFMjgh2jW60gu9HHy1hSKZEUYqJ+j+UjDAtCT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574819; c=relaxed/simple;
	bh=WULodj3ndaifHU9DlNb0w1E7YxSNfz8+hYky6+hNjMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1UCS622EFisPU7p3JLYz/WeVjmqLlZB+U+o13Vanc3FQdZhoQ2cul23kzyky0+gEoxVeoE1YTDG765mhAW3JWOJlqCL3eOyxtx5xl+8wRJnxyG5eJfgHwQkAsQFZUFc3DloRaqnkVk3wrrQB+4514aVtV0IB+gx+N46Q5yWQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtsgnLat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEBC16AAE;
	Fri, 16 Jan 2026 14:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574819;
	bh=WULodj3ndaifHU9DlNb0w1E7YxSNfz8+hYky6+hNjMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtsgnLatpOhe9kqnWRHmZwh5A/3hgyDsPKkyHY1PRTvRlU0+eOT7hKDZl0wG7WStN
	 3m33Rr/NxbHIy9fFYQBIqBlW6GdFXOP7tkP+DzN6zMLC2ntO8zB0C6vCIKJMpdTq+e
	 VmkVEXX7M6qhXS7lcMKs+jvKtJQcqIkqpPfTOEZJhyrxximK0XcjOHxHcJGcOYtOTj
	 aUDhA4bvmAp+TA4pLoqSw1vheM1ZHepi29vIdezq8hIBnYs8eP6kE/GnP8hFVe87Z1
	 1vY/Xi/Yl0fWVfDxWZmdomVLtBfaV2nFDDR3ZT1niuIxMgBf0Ubjfs+t9Q6dBHqOwU
	 Ya4whlE0UUDDA==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 16/16] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
Date: Fri, 16 Jan 2026 09:46:15 -0500
Message-ID: <20260116144616.2098618-17-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

ksmbd hard-codes FILE_CASE_SENSITIVE_SEARCH and
FILE_CASE_PRESERVED_NAMES in FS_ATTRIBUTE_INFORMATION responses,
incorrectly indicating all exports are case-sensitive. This breaks
clients accessing case-insensitive filesystems like exFAT or
ext4/f2fs directories with casefold enabled.

Query actual case behavior via vfs_fileattr_get() and report accurate
attributes to SMB clients. Filesystems without ->fileattr_get continue
reporting default POSIX behavior (case-sensitive, case-preserving).

SMB's FS_ATTRIBUTE_INFORMATION reports per-share attributes from the
share root, not per-file. Shares mixing casefold and non-casefold
directories report the root directory's behavior.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2fcd0d4d1fb0..f579093bb418 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13,6 +13,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5486,16 +5487,28 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	case FS_ATTRIBUTE_INFORMATION:
 	{
 		FILE_SYSTEM_ATTRIBUTE_INFO *info;
+		struct file_kattr fa = {};
 		size_t sz;
+		u32 attrs;
+		int err;
 
 		info = (FILE_SYSTEM_ATTRIBUTE_INFO *)rsp->Buffer;
-		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
-					       FILE_PERSISTENT_ACLS |
-					       FILE_UNICODE_ON_DISK |
-					       FILE_CASE_PRESERVED_NAMES |
-					       FILE_CASE_SENSITIVE_SEARCH |
-					       FILE_SUPPORTS_BLOCK_REFCOUNTING);
+		attrs = FILE_SUPPORTS_OBJECT_IDS |
+			FILE_PERSISTENT_ACLS |
+			FILE_UNICODE_ON_DISK |
+			FILE_SUPPORTS_BLOCK_REFCOUNTING;
 
+		err = vfs_fileattr_get(path.dentry, &fa);
+		if (err && err != -ENOIOCTLCMD) {
+			path_put(&path);
+			return err;
+		}
+		if (!fa.case_insensitive)
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (!fa.case_nonpreserving)
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,
-- 
2.52.0


