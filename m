Return-Path: <linux-fsdevel+bounces-21183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173190033C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81789B252AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1441195FD7;
	Fri,  7 Jun 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="JbhystdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C60194C93;
	Fri,  7 Jun 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762585; cv=none; b=NxbL0C+tjaULIeD/lbObP+RObq1XAU4t8ZtbwwHcMMUPSaYbh+fQo9nlQ0uDhStPkvbJVlMYCcPTQ286DAqDNatcueqCoCCHwTK39y5T4MK//CvYTn7TmBGvL7lM+temRRf4BaNszhO4YgTS/Tq7vhL9E4Aei4/H9ajbZFhI6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762585; c=relaxed/simple;
	bh=FLs3WPnMi4Qn41zvRBy2Q7uyU38hh1awhc2HHjOGV4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcmRTfP/9pZHH4ewNtyu5/vEzusWD7brh3cvCFOSKj2R3pZNFlm6wsw/JWsG6eVDwU//f7IZMViRwFUPDrtGU/2/QLzuJj7zvHuKM2HFZ/p7gDof31SDEuLTO2Ok1Qu/+1h0qxdAxeTVczMcDPYl+vTGPaXkOY1w7AVNRW4azm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=JbhystdN; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 0FC022119;
	Fri,  7 Jun 2024 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762108;
	bh=zHsLvz6osWfE3TmkcyKZjWOaqyoi8Qs6E8wNxI8KraE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JbhystdNPitG9/q2a+VVljNiZ2kCAYZQ85iyjKfsrrIicEze/NIjCQMRjuytaIXU1
	 zi11k3rtaxjM99r89ySgRWTidbow0LTDzwrmSU7UJYzp+pq0b4nrKTGbG0wS+b/WbC
	 DAQS89o7W/TAlEMXxJsfVU8+NjQMBY/CV8+py1B8=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 14/18] fs/ntfs3: Merge synonym COMPRESSION_UNIT and NTFS_LZNT_CUNIT
Date: Fri, 7 Jun 2024 15:15:44 +0300
Message-ID: <20240607121548.18818-15-almaz.alexandrovich@paragon-software.com>
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

COMPRESSION_UNIT and NTFS_LZNT_CUNIT mean the same thing
(1u<<NTFS_LZNT_CUNIT) determines the size for compression (in clusters).

COMPRESS_MAX_CLUSTER is not used in the code.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/frecord.c | 2 +-
 fs/ntfs3/fslog.c   | 2 +-
 fs/ntfs3/inode.c   | 2 +-
 fs/ntfs3/ntfs.h    | 3 ---
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 660a7cfba8f6..c7ab8d6f3896 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1501,7 +1501,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 	if (is_ext) {
 		if (flags & ATTR_FLAG_COMPRESSED)
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 		attr->nres.total_size = attr->nres.alloc_size;
 	}
 
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 055c2af602c3..6049ba33d384 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2992,7 +2992,7 @@ static struct ATTRIB *attr_create_nonres_log(struct ntfs_sb_info *sbi,
 	if (is_ext) {
 		attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
 		if (is_attr_compressed(attr))
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 
 		attr->nres.run_off =
 			cpu_to_le16(SIZEOF_NONRESIDENT_EX + name_size);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c9a2f0ee117e..f3f6af10a586 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1506,7 +1506,7 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
 			attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
 			attr->flags = ATTR_FLAG_COMPRESSED;
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 			asize = SIZEOF_NONRESIDENT_EX + 8;
 		} else {
 			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT + 8);
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 3d6143c7abc0..1f2cdb0dbbe1 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -82,9 +82,6 @@ typedef u32 CLST;
 #define RESIDENT_LCN   ((CLST)-2)
 #define COMPRESSED_LCN ((CLST)-3)
 
-#define COMPRESSION_UNIT     4
-#define COMPRESS_MAX_CLUSTER 0x1000
-
 enum RECORD_NUM {
 	MFT_REC_MFT		= 0,
 	MFT_REC_MIRR		= 1,
-- 
2.34.1


