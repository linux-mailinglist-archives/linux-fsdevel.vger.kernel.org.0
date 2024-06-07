Return-Path: <linux-fsdevel+bounces-21182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D390033B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A671F214E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4361195F38;
	Fri,  7 Jun 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="ql6b1Rc+";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="udhbf3NC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF3D194AD0;
	Fri,  7 Jun 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762585; cv=none; b=u4D2yzVisLvAmu73/7t8jwjikOg57cBAV/wFr9LKcDq7wDybxXTuqWOLFIdQre0/8rj6a8lOQnLN6NTu+IrdXaIuPzL+d159SDgxozzivVVTfTCrrN1CdeVgWQen86oIe+qJDNNsyR0kUxE0hbyWtaOKL2JXgu92OgU9pzCZdiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762585; c=relaxed/simple;
	bh=dE3xbrb288BUcy0ffw0XuM+Wo69zpin7XHmKE6h0t/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLcLLzCFt5IY7MdeAZKlEohnAnT5q3gI+7l1fcZTlvmV2OSBIwyBw8h1CSICFTDR0mDEf6WHjkgly8dKhmRH9UkDRU4oKMUCCxRGegniEzQEkZTabW7QyhfGpx1YJ+csMI6qyO7eKR9VOMES8mgTFUuAK9+VbHY1QH7z54ELpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=ql6b1Rc+; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=udhbf3NC; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 238322113;
	Fri,  7 Jun 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762107;
	bh=ym80i2jTMD1HhHw9F6CkuGUlURqOKsq9Wpygi7rED0Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ql6b1Rc+StMi1+r0ITd5QoV2mnkysFlrCipV2oajuuunicN2cf3sdyQuNStnoiT0k
	 ewrtZN55TlktwwSnXYH0/dlr93yU/VENgkFlmorIm2wPgndpvyaWlmmKT7jiMkALLv
	 6qo9gAC1nJIiyI9YLRs2d7wJnQcahRP3FDYTz5RM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 0695A195;
	Fri,  7 Jun 2024 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762581;
	bh=ym80i2jTMD1HhHw9F6CkuGUlURqOKsq9Wpygi7rED0Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=udhbf3NCsD2gP7uFZbWhAJDK+16Ws0gCfh+H5vIymtSFnBiNhTA/CtNcp7LEsjWiy
	 5pfNgE7fRDZXHqHcZHjZx/SGVY3GrKlv5RM1VZvZIazH/Y5PRyqNQEzR/JiZeWHr05
	 hhFIdHuG7VUDcGDtK+LLH3IJRWN3St/8eQtlkWYs=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:20 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 13/18] fs/ntfs3: Use macros NTFS_LABEL_MAX_LENGTH instead of hardcoded value
Date: Fri, 7 Jun 2024 15:15:43 +0300
Message-ID: <20240607121548.18818-14-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

To check the length of the volume label, the existing constant
NTFS_LABEL_MAX_LENGTH could be used.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fsntfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 626d3f2c7e2d..0fa636038b4e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2650,8 +2650,8 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 {
 	int err;
 	struct ATTRIB *attr;
+	u32 uni_bytes;
 	struct ntfs_inode *ni = sbi->volume.ni;
-	const u8 max_ulen = 0x80; /* TODO: use attrdef to get maximum length */
 	/* Allocate PATH_MAX bytes. */
 	struct cpu_str *uni = __getname();
 
@@ -2663,7 +2663,8 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 	if (err < 0)
 		goto out;
 
-	if (uni->len > max_ulen) {
+	uni_bytes = uni->len * sizeof(u16);
+	if (uni_bytes > NTFS_LABEL_MAX_LENGTH * sizeof(u16)) {
 		ntfs_warn(sbi->sb, "new label is too long");
 		err = -EFBIG;
 		goto out;
@@ -2674,13 +2675,13 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 	/* Ignore any errors. */
 	ni_remove_attr(ni, ATTR_LABEL, NULL, 0, false, NULL);
 
-	err = ni_insert_resident(ni, uni->len * sizeof(u16), ATTR_LABEL, NULL,
-				 0, &attr, NULL, NULL);
+	err = ni_insert_resident(ni, uni_bytes, ATTR_LABEL, NULL, 0, &attr,
+				 NULL, NULL);
 	if (err < 0)
 		goto unlock_out;
 
 	/* write new label in on-disk struct. */
-	memcpy(resident_data(attr), uni->name, uni->len * sizeof(u16));
+	memcpy(resident_data(attr), uni->name, uni_bytes);
 
 	/* update cached value of current label. */
 	if (len >= ARRAY_SIZE(sbi->volume.label))
-- 
2.34.1


