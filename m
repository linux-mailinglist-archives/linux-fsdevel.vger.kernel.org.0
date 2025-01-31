Return-Path: <linux-fsdevel+bounces-40491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 150EDA23E40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CD01888A72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52461C54A5;
	Fri, 31 Jan 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FhWbB7Sr";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="LJPcDGam"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146C61C1F23;
	Fri, 31 Jan 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738329525; cv=none; b=I8vS5tvoNE0fcYuPOSZ05iE7OA0bvOG1vJJUxqhzwnyyoARWP8LC8/PW4vGBjAT/KASqzC4nkTUp/vXdgo526Om69gu2lGOT7lQ7urMHtHVYY8ipwuoFdKVYOAuDbcKLKyuNqoGCl6C1YG1V2H63NO5CSL84A8jZzmhCxb7fRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738329525; c=relaxed/simple;
	bh=+2R6j+G5LXdz2bl7xJs2HJikFKp1C18+Q1dZWVErtuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjdgp3MYOB0jgHxTbh0P9aDjf1QQRuY4oP1zHfXgQJblUQkWvhIE0gwT7zip6LdDJnNEeMGf7CZAGLrHM5ETx5r4LK7PsuxUGtXMFcC//jPG9hDK0YCK6x+aIOeQ/TnefYgM/dlB0H5DC4vxFgajSclx48xagRYgAhRDa9bfuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FhWbB7Sr; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=LJPcDGam; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8DB2B26D1;
	Fri, 31 Jan 2025 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1738329458;
	bh=mqejZPqDCmsCg/VWmxG+29NTa0ZeGImihnLOpNHI2xM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FhWbB7SriaHFOzQJ3+YjbQA+QhwP+YCas2/hLr5bgTj17z30HeJNWPT7/jKseeWRF
	 HipPqU9Ue4efZA3m8RhG4nOBdk/Cbn+JW6OZEw3YLHxXzfftvqG/ItU5s/Z817QobG
	 Sv+4Q2bPlF/ZLyDboiLpKrtStpCgGS44II6L6d1Q=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C9E492117;
	Fri, 31 Jan 2025 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1738329519;
	bh=mqejZPqDCmsCg/VWmxG+29NTa0ZeGImihnLOpNHI2xM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LJPcDGamO2BFPa66j/4i9Dkhx3QbhyUHEI/N/DoLhLqWp01GbZ7rIUTKdE5U8PGoX
	 RyCK+JLBkx9/BUqPdcEoqSLzTbXVaE67nBDkVFNloZK/cBQh6oCvzRhQYHb2V/9xQJ
	 DYPNnvChvW7eMLugLG6e2kTO4vddIE61Wx/w/SuE=
Received: from ntfs3vm.localdomain (192.168.211.140) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 31 Jan 2025 16:18:39 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Kun Hu
	<huk23@m.fudan.edu.cn>
Subject: [PATCH v2] fs/ntfs3: Update inode->i_mapping->a_ops on compression state
Date: Fri, 31 Jan 2025 16:18:31 +0300
Message-ID: <20250131131831.6289-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
References: <20250123135335.15060-1-almaz.alexandrovich@paragon-software.com>
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

v2:
Additionally, ensure that all dirty pages are flushed and concurrent access
to the page cache is blocked.

Fixes: 6b39bfaeec44 ("fs/ntfs3: Add support for the compression attribute")
Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |  3 ++-
 fs/ntfs3/file.c    | 22 ++++++++++++++++++++--
 fs/ntfs3/frecord.c |  6 ++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index af94e3737470..e946f75eb540 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2664,8 +2664,9 @@ int attr_set_compress(struct ntfs_inode *ni, bool compr)
 		attr->nres.run_off = cpu_to_le16(run_off);
 	}
 
-	/* Update data attribute flags. */
+	/* Update attribute flags. */
 	if (compr) {
+		attr->flags &= ~ATTR_FLAG_SPARSED;
 		attr->flags |= ATTR_FLAG_COMPRESSED;
 		attr->nres.c_unit = NTFS_LZNT_CUNIT;
 	} else {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 4d9d84cc3c6f..9b6a3f8d2e7c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -101,8 +101,26 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Allowed to change compression for empty files and for directories only. */
 	if (!is_dedup(ni) && !is_encrypted(ni) &&
 	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode))) {
-		/* Change compress state. */
-		int err = ni_set_compress(inode, flags & FS_COMPR_FL);
+		int err = 0;
+		struct address_space *mapping = inode->i_mapping;
+
+		/* write out all data and wait. */
+		filemap_invalidate_lock(mapping);
+		err = filemap_write_and_wait(mapping);
+
+		if (err >= 0) {
+			/* Change compress state. */
+			bool compr = flags & FS_COMPR_FL;
+			err = ni_set_compress(inode, compr);
+
+			/* For files change a_ops too. */
+			if (!err)
+				mapping->a_ops = compr ? &ntfs_aops_cmpr :
+							 &ntfs_aops;
+		}
+
+		filemap_invalidate_unlock(mapping);
+
 		if (err)
 			return err;
 	}
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


