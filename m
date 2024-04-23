Return-Path: <linux-fsdevel+bounces-17469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410AC8ADDB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 08:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7355F1C21EB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66D53819;
	Tue, 23 Apr 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="sJGveCFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0C535AA;
	Tue, 23 Apr 2024 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854731; cv=none; b=PgxI4S+0xfBzGHl2PF7jcDR1o3lciNZzPWzspJAfDqPAcuwt7o8WNqcTF3LkW5uOyTT0hakXQ0DEYXcrDP40ODD7lam/5fl+hC8zmgdbUpdMC+NO6m0Q14WP1DUhb9qxegrUp38ue3t28kCNw2sTjV5qI/xATtBq9itUON/jjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854731; c=relaxed/simple;
	bh=5V5mlWjgKEt2xggGHOJT9zfphZm259eruYClAAMeW0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZVsmaJ98dm6XGj33b74/S5XpU203TlH0v+hbNAy0fQgR4IqW7HjVjufVcTvCvceh9ZkO8D6jVxj97rJTAuF4hWiB7004a5+PXPHUQAFQVJg3D37zb0ovx59aQI1G1JOLq4CczdGVs2IHpiD+KJtGqonX573aKlOThR2YLo58bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=sJGveCFJ; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 26DFA2001;
	Tue, 23 Apr 2024 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713854276;
	bh=iXPcB3W86y8aVaYAB3RHoq4FWQk45RoZD6nKh0gQY00=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sJGveCFJeKRoNE8pxoKdykAhBTWKSs+Z7TjGH0023pmO+IROMcScOOpEj1jWEC0Bm
	 rzLShtvadAmLVEMICBvSKEy6/hGVdpEPKzEcxDyJyVqK7m4U/4yN7pghIcaVI0flrU
	 TM+c5VYkMHBiUYnVLZMPtYeSDHsswtmhYSiOHC4M=
Received: from ntfs3vm.paragon-software.com (192.168.211.160) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 23 Apr 2024 09:45:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 8/9] fs/ntfs3: Always make file nonresident on fallocate call
Date: Tue, 23 Apr 2024 09:44:27 +0300
Message-ID: <20240423064428.8289-9-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
References: <20240423064428.8289-1-almaz.alexandrovich@paragon-software.com>
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

xfstest 438 is starting to pass with this change.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 32 ++++++++++++++++++++++++++++++++
 fs/ntfs3/file.c    |  9 +++++++++
 fs/ntfs3/ntfs_fs.h |  1 +
 3 files changed, 42 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 7aadf5010999..8e6bcdf99770 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2558,3 +2558,35 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 
 	goto out;
 }
+
+/*
+ * attr_force_nonresident
+ *
+ * Convert default data attribute into non resident form.
+ */
+int attr_force_nonresident(struct ntfs_inode *ni)
+{
+	int err;
+	struct ATTRIB *attr;
+	struct ATTR_LIST_ENTRY *le = NULL;
+	struct mft_inode *mi;
+
+	attr = ni_find_attr(ni, NULL, &le, ATTR_DATA, NULL, 0, NULL, &mi);
+	if (!attr) {
+		ntfs_bad_inode(&ni->vfs_inode, "no data attribute");
+		return -ENOENT;
+	}
+
+	if (attr->non_res) {
+		/* Already non resident. */
+		return 0;
+	}
+
+	down_write(&ni->file.run_lock);
+	err = attr_make_nonresident(ni, attr, le, mi,
+				    le32_to_cpu(attr->res.data_size),
+				    &ni->file.run, &attr, NULL);
+	up_write(&ni->file.run_lock);
+
+	return err;
+}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5418662c80d8..fce8ea098d60 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -578,6 +578,15 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		/* Check new size. */
 		u8 cluster_bits = sbi->cluster_bits;
 
+		/* Be sure file is non resident. */
+		if (is_resident(ni)) {
+			ni_lock(ni);
+			err = attr_force_nonresident(ni);
+			ni_unlock(ni);
+			if (err)
+				goto out;
+		}
+
 		/* generic/213: expected -ENOSPC instead of -EFBIG. */
 		if (!is_supported_holes) {
 			loff_t to_alloc = new_size - inode_get_bytes(inode);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 3db6a61f61dc..00dec0ec5648 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -452,6 +452,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
 int attr_punch_hole(struct ntfs_inode *ni, u64 vbo, u64 bytes, u32 *frame_size);
+int attr_force_nonresident(struct ntfs_inode *ni);
 
 /* Functions from attrlist.c */
 void al_destroy(struct ntfs_inode *ni);
-- 
2.34.1


