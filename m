Return-Path: <linux-fsdevel+bounces-72112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D3CDEDC2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 18:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E991C3008180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD6C2472A6;
	Fri, 26 Dec 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="FgoVrCSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68283245020;
	Fri, 26 Dec 2025 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766771052; cv=none; b=GnolUyK5IcXLsm7nON/RbbX0O35gAyjcX+wtPIF0AfcGYM7NgSO/FpDDo64XUHCRXAI62HuuLMVk3uS/tN7RYHPlcAOtKPzmD5Y/3kwm+YWb+odWWLwON7kRI2pYp16a1Hn+gamI5mQ9frNmKgn2lee/KsGJkeG/TX+VLwVbf6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766771052; c=relaxed/simple;
	bh=Cr3v32S2wWm71KX2J83cLR5eYuv4NO6WaNKIvOuUwkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TiDr81R2wIOCaWIh/gmC+BzD15rtvg5k+W6cBgi66bLF/7Wa0w3cste61RSAtE5kUWFTSyOpryfbRVs0K4op7MEQlQQLlxeHbXn91gMPqZxKFFj+VAtVbNYGcu5DqRrI+zaaLz7yfIFsEAY/Ao54ckalUw92k5L+u1j5sCPN9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=FgoVrCSB; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 1D96F1D1D;
	Fri, 26 Dec 2025 17:41:00 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=FgoVrCSB;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5895D2267;
	Fri, 26 Dec 2025 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1766771048;
	bh=GEf2/AXnRohp3Y1XjYJ4yFOaWhGRecisCTVE9i0G2uA=;
	h=From:To:CC:Subject:Date;
	b=FgoVrCSBLpW3PTAFj8RBtzWEaNcXZZP0XbJlf3Gsg7and9OwEzQRq1JInYKfGtAkm
	 h35uhmPze2+pEOMLu0Lxbqdcvv+Y4txZDRHXlX4Dg/vlZxuGxjIdLaq/fr5DAZ/+Xx
	 SaKWLQsbS4o+0hZ9SP04RZCAf1mKdTvgXlRGTvRs=
Received: from localhost.localdomain (172.30.20.178) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Dec 2025 20:44:07 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: implement llseek SEEK_DATA/SEEK_HOLE by scanning data runs
Date: Fri, 26 Dec 2025 18:43:58 +0100
Message-ID: <20251226174358.15936-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
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

The generic llseek implementation does not understand ntfs data runs,
sparse regions, or compression semantics, and therefore cannot correctly
locate data or holes in files.

Add a filesystem-specific llseek handler that scans attribute data runs
to find the next data or hole starting at the given offset. Handle
resident attributes, sparse runs, compressed holes, and the implicit hole
at end-of-file.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c  |  4 +--
 fs/ntfs3/file.c    | 27 +++++++++++++++-
 fs/ntfs3/frecord.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs3/ntfs.h    |  1 +
 fs/ntfs3/ntfs_fs.h |  8 +++++
 5 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 0cd15a0983fe..3e188d6c229f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -940,7 +940,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 	if (!attr_b->non_res) {
 		*lcn = RESIDENT_LCN;
-		*len = 1;
+		*len = le32_to_cpu(attr_b->res.data_size);
 		goto out;
 	}
 
@@ -950,7 +950,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 			err = -EINVAL;
 		} else {
 			*len = 1;
-			*lcn = SPARSE_LCN;
+			*lcn = EOF_LCN;
 		}
 		goto out;
 	}
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a88045ab549f..c89b1e7e734c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1474,6 +1474,31 @@ int ntfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	return ret;
 }
 
+/*
+ * ntfs_llseek - file_operations::llseek
+ */
+static loff_t ntfs_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct ntfs_inode *ni = ntfs_i(inode);
+	loff_t maxbytes = ntfs_get_maxbytes(ni);
+	loff_t ret;
+
+	if (whence == SEEK_DATA || whence == SEEK_HOLE) {
+		inode_lock_shared(inode);
+		/* Scan fragments for hole or data. */
+		ret = ni_seek_data_or_hole(ni, offset, whence == SEEK_DATA);
+		inode_unlock_shared(inode);
+
+		if (ret >= 0)
+			ret = vfs_setpos(file, ret, maxbytes);
+	} else {
+		ret = generic_file_llseek_size(file, offset, whence, maxbytes,
+					       i_size_read(inode));
+	}
+	return ret;
+}
+
 // clang-format off
 const struct inode_operations ntfs_file_inode_operations = {
 	.getattr	= ntfs_getattr,
@@ -1485,7 +1510,7 @@ const struct inode_operations ntfs_file_inode_operations = {
 };
 
 const struct file_operations ntfs_file_operations = {
-	.llseek		= generic_file_llseek,
+	.llseek		= ntfs_llseek,
 	.read_iter	= ntfs_file_read_iter,
 	.write_iter	= ntfs_file_write_iter,
 	.unlocked_ioctl = ntfs_ioctl,
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a123e3f0acde..03dcb66b5f6c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3001,6 +3001,82 @@ bool ni_is_dirty(struct inode *inode)
 	return false;
 }
 
+/*
+ * ni_seek_data_or_hole
+ *
+ * Helper function for ntfs_llseek( SEEK_DATA/SEEK_HOLE )
+ */
+loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data)
+{
+	int err;
+	u8 cluster_bits = ni->mi.sbi->cluster_bits;
+	CLST vcn, lcn, clen;
+	loff_t vbo;
+
+	/* Enumerate all fragments. */
+	for (vcn = offset >> cluster_bits;; vcn += clen) {
+		err = attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false);
+		if (err) {
+			return err;
+		}
+
+		if (lcn == RESIDENT_LCN) {
+			/* clen - resident size in bytes. clen == ni->vfs_inode.i_size */
+			if (offset >= clen) {
+				/* check eof. */
+				return -ENXIO;
+			}
+
+			if (data) {
+				return offset;
+			}
+
+			return clen;
+		}
+
+		if (lcn == EOF_LCN) {
+			if (data) {
+				return -ENXIO;
+			}
+
+			/* implicit hole at the end of file. */
+			return ni->vfs_inode.i_size;
+		}
+
+		if (data) {
+			/*
+			 * Adjust the file offset to the next location in the file greater than
+			 * or equal to offset containing data. If offset points to data, then
+			 * the file offset is set to offset.
+			 */
+			if (lcn != SPARSE_LCN) {
+				vbo = (u64)vcn << cluster_bits;
+				return max(vbo, offset);
+			}
+		} else {
+			/*
+			 * Adjust the file offset to the next hole in the file greater than or 
+			 * equal to offset. If offset points into the middle of a hole, then the
+			 * file offset is set to offset. If there is no hole past offset, then the 
+			 * file offset is adjusted to the end of the file
+			 * (i.e., there is an implicit hole at the end of any file).
+			 */
+			if (lcn == SPARSE_LCN &&
+			    /* native compression hole begins at aligned vcn. */
+			    (!(ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ||
+			     !(vcn & (NTFS_LZNT_CLUSTERS - 1)))) {
+				vbo = (u64)vcn << cluster_bits;
+				return max(vbo, offset);
+			}
+		}
+
+		if (!clen) {
+			/* Corrupted file. */
+			return -EINVAL;
+		}
+	}
+}
+
 /*
  * ni_write_parents
  *
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 552b97905813..ae0a6ba102c0 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -81,6 +81,7 @@ typedef u32 CLST;
 #define SPARSE_LCN     ((CLST)-1)
 #define RESIDENT_LCN   ((CLST)-2)
 #define COMPRESSED_LCN ((CLST)-3)
+#define EOF_LCN       ((CLST)-4)
 
 enum RECORD_NUM {
 	MFT_REC_MFT		= 0,
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 482722438bd9..32823e1428a7 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -591,6 +591,7 @@ int ni_rename(struct ntfs_inode *dir_ni, struct ntfs_inode *new_dir_ni,
 	      struct NTFS_DE *new_de);
 
 bool ni_is_dirty(struct inode *inode);
+loff_t ni_seek_data_or_hole(struct ntfs_inode *ni, loff_t offset, bool data);
 int ni_write_parents(struct ntfs_inode *ni, int sync);
 
 /* Globals from fslog.c */
@@ -1107,6 +1108,13 @@ static inline int is_resident(struct ntfs_inode *ni)
 	return ni->ni_flags & NI_FLAG_RESIDENT;
 }
 
+static inline loff_t ntfs_get_maxbytes(struct ntfs_inode *ni)
+{
+	struct ntfs_sb_info *sbi = ni->mi.sbi;
+	return is_sparsed(ni) || is_compressed(ni) ? sbi->maxbytes_sparse :
+						     sbi->maxbytes;
+}
+
 static inline void le16_sub_cpu(__le16 *var, u16 val)
 {
 	*var = cpu_to_le16(le16_to_cpu(*var) - val);
-- 
2.43.0


