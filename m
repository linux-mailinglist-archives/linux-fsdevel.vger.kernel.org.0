Return-Path: <linux-fsdevel+bounces-58921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD8B3357A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4731B2212D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C3281368;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ld3dT/fP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839B272E56
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=BgWg5Jcefw5BjqyMO3GH9ps/8LeU/BzRyaty4voOY0zHBcyXNJ0Jas86XKAnW9MC1DAggfhX7m72pZcDJr7KvcR0ftg3Pced1ZVZW4n8ExiuXRP9LlQfJYOehfbMgzbI9n0swupJFXdDcnJLLjvvS13RVIhr00Fu5fNV53Qh42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=piNXxRocZU/QUdHQDAk/Bk55Igk0PXQJ54drQiYx4Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVIZbZ79xo5HXR9nAgmJBOZN8SxL1AdmGoLgnHOBdYbNDQ6PPZ4M2pLFglkCnOfgoFQ9JJXWrfAR2wXg7nwk83q6XRwzJtfWQwzS1KJ3I5ViMqTUyOR2vs/6u4uMNcrWC7rBKtrj9fgC+i8Z+3OSGipZWxT9iDTNOWX8QXQrjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ld3dT/fP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9anucYdGEYQ4WMeY/26FMDYw92Gp5uanc4lYXPWhKO8=; b=ld3dT/fPTtoLcYUhXpYgPyQGRH
	HdEMA2L6joIEhZDWXrFFRWuXfwsd88YjCiGPJlIkmoVVQTBbRo0T1OLVrxIiEckIcRIUCUgDyvtIV
	lN4mab3cc1bQuwzJ+dKlE3R+MCi5VTpFegknQ3Dqw8Lej9RLrmxuq09u9bbLTDWjefVhcoaH2HAgb
	HGn2TNsCTXqjnp/2upbps1kkvBMoOHv2rd5RgI8NmV8zd0EkUenea9sSX+nq+ktUSbSE+BMpC6whb
	HXOon+4gONqqPWq5Pc+tOSAIE9+k0ry1vQncujq7z1YMyApgVmQT2jAaGv1ZduMi/FeWTmn16swJx
	H33xcE9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBq-2OXx;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 25/52] do_new_mount_rc(): use __free() to deal with dropping mnt on failure
Date: Mon, 25 Aug 2025 05:43:28 +0100
Message-ID: <20250825044355.1541941-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

do_add_mount() consumes vfsmount on success; just follow it with
conditional retain_and_null_ptr() on success and we can switch
to __free() for mnt and be done with that - unlock_mount() is
in the very end.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 99757040a39a..79c87937a7dd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3694,7 +3694,6 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
-	struct vfsmount *mnt;
 	struct pinned_mountpoint mp = {};
 	struct super_block *sb = fc->root->d_sb;
 	int error;
@@ -3710,7 +3709,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 
 	up_write(&sb->s_umount);
 
-	mnt = vfs_create_mount(fc);
+	struct vfsmount *mnt __free(mntput) = vfs_create_mount(fc);
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
@@ -3720,10 +3719,10 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	if (!error) {
 		error = do_add_mount(real_mount(mnt), mp.mp,
 				     mountpoint, mnt_flags);
+		if (!error)
+			retain_and_null_ptr(mnt); // consumed on success
 		unlock_mount(&mp);
 	}
-	if (error < 0)
-		mntput(mnt);
 	return error;
 }
 
-- 
2.47.2


