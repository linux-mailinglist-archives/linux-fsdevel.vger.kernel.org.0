Return-Path: <linux-fsdevel+bounces-13601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B1871B3B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11F4B22E21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F46F532;
	Tue,  5 Mar 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oxGh57L9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33C6EB4B;
	Tue,  5 Mar 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633812; cv=none; b=W2mYhd3ETSyoYXzWbJQKUG6f+5cUhUXOGHirEKm8r2DRK++5OH0D6un/jjpX0yDCYiSqewqUDJzy1AmYuI8TaX1YHEpUiLIeQ0wIf1W9o+bcouggslGXgKSOzg8tAKI4C3ruhlksTOKNMTZFm42AhLrEX4DJRJsX1fBYVi5ERYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633812; c=relaxed/simple;
	bh=VysEZ2lHFHLjYXsEGtqT3tM7vTbrrtv13nJeePZzgiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQQESho7y2ZqG4B6rRAcT9uuYjeozCaGEYqHqXN/zt8K9QuodeVdnAc+e6YHtx/1+5AIoo9+8Q2fDiDm/zuGQkig6lJOtZx6QypczogehwtFHlHPxP2G5qvjeLeZdKakTqf++tKDOsVJWGeQebLPlQEB3W89PkWpJ/93KOWtucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oxGh57L9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709633809;
	bh=VysEZ2lHFHLjYXsEGtqT3tM7vTbrrtv13nJeePZzgiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxGh57L9DzbFshNO4gMAW7zI1Vej6TDs0+KddLIM+OhA+vhy2JSRQ+hCNG7c1jpFI
	 QM/SXJTw3Jmf4MSOiGsaBL9niHnZN6xN02d3wutMuNbeMqrapllSM8BjLIqf8/BQC0
	 It1qJwLq/SbsZSzKpcFDdEvRvjcnXGjDTIVHw2Us9YWoyW/zo1MTsOUd8GgPMGbQXd
	 q66bbmeX+b81CCewGEtRHgJnOA3qY1uZIje/g4VUAqo2XR+1/n0QegedcGNl6DPutL
	 WCrAsqTDaHannc+ADmvLdeX9tsa6RE+ObjNwrFjlFx+lzKncZJ8Qyj/AnIRj5LelUR
	 MaK4y8S+SGx8w==
Received: from eugen-station.domain.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C24C37820E8;
	Tue,  5 Mar 2024 10:16:46 +0000 (UTC)
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
Subject: [PATCH v13 7/9] f2fs: Log error when lookup of encoded dentry fails
Date: Tue,  5 Mar 2024 12:16:06 +0200
Message-Id: <20240305101608.67943-8-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305101608.67943-1-eugen.hristev@collabora.com>
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
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
index 0601b4c8bacc..1bb98970a56a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -190,11 +190,22 @@ static inline int f2fs_match_name(const struct inode *dir,
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


