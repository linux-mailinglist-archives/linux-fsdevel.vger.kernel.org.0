Return-Path: <linux-fsdevel+bounces-66650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B3C2742C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 01:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BD83A7789
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 00:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9916118DF80;
	Sat,  1 Nov 2025 00:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="nES7K0yI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F92B2DA
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761956304; cv=none; b=UCwZjBFfrQOe+Y34TEqf/MuWZRdBVp3HAc60ieuFxhj+adQ00zsAuVvPEkQsOxmjiU8QS0gdnKCX7BEypaUDeAQIaNxpQxELajW58SO7mUkl3QSDY/rpq95Bg80GB/lZH93lrd9Xjr7FLLp+FPLYi/XnBGZ+ts2A4Y0koyROlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761956304; c=relaxed/simple;
	bh=I5soOLjY0geTO23YPRD36OHZMwEQEwLGCZlf1ra0Wwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LWaQRZZaC360cIN9DIHOupq3Z7qLjbD3Mfhz4eUFEKBBIndgJdYo8KwrMH1nE+UXju+BT7mVU510lG2nQMjfwPuh3XaVLMSt8N0TbQC5R1u9SBaFtc+lNnGiBd7XFLexlJY1fDUsaTN+zuIhVAKR5RXb6oGFC6sltnOqF8KkvlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=nES7K0yI; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63f9beb27b9so1114537d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1761956300; x=1762561100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTecMZ/K5OeguUGR8FPTjYHpYaGYRZ5NThhtWK1+Nmg=;
        b=nES7K0yIs7/mACe/HAhc+6l18FOl6zENHRK4dsIUfD8hKqBKRFc9sRajBuQZ4c8gBI
         6QP06PJDeXkO8r3AbFrUBD/BQPkUTrdyvjvw9MN0JjIwGWVPyzLnCYkYUTFhmk+FrAEj
         lPozrCKSsKZHi63unFZz9spKx2U88NwzT77v4GM/Seu4vn+nPjoZlX5tdhV5jEle6rWT
         XmeSZpUZ6LpGHe6YLnUfo6XrQ1SVBPk0fMNkXopqEvNgvcC3/Mk7cuz1E9piDnKi9EzF
         DSbE/H1wcJaJQjLJeABbQEe2xr5jZODX6a+MW2rkE/A7dSbZsUinz46UxN8XCOe2SleB
         smdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761956300; x=1762561100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTecMZ/K5OeguUGR8FPTjYHpYaGYRZ5NThhtWK1+Nmg=;
        b=flUgywamPK+tE86K/PeooBfKnrnyWyMWIeyLHzODvmu7hf+EkF/9zCNodM78n57C6J
         K0rORyE+9DSQ9khJAbooajeor9zZr2wKa8xyrWqsLakJwgNaC2xX6/toSx2fWxj0MAH7
         tSEKyGnveKLySIaMkrHECgceby3HC4RxlwNTx+UoQClwlLlQPi79uU3fftYQ32cyaCnE
         FQr9TLuIC+rShBb6JVHo9zDZIPW+ahEpStyCedNCIsLsclbjD5gnjV+uZXRGfCIHC2KA
         JOYmptFpMi9U3vAnvvrD1u7+RcrcQyGAjMZE+TImAltPKv6+cRAKM9XB7hR+gFkcG3Py
         VfVA==
X-Forwarded-Encrypted: i=1; AJvYcCVspYenLx69bZuymdYWiNF+5ICjGykpcQ0ppGmmyX027uetF/4zD5TekB7kxXonJ4f9wuns+a+zDPZFkpNr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/trDH/+Qu3dPhdNqH4nwal7I34YjiY2nND8erDZaQaSKys3Ad
	1mEo31HhcJ58kt0gsFlxFgQp8QuzNF8w6JbBtwRcN5Ekmage99agGaJ6ZqGECSjzEiU=
X-Gm-Gg: ASbGncuCaIrz8fqgTKVoTAVvsP7tnegwww+duvLvpxbGc9ARCQggQazB5PK+Qb839yj
	N1ZOZdyl4VxJYQSVNNau1DTKW+EqEic2RNsgwGUIWo+uvzlbMCBqy7fmZF1RU3Df430R+LaJG+G
	JIqVVsWGPbRP981lpMMWs0UAhYkSNv9ioB2RpXrwWmyXsgRKOpUvK8han5egs4LkWP7PyWpAcQf
	87wYzeAQFbZyudJ11xKm3Fh2vlabpZYn0/j2NufoPX0T/8nX2ya/EM+BzW2N3vnomcf2Z9HeSpj
	rWTqKpn+FU0/+qLs6JDmY54asVcMM87BA8BxpYpOLlL+I9EQVEQ0QuNiOt1Gya4eRaKbNyag5iD
	usYgw3VVfLqw4mo2ecKEc0PvqOCg7as0X/77/TZlEvUmvooEgCTULhncdI5lO8V3gem+Kjg9lOw
	ons4/ENMiD67s8zGc53zVqvA==
X-Google-Smtp-Source: AGHT+IGBMR/tLmC6GCWAxlbzL9a4TlaY87J09GEeB61mJa7Nsql1D/Kl+rIEsnKOWKPi/8sgEvkzjA==
X-Received: by 2002:a05:690e:2512:10b0:63f:9b93:fda4 with SMTP id 956f58d0204a3-63f9b9401ebmr2242653d50.22.1761956300065;
        Fri, 31 Oct 2025 17:18:20 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6a77:8f32:2919:3a8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f96a50f2esm895877d50.15.2025.10.31.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 17:18:19 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs/hfsplus: move on-disk layout declarations into hfs_common.h
Date: Fri, 31 Oct 2025 17:17:45 -0700
Message-Id: <20251101001744.247658-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, HFS declares on-disk layout's metadata structures
in fs/hfs/hfs.h and HFS+ declares it in fs/hfsplus/hfsplus_raw.h.
However, HFS and HFS+ on-disk layouts have some similarity and
overlapping in declarations. As a result, fs/hfs/hfs.h and
fs/hfsplus/hfsplus_raw.h contain multiple duplicated declarations.
Moreover, both HFS and HFS+ drivers contain completely similar
implemented functionality in multiple places.

This patch is moving the on-disk layout declarations from
fs/hfs/hfs.h and fs/hfsplus/hfsplus_raw.h into
include/linux/hfs_common.h with the goal to exclude
the duplication in declarations. Also, this patch prepares
the basis for creating a hfslib that can aggregate common
functionality without necessity to duplicate the same code
in HFS and HFS+ drivers.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/btree.h             |  42 ---
 fs/hfs/hfs.h               | 269 +---------------
 fs/hfs/hfs_fs.h            |   1 -
 fs/hfsplus/hfsplus_fs.h    |   1 -
 fs/hfsplus/hfsplus_raw.h   | 394 +----------------------
 fs/hfsplus/xattr.c         |  22 +-
 include/linux/hfs_common.h | 633 +++++++++++++++++++++++++++++++++++++
 7 files changed, 645 insertions(+), 717 deletions(-)

diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 0e6baee93245..527cc028ada4 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -128,45 +128,3 @@ extern int __hfs_brec_find(struct hfs_bnode *, struct hfs_find_data *);
 extern int hfs_brec_find(struct hfs_find_data *);
 extern int hfs_brec_read(struct hfs_find_data *, void *, int);
 extern int hfs_brec_goto(struct hfs_find_data *, int);
-
-
-struct hfs_bnode_desc {
-	__be32 next;		/* (V) Number of the next node at this level */
-	__be32 prev;		/* (V) Number of the prev node at this level */
-	u8 type;		/* (F) The type of node */
-	u8 height;		/* (F) The level of this node (leaves=1) */
-	__be16 num_recs;	/* (V) The number of records in this node */
-	u16 reserved;
-} __packed;
-
-#define HFS_NODE_INDEX	0x00	/* An internal (index) node */
-#define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
-#define HFS_NODE_MAP	0x02	/* Holds part of the bitmap of used nodes */
-#define HFS_NODE_LEAF	0xFF	/* A leaf (ndNHeight==1) node */
-
-struct hfs_btree_header_rec {
-	__be16 depth;		/* (V) The number of levels in this B-tree */
-	__be32 root;		/* (V) The node number of the root node */
-	__be32 leaf_count;	/* (V) The number of leaf records */
-	__be32 leaf_head;	/* (V) The number of the first leaf node */
-	__be32 leaf_tail;	/* (V) The number of the last leaf node */
-	__be16 node_size;	/* (F) The number of bytes in a node (=512) */
-	__be16 max_key_len;	/* (F) The length of a key in an index node */
-	__be32 node_count;	/* (V) The total number of nodes */
-	__be32 free_nodes;	/* (V) The number of unused nodes */
-	u16 reserved1;
-	__be32 clump_size;	/* (F) clump size. not usually used. */
-	u8 btree_type;		/* (F) BTree type */
-	u8 reserved2;
-	__be32 attributes;	/* (F) attributes */
-	u32 reserved3[16];
-} __packed;
-
-#define BTREE_ATTR_BADCLOSE	0x00000001	/* b-tree not closed properly. not
-						   used by hfsplus. */
-#define HFS_TREE_BIGKEYS	0x00000002	/* key length is u16 instead of u8.
-						   used by hfsplus. */
-#define HFS_TREE_VARIDXKEYS	0x00000004	/* variable key length instead of
-						   max key length. use din catalog
-						   b-tree but not in extents
-						   b-tree (hfsplus). */
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 6f194d0768b6..3f2293ff6fdd 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -9,274 +9,7 @@
 #ifndef _HFS_H
 #define _HFS_H
 
-/* offsets to various blocks */
-#define HFS_DD_BLK		0 /* Driver Descriptor block */
-#define HFS_PMAP_BLK		1 /* First block of partition map */
-#define HFS_MDB_BLK		2 /* Block (w/i partition) of MDB */
-
-/* magic numbers for various disk blocks */
-#define HFS_DRVR_DESC_MAGIC	0x4552 /* "ER": driver descriptor map */
-#define HFS_OLD_PMAP_MAGIC	0x5453 /* "TS": old-type partition map */
-#define HFS_NEW_PMAP_MAGIC	0x504D /* "PM": new-type partition map */
-#define HFS_SUPER_MAGIC		0x4244 /* "BD": HFS MDB (super block) */
-#define HFS_MFS_SUPER_MAGIC	0xD2D7 /* MFS MDB (super block) */
-
-/* various FIXED size parameters */
-#define HFS_SECTOR_SIZE		512    /* size of an HFS sector */
-#define HFS_SECTOR_SIZE_BITS	9      /* log_2(HFS_SECTOR_SIZE) */
-#define HFS_NAMELEN		31     /* maximum length of an HFS filename */
-#define HFS_MAX_NAMELEN		128
-#define HFS_MAX_VALENCE		32767U
-
-/* Meanings of the drAtrb field of the MDB,
- * Reference: _Inside Macintosh: Files_ p. 2-61
- */
-#define HFS_SB_ATTRIB_HLOCK	(1 << 7)
-#define HFS_SB_ATTRIB_UNMNT	(1 << 8)
-#define HFS_SB_ATTRIB_SPARED	(1 << 9)
-#define HFS_SB_ATTRIB_INCNSTNT	(1 << 11)
-#define HFS_SB_ATTRIB_SLOCK	(1 << 15)
-
-/* Some special File ID numbers */
-#define HFS_POR_CNID		1	/* Parent Of the Root */
-#define HFS_ROOT_CNID		2	/* ROOT directory */
-#define HFS_EXT_CNID		3	/* EXTents B-tree */
-#define HFS_CAT_CNID		4	/* CATalog B-tree */
-#define HFS_BAD_CNID		5	/* BAD blocks file */
-#define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
-#define HFS_START_CNID		7	/* STARTup file (HFS+) */
-#define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */
-#define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */
-#define HFS_FIRSTUSER_CNID	16
-
-/* values for hfs_cat_rec.cdrType */
-#define HFS_CDR_DIR    0x01    /* folder (directory) */
-#define HFS_CDR_FIL    0x02    /* file */
-#define HFS_CDR_THD    0x03    /* folder (directory) thread */
-#define HFS_CDR_FTH    0x04    /* file thread */
-
-/* legal values for hfs_ext_key.FkType and hfs_file.fork */
-#define HFS_FK_DATA	0x00
-#define HFS_FK_RSRC	0xFF
-
-/* bits in hfs_fil_entry.Flags */
-#define HFS_FIL_LOCK	0x01  /* locked */
-#define HFS_FIL_THD	0x02  /* file thread */
-#define HFS_FIL_DOPEN   0x04  /* data fork open */
-#define HFS_FIL_ROPEN   0x08  /* resource fork open */
-#define HFS_FIL_DIR     0x10  /* directory (always clear) */
-#define HFS_FIL_NOCOPY  0x40  /* copy-protected file */
-#define HFS_FIL_USED	0x80  /* open */
-
-/* bits in hfs_dir_entry.Flags. dirflags is 16 bits. */
-#define HFS_DIR_LOCK        0x01  /* locked */
-#define HFS_DIR_THD         0x02  /* directory thread */
-#define HFS_DIR_INEXPFOLDER 0x04  /* in a shared area */
-#define HFS_DIR_MOUNTED     0x08  /* mounted */
-#define HFS_DIR_DIR         0x10  /* directory (always set) */
-#define HFS_DIR_EXPFOLDER   0x20  /* share point */
-
-/* bits hfs_finfo.fdFlags */
-#define HFS_FLG_INITED		0x0100
-#define HFS_FLG_LOCKED		0x1000
-#define HFS_FLG_INVISIBLE	0x4000
-
-/*======== HFS structures as they appear on the disk ========*/
-
-/* Pascal-style string of up to 31 characters */
-struct hfs_name {
-	u8 len;
-	u8 name[HFS_NAMELEN];
-} __packed;
-
-struct hfs_point {
-	__be16 v;
-	__be16 h;
-} __packed;
-
-struct hfs_rect {
-	__be16 top;
-	__be16 left;
-	__be16 bottom;
-	__be16 right;
-} __packed;
-
-struct hfs_finfo {
-	__be32 fdType;
-	__be32 fdCreator;
-	__be16 fdFlags;
-	struct hfs_point fdLocation;
-	__be16 fdFldr;
-} __packed;
-
-struct hfs_fxinfo {
-	__be16 fdIconID;
-	u8 fdUnused[8];
-	__be16 fdComment;
-	__be32 fdPutAway;
-} __packed;
-
-struct hfs_dinfo {
-	struct hfs_rect frRect;
-	__be16 frFlags;
-	struct hfs_point frLocation;
-	__be16 frView;
-} __packed;
-
-struct hfs_dxinfo {
-	struct hfs_point frScroll;
-	__be32 frOpenChain;
-	__be16 frUnused;
-	__be16 frComment;
-	__be32 frPutAway;
-} __packed;
-
-union hfs_finder_info {
-	struct {
-		struct hfs_finfo finfo;
-		struct hfs_fxinfo fxinfo;
-	} file;
-	struct {
-		struct hfs_dinfo dinfo;
-		struct hfs_dxinfo dxinfo;
-	} dir;
-} __packed;
-
-/* Cast to a pointer to a generic bkey */
-#define	HFS_BKEY(X)	(((void)((X)->KeyLen)), ((struct hfs_bkey *)(X)))
-
-/* The key used in the catalog b-tree: */
-struct hfs_cat_key {
-	u8 key_len;		/* number of bytes in the key */
-	u8 reserved;		/* padding */
-	__be32 ParID;		/* CNID of the parent dir */
-	struct hfs_name	CName;	/* The filename of the entry */
-} __packed;
-
-/* The key used in the extents b-tree: */
-struct hfs_ext_key {
-	u8 key_len;		/* number of bytes in the key */
-	u8 FkType;		/* HFS_FK_{DATA,RSRC} */
-	__be32 FNum;		/* The File ID of the file */
-	__be16 FABN;		/* allocation blocks number*/
-} __packed;
-
-typedef union hfs_btree_key {
-	u8 key_len;			/* number of bytes in the key */
-	struct hfs_cat_key cat;
-	struct hfs_ext_key ext;
-} hfs_btree_key;
-
-#define HFS_MAX_CAT_KEYLEN	(sizeof(struct hfs_cat_key) - sizeof(u8))
-#define HFS_MAX_EXT_KEYLEN	(sizeof(struct hfs_ext_key) - sizeof(u8))
-
-typedef union hfs_btree_key btree_key;
-
-struct hfs_extent {
-	__be16 block;
-	__be16 count;
-};
-typedef struct hfs_extent hfs_extent_rec[3];
-
-/* The catalog record for a file */
-struct hfs_cat_file {
-	s8 type;			/* The type of entry */
-	u8 reserved;
-	u8 Flags;			/* Flags such as read-only */
-	s8 Typ;				/* file version number = 0 */
-	struct hfs_finfo UsrWds;	/* data used by the Finder */
-	__be32 FlNum;			/* The CNID */
-	__be16 StBlk;			/* obsolete */
-	__be32 LgLen;			/* The logical EOF of the data fork*/
-	__be32 PyLen;			/* The physical EOF of the data fork */
-	__be16 RStBlk;			/* obsolete */
-	__be32 RLgLen;			/* The logical EOF of the rsrc fork */
-	__be32 RPyLen;			/* The physical EOF of the rsrc fork */
-	__be32 CrDat;			/* The creation date */
-	__be32 MdDat;			/* The modified date */
-	__be32 BkDat;			/* The last backup date */
-	struct hfs_fxinfo FndrInfo;	/* more data for the Finder */
-	__be16 ClpSize;			/* number of bytes to allocate
-					   when extending files */
-	hfs_extent_rec ExtRec;		/* first extent record
-					   for the data fork */
-	hfs_extent_rec RExtRec;		/* first extent record
-					   for the resource fork */
-	u32 Resrv;			/* reserved by Apple */
-} __packed;
-
-/* the catalog record for a directory */
-struct hfs_cat_dir {
-	s8 type;			/* The type of entry */
-	u8 reserved;
-	__be16 Flags;			/* flags */
-	__be16 Val;			/* Valence: number of files and
-					   dirs in the directory */
-	__be32 DirID;			/* The CNID */
-	__be32 CrDat;			/* The creation date */
-	__be32 MdDat;			/* The modification date */
-	__be32 BkDat;			/* The last backup date */
-	struct hfs_dinfo UsrInfo;	/* data used by the Finder */
-	struct hfs_dxinfo FndrInfo;	/* more data used by Finder */
-	u8 Resrv[16];			/* reserved by Apple */
-} __packed;
-
-/* the catalog record for a thread */
-struct hfs_cat_thread {
-	s8 type;			/* The type of entry */
-	u8 reserved[9];			/* reserved by Apple */
-	__be32 ParID;			/* CNID of parent directory */
-	struct hfs_name CName;		/* The name of this entry */
-}  __packed;
-
-/* A catalog tree record */
-typedef union hfs_cat_rec {
-	s8 type;			/* The type of entry */
-	struct hfs_cat_file file;
-	struct hfs_cat_dir dir;
-	struct hfs_cat_thread thread;
-} hfs_cat_rec;
-
-struct hfs_mdb {
-	__be16 drSigWord;		/* Signature word indicating fs type */
-	__be32 drCrDate;		/* fs creation date/time */
-	__be32 drLsMod;			/* fs modification date/time */
-	__be16 drAtrb;			/* fs attributes */
-	__be16 drNmFls;			/* number of files in root directory */
-	__be16 drVBMSt;			/* location (in 512-byte blocks)
-					   of the volume bitmap */
-	__be16 drAllocPtr;		/* location (in allocation blocks)
-					   to begin next allocation search */
-	__be16 drNmAlBlks;		/* number of allocation blocks */
-	__be32 drAlBlkSiz;		/* bytes in an allocation block */
-	__be32 drClpSiz;		/* clumpsize, the number of bytes to
-					   allocate when extending a file */
-	__be16 drAlBlSt;		/* location (in 512-byte blocks)
-					   of the first allocation block */
-	__be32 drNxtCNID;		/* CNID to assign to the next
-					   file or directory created */
-	__be16 drFreeBks;		/* number of free allocation blocks */
-	u8 drVN[28];			/* the volume label */
-	__be32 drVolBkUp;		/* fs backup date/time */
-	__be16 drVSeqNum;		/* backup sequence number */
-	__be32 drWrCnt;			/* fs write count */
-	__be32 drXTClpSiz;		/* clumpsize for the extents B-tree */
-	__be32 drCTClpSiz;		/* clumpsize for the catalog B-tree */
-	__be16 drNmRtDirs;		/* number of directories in
-					   the root directory */
-	__be32 drFilCnt;		/* number of files in the fs */
-	__be32 drDirCnt;		/* number of directories in the fs */
-	u8 drFndrInfo[32];		/* data used by the Finder */
-	__be16 drEmbedSigWord;		/* embedded volume signature */
-	__be32 drEmbedExtent;		/* starting block number (xdrStABN)
-					   and number of allocation blocks
-					   (xdrNumABlks) occupied by embedded
-					   volume */
-	__be32 drXTFlSize;		/* bytes in the extents B-tree */
-	hfs_extent_rec drXTExtRec;	/* extents B-tree's first 3 extents */
-	__be32 drCTFlSize;		/* bytes in the catalog B-tree */
-	hfs_extent_rec drCTExtRec;	/* catalog B-tree's first 3 extents */
-} __packed;
+#include <linux/hfs_common.h>
 
 /*======== Data structures kept in memory ========*/
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index fff149af89da..505c03e40674 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -18,7 +18,6 @@
 
 #include <asm/byteorder.h>
 #include <linux/uaccess.h>
-#include <linux/hfs_common.h>
 
 #include "hfs.h"
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 89e8b19c127b..c4440787e04d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -16,7 +16,6 @@
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
-#include <linux/hfs_common.h>
 #include "hfsplus_raw.h"
 
 /* Runtime config options */
diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 68b4240c6191..83b5dbde924b 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -15,398 +15,6 @@
 #define _LINUX_HFSPLUS_RAW_H
 
 #include <linux/types.h>
-
-/* Some constants */
-#define HFSPLUS_SECTOR_SIZE        512
-#define HFSPLUS_SECTOR_SHIFT         9
-#define HFSPLUS_VOLHEAD_SECTOR       2
-#define HFSPLUS_VOLHEAD_SIG     0x482b
-#define HFSPLUS_VOLHEAD_SIGX    0x4858
-#define HFSPLUS_SUPER_MAGIC     0x482b
-#define HFSPLUS_MIN_VERSION          4
-#define HFSPLUS_CURRENT_VERSION      5
-
-#define HFSP_WRAP_MAGIC         0x4244
-#define HFSP_WRAP_ATTRIB_SLOCK  0x8000
-#define HFSP_WRAP_ATTRIB_SPARED 0x0200
-
-#define HFSP_WRAPOFF_SIG          0x00
-#define HFSP_WRAPOFF_ATTRIB       0x0A
-#define HFSP_WRAPOFF_ABLKSIZE     0x14
-#define HFSP_WRAPOFF_ABLKSTART    0x1C
-#define HFSP_WRAPOFF_EMBEDSIG     0x7C
-#define HFSP_WRAPOFF_EMBEDEXT     0x7E
-
-#define HFSP_HIDDENDIR_NAME \
-	"\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80HFS+ Private Data"
-
-#define HFSP_HARDLINK_TYPE	0x686c6e6b	/* 'hlnk' */
-#define HFSP_HFSPLUS_CREATOR	0x6866732b	/* 'hfs+' */
-
-#define HFSP_SYMLINK_TYPE	0x736c6e6b	/* 'slnk' */
-#define HFSP_SYMLINK_CREATOR	0x72686170	/* 'rhap' */
-
-#define HFSP_MOUNT_VERSION	0x482b4c78	/* 'H+Lx' */
-
-/* Structures used on disk */
-
-typedef __be32 hfsplus_cnid;
-typedef __be16 hfsplus_unichr;
-
-#define HFSPLUS_MAX_STRLEN 255
-#define HFSPLUS_ATTR_MAX_STRLEN 127
-
-/* A "string" as used in filenames, etc. */
-struct hfsplus_unistr {
-	__be16 length;
-	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
-} __packed;
-
-/*
- * A "string" is used in attributes file
- * for name of extended attribute
- */
-struct hfsplus_attr_unistr {
-	__be16 length;
-	hfsplus_unichr unicode[HFSPLUS_ATTR_MAX_STRLEN];
-} __packed;
-
-/* POSIX permissions */
-struct hfsplus_perm {
-	__be32 owner;
-	__be32 group;
-	u8  rootflags;
-	u8  userflags;
-	__be16 mode;
-	__be32 dev;
-} __packed;
-
-#define HFSPLUS_FLG_NODUMP	0x01
-#define HFSPLUS_FLG_IMMUTABLE	0x02
-#define HFSPLUS_FLG_APPEND	0x04
-
-/* A single contiguous area of a file */
-struct hfsplus_extent {
-	__be32 start_block;
-	__be32 block_count;
-} __packed;
-typedef struct hfsplus_extent hfsplus_extent_rec[8];
-
-/* Information for a "Fork" in a file */
-struct hfsplus_fork_raw {
-	__be64 total_size;
-	__be32 clump_size;
-	__be32 total_blocks;
-	hfsplus_extent_rec extents;
-} __packed;
-
-/* HFS+ Volume Header */
-struct hfsplus_vh {
-	__be16 signature;
-	__be16 version;
-	__be32 attributes;
-	__be32 last_mount_vers;
-	u32 reserved;
-
-	__be32 create_date;
-	__be32 modify_date;
-	__be32 backup_date;
-	__be32 checked_date;
-
-	__be32 file_count;
-	__be32 folder_count;
-
-	__be32 blocksize;
-	__be32 total_blocks;
-	__be32 free_blocks;
-
-	__be32 next_alloc;
-	__be32 rsrc_clump_sz;
-	__be32 data_clump_sz;
-	hfsplus_cnid next_cnid;
-
-	__be32 write_count;
-	__be64 encodings_bmp;
-
-	u32 finder_info[8];
-
-	struct hfsplus_fork_raw alloc_file;
-	struct hfsplus_fork_raw ext_file;
-	struct hfsplus_fork_raw cat_file;
-	struct hfsplus_fork_raw attr_file;
-	struct hfsplus_fork_raw start_file;
-} __packed;
-
-/* HFS+ volume attributes */
-#define HFSPLUS_VOL_UNMNT		(1 << 8)
-#define HFSPLUS_VOL_SPARE_BLK		(1 << 9)
-#define HFSPLUS_VOL_NOCACHE		(1 << 10)
-#define HFSPLUS_VOL_INCNSTNT		(1 << 11)
-#define HFSPLUS_VOL_NODEID_REUSED	(1 << 12)
-#define HFSPLUS_VOL_JOURNALED		(1 << 13)
-#define HFSPLUS_VOL_SOFTLOCK		(1 << 15)
-#define HFSPLUS_VOL_UNUSED_NODE_FIX	(1 << 31)
-
-/* HFS+ BTree node descriptor */
-struct hfs_bnode_desc {
-	__be32 next;
-	__be32 prev;
-	s8 type;
-	u8 height;
-	__be16 num_recs;
-	u16 reserved;
-} __packed;
-
-/* HFS+ BTree node types */
-#define HFS_NODE_INDEX	0x00	/* An internal (index) node */
-#define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
-#define HFS_NODE_MAP	0x02	/* Holds part of the bitmap of used nodes */
-#define HFS_NODE_LEAF	0xFF	/* A leaf (ndNHeight==1) node */
-
-/* HFS+ BTree header */
-struct hfs_btree_header_rec {
-	__be16 depth;
-	__be32 root;
-	__be32 leaf_count;
-	__be32 leaf_head;
-	__be32 leaf_tail;
-	__be16 node_size;
-	__be16 max_key_len;
-	__be32 node_count;
-	__be32 free_nodes;
-	u16 reserved1;
-	__be32 clump_size;
-	u8 btree_type;
-	u8 key_type;
-	__be32 attributes;
-	u32 reserved3[16];
-} __packed;
-
-/* BTree attributes */
-#define HFS_TREE_BIGKEYS	2
-#define HFS_TREE_VARIDXKEYS	4
-
-/* HFS+ BTree misc info */
-#define HFSPLUS_TREE_HEAD 0
-#define HFSPLUS_NODE_MXSZ 32768
-#define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
-#define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
-#define HFSPLUS_BTREE_HDR_USER_BYTES		128
-
-/* Some special File ID numbers (stolen from hfs.h) */
-#define HFSPLUS_POR_CNID		1	/* Parent Of the Root */
-#define HFSPLUS_ROOT_CNID		2	/* ROOT directory */
-#define HFSPLUS_EXT_CNID		3	/* EXTents B-tree */
-#define HFSPLUS_CAT_CNID		4	/* CATalog B-tree */
-#define HFSPLUS_BAD_CNID		5	/* BAD blocks file */
-#define HFSPLUS_ALLOC_CNID		6	/* ALLOCation file */
-#define HFSPLUS_START_CNID		7	/* STARTup file */
-#define HFSPLUS_ATTR_CNID		8	/* ATTRibutes file */
-#define HFSPLUS_EXCH_CNID		15	/* ExchangeFiles temp id */
-#define HFSPLUS_FIRSTUSER_CNID		16	/* first available user id */
-
-/* btree key type */
-#define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
-#define HFSPLUS_KEY_BINARY		0xBC	/* case-sensitive */
-
-/* HFS+ catalog entry key */
-struct hfsplus_cat_key {
-	__be16 key_len;
-	hfsplus_cnid parent;
-	struct hfsplus_unistr name;
-} __packed;
-
-#define HFSPLUS_CAT_KEYLEN	(sizeof(struct hfsplus_cat_key))
-
-/* Structs from hfs.h */
-struct hfsp_point {
-	__be16 v;
-	__be16 h;
-} __packed;
-
-struct hfsp_rect {
-	__be16 top;
-	__be16 left;
-	__be16 bottom;
-	__be16 right;
-} __packed;
-
-
-/* HFS directory info (stolen from hfs.h */
-struct DInfo {
-	struct hfsp_rect frRect;
-	__be16 frFlags;
-	struct hfsp_point frLocation;
-	__be16 frView;
-} __packed;
-
-struct DXInfo {
-	struct hfsp_point frScroll;
-	__be32 frOpenChain;
-	__be16 frUnused;
-	__be16 frComment;
-	__be32 frPutAway;
-} __packed;
-
-/* HFS+ folder data (part of an hfsplus_cat_entry) */
-struct hfsplus_cat_folder {
-	__be16 type;
-	__be16 flags;
-	__be32 valence;
-	hfsplus_cnid id;
-	__be32 create_date;
-	__be32 content_mod_date;
-	__be32 attribute_mod_date;
-	__be32 access_date;
-	__be32 backup_date;
-	struct hfsplus_perm permissions;
-	struct_group_attr(info, __packed,
-		struct DInfo user_info;
-		struct DXInfo finder_info;
-	);
-	__be32 text_encoding;
-	__be32 subfolders;	/* Subfolder count in HFSX. Reserved in HFS+. */
-} __packed;
-
-/* HFS file info (stolen from hfs.h) */
-struct FInfo {
-	__be32 fdType;
-	__be32 fdCreator;
-	__be16 fdFlags;
-	struct hfsp_point fdLocation;
-	__be16 fdFldr;
-} __packed;
-
-struct FXInfo {
-	__be16 fdIconID;
-	u8 fdUnused[8];
-	__be16 fdComment;
-	__be32 fdPutAway;
-} __packed;
-
-/* HFS+ file data (part of a cat_entry) */
-struct hfsplus_cat_file {
-	__be16 type;
-	__be16 flags;
-	u32 reserved1;
-	hfsplus_cnid id;
-	__be32 create_date;
-	__be32 content_mod_date;
-	__be32 attribute_mod_date;
-	__be32 access_date;
-	__be32 backup_date;
-	struct hfsplus_perm permissions;
-	struct_group_attr(info, __packed,
-		struct FInfo user_info;
-		struct FXInfo finder_info;
-	);
-	__be32 text_encoding;
-	u32 reserved2;
-
-	struct hfsplus_fork_raw data_fork;
-	struct hfsplus_fork_raw rsrc_fork;
-} __packed;
-
-/* File and folder flag bits */
-#define HFSPLUS_FILE_LOCKED		0x0001
-#define HFSPLUS_FILE_THREAD_EXISTS	0x0002
-#define HFSPLUS_XATTR_EXISTS		0x0004
-#define HFSPLUS_ACL_EXISTS		0x0008
-#define HFSPLUS_HAS_FOLDER_COUNT	0x0010	/* Folder has subfolder count
-						 * (HFSX only) */
-
-/* HFS+ catalog thread (part of a cat_entry) */
-struct hfsplus_cat_thread {
-	__be16 type;
-	s16 reserved;
-	hfsplus_cnid parentID;
-	struct hfsplus_unistr nodeName;
-} __packed;
-
-#define HFSPLUS_MIN_THREAD_SZ 10
-
-/* A data record in the catalog tree */
-typedef union {
-	__be16 type;
-	struct hfsplus_cat_folder folder;
-	struct hfsplus_cat_file file;
-	struct hfsplus_cat_thread thread;
-} __packed hfsplus_cat_entry;
-
-/* HFS+ catalog entry type */
-#define HFSPLUS_FOLDER         0x0001
-#define HFSPLUS_FILE           0x0002
-#define HFSPLUS_FOLDER_THREAD  0x0003
-#define HFSPLUS_FILE_THREAD    0x0004
-
-/* HFS+ extents tree key */
-struct hfsplus_ext_key {
-	__be16 key_len;
-	u8 fork_type;
-	u8 pad;
-	hfsplus_cnid cnid;
-	__be32 start_block;
-} __packed;
-
-#define HFSPLUS_EXT_KEYLEN	sizeof(struct hfsplus_ext_key)
-
-#define HFSPLUS_XATTR_FINDER_INFO_NAME "com.apple.FinderInfo"
-#define HFSPLUS_XATTR_ACL_NAME "com.apple.system.Security"
-
-#define HFSPLUS_ATTR_INLINE_DATA 0x10
-#define HFSPLUS_ATTR_FORK_DATA   0x20
-#define HFSPLUS_ATTR_EXTENTS     0x30
-
-/* HFS+ attributes tree key */
-struct hfsplus_attr_key {
-	__be16 key_len;
-	__be16 pad;
-	hfsplus_cnid cnid;
-	__be32 start_block;
-	struct hfsplus_attr_unistr key_name;
-} __packed;
-
-#define HFSPLUS_ATTR_KEYLEN	sizeof(struct hfsplus_attr_key)
-
-/* HFS+ fork data attribute */
-struct hfsplus_attr_fork_data {
-	__be32 record_type;
-	__be32 reserved;
-	struct hfsplus_fork_raw the_fork;
-} __packed;
-
-/* HFS+ extension attribute */
-struct hfsplus_attr_extents {
-	__be32 record_type;
-	__be32 reserved;
-	struct hfsplus_extent extents;
-} __packed;
-
-#define HFSPLUS_MAX_INLINE_DATA_SIZE 3802
-
-/* HFS+ attribute inline data */
-struct hfsplus_attr_inline_data {
-	__be32 record_type;
-	__be32 reserved1;
-	u8 reserved2[6];
-	__be16 length;
-	u8 raw_bytes[HFSPLUS_MAX_INLINE_DATA_SIZE];
-} __packed;
-
-/* A data record in the attributes tree */
-typedef union {
-	__be32 record_type;
-	struct hfsplus_attr_fork_data fork_data;
-	struct hfsplus_attr_extents extents;
-	struct hfsplus_attr_inline_data inline_data;
-} __packed hfsplus_attr_entry;
-
-/* HFS+ generic BTree key */
-typedef union {
-	__be16 key_len;
-	struct hfsplus_cat_key cat;
-	struct hfsplus_ext_key ext;
-	struct hfsplus_attr_key attr;
-} __packed hfsplus_btree_key;
+#include <linux/hfs_common.h>
 
 #endif
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index ece4d29c0ab9..da95a9de9a65 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -265,10 +265,8 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 	struct hfs_find_data cat_fd;
 	hfsplus_cat_entry entry;
 	u16 cat_entry_flags, cat_entry_type;
-	u16 folder_finderinfo_len = sizeof(struct DInfo) +
-					sizeof(struct DXInfo);
-	u16 file_finderinfo_len = sizeof(struct FInfo) +
-					sizeof(struct FXInfo);
+	u16 folder_finderinfo_len = sizeof(DInfo) + sizeof(DXInfo);
+	u16 file_finderinfo_len = sizeof(FInfo) + sizeof(FXInfo);
 
 	if ((!S_ISREG(inode->i_mode) &&
 			!S_ISDIR(inode->i_mode)) ||
@@ -444,11 +442,11 @@ static ssize_t hfsplus_getxattr_finder_info(struct inode *inode,
 	ssize_t res = 0;
 	struct hfs_find_data fd;
 	u16 entry_type;
-	u16 folder_rec_len = sizeof(struct DInfo) + sizeof(struct DXInfo);
-	u16 file_rec_len = sizeof(struct FInfo) + sizeof(struct FXInfo);
+	u16 folder_rec_len = sizeof(DInfo) + sizeof(DXInfo);
+	u16 file_rec_len = sizeof(FInfo) + sizeof(FXInfo);
 	u16 record_len = max(folder_rec_len, file_rec_len);
-	u8 folder_finder_info[sizeof(struct DInfo) + sizeof(struct DXInfo)];
-	u8 file_finder_info[sizeof(struct FInfo) + sizeof(struct FXInfo)];
+	u8 folder_finder_info[sizeof(DInfo) + sizeof(DXInfo)];
+	u8 file_finder_info[sizeof(FInfo) + sizeof(FXInfo)];
 
 	if (size >= record_len) {
 		res = hfs_find_init(HFSPLUS_SB(inode->i_sb)->cat_tree, &fd);
@@ -612,8 +610,8 @@ static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct hfs_find_data fd;
 	u16 entry_type;
-	u8 folder_finder_info[sizeof(struct DInfo) + sizeof(struct DXInfo)];
-	u8 file_finder_info[sizeof(struct FInfo) + sizeof(struct FXInfo)];
+	u8 folder_finder_info[sizeof(DInfo) + sizeof(DXInfo)];
+	u8 file_finder_info[sizeof(FInfo) + sizeof(FXInfo)];
 	unsigned long len, found_bit;
 	int xattr_name_len, symbols_count;
 
@@ -629,14 +627,14 @@ static ssize_t hfsplus_listxattr_finder_info(struct dentry *dentry,
 
 	entry_type = hfs_bnode_read_u16(fd.bnode, fd.entryoffset);
 	if (entry_type == HFSPLUS_FOLDER) {
-		len = sizeof(struct DInfo) + sizeof(struct DXInfo);
+		len = sizeof(DInfo) + sizeof(DXInfo);
 		hfs_bnode_read(fd.bnode, folder_finder_info,
 				fd.entryoffset +
 				offsetof(struct hfsplus_cat_folder, user_info),
 				len);
 		found_bit = find_first_bit((void *)folder_finder_info, len*8);
 	} else if (entry_type == HFSPLUS_FILE) {
-		len = sizeof(struct FInfo) + sizeof(struct FXInfo);
+		len = sizeof(FInfo) + sizeof(FXInfo);
 		hfs_bnode_read(fd.bnode, file_finder_info,
 				fd.entryoffset +
 				offsetof(struct hfsplus_cat_file, user_info),
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 8838ca2f3d08..dadb5e0aa8a3 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -17,4 +17,637 @@
 	pr_debug("pid %d:%s:%d %s(): " fmt,					\
 		 current->pid, __FILE__, __LINE__, __func__, ##__VA_ARGS__)	\
 
+/*
+ * Format of structures on disk
+ * Information taken from Apple Technote #1150 (HFS Plus Volume Format)
+ */
+
+/* offsets to various blocks */
+#define HFS_DD_BLK			0	/* Driver Descriptor block */
+#define HFS_PMAP_BLK			1	/* First block of partition map */
+#define HFS_MDB_BLK			2	/* Block (w/i partition) of MDB */
+
+/* magic numbers for various disk blocks */
+#define HFS_DRVR_DESC_MAGIC		0x4552	/* "ER": driver descriptor map */
+#define HFS_OLD_PMAP_MAGIC		0x5453	/* "TS": old-type partition map */
+#define HFS_NEW_PMAP_MAGIC		0x504D	/* "PM": new-type partition map */
+#define HFS_SUPER_MAGIC			0x4244	/* "BD": HFS MDB (super block) */
+#define HFS_MFS_SUPER_MAGIC		0xD2D7	/* MFS MDB (super block) */
+
+#define HFSPLUS_VOLHEAD_SIG		0x482b
+#define HFSPLUS_VOLHEAD_SIGX		0x4858
+#define HFSPLUS_SUPER_MAGIC		0x482b
+
+#define HFSP_WRAP_MAGIC			0x4244
+#define HFSP_WRAP_ATTRIB_SLOCK		0x8000
+#define HFSP_WRAP_ATTRIB_SPARED		0x0200
+
+#define HFSP_WRAPOFF_SIG		0x00
+#define HFSP_WRAPOFF_ATTRIB		0x0A
+#define HFSP_WRAPOFF_ABLKSIZE		0x14
+#define HFSP_WRAPOFF_ABLKSTART		0x1C
+#define HFSP_WRAPOFF_EMBEDSIG		0x7C
+#define HFSP_WRAPOFF_EMBEDEXT		0x7E
+
+#define HFSP_HARDLINK_TYPE		0x686c6e6b	/* 'hlnk' */
+#define HFSP_HFSPLUS_CREATOR		0x6866732b	/* 'hfs+' */
+
+#define HFSP_SYMLINK_TYPE		0x736c6e6b	/* 'slnk' */
+#define HFSP_SYMLINK_CREATOR		0x72686170	/* 'rhap' */
+
+#define HFSP_MOUNT_VERSION		0x482b4c78	/* 'H+Lx' */
+
+#define HFSP_HIDDENDIR_NAME \
+	"\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80\xe2\x90\x80HFS+ Private Data"
+
+/* various FIXED size parameters */
+#define HFS_SECTOR_SIZE			512	/* size of an HFS sector */
+#define HFS_SECTOR_SIZE_BITS		9	/* log_2(HFS_SECTOR_SIZE) */
+#define HFS_MAX_VALENCE			32767U
+
+#define HFSPLUS_SECTOR_SIZE		HFS_SECTOR_SIZE
+#define HFSPLUS_SECTOR_SHIFT		HFS_SECTOR_SIZE_BITS
+#define HFSPLUS_VOLHEAD_SECTOR		2
+#define HFSPLUS_MIN_VERSION		4
+#define HFSPLUS_CURRENT_VERSION		5
+
+#define HFS_NAMELEN			31	/* maximum length of an HFS filename */
+#define HFS_MAX_NAMELEN			128
+
+#define HFSPLUS_MAX_STRLEN		255
+#define HFSPLUS_ATTR_MAX_STRLEN		127
+
+/* Meanings of the drAtrb field of the MDB,
+ * Reference: _Inside Macintosh: Files_ p. 2-61
+ */
+#define HFS_SB_ATTRIB_HLOCK	(1 << 7)
+#define HFS_SB_ATTRIB_UNMNT	(1 << 8)
+#define HFS_SB_ATTRIB_SPARED	(1 << 9)
+#define HFS_SB_ATTRIB_INCNSTNT	(1 << 11)
+#define HFS_SB_ATTRIB_SLOCK	(1 << 15)
+
+/* values for hfs_cat_rec.cdrType */
+#define HFS_CDR_DIR		0x01	/* folder (directory) */
+#define HFS_CDR_FIL		0x02	/* file */
+#define HFS_CDR_THD		0x03	/* folder (directory) thread */
+#define HFS_CDR_FTH		0x04	/* file thread */
+
+/* legal values for hfs_ext_key.FkType and hfs_file.fork */
+#define HFS_FK_DATA		0x00
+#define HFS_FK_RSRC		0xFF
+
+/* bits in hfs_fil_entry.Flags */
+#define HFS_FIL_LOCK		0x01	/* locked */
+#define HFS_FIL_THD		0x02	/* file thread */
+#define HFS_FIL_DOPEN		0x04	/* data fork open */
+#define HFS_FIL_ROPEN		0x08	/* resource fork open */
+#define HFS_FIL_DIR		0x10	/* directory (always clear) */
+#define HFS_FIL_NOCOPY		0x40	/* copy-protected file */
+#define HFS_FIL_USED		0x80	/* open */
+
+/* bits in hfs_dir_entry.Flags. dirflags is 16 bits. */
+#define HFS_DIR_LOCK		0x01	/* locked */
+#define HFS_DIR_THD		0x02	/* directory thread */
+#define HFS_DIR_INEXPFOLDER	0x04	/* in a shared area */
+#define HFS_DIR_MOUNTED		0x08	/* mounted */
+#define HFS_DIR_DIR		0x10	/* directory (always set) */
+#define HFS_DIR_EXPFOLDER	0x20	/* share point */
+
+/* bits hfs_finfo.fdFlags */
+#define HFS_FLG_INITED		0x0100
+#define HFS_FLG_LOCKED		0x1000
+#define HFS_FLG_INVISIBLE	0x4000
+
+/* Some special File ID numbers */
+#define HFS_POR_CNID		1	/* Parent Of the Root */
+#define HFSPLUS_POR_CNID	HFS_POR_CNID
+#define HFS_ROOT_CNID		2	/* ROOT directory */
+#define HFSPLUS_ROOT_CNID	HFS_ROOT_CNID
+#define HFS_EXT_CNID		3	/* EXTents B-tree */
+#define HFSPLUS_EXT_CNID	HFS_EXT_CNID
+#define HFS_CAT_CNID		4	/* CATalog B-tree */
+#define HFSPLUS_CAT_CNID	HFS_CAT_CNID
+#define HFS_BAD_CNID		5	/* BAD blocks file */
+#define HFSPLUS_BAD_CNID	HFS_BAD_CNID
+#define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
+#define HFSPLUS_ALLOC_CNID	HFS_ALLOC_CNID
+#define HFS_START_CNID		7	/* STARTup file (HFS+) */
+#define HFSPLUS_START_CNID	HFS_START_CNID
+#define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */
+#define HFSPLUS_ATTR_CNID	HFS_ATTR_CNID
+#define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */
+#define HFSPLUS_EXCH_CNID	HFS_EXCH_CNID
+#define HFS_FIRSTUSER_CNID	16	/* first available user id */
+#define HFSPLUS_FIRSTUSER_CNID	HFS_FIRSTUSER_CNID
+
+/*======== HFS/HFS+ structures as they appear on the disk ========*/
+
+typedef __be32 hfsplus_cnid;
+typedef __be16 hfsplus_unichr;
+
+/* Pascal-style string of up to 31 characters */
+struct hfs_name {
+	u8 len;
+	u8 name[HFS_NAMELEN];
+} __packed;
+
+/* A "string" as used in filenames, etc. */
+struct hfsplus_unistr {
+	__be16 length;
+	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
+} __packed;
+
+/*
+ * A "string" is used in attributes file
+ * for name of extended attribute
+ */
+struct hfsplus_attr_unistr {
+	__be16 length;
+	hfsplus_unichr unicode[HFSPLUS_ATTR_MAX_STRLEN];
+} __packed;
+
+struct hfs_extent {
+	__be16 block;
+	__be16 count;
+};
+typedef struct hfs_extent hfs_extent_rec[3];
+
+/* A single contiguous area of a file */
+struct hfsplus_extent {
+	__be32 start_block;
+	__be32 block_count;
+} __packed;
+typedef struct hfsplus_extent hfsplus_extent_rec[8];
+
+/* Information for a "Fork" in a file */
+struct hfsplus_fork_raw {
+	__be64 total_size;
+	__be32 clump_size;
+	__be32 total_blocks;
+	hfsplus_extent_rec extents;
+} __packed;
+
+struct hfs_mdb {
+	__be16 drSigWord;		/* Signature word indicating fs type */
+	__be32 drCrDate;		/* fs creation date/time */
+	__be32 drLsMod;			/* fs modification date/time */
+	__be16 drAtrb;			/* fs attributes */
+	__be16 drNmFls;			/* number of files in root directory */
+	__be16 drVBMSt;			/* location (in 512-byte blocks)
+					   of the volume bitmap */
+	__be16 drAllocPtr;		/* location (in allocation blocks)
+					   to begin next allocation search */
+	__be16 drNmAlBlks;		/* number of allocation blocks */
+	__be32 drAlBlkSiz;		/* bytes in an allocation block */
+	__be32 drClpSiz;		/* clumpsize, the number of bytes to
+					   allocate when extending a file */
+	__be16 drAlBlSt;		/* location (in 512-byte blocks)
+					   of the first allocation block */
+	__be32 drNxtCNID;		/* CNID to assign to the next
+					   file or directory created */
+	__be16 drFreeBks;		/* number of free allocation blocks */
+	u8 drVN[28];			/* the volume label */
+	__be32 drVolBkUp;		/* fs backup date/time */
+	__be16 drVSeqNum;		/* backup sequence number */
+	__be32 drWrCnt;			/* fs write count */
+	__be32 drXTClpSiz;		/* clumpsize for the extents B-tree */
+	__be32 drCTClpSiz;		/* clumpsize for the catalog B-tree */
+	__be16 drNmRtDirs;		/* number of directories in
+					   the root directory */
+	__be32 drFilCnt;		/* number of files in the fs */
+	__be32 drDirCnt;		/* number of directories in the fs */
+	u8 drFndrInfo[32];		/* data used by the Finder */
+	__be16 drEmbedSigWord;		/* embedded volume signature */
+	__be32 drEmbedExtent;		/* starting block number (xdrStABN)
+					   and number of allocation blocks
+					   (xdrNumABlks) occupied by embedded
+					   volume */
+	__be32 drXTFlSize;		/* bytes in the extents B-tree */
+	hfs_extent_rec drXTExtRec;	/* extents B-tree's first 3 extents */
+	__be32 drCTFlSize;		/* bytes in the catalog B-tree */
+	hfs_extent_rec drCTExtRec;	/* catalog B-tree's first 3 extents */
+} __packed;
+
+/* HFS+ Volume Header */
+struct hfsplus_vh {
+	__be16 signature;
+	__be16 version;
+	__be32 attributes;
+	__be32 last_mount_vers;
+	u32 reserved;
+
+	__be32 create_date;
+	__be32 modify_date;
+	__be32 backup_date;
+	__be32 checked_date;
+
+	__be32 file_count;
+	__be32 folder_count;
+
+	__be32 blocksize;
+	__be32 total_blocks;
+	__be32 free_blocks;
+
+	__be32 next_alloc;
+	__be32 rsrc_clump_sz;
+	__be32 data_clump_sz;
+	hfsplus_cnid next_cnid;
+
+	__be32 write_count;
+	__be64 encodings_bmp;
+
+	u32 finder_info[8];
+
+	struct hfsplus_fork_raw alloc_file;
+	struct hfsplus_fork_raw ext_file;
+	struct hfsplus_fork_raw cat_file;
+	struct hfsplus_fork_raw attr_file;
+	struct hfsplus_fork_raw start_file;
+} __packed;
+
+/* HFS+ volume attributes */
+#define HFSPLUS_VOL_UNMNT		(1 << 8)
+#define HFSPLUS_VOL_SPARE_BLK		(1 << 9)
+#define HFSPLUS_VOL_NOCACHE		(1 << 10)
+#define HFSPLUS_VOL_INCNSTNT		(1 << 11)
+#define HFSPLUS_VOL_NODEID_REUSED	(1 << 12)
+#define HFSPLUS_VOL_JOURNALED		(1 << 13)
+#define HFSPLUS_VOL_SOFTLOCK		(1 << 15)
+#define HFSPLUS_VOL_UNUSED_NODE_FIX	(1 << 31)
+
+struct hfs_point {
+	__be16 v;
+	__be16 h;
+} __packed;
+
+typedef struct hfs_point hfsp_point;
+
+struct hfs_rect {
+	__be16 top;
+	__be16 left;
+	__be16 bottom;
+	__be16 right;
+} __packed;
+
+typedef struct hfs_rect hfsp_rect;
+
+struct hfs_finfo {
+	__be32 fdType;
+	__be32 fdCreator;
+	__be16 fdFlags;
+	struct hfs_point fdLocation;
+	__be16 fdFldr;
+} __packed;
+
+typedef struct hfs_finfo FInfo;
+
+struct hfs_fxinfo {
+	__be16 fdIconID;
+	u8 fdUnused[8];
+	__be16 fdComment;
+	__be32 fdPutAway;
+} __packed;
+
+typedef struct hfs_fxinfo FXInfo;
+
+struct hfs_dinfo {
+	struct hfs_rect frRect;
+	__be16 frFlags;
+	struct hfs_point frLocation;
+	__be16 frView;
+} __packed;
+
+typedef struct hfs_dinfo DInfo;
+
+struct hfs_dxinfo {
+	struct hfs_point frScroll;
+	__be32 frOpenChain;
+	__be16 frUnused;
+	__be16 frComment;
+	__be32 frPutAway;
+} __packed;
+
+typedef struct hfs_dxinfo DXInfo;
+
+union hfs_finder_info {
+	struct {
+		struct hfs_finfo finfo;
+		struct hfs_fxinfo fxinfo;
+	} file;
+	struct {
+		struct hfs_dinfo dinfo;
+		struct hfs_dxinfo dxinfo;
+	} dir;
+} __packed;
+
+/* The key used in the catalog b-tree: */
+struct hfs_cat_key {
+	u8 key_len;		/* number of bytes in the key */
+	u8 reserved;		/* padding */
+	__be32 ParID;		/* CNID of the parent dir */
+	struct hfs_name	CName;	/* The filename of the entry */
+} __packed;
+
+/* HFS+ catalog entry key */
+struct hfsplus_cat_key {
+	__be16 key_len;
+	hfsplus_cnid parent;
+	struct hfsplus_unistr name;
+} __packed;
+
+#define HFSPLUS_CAT_KEYLEN	(sizeof(struct hfsplus_cat_key))
+
+/* The key used in the extents b-tree: */
+struct hfs_ext_key {
+	u8 key_len;		/* number of bytes in the key */
+	u8 FkType;		/* HFS_FK_{DATA,RSRC} */
+	__be32 FNum;		/* The File ID of the file */
+	__be16 FABN;		/* allocation blocks number*/
+} __packed;
+
+/* HFS+ extents tree key */
+struct hfsplus_ext_key {
+	__be16 key_len;
+	u8 fork_type;
+	u8 pad;
+	hfsplus_cnid cnid;
+	__be32 start_block;
+} __packed;
+
+#define HFSPLUS_EXT_KEYLEN	sizeof(struct hfsplus_ext_key)
+
+typedef union hfs_btree_key {
+	u8 key_len;			/* number of bytes in the key */
+	struct hfs_cat_key cat;
+	struct hfs_ext_key ext;
+} hfs_btree_key;
+
+#define HFS_MAX_CAT_KEYLEN	(sizeof(struct hfs_cat_key) - sizeof(u8))
+#define HFS_MAX_EXT_KEYLEN	(sizeof(struct hfs_ext_key) - sizeof(u8))
+
+typedef union hfs_btree_key btree_key;
+
+/* The catalog record for a file */
+struct hfs_cat_file {
+	s8 type;			/* The type of entry */
+	u8 reserved;
+	u8 Flags;			/* Flags such as read-only */
+	s8 Typ;				/* file version number = 0 */
+	struct hfs_finfo UsrWds;	/* data used by the Finder */
+	__be32 FlNum;			/* The CNID */
+	__be16 StBlk;			/* obsolete */
+	__be32 LgLen;			/* The logical EOF of the data fork*/
+	__be32 PyLen;			/* The physical EOF of the data fork */
+	__be16 RStBlk;			/* obsolete */
+	__be32 RLgLen;			/* The logical EOF of the rsrc fork */
+	__be32 RPyLen;			/* The physical EOF of the rsrc fork */
+	__be32 CrDat;			/* The creation date */
+	__be32 MdDat;			/* The modified date */
+	__be32 BkDat;			/* The last backup date */
+	struct hfs_fxinfo FndrInfo;	/* more data for the Finder */
+	__be16 ClpSize;			/* number of bytes to allocate
+					   when extending files */
+	hfs_extent_rec ExtRec;		/* first extent record
+					   for the data fork */
+	hfs_extent_rec RExtRec;		/* first extent record
+					   for the resource fork */
+	u32 Resrv;			/* reserved by Apple */
+} __packed;
+
+/* the catalog record for a directory */
+struct hfs_cat_dir {
+	s8 type;			/* The type of entry */
+	u8 reserved;
+	__be16 Flags;			/* flags */
+	__be16 Val;			/* Valence: number of files and
+					   dirs in the directory */
+	__be32 DirID;			/* The CNID */
+	__be32 CrDat;			/* The creation date */
+	__be32 MdDat;			/* The modification date */
+	__be32 BkDat;			/* The last backup date */
+	struct hfs_dinfo UsrInfo;	/* data used by the Finder */
+	struct hfs_dxinfo FndrInfo;	/* more data used by Finder */
+	u8 Resrv[16];			/* reserved by Apple */
+} __packed;
+
+/* the catalog record for a thread */
+struct hfs_cat_thread {
+	s8 type;			/* The type of entry */
+	u8 reserved[9];			/* reserved by Apple */
+	__be32 ParID;			/* CNID of parent directory */
+	struct hfs_name CName;		/* The name of this entry */
+}  __packed;
+
+/* A catalog tree record */
+typedef union hfs_cat_rec {
+	s8 type;			/* The type of entry */
+	struct hfs_cat_file file;
+	struct hfs_cat_dir dir;
+	struct hfs_cat_thread thread;
+} hfs_cat_rec;
+
+/* POSIX permissions */
+struct hfsplus_perm {
+	__be32 owner;
+	__be32 group;
+	u8  rootflags;
+	u8  userflags;
+	__be16 mode;
+	__be32 dev;
+} __packed;
+
+#define HFSPLUS_FLG_NODUMP	0x01
+#define HFSPLUS_FLG_IMMUTABLE	0x02
+#define HFSPLUS_FLG_APPEND	0x04
+
+/* HFS/HFS+ BTree node descriptor */
+struct hfs_bnode_desc {
+	__be32 next;		/* (V) Number of the next node at this level */
+	__be32 prev;		/* (V) Number of the prev node at this level */
+	u8 type;		/* (F) The type of node */
+	u8 height;		/* (F) The level of this node (leaves=1) */
+	__be16 num_recs;	/* (V) The number of records in this node */
+	u16 reserved;
+} __packed;
+
+/* HFS/HFS+ BTree node types */
+#define HFS_NODE_INDEX	0x00	/* An internal (index) node */
+#define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
+#define HFS_NODE_MAP	0x02	/* Holds part of the bitmap of used nodes */
+#define HFS_NODE_LEAF	0xFF	/* A leaf (ndNHeight==1) node */
+
+/* HFS/HFS+ BTree header */
+struct hfs_btree_header_rec {
+	__be16 depth;		/* (V) The number of levels in this B-tree */
+	__be32 root;		/* (V) The node number of the root node */
+	__be32 leaf_count;	/* (V) The number of leaf records */
+	__be32 leaf_head;	/* (V) The number of the first leaf node */
+	__be32 leaf_tail;	/* (V) The number of the last leaf node */
+	__be16 node_size;	/* (F) The number of bytes in a node (=512) */
+	__be16 max_key_len;	/* (F) The length of a key in an index node */
+	__be32 node_count;	/* (V) The total number of nodes */
+	__be32 free_nodes;	/* (V) The number of unused nodes */
+	u16 reserved1;
+	__be32 clump_size;	/* (F) clump size. not usually used. */
+	u8 btree_type;		/* (F) BTree type */
+	u8 key_type;
+	__be32 attributes;	/* (F) attributes */
+	u32 reserved3[16];
+} __packed;
+
+/* BTree attributes */
+#define BTREE_ATTR_BADCLOSE	0x00000001	/* b-tree not closed properly. not
+						   used by hfsplus. */
+#define HFS_TREE_BIGKEYS	0x00000002	/* key length is u16 instead of u8.
+						   used by hfsplus. */
+#define HFS_TREE_VARIDXKEYS	0x00000004	/* variable key length instead of
+						   max key length. use din catalog
+						   b-tree but not in extents
+						   b-tree (hfsplus). */
+
+/* HFS+ BTree misc info */
+#define HFSPLUS_TREE_HEAD			0
+#define HFSPLUS_NODE_MXSZ			32768
+#define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
+#define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
+#define HFSPLUS_BTREE_HDR_USER_BYTES		128
+
+/* btree key type */
+#define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
+#define HFSPLUS_KEY_BINARY		0xBC	/* case-sensitive */
+
+/* HFS+ folder data (part of an hfsplus_cat_entry) */
+struct hfsplus_cat_folder {
+	__be16 type;
+	__be16 flags;
+	__be32 valence;
+	hfsplus_cnid id;
+	__be32 create_date;
+	__be32 content_mod_date;
+	__be32 attribute_mod_date;
+	__be32 access_date;
+	__be32 backup_date;
+	struct hfsplus_perm permissions;
+	struct_group_attr(info, __packed,
+		DInfo user_info;
+		DXInfo finder_info;
+	);
+	__be32 text_encoding;
+	__be32 subfolders;	/* Subfolder count in HFSX. Reserved in HFS+. */
+} __packed;
+
+/* HFS+ file data (part of a cat_entry) */
+struct hfsplus_cat_file {
+	__be16 type;
+	__be16 flags;
+	u32 reserved1;
+	hfsplus_cnid id;
+	__be32 create_date;
+	__be32 content_mod_date;
+	__be32 attribute_mod_date;
+	__be32 access_date;
+	__be32 backup_date;
+	struct hfsplus_perm permissions;
+	struct_group_attr(info, __packed,
+		FInfo user_info;
+		FXInfo finder_info;
+	);
+	__be32 text_encoding;
+	u32 reserved2;
+
+	struct hfsplus_fork_raw data_fork;
+	struct hfsplus_fork_raw rsrc_fork;
+} __packed;
+
+/* File and folder flag bits */
+#define HFSPLUS_FILE_LOCKED		0x0001
+#define HFSPLUS_FILE_THREAD_EXISTS	0x0002
+#define HFSPLUS_XATTR_EXISTS		0x0004
+#define HFSPLUS_ACL_EXISTS		0x0008
+#define HFSPLUS_HAS_FOLDER_COUNT	0x0010	/* Folder has subfolder count
+						 * (HFSX only) */
+
+/* HFS+ catalog thread (part of a cat_entry) */
+struct hfsplus_cat_thread {
+	__be16 type;
+	s16 reserved;
+	hfsplus_cnid parentID;
+	struct hfsplus_unistr nodeName;
+} __packed;
+
+#define HFSPLUS_MIN_THREAD_SZ		10
+
+/* A data record in the catalog tree */
+typedef union {
+	__be16 type;
+	struct hfsplus_cat_folder folder;
+	struct hfsplus_cat_file file;
+	struct hfsplus_cat_thread thread;
+} __packed hfsplus_cat_entry;
+
+/* HFS+ catalog entry type */
+#define HFSPLUS_FOLDER		0x0001
+#define HFSPLUS_FILE		0x0002
+#define HFSPLUS_FOLDER_THREAD	0x0003
+#define HFSPLUS_FILE_THREAD	0x0004
+
+#define HFSPLUS_XATTR_FINDER_INFO_NAME	"com.apple.FinderInfo"
+#define HFSPLUS_XATTR_ACL_NAME		"com.apple.system.Security"
+
+#define HFSPLUS_ATTR_INLINE_DATA	0x10
+#define HFSPLUS_ATTR_FORK_DATA		0x20
+#define HFSPLUS_ATTR_EXTENTS		0x30
+
+/* HFS+ attributes tree key */
+struct hfsplus_attr_key {
+	__be16 key_len;
+	__be16 pad;
+	hfsplus_cnid cnid;
+	__be32 start_block;
+	struct hfsplus_attr_unistr key_name;
+} __packed;
+
+#define HFSPLUS_ATTR_KEYLEN	sizeof(struct hfsplus_attr_key)
+
+/* HFS+ fork data attribute */
+struct hfsplus_attr_fork_data {
+	__be32 record_type;
+	__be32 reserved;
+	struct hfsplus_fork_raw the_fork;
+} __packed;
+
+/* HFS+ extension attribute */
+struct hfsplus_attr_extents {
+	__be32 record_type;
+	__be32 reserved;
+	struct hfsplus_extent extents;
+} __packed;
+
+#define HFSPLUS_MAX_INLINE_DATA_SIZE	3802
+
+/* HFS+ attribute inline data */
+struct hfsplus_attr_inline_data {
+	__be32 record_type;
+	__be32 reserved1;
+	u8 reserved2[6];
+	__be16 length;
+	u8 raw_bytes[HFSPLUS_MAX_INLINE_DATA_SIZE];
+} __packed;
+
+/* A data record in the attributes tree */
+typedef union {
+	__be32 record_type;
+	struct hfsplus_attr_fork_data fork_data;
+	struct hfsplus_attr_extents extents;
+	struct hfsplus_attr_inline_data inline_data;
+} __packed hfsplus_attr_entry;
+
+/* HFS+ generic BTree key */
+typedef union {
+	__be16 key_len;
+	struct hfsplus_cat_key cat;
+	struct hfsplus_ext_key ext;
+	struct hfsplus_attr_key attr;
+} __packed hfsplus_btree_key;
+
 #endif /* _HFS_COMMON_H_ */
-- 
2.43.0


