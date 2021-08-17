Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD9E3EF46F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhHQVH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhHQVH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:07:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F652C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j1so1199134pjv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0xQZa3NHRv/YJBHwdMlr3YdmFg51MKltcZezbvVR+A=;
        b=F7nxRaeK17B8wZHPWrLoLECFPBXswXfhoC6QQqy6hQewLDDini3L0R/KHqp6XetxhF
         mcqJXWF7ul7VNSExTh3aXSOyu/S2boc0fWtNv087a7xOce+F5f4tnVbZiBV21OA1lHbA
         I5pxVyRdVI5Xt5FUTSHEb+cNmG7I6odbe6BKbH1PyA8iKbyQpdZO1P87NFsA4F7UGfuY
         ZVzF/ctXRbWhzbCpo1Nmz5AbUd1Eose8ibospkHcYzF8hGi1lyN9ejm83k07Ei+1tirV
         xFcWio41Aqfz0vBIP5BbcKBv4lmhgk9IPaZkSu81JdqOiIk2nOikPlg1fLXkjUDJroN9
         BzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0xQZa3NHRv/YJBHwdMlr3YdmFg51MKltcZezbvVR+A=;
        b=VSziSPhaKsA/G/XdGTBcf0orN9xSW4CvnrmC0taIK3+IYazp7F8rrmijd1bhUcdguf
         /Uwid3K2iowKypcXZanhBDLGRkwHukBI27BK8mKPQY8FmwxkFcOVIm0qzq20TBBBsn5/
         ZVFHb7826t1c6MB4apobqczMseXV/HgVMkhmp1pU+Z2GLY4b3sAV1fFJwVo5lQRp/J6U
         DLtDdhyaGEGmtkeuTN6PHD1Y053JhdaQTWENshjyxYy+IOq8IEbXAvZOYAImzoxBT7+E
         AkoVA1JiG/xPIGdRMU674AciiSEvxgVwR+lSSNzXyLy51bhGSNwjz89GAaYt9B55ZbAt
         87+A==
X-Gm-Message-State: AOAM533wHFS9dY3hLVtaRw7Ha2z8JUlm2OL3R9ny+2NJofjiMaFWkErH
        EtQhC+XIrI9EhVD3D+km00iglg==
X-Google-Smtp-Source: ABdhPJyR650nd7twpnZ9V46Hc/h8s6f6l4P8YpbGlGdt+hLsID4ZgAx3OAFvnQ2tpXSkrBSArOgAog==
X-Received: by 2002:a05:6a00:248a:b029:3e0:9be4:963f with SMTP id c10-20020a056a00248ab02903e09be4963fmr5578748pfv.29.1629234443600;
        Tue, 17 Aug 2021 14:07:23 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:23 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 07/14] btrfs: add definitions + documentation for encoded I/O ioctls
Date:   Tue, 17 Aug 2021 14:06:39 -0700
Message-Id: <9bd601f8c5494342d8c7d8aaa86aa815c2118173.1629234193.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In order to allow sending and receiving compressed data without
decompressing it, we need an interface to write pre-compressed data
directly to the filesystem and the matching interface to read compressed
data without decompressing it. This adds the definitions for ioctls to
do that and detailed explanations of how to use them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/uapi/linux/btrfs.h | 132 +++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d7d3cfead056..95da52955894 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -861,6 +861,134 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 align[7];
 };
 
+/*
+ * Data and metadata for an encoded read or write.
+ *
+ * Encoded I/O bypasses any encoding automatically done by the filesystem (e.g.,
+ * compression). This can be used to read the compressed contents of a file or
+ * write pre-compressed data directly to a file.
+ *
+ * BTRFS_IOC_ENCODED_READ and BTRFS_IOC_ENCODED_WRITE are essentially
+ * preadv/pwritev with additional metadata about how the data is encoded and the
+ * size of the unencoded data.
+ *
+ * BTRFS_IOC_ENCODED_READ fills the given iovecs with the encoded data, fills
+ * the metadata fields, and returns the size of the encoded data. It reads one
+ * extent per call. It can also read data which is not encoded.
+ *
+ * BTRFS_IOC_ENCODED_WRITE uses the metadata fields, writes the encoded data
+ * from the iovecs, and returns the size of the encoded data. Note that the
+ * encoded data is not validated when it is written; if it is not valid (e.g.,
+ * it cannot be decompressed), then a subsequent read may return an error.
+ *
+ * Since the filesystem page cache contains decoded data, encoded I/O bypasses
+ * the page cache. Encoded I/O requires CAP_SYS_ADMIN.
+ */
+struct btrfs_ioctl_encoded_io_args {
+	/* Input parameters for both reads and writes. */
+
+	/*
+	 * iovecs containing encoded data.
+	 *
+	 * For reads, if the size of the encoded data is larger than the sum of
+	 * iov[n].iov_len for 0 <= n < iovcnt, then the ioctl fails with
+	 * ENOBUFS.
+	 *
+	 * For writes, the size of the encoded data is the sum of iov[n].iov_len
+	 * for 0 <= n < iovcnt. This must be less than 128 KiB (this limit may
+	 * increase in the future). This must also be less than or equal to
+	 * unencoded_len.
+	 */
+	const struct iovec __user *iov;
+	/* Number of iovecs. */
+	unsigned long iovcnt;
+	/*
+	 * Offset in file.
+	 *
+	 * For writes, must be aligned to the sector size of the filesystem.
+	 */
+	__s64 offset;
+	/* Currently must be zero. */
+	__u64 flags;
+
+	/*
+	 * For reads, the following members are filled in with the metadata for
+	 * the encoded data.
+	 * For writes, the following members must be set to the metadata for the
+	 * encoded data.
+	 */
+
+	/*
+	 * Length of the data in the file.
+	 *
+	 * Must be less than or equal to unencoded_len - unencoded_offset. For
+	 * writes, must be aligned to the sector size of the filesystem unless
+	 * the data ends at or beyond the current end of the file.
+	 */
+	__u64 len;
+	/*
+	 * Length of the unencoded (i.e., decrypted and decompressed) data.
+	 *
+	 * For writes, must be no more than 128 KiB (this limit may increase in
+	 * the future). If the unencoded data is actually longer than
+	 * unencoded_len, then it is truncated; if it is shorter, then it is
+	 * extended with zeroes.
+	 */
+	__u64 unencoded_len;
+	/*
+	 * Offset from the first byte of the unencoded data to the first byte of
+	 * logical data in the file.
+	 *
+	 * Must be less than unencoded_len.
+	 */
+	__u64 unencoded_offset;
+	/*
+	 * BTRFS_ENCODED_IO_COMPRESSION_* type.
+	 *
+	 * For writes, must not be BTRFS_ENCODED_IO_COMPRESSION_NONE.
+	 */
+	__u32 compression;
+	/* Currently always BTRFS_ENCODED_IO_ENCRYPTION_NONE. */
+	__u32 encryption;
+	/*
+	 * Reserved for future expansion.
+	 *
+	 * For reads, always returned as zero. Users should check for non-zero
+	 * bytes. If there are any, then the kernel has a newer version of this
+	 * structure with additional information that the user definition is
+	 * missing.
+	 *
+	 * For writes, must be zeroed.
+	 */
+	__u8 reserved[32];
+};
+
+/* Data is not compressed. */
+#define BTRFS_ENCODED_IO_COMPRESSION_NONE 0
+/* Data is compressed as a single zlib stream. */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZLIB 1
+/*
+ * Data is compressed as a single zstd frame with the windowLog compression
+ * parameter set to no more than 17.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_ZSTD 2
+/*
+ * Data is compressed page by page (using the page size indicated by the name of
+ * the constant) with LZO1X and wrapped in the format documented in
+ * fs/btrfs/lzo.c. For writes, the compression page size must match the
+ * filesystem page size.
+ */
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_4K 3
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_8K 4
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_16K 5
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_32K 6
+#define BTRFS_ENCODED_IO_COMPRESSION_LZO_64K 7
+#define BTRFS_ENCODED_IO_COMPRESSION_TYPES 8
+
+/* Data is not encrypted. */
+#define BTRFS_ENCODED_IO_ENCRYPTION_NONE 0
+#define BTRFS_ENCODED_IO_ENCRYPTION_TYPES 1
+
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
 	BTRFS_ERROR_DEV_RAID1_MIN_NOT_MET = 1,
@@ -989,5 +1117,9 @@ enum btrfs_err_code {
 				struct btrfs_ioctl_ino_lookup_user_args)
 #define BTRFS_IOC_SNAP_DESTROY_V2 _IOW(BTRFS_IOCTL_MAGIC, 63, \
 				struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, \
+				    struct btrfs_ioctl_encoded_io_args)
+#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, \
+				     struct btrfs_ioctl_encoded_io_args)
 
 #endif /* _UAPI_LINUX_BTRFS_H */
-- 
2.32.0

