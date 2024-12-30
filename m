Return-Path: <linux-fsdevel+bounces-38263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B069FE3F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 09:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E14616169E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95E1A238D;
	Mon, 30 Dec 2024 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="jLRKDyfH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896E1A0B15;
	Mon, 30 Dec 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735548703; cv=none; b=PvC68mWUrzN15kDq9wNfUZw0uOlZQX4ZGvFMGmt5W76EH2PneW+C781hDuO1QZpxZbDb6VFj0wex937r5h58LVebQD3aCnGIUHBtadtV+Gwdp8Jnlf3AkzgZrsFpYmZ+8+G8yDIPe5YHmLMmhvEAOhGIuff/q5CSCeCUIkgCEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735548703; c=relaxed/simple;
	bh=wOmXF/rySu7Q9In5RqcleP5CsIBEhfUM0JHdFXfS5Cg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LP8dvEwO0/wIfwMQFYwdF1w2c48/+1YpaRMafg+125gwvK0RNiZJH/6bdVyirUaB+z8Exj48zCIYhm8gS59uNfo+p3QTRi1TfdlY/7a3g/vL87Kzn3ulCTGksgDlu5JJPDdAS8g4toh/7xkkIN0TQMmoXaCtspcxJH1V4kGneLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=jLRKDyfH; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 62BB92001;
	Mon, 30 Dec 2024 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1735548673;
	bh=0Tq9sS3zo5tq38SGJ8g3hPzxqHb1ENdAFfRFcPcn6Qc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jLRKDyfHpSr6PB7kAzQxcpoH98jDLDiKw44sLKKjGeZWzMLJqD6bhv3OYMEEs5uAr
	 yvA8d1Eme3sevqNLSPjrWURQRgBC5YjQCr4jx2YMgS0qsXuUNEoIELFeMQbqn7XZsy
	 75mrFSTT0VlRrt65A1MoheaViVynz+SQrx84Bu+U=
Received: from ntfs3vm.paragon-software.com (192.168.211.75) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Dec 2024 11:51:39 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 2/2] fs/ntfs3: Unify inode corruption marking with _ntfs_bad_inode()
Date: Mon, 30 Dec 2024 11:51:16 +0300
Message-ID: <20241230085116.322824-3-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230085116.322824-1-almaz.alexandrovich@paragon-software.com>
References: <20241230085116.322824-1-almaz.alexandrovich@paragon-software.com>
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

Also reworked error handling in a couple of places.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |  4 ++--
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/frecord.c | 12 +++++++-----
 fs/ntfs3/fsntfs.c  |  6 +++++-
 fs/ntfs3/index.c   |  6 ++----
 fs/ntfs3/inode.c   |  3 +++
 6 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 795cf8e75d2e..af94e3737470 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1407,7 +1407,7 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 	 */
 	if (!attr->non_res) {
 		if (vbo[1] + bytes_per_off > le32_to_cpu(attr->res.data_size)) {
-			ntfs_inode_err(&ni->vfs_inode, "is corrupted");
+			_ntfs_bad_inode(&ni->vfs_inode);
 			return -EINVAL;
 		}
 		addr = resident_data(attr);
@@ -2588,7 +2588,7 @@ int attr_force_nonresident(struct ntfs_inode *ni)
 
 	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, &mi);
 	if (!attr) {
-		ntfs_bad_inode(&ni->vfs_inode, "no data attribute");
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return -ENOENT;
 	}
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index fc6a8aa29e3a..b6da80c69ca6 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -512,7 +512,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos = pos;
 	} else if (err < 0) {
 		if (err == -EINVAL)
-			ntfs_inode_err(dir, "directory corrupted");
+			_ntfs_bad_inode(dir);
 		ctx->pos = eod;
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b6be7dfafcbd..5df6a0b5add9 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -148,8 +148,10 @@ int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi)
 		goto out;
 
 	err = mi_get(ni->mi.sbi, rno, &r);
-	if (err)
+	if (err) {
+		_ntfs_bad_inode(&ni->vfs_inode);
 		return err;
+	}
 
 	ni_add_mi(ni, r);
 
@@ -239,8 +241,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return attr;
 
 out:
-	ntfs_inode_err(&ni->vfs_inode, "failed to parse mft record");
-	ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -332,6 +333,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	    vcn <= le64_to_cpu(attr->nres.evcn))
 		return attr;
 
+	_ntfs_bad_inode(&ni->vfs_inode);
 	return NULL;
 }
 
@@ -1607,8 +1609,8 @@ int ni_delete_all(struct ntfs_inode *ni)
 		roff = le16_to_cpu(attr->nres.run_off);
 
 		if (roff > asize) {
-			_ntfs_bad_inode(&ni->vfs_inode);
-			return -EINVAL;
+			/* ni_enum_attr_ex checks this case. */
+			continue;
 		}
 
 		/* run==1 means unpack and deallocate. */
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 03471bc9371c..938d351ebac7 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -908,7 +908,11 @@ void ntfs_bad_inode(struct inode *inode, const char *hint)
 
 	ntfs_inode_err(inode, "%s", hint);
 	make_bad_inode(inode);
-	ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	/* Avoid recursion if bad inode is $Volume. */
+	if (inode->i_ino != MFT_REC_VOL &&
+	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING)) {
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+	}
 }
 
 /*
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 9089c58a005c..7eb9fae22f8d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1094,8 +1094,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 ok:
 	if (!index_buf_check(ib, bytes, &vbn)) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1117,8 +1116,7 @@ int indx_read(struct ntfs_index *indx, struct ntfs_inode *ni, CLST vbn,
 
 out:
 	if (err == -E_NTFS_CORRUPT) {
-		ntfs_inode_err(&ni->vfs_inode, "directory corrupted");
-		ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+		_ntfs_bad_inode(&ni->vfs_inode);
 		err = -EINVAL;
 	}
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index be04d2845bb7..a1e11228dafd 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -410,6 +410,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	if (!std5)
 		goto out;
 
+	if (is_bad_inode(inode))
+		goto out;
+
 	if (!is_match && name) {
 		err = -ENOENT;
 		goto out;
-- 
2.34.1


