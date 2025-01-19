Return-Path: <linux-fsdevel+bounces-39611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D588A16265
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 16:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C36164B2F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059271DF251;
	Sun, 19 Jan 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="L9ucWdyJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087816415;
	Sun, 19 Jan 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298818; cv=none; b=OrVEFgX/bUQSzMP0tQV3CpNlmE1Qqwo86tpm1C8DIvsbTrzLXYyJFg9XPjg/LgA91bSf2VpEB9wbJQ7ZzZXwZDMG/SfNeNf1Sv2tXsrqHNEgEfHcAq8TRyjAZO5hyjGcHCHvJBIAKvErk/kgO16QDsnt5NakkZuv6G8ywAnS1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298818; c=relaxed/simple;
	bh=EIicUNf3AxSd8kyudhvGquw6fRE5W6dFnSIWImmXlHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJQ3jMSX/hAH9xIBIzhC24Bqam5jFDHLhWVNQlrp9eOgF2uP5bLxbAW32BbPlAVHSI9hMTafo7qRZ9g8SDkXCNstN3C3u8bhQRGJZfHPyr45Otl4Wm+wkrAEJpoQFUItoYmwBrsmQ52tYxsGt8z9scFQGcprit4ki5FpP4DVl7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=L9ucWdyJ; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737298815;
	bh=EIicUNf3AxSd8kyudhvGquw6fRE5W6dFnSIWImmXlHY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=L9ucWdyJCn2DzJboUzGN7ub0Cx4kzmAZNTA8D1umFA1jwDjf65CmZ5u+3HGly4cRY
	 A29l725WWCnxB/sE+oGn5/hsmTSPKqJy618gxmHZCwR71vhN41LOEghdiM+gbSpmfO
	 jM1d1rcrbTDg8vY3XPfE0T1pAKdJU6cairzq8Fds=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id D34BB128651F;
	Sun, 19 Jan 2025 10:00:15 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Yq3JkmNeO5vh; Sun, 19 Jan 2025 10:00:15 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE208128651D;
	Sun, 19 Jan 2025 10:00:14 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-efi@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] efivarfs: prevent setting of zero size on the inodes in the cache
Date: Sun, 19 Jan 2025 09:59:40 -0500
Message-Id: <20250119145941.22094-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
References: <20250119145941.22094-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current efivarfs uses simple_setattr which allows the setting of any
size in the inode cache.  This is wrong because a zero size file is
used to indicate an "uncommitted" variable, so by simple means of
truncating the file (as root) any variable may be turned to look like
it's uncommitted.  Fix by adding an efivarfs_setattr routine which
does not allow updating of the cached inode size (which now only comes
from the underlying variable).

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/efivarfs/inode.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index ec23da8405ff..a4a6587ecd2e 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -187,7 +187,24 @@ efivarfs_fileattr_set(struct mnt_idmap *idmap,
 	return 0;
 }
 
+/* copy of simple_setattr except that it doesn't do i_size updates */
+static int efivarfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		   struct iattr *iattr)
+{
+	struct inode *inode = d_inode(dentry);
+	int error;
+
+	error = setattr_prepare(idmap, dentry, iattr);
+	if (error)
+		return error;
+
+	setattr_copy(idmap, inode, iattr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
 static const struct inode_operations efivarfs_file_inode_operations = {
 	.fileattr_get = efivarfs_fileattr_get,
 	.fileattr_set = efivarfs_fileattr_set,
+	.setattr      = efivarfs_setattr,
 };
-- 
2.35.3


