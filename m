Return-Path: <linux-fsdevel+bounces-15898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225A8958CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 17:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B09E28D0FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0306713958E;
	Tue,  2 Apr 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DOrp/SL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E12136675;
	Tue,  2 Apr 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072940; cv=none; b=H+s/9lvsubO19p1lstBOEasFw6o6vdw3EKLzEU290C+VxkyhOIuFCz1fXXsoIaCQVgCDES8nRLpl0ZtGDnY+yBNLsJWOrWpG+hkEqs5czxGQ94KLIeAcMz9yKGu6/mjs6OsfPNcmCUz9Vh2kXZrK2FL98jXfbuoU0XXRoeUJZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072940; c=relaxed/simple;
	bh=IfRmBs/VQkfKjJFkvo6pie00L4VVXFYihT/akWQE4ic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jZQ1jApTcetv2IBGHdDs2LwIuB2SgWw2JsbNz3br1D6Xu/68wiMI5nRzUmzNETx64Ws3y6VtBsPkb/iRmrFLIcEix3hD6JvlI+QkX7j9kmK7FfaTS+aJ0omK3vW9lpAe3+fTkg4PI+E5yf+UnGXGoeraTO2fIHF4a0NTh7zNODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DOrp/SL4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712072936;
	bh=IfRmBs/VQkfKjJFkvo6pie00L4VVXFYihT/akWQE4ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOrp/SL4kYewXK66WVjQc1/mDm1Tmp7wW7CniDjHoGxjckveBZJKXBF9PkUkRw0dt
	 /8Gg8nKilcx92NCErLQF4hTJ4XO+qzFjh8nAz4ZgNOJduwAlISMXqHwAsJp4yXesCR
	 F9RXo5Lhhj1Bn3DsE/ZELAptMvrhcYnSANtSj9Eq6rR51dUIBKiU7NZBHxQWdDgI2L
	 qlGy5py7/8LavzFbWm8PDVEhOzU8owFrpXtKV7dF3oAqWmx4d8Q8RiTeYdx7GK8pme
	 ulyb8ATrbw+S3jrqBCwTbcxMQN4OI+ybvlQ9vy5fDK4oZSfvPhVg3PHn5/MKM+EoX9
	 KXXd9Hw+88QtA==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E417337820F9;
	Tue,  2 Apr 2024 15:48:55 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	krisman@suse.de
Subject: [PATCH v15 7/9] f2fs: Log error when lookup of encoded dentry fails
Date: Tue,  2 Apr 2024 18:48:40 +0300
Message-Id: <20240402154842.508032-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402154842.508032-1-eugen.hristev@collabora.com>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the volume is in strict mode, generi c_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/f2fs/dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 88b0045d0c4f..64286d80dd30 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -192,11 +192,16 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name)
-		return generic_ci_match(dir, fname->usr_fname,
-					&fname->cf_name,
-					de_name, de_name_len);
-
+	if (fname->cf_name.name) {
+		int ret = generic_ci_match(dir, fname->usr_fname,
+					   &fname->cf_name,
+					   de_name, de_name_len);
+		if (ret == -EINVAL)
+			f2fs_warn(F2FS_SB(dir->i_sb),
+				"Directory contains filename that is invalid UTF-8");
+
+		return ret;
+	}
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1


