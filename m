Return-Path: <linux-fsdevel+bounces-14872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E338D880D9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 09:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB91C20CA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8D41211;
	Wed, 20 Mar 2024 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Kh/iR63U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A54086C;
	Wed, 20 Mar 2024 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924413; cv=none; b=lTBI6J7qss1FrxvM/wgjwbXFkg53yrNmpLDN4QvdqWxxpSK8Vu4PF7MDp6q6AFNwq6apit2NzpROTQYHo7pH15Hd/GlzZ39kZUAf926BydyglhH5nQqfNXBjSG77Zx2pmIRbIfzM721EYPiN7KwmA4imIoxQriCfSR3aQQn6lBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924413; c=relaxed/simple;
	bh=2Udo3G7fQC2cxqRuvgN0N9z0lkRknXjSVOSfuivtoKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G62BrxNxsTVs2jdc3bU/3xZxvbW/DTThecN97CDtfdFqrtdXONacNB4O9Sw+xtkTsbJXZwRJRsVkDDBAgk1Qw6zHCVMz/2W5j37ejn0BUZV9+HoV4PS9A25e32rRH6sQ1JtVJZp1++tAdxLk1yC3/C4sDrK/8fZtOlIHvzjwNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Kh/iR63U; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710924410;
	bh=2Udo3G7fQC2cxqRuvgN0N9z0lkRknXjSVOSfuivtoKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kh/iR63UC8ZHS0o2V423ngKRDPAMlLMkAT8Paiad4gxqnzpqRU4zW5zSa/jecd1FU
	 SYFFgw01m/Z2sR4ppPva+YH4+dVtXfnb+/Oo0aMh557KlmDlyZUcDozc1LH/OOid1E
	 lUv+1cg4wvdGjIoVSmuWxPJxFsQuVC7OiRyTNe1tzg5ypCMwz7UTSXhEJjgbEJu/2g
	 iIfjW6cF8GLQnU5gdPa3B9mUCnMOjZXvT3VhLHLS+YEwl2p8cYRcp3bimhJpSFeHbI
	 plLtUvP+khbz6zrhCYMMqIig/MX8JRsDQu2qaH9xZzjwzbIYSUuDbPloV9SLHxI0iL
	 J0kkvsXCv+AKg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82D4137820FC;
	Wed, 20 Mar 2024 08:46:48 +0000 (UTC)
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
Subject: [PATCH v14 7/9] f2fs: Log error when lookup of encoded dentry fails
Date: Wed, 20 Mar 2024 10:46:20 +0200
Message-Id: <20240320084622.46643-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320084622.46643-1-eugen.hristev@collabora.com>
References: <20240320084622.46643-1-eugen.hristev@collabora.com>
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
 fs/f2fs/dir.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 88b0045d0c4f..3b0003e8767a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -192,11 +192,22 @@ static inline int f2fs_match_name(const struct inode *dir,
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
+		if (ret < 0) {
+			/*
+			 * Treat comparison errors as not a match.  The
+			 * only case where it happens is on a disk
+			 * corruption or ENOMEM.
+			 */
+			if (ret == -EINVAL)
+				f2fs_warn(F2FS_SB(dir->i_sb),
+					"Directory contains filename that is invalid UTF-8");
+		}
+		return ret;
+	}
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.34.1


