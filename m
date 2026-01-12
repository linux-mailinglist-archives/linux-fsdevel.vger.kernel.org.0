Return-Path: <linux-fsdevel+bounces-73299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E6D14A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93F6A307C9DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC0437F8BB;
	Mon, 12 Jan 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTgRgnsL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00437F8A5;
	Mon, 12 Jan 2026 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240037; cv=none; b=PuPKvl/w0ZjN4O9gxx704zaRpmEvHOUwAoLOQvyMuFjVTL5mBRL36fUgigObpohMY3xSfRxn3iaDosDVF4ivvrZcajft4lW8KT0unBqjXUz6KPTq5RVrSptVtH9aEVvWbVbeoSjElgoAVjjkGXi5Zv36FQhZyNewXVijuzWUhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240037; c=relaxed/simple;
	bh=7CV8d5ZLjZnsixivTyttzKYK+F3Fykxp76GMWvkN/D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9ULnNTYTa/kuRpOjQFVcqjPPQwTrgLmzVO81S4i9DfjriYhXSf1dt3bcL6Flu5p0Pcrdy6EuLs2PTscebntKyZuHqTT1u7D7a2Zd4dCy9TGpxtV0efv5qaIWCnq0yLNVJ8L3RJPGVqavIvVoIxvwzq3tf3BwM/tPle7InY550M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTgRgnsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6FAC19425;
	Mon, 12 Jan 2026 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240037;
	bh=7CV8d5ZLjZnsixivTyttzKYK+F3Fykxp76GMWvkN/D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTgRgnsLIoHdfPZ7yUZk1X/iiP+32IhZKLwoqdUUFGafNUBLN24n7VykD2UAKgLzh
	 g3/B9h94Nlm3hReKMPuS5PD7kZDuX+DkPJmVzmE+MQKg7jUelRju6q9Gu42VJ/8VOL
	 FvFsTK5nM3QnM/vQjaPk4ASdRJ/7OiFgvhmDZpFJr5byy1sHFJvZ/pZx0ygv9qlc/9
	 G4hld9ftSDKcjfhAHEI3soKcPqgCuXJRFNYIaLfQqsF3/POXznYw7tmuxgvOpWcota
	 znYTlLgv/VmymYtK3G55pJO88ys77Fs+imwAg7lmSsVTpyRaP/zW60ZNipesBXBP1y
	 RcDXNiV38SE3A==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v3 16/16] ksmbd: Report filesystem case sensitivity via FS_ATTRIBUTE_INFORMATION
Date: Mon, 12 Jan 2026 12:46:29 -0500
Message-ID: <20260112174629.3729358-17-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/server/smb2pdu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2fcd0d4d1fb0..2db189fef4da 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13,6 +13,7 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/filelock.h>
+#include <linux/fileattr.h>
 
 #include "glob.h"
 #include "smbfsctl.h"
@@ -5486,16 +5487,33 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
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
+		if (err == -ENOIOCTLCMD) {
+			/* Default POSIX: case-sensitive and case-preserving */
+			fa.case_insensitive = false;
+			fa.case_preserving = true;
+		}
+		if (!fa.case_insensitive)
+			attrs |= FILE_CASE_SENSITIVE_SEARCH;
+		if (fa.case_preserving)
+			attrs |= FILE_CASE_PRESERVED_NAMES;
+
+		info->Attributes = cpu_to_le32(attrs);
 		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
 
 		if (test_share_config_flag(work->tcon->share_conf,
-- 
2.52.0


