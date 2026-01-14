Return-Path: <linux-fsdevel+bounces-73742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94AD1F7CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA24C30835E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293637F8A9;
	Wed, 14 Jan 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJzzHfdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12C2280331;
	Wed, 14 Jan 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400972; cv=none; b=N9DWMKvMmzBfyTX8mimQsB9fz/I/DIunHlF6miXIEUGuOvmuC+VrH3JR3S/pugP2lXmn4ffAPMYY3yZx7eELEftYzymuU3eipBUX4xt5SVtY+ftqk3VxHNQxdL2+Sj96MAiBCBXPuWKTBy/4c9+StN+9VCmidxovrZ65m+Gi3A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400972; c=relaxed/simple;
	bh=X2CfF5Mn9CRS+EjjMIOtUmXyiac4dDTyVUDa2EW06DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1NmsNgKV4mKyhiVRBKn6CUUXMKuWJmhsmUx0RTEOzylZimGk6Wy6N3hIZJ4JmIUHT0Dc8z3D10h7/aUs8Tz3Vddo12sAs8NaOq5zNSNnQidi4RJoCyV4/Mtgs0aL80mOXVC69O9TAtFl8p6yW4OZWbIuYKcTVgUVhqPc/W52XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJzzHfdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619ABC19423;
	Wed, 14 Jan 2026 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400971;
	bh=X2CfF5Mn9CRS+EjjMIOtUmXyiac4dDTyVUDa2EW06DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJzzHfdw/hacdM48fidfnrJv0YzvbGhUvIBJr5cAF/xwLQtQpE5DauIigCx6L7s0M
	 +HVTvSL3ynafViB+RyvF1tfbtr4Wp9OuQWgp670uHq7AFoHzy5RCSB035MCLmyarco
	 Cw0QT1R0h7GnheHPu9OcgyKOX57UQ8q3WOi2+qPsoj51FYk5WYKo5YfAGA/mJUX51n
	 HxMBw3YmfijgFpGwkr/7CNls9TCDCDoygN3fYfMlh0GbLBcD/+zvjAMp5Pzxh61J3N
	 6B96VvJSeSQ5GuV1EDp3UTL04MgvVVCAkOBgDvZ+oIv7Ti19kP7+B6GxK3rknlnnxD
	 MTQb2nWrt+WKA==
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
Subject: [PATCH v4 11/16] f2fs: Add case sensitivity reporting to fileattr_get
Date: Wed, 14 Jan 2026 09:28:54 -0500
Message-ID: <20260114142900.3945054-12-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFS and other remote filesystem protocols need to determine
whether a local filesystem performs case-insensitive lookups
so they can provide correct semantics to clients. Without
this information, f2fs exports cannot properly advertise
their filename case behavior.

Report f2fs case sensitivity behavior via the file_kattr
boolean fields. Like ext4, f2fs supports per-directory case
folding via the casefold flag (IS_CASEFOLDED). Files are
always case-preserving.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7047ca6b98d..5d4c129c9802 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3439,6 +3439,12 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
+	/*
+	 * f2fs preserves case (the default). If this inode is a
+	 * casefolded directory, report case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
 	return 0;
 }
 
-- 
2.52.0


