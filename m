Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781163A6ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiK1LRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 06:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiK1LRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86D1A072
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmyCfjmOk6+j6r8nH419i3TD5Kdx+xb7B6SU54l4Gk8=;
        b=ZnxDuvjgtEZk3LUDdvTxHxm2K5hrceg/rQIQcAWVMkn/eza8f2mXS9iqPzBOyqW2wI362z
        0J2MbEvDye0XTpe6Qonz14OWumRyRF84zilGmEKT+LVM4gAZGxtn+MTuNMhb2uF6WXxHpp
        1YclSGrdFXMRl7Ay1aCWpRvZAHHJj3s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-253-cYT4VQyTPxKuxzeKt_Ozdw-1; Mon, 28 Nov 2022 06:16:34 -0500
X-MC-Unique: cYT4VQyTPxKuxzeKt_Ozdw-1
Received: by mail-lf1-f71.google.com with SMTP id y26-20020a0565123f1a00b004b4b8aabd0cso3702995lfa.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmyCfjmOk6+j6r8nH419i3TD5Kdx+xb7B6SU54l4Gk8=;
        b=oQA5VbXxyRQ4N/rGmdVVpIUm9xZXl+Lf9YD+X2X6G5IusrNvQsH/BiKuc4urxt35fh
         fkEOK/CMKe1uDDE/O4TjBW428pFj4F6vY3WUkBl35T6QuQJW/HnTih6StkBmy5rti7FU
         2SNZNQV2lgE3HQumV7GI96oRlB96WFWGpgGxTxa39tfEdyDQWFEmjAQEoUUXdGzFH3/x
         tOHwQtRF7sTsodKeFRprgZCECjmBMy8mR3/UfUKIKa1Tgr/qiy20ckxWVccEKnSy3RJl
         iCtKKaspLux8O07U3DBeFqBrFDILJTLgNwHVtvkxjrKPNS1ERGYUUGb/vEMsUhYX6nPk
         FJCA==
X-Gm-Message-State: ANoB5pkCTUPLeLBPRx2F6ylUMEtnlSj4/9jbpMQVnPLvmJVeDnWLdvGQ
        HORxiu+VpVeYOwDZ2xVFceJLmvDYo2EehQkqfBN0Twm8pobVcF7LwB72SVemNTXh9SqvN8rTfku
        w+IXtEt//Sq7cO0ECyCdhgUgesEbuAD0/GjQmTTXkq5nflWJJV0wP2Jd7tBgf6WJ5Y4/6jtTVwA
        ==
X-Received: by 2002:ac2:5199:0:b0:4b4:e6d7:ad19 with SMTP id u25-20020ac25199000000b004b4e6d7ad19mr9924765lfi.392.1669634192869;
        Mon, 28 Nov 2022 03:16:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ToyOkZ3IaD6CXSr6E/F0UoxejnUKPaezvbbXu+Da8xksi5OmRVNntTRPutFLToPWB94au3Q==
X-Received: by 2002:ac2:5199:0:b0:4b4:e6d7:ad19 with SMTP id u25-20020ac25199000000b004b4e6d7ad19mr9924752lfi.392.1669634192467;
        Mon, 28 Nov 2022 03:16:32 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id bn24-20020a05651c179800b00277041268absm1188223ljb.78.2022.11.28.03.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:16:31 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com, alexl@redhat.com
Subject: [PATCH 2/6] composefs: Add on-disk layout
Date:   Mon, 28 Nov 2022 12:16:23 +0100
Message-Id: <cbe0d67a97c8b5157de06cedb67c88794c9c304e.1669631086.git.alexl@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669631086.git.alexl@redhat.com>
References: <cover.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds the on-disk layout header file of composefs.

Signed-off-by: Alexander Larsson <alexl@redhat.com>
Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/composefs/cfs.h | 242 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 fs/composefs/cfs.h

diff --git a/fs/composefs/cfs.h b/fs/composefs/cfs.h
new file mode 100644
index 000000000000..8f001fd28d6b
--- /dev/null
+++ b/fs/composefs/cfs.h
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * composefs
+ *
+ * Copyright (C) 2021 Giuseppe Scrivano
+ * Copyright (C) 2022 Alexander Larsson
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef _CFS_H
+#define _CFS_H
+
+#include <asm/byteorder.h>
+#include <crypto/sha2.h>
+#include <linux/fs.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+
+#define CFS_VERSION 1
+
+#define CFS_MAGIC 0xc078629aU
+
+#define CFS_MAX_DIR_CHUNK_SIZE 4096
+#define CFS_MAX_XATTRS_SIZE 4096
+
+static inline u16 cfs_u16_to_file(u16 val)
+{
+	return cpu_to_le16(val);
+}
+
+static inline u32 cfs_u32_to_file(u32 val)
+{
+	return cpu_to_le32(val);
+}
+
+static inline u64 cfs_u64_to_file(u64 val)
+{
+	return cpu_to_le64(val);
+}
+
+static inline u16 cfs_u16_from_file(u16 val)
+{
+	return le16_to_cpu(val);
+}
+
+static inline u32 cfs_u32_from_file(u32 val)
+{
+	return le32_to_cpu(val);
+}
+
+static inline u64 cfs_u64_from_file(u64 val)
+{
+	return le64_to_cpu(val);
+}
+
+static inline int cfs_xdigit_value(char c)
+{
+	if (c >= '0' && c <= '9')
+		return c - '0';
+	if (c >= 'A' && c <= 'F')
+		return c - 'A' + 10;
+	if (c >= 'a' && c <= 'f')
+		return c - 'a' + 10;
+	return -1;
+}
+
+static inline int cfs_digest_from_payload(const char *payload,
+					  size_t payload_len,
+					  u8 digest_out[SHA256_DIGEST_SIZE])
+{
+	const char *p, *end;
+	u8 last_digit = 0;
+	int digit = 0;
+	size_t n_nibbles = 0;
+
+	end = payload + payload_len;
+	for (p = payload; p != end; p++) {
+		/* Skip subdir structure */
+		if (*p == '/')
+			continue;
+
+		/* Break at (and ignore) extension */
+		if (*p == '.')
+			break;
+
+		if (n_nibbles == SHA256_DIGEST_SIZE * 2)
+			return -1; /* Too long */
+
+		digit = cfs_xdigit_value(*p);
+		if (digit == -1)
+			return -1; /* Not hex digit */
+
+		n_nibbles++;
+		if ((n_nibbles % 2) == 0) {
+			digest_out[n_nibbles / 2 - 1] =
+				(last_digit << 4) | digit;
+		}
+		last_digit = digit;
+	}
+
+	if (n_nibbles != SHA256_DIGEST_SIZE * 2)
+		return -1; /* Too short */
+
+	return 0;
+}
+
+struct cfs_vdata_s {
+	u64 off;
+	u32 len;
+} __packed;
+
+struct cfs_header_s {
+	u8 version;
+	u8 unused1;
+	u16 unused2;
+
+	u32 magic;
+	u64 data_offset;
+	u64 root_inode;
+
+	u64 unused3[2];
+} __packed;
+
+enum cfs_inode_flags {
+	CFS_INODE_FLAGS_NONE = 0,
+	CFS_INODE_FLAGS_PAYLOAD = 1 << 0,
+	CFS_INODE_FLAGS_MODE = 1 << 1,
+	CFS_INODE_FLAGS_NLINK = 1 << 2,
+	CFS_INODE_FLAGS_UIDGID = 1 << 3,
+	CFS_INODE_FLAGS_RDEV = 1 << 4,
+	CFS_INODE_FLAGS_TIMES = 1 << 5,
+	CFS_INODE_FLAGS_TIMES_NSEC = 1 << 6,
+	CFS_INODE_FLAGS_LOW_SIZE = 1 << 7, /* Low 32bit of st_size */
+	CFS_INODE_FLAGS_HIGH_SIZE = 1 << 8, /* High 32bit of st_size */
+	CFS_INODE_FLAGS_XATTRS = 1 << 9,
+	CFS_INODE_FLAGS_DIGEST = 1
+				 << 10, /* fs-verity sha256 digest of content */
+	CFS_INODE_FLAGS_DIGEST_FROM_PAYLOAD =
+		1 << 11, /* Compute digest from payload */
+};
+
+#define CFS_INODE_FLAG_CHECK(_flag, _name)                                     \
+	(((_flag) & (CFS_INODE_FLAGS_##_name)) != 0)
+#define CFS_INODE_FLAG_CHECK_SIZE(_flag, _name, _size)                         \
+	(CFS_INODE_FLAG_CHECK(_flag, _name) ? (_size) : 0)
+
+#define CFS_INODE_DEFAULT_MODE 0100644
+#define CFS_INODE_DEFAULT_NLINK 1
+#define CFS_INODE_DEFAULT_NLINK_DIR 2
+#define CFS_INODE_DEFAULT_UIDGID 0
+#define CFS_INODE_DEFAULT_RDEV 0
+#define CFS_INODE_DEFAULT_TIMES 0
+
+struct cfs_inode_s {
+	u32 flags;
+
+	/* Optional data: (selected by flags) */
+
+	/* This is the size of the type specific data that comes directly after
+	 * the inode in the file. Of this type:
+	 *
+	 * directory: cfs_dir_s
+	 * regular file: the backing filename
+	 * symlink: the target link
+	 *
+	 * Canonically payload_length is 0 for empty dir/file/symlink.
+	 */
+	u32 payload_length;
+
+	u32 st_mode; /* File type and mode.  */
+	u32 st_nlink; /* Number of hard links, only for regular files.  */
+	u32 st_uid; /* User ID of owner.  */
+	u32 st_gid; /* Group ID of owner.  */
+	u32 st_rdev; /* Device ID (if special file).  */
+	u64 st_size; /* Size of file, only used for regular files */
+
+	struct cfs_vdata_s xattrs; /* ref to variable data */
+
+	u8 digest[SHA256_DIGEST_SIZE]; /* fs-verity digest */
+
+	struct timespec64 st_mtim; /* Time of last modification.  */
+	struct timespec64 st_ctim; /* Time of last status change.  */
+};
+
+static inline u32 cfs_inode_encoded_size(u32 flags)
+{
+	return sizeof(u32) /* flags */ +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, PAYLOAD, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, MODE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, NLINK, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, UIDGID,
+					 sizeof(u32) + sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, RDEV, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES, sizeof(u64) * 2) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, TIMES_NSEC, sizeof(u32) * 2) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, LOW_SIZE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, HIGH_SIZE, sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, XATTRS,
+					 sizeof(u64) + sizeof(u32)) +
+	       CFS_INODE_FLAG_CHECK_SIZE(flags, DIGEST, SHA256_DIGEST_SIZE);
+}
+
+struct cfs_dentry_s {
+	/* Index of struct cfs_inode_s */
+	u64 inode_index;
+	u8 d_type;
+	u8 name_len;
+	u16 name_offset;
+} __packed;
+
+struct cfs_dir_chunk_s {
+	u16 n_dentries;
+	u16 chunk_size;
+	u64 chunk_offset;
+} __packed;
+
+struct cfs_dir_s {
+	u32 n_chunks;
+	struct cfs_dir_chunk_s chunks[];
+} __packed;
+
+#define cfs_dir_size(_n_chunks)                                                \
+	(sizeof(struct cfs_dir_s) +                                            \
+	 (_n_chunks) * sizeof(struct cfs_dir_chunk_s))
+
+/* xattr representation.  */
+struct cfs_xattr_element_s {
+	u16 key_length;
+	u16 value_length;
+} __packed;
+
+struct cfs_xattr_header_s {
+	u16 n_attr;
+	struct cfs_xattr_element_s attr[0];
+} __packed;
+
+#define cfs_xattr_header_size(_n_element)                                      \
+	(sizeof(struct cfs_xattr_header_s) +                                   \
+	 (_n_element) * sizeof(struct cfs_xattr_element_s))
+
+#endif
-- 
2.38.1

