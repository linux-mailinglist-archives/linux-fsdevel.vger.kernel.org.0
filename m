Return-Path: <linux-fsdevel+bounces-73738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B2D1F799
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86576306DABF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B452E7186;
	Wed, 14 Jan 2026 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5o/KVYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2882E0914;
	Wed, 14 Jan 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400962; cv=none; b=kCLWjbHxDJCJr3Ll6kt6yLxzx41HkrWqyuB903IhkawalvcvJAI7nEhT52e9yb4hNVz5GXvf81YDcsth6WdIW+zCIMr8LdULfM6fQpiUAFX53oiMBi0E3KzXiodIV8f2P71CJdvKEC9KHZGq4kvBeArEPBoAsLQ0nZTyoyWL5Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400962; c=relaxed/simple;
	bh=tyhvqqIS+ku3U7Hk/wztpIFyA6yZTojJ9ILKjB/tyUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbV6w5X0OqxP5qKLHzPY8Lk0/0VaYcaxv3bg9dMPKBVjWa0WpfeIB81UBhYWAg0HLf+A0yqh89mM3hg/BytnfHwcKf5BzwWc7INOUSLj/50UfdDoIoXVTuEeH4+b8WbYZBfO5xuh+eDn1ecUu5r048Dn2StpJ/8JVQ+v6Wtisto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5o/KVYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FDDC4CEF7;
	Wed, 14 Jan 2026 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400961;
	bh=tyhvqqIS+ku3U7Hk/wztpIFyA6yZTojJ9ILKjB/tyUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5o/KVYR2qw51QFacfAcALWIWChjp/BgoANnkbmY9kg52Kze5zGJ/wsJJ85AQwirL
	 fd0uv3imNWaXdYgytnHWUNor9uwG9vKFN2KyETkKtYLEegNZMTKK+MnUEAXQhc/AXQ
	 2BMstvLzcAzyKtigpf/cNO9sAFDSe8WYsQwlaqWDHmOuCsWhuUWqyP8kheGLu3I727
	 jIYUYcW2W26pTuCcIxVcpMImGDTTfm6c/FE8SdAzB1IZ/e4QJaDtm+0G4TJ6AIBXum
	 Bz+0XFjRi1BpcazHUAq0E8ZuEKN2fKT3YMGmdsCYWSn2OCAS2rwXt7e4JNGMGLwJFb
	 ixLnCYf3ixjfA==
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
Subject: [PATCH v4 07/16] ext4: Report case sensitivity in fileattr_get
Date: Wed, 14 Jan 2026 09:28:50 -0500
Message-ID: <20260114142900.3945054-8-cel@kernel.org>
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

Report ext4's case sensitivity behavior via file_kattr boolean
fields. ext4 always preserves case at rest.

Case sensitivity is a per-directory setting in ext4. If the queried
inode is a casefolded directory, report case-insensitive; otherwise
report case-sensitive (standard POSIX behavior).

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/ext4/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 7ce0fc40aec2..213769d217c3 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -996,6 +996,12 @@ int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 
+	/*
+	 * ext4 preserves case (the default). If this inode is a
+	 * casefolded directory, report case-insensitive; otherwise
+	 * report case-sensitive (standard POSIX behavior).
+	 */
+	fa->case_insensitive = IS_CASEFOLDED(inode);
 	return 0;
 }
 
-- 
2.52.0


