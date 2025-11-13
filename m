Return-Path: <linux-fsdevel+bounces-68286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30795C586B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75BFB34CF4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC4359701;
	Thu, 13 Nov 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="M3CKGDKK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1622E8B6F;
	Thu, 13 Nov 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047092; cv=none; b=Y23omv6M+BR0YlkFWW47WY0OTttNvSXqApBDz4aBrIye5gr/hu1vaVn3fkmr0ysIqUEVoXxUyIr0Oe0o6KdtBZVqjQ0c95gHgh6sWchZeN+PkmIwbJppLH9mZHoDYv84st/dmfJ41YH/xtCQl++eJutyINqcQJw9Cv5v7NFDSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047092; c=relaxed/simple;
	bh=C3bQJEeiZqf0kmN5RC6hlo6LUZPWBiGblw7TaXGD9CA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sy3BM+JyJUDLb0C1gw9FyOqfN4VMgJIHTwcXqhcMq+2BZa/zLsrIHki2uKN9Lw0/ek/cTM1T3VsfA2Cx3S95MxbCu2bn23OGZHcFjLzx+Y9MdYVp0yqt0FkX7aZLi75MpAgrJAqzThbBR0+9aQUulaRpm0CKqVsdLvmvenfht7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=M3CKGDKK; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id C930A1D47;
	Thu, 13 Nov 2025 15:14:39 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=M3CKGDKK;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 802C12151;
	Thu, 13 Nov 2025 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763047081;
	bh=+gdkkyvlEFpgEIgXHjHTADvJbOSHIkINmuaG5SPiN+4=;
	h=From:To:CC:Subject:Date;
	b=M3CKGDKKU2OBrZXtPJdbKNEBEwMPc8GZQdjvyKZLICyFbK8g0dZVdfl+6Tl906nxB
	 7wnjeMFaGkxQ/lKLohPHVXctmkXc/tfPLd+qdbIJwpYNldfwYs7ETrg3S6TIEC3nLR
	 RViWQg/VIB1IrLR57xtE9xeyc6U7n2xqxsdTzcdk=
Received: from localhost.localdomain (172.30.20.182) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Nov 2025 18:18:00 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: correct attr_collapse_range when file is too fragmented
Date: Thu, 13 Nov 2025 16:17:52 +0100
Message-ID: <20251113151752.7493-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

Fix incorrect VCN adjustments in attr_collapse_range() that caused
filesystem errors or corruption on very fragmented NTFS files when
performing collapse-range operations.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 84 ++++++++++++++++++++++------------------------
 fs/ntfs3/ntfs_fs.h |  4 +--
 fs/ntfs3/record.c  |  2 +-
 fs/ntfs3/run.c     | 11 ++++--
 4 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index d0373254f82a..980ae9157248 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -1860,7 +1860,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	struct ATTRIB *attr = NULL, *attr_b;
 	struct ATTR_LIST_ENTRY *le, *le_b;
 	struct mft_inode *mi, *mi_b;
-	CLST svcn, evcn1, len, dealloc, alen;
+	CLST svcn, evcn1, len, dealloc, alen, done;
 	CLST vcn, end;
 	u64 valid_size, data_size, alloc_size, total_size;
 	u32 mask;
@@ -1923,6 +1923,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	len = bytes >> sbi->cluster_bits;
 	end = vcn + len;
 	dealloc = 0;
+	done = 0;
 
 	svcn = le64_to_cpu(attr_b->nres.svcn);
 	evcn1 = le64_to_cpu(attr_b->nres.evcn) + 1;
@@ -1931,23 +1932,28 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 		attr = attr_b;
 		le = le_b;
 		mi = mi_b;
-	} else if (!le_b) {
+		goto check_seg;
+	}
+
+	if (!le_b) {
 		err = -EINVAL;
 		goto out;
-	} else {
-		le = le_b;
-		attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn,
-				    &mi);
-		if (!attr) {
-			err = -EINVAL;
-			goto out;
-		}
+	}
 
-		svcn = le64_to_cpu(attr->nres.svcn);
-		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+	le = le_b;
+	attr = ni_find_attr(ni, attr_b, &le, ATTR_DATA, NULL, 0, &vcn, &mi);
+	if (!attr) {
+		err = -EINVAL;
+		goto out;
 	}
 
 	for (;;) {
+		CLST vcn1, eat, next_svcn;
+
+		svcn = le64_to_cpu(attr->nres.svcn);
+		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
+
+check_seg:
 		if (svcn >= end) {
 			/* Shift VCN- */
 			attr->nres.svcn = cpu_to_le64(svcn - len);
@@ -1957,22 +1963,25 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				ni->attr_list.dirty = true;
 			}
 			mi->dirty = true;
-		} else if (svcn < vcn || end < evcn1) {
-			CLST vcn1, eat, next_svcn;
+			goto next_attr;
+		}
 
-			/* Collapse a part of this attribute segment. */
-			err = attr_load_runs(attr, ni, run, &svcn);
-			if (err)
-				goto out;
-			vcn1 = max(vcn, svcn);
-			eat = min(end, evcn1) - vcn1;
+		run_truncate(run, 0);
+		err = attr_load_runs(attr, ni, run, &svcn);
+		if (err)
+			goto out;
 
-			err = run_deallocate_ex(sbi, run, vcn1, eat, &dealloc,
-						true);
-			if (err)
-				goto out;
+		vcn1 = vcn + done; /* original vcn in attr/run. */
+		eat = min(end, evcn1) - vcn1;
+
+		err = run_deallocate_ex(sbi, run, vcn1, eat, &dealloc, true);
+		if (err)
+			goto out;
 
-			if (!run_collapse_range(run, vcn1, eat)) {
+		if (svcn + eat < evcn1) {
+			/* Collapse a part of this attribute segment. */
+
+			if (!run_collapse_range(run, vcn1, eat, done)) {
 				err = -ENOMEM;
 				goto out;
 			}
@@ -1980,7 +1989,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			if (svcn >= vcn) {
 				/* Shift VCN */
 				attr->nres.svcn = cpu_to_le64(vcn);
-				if (le) {
+				if (le && attr->nres.svcn != le->vcn) {
 					le->vcn = attr->nres.svcn;
 					ni->attr_list.dirty = true;
 				}
@@ -1991,7 +2000,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				goto out;
 
 			next_svcn = le64_to_cpu(attr->nres.evcn) + 1;
-			if (next_svcn + eat < evcn1) {
+			if (next_svcn + eat + done < evcn1) {
 				err = ni_insert_nonresident(
 					ni, ATTR_DATA, NULL, 0, run, next_svcn,
 					evcn1 - eat - next_svcn, a_flags, &attr,
@@ -2005,18 +2014,9 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 
 			/* Free all allocated memory. */
 			run_truncate(run, 0);
+			done += eat;
 		} else {
 			u16 le_sz;
-			u16 roff = le16_to_cpu(attr->nres.run_off);
-
-			if (roff > le32_to_cpu(attr->size)) {
-				err = -EINVAL;
-				goto out;
-			}
-
-			run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn,
-				      evcn1 - 1, svcn, Add2Ptr(attr, roff),
-				      le32_to_cpu(attr->size) - roff);
 
 			/* Delete this attribute segment. */
 			mi_remove_attr(NULL, mi, attr);
@@ -2029,6 +2029,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				goto out;
 			}
 
+			done += evcn1 - svcn;
 			if (evcn1 >= alen)
 				break;
 
@@ -2046,11 +2047,12 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 					err = -EINVAL;
 					goto out;
 				}
-				goto next_attr;
+				continue;
 			}
 			le = (struct ATTR_LIST_ENTRY *)((u8 *)le - le_sz);
 		}
 
+next_attr:
 		if (evcn1 >= alen)
 			break;
 
@@ -2059,10 +2061,6 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 			err = -EINVAL;
 			goto out;
 		}
-
-next_attr:
-		svcn = le64_to_cpu(attr->nres.svcn);
-		evcn1 = le64_to_cpu(attr->nres.evcn) + 1;
 	}
 
 	if (!attr_b) {
@@ -2552,7 +2550,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	if (attr_load_runs(attr, ni, run, NULL))
 		goto bad_inode;
 
-	if (!run_collapse_range(run, vcn, len))
+	if (!run_collapse_range(run, vcn, len, 0))
 		goto bad_inode;
 
 	if (mi_pack_runs(mi, attr, run, evcn1 + len - svcn))
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 86f825cf1c29..8ff49c5a2973 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -777,7 +777,7 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		    struct ATTRIB *attr);
 bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes);
 int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
-		 struct runs_tree *run, CLST len);
+		 const struct runs_tree *run, CLST len);
 static inline bool mi_is_ref(const struct mft_inode *mi,
 			     const struct MFT_REF *ref)
 {
@@ -812,7 +812,7 @@ void run_truncate_head(struct runs_tree *run, CLST vcn);
 void run_truncate_around(struct runs_tree *run, CLST vcn);
 bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
 		   bool is_mft);
-bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len);
+bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len, CLST sub);
 bool run_insert_range(struct runs_tree *run, CLST vcn, CLST len);
 bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
 		   CLST *lcn, CLST *len);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 714c7ecedca8..167093e8d287 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -621,7 +621,7 @@ bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes)
  * If failed record is not changed.
  */
 int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
-		 struct runs_tree *run, CLST len)
+		 const struct runs_tree *run, CLST len)
 {
 	int err = 0;
 	struct ntfs_sb_info *sbi = mi->sbi;
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 5df55e4adbb1..395b20492525 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -487,7 +487,7 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len,
  * Helper for attr_collapse_range(),
  * which is helper for fallocate(collapse_range).
  */
-bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
+bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len, CLST sub)
 {
 	size_t index, eat;
 	struct ntfs_run *r, *e, *eat_start, *eat_end;
@@ -511,7 +511,7 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 			/* Collapse a middle part of normal run, split. */
 			if (!run_add_entry(run, vcn, SPARSE_LCN, len, false))
 				return false;
-			return run_collapse_range(run, vcn, len);
+			return run_collapse_range(run, vcn, len, sub);
 		}
 
 		r += 1;
@@ -545,6 +545,13 @@ bool run_collapse_range(struct runs_tree *run, CLST vcn, CLST len)
 	memmove(eat_start, eat_end, (e - eat_end) * sizeof(*r));
 	run->count -= eat;
 
+	if (sub) {
+		e -= eat;
+		for (r = run->runs; r < e; r++) {
+			r->vcn -= sub;
+		}
+	}
+
 	return true;
 }
 
-- 
2.43.0


