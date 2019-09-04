Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1FA7855
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfIDCKR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfIDCKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 575B02FF21D1C15272DF;
        Wed,  4 Sep 2019 10:10:15 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:05 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 01/25] erofs: remove all the byte offset comments
Date:   Wed, 4 Sep 2019 10:08:48 +0800
Message-ID: <20190904020912.63925-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph suggested [1], "Please remove all the byte offset comments.
that is something that can easily be checked with gdb or pahole."

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 105 +++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index afa7d45ca958..49335fff9d65 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,27 +17,28 @@
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
 #define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
+/* 128-byte erofs on-disk super block */
 struct erofs_super_block {
-/*  0 */__le32 magic;           /* in the little endian */
-/*  4 */__le32 checksum;        /* crc32c(super_block) */
-/*  8 */__le32 features;        /* (aka. feature_compat) */
-/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-/* 13 */__u8 reserved;
-
-/* 14 */__le16 root_nid;
-/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
-
-/* 24 */__le64 build_time;      /* inode v1 time derivation */
-/* 32 */__le32 build_time_nsec;
-/* 36 */__le32 blocks;          /* used for statfs */
-/* 40 */__le32 meta_blkaddr;
-/* 44 */__le32 xattr_blkaddr;
-/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
-/* 64 */__u8 volume_name[16];   /* volume name */
-/* 80 */__le32 requirements;    /* (aka. feature_incompat) */
-
-/* 84 */__u8 reserved2[44];
-} __packed;                     /* 128 bytes */
+	__le32 magic;           /* file system magic number */
+	__le32 checksum;        /* crc32c(super_block) */
+	__le32 features;        /* (aka. feature_compat) */
+	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 reserved;
+
+	__le16 root_nid;	/* nid of root directory */
+	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+
+	__le64 build_time;      /* inode v1 time derivation */
+	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
+	__le32 blocks;          /* used for statfs */
+	__le32 meta_blkaddr;	/* start block address of metadata area */
+	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
+	__u8 uuid[16];          /* 128-bit uuid for volume */
+	__u8 volume_name[16];   /* volume name */
+	__le32 requirements;    /* (aka. feature_incompat) */
+
+	__u8 reserved2[44];
+} __packed;
 
 /*
  * erofs inode data mapping:
@@ -73,16 +74,17 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATA_MAPPING_BIT        1
 
+/* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_v1 {
-/*  0 */__le16 i_advise;
+	__le16 i_advise;	/* inode hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_nlink;
-/*  8 */__le32 i_size;
-/* 12 */__le32 i_reserved;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_nlink;
+	__le32 i_size;
+	__le32 i_reserved;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -90,10 +92,10 @@ struct erofs_inode_v1 {
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
 	} i_u __packed;
-/* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
-/* 24 */__le16 i_uid;
-/* 26 */__le16 i_gid;
-/* 28 */__le32 i_reserved2;
+	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	__le16 i_uid;
+	__le16 i_gid;
+	__le32 i_reserved2;
 } __packed;
 
 /* 32 bytes on-disk inode */
@@ -101,15 +103,16 @@ struct erofs_inode_v1 {
 /* 64 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V2   1
 
+/* 64-byte complete form of an ondisk inode */
 struct erofs_inode_v2 {
-/*  0 */__le16 i_advise;
+	__le16 i_advise;	/* inode hints */
 
 /* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
-/*  2 */__le16 i_xattr_icount;
-/*  4 */__le16 i_mode;
-/*  6 */__le16 i_reserved;
-/*  8 */__le64 i_size;
-/* 16 */union {
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_reserved;
+	__le64 i_size;
+	union {
 		/* file total compressed blocks for data mapping 1 */
 		__le32 compressed_blocks;
 		__le32 raw_blkaddr;
@@ -119,15 +122,15 @@ struct erofs_inode_v2 {
 	} i_u __packed;
 
 	/* only used for 32-bit stat compatibility */
-/* 20 */__le32 i_ino;
-
-/* 24 */__le32 i_uid;
-/* 28 */__le32 i_gid;
-/* 32 */__le64 i_ctime;
-/* 40 */__le32 i_ctime_nsec;
-/* 44 */__le32 i_nlink;
-/* 48 */__u8   i_reserved2[16];
-} __packed;                     /* 64 bytes */
+	__le32 i_ino;
+
+	__le32 i_uid;
+	__le32 i_gid;
+	__le64 i_ctime;
+	__le32 i_ctime_nsec;
+	__le32 i_nlink;
+	__u8   i_reserved2[16];
+} __packed;
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -264,7 +267,7 @@ struct z_erofs_vle_decompressed_index {
 		 * [1] - pointing to the tail cluster
 		 */
 		__le16 delta[2];
-	} di_u __packed;		/* 8 bytes */
+	} di_u __packed;
 } __packed;
 
 #define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
@@ -273,10 +276,10 @@ struct z_erofs_vle_decompressed_index {
 
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
-	__le64 nid;     /*  0, node number */
-	__le16 nameoff; /*  8, start offset of file name */
-	__u8 file_type; /* 10, file type */
-	__u8 reserved;  /* 11, reserved */
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
 } __packed;
 
 /*
-- 
2.17.1

