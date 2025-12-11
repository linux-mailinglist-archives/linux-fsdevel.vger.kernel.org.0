Return-Path: <linux-fsdevel+bounces-71130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AACB656A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB093074AAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B53043C4;
	Thu, 11 Dec 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8LCE3PD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806503128AC;
	Thu, 11 Dec 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466516; cv=none; b=Z+iAOpvHRGTcWIepEwn7CmeqvMhP6PRmGit4GM/vGwCi1skbdhD4OEsnPeZzXPIpzbik41s6J1qJ+YuJtgNGEFnB8sUBRWRe4vgtpaDhrg82RCfiMqfKZU4lXmseqV2Kh2HjQ9X74Lj7Ky2Tjsbq7jK/awZsxxnVQLNLpu9x3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466516; c=relaxed/simple;
	bh=xKTkBQxvzaKb2/BHpHJKS548Bqa8fPqHgj5k2JtaR0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKDi9aUJGG3Zb7KiylCO5Mfzdj85fmpbU4FXa6wa1mjwwNHPgkYrrIyim9ZA1I28xPlPf+tNPgq8GZ8DcxLR+hCg6pcFUpgveLFqiNyAdlkVbdjlUk0DY8ATAqtQ0MKOu00U9PK5dtIlO1xtEkFkvQE6Xuux/5YP3au9EJMUmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8LCE3PD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54913C113D0;
	Thu, 11 Dec 2025 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466516;
	bh=xKTkBQxvzaKb2/BHpHJKS548Bqa8fPqHgj5k2JtaR0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p8LCE3PDI0L8GG1v6klE0Os1Q/pTcVw8vhzm2WuwuRz7KklyWihdL3lF2ccmM4aih
	 oI2/yZm/5/L9LmKmGQ6clFIMMIJlVTR71EmL3la1UW8WpGbPWwbJ7R6mA7vPFozISM
	 XpO1XAYaZx7be3b4Aia4xTaZUWw4UqMq9LXIDjShOLPseWERIjyWMbIKZznIKxTaBQ
	 GQhm8OpXEDavN3/qSsie4LZFbu3PV0VIja6JP2Tm5oFRDpWtQDXV6xfk4gguT/RkgW
	 qmJ/uNUUpsE2qvtRkPWN/dfQQNL7e6eiNxMs4Sb9ZGm1APC/JSt3eIx/rnLibGP7XZ
	 eZctnHuouMmFw==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/6] ext4: Report case sensitivity in fileattr_get
Date: Thu, 11 Dec 2025 10:21:14 -0500
Message-ID: <20251211152116.480799-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Report ext4's case sensitivity behavior via file_kattr.case_info.
ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report Unicode case-insensitive
matching; otherwise report case-sensitive (standard POSIX behavior).

This enables file_getattr to report the case sensitivity behavior of
individual directories within an ext4 filesystem.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a93a7baae990..d760657bb9e2 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -996,6 +996,18 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * ext4 always preserves case. If this inode is a casefolded
+	 * directory, report Unicode case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
+	 */
+	if (IS_CASEFOLDED(inode))
+		fa->case_info = FILEATTR_CASEFOLD_UNICODE |
+				FILEATTR_CASE_PRESERVING;
+	else
+		fa->case_info = FILEATTR_CASEFOLD_NONE |
+				FILEATTR_CASE_PRESERVING;
+
 	return 0;
 }
 
-- 
2.52.0


