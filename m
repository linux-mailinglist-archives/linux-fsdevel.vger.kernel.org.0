Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBB255CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 16:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgH1OmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 10:42:14 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:49826 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727957AbgH1Okh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:40:37 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 4A39F82040;
        Fri, 28 Aug 2020 17:40:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598625615;
        bh=CuXwGA0MkObc5Qsav619OwalyrJr+uJfxc31FbSI1HU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sgZW9nbBCRn7Gbqd0CQm10bmyvjMwVEwSK6m0YW3DRIKXt344hnFfnKtsyrSjLZsC
         +l3dIN565TkD/cL5UY1CkJTDrPYl33PNzD6mX+e5dn0m15ESsLPBNrIuIlBxFLrpXx
         tWd6bn+J6hyHW/1gyB99hQJg/lE2ma1qnSmsrahE=
Received: from localhost.localdomain (172.30.8.44) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 28 Aug 2020 17:40:14 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v3 01/10] fs/ntfs3: Add headers and misc files
Date:   Fri, 28 Aug 2020 07:39:29 -0700
Message-ID: <20200828143938.102889-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.30.8.44]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds headers and misc files

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/debug.h   |   45 ++
 fs/ntfs3/ntfs.h    | 1249 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h | 1001 +++++++++++++++++++++++++++++++++++
 fs/ntfs3/upcase.c  |   78 +++
 4 files changed, 2373 insertions(+)
 create mode 100644 fs/ntfs3/debug.h
 create mode 100644 fs/ntfs3/ntfs.h
 create mode 100644 fs/ntfs3/ntfs_fs.h
 create mode 100644 fs/ntfs3/upcase.c

diff --git a/fs/ntfs3/debug.h b/fs/ntfs3/debug.h
new file mode 100644
index 000000000000..eff8e52b1560
--- /dev/null
+++ b/fs/ntfs3/debug.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/ntfs3/debug.h
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ * useful functions for debuging
+ */
+
+#ifndef Add2Ptr
+#define Add2Ptr(P, I) (void *)((u8 *)(P) + (I))
+#define PtrOffset(B, O) ((size_t)((size_t)(O) - (size_t)(B)))
+#endif
+
+#define QuadAlign(n) (((n) + 7u) & (~7u))
+#define IsQuadAligned(n) (!((size_t)(n)&7u))
+#define Quad2Align(n) (((n) + 15u) & (~15u))
+#define IsQuad2Aligned(n) (!((size_t)(n)&15u))
+#define Quad4Align(n) (((n) + 31u) & (~31u))
+#define IsSizeTAligned(n) (!((size_t)(n) & (sizeof(size_t) - 1)))
+#define DwordAlign(n) (((n) + 3u) & (~3u))
+#define IsDwordAligned(n) (!((size_t)(n)&3u))
+#define WordAlign(n) (((n) + 1u) & (~1u))
+#define IsWordAligned(n) (!((size_t)(n)&1u))
+
+#ifdef CONFIG_PRINTK
+__printf(2, 3) void ntfs_printk(const struct super_block *sb, const char *fmt,
+				...);
+__printf(2, 3) void ntfs_inode_printk(struct inode *inode, const char *fmt,
+				      ...);
+#else
+static inline __printf(2, 3) void ntfs_printk(const struct super_block *sb,
+					      const char *fmt, ...)
+{
+}
+
+static inline __printf(2, 3) void ntfs_inode_printk(struct inode *inode,
+						    const char *fmt, ...)
+{
+}
+#endif
+
+#define ntfs_alloc(s, z) kmalloc(s, z ? (GFP_NOFS | __GFP_ZERO) : GFP_NOFS)
+#define ntfs_free(p) kfree(p)
+#define ntfs_memdup(src, len) kmemdup(src, len, GFP_NOFS)
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
new file mode 100644
index 000000000000..d7fac44adfa3
--- /dev/null
+++ b/fs/ntfs3/ntfs.h
@@ -0,0 +1,1249 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/ntfs3/ntfs.h
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ * on-disk ntfs structs
+ */
+
+/* TODO:
+ * - Check 4K mft record and 512 bytes cluster
+ */
+
+/*
+ * Activate this define to use binary search in indexes
+ */
+#define NTFS3_INDEX_BINARY_SEARCH
+
+/*
+ * Check each run for marked clusters
+ */
+#define NTFS3_CHECK_FREE_CLST
+
+#define NTFS_NAME_LEN 255
+
+/*
+ * ntfs.sys used 500 maximum links
+ * on-disk struct allows up to 0xffff
+ */
+#define NTFS_LINK_MAX 0x400
+//#define NTFS_LINK_MAX 0xffff
+
+/*
+ * Activate to use 64 bit clusters instead of 32 bits in ntfs.sys
+ * Logical and virtual cluster number
+ * If needed, may be redefined to use 64 bit value
+ */
+//#define NTFS3_64BIT_CLUSTER
+
+#define NTFS_LZNT_MAX_CLUSTER 4096
+#define NTFS_LZNT_CUNIT 4
+
+struct GUID {
+	__le32 Data1;
+	__le16 Data2;
+	__le16 Data3;
+	u8 Data4[8];
+};
+
+struct le_str {
+	u8 len;
+	u8 unused;
+	__le16 name[20];
+};
+
+struct cpu_str {
+	u8 len;
+	u8 unused;
+	u16 name[20];
+};
+
+static_assert(SECTOR_SHIFT == 9);
+
+#ifdef NTFS3_64BIT_CLUSTER
+typedef u64 CLST;
+static_assert(sizeof(size_t) == 8);
+#else
+typedef u32 CLST;
+#endif
+
+#define SPARSE_LCN ((CLST)-1)
+#define RESIDENT_LCN ((CLST)-2)
+#define COMPRESSED_LCN ((CLST)-3)
+
+#define COMPRESSION_UNIT 4
+#define COMPRESS_MAX_CLUSTER 0x1000
+#define MFT_INCREASE_CHUNK 1024
+
+enum RECORD_NUM {
+	MFT_REC_MFT = 0,
+	MFT_REC_MIRR = 1,
+	MFT_REC_LOG = 2,
+	MFT_REC_VOL = 3,
+	MFT_REC_ATTR = 4,
+	MFT_REC_ROOT = 5,
+	MFT_REC_BITMAP = 6,
+	MFT_REC_BOOT = 7,
+	MFT_REC_BADCLUST = 8,
+	MFT_REC_QUOTA = 9,
+	MFT_REC_SECURE = 9, // NTFS 3.0
+	MFT_REC_UPCASE = 10,
+	MFT_REC_EXTEND = 11, // NTFS 3.0
+	MFT_REC_RESERVED = 11,
+	MFT_REC_FREE = 16,
+	MFT_REC_USER = 24,
+};
+
+enum ATTR_TYPE {
+	ATTR_ZERO = cpu_to_le32(0x00),
+	ATTR_STD = cpu_to_le32(0x10),
+	ATTR_LIST = cpu_to_le32(0x20),
+	ATTR_NAME = cpu_to_le32(0x30),
+	// ATTR_VOLUME_VERSION on Nt4
+	ATTR_ID = cpu_to_le32(0x40),
+	ATTR_SECURE = cpu_to_le32(0x50),
+	ATTR_LABEL = cpu_to_le32(0x60),
+	ATTR_VOL_INFO = cpu_to_le32(0x70),
+	ATTR_DATA = cpu_to_le32(0x80),
+	ATTR_ROOT = cpu_to_le32(0x90),
+	ATTR_ALLOC = cpu_to_le32(0xA0),
+	ATTR_BITMAP = cpu_to_le32(0xB0),
+	// ATTR_SYMLINK on Nt4
+	ATTR_REPARSE = cpu_to_le32(0xC0),
+	ATTR_EA_INFO = cpu_to_le32(0xD0),
+	ATTR_EA = cpu_to_le32(0xE0),
+	ATTR_PROPERTYSET = cpu_to_le32(0xF0),
+	ATTR_LOGGED_UTILITY_STREAM = cpu_to_le32(0x100),
+	ATTR_END = cpu_to_le32(0xFFFFFFFF)
+};
+
+static_assert(sizeof(enum ATTR_TYPE) == 4);
+
+enum FILE_ATTRIBUTE {
+	FILE_ATTRIBUTE_READONLY = cpu_to_le32(0x00000001),
+	FILE_ATTRIBUTE_HIDDEN = cpu_to_le32(0x00000002),
+	FILE_ATTRIBUTE_SYSTEM = cpu_to_le32(0x00000004),
+	FILE_ATTRIBUTE_ARCHIVE = cpu_to_le32(0x00000020),
+	FILE_ATTRIBUTE_DEVICE = cpu_to_le32(0x00000040),
+
+	FILE_ATTRIBUTE_TEMPORARY = cpu_to_le32(0x00000100),
+	FILE_ATTRIBUTE_SPARSE_FILE = cpu_to_le32(0x00000200),
+	FILE_ATTRIBUTE_REPARSE_POINT = cpu_to_le32(0x00000400),
+	FILE_ATTRIBUTE_COMPRESSED = cpu_to_le32(0x00000800),
+
+	FILE_ATTRIBUTE_OFFLINE = cpu_to_le32(0x00001000),
+	FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = cpu_to_le32(0x00002000),
+	FILE_ATTRIBUTE_ENCRYPTED = cpu_to_le32(0x00004000),
+
+	FILE_ATTRIBUTE_VALID_FLAGS = cpu_to_le32(0x00007fb7),
+
+	FILE_ATTRIBUTE_DIRECTORY = cpu_to_le32(0x10000000),
+};
+
+static_assert(sizeof(enum FILE_ATTRIBUTE) == 4);
+
+extern const struct cpu_str NAME_MFT; // L"$MFT"
+extern const struct cpu_str NAME_MIRROR; // L"$MFTMirr"
+extern const struct cpu_str NAME_LOGFILE; // L"$LogFile"
+extern const struct cpu_str NAME_VOLUME; // L"$Volume"
+extern const struct cpu_str NAME_ATTRDEF; // L"$AttrDef"
+extern const struct cpu_str NAME_ROOT; // L"."
+extern const struct cpu_str NAME_BITMAP; // L"$Bitmap"
+extern const struct cpu_str NAME_BOOT; // L"$Boot"
+extern const struct cpu_str NAME_BADCLUS; // L"$BadClus"
+extern const struct cpu_str NAME_QUOTA; // L"$Quota"
+extern const struct cpu_str NAME_SECURE; // L"$Secure"
+extern const struct cpu_str NAME_UPCASE; // L"$UpCase"
+extern const struct cpu_str NAME_EXTEND; // L"$Extend"
+extern const struct cpu_str NAME_OBJID; // L"$ObjId"
+extern const struct cpu_str NAME_REPARSE; // L"$Reparse"
+extern const struct cpu_str NAME_USNJRNL; // L"$UsnJrnl"
+extern const struct cpu_str NAME_UGM; // L"$UGM"
+
+extern const __le16 I30_NAME[4]; // L"$I30"
+extern const __le16 SII_NAME[4]; // L"$SII"
+extern const __le16 SDH_NAME[4]; // L"$SDH"
+extern const __le16 SO_NAME[2]; // L"$O"
+extern const __le16 SQ_NAME[2]; // L"$Q"
+extern const __le16 SR_NAME[2]; // L"$R"
+
+extern const __le16 BAD_NAME[4]; // L"$Bad"
+extern const __le16 SDS_NAME[4]; // L"$SDS"
+extern const __le16 EFS_NAME[4]; // L"$EFS"
+extern const __le16 WOF_NAME[17]; // L"WofCompressedData"
+extern const __le16 J_NAME[2]; // L"$J"
+extern const __le16 MAX_NAME[4]; // L"$Max"
+
+/* MFT record number structure */
+struct MFT_REF {
+	__le32 low; // The low part of the number
+	__le16 high; // The high part of the number
+	__le16 seq; // The sequence number of MFT record
+};
+
+static_assert(sizeof(__le64) == sizeof(struct MFT_REF));
+
+static inline CLST ino_get(const struct MFT_REF *ref)
+{
+#ifdef NTFS3_64BIT_CLUSTER
+	return le32_to_cpu(ref->low) | ((u64)le16_to_cpu(ref->high) << 32);
+#else
+	return le32_to_cpu(ref->low);
+#endif
+}
+
+struct NTFS_BOOT {
+	u8 jump_code[3]; // 0x00: Jump to boot code
+	u8 system_id[8]; // 0x03: System ID, equals "NTFS    "
+
+	// NOTE: this member is not aligned(!)
+	// bytes_per_sector[0] must be 0
+	// bytes_per_sector[1] must be multiplied by 256
+	u8 bytes_per_sector[2]; // 0x0B: Bytes per sector
+
+	u8 sectors_per_clusters; // 0x0D: Sectors per cluster
+	u8 unused1[7];
+	u8 media_type; // 0x15: Media type (0xF8 - harddisk)
+	u8 unused2[2];
+	__le16 secotrs_per_track; // 0x18: number of sectors per track
+	__le16 heads; // 0x1A: number of heads per cylinder
+	__le32 hidden_sectors; // 0x1C: number of 'hidden' sectors
+	u8 unused3[4];
+	u8 bios_drive_num; // 0x24: BIOS drive number =0x80
+	u8 unused4;
+	u8 signature_ex; // 0x26: Extended BOOT signature =0x80
+	u8 unused5;
+	__le64 sectors_per_volume; // 0x28: size of volume in sectors
+	__le64 mft_clst; // 0x30: first cluster of $MFT
+	__le64 mft2_clst; // 0x38: first cluster of $MFTMirr
+	s8 record_size; // 0x40: size of MFT record in clusters(sectors)
+	u8 unused6[3];
+	s8 index_size; // 0x44: size of INDX record in clusters(sectors)
+	u8 unused7[3];
+	__le64 serial_num; // 0x48: Volume serial number
+	__le32 check_sum; // 0x50: Simple additive checksum of all of the u32's which
+		// precede the 'check_sum'
+
+	u8 boot_code[0x200 - 0x50 - 2 - 4]; // 0x54:
+	u8 boot_magic[2]; // 0x1FE: Boot signature =0x55 + 0xAA
+};
+
+static_assert(sizeof(struct NTFS_BOOT) == 0x200);
+
+enum NTFS_SIGNATURE {
+	NTFS_FILE_SIGNATURE = cpu_to_le32(0x454C4946), // 'FILE'
+	NTFS_INDX_SIGNATURE = cpu_to_le32(0x58444E49), // 'INDX'
+	NTFS_CHKD_SIGNATURE = cpu_to_le32(0x444B4843), // 'CHKD'
+	NTFS_RSTR_SIGNATURE = cpu_to_le32(0x52545352), // 'RSTR'
+	NTFS_RCRD_SIGNATURE = cpu_to_le32(0x44524352), // 'RCRD'
+	NTFS_BAAD_SIGNATURE = cpu_to_le32(0x44414142), // 'BAAD'
+	NTFS_HOLE_SIGNATURE = cpu_to_le32(0x454C4F48), // 'HOLE'
+	NTFS_FFFF_SIGNATURE = cpu_to_le32(0xffffffff),
+};
+
+static_assert(sizeof(enum NTFS_SIGNATURE) == 4);
+
+/* MFT Record header structure */
+struct NTFS_RECORD_HEADER {
+	/* Record magic number, equals 'FILE'/'INDX'/'RSTR'/'RCRD' */
+	enum NTFS_SIGNATURE sign; // 0x00:
+	__le16 fix_off; // 0x04:
+	__le16 fix_num; // 0x06:
+	__le64 lsn; // 0x08: Log file sequence number
+};
+
+static_assert(sizeof(struct NTFS_RECORD_HEADER) == 0x10);
+
+static inline int is_baad(const struct NTFS_RECORD_HEADER *hdr)
+{
+	return hdr->sign == NTFS_BAAD_SIGNATURE;
+}
+
+/* Possible bits in struct MFT_REC.flags */
+enum RECORD_FLAG {
+	RECORD_FLAG_IN_USE = cpu_to_le16(0x0001),
+	RECORD_FLAG_DIR = cpu_to_le16(0x0002),
+	RECORD_FLAG_SYSTEM = cpu_to_le16(0x0004),
+	RECORD_FLAG_UNKNOWN = cpu_to_le16(0x0008),
+};
+
+/* MFT Record structure */
+struct MFT_REC {
+	struct NTFS_RECORD_HEADER rhdr; // 'FILE'
+
+	__le16 seq; // 0x10: Sequence number for this record
+	__le16 hard_links; // 0x12: The number of hard links to record
+	__le16 attr_off; // 0x14: Offset to attributes
+	__le16 flags; // 0x16: 1=non-resident, 2=dir. See RECORD_FLAG_XXX
+	__le32 used; // 0x18: The size of used part
+	__le32 total; // 0x1C: Total record size
+
+	struct MFT_REF parent_ref; // 0x20: Parent MFT record
+	__le16 next_attr_id; // 0x28: The next attribute Id
+
+	//
+	// NTFS of version 3.1 uses this record header
+	// if fix_off >= 0x30
+
+	__le16 Res; // 0x2A: ? High part of MftRecord
+	__le32 MftRecord; // 0x2C: Current record number
+	__le16 Fixups[1]; // 0x30:
+};
+
+#define MFTRECORD_FIXUP_OFFSET_1 offsetof(struct MFT_REC, Res)
+#define MFTRECORD_FIXUP_OFFSET_3 offsetof(struct MFT_REC, Fixups)
+
+static_assert(MFTRECORD_FIXUP_OFFSET_1 == 0x2A);
+static_assert(MFTRECORD_FIXUP_OFFSET_3 == 0x30);
+
+static inline bool is_rec_base(const struct MFT_REC *rec)
+{
+	const struct MFT_REF *r = &rec->parent_ref;
+
+	return !r->low && !r->high && !r->seq;
+}
+
+static inline bool is_mft_rec5(const struct MFT_REC *rec)
+{
+	return le16_to_cpu(rec->rhdr.fix_off) >=
+	       offsetof(struct MFT_REC, Fixups);
+}
+
+static inline bool is_rec_inuse(const struct MFT_REC *rec)
+{
+	return rec->flags & RECORD_FLAG_IN_USE;
+}
+
+static inline bool clear_rec_inuse(struct MFT_REC *rec)
+{
+	return rec->flags &= ~RECORD_FLAG_IN_USE;
+}
+
+/* Possible values of ATTR_RESIDENT.flags */
+#define RESIDENT_FLAG_INDEXED 0x01
+
+struct ATTR_RESIDENT {
+	__le32 data_size; // 0x10: The size of data
+	__le16 data_off; // 0x14: Offset to data
+	u8 flags; // 0x16: resident flags ( 1 - indexed )
+	u8 res; // 0x17:
+}; // sizeof() = 0x18
+
+struct ATTR_NONRESIDENT {
+	__le64 svcn; // 0x10: Starting VCN of this segment
+	__le64 evcn; // 0x18: End VCN of this segment
+	__le16 run_off; // 0x20: Offset to packed runs
+	//  Unit of Compression size for this stream, expressed
+	//  as a log of the cluster size.
+	//
+	//      0 means file is not compressed
+	//      1, 2, 3, and 4 are potentially legal values if the
+	//          stream is compressed, however the implementation
+	//          may only choose to use 4, or possibly 3.  Note
+	//          that 4 means cluster size time 16.  If convenient
+	//          the implementation may wish to accept a
+	//          reasonable range of legal values here (1-5?),
+	//          even if the implementation only generates
+	//          a smaller set of values itself.
+	u8 c_unit; // 0x22
+	u8 res1[5]; // 0x23:
+	__le64 alloc_size; // 0x28: The allocated size of attribute in bytes
+		// (multiple of cluster size)
+	__le64 data_size; // 0x30: The size of attribute  in bytes <= alloc_size
+	__le64 valid_size; // 0x38: The size of valid part in bytes <= data_size
+	__le64 total_size; // 0x40: The sum of the allocated clusters for a file
+		// (present only for the first segment (0 == vcn)
+		// of compressed attribute)
+
+}; // sizeof()=0x40 or 0x48 (if compressed)
+
+/* Possible values of ATTRIB.flags: */
+#define ATTR_FLAG_COMPRESSED cpu_to_le16(0x0001)
+#define ATTR_FLAG_COMPRESSED_MASK cpu_to_le16(0x00FF)
+#define ATTR_FLAG_ENCRYPTED cpu_to_le16(0x4000)
+#define ATTR_FLAG_SPARSED cpu_to_le16(0x8000)
+
+struct ATTRIB {
+	enum ATTR_TYPE type; // 0x00: The type of this attribute
+	__le32 size; // 0x04: The size of this attribute
+	u8 non_res; // 0x08: Is this attribute non-resident ?
+	u8 name_len; // 0x09: This attribute name length
+	__le16 name_off; // 0x0A: Offset to the attribute name
+	__le16 flags; // 0x0C: See ATTR_FLAG_XXX
+	__le16 id; // 0x0E: unique id (per record)
+
+	union {
+		struct ATTR_RESIDENT res; // 0x10
+		struct ATTR_NONRESIDENT nres; // 0x10
+	};
+};
+
+/* Define attribute sizes */
+#define SIZEOF_RESIDENT 0x18
+#define SIZEOF_NONRESIDENT_EX 0x48
+#define SIZEOF_NONRESIDENT 0x40
+
+#define SIZEOF_RESIDENT_LE cpu_to_le16(0x18)
+#define SIZEOF_NONRESIDENT_EX_LE cpu_to_le16(0x48)
+#define SIZEOF_NONRESIDENT_LE cpu_to_le16(0x40)
+
+static inline u64 attr_ondisk_size(const struct ATTRIB *attr)
+{
+	return attr->non_res ? ((attr->flags &
+				 (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED)) ?
+					le64_to_cpu(attr->nres.total_size) :
+					le64_to_cpu(attr->nres.alloc_size)) :
+			       QuadAlign(le32_to_cpu(attr->res.data_size));
+}
+
+static inline u64 attr_size(const struct ATTRIB *attr)
+{
+	return attr->non_res ? le64_to_cpu(attr->nres.data_size) :
+			       le32_to_cpu(attr->res.data_size);
+}
+
+static inline bool is_attr_encrypted(const struct ATTRIB *attr)
+{
+	return attr->flags & ATTR_FLAG_ENCRYPTED;
+}
+
+static inline bool is_attr_sparsed(const struct ATTRIB *attr)
+{
+	return attr->flags & ATTR_FLAG_SPARSED;
+}
+
+static inline bool is_attr_compressed(const struct ATTRIB *attr)
+{
+	return attr->flags & ATTR_FLAG_COMPRESSED;
+}
+
+static inline bool is_attr_ext(const struct ATTRIB *attr)
+{
+	return attr->flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED);
+}
+
+static inline bool is_attr_indexed(const struct ATTRIB *attr)
+{
+	return !attr->non_res && (attr->res.flags & RESIDENT_FLAG_INDEXED);
+}
+
+static inline const __le16 *attr_name(const struct ATTRIB *attr)
+{
+	return Add2Ptr(attr, le16_to_cpu(attr->name_off));
+}
+
+static inline u64 attr_svcn(const struct ATTRIB *attr)
+{
+	return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
+}
+
+/* the size of resident attribute by its resident size */
+#define BYTES_PER_RESIDENT(b) (0x18 + (b))
+
+static_assert(sizeof(struct ATTRIB) == 0x48);
+static_assert(sizeof(((struct ATTRIB *)NULL)->res) == 0x08);
+static_assert(sizeof(((struct ATTRIB *)NULL)->nres) == 0x38);
+
+static inline void *resident_data_ex(const struct ATTRIB *attr, u32 datasize)
+{
+	u32 asize, rsize;
+	u16 off;
+
+	if (attr->non_res)
+		return NULL;
+
+	asize = le32_to_cpu(attr->size);
+	off = le16_to_cpu(attr->res.data_off);
+
+	if (asize < datasize + off)
+		return NULL;
+
+	rsize = le32_to_cpu(attr->res.data_size);
+	if (rsize < datasize)
+		return NULL;
+
+	return Add2Ptr(attr, off);
+}
+
+static inline void *resident_data(const struct ATTRIB *attr)
+{
+	return Add2Ptr(attr, le16_to_cpu(attr->res.data_off));
+}
+
+static inline void *attr_run(const struct ATTRIB *attr)
+{
+	return Add2Ptr(attr, le16_to_cpu(attr->nres.run_off));
+}
+
+/* Standard information attribute (0x10) */
+struct ATTR_STD_INFO {
+	__le64 cr_time; // 0x00: File creation file
+	__le64 m_time; // 0x08: File modification time
+	__le64 c_time; // 0x10: Last time any attribute was modified.
+	__le64 a_time; // 0x18: File last access time
+	enum FILE_ATTRIBUTE fa; // 0x20: Standard DOS attributes & more
+	__le32 max_ver_num; // 0x24: Maximum Number of Versions
+	__le32 ver_num; // 0x28: Version Number
+	__le32 class_id; // 0x2C: Class Id from bidirectional Class Id index
+};
+
+static_assert(sizeof(struct ATTR_STD_INFO) == 0x30);
+
+#define SECURITY_ID_INVALID 0x00000000
+#define SECURITY_ID_FIRST 0x00000100
+
+struct ATTR_STD_INFO5 {
+	__le64 cr_time; // 0x00: File creation file
+	__le64 m_time; // 0x08: File modification time
+	__le64 c_time; // 0x10: Last time any attribute was modified.
+	__le64 a_time; // 0x18: File last access time
+	enum FILE_ATTRIBUTE fa; // 0x20: Standard DOS attributes & more
+	__le32 max_ver_num; // 0x24: Maximum Number of Versions
+	__le32 ver_num; // 0x28: Version Number
+	__le32 class_id; // 0x2C: Class Id from bidirectional Class Id index
+
+	__le32 owner_id; // 0x30: Owner Id of the user owning the file. This Id is a key
+		// in the $O and $Q Indexes of the file $Quota. If zero, then
+		// quotas are disabled
+	__le32 security_id; // 0x34: The Security Id is a key in the $SII Index and $SDS
+		// Data Stream in the file $Secure.
+	__le64 quota_charge; // 0x38: The number of bytes this file user from the user's
+		// quota. This should be the total data size of all streams.
+		// If zero, then quotas are disabled.
+	__le64 usn; // 0x40: Last Update Sequence Number of the file. This is a direct
+		// index into the file $UsnJrnl. If zero, the USN Journal is
+		// disabled.
+};
+
+static_assert(sizeof(struct ATTR_STD_INFO5) == 0x48);
+
+/* attribute list entry structure (0x20) */
+struct ATTR_LIST_ENTRY {
+	enum ATTR_TYPE type; // 0x00: The type of attribute
+	__le16 size; // 0x04: The size of this record
+	u8 name_len; // 0x06: The length of attribute name
+	u8 name_off; // 0x07: The offset to attribute name
+	__le64 vcn; // 0x08: Starting VCN of this attribute
+	struct MFT_REF ref; // 0x10: MFT record number with attribute
+	__le16 id; // 0x18: struct ATTRIB ID
+	__le16 name[3]; // 0x1A: Just to align. To get real name can use bNameOffset
+
+}; // sizeof(0x20)
+
+static_assert(sizeof(struct ATTR_LIST_ENTRY) == 0x20);
+
+static inline u32 le_size(u8 name_len)
+{
+	return QuadAlign(offsetof(struct ATTR_LIST_ENTRY, name) +
+			 name_len * sizeof(short));
+}
+
+/* returns 0 if 'attr' has the same type and name */
+static inline int le_cmp(const struct ATTR_LIST_ENTRY *le,
+			 const struct ATTRIB *attr)
+{
+	return le->type != attr->type || le->name_len != attr->name_len ||
+	       (!le->name_len &&
+		memcmp(Add2Ptr(le, le->name_off),
+		       Add2Ptr(attr, le16_to_cpu(attr->name_off)),
+		       le->name_len * sizeof(short)));
+}
+
+static inline const __le16 *le_name(const struct ATTR_LIST_ENTRY *le)
+{
+	return Add2Ptr(le, le->name_off);
+}
+
+/* File name types (the field type in struct ATTR_FILE_NAME ) */
+#define FILE_NAME_POSIX 0
+#define FILE_NAME_UNICODE 1
+#define FILE_NAME_DOS 2
+#define FILE_NAME_UNICODE_AND_DOS (FILE_NAME_DOS | FILE_NAME_UNICODE)
+
+/* Filename attribute structure (0x30) */
+struct NTFS_DUP_INFO {
+	__le64 cr_time; // 0x00: File creation file
+	__le64 m_time; // 0x08: File modification time
+	__le64 c_time; // 0x10: Last time any attribute was modified
+	__le64 a_time; // 0x18: File last access time
+	__le64 alloc_size; // 0x20: Data attribute allocated size, multiple of cluster size
+	__le64 data_size; // 0x28: Data attribute size <= Dataalloc_size
+	enum FILE_ATTRIBUTE fa; // 0x30: Standard DOS attributes & more
+	__le16 ea_size; // 0x34: Packed EAs
+	__le16 reparse; // 0x36: Used by Reparse
+
+}; // 0x38
+
+struct ATTR_FILE_NAME {
+	struct MFT_REF home; // 0x00: MFT record for directory
+	struct NTFS_DUP_INFO dup; // 0x08
+	u8 name_len; // 0x40: File name length in words
+	u8 type; // 0x41: File name type
+	__le16 name[1]; // 0x42: File name
+};
+
+static_assert(sizeof(((struct ATTR_FILE_NAME *)NULL)->dup) == 0x38);
+static_assert(offsetof(struct ATTR_FILE_NAME, name) == 0x42);
+#define SIZEOF_ATTRIBUTE_FILENAME 0x44
+#define SIZEOF_ATTRIBUTE_FILENAME_MAX (0x42 + 255 * 2)
+
+static inline struct ATTRIB *attr_from_name(struct ATTR_FILE_NAME *fname)
+{
+	return (struct ATTRIB *)((char *)fname - SIZEOF_RESIDENT);
+}
+
+static inline u16 fname_full_size(const struct ATTR_FILE_NAME *fname)
+{
+	return offsetof(struct ATTR_FILE_NAME, name) +
+	       fname->name_len * sizeof(short);
+}
+
+static inline u8 paired_name(u8 type)
+{
+	if (type == FILE_NAME_UNICODE)
+		return FILE_NAME_DOS;
+	if (type == FILE_NAME_DOS)
+		return FILE_NAME_UNICODE;
+	return FILE_NAME_POSIX;
+}
+
+/* Index entry defines ( the field flags in NtfsDirEntry ) */
+#define NTFS_IE_HAS_SUBNODES cpu_to_le16(1)
+#define NTFS_IE_LAST cpu_to_le16(2)
+
+/* Directory entry structure */
+struct NTFS_DE {
+	union {
+		struct MFT_REF ref; // 0x00: MFT record number with this file
+		struct {
+			__le16 data_off; // 0x00:
+			__le16 data_size; // 0x02:
+			__le32 Res; // 0x04: must be 0
+		} View;
+	};
+	__le16 size; // 0x08: The size of this entry
+	__le16 key_size; // 0x0A: The size of File name length in bytes + 0x42
+	__le16 flags; // 0x0C: Entry flags, 1=subnodes, 2=last
+	__le16 Reserved; // 0x0E:
+
+	// Here any indexed attribute can be placed
+	// One of them is:
+	// struct ATTR_FILE_NAME AttrFileName;
+	//
+
+	// The last 8 bytes of this structure contains
+	// the VBN of subnode
+	// !!! Note !!!
+	// This field is presented only if (flags & NTFS_IE_HAS_SUBNODES)
+	// __le64 vbn;
+};
+
+static_assert(sizeof(struct NTFS_DE) == 0x10);
+
+static inline void de_set_vbn_le(struct NTFS_DE *e, __le64 vcn)
+{
+	__le64 *v = Add2Ptr(e, le16_to_cpu(e->size) - sizeof(__le64));
+
+	*v = vcn;
+}
+
+static inline void de_set_vbn(struct NTFS_DE *e, CLST vcn)
+{
+	__le64 *v = Add2Ptr(e, le16_to_cpu(e->size) - sizeof(__le64));
+
+	*v = cpu_to_le64(vcn);
+}
+
+static inline __le64 de_get_vbn_le(const struct NTFS_DE *e)
+{
+	return *(__le64 *)Add2Ptr(e, le16_to_cpu(e->size) - sizeof(__le64));
+}
+
+static inline CLST de_get_vbn(const struct NTFS_DE *e)
+{
+	__le64 *v = Add2Ptr(e, le16_to_cpu(e->size) - sizeof(__le64));
+
+	return le64_to_cpu(*v);
+}
+
+static inline struct NTFS_DE *de_get_next(const struct NTFS_DE *e)
+{
+	return Add2Ptr(e, le16_to_cpu(e->size));
+}
+
+static inline struct ATTR_FILE_NAME *de_get_fname(const struct NTFS_DE *e)
+{
+	return le16_to_cpu(e->key_size) >= SIZEOF_ATTRIBUTE_FILENAME ?
+		       Add2Ptr(e, sizeof(struct NTFS_DE)) :
+		       NULL;
+}
+
+static inline bool de_is_last(const struct NTFS_DE *e)
+{
+	return e->flags & NTFS_IE_LAST;
+}
+
+static inline bool de_has_vcn(const struct NTFS_DE *e)
+{
+	return e->flags & NTFS_IE_HAS_SUBNODES;
+}
+
+static inline bool de_has_vcn_ex(const struct NTFS_DE *e)
+{
+	return (e->flags & NTFS_IE_HAS_SUBNODES) &&
+	       (u64)(-1) != *((u64 *)Add2Ptr(e, le16_to_cpu(e->size) -
+							sizeof(__le64)));
+}
+
+#define MAX_BYTES_PER_NAME_ENTRY                                               \
+	QuadAlign(sizeof(struct NTFS_DE) +                                     \
+		  offsetof(struct ATTR_FILE_NAME, name) +                      \
+		  NTFS_NAME_LEN * sizeof(short))
+
+struct INDEX_HDR {
+	// The offset from the start of this structure to the first NtfsDirEntry
+	__le32 de_off; // 0x00:
+	// The size of this structure plus all entries (quad-word aligned)
+	__le32 used; // 0x04
+	// The allocated size of for this structure plus all entries
+	__le32 total; // 0x08:
+	// 0x00 = Small directory, 0x01 = Large directory
+	u8 flags; // 0x0C
+	u8 res[3];
+
+	//
+	// de_off + used <= total
+	//
+};
+
+static_assert(sizeof(struct INDEX_HDR) == 0x10);
+
+static inline struct NTFS_DE *hdr_first_de(const struct INDEX_HDR *hdr)
+{
+	u32 de_off = le32_to_cpu(hdr->de_off);
+	u32 used = le32_to_cpu(hdr->used);
+	struct NTFS_DE *e = Add2Ptr(hdr, de_off);
+	u16 esize;
+
+	if (de_off >= used || de_off >= le32_to_cpu(hdr->total))
+		return NULL;
+
+	esize = le16_to_cpu(e->size);
+	if (esize < sizeof(struct NTFS_DE) || de_off + esize > used)
+		return NULL;
+
+	return e;
+}
+
+static inline struct NTFS_DE *hdr_next_de(const struct INDEX_HDR *hdr,
+					  const struct NTFS_DE *e)
+{
+	size_t off = PtrOffset(hdr, e);
+	u32 used = le32_to_cpu(hdr->used);
+	u16 esize;
+
+	if (off >= used)
+		return NULL;
+
+	esize = le16_to_cpu(e->size);
+
+	if (esize < sizeof(struct NTFS_DE) ||
+	    off + esize + sizeof(struct NTFS_DE) > used)
+		return NULL;
+
+	return Add2Ptr(e, esize);
+}
+
+static inline bool hdr_has_subnode(const struct INDEX_HDR *hdr)
+{
+	return hdr->flags & 1;
+}
+
+struct INDEX_BUFFER {
+	struct NTFS_RECORD_HEADER rhdr; // 'INDX'
+	__le64 vbn; // 0x10: vcn if index >= cluster or vsn id index < cluster
+	struct INDEX_HDR ihdr; // 0x18:
+};
+
+static_assert(sizeof(struct INDEX_BUFFER) == 0x28);
+
+static inline bool ib_is_empty(const struct INDEX_BUFFER *ib)
+{
+	const struct NTFS_DE *first = hdr_first_de(&ib->ihdr);
+
+	return !first || de_is_last(first);
+}
+
+static inline bool ib_is_leaf(const struct INDEX_BUFFER *ib)
+{
+	return !(ib->ihdr.flags & 1);
+}
+
+/* Index root structure ( 0x90 ) */
+enum COLLATION_RULE {
+	NTFS_COLLATION_TYPE_BINARY = cpu_to_le32(0),
+	NTFS_COLLATION_TYPE_FILENAME = cpu_to_le32(0x01),
+	// $SII of $Secure / $Q of Quota
+	NTFS_COLLATION_TYPE_UINT = cpu_to_le32(0x10),
+	// $O of Quota
+	NTFS_COLLATION_TYPE_SID = cpu_to_le32(0x11),
+	// $SDH of $Secure
+	NTFS_COLLATION_TYPE_SECURITY_HASH = cpu_to_le32(0x12),
+	// $O of ObjId and "$R" for Reparse
+	NTFS_COLLATION_TYPE_UINTS = cpu_to_le32(0x13)
+};
+
+static_assert(sizeof(enum COLLATION_RULE) == 4);
+
+//
+struct INDEX_ROOT {
+	enum ATTR_TYPE type; // 0x00: The type of attribute to index on
+	enum COLLATION_RULE rule; // 0x04: The rule
+	__le32 index_block_size; // 0x08: The size of index record
+	u8 index_block_clst; // 0x0C: The number of clusters per index
+	u8 res[3];
+	struct INDEX_HDR ihdr; // 0x10:
+};
+
+static_assert(sizeof(struct INDEX_ROOT) == 0x20);
+static_assert(offsetof(struct INDEX_ROOT, ihdr) == 0x10);
+
+#define VOLUME_FLAG_DIRTY cpu_to_le16(0x0001)
+#define VOLUME_FLAG_RESIZE_LOG_FILE cpu_to_le16(0x0002)
+
+struct VOLUME_INFO {
+	__le64 res1; // 0x00
+	u8 major_ver; // 0x08: NTFS major version number (before .)
+	u8 minor_ver; // 0x09: NTFS minor version number (after .)
+	__le16 flags; // 0x0A: Volume flags, see VOLUME_FLAG_XXX
+
+}; // sizeof=0xC
+
+#define SIZEOF_ATTRIBUTE_VOLUME_INFO 0xc
+
+#define NTFS_LABEL_MAX_LENGTH (0x100 / sizeof(short))
+#define NTFS_ATTR_INDEXABLE cpu_to_le32(0x00000002)
+#define NTFS_ATTR_DUPALLOWED cpu_to_le32(0x00000004)
+#define NTFS_ATTR_MUST_BE_INDEXED cpu_to_le32(0x00000010)
+#define NTFS_ATTR_MUST_BE_NAMED cpu_to_le32(0x00000020)
+#define NTFS_ATTR_MUST_BE_RESIDENT cpu_to_le32(0x00000040)
+#define NTFS_ATTR_LOG_ALWAYS cpu_to_le32(0x00000080)
+
+/* $AttrDef file entry */
+struct ATTR_DEF_ENTRY {
+	__le16 name[0x40]; // 0x00: Attr name
+	enum ATTR_TYPE type; // 0x80: struct ATTRIB type
+	__le32 res; // 0x84:
+	enum COLLATION_RULE rule; // 0x88:
+	__le32 flags; // 0x8C: NTFS_ATTR_XXX (see above)
+	__le64 min_sz; // 0x90: Minimum attribute data size
+	__le64 max_sz; // 0x98: Maximum attribute data size
+};
+
+static_assert(sizeof(struct ATTR_DEF_ENTRY) == 0xa0);
+
+/* Object ID (0x40) */
+struct OBJECT_ID {
+	struct GUID ObjId; // 0x00: Unique Id assigned to file
+	struct GUID
+		BirthVolumeId; // 0x10: Birth Volume Id is the Object Id of the Volume on
+	// which the Object Id was allocated. It never changes
+	struct GUID
+		BirthObjectId; // 0x20: Birth Object Id is the first Object Id that was
+	// ever assigned to this MFT Record. I.e. If the Object Id
+	// is changed for some reason, this field will reflect the
+	// original value of the Object Id.
+	struct GUID
+		DomainId; // 0x30: Domain Id is currently unused but it is intended to be
+	// used in a network environment where the local machine is
+	// part of a Windows 2000 Domain. This may be used in a Windows
+	// 2000 Advanced Server managed domain.
+};
+
+static_assert(sizeof(struct OBJECT_ID) == 0x40);
+
+/* O Directory entry structure ( rule = 0x13 ) */
+struct NTFS_DE_O {
+	struct NTFS_DE de;
+	// See struct OBJECT_ID (0x40) for details
+	struct GUID ObjId; // 0x10: Unique Id assigned to file
+	struct MFT_REF ref; // 0x20: MFT record number with this file
+	struct GUID
+		BirthVolumeId; // 0x28: Birth Volume Id is the Object Id of the Volume on
+	// which the Object Id was allocated. It never changes
+	struct GUID
+		BirthObjectId; // 0x38: Birth Object Id is the first Object Id that was
+	// ever assigned to this MFT Record. I.e. If the Object Id
+	// is changed for some reason, this field will reflect the
+	// original value of the Object Id.
+	// This field is valid if data_size == 0x48
+	struct GUID
+		BirthDomainId; // 0x48: Domain Id is currently unused but it is intended
+	// to be used in a network environment where the local
+	// machine is part of a Windows 2000 Domain. This may be
+	// used in a Windows 2000 Advanced Server managed domain.
+
+	// The last 8 bytes of this structure contains
+	// the VCN of subnode
+	// !!! Note !!!
+	// This field is presented only if (flags & 0x1)
+	// __le64             SubnodesVCN;
+};
+
+static_assert(sizeof(struct NTFS_DE_O) == 0x58);
+
+#define NTFS_OBJECT_ENTRY_DATA_SIZE1                                           \
+	0x38 // struct NTFS_DE_O.BirthDomainId is not used
+#define NTFS_OBJECT_ENTRY_DATA_SIZE2                                           \
+	0x48 // struct NTFS_DE_O.BirthDomainId is used
+
+/* Q Directory entry structure ( rule = 0x11 ) */
+struct NTFS_DE_Q {
+	struct NTFS_DE de;
+	__le32 owner_id; // 0x10: Unique Id assigned to file
+	__le32 Version; // 0x14: 0x02
+	__le32 flags2; // 0x18: Quota flags, see above
+	__le64 BytesUsed; // 0x1C:
+	__le64 ChangeTime; // 0x24:
+	__le64 WarningLimit; // 0x28:
+	__le64 HardLimit; // 0x34:
+	__le64 ExceededTime; // 0x3C:
+
+	// SID is placed here
+
+	// The last 8 bytes of this structure contains
+	// the VCN of subnode
+	// !!! Note !!!
+	// This field is presented only if (flags & 0x1)
+	// __le64             SubnodesVCN;
+
+}; // __attribute__ ((packed)); // sizeof() = 0x44
+
+#define SIZEOF_NTFS_DE_Q 0x44
+
+#define SecurityDescriptorsBlockSize 0x40000 // 256K
+#define SecurityDescriptorMaxSize 0x20000 // 128K
+#define Log2OfSecurityDescriptorsBlockSize 18
+
+struct SECURITY_KEY {
+	__le32 hash; //  Hash value for descriptor
+	__le32 sec_id; //  Security Id (guaranteed unique)
+};
+
+/* Security descriptors (the content of $Secure::SDS data stream) */
+struct SECURITY_HDR {
+	struct SECURITY_KEY key; // 0x00: Security Key
+	__le64 off; // 0x08: Offset of this entry in the file
+	__le32 size; // 0x10: Size of this entry, 8 byte aligned
+	//
+	// Security descriptor itself is placed here
+	// Total size is 16 byte aligned
+	//
+
+} __packed;
+
+#define SIZEOF_SECURITY_HDR 0x14
+
+/* SII Directory entry structure */
+struct NTFS_DE_SII {
+	struct NTFS_DE de;
+	__le32 sec_id; // 0x10: Key: sizeof(security_id) = wKeySize
+	struct SECURITY_HDR sec_hdr; // 0x14:
+
+} __packed;
+
+#define SIZEOF_SII_DIRENTRY 0x28
+
+/* SDH Directory entry structure */
+struct NTFS_DE_SDH {
+	struct NTFS_DE de;
+	struct SECURITY_KEY key; // 0x10: Key
+	struct SECURITY_HDR sec_hdr; // 0x18: Data
+	__le16 magic[2]; // 0x2C: 0x00490049 "I I"
+};
+
+#define SIZEOF_SDH_DIRENTRY 0x30
+
+struct REPARSE_KEY {
+	__le32 ReparseTag; // 0x00: Reparse Tag
+	struct MFT_REF ref; // 0x04: MFT record number with this file
+
+}; // sizeof() = 0x0C
+
+static_assert(offsetof(struct REPARSE_KEY, ref) == 0x04);
+#define SIZEOF_REPARSE_KEY 0x0C
+
+/* Reparse Directory entry structure */
+struct NTFS_DE_R {
+	struct NTFS_DE de;
+	struct REPARSE_KEY Key; // 0x10: Reparse Key (Tag + struct MFT_REF)
+
+	// The last 8 bytes of this structure contains
+	// the VCN of subnode
+	// !!! Note !!!
+	// This field is presented only if (flags & 0x1)
+	// __le64             SubnodesVCN;
+
+}; // sizeof() = 0x1C
+
+#define SIZEOF_R_DIRENTRY 0x1C
+
+/* CompressReparseBuffer.WofVersion */
+#define WOF_CURRENT_VERSION cpu_to_le32(1)
+/* CompressReparseBuffer.WofProvider */
+#define WOF_PROVIDER_WIM cpu_to_le32(1)
+/* CompressReparseBuffer.WofProvider */
+#define WOF_PROVIDER_SYSTEM cpu_to_le32(2)
+/* CompressReparseBuffer.ProviderVer */
+#define WOF_PROVIDER_CURRENT_VERSION cpu_to_le32(1)
+
+#define WOF_COMPRESSION_XPRESS4K 0 // 4k
+#define WOF_COMPRESSION_LZX 1 // 32k
+#define WOF_COMPRESSION_XPRESS8K 2 // 8k
+#define WOF_COMPRESSION_XPRESS16K 3 // 16k
+
+/*
+ * ATTR_REPARSE (0xC0)
+ *
+ * The reparse struct GUID structure is used by all 3rd party layered drivers to
+ * store data in a reparse point. For non-Microsoft tags, The struct GUID field
+ * cannot be GUID_NULL.
+ * The constraints on reparse tags are defined below.
+ * Microsoft tags can also be used with this format of the reparse point buffer.
+ */
+struct REPARSE_POINT {
+	__le32 ReparseTag; // 0x00:
+	__le16 ReparseDataLength; // 0x04:
+	__le16 Reserved;
+
+	struct GUID Guid; // 0x08:
+
+	//
+	// Here GenericReparseBuffer is placed
+	//
+};
+
+static_assert(sizeof(struct REPARSE_POINT) == 0x18);
+
+//
+// Maximum allowed size of the reparse data.
+//
+#define MAXIMUM_REPARSE_DATA_BUFFER_SIZE (16 * 1024)
+
+//
+// The value of the following constant needs to satisfy the following
+// conditions:
+//  (1) Be at least as large as the largest of the reserved tags.
+//  (2) Be strictly smaller than all the tags in use.
+//
+#define IO_REPARSE_TAG_RESERVED_RANGE 1
+
+//
+// The reparse tags are a ULONG. The 32 bits are laid out as follows:
+//
+//   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
+//   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+//  +-+-+-+-+-----------------------+-------------------------------+
+//  |M|R|N|R|     Reserved bits     |       Reparse Tag Value       |
+//  +-+-+-+-+-----------------------+-------------------------------+
+//
+// M is the Microsoft bit. When set to 1, it denotes a tag owned by Microsoft.
+//   All ISVs must use a tag with a 0 in this position.
+//   Note: If a Microsoft tag is used by non-Microsoft software, the
+//   behavior is not defined.
+//
+// R is reserved.  Must be zero for non-Microsoft tags.
+//
+// N is name surrogate. When set to 1, the file represents another named
+//   entity in the system.
+//
+// The M and N bits are OR-able.
+// The following macros check for the M and N bit values:
+//
+
+//
+// Macro to determine whether a reparse point tag corresponds to a tag
+// owned by Microsoft.
+//
+#define IsReparseTagMicrosoft(_tag) (((_tag)&IO_REPARSE_TAG_MICROSOFT))
+
+//
+// Macro to determine whether a reparse point tag is a name surrogate
+//
+#define IsReparseTagNameSurrogate(_tag) (((_tag)&IO_REPARSE_TAG_NAME_SURROGATE))
+
+//
+// The following constant represents the bits that are valid to use in
+// reparse tags.
+//
+#define IO_REPARSE_TAG_VALID_VALUES 0xF000FFFF
+
+//
+// Macro to determine whether a reparse tag is a valid tag.
+//
+#define IsReparseTagValid(_tag)                                                \
+	(!((_tag) & ~IO_REPARSE_TAG_VALID_VALUES) &&                           \
+	 ((_tag) > IO_REPARSE_TAG_RESERVED_RANGE))
+
+//
+// Microsoft tags for reparse points.
+//
+
+enum IO_REPARSE_TAG {
+	IO_REPARSE_TAG_SYMBOLIC_LINK = cpu_to_le32(0),
+	IO_REPARSE_TAG_NAME_SURROGATE = cpu_to_le32(0x20000000),
+	IO_REPARSE_TAG_MICROSOFT = cpu_to_le32(0x80000000),
+	IO_REPARSE_TAG_MOUNT_POINT = cpu_to_le32(0xA0000003),
+	IO_REPARSE_TAG_SYMLINK = cpu_to_le32(0xA000000C),
+	IO_REPARSE_TAG_HSM = cpu_to_le32(0xC0000004),
+	IO_REPARSE_TAG_SIS = cpu_to_le32(0x80000007),
+	IO_REPARSE_TAG_DEDUP = cpu_to_le32(0x80000013),
+	IO_REPARSE_TAG_COMPRESS = cpu_to_le32(0x80000017),
+
+	//
+	// The reparse tag 0x80000008 is reserved for Microsoft internal use
+	// (may be published in the future)
+	//
+
+	//
+	// Microsoft reparse tag reserved for DFS
+	//
+	IO_REPARSE_TAG_DFS = cpu_to_le32(0x8000000A),
+
+	//
+	// Microsoft reparse tag reserved for the file system filter manager
+	//
+	IO_REPARSE_TAG_FILTER_MANAGER = cpu_to_le32(0x8000000B),
+
+	//
+	// Non-Microsoft tags for reparse points
+	//
+
+	//
+	// Tag allocated to CONGRUENT, May 2000. Used by IFSTEST
+	//
+	IO_REPARSE_TAG_IFSTEST_CONGRUENT = cpu_to_le32(0x00000009),
+
+	//
+	// Tag allocated to ARKIVIO
+	//
+	IO_REPARSE_TAG_ARKIVIO = cpu_to_le32(0x0000000C),
+
+	//
+	//  Tag allocated to SOLUTIONSOFT
+	//
+	IO_REPARSE_TAG_SOLUTIONSOFT = cpu_to_le32(0x2000000D),
+
+	//
+	//  Tag allocated to COMMVAULT
+	//
+	IO_REPARSE_TAG_COMMVAULT = cpu_to_le32(0x0000000E),
+
+	// OneDrive??
+	IO_REPARSE_TAG_CLOUD = cpu_to_le32(0x9000001A),
+	IO_REPARSE_TAG_CLOUD_1 = cpu_to_le32(0x9000101A),
+	IO_REPARSE_TAG_CLOUD_2 = cpu_to_le32(0x9000201A),
+	IO_REPARSE_TAG_CLOUD_3 = cpu_to_le32(0x9000301A),
+	IO_REPARSE_TAG_CLOUD_4 = cpu_to_le32(0x9000401A),
+	IO_REPARSE_TAG_CLOUD_5 = cpu_to_le32(0x9000501A),
+	IO_REPARSE_TAG_CLOUD_6 = cpu_to_le32(0x9000601A),
+	IO_REPARSE_TAG_CLOUD_7 = cpu_to_le32(0x9000701A),
+	IO_REPARSE_TAG_CLOUD_8 = cpu_to_le32(0x9000801A),
+	IO_REPARSE_TAG_CLOUD_9 = cpu_to_le32(0x9000901A),
+	IO_REPARSE_TAG_CLOUD_A = cpu_to_le32(0x9000A01A),
+	IO_REPARSE_TAG_CLOUD_B = cpu_to_le32(0x9000B01A),
+	IO_REPARSE_TAG_CLOUD_C = cpu_to_le32(0x9000C01A),
+	IO_REPARSE_TAG_CLOUD_D = cpu_to_le32(0x9000D01A),
+	IO_REPARSE_TAG_CLOUD_E = cpu_to_le32(0x9000E01A),
+	IO_REPARSE_TAG_CLOUD_F = cpu_to_le32(0x9000F01A),
+
+};
+
+/* Microsoft reparse buffer. (see DDK for details) */
+struct REPARSE_DATA_BUFFER {
+	__le32 ReparseTag; // 0x00:
+	__le16 ReparseDataLength; // 0x04:
+	__le16 Reserved;
+
+	union {
+		// If ReparseTag == 0
+		struct {
+			__le16 SubstituteNameOffset; // 0x08
+			__le16 SubstituteNameLength; // 0x0A
+			__le16 PrintNameOffset; // 0x0C
+			__le16 PrintNameLength; // 0x0E
+			__le16 PathBuffer[1]; // 0x10
+		} SymbolicLinkReparseBuffer;
+
+		// If ReparseTag == 0xA0000003U
+		struct {
+			__le16 SubstituteNameOffset; // 0x08
+			__le16 SubstituteNameLength; // 0x0A
+			__le16 PrintNameOffset; // 0x0C
+			__le16 PrintNameLength; // 0x0E
+			__le16 PathBuffer[1]; // 0x10
+		} MountPointReparseBuffer;
+
+		// If ReparseTag == IO_REPARSE_TAG_SYMLINK2       (0xA000000CU)
+		// https://msdn.microsoft.com/en-us/library/cc232006.aspx
+		struct {
+			__le16 SubstituteNameOffset; // 0x08
+			__le16 SubstituteNameLength; // 0x0A
+			__le16 PrintNameOffset; // 0x0C
+			__le16 PrintNameLength; // 0x0E
+			// 0-absolute path 1- relative path
+			__le32 Flags; // 0x10
+			__le16 PathBuffer[1]; // 0x14
+		} SymbolicLink2ReparseBuffer;
+
+		// If ReparseTag == 0x80000017U
+		struct {
+			__le32 WofVersion; // 0x08 == 1
+			/* 1 - WIM backing provider ("WIMBoot"),
+			 * 2 - System compressed file provider
+			 */
+			__le32 WofProvider; // 0x0C
+			__le32 ProviderVer; // 0x10: == 1 WOF_FILE_PROVIDER_CURRENT_VERSION == 1
+			__le32 CompressionFormat; // 0x14: 0, 1, 2, 3. See WOF_COMPRESSION_XXX
+		} CompressReparseBuffer;
+
+		struct {
+			u8 DataBuffer[1]; // 0x08
+		} GenericReparseBuffer;
+	};
+};
+
+static inline u32 ntfs_reparse_bytes(u32 uni_len)
+{
+	return sizeof(short) * (2 * uni_len + 4) +
+	       offsetof(struct REPARSE_DATA_BUFFER,
+			SymbolicLink2ReparseBuffer.PathBuffer);
+}
+
+/* ATTR_EA_INFO (0xD0) */
+
+#define FILE_NEED_EA 0x80 // See ntifs.h
+/* FILE_NEED_EA, indicates that the file to which the EA belongs cannot be
+ * interpreted without understanding the associated extended attributes.
+ */
+struct EA_INFO {
+	__le16 size_pack; // 0x00: Size of buffer to hold in packed form
+	__le16 count; // 0x02: Count of EA's with FILE_NEED_EA bit set
+	__le32 size; // 0x04: Size of buffer to hold in unpacked form
+};
+
+static_assert(sizeof(struct EA_INFO) == 8);
+
+/* ATTR_EA (0xE0) */
+struct EA_FULL {
+	__le32 size; // 0x00: (not in packed)
+	u8 flags; // 0x04
+	u8 name_len; // 0x05
+	__le16 elength; // 0x06
+	u8 name[1]; // 0x08
+};
+
+static_assert(offsetof(struct EA_FULL, name) == 8);
+
+#define MAX_EA_DATA_SIZE (256 * 1024)
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
new file mode 100644
index 000000000000..a28ccc36b288
--- /dev/null
+++ b/fs/ntfs3/ntfs_fs.h
@@ -0,0 +1,1001 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  linux/fs/ntfs3/ntfs_fs.h
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+/* "true" when [s,s+c) intersects with [l,l+w) */
+#define IS_IN_RANGE(s, c, l, w)                                                \
+	(((c) > 0 && (w) > 0) &&                                               \
+	 (((l) <= (s) && (s) < ((l) + (w))) ||                                 \
+	  ((s) <= (l) && ((s) + (c)) >= ((l) + (w))) ||                        \
+	  ((l) < ((s) + (c)) && ((s) + (c)) < ((l) + (w)))))
+
+/* "true" when [s,se) intersects with [l,le) */
+#define IS_IN_RANGE2(s, se, l, le)                                             \
+	(((se) > (s) && (le) > (l)) &&                                         \
+	 (((l) <= (s) && (s) < (le)) || ((s) <= (l) && (se) >= (le)) ||        \
+	  ((l) < (se) && (se) < (le))))
+
+#define MINUS_ONE_T ((size_t)(-1))
+/* Biggest MFT / smallest cluster */
+#define MAXIMUM_BYTES_PER_MFT 4096 // ??
+#define NTFS_BLOCKS_PER_MFT_RECORD (MAXIMUM_BYTES_PER_MFT / 512)
+
+#define MAXIMUM_BYTES_PER_INDEX 4096 // ??
+#define NTFS_BLOCKS_PER_INODE (MAXIMUM_BYTES_PER_INDEX / 512)
+
+struct ntfs_inode;
+struct ntfs_sb_info;
+struct lznt;
+
+struct mount_options {
+	kuid_t fs_uid;
+	kgid_t fs_gid;
+	u16 fs_fmask_inv;
+	u16 fs_dmask_inv;
+
+	unsigned uid : 1, /* uid was set */
+		gid : 1, /* gid was set */
+		fmask : 1, /* fmask was set */
+		dmask : 1, /*dmask was set*/
+		sys_immutable : 1, /* set = system files are immutable */
+		discard : 1, /* issue discard requests on deletions */
+		sparse : 1, /*create sparse files*/
+		showmeta : 1, /*show meta files*/
+		nohidden : 1, /*do not show hidden files*/
+		force : 1, /*rw mount dirty volume*/
+		no_acs_rules : 1, /*exclude acs rules*/
+		prealloc : 1 /*preallocate space when file is growing*/
+		;
+};
+
+struct ntfs_run;
+
+/* TODO: use rb tree instead of array */
+struct runs_tree {
+	struct ntfs_run *runs_;
+	size_t count; // Currently used size a ntfs_run storage.
+	size_t allocated; // Currently allocated ntfs_run storage size.
+};
+
+struct ntfs_buffers {
+	/* Biggest MFT / smallest cluster = 4096 / 512 = 8 */
+	/* Biggest index / smallest cluster = 4096 / 512 = 8 */
+	struct buffer_head *bh[PAGE_SIZE >> SECTOR_SHIFT];
+	u32 bytes;
+	u32 nbufs;
+	u32 off;
+};
+
+#define NTFS_FLAGS_NODISCARD 0x00000001
+#define NTFS_FLAGS_NEED_REPLAY 0x04000000
+
+enum ALLOCATE_OPT {
+	ALLOCATE_DEF = 0, // Allocate all clusters
+	ALLOCATE_MFT = 1, // Allocate for MFT
+};
+
+enum bitmap_mutex_classes {
+	BITMAP_MUTEX_CLUSTERS = 0,
+	BITMAP_MUTEX_MFT = 1,
+};
+
+struct wnd_bitmap {
+	struct super_block *sb;
+	struct rw_semaphore rw_lock;
+
+	struct runs_tree run;
+	size_t nbits;
+
+	u16 free_holder[8]; // holder for free_bits
+
+	size_t total_zeroes; // total number of free bits
+	u16 *free_bits; // free bits in each window
+	size_t nwnd;
+	u32 bits_last; // bits in last window
+
+	struct rb_root start_tree; // extents, sorted by 'start'
+	struct rb_root count_tree; // extents, sorted by 'count + start'
+	size_t count; // extents count
+	int uptodated; // -1 Tree is activated but not updated (too many fragments)
+		// 0 - Tree is not activated
+		// 1 - Tree is activated and updated
+	size_t extent_min; // Minimal extent used while building
+	size_t extent_max; // Upper estimate of biggest free block
+
+	bool set_tail; // not necessary in driver
+	bool inited;
+
+	/* Zone [bit, end) */
+	size_t zone_bit;
+	size_t zone_end;
+};
+
+typedef int (*NTFS_CMP_FUNC)(const void *key1, size_t len1, const void *key2,
+			     size_t len2, const void *param);
+
+enum index_mutex_classed {
+	INDEX_MUTEX_I30 = 0,
+	INDEX_MUTEX_SII = 1,
+	INDEX_MUTEX_SDH = 2,
+	INDEX_MUTEX_SO = 3,
+	INDEX_MUTEX_SQ = 4,
+	INDEX_MUTEX_SR = 5,
+	INDEX_MUTEX_TOTAL
+};
+
+/* This struct works with indexes */
+struct ntfs_index {
+	struct runs_tree bitmap_run;
+	struct runs_tree alloc_run;
+
+	/*TODO: remove 'cmp'*/
+	NTFS_CMP_FUNC cmp;
+
+	u8 index_bits; // log2(root->index_block_size)
+	u8 idx2vbn_bits; // log2(root->index_block_clst)
+	u8 vbn2vbo_bits; // index_block_size < cluster? 9 : cluster_bits
+	u8 changed; // set when tree is changed
+	u8 type; // index_mutex_classed
+};
+
+/* Set when $LogFile is replaying */
+#define NTFS_FLAGS_LOG_REPLAING 0x00000008
+
+/* Set when we changed first MFT's which copy must be updated in $MftMirr */
+#define NTFS_FLAGS_MFTMIRR 0x00001000
+
+/* Minimum mft zone */
+#define NTFS_MIN_MFT_ZONE 100
+
+struct COMPRESS_CTX {
+	u64 chunk_num; // Number of chunk cmpr_buffer/unc_buffer
+	u64 first_chunk, last_chunk, total_chunks;
+	u64 chunk0_off;
+	void *ctx;
+	u8 *cmpr_buffer;
+	u8 *unc_buffer;
+	void *chunk_off_mem;
+	size_t chunk_off;
+	u32 *chunk_off32; // pointer inside ChunkOffsetsMem
+	u64 *chunk_off64; // pointer inside ChunkOffsetsMem
+	u32 compress_format;
+	u32 offset_bits;
+	u32 chunk_bits;
+	u32 chunk_size;
+};
+
+/* ntfs file system in-core superblock data */
+struct ntfs_sb_info {
+	struct super_block *sb;
+
+	u32 discard_granularity;
+	u64 discard_granularity_mask_inv; // ~(discard_granularity_mask_inv-1)
+
+	u32 cluster_size; // bytes per cluster
+	u32 cluster_mask; // == cluster_size - 1
+	u64 cluster_mask_inv; // ~(cluster_size - 1)
+	u32 block_mask; // sb->s_blocksize - 1
+	u32 blocks_per_cluster; // cluster_size / sb->s_blocksize
+
+	u32 record_size;
+	u32 sector_size;
+	u32 index_size;
+
+	u8 sector_bits;
+	u8 cluster_bits;
+	u8 record_bits;
+
+	u64 maxbytes; // Maximum size for normal files
+	u64 maxbytes_sparse; // Maximum size for sparse file
+
+	u32 flags; // See NTFS_FLAGS_XXX
+
+	CLST bad_clusters; // The count of marked bad clusters
+
+	u16 max_bytes_per_attr; // maximum attribute size in record
+	u16 attr_size_tr; // attribute size threshold (320 bytes)
+
+	/* Records in $Extend */
+	CLST objid_no;
+	CLST quota_no;
+	CLST reparse_no;
+	CLST usn_jrnl_no;
+
+	struct ATTR_DEF_ENTRY *def_table; // attribute definition table
+	u32 def_entries;
+
+	struct MFT_REC *new_rec;
+
+	u16 *upcase;
+
+	struct nls_table *nls; /*use utf8 if nls==NULL*/
+
+	struct {
+		u64 lbo, lbo2;
+		struct ntfs_inode *ni;
+		struct wnd_bitmap bitmap; // $MFT::Bitmap
+		ulong reserved_bitmap;
+		size_t next_free; // The next record to allocate from
+		size_t used;
+		u32 recs_mirr; // Number of records MFTMirr
+		u8 next_reserved;
+		u8 reserved_bitmap_inited;
+	} mft;
+
+	struct {
+		struct wnd_bitmap bitmap; // $Bitmap::Data
+		CLST next_free_lcn;
+	} used;
+
+	struct {
+		u64 size; // in bytes
+		u64 blocks; // in blocks
+		u64 ser_num;
+		struct ntfs_inode *ni;
+		__le16 flags; // see VOLUME_FLAG_XXX
+		u8 major_ver;
+		u8 minor_ver;
+		char label[65];
+		bool real_dirty; /* real fs state*/
+	} volume;
+
+	struct {
+		struct ntfs_index index_sii;
+		struct ntfs_index index_sdh;
+		struct ntfs_inode *ni;
+		u32 next_id;
+		u64 next_off;
+
+		__le32 def_file_id;
+		__le32 def_dir_id;
+	} security;
+
+	struct {
+		struct ntfs_index index_r;
+		struct ntfs_inode *ni;
+		u64 max_size; // 16K
+	} reparse;
+
+	struct {
+		struct ntfs_index index_o;
+		struct ntfs_inode *ni;
+	} objid;
+
+	struct {
+		/*protect 'frame_unc' and 'ctx'*/
+		spinlock_t lock;
+		u8 *frame_unc;
+		struct lznt *ctx;
+	} compress;
+
+	struct mount_options options;
+	struct ratelimit_state msg_ratelimit;
+};
+
+struct mft_inode {
+	struct rb_node node;
+	struct ntfs_sb_info *sbi;
+
+	CLST rno;
+	struct MFT_REC *mrec;
+	struct ntfs_buffers nb;
+
+	bool dirty;
+};
+
+#define NI_FLAG_DIR 0x00000001
+#define NI_FLAG_RESIDENT 0x00000002
+#define NI_FLAG_UPDATE_PARENT 0x00000004
+
+/* Data attribute is compressed special way */
+#define NI_FLAG_COMPRESSED_MASK 0x00000f00 //
+/* Data attribute is deduplicated */
+#define NI_FLAG_DEDUPLICATED 0x00001000
+#define NI_FLAG_EA 0x00002000
+
+/* ntfs file system inode data memory */
+struct ntfs_inode {
+	struct mft_inode mi; // base record
+
+	loff_t i_valid; /* valid size */
+	struct timespec64 i_crtime;
+
+	struct mutex ni_lock;
+
+	/* file attributes from std */
+	enum FILE_ATTRIBUTE std_fa;
+	__le32 std_security_id;
+
+	// subrecords tree
+	struct rb_root mi_tree;
+
+	union {
+		struct ntfs_index dir;
+		struct {
+			struct rw_semaphore run_lock;
+			struct runs_tree run;
+		} file;
+	};
+
+	struct {
+		struct runs_tree run;
+		void *le; // 1K aligned memory
+		size_t size;
+		bool dirty;
+	} attr_list;
+
+	size_t ni_flags; // NI_FLAG_XXX
+
+	struct inode vfs_inode;
+};
+
+struct indx_node {
+	struct ntfs_buffers nb;
+	struct INDEX_BUFFER *index;
+};
+
+struct ntfs_fnd {
+	int level;
+	struct indx_node *nodes[20];
+	struct NTFS_DE *de[20];
+	struct NTFS_DE *root_de;
+};
+
+enum REPARSE_SIGN {
+	REPARSE_NONE = 0,
+	REPARSE_COMPRESSED = 1,
+	REPARSE_DEDUPLICATED = 2,
+	REPARSE_LINK = 3
+};
+
+/* functions from attrib.c*/
+int attr_load_runs(struct ATTRIB *attr, struct ntfs_inode *ni,
+		   struct runs_tree *run);
+int attr_allocate_clusters(struct ntfs_sb_info *sbi, struct runs_tree *run,
+			   CLST vcn, CLST lcn, CLST len, CLST *pre_alloc,
+			   enum ALLOCATE_OPT opt, CLST *alen, const size_t fr,
+			   CLST *new_lcn);
+int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		  const __le16 *name, u8 name_len, struct runs_tree *run,
+		  u64 new_size, const u64 *new_valid, bool keep_prealloc,
+		  struct ATTRIB **ret);
+int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST *lcn, CLST *len,
+			bool *new);
+int attr_load_runs_vcn(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		       const __le16 *name, u8 name_len, struct runs_tree *run,
+		       CLST vcn);
+int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
+			     CLST frame, CLST *clst_data, bool *is_compr);
+int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
+			u64 new_valid);
+
+/* functions from attrlist.c*/
+void al_destroy(struct ntfs_inode *ni);
+bool al_verify(struct ntfs_inode *ni);
+int ntfs_load_attr_list(struct ntfs_inode *ni, struct ATTRIB *attr);
+struct ATTR_LIST_ENTRY *al_enumerate(struct ntfs_inode *ni,
+				     struct ATTR_LIST_ENTRY *le);
+struct ATTR_LIST_ENTRY *al_find_le(struct ntfs_inode *ni,
+				   struct ATTR_LIST_ENTRY *le,
+				   const struct ATTRIB *attr);
+struct ATTR_LIST_ENTRY *al_find_ex(struct ntfs_inode *ni,
+				   struct ATTR_LIST_ENTRY *le,
+				   enum ATTR_TYPE type, const __le16 *name,
+				   u8 name_len, const CLST *vcn);
+int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
+	      u8 name_len, CLST svcn, __le16 id, const struct MFT_REF *ref,
+	      struct ATTR_LIST_ENTRY **new_le);
+bool al_remove_le(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le);
+bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
+		  const __le16 *name, size_t name_len,
+		  const struct MFT_REF *ref);
+int al_update(struct ntfs_inode *ni);
+static inline size_t al_aligned(size_t size)
+{
+	return (size + 1023) & ~(size_t)1023;
+}
+
+/* globals from bitfunc.c */
+bool are_bits_clear(const ulong *map, size_t bit, size_t nbits);
+bool are_bits_set(const ulong *map, size_t bit, size_t nbits);
+size_t get_set_bits_ex(const ulong *map, size_t bit, size_t nbits);
+
+/* globals from dir.c */
+int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
+		      u8 *buf, int buf_len);
+int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
+		      struct cpu_str *uni, u32 max_ulen,
+		      enum utf16_endian endian);
+struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
+			   struct ntfs_fnd *fnd);
+struct inode *dir_search(struct inode *dir, const struct qstr *name,
+			 struct ntfs_fnd *fnd);
+bool dir_is_empty(struct inode *dir);
+extern const struct file_operations ntfs_dir_operations;
+
+/* globals from file.c*/
+int ntfs_getattr(const struct path *path, struct kstat *stat, u32 request_mask,
+		 u32 flags);
+void ntfs_sparse_cluster(struct inode *inode, struct page *page0, loff_t vbo,
+			 u32 bytes);
+int ntfs_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync);
+void ntfs_truncate_blocks(struct inode *inode, loff_t offset);
+int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
+int ntfs_file_open(struct inode *inode, struct file *file);
+int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		__u64 start, __u64 len);
+extern const struct inode_operations ntfs_special_inode_operations;
+extern const struct inode_operations ntfs_file_inode_operations;
+extern const struct file_operations ntfs_file_operations;
+
+/* globals from frecord.c */
+void ni_remove_mi(struct ntfs_inode *ni, struct mft_inode *mi);
+struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni);
+void ni_clear(struct ntfs_inode *ni);
+int ni_load_mi_ex(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi);
+int ni_load_mi(struct ntfs_inode *ni, struct ATTR_LIST_ENTRY *le,
+	       struct mft_inode **mi);
+struct ATTRIB *ni_find_attr(struct ntfs_inode *ni, struct ATTRIB *attr,
+			    struct ATTR_LIST_ENTRY **entry_o,
+			    enum ATTR_TYPE type, const __le16 *name,
+			    u8 name_len, const CLST *vcn,
+			    struct mft_inode **mi);
+struct ATTRIB *ni_enum_attr_ex(struct ntfs_inode *ni, struct ATTRIB *attr,
+			       struct ATTR_LIST_ENTRY **le);
+struct ATTRIB *ni_load_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
+			    const __le16 *name, u8 name_len, CLST vcn,
+			    struct mft_inode **pmi);
+int ni_load_all_mi(struct ntfs_inode *ni);
+bool ni_add_subrecord(struct ntfs_inode *ni, CLST rno, struct mft_inode **mi);
+int ni_remove_attr(struct ntfs_inode *ni, enum ATTR_TYPE type,
+		   const __le16 *name, size_t name_len, bool base_only,
+		   const __le16 *id);
+int ni_create_attr_list(struct ntfs_inode *ni);
+int ni_expand_list(struct ntfs_inode *ni);
+int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
+			  const __le16 *name, u8 name_len,
+			  const struct runs_tree *run, CLST svcn, CLST len,
+			  __le16 flags, struct ATTRIB **new_attr,
+			  struct mft_inode **mi);
+int ni_insert_resident(struct ntfs_inode *ni, u32 data_size,
+		       enum ATTR_TYPE type, const __le16 *name, u8 name_len,
+		       struct ATTRIB **new_attr, struct mft_inode **mi);
+int ni_remove_attr_le(struct ntfs_inode *ni, struct ATTRIB *attr,
+		      struct ATTR_LIST_ENTRY *le);
+int ni_delete_all(struct ntfs_inode *ni);
+struct ATTR_FILE_NAME *ni_fname_name(struct ntfs_inode *ni,
+				     const struct cpu_str *uni,
+				     const struct MFT_REF *home,
+				     struct ATTR_LIST_ENTRY **entry);
+struct ATTR_FILE_NAME *ni_fname_type(struct ntfs_inode *ni, u8 name_type,
+				     struct ATTR_LIST_ENTRY **entry);
+u16 ni_fnames_count(struct ntfs_inode *ni);
+int ni_init_compress(struct ntfs_inode *ni, struct COMPRESS_CTX *ctx);
+enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
+				   void *buffer);
+int ni_write_inode(struct inode *inode, int sync, const char *hint);
+#define _ni_write_inode(i, w) ni_write_inode(i, w, __func__)
+int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
+	      __u64 vbo, __u64 len);
+int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page);
+int ni_writepage_cmpr(struct page *page, int sync);
+
+/* globals from fslog.c */
+int log_replay(struct ntfs_inode *ni);
+
+/* globals from fsntfs.c */
+bool ntfs_fix_pre_write(struct NTFS_RECORD_HEADER *rhdr, size_t bytes);
+int ntfs_fix_post_read(struct NTFS_RECORD_HEADER *rhdr, size_t bytes,
+		       bool simple);
+int ntfs_extend_init(struct ntfs_sb_info *sbi);
+int ntfs_loadlog_and_replay(struct ntfs_inode *ni, struct ntfs_sb_info *sbi);
+const struct ATTR_DEF_ENTRY *ntfs_query_def(struct ntfs_sb_info *sbi,
+					    enum ATTR_TYPE Type);
+int ntfs_look_for_free_space(struct ntfs_sb_info *sbi, CLST lcn, CLST len,
+			     CLST *new_lcn, CLST *new_len,
+			     enum ALLOCATE_OPT opt);
+int ntfs_look_free_mft(struct ntfs_sb_info *sbi, CLST *rno, bool mft,
+		       struct ntfs_inode *ni, struct mft_inode **mi);
+void ntfs_mark_rec_free(struct ntfs_sb_info *sbi, CLST nRecord);
+int ntfs_clear_mft_tail(struct ntfs_sb_info *sbi, size_t from, size_t to);
+int ntfs_refresh_zone(struct ntfs_sb_info *sbi);
+int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait);
+enum NTFS_DIRTY_FLAGS {
+	NTFS_DIRTY_DIRTY = 0,
+	NTFS_DIRTY_CLEAR = 1,
+	NTFS_DIRTY_ERROR = 2,
+};
+int ntfs_set_state(struct ntfs_sb_info *sbi, enum NTFS_DIRTY_FLAGS dirty);
+int ntfs_sb_read(struct super_block *sb, u64 lbo, size_t bytes, void *buffer);
+int ntfs_sb_write(struct super_block *sb, u64 lbo, size_t bytes,
+		  const void *buffer, int wait);
+int ntfs_sb_write_run(struct ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		      const void *buf, size_t bytes);
+struct buffer_head *ntfs_bread_run(struct ntfs_sb_info *sbi,
+				   struct runs_tree *run, u64 vbo);
+int ntfs_read_run_nb(struct ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		     void *buf, u32 bytes, struct ntfs_buffers *nb);
+int ntfs_read_bh_ex(struct ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		    struct NTFS_RECORD_HEADER *rhdr, u32 bytes,
+		    struct ntfs_buffers *nb);
+int ntfs_get_bh(struct ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		u32 bytes, struct ntfs_buffers *nb);
+int ntfs_write_bh_ex(struct ntfs_sb_info *sbi, struct NTFS_RECORD_HEADER *rhdr,
+		     struct ntfs_buffers *nb, int sync);
+int ntfs_vbo_to_lbo(struct ntfs_sb_info *sbi, struct runs_tree *run, u64 vbo,
+		    u64 *lbo, u64 *bytes);
+struct ntfs_inode *ntfs_new_inode(struct ntfs_sb_info *sbi, CLST nRec,
+				  bool dir);
+extern const u8 s_dir_security[0x50];
+extern const u8 s_file_security[0x58];
+int ntfs_security_init(struct ntfs_sb_info *sbi);
+int ntfs_get_security_by_id(struct ntfs_sb_info *sbi, u32 security_id,
+			    void **sd, size_t *size);
+int ntfs_insert_security(struct ntfs_sb_info *sbi, const void *sd, u32 size,
+			 __le32 *security_id, bool *inserted);
+int ntfs_reparse_init(struct ntfs_sb_info *sbi);
+int ntfs_objid_init(struct ntfs_sb_info *sbi);
+int ntfs_objid_remove(struct ntfs_sb_info *sbi, struct GUID *guid);
+int ntfs_insert_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
+			const struct MFT_REF *ref);
+int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
+			const struct MFT_REF *ref);
+void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim);
+int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim);
+
+/* globals from index.c */
+int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit);
+void fnd_clear(struct ntfs_fnd *fnd);
+struct ntfs_fnd *fnd_get(struct ntfs_index *indx);
+void fnd_put(struct ntfs_fnd *fnd);
+void indx_clear(struct ntfs_index *idx);
+int indx_init(struct ntfs_index *indx, struct ntfs_sb_info *sbi,
+	      const struct ATTRIB *attr, enum index_mutex_classed type);
+struct INDEX_ROOT *indx_get_root(struct ntfs_index *indx, struct ntfs_inode *ni,
+				 struct ATTRIB **attr, struct mft_inode **mi);
+int indx_read(struct ntfs_index *idx, struct ntfs_inode *ni, CLST vbn,
+	      struct indx_node **node);
+int indx_find(struct ntfs_index *indx, struct ntfs_inode *dir,
+	      const struct INDEX_ROOT *root, const void *Key, size_t KeyLen,
+	      const void *param, int *diff, struct NTFS_DE **entry,
+	      struct ntfs_fnd *fnd);
+int indx_find_sort(struct ntfs_index *indx, struct ntfs_inode *ni,
+		   const struct INDEX_ROOT *root, struct NTFS_DE **entry,
+		   struct ntfs_fnd *fnd);
+int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
+		  const struct INDEX_ROOT *root, struct NTFS_DE **entry,
+		  size_t *off, struct ntfs_fnd *fnd);
+int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
+		      const struct NTFS_DE *new_de, const void *param,
+		      struct ntfs_fnd *fnd);
+int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
+		      const void *key, u32 key_len, const void *param);
+int indx_update_dup(struct ntfs_inode *ni, struct ntfs_sb_info *sbi,
+		    const struct ATTR_FILE_NAME *fname,
+		    const struct NTFS_DUP_INFO *dup, int sync);
+
+/* globals from inode.c */
+struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
+			 const struct cpu_str *name);
+int ntfs_set_size(struct inode *inode, u64 new_size);
+int reset_log_file(struct inode *inode);
+int ntfs_get_block(struct inode *inode, sector_t vbn,
+		   struct buffer_head *bh_result, int create);
+int ntfs_write_inode(struct inode *inode, struct writeback_control *wbc);
+int ntfs_sync_inode(struct inode *inode);
+int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
+		      struct inode *i2);
+int inode_write_data(struct inode *inode, const void *data, size_t bytes);
+int ntfs_create_inode(struct inode *dir, struct dentry *dentry,
+		      struct file *file, umode_t mode, dev_t dev,
+		      const char *symname, unsigned int size, int excl,
+		      struct ntfs_fnd *fnd, struct inode **new_inode);
+int ntfs_link_inode(struct inode *inode, struct dentry *dentry);
+int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry);
+void ntfs_evict_inode(struct inode *inode);
+int ntfs_readpage(struct file *file, struct page *page);
+extern const struct inode_operations ntfs_link_inode_operations;
+extern const struct address_space_operations ntfs_aops;
+extern const struct address_space_operations ntfs_aops_cmpr;
+
+/* globals from name_i.c*/
+int fill_name_de(struct ntfs_sb_info *sbi, void *buf, const struct qstr *name);
+struct dentry *ntfs_get_parent(struct dentry *child);
+
+extern const struct inode_operations ntfs_dir_inode_operations;
+
+/* globals from record.c */
+int mi_get(struct ntfs_sb_info *sbi, CLST rno, struct mft_inode **mi);
+void mi_put(struct mft_inode *mi);
+int mi_init(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno);
+int mi_read(struct mft_inode *mi, bool is_mft);
+struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr);
+// TODO: id?
+struct ATTRIB *mi_find_attr(struct mft_inode *mi, struct ATTRIB *attr,
+			    enum ATTR_TYPE type, const __le16 *name,
+			    size_t name_len, const __le16 *id);
+static inline struct ATTRIB *rec_find_attr_le(struct mft_inode *rec,
+					      struct ATTR_LIST_ENTRY *le)
+{
+	return mi_find_attr(rec, NULL, le->type, le_name(le), le->name_len,
+			    &le->id);
+}
+int mi_write(struct mft_inode *mi, int wait);
+int mi_format_new(struct mft_inode *mi, struct ntfs_sb_info *sbi, CLST rno,
+		  __le16 flags, bool is_mft);
+void mi_mark_free(struct mft_inode *mi);
+struct ATTRIB *mi_insert_attr(struct mft_inode *mi, enum ATTR_TYPE type,
+			      const __le16 *name, u8 name_len, u32 asize,
+			      u16 name_off);
+
+bool mi_remove_attr(struct mft_inode *mi, struct ATTRIB *attr);
+bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes);
+int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
+		 struct runs_tree *run, CLST len);
+static inline bool mi_is_ref(const struct mft_inode *mi,
+			     const struct MFT_REF *ref)
+{
+	if (le32_to_cpu(ref->low) != mi->rno)
+		return false;
+	if (ref->seq != mi->mrec->seq)
+		return false;
+
+#ifdef NTFS3_64BIT_CLUSTER
+	return le16_to_cpu(ref->high) == (mi->rno >> 32);
+#else
+	return !ref->high;
+#endif
+}
+
+/* globals from run.c */
+bool run_lookup_entry(const struct runs_tree *run, CLST vcn, CLST *lcn,
+		      CLST *len, size_t *index);
+void run_truncate(struct runs_tree *run, CLST vcn);
+void run_truncate_head(struct runs_tree *run, CLST vcn);
+bool run_lookup(const struct runs_tree *run, CLST Vcn, size_t *Index);
+bool run_add_entry(struct runs_tree *run, CLST vcn, CLST lcn, CLST len);
+bool run_get_entry(const struct runs_tree *run, size_t index, CLST *vcn,
+		   CLST *lcn, CLST *len);
+bool run_is_mapped_full(const struct runs_tree *run, CLST svcn, CLST evcn);
+
+int run_pack(const struct runs_tree *run, CLST svcn, CLST len, u8 *run_buf,
+	     u32 run_buf_size, CLST *packed_vcns);
+int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
+	       CLST svcn, CLST evcn, const u8 *run_buf, u32 run_buf_size);
+
+#ifdef NTFS3_CHECK_FREE_CLST
+int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
+		  CLST svcn, CLST evcn, const u8 *run_buf, u32 run_buf_size);
+#else
+#define run_unpack_ex run_unpack
+#endif
+int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn);
+
+/* globals from super.c */
+void *ntfs_set_shared(void *ptr, u32 bytes);
+void *ntfs_put_shared(void *ptr);
+void ntfs_unmap_meta(struct super_block *sb, CLST lcn, CLST len);
+int ntfs_discard(struct ntfs_sb_info *sbi, CLST Lcn, CLST Len);
+
+/* globals from ubitmap.c*/
+void wnd_close(struct wnd_bitmap *wnd);
+static inline size_t wnd_zeroes(const struct wnd_bitmap *wnd)
+{
+	return wnd->total_zeroes;
+}
+void wnd_trace(struct wnd_bitmap *wnd);
+void wnd_trace_tree(struct wnd_bitmap *wnd, u32 nExtents, const char *Hint);
+int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nBits);
+int wnd_set_free(struct wnd_bitmap *wnd, size_t FirstBit, size_t Bits);
+int wnd_set_used(struct wnd_bitmap *wnd, size_t FirstBit, size_t Bits);
+bool wnd_is_free(struct wnd_bitmap *wnd, size_t FirstBit, size_t Bits);
+bool wnd_is_used(struct wnd_bitmap *wnd, size_t FirstBit, size_t Bits);
+
+/* Possible values for 'flags' 'wnd_find' */
+#define BITMAP_FIND_MARK_AS_USED 0x01
+#define BITMAP_FIND_FULL 0x02
+size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
+		size_t flags, size_t *allocated);
+int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits);
+void wnd_zone_set(struct wnd_bitmap *wnd, size_t Lcn, size_t Len);
+int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);
+
+/* globals from upcase.c */
+int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
+		   const u16 *upcase);
+int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
+		       const u16 *upcase);
+
+/* globals from xattr.c */
+struct posix_acl *ntfs_get_acl(struct inode *inode, int type);
+int ntfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int ntfs_acl_chmod(struct inode *inode);
+int ntfs_permission(struct inode *inode, int mask);
+ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
+int ntfs_init_acl(struct inode *inode, struct inode *dir);
+extern const struct xattr_handler *ntfs_xattr_handlers[];
+
+/* globals from lznt.c */
+struct lznt *get_compression_ctx(bool std);
+size_t compress_lznt(const void *uncompressed, size_t uncompressed_size,
+		     void *compressed, size_t compressed_size,
+		     struct lznt *ctx);
+ssize_t decompress_lznt(const void *compressed, size_t compressed_size,
+			void *uncompressed, size_t uncompressed_size);
+
+char *attr_str(const struct ATTRIB *attr, char *buf, size_t buf_len);
+
+static inline bool is_nt5(struct ntfs_sb_info *sbi)
+{
+	return sbi->volume.major_ver >= 3;
+}
+
+/*(sb->s_flags & SB_ACTIVE)*/
+static inline bool is_mounted(struct ntfs_sb_info *sbi)
+{
+	return !!sbi->sb->s_root;
+}
+
+static inline bool ntfs_is_meta_file(struct ntfs_sb_info *sbi, CLST rno)
+{
+	return rno < MFT_REC_FREE || rno == sbi->objid_no ||
+	       rno == sbi->quota_no || rno == sbi->reparse_no ||
+	       rno == sbi->usn_jrnl_no;
+}
+
+static inline void ntfs_unmap_page(struct page *page)
+{
+	kunmap(page);
+	put_page(page);
+}
+
+static inline struct page *ntfs_map_page(struct address_space *mapping,
+					 unsigned long index)
+{
+	struct page *page = read_mapping_page(mapping, index, NULL);
+
+	if (!IS_ERR(page)) {
+		kmap(page);
+		if (!PageError(page))
+			return page;
+		ntfs_unmap_page(page);
+		return ERR_PTR(-EIO);
+	}
+	return page;
+}
+
+static inline size_t wnd_zone_bit(const struct wnd_bitmap *wnd)
+{
+	return wnd->zone_bit;
+}
+
+static inline size_t wnd_zone_len(const struct wnd_bitmap *wnd)
+{
+	return wnd->zone_end - wnd->zone_bit;
+}
+
+static inline void run_init(struct runs_tree *run)
+{
+	run->runs_ = NULL;
+	run->count = 0;
+	run->allocated = 0;
+}
+
+static inline struct runs_tree *run_alloc(void)
+{
+	return ntfs_alloc(sizeof(struct runs_tree), 1);
+}
+
+static inline void run_close(struct runs_tree *run)
+{
+	ntfs_free(run->runs_);
+	memset(run, 0, sizeof(*run));
+}
+
+static inline void run_free(struct runs_tree *run)
+{
+	if (run) {
+		ntfs_free(run->runs_);
+		ntfs_free(run);
+	}
+}
+
+static inline bool run_is_empty(struct runs_tree *run)
+{
+	return !run->count;
+}
+
+/* NTFS uses quad aligned bitmaps */
+static inline size_t bitmap_size(size_t bits)
+{
+	return QuadAlign((bits + 7) >> 3);
+}
+
+#define _100ns2seconds 10000000
+#define SecondsToStartOf1970 0x00000002B6109100
+
+#define NTFS_TIME_GRAN 100
+
+/*
+ * kernel2nt
+ *
+ * converts in-memory kernel timestamp into nt time
+ */
+static inline __le64 kernel2nt(const struct timespec64 *ts)
+{
+	// 10^7 units of 100 nanoseconds one second
+	return cpu_to_le64(_100ns2seconds *
+				   (ts->tv_sec + SecondsToStartOf1970) +
+			   ts->tv_nsec / NTFS_TIME_GRAN);
+}
+
+/*
+ * nt2kernel
+ *
+ * converts on-disk nt time into kernel timestamp
+ */
+static inline void nt2kernel(const __le64 tm, struct timespec64 *ts)
+{
+	u64 t = le64_to_cpu(tm) - _100ns2seconds * SecondsToStartOf1970;
+
+	// WARNING: do_div changes its first argument(!)
+	ts->tv_nsec = do_div(t, _100ns2seconds) * 100;
+	ts->tv_sec = t;
+}
+
+static inline struct ntfs_sb_info *ntfs_sb(struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+/* Align up on cluster boundary */
+static inline u64 ntfs_up_cluster(const struct ntfs_sb_info *sbi, u64 size)
+{
+	return (size + sbi->cluster_mask) & ~((u64)sbi->cluster_mask);
+}
+
+/* Align up on cluster boundary */
+static inline u64 ntfs_up_block(const struct super_block *sb, u64 size)
+{
+	return (size + sb->s_blocksize - 1) & ~(u64)(sb->s_blocksize - 1);
+}
+
+static inline CLST bytes_to_cluster(const struct ntfs_sb_info *sbi, u64 size)
+{
+	return (size + sbi->cluster_mask) >> sbi->cluster_bits;
+}
+
+static inline u64 bytes_to_block(const struct super_block *sb, u64 size)
+{
+	return (size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
+}
+
+/* calculates ((bytes + frame_size - 1)/frame_size)*frame_size; */
+static inline u64 ntfs_up_frame(const struct ntfs_sb_info *sbi, u64 bytes,
+				u8 c_unit)
+{
+	u32 bytes_per_frame = 1u << (c_unit + sbi->cluster_bits);
+
+	return (bytes + bytes_per_frame - 1) & ~(u64)(bytes_per_frame - 1);
+}
+
+static inline struct buffer_head *ntfs_bread(struct super_block *sb,
+					     sector_t block)
+{
+	struct buffer_head *bh;
+
+	bh = sb_bread(sb, block);
+	if (bh)
+		return bh;
+
+	ntfs_printk(sb, KERN_ERR "failed to read volume at offset 0x%llx",
+		    (u64)block << sb->s_blocksize_bits);
+	return NULL;
+}
+
+static inline bool is_power_of2(size_t v)
+{
+	return v && !(v & (v - 1));
+}
+
+static inline struct ntfs_inode *ntfs_i(struct inode *inode)
+{
+	return container_of(inode, struct ntfs_inode, vfs_inode);
+}
+
+static inline bool is_compressed(const struct ntfs_inode *ni)
+{
+	return (ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ||
+	       (ni->ni_flags & NI_FLAG_COMPRESSED_MASK);
+}
+
+static inline bool is_dedup(const struct ntfs_inode *ni)
+{
+	return ni->ni_flags & NI_FLAG_DEDUPLICATED;
+}
+
+static inline bool is_encrypted(const struct ntfs_inode *ni)
+{
+	return ni->std_fa & FILE_ATTRIBUTE_ENCRYPTED;
+}
+
+static inline bool is_sparsed(const struct ntfs_inode *ni)
+{
+	return ni->std_fa & FILE_ATTRIBUTE_SPARSE_FILE;
+}
+
+static inline void le16_sub_cpu(__le16 *var, u16 val)
+{
+	*var = cpu_to_le16(le16_to_cpu(*var) - val);
+}
+
+static inline void le32_sub_cpu(__le32 *var, u32 val)
+{
+	*var = cpu_to_le32(le32_to_cpu(*var) - val);
+}
+
+static inline void nb_put(struct ntfs_buffers *nb)
+{
+	u32 i, nbufs = nb->nbufs;
+
+	if (!nbufs)
+		return;
+
+	for (i = 0; i < nbufs; i++)
+		put_bh(nb->bh[i]);
+	nb->nbufs = 0;
+}
+
+static inline void put_indx_node(struct indx_node *in)
+{
+	if (!in)
+		return;
+
+	ntfs_free(in->index);
+	nb_put(&in->nb);
+	ntfs_free(in);
+}
+
+static inline void mi_clear(struct mft_inode *mi)
+{
+	nb_put(&mi->nb);
+	ntfs_free(mi->mrec);
+	mi->mrec = NULL;
+}
+
+static inline void ni_lock(struct ntfs_inode *ni)
+{
+	mutex_lock(&ni->ni_lock);
+}
+
+static inline void ni_unlock(struct ntfs_inode *ni)
+{
+	mutex_unlock(&ni->ni_lock);
+}
+
+static inline int ni_trylock(struct ntfs_inode *ni)
+{
+	return mutex_trylock(&ni->ni_lock);
+}
+
+static inline int ni_has_resident_data(struct ntfs_inode *ni)
+{
+	return ni->ni_flags & NI_FLAG_RESIDENT;
+}
+
+static inline int attr_load_runs_attr(struct ntfs_inode *ni,
+				      struct ATTRIB *attr,
+				      struct runs_tree *run, CLST vcn)
+{
+	return attr_load_runs_vcn(ni, attr->type, attr_name(attr),
+				  attr->name_len, run, vcn);
+}
+
+static inline void le64_sub_cpu(__le64 *var, u64 val)
+{
+	*var = cpu_to_le64(le64_to_cpu(*var) - val);
+}
diff --git a/fs/ntfs3/upcase.c b/fs/ntfs3/upcase.c
new file mode 100644
index 000000000000..0bb8d75b8abb
--- /dev/null
+++ b/fs/ntfs3/upcase.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/upcase.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/module.h>
+#include <linux/nls.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+static inline u16 upcase_unicode_char(const u16 *upcase, u16 chr)
+{
+	if (chr < 'a')
+		return chr;
+
+	if (chr <= 'z')
+		return (u16)(chr - ('a' - 'A'));
+
+	return upcase[chr];
+}
+
+int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
+		   const u16 *upcase)
+{
+	int diff;
+	size_t len = l1 < l2 ? l1 : l2;
+
+	if (upcase) {
+		while (len--) {
+			diff = upcase_unicode_char(upcase, le16_to_cpu(*s1++)) -
+			       upcase_unicode_char(upcase, le16_to_cpu(*s2++));
+			if (diff)
+				return diff;
+		}
+	} else {
+		while (len--) {
+			diff = le16_to_cpu(*s1++) - le16_to_cpu(*s2++);
+			if (diff)
+				return diff;
+		}
+	}
+
+	return (int)(l1 - l2);
+}
+
+int ntfs_cmp_names_cpu(const struct cpu_str *uni1, const struct le_str *uni2,
+		       const u16 *upcase)
+{
+	const u16 *s1 = uni1->name;
+	const __le16 *s2 = uni2->name;
+	size_t l1 = uni1->len;
+	size_t l2 = uni2->len;
+	size_t len = l1 < l2 ? l1 : l2;
+	int diff;
+
+	if (upcase) {
+		while (len--) {
+			diff = upcase_unicode_char(upcase, *s1++) -
+			       upcase_unicode_char(upcase, le16_to_cpu(*s2++));
+			if (diff)
+				return diff;
+		}
+	} else {
+		while (len--) {
+			diff = *s1++ - le16_to_cpu(*s2++);
+			if (diff)
+				return diff;
+		}
+	}
+
+	return l1 - l2;
+}
-- 
2.25.2

