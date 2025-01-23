Return-Path: <linux-fsdevel+bounces-39935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365BDA1A53F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 14:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D391886DD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176E020FA8E;
	Thu, 23 Jan 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ulh3B6Qs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B51C6F70;
	Thu, 23 Jan 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737640434; cv=none; b=c32QIF4fYfXC+bOuv7Blz70547C7ksNQK933nmy5KI0BJw1blfjKKzz7vPeph7UWpmc+8/IBac34Jira/4VBygTyBF7VstzhtyJPmY85PjTYofvVOSzeyy++T3Yl/OQ2tpM41qWrKIOpW+kPsxbMNw49Jn9CwynVXy+ETIzGRCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737640434; c=relaxed/simple;
	bh=fIY9VJrjo3CSY0ysJkZk4BxdCFZ83+ny9LgTaNchne4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WeI1tGsLFsQt6iEWvNr4baettNwTlDAqyskL3AG6wuQGgru1eVUEe4z1NB8IssCX5qLc0SUS4kdZtt4HQUBseiLtDUkXEOlmJGgFoqlmeQp+x+Of9855StkIBqceCf3Eag8AOWpl1qTjuECvqpQud5lJppqdDOaFcXW6x9CMuHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ulh3B6Qs; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 024CE1D2F;
	Thu, 23 Jan 2025 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1737640372;
	bh=uFzZ5UMfHY+uCFssxorFeNqHgTRRX3R3zhAkhTP+pBI=;
	h=From:To:CC:Subject:Date;
	b=ulh3B6QsFQGEy1fs4SF31haOl5+2QjeKEHn3GKeP1VDxbnMNpXa1zbZPk4/dr2SS0
	 xUoHl+kxvu59lhLrB2uHw/0T95h+KaFnEY7KeyXfnkSxyNVHBwuMDKCw8140ImPPPN
	 VgpT+MTD3kco8MDJwUTV9NECnESsZoJ38/CPBg4w=
Received: from ntfs3vm.paragon-software.com (192.168.211.136) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 23 Jan 2025 16:53:44 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Jiaji Qin
	<jjtan24@m.fudan.edu.cn>, Kun Hu <huk23@m.fudan.edu.cn>
Subject: [PATCH] fs/ntfs3: Update inode->i_mapping->a_ops on compression state change
Date: Thu, 23 Jan 2025 16:53:35 +0300
Message-ID: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Update inode->i_mapping->a_ops when the compression state changes to
ensure correct address space operations.
Clear ATTR_FLAG_SPARSED/FILE_ATTRIBUTE_SPARSE_FILE when enabling
compression to prevent flag conflicts.

Fixes: 6b39bfaeec44 ("fs/ntfs3: Add support for the compression attribute")
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 1 +
 fs/ntfs3/file.c    | 2 ++
 fs/ntfs3/frecord.c | 6 ++++--
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index af94e3737470..d2410ab6c7bf 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2666,6 +2666,7 @@ int attr_set_compress(struct ntfs_inode *ni, bool compr)
 
 	/* Update data attribute flags. */
 	if (compr) {
+		attr->flags &= ATTR_FLAG_SPARSED;
 		attr->flags |= ATTR_FLAG_COMPRESSED;
 		attr->nres.c_unit = NTFS_LZNT_CUNIT;
 	} else {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3f96a11804c9..e8f452f47cd5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -105,6 +105,8 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
 		if (err)
 			return err;
+		inode->i_mapping->a_ops =
+			(flags & FS_COMPR_FL) ? &ntfs_aops_cmpr : &ntfs_aops;
 	}
 
 	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 5df6a0b5add9..81271196c557 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3434,10 +3434,12 @@ int ni_set_compress(struct inode *inode, bool compr)
 	}
 
 	ni->std_fa = std->fa;
-	if (compr)
+	if (compr) {
+		std->fa &= ~FILE_ATTRIBUTE_SPARSE_FILE;
 		std->fa |= FILE_ATTRIBUTE_COMPRESSED;
-	else
+	} else {
 		std->fa &= ~FILE_ATTRIBUTE_COMPRESSED;
+	}
 
 	if (ni->std_fa != std->fa) {
 		ni->std_fa = std->fa;
-- 
2.34.1


