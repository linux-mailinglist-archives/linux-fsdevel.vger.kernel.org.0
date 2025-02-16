Return-Path: <linux-fsdevel+bounces-41790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD63A375EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D39B3A6EFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9D19D8B2;
	Sun, 16 Feb 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDrEhEm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338C18DB21;
	Sun, 16 Feb 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724139; cv=none; b=Lw5EeXY2n4gA6sLm5QY/2d/ycVfDzdp2G2AxJA1ttL5JyDL5djd/yjEgrg0XhWwJcHrXC9zvjePPJs/zCY4xLWOWpbtmpr1bjJKq4ivdfYjfWo9Dssc7MKuyJ6anuzZ5t6n0LYyfAwj8oFE0uF7IGsNKnreTSU7xp1AOF9yatqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724139; c=relaxed/simple;
	bh=RehJg42gCsvkynnxL7TMvNf8fOoQVcslCQrnQS0ZVM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QED2ZeeKxrRhFuBZspl2G69Lyd8nyeDU0J+s+kuhz0EUxA0Zx0uVtwpB/9WK7DSDDSwpc5ba+/g80LCX/ns9xK0IcssAXVUjKB7mPNVDrWwRnKUC31gso3/mMORx8PDbXvrjBiEqjr0nknJLcPjq9RD+ENBzUakdyGAOHYrCb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDrEhEm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB60BC4CEDD;
	Sun, 16 Feb 2025 16:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724139;
	bh=RehJg42gCsvkynnxL7TMvNf8fOoQVcslCQrnQS0ZVM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDrEhEm0rQviO8QW9L7hEqiN4HMa5zWgmkKlglyPeZ4KjMA8wP1UW6s3FjGjCT07c
	 pWQKBIDE56OFtKW9LQAV2mDJ201Yrk/Iw/7pM/Xc4F5v4UpwtLE3qxI/tjEdw5sqUn
	 KN1AYWLG4n6boWhQELGJSG3HsbGfWkYaBEonXorK7jd6/HyufSn+vUvC6zdDQD+nno
	 jBvkLhe1usB/fiFyVHfgOb0gc1dVo5NBs2uXK2El1smjXSUAgT9oKGZhl8DqtHHhvP
	 oBf9z3ll1emcfJ7yrF8ejo8MJ1eL6GR8RXxCFNepB/rI5CbnR4Yj56FkuIui2KBm5l
	 ILzapKOfEjh8Q==
Received: by pali.im (Postfix)
	id 14E2DA81; Sun, 16 Feb 2025 17:42:06 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/4] fs: Extend FS_IOC_FS[GS]ETXATTR API for Windows attributes
Date: Sun, 16 Feb 2025 17:40:27 +0100
Message-Id: <20250216164029.20673-3-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216164029.20673-1-pali@kernel.org>
References: <20250216164029.20673-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct fsxattr has 8 reserved padding bytes. Use these bytes for defining
new fields fsx_xflags2, fsx_xflags2_mask and fsx_xflags_mask in backward
compatible manner. If the new FS_XFLAG_HASEXTFIELDS flag in fsx_xflags is
not set then these new fields are treated as not present, like before this
change.

New field fsx_xflags_mask for SET operation specifies which flags in
fsx_xflags are going to be changed. This would allow userspace application
to change just subset of all flags. For GET operation this field specifies
which FS_XFLAG_* flags are supported by the file.

New field fsx_xflags2 specify new flags FS_XFLAG2_* which defines some of
Windows FILE_ATTRIBUTE_* attributes, which are mostly not going to be
interpreted or used by the kernel, and are mostly going to be used by
userspace. Field fsx_xflags2_mask then specify mask for them.

This change defines just API without filesystem support for them. These
attributes can be implemented later for Windows filesystems like FAT, NTFS,
exFAT, UDF, SMB, NFS4 which all native storage for those attributes (or at
least some subset of them).

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 include/uapi/linux/fs.h | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 367bc5289c47..93e947d6e604 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -145,15 +145,26 @@ struct fsxattr {
 	__u32		fsx_nextents;	/* nextents field value (get)	*/
 	__u32		fsx_projid;	/* project identifier (get/set) */
 	__u32		fsx_cowextsize;	/* CoW extsize field value (get/set)*/
-	unsigned char	fsx_pad[8];
+	__u16		fsx_xflags2;	/* xflags2 field value (get/set)*/
+	__u16		fsx_xflags2_mask;/*mask for xflags2 (get/set)*/
+	__u32		fsx_xflags_mask;/* mask for xflags (get/set)*/
+	/*
+	 * For FS_IOC_FSSETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
+	 * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags from fsx_xflags
+	 * and fsx_xflags2 fields are going to be changed.
+	 *
+	 * For FS_IOC_FSGETXATTR ioctl, fsx_xflags_mask and fsx_xflags2_mask
+	 * fields specify which FS_XFLAG_* and FS_XFLAG2_* flags are supported.
+	 */
 };
 
 /*
- * Flags for the fsx_xflags field
+ * Flags for the fsx_xflags and fsx_xflags_mask fields
  */
 #define FS_XFLAG_REALTIME	0x00000001	/* data in realtime volume */
 #define FS_XFLAG_PREALLOC	0x00000002	/* preallocated file extents */
-#define FS_XFLAG_IMMUTABLE	0x00000008	/* file cannot be modified */
+#define FS_XFLAG_IMMUTABLEUSER	0x00000004	/* file cannot be modified, changing this bit does not require CAP_LINUX_IMMUTABLE, equivalent of Windows FILE_ATTRIBUTE_READONLY */
+#define FS_XFLAG_IMMUTABLE	0x00000008	/* file cannot be modified, changing this bit requires CAP_LINUX_IMMUTABLE */
 #define FS_XFLAG_APPEND		0x00000010	/* all writes append */
 #define FS_XFLAG_SYNC		0x00000020	/* all writes synchronous */
 #define FS_XFLAG_NOATIME	0x00000040	/* do not update access time */
@@ -167,10 +178,25 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
-#define FS_XFLAG_COMPRESSED	0x00020000	/* compressed file */
-#define FS_XFLAG_ENCRYPTED	0x00040000	/* encrypted file */
+#define FS_XFLAG_COMPRESSED	0x00020000	/* compressed file, equivalent of Windows FILE_ATTRIBUTE_COMPRESSED */
+#define FS_XFLAG_ENCRYPTED	0x00040000	/* encrypted file, equivalent of Windows FILE_ATTRIBUTE_ENCRYPTED */
+#define FS_XFLAG_CHECKSUMS	0x00080000	/* checksum for data and metadata, equivalent of Windows FILE_ATTRIBUTE_INTEGRITY_STREAM */
+#define FS_XFLAG_HASEXTFIELDS	0x40000000	/* fields fsx_xflags_mask, fsx_xflags2 and fsx_xflags2_mask are present */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
+/*
+ * Flags for the fsx_xflags2 and fsx_xflags2_mask fields
+ */
+#define FS_XFLAG2_HIDDEN	0x0001	/* inode is hidden, equivalent of Widows FILE_ATTRIBUTE_HIDDEN */
+#define FS_XFLAG2_SYSTEM	0x0002	/* inode is part of operating system, equivalent of Windows FILE_ATTRIBUTE_SYSTEM */
+#define FS_XFLAG2_ARCHIVE	0x0004	/* inode was not archived yet, equivalent of Windows FILE_ATTRIBUTE_ARCHIVE */
+#define FS_XFLAG2_TEMPORARY	0x0008	/* inode content does not have to preserved across reboots, equivalent of Windows FILE_ATTRIBUTE_TEMPORARY */
+#define FS_XFLAG2_NOTINDEXED	0x0010	/* inode will not be indexed by content indexing service, equivalent of Windows FILE_ATTRIBUTE_NOT_CONTENT_INDEXED */
+#define FS_XFLAG2_NOSCRUBDATA	0x0020	/* file inode will not be checked by scrubber (proactive background data integrity scanner), for directory inode it means that newly created child would have this flag set, equivalent of Windows FILE_ATTRIBUTE_NO_SCRUB_DATA */
+#define FS_XFLAG2_OFFLINE	0x0040	/* inode is marked as HSM offline, equivalent of Windows FILE_ATTRIBUTE_OFFLINE */
+#define FS_XFLAG2_PINNED	0x0080	/* inode data content must be always stored in local HSM storage, equivalent of Windows FILE_ATTRIBUTE_PINNED */
+#define FS_XFLAG2_UNPINNED	0x0100	/* inode data content can be removed from local HSM storage, equivalent of Windows FILE_ATTRIBUTE_UNPINNED */
+
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
 
-- 
2.20.1


