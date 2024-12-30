Return-Path: <linux-fsdevel+bounces-38265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748669FE3F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 09:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F23E18827D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD5B1A23AC;
	Mon, 30 Dec 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="C4ZFTCz/";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="H3pplF7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C91A2389;
	Mon, 30 Dec 2024 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549099; cv=none; b=qEgxsgruHgah1dhQSxGYcsirPFuuKPInu3mggAxXCnRC+zhsh9Xb9NTCo2BYvYnOpXjcyjdhrp+VZl4+IBCpp6oy4TX54m/hemqQ5/GMB9JUjJ5kta5ISEJWHqvnLTPWclslIGhzRS3t6JuKEahf2T8ue4nvDkipSXGmANFQaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549099; c=relaxed/simple;
	bh=n3TCaSUBQMNk9VmAT5qs22bvHWsLoEBNGxNK+DHsToc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3zIInWQl+ElndYBBZYI/oDX+6PU3NnmTZgPQpgwWiclkv/m5acAE5Xz43Vc/n0SRodrdpAQ7hOALbKCri5/SPueDeFZ1aCV4B3d8Jc4cm5MuFA27xKDqiAtPjd5ybzlh+7+bqMi7bQwJZ5dL9g3Qt11bcuWlymasuP9cG7jHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=C4ZFTCz/; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=H3pplF7r; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 72E2E1FEA;
	Mon, 30 Dec 2024 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1735548661;
	bh=N8Bh5Cc0JmnUP5SB5gpUFuUhHJp04W9XvOM3AUvkC5M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=C4ZFTCz/c+EsvSITMO6+gJzHLgse/GunUWXfYt/LvXsrfMmie2okF0+nQsXloYoyI
	 NSdpxYALHXd7aOn30BZyWKULzjXDM4aqJi3yzcwsbPOz7TpfS/QBSgUOin8bYi2OO1
	 29Yc31Oz0u8YKi49vAgvmkIAmyutz/4sXjSXAIpc=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1409B1D6E;
	Mon, 30 Dec 2024 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1735548688;
	bh=N8Bh5Cc0JmnUP5SB5gpUFuUhHJp04W9XvOM3AUvkC5M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=H3pplF7r1oREDmEmKAjBelFE1roD5Ej2X/kUjsa66xHzB9DjYJwknMWi20wD3Mn8g
	 vmGkTIRfYAS5h3jH8jRrjYsESN42Vs0AOeLhJuoAPinI8iR6MgKzRON/iqQsOj+VMD
	 sg98gnO3ntxmYZWLa09g0D4BQfXqjrCrQUJ07htQ=
Received: from ntfs3vm.paragon-software.com (192.168.211.75) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 30 Dec 2024 11:51:27 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	<syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com>
Subject: [PATCH 1/2] fs/ntfs3: Mark inode as bad as soon as error detected in mi_enum_attr()
Date: Mon, 30 Dec 2024 11:51:15 +0300
Message-ID: <20241230085116.322824-2-almaz.alexandrovich@paragon-software.com>
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

Extended the `mi_enum_attr()` function interface with an additional
parameter, `struct ntfs_inode *ni`, to allow marking the inode
as bad as soon as an error is detected.

Reported-by: syzbot+73d8fc29ec7cba8286fa@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  | 11 ++++---
 fs/ntfs3/frecord.c | 59 ++++++++++++++++++----------------
 fs/ntfs3/ntfs_fs.h | 21 ++++++------
 fs/ntfs3/record.c  | 79 ++++++++++++++++++++++++----------------------
 4 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8d789b017fa9..795cf8e75d2e 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -787,7 +787,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		if (err)
 			goto out;
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len,
+				    &le->id);
 		if (!attr) {
 			err = -EINVAL;
 			goto bad_inode;
@@ -1181,7 +1182,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			goto out;
 		}
 
-		attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, &le->id);
+		attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0, &le->id);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
@@ -1796,7 +1797,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 				goto out;
 			}
 
-			attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0,
+			attr = mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0,
 					    &le->id);
 			if (!attr) {
 				err = -EINVAL;
@@ -2041,8 +2042,8 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 				}
 
 				/* Look for required attribute. */
-				attr = mi_find_attr(mi, NULL, ATTR_DATA, NULL,
-						    0, &le->id);
+				attr = mi_find_attr(ni, mi, NULL, ATTR_DATA,
+						    NULL, 0, &le->id);
 				if (!attr) {
 					err = -EINVAL;
 					goto out;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c57f0686b14b..b6be7dfafcbd 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -75,7 +75,7 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO)) :
 		      NULL;
 }
@@ -89,7 +89,7 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)
 {
 	const struct ATTRIB *attr;
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
 
 	return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
 		      NULL;
@@ -201,7 +201,8 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 			*mi = &ni->mi;
 
 		/* Look for required attribute in primary record. */
-		return mi_find_attr(&ni->mi, attr, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, attr, type, name, name_len,
+				    NULL);
 	}
 
 	/* First look for list entry of required type. */
@@ -217,7 +218,7 @@ struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
 		return NULL;
 
 	/* Look for required attribute. */
-	attr = mi_find_attr(m, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, m, NULL, type, name, name_len, &le->id);
 
 	if (!attr)
 		goto out;
@@ -259,7 +260,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		if (mi)
 			*mi = &ni->mi;
 		/* Enum attributes in primary record. */
-		return mi_enum_attr(&ni->mi, attr);
+		return mi_enum_attr(ni, &ni->mi, attr);
 	}
 
 	/* Get next list entry. */
@@ -275,7 +276,7 @@ struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
 		*mi = mi2;
 
 	/* Find attribute in loaded record. */
-	return rec_find_attr_le(mi2, le2);
+	return rec_find_attr_le(ni, mi2, le2);
 }
 
 /*
@@ -293,7 +294,8 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (!ni->attr_list.size) {
 		if (pmi)
 			*pmi = &ni->mi;
-		return mi_find_attr(&ni->mi, NULL, type, name, name_len, NULL);
+		return mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    NULL);
 	}
 
 	le = al_find_ex(ni, NULL, type, name, name_len, NULL);
@@ -319,7 +321,7 @@ struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	if (pmi)
 		*pmi = mi;
 
-	attr = mi_find_attr(mi, NULL, type, name, name_len, &le->id);
+	attr = mi_find_attr(ni, mi, NULL, type, name, name_len, &le->id);
 	if (!attr)
 		return NULL;
 
@@ -398,7 +400,8 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	int diff;
 
 	if (base_only || type == ATTR_LIST || !ni->attr_list.size) {
-		attr = mi_find_attr(&ni->mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, &ni->mi, NULL, type, name, name_len,
+				    id);
 		if (!attr)
 			return -ENOENT;
 
@@ -437,7 +440,7 @@ int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 		al_remove_le(ni, le);
 
-		attr = mi_find_attr(mi, NULL, type, name, name_len, id);
+		attr = mi_find_attr(ni, mi, NULL, type, name, name_len, id);
 		if (!attr)
 			return -ENOENT;
 
@@ -485,7 +488,7 @@ ni_ins_new_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		name = le->name;
 	}
 
-	attr = mi_insert_attr(mi, type, name, name_len, asize, name_off);
+	attr = mi_insert_attr(ni, mi, type, name, name_len, asize, name_off);
 	if (!attr) {
 		if (le_added)
 			al_remove_le(ni, le);
@@ -673,7 +676,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 	if (err)
 		return err;
 
-	attr_list = mi_find_attr(&ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
+	attr_list = mi_find_attr(ni, &ni->mi, NULL, ATTR_LIST, NULL, 0, NULL);
 	if (!attr_list)
 		return 0;
 
@@ -695,7 +698,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			return 0;
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			return 0;
@@ -731,7 +734,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 			goto out;
 		}
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr) {
 			/* Should never happened, 'cause already checked. */
@@ -740,7 +743,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 
 		/* Insert into primary record. */
-		attr_ins = mi_insert_attr(&ni->mi, le->type, le_name(le),
+		attr_ins = mi_insert_attr(ni, &ni->mi, le->type, le_name(le),
 					  le->name_len, asize,
 					  le16_to_cpu(attr->name_off));
 		if (!attr_ins) {
@@ -768,7 +771,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
 		if (!mi)
 			continue;
 
-		attr = mi_find_attr(mi, NULL, le->type, le_name(le),
+		attr = mi_find_attr(ni, mi, NULL, le->type, le_name(le),
 				    le->name_len, &le->id);
 		if (!attr)
 			continue;
@@ -831,7 +834,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	free_b = 0;
 	attr = NULL;
 
-	for (; (attr = mi_enum_attr(&ni->mi, attr)); le = Add2Ptr(le, sz)) {
+	for (; (attr = mi_enum_attr(ni, &ni->mi, attr)); le = Add2Ptr(le, sz)) {
 		sz = le_size(attr->name_len);
 		le->type = attr->type;
 		le->size = cpu_to_le16(sz);
@@ -886,7 +889,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 		u32 asize = le32_to_cpu(b->size);
 		u16 name_off = le16_to_cpu(b->name_off);
 
-		attr = mi_insert_attr(mi, b->type, Add2Ptr(b, name_off),
+		attr = mi_insert_attr(ni, mi, b->type, Add2Ptr(b, name_off),
 				      b->name_len, asize, name_off);
 		if (!attr)
 			goto out;
@@ -909,7 +912,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 			goto out;
 	}
 
-	attr = mi_insert_attr(&ni->mi, ATTR_LIST, NULL, 0,
+	attr = mi_insert_attr(ni, &ni->mi, ATTR_LIST, NULL, 0,
 			      lsize + SIZEOF_RESIDENT, SIZEOF_RESIDENT);
 	if (!attr)
 		goto out;
@@ -993,13 +996,13 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		mi = rb_entry(node, struct mft_inode, node);
 
 		if (is_mft_data &&
-		    (mi_enum_attr(mi, NULL) ||
+		    (mi_enum_attr(ni, mi, NULL) ||
 		     vbo <= ((u64)mi->rno << sbi->record_bits))) {
 			/* We can't accept this record 'cause MFT's bootstrapping. */
 			continue;
 		}
 		if (is_mft &&
-		    mi_find_attr(mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
+		    mi_find_attr(ni, mi, NULL, ATTR_DATA, NULL, 0, NULL)) {
 			/*
 			 * This child record already has a ATTR_DATA.
 			 * So it can't accept any other records.
@@ -1008,7 +1011,7 @@ static int ni_ins_attr_ext(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
 		}
 
 		if ((type != ATTR_NAME || name_len) &&
-		    mi_find_attr(mi, NULL, type, name, name_len, NULL)) {
+		    mi_find_attr(ni, mi, NULL, type, name, name_len, NULL)) {
 			/* Only indexed attributes can share same record. */
 			continue;
 		}
@@ -1157,7 +1160,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	/* Estimate the result of moving all possible attributes away. */
 	attr = NULL;
 
-	while ((attr = mi_enum_attr(&ni->mi, attr))) {
+	while ((attr = mi_enum_attr(ni, &ni->mi, attr))) {
 		if (attr->type == ATTR_STD)
 			continue;
 		if (attr->type == ATTR_LIST)
@@ -1175,7 +1178,7 @@ static int ni_insert_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(&ni->mi, attr);
+		attr = mi_enum_attr(ni, &ni->mi, attr);
 		if (!attr) {
 			/* We should never be here 'cause we have already check this case. */
 			err = -EINVAL;
@@ -1259,7 +1262,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 	for (node = rb_first(&ni->mi_tree); node; node = rb_next(node)) {
 		mi = rb_entry(node, struct mft_inode, node);
 
-		attr = mi_enum_attr(mi, NULL);
+		attr = mi_enum_attr(ni, mi, NULL);
 
 		if (!attr) {
 			mft_min = mi->rno;
@@ -1280,7 +1283,7 @@ static int ni_expand_mft_list(struct ntfs_inode *ni)
 		ni_remove_mi(ni, mi_new);
 	}
 
-	attr = mi_find_attr(&ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
+	attr = mi_find_attr(ni, &ni->mi, NULL, ATTR_DATA, NULL, 0, NULL);
 	if (!attr) {
 		err = -EINVAL;
 		goto out;
@@ -1397,7 +1400,7 @@ int ni_expand_list(struct ntfs_inode *ni)
 			continue;
 
 		/* Find attribute in primary record. */
-		attr = rec_find_attr_le(&ni->mi, le);
+		attr = rec_find_attr_le(ni, &ni->mi, le);
 		if (!attr) {
 			err = -EINVAL;
 			goto out;
@@ -3344,7 +3347,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		if (!mi->dirty)
 			continue;
 
-		is_empty = !mi_enum_attr(mi, NULL);
+		is_empty = !mi_enum_attr(ni, mi, NULL);
 
 		if (is_empty)
 			clear_rec_inuse(mi->mrec);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cd8e8374bb5a..382820464dee 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -745,23 +745,24 @@ int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
 void mi_put(struct mft_inode *mi);
 int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
 int mi_read(struct mft_inode *mi, bool is_mft);
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr);
-// TODO: id?
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    u8 name_len, const __le16 *id);
-static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr);
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, u8 name_len, const __le16 *id);
+static inline struct ATTRIB *rec_find_attr_le(struct ntfs_inode *ni,
+					      struct mft_inode *rec,
 					      struct ATTR_LIST_ENTRY *le)
 {
-	return mi_find_attr(rec, NULL, le->type, le_name(le), le->name_len,
+	return mi_find_attr(ni, rec, NULL, le->type, le_name(le), le->name_len,
 			    &le->id);
 }
 int mi_write(struct mft_inode *mi, int wait);
 int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
 		  __le16 flags, bool is_mft);
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off);
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off);
 
 bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 		    struct ATTRIB *attr);
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 61d53d39f3b9..714c7ecedca8 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -31,7 +31,7 @@ static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
  *
  * Return: Unused attribute id that is less than mrec->next_attr_id.
  */
-static __le16 mi_new_attt_id(struct mft_inode *mi)
+static __le16 mi_new_attt_id(struct ntfs_inode *ni, struct mft_inode *mi)
 {
 	u16 free_id, max_id, t16;
 	struct MFT_REC *rec = mi->mrec;
@@ -52,7 +52,7 @@ static __le16 mi_new_attt_id(struct mft_inode *mi)
 	attr = NULL;
 
 	for (;;) {
-		attr = mi_enum_attr(mi, attr);
+		attr = mi_enum_attr(ni, mi, attr);
 		if (!attr) {
 			rec->next_attr_id = cpu_to_le16(max_id + 1);
 			mi->dirty = true;
@@ -195,7 +195,8 @@ int mi_read(struct mft_inode *mi, bool is_mft)
  * NOTE: mi->mrec - memory of size sbi->record_size
  * here we sure that mi->mrec->total == sbi->record_size (see mi_read)
  */
-struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+struct ATTRIB *mi_enum_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
@@ -209,11 +210,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		off = le16_to_cpu(rec->attr_off);
 
 		if (used > total)
-			return NULL;
+			goto out;
 
 		if (off >= used || off < MFTRECORD_FIXUP_OFFSET_1 ||
 		    !IS_ALIGNED(off, 8)) {
-			return NULL;
+			goto out;
 		}
 
 		/* Skip non-resident records. */
@@ -243,7 +244,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	 */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
-		return NULL;
+		goto out;
 	}
 
 	if (attr->type == ATTR_END) {
@@ -254,112 +255,116 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
 	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
-		return NULL;
+		goto out;
 
 	/* attributes in record must be ordered by type */
 	if (t32 < prev_type)
-		return NULL;
+		goto out;
 
 	asize = le32_to_cpu(attr->size);
 
 	if (!IS_ALIGNED(asize, 8))
-		return NULL;
+		goto out;
 
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
-		return NULL;
+		goto out;
 
 	/* Can we use the field attr->non_res. */
 	if (off + 9 > used)
-		return NULL;
+		goto out;
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
 		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
-			return NULL;
+			goto out;
 
 		t16 = le16_to_cpu(attr->res.data_off);
 		if (t16 > asize)
-			return NULL;
+			goto out;
 
 		if (le32_to_cpu(attr->res.data_size) > asize - t16)
-			return NULL;
+			goto out;
 
 		t32 = sizeof(short) * attr->name_len;
 		if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
-			return NULL;
+			goto out;
 
 		return attr;
 	}
 
 	/* Check nonresident fields. */
 	if (attr->non_res != 1)
-		return NULL;
+		goto out;
 
 	/* Can we use memory including attr->nres.valid_size? */
 	if (asize < SIZEOF_NONRESIDENT)
-		return NULL;
+		goto out;
 
 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
-		return NULL;
+		goto out;
 
 	t32 = sizeof(short) * attr->name_len;
 	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
-		return NULL;
+		goto out;
 
 	/* Check start/end vcn. */
 	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
-		return NULL;
+		goto out;
 
 	data_size = le64_to_cpu(attr->nres.data_size);
 	if (le64_to_cpu(attr->nres.valid_size) > data_size)
-		return NULL;
+		goto out;
 
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (data_size > alloc_size)
-		return NULL;
+		goto out;
 
 	t32 = mi->sbi->cluster_mask;
 	if (alloc_size & t32)
-		return NULL;
+		goto out;
 
 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
 		/* Can we use memory including attr->nres.total_size? */
 		if (asize < SIZEOF_NONRESIDENT_EX)
-			return NULL;
+			goto out;
 
 		tot_size = le64_to_cpu(attr->nres.total_size);
 		if (tot_size & t32)
-			return NULL;
+			goto out;
 
 		if (tot_size > alloc_size)
-			return NULL;
+			goto out;
 	} else {
 		if (attr->nres.c_unit)
-			return NULL;
+			goto out;
 
 		if (alloc_size > mi->sbi->volume.size)
-			return NULL;
+			goto out;
 	}
 
 	return attr;
+
+out:
+	_ntfs_bad_inode(&ni->vfs_inode);
+	return NULL;
 }
 
 /*
  * mi_find_attr - Find the attribute by type and name and id.
  */
-struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
-			    enum ATTR_TYPE type, const __le16 *name,
-			    u8 name_len, const __le16 *id)
+struct ATTRIB *mi_find_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			    struct ATTRIB *attr, enum ATTR_TYPE type,
+			    const __le16 *name, u8 name_len, const __le16 *id)
 {
 	u32 type_in = le32_to_cpu(type);
 	u32 atype;
 
 next_attr:
-	attr = mi_enum_attr(mi, attr);
+	attr = mi_enum_attr(ni, mi, attr);
 	if (!attr)
 		return NULL;
 
@@ -467,9 +472,9 @@ int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
  *
  * Return: Not full constructed attribute or NULL if not possible to create.
  */
-struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
-			      const __le16 *name, u8 name_len, u32 asize,
-			      u16 name_off)
+struct ATTRIB *mi_insert_attr(struct ntfs_inode *ni, struct mft_inode *mi,
+			      enum ATTR_TYPE type, const __le16 *name,
+			      u8 name_len, u32 asize, u16 name_off)
 {
 	size_t tail;
 	struct ATTRIB *attr;
@@ -488,7 +493,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 	 * at which we should insert it.
 	 */
 	attr = NULL;
-	while ((attr = mi_enum_attr(mi, attr))) {
+	while ((attr = mi_enum_attr(ni, mi, attr))) {
 		int diff = compare_attr(attr, type, name, name_len, upcase);
 
 		if (diff < 0)
@@ -508,7 +513,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
 		tail = used - PtrOffset(rec, attr);
 	}
 
-	id = mi_new_attt_id(mi);
+	id = mi_new_attt_id(ni, mi);
 
 	memmove(Add2Ptr(attr, asize), attr, tail);
 	memset(attr, 0, asize);
-- 
2.34.1


