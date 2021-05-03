Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D2371374
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhECKNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 06:13:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233075AbhECKNc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 06:13:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA3D8AD4D
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 10:12:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E56631F2B71; Mon,  3 May 2021 12:12:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 3/4] udf: Get rid of 0-length arrays
Date:   Mon,  3 May 2021 12:12:30 +0200
Message-Id: <20210503101237.17576-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210503100931.5127-1-jack@suse.cz>
References: <20210503100931.5127-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Declare variable length arrays using [] instead of the old-style
declarations using arrays with 0 members. Also comment out entries in
structures beyond the first variable length array (we still do keep them
in comments as a reminder there are further entries in the structure
behind the variable length array). Accessing such entries needs a
careful offset math anyway so it is safer to not have them declared.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/ecma_167.h | 38 +++++++++++++++++++-------------------
 fs/udf/osta_udf.h | 13 ++++++-------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index 185c3e247648..c6bea5c9841a 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -307,14 +307,14 @@ struct logicalVolDesc {
 	struct regid		impIdent;
 	uint8_t			impUse[128];
 	struct extent_ad	integritySeqExt;
-	uint8_t			partitionMaps[0];
+	uint8_t			partitionMaps[];
 } __packed;
 
 /* Generic Partition Map (ECMA 167r3 3/10.7.1) */
 struct genericPartitionMap {
 	uint8_t		partitionMapType;
 	uint8_t		partitionMapLength;
-	uint8_t		partitionMapping[0];
+	uint8_t		partitionMapping[];
 } __packed;
 
 /* Partition Map Type (ECMA 167r3 3/10.7.1.1) */
@@ -342,7 +342,7 @@ struct unallocSpaceDesc {
 	struct tag		descTag;
 	__le32			volDescSeqNum;
 	__le32			numAllocDescs;
-	struct extent_ad	allocDescs[0];
+	struct extent_ad	allocDescs[];
 } __packed;
 
 /* Terminating Descriptor (ECMA 167r3 3/10.9) */
@@ -360,9 +360,9 @@ struct logicalVolIntegrityDesc {
 	uint8_t			logicalVolContentsUse[32];
 	__le32			numOfPartitions;
 	__le32			lengthOfImpUse;
-	__le32			freeSpaceTable[0];
-	__le32			sizeTable[0];
-	uint8_t			impUse[0];
+	__le32			freeSpaceTable[];
+	/* __le32		sizeTable[]; */
+	/* uint8_t		impUse[]; */
 } __packed;
 
 /* Integrity Type (ECMA 167r3 3/10.10.3) */
@@ -578,8 +578,8 @@ struct fileEntry {
 	__le64			uniqueID;
 	__le32			lengthExtendedAttr;
 	__le32			lengthAllocDescs;
-	uint8_t			extendedAttr[0];
-	uint8_t			allocDescs[0];
+	uint8_t			extendedAttr[];
+	/* uint8_t		allocDescs[]; */
 } __packed;
 
 /* Permissions (ECMA 167r3 4/14.9.5) */
@@ -632,7 +632,7 @@ struct genericFormat {
 	uint8_t		attrSubtype;
 	uint8_t		reserved[3];
 	__le32		attrLength;
-	uint8_t		attrData[0];
+	uint8_t		attrData[];
 } __packed;
 
 /* Character Set Information (ECMA 167r3 4/14.10.3) */
@@ -643,7 +643,7 @@ struct charSetInfo {
 	__le32		attrLength;
 	__le32		escapeSeqLength;
 	uint8_t		charSetType;
-	uint8_t		escapeSeq[0];
+	uint8_t		escapeSeq[];
 } __packed;
 
 /* Alternate Permissions (ECMA 167r3 4/14.10.4) */
@@ -682,7 +682,7 @@ struct infoTimesExtAttr {
 	__le32		attrLength;
 	__le32		dataLength;
 	__le32		infoTimeExistence;
-	uint8_t		infoTimes[0];
+	uint8_t		infoTimes[];
 } __packed;
 
 /* Device Specification (ECMA 167r3 4/14.10.7) */
@@ -694,7 +694,7 @@ struct deviceSpec {
 	__le32		impUseLength;
 	__le32		majorDeviceIdent;
 	__le32		minorDeviceIdent;
-	uint8_t		impUse[0];
+	uint8_t		impUse[];
 } __packed;
 
 /* Implementation Use Extended Attr (ECMA 167r3 4/14.10.8) */
@@ -705,7 +705,7 @@ struct impUseExtAttr {
 	__le32		attrLength;
 	__le32		impUseLength;
 	struct regid	impIdent;
-	uint8_t		impUse[0];
+	uint8_t		impUse[];
 } __packed;
 
 /* Application Use Extended Attribute (ECMA 167r3 4/14.10.9) */
@@ -716,7 +716,7 @@ struct appUseExtAttr {
 	__le32		attrLength;
 	__le32		appUseLength;
 	struct regid	appIdent;
-	uint8_t		appUse[0];
+	uint8_t		appUse[];
 } __packed;
 
 #define EXTATTR_CHAR_SET		1
@@ -733,7 +733,7 @@ struct unallocSpaceEntry {
 	struct tag	descTag;
 	struct icbtag	icbTag;
 	__le32		lengthAllocDescs;
-	uint8_t		allocDescs[0];
+	uint8_t		allocDescs[];
 } __packed;
 
 /* Space Bitmap Descriptor (ECMA 167r3 4/14.12) */
@@ -741,7 +741,7 @@ struct spaceBitmapDesc {
 	struct tag	descTag;
 	__le32		numOfBits;
 	__le32		numOfBytes;
-	uint8_t		bitmap[0];
+	uint8_t		bitmap[];
 } __packed;
 
 /* Partition Integrity Entry (ECMA 167r3 4/14.13) */
@@ -780,7 +780,7 @@ struct pathComponent {
 	uint8_t		componentType;
 	uint8_t		lengthComponentIdent;
 	__le16		componentFileVersionNum;
-	dchars		componentIdent[0];
+	dchars		componentIdent[];
 } __packed;
 
 /* File Entry (ECMA 167r3 4/14.17) */
@@ -809,8 +809,8 @@ struct extendedFileEntry {
 	__le64			uniqueID;
 	__le32			lengthExtendedAttr;
 	__le32			lengthAllocDescs;
-	uint8_t			extendedAttr[0];
-	uint8_t			allocDescs[0];
+	uint8_t			extendedAttr[];
+	/* uint8_t		allocDescs[]; */
 } __packed;
 
 #endif /* _ECMA_167_H */
diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
index 1c83aeede52e..157de0ec0cd5 100644
--- a/fs/udf/osta_udf.h
+++ b/fs/udf/osta_udf.h
@@ -111,7 +111,7 @@ struct logicalVolIntegrityDescImpUse {
 	__le16		minUDFReadRev;
 	__le16		minUDFWriteRev;
 	__le16		maxUDFWriteRev;
-	uint8_t		impUse[0];
+	uint8_t		impUse[];
 } __packed;
 
 /* Implementation Use Volume Descriptor (UDF 2.60 2.2.7) */
@@ -190,8 +190,8 @@ struct virtualAllocationTable20 {
 	__le16		minUDFWriteRev;
 	__le16		maxUDFWriteRev;
 	__le16		reserved;
-	uint8_t		impUse[0];
-	__le32		vatEntry[0];
+	uint8_t		impUse[];
+	/* __le32	vatEntry[]; */
 } __packed;
 
 #define ICBTAG_FILE_TYPE_VAT20		0xF8U
@@ -208,8 +208,7 @@ struct sparingTable {
 	__le16		reallocationTableLen;
 	__le16		reserved;
 	__le32		sequenceNum;
-	struct sparingEntry
-			mapEntry[0];
+	struct sparingEntry mapEntry[];
 } __packed;
 
 /* Metadata File (and Metadata Mirror File) (UDF 2.60 2.2.13.1) */
@@ -232,7 +231,7 @@ struct allocDescImpUse {
 /* FreeEASpace (UDF 2.60 3.3.4.5.1.1) */
 struct freeEaSpace {
 	__le16		headerChecksum;
-	uint8_t		freeEASpace[0];
+	uint8_t		freeEASpace[];
 } __packed;
 
 /* DVD Copyright Management Information (UDF 2.60 3.3.4.5.1.2) */
@@ -256,7 +255,7 @@ struct LVExtensionEA {
 /* FreeAppEASpace (UDF 2.60 3.3.4.6.1) */
 struct freeAppEASpace {
 	__le16		headerChecksum;
-	uint8_t		freeEASpace[0];
+	uint8_t		freeEASpace[];
 } __packed;
 
 /* UDF Defined System Stream (UDF 2.60 3.3.7) */
-- 
2.26.2

