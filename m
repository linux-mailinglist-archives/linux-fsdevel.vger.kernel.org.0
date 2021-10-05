Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE7422E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhJEQtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:49:20 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:34228 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233928AbhJEQtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:49:19 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A702B1D3B;
        Tue,  5 Oct 2021 19:47:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633452446;
        bh=1hkXWZg0gGYLqaDEraBod4BgLqQtDThhgkdcvLmR/YQ=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=KinEtfOpMiRqg7VRQkSR2UOf7mzlJnTbpdAvePEKxfKGERzxeZo8g7UVGYSNZGjMX
         VkJNVn4LTlyCp6B/lQWjlEqkTAaSdDr82URbcO5H2XE2N+9+PYtQiWEoBO45K0Nmk5
         Cm1oRHE2tyrTIxSFGi8T/OlOvQpuvqzVeroWXkFo=
Received: from [192.168.211.181] (192.168.211.181) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 5 Oct 2021 19:47:26 +0300
Message-ID: <b4fc8185-83a8-7626-5ebe-eb6c5cedc078@paragon-software.com>
Date:   Tue, 5 Oct 2021 19:47:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 2/5] fs/ntfs3: Refactor ntfs_readlink_hlp
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
In-Reply-To: <98a166e4-f894-8bff-9479-05ef5435f1ed@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.181]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename some variables.
Returned err by default is EINVAL.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c | 91 +++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 48 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7dd162f6a7e2..d618b0573533 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1763,15 +1763,15 @@ void ntfs_evict_inode(struct inode *inode)
 static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 				      int buflen)
 {
-	int i, err = 0;
+	int i, err = -EINVAL;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
-	u64 i_size = inode->i_size;
-	u16 nlen = 0;
+	u64 size;
+	u16 ulen = 0;
 	void *to_free = NULL;
 	struct REPARSE_DATA_BUFFER *rp;
-	struct le_str *uni;
+	const __le16 *uname;
 	struct ATTRIB *attr;
 
 	/* Reparse data present. Try to parse it. */
@@ -1780,68 +1780,64 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 
 	*buffer = 0;
 
-	/* Read into temporal buffer. */
-	if (i_size > sbi->reparse.max_size || i_size <= sizeof(u32)) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	attr = ni_find_attr(ni, NULL, NULL, ATTR_REPARSE, NULL, 0, NULL, NULL);
-	if (!attr) {
-		err = -EINVAL;
+	if (!attr)
 		goto out;
-	}
 
 	if (!attr->non_res) {
-		rp = resident_data_ex(attr, i_size);
-		if (!rp) {
-			err = -EINVAL;
+		rp = resident_data_ex(attr, sizeof(struct REPARSE_DATA_BUFFER));
+		if (!rp)
 			goto out;
-		}
+		size = le32_to_cpu(attr->res.data_size);
 	} else {
-		rp = kmalloc(i_size, GFP_NOFS);
+		size = le64_to_cpu(attr->nres.data_size);
+		rp = NULL;
+	}
+
+	if (size > sbi->reparse.max_size || size <= sizeof(u32))
+		goto out;
+
+	if (!rp) {
+		rp = kmalloc(size, GFP_NOFS);
 		if (!rp) {
 			err = -ENOMEM;
 			goto out;
 		}
 		to_free = rp;
-		err = ntfs_read_run_nb(sbi, &ni->file.run, 0, rp, i_size, NULL);
+		/* Read into temporal buffer. */
+		err = ntfs_read_run_nb(sbi, &ni->file.run, 0, rp, size, NULL);
 		if (err)
 			goto out;
 	}
 
-	err = -EINVAL;
-
 	/* Microsoft Tag. */
 	switch (rp->ReparseTag) {
 	case IO_REPARSE_TAG_MOUNT_POINT:
 		/* Mount points and junctions. */
 		/* Can we use 'Rp->MountPointReparseBuffer.PrintNameLength'? */
-		if (i_size <= offsetof(struct REPARSE_DATA_BUFFER,
-				       MountPointReparseBuffer.PathBuffer))
+		if (size <= offsetof(struct REPARSE_DATA_BUFFER,
+				     MountPointReparseBuffer.PathBuffer))
 			goto out;
-		uni = Add2Ptr(rp,
-			      offsetof(struct REPARSE_DATA_BUFFER,
-				       MountPointReparseBuffer.PathBuffer) +
-				      le16_to_cpu(rp->MountPointReparseBuffer
-							  .PrintNameOffset) -
-				      2);
-		nlen = le16_to_cpu(rp->MountPointReparseBuffer.PrintNameLength);
+		uname = Add2Ptr(rp,
+				offsetof(struct REPARSE_DATA_BUFFER,
+					 MountPointReparseBuffer.PathBuffer) +
+					le16_to_cpu(rp->MountPointReparseBuffer
+							    .PrintNameOffset));
+		ulen = le16_to_cpu(rp->MountPointReparseBuffer.PrintNameLength);
 		break;
 
 	case IO_REPARSE_TAG_SYMLINK:
 		/* FolderSymbolicLink */
 		/* Can we use 'Rp->SymbolicLinkReparseBuffer.PrintNameLength'? */
-		if (i_size <= offsetof(struct REPARSE_DATA_BUFFER,
-				       SymbolicLinkReparseBuffer.PathBuffer))
+		if (size <= offsetof(struct REPARSE_DATA_BUFFER,
+				     SymbolicLinkReparseBuffer.PathBuffer))
 			goto out;
-		uni = Add2Ptr(rp,
-			      offsetof(struct REPARSE_DATA_BUFFER,
-				       SymbolicLinkReparseBuffer.PathBuffer) +
-				      le16_to_cpu(rp->SymbolicLinkReparseBuffer
-							  .PrintNameOffset) -
-				      2);
-		nlen = le16_to_cpu(
+		uname = Add2Ptr(
+			rp, offsetof(struct REPARSE_DATA_BUFFER,
+				     SymbolicLinkReparseBuffer.PathBuffer) +
+				    le16_to_cpu(rp->SymbolicLinkReparseBuffer
+							.PrintNameOffset));
+		ulen = le16_to_cpu(
 			rp->SymbolicLinkReparseBuffer.PrintNameLength);
 		break;
 
@@ -1873,29 +1869,28 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 			goto out;
 		}
 		if (!IsReparseTagNameSurrogate(rp->ReparseTag) ||
-		    i_size <= sizeof(struct REPARSE_POINT)) {
+		    size <= sizeof(struct REPARSE_POINT)) {
 			goto out;
 		}
 
 		/* Users tag. */
-		uni = Add2Ptr(rp, sizeof(struct REPARSE_POINT) - 2);
-		nlen = le16_to_cpu(rp->ReparseDataLength) -
+		uname = Add2Ptr(rp, sizeof(struct REPARSE_POINT));
+		ulen = le16_to_cpu(rp->ReparseDataLength) -
 		       sizeof(struct REPARSE_POINT);
 	}
 
 	/* Convert nlen from bytes to UNICODE chars. */
-	nlen >>= 1;
+	ulen >>= 1;
 
 	/* Check that name is available. */
-	if (!nlen || &uni->name[nlen] > (__le16 *)Add2Ptr(rp, i_size))
+	if (!ulen || uname + ulen > (__le16 *)Add2Ptr(rp, size))
 		goto out;
 
 	/* If name is already zero terminated then truncate it now. */
-	if (!uni->name[nlen - 1])
-		nlen -= 1;
-	uni->len = nlen;
+	if (!uname[ulen - 1])
+		ulen -= 1;
 
-	err = ntfs_utf16_to_nls(sbi, uni, buffer, buflen);
+	err = ntfs_utf16_to_nls(sbi, uname, ulen, buffer, buflen);
 
 	if (err < 0)
 		goto out;
-- 
2.33.0


