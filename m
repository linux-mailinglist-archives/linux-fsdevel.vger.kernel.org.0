Return-Path: <linux-fsdevel+bounces-64644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6ABEF120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 04:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524293E37AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 02:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04543248878;
	Mon, 20 Oct 2025 02:13:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289F324168D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 02:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926404; cv=none; b=aHw9Sy1QU2XgRse2UGZM4SMeh35gJuSRNszDOXh3NJsDJ+xDY8j9/7kQy2NFPcBcC5EwgKfP/Jva6WhoqhFS8ctaIh/Ikobhb5tVI+ACvrKgbzWEWJmpA3RJ+CncZ/IoE06WHPq/RkU+u1zkERIhUPFDVXpCppzRN7E/2g4kv30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926404; c=relaxed/simple;
	bh=GCktuazVyJEjU0L3VUgvevLYAJY6pekl6W3ASpaiRiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGADviu6W5RCwfXkh2R2BPYnKRrq72u/z4s4bbAB5X1s3Vdto4yxTFdS+H/WII0jdXJFaDkDI9Dz3mao3FhE79upJUUcBgxg3mEbYNwgBHrGcJ3+X7IChMEcMf6ym2hNBRukKOSV/RZUrqXiLH/qONjKhVi+rn63MUrViUrS/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso5225797a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Oct 2025 19:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926399; x=1761531199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocUUtYvD5Pyv2NuAzK1/LW2NAMKoUr4MsR/9TcR61sw=;
        b=vJ6QxLUwZMhRI9FugghbeuU+gu4f7fhoeR9WQql1HeQQUfiYgGWBPm4ITU81U0g2kT
         ydRsfJ96ZE42KgsknIzvT/LN7qO3I5vIqHIAqR3q97cGe3uaPQO6EKqZesuZAha6vhfd
         Y2+ZwhLOa5/LCt/5aO0oJ4BjSgINP1qoSnLHiYvB8Iv0Xlp8O7pOwv3JZxpxWt7AgzBq
         QZXED1F8e5vUScWKvFX2/6PM4GMyj3T/BTZUbZGyusfLJQ/tarBWVtcNYU15O5KR8mOw
         VEC99guVqGaG6YxWuIW5LHxCPcMy/IsVjYX1WAy1aLtuxj1VXe+AweuFr50B6mlQBU7p
         MuZw==
X-Gm-Message-State: AOJu0Yx1AE4j8KobMoYN29qXdF4KaoUVhDddaZz4rh9x/FVeWUdDLKFh
	nlGF72OZbhIwZjcSpX4j9upcJVazQ7p6VUbl1EZE8gWTiuL51HB5W3m1
X-Gm-Gg: ASbGncvaflabxYn02yEUAIOzVqxACkLD7/+kbOPkYhpNOZM8EqUwBnenzavGF+hj9cd
	gAxa9GDKpIvNaliUKIffpF6eajVQWpTX3XhPPHv70g9BSBa2FU+0wEju7WRJ76pUMLdAOJSF+Mq
	a0bxWh3qbKdZIcAdKX5WewfTpRDokV4uogKMqtNdYyimaStJQ/dGzg9owh0afIS4+/j7NwGzjf9
	GZ1apx1y8ODnTz20fmSSRL0jk5/+szC2DCJ4muSRcxT2DBkoRSUA+xYHBpRpw/5xI7Zy9h0i0yP
	EtwD4QxYRupqPKj4NOgWlfzEIt3AxxapaMIXqyc6qYcUFgusV/v09mj5VseOIDFfV9aYILVykRQ
	9HE1FLaogtkSaDQObVJ9BsxZiYvm7NOY4gy1u/qJM09/lg/wzrw8c4yd5LkjOgSWyg9bM+Q1Avy
	4Y/A+e11zTX8i4G2xKqkq1HXi5BA==
X-Google-Smtp-Source: AGHT+IG6k0VPpmeZcx6OaBsLQ4r1iFWcqHs1FC2KanU/4lkkEzsD6f5Zj39uD5Qvd7DFlCBrYJSA1Q==
X-Received: by 2002:a17:90b:3d07:b0:32e:2fa7:fe6b with SMTP id 98e67ed59e1d1-33bc9d1d3e4mr14251827a91.14.1760926398739;
        Sun, 19 Oct 2025 19:13:18 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a764508b0sm6406849a12.0.2025.10.19.19.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:13:17 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 10/11] ntfsplus: add misc operations
Date: Mon, 20 Oct 2025 11:12:26 +0900
Message-Id: <20251020021227.5965-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251020021227.5965-1-linkinjeon@kernel.org>
References: <20251020021227.5965-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds the implementation of misc operations for ntfsplus.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfsplus/collate.c | 173 ++++++++++
 fs/ntfsplus/logfile.c | 773 ++++++++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/misc.c    | 221 ++++++++++++
 fs/ntfsplus/unistr.c  | 471 +++++++++++++++++++++++++
 fs/ntfsplus/upcase.c  |  73 ++++
 5 files changed, 1711 insertions(+)
 create mode 100644 fs/ntfsplus/collate.c
 create mode 100644 fs/ntfsplus/logfile.c
 create mode 100644 fs/ntfsplus/misc.c
 create mode 100644 fs/ntfsplus/unistr.c
 create mode 100644 fs/ntfsplus/upcase.c

diff --git a/fs/ntfsplus/collate.c b/fs/ntfsplus/collate.c
new file mode 100644
index 000000000000..8547adf7146e
--- /dev/null
+++ b/fs/ntfsplus/collate.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel collation handling. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2004 Anton Altaparmakov
+ *
+ * Part of this file is based on code from the NTFS-3G project.
+ * and is copyrighted by the respective authors below:
+ * Copyright (c) 2004 Anton Altaparmakov
+ * Copyright (c) 2005 Yura Pakhuchiy
+ */
+
+#include "collate.h"
+#include "misc.h"
+#include "ntfs.h"
+
+static int ntfs_collate_binary(struct ntfs_volume *vol,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len)
+{
+	int rc;
+
+	ntfs_debug("Entering.");
+	rc = memcmp(data1, data2, min(data1_len, data2_len));
+	if (!rc && (data1_len != data2_len)) {
+		if (data1_len < data2_len)
+			rc = -1;
+		else
+			rc = 1;
+	}
+	ntfs_debug("Done, returning %i", rc);
+	return rc;
+}
+
+static int ntfs_collate_ntofs_ulong(struct ntfs_volume *vol,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len)
+{
+	int rc;
+	u32 d1, d2;
+
+	ntfs_debug("Entering.");
+	BUG_ON(data1_len != data2_len);
+	BUG_ON(data1_len != 4);
+	d1 = le32_to_cpup(data1);
+	d2 = le32_to_cpup(data2);
+	if (d1 < d2)
+		rc = -1;
+	else {
+		if (d1 == d2)
+			rc = 0;
+		else
+			rc = 1;
+	}
+	ntfs_debug("Done, returning %i", rc);
+	return rc;
+}
+
+/**
+ * ntfs_collate_ntofs_ulongs - Which of two le32 arrays should be listed first
+ *
+ * Returns: -1, 0 or 1 depending of how the arrays compare
+ */
+static int ntfs_collate_ntofs_ulongs(struct ntfs_volume *vol,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len)
+{
+	int rc;
+	int len;
+	const __le32 *p1, *p2;
+	u32 d1, d2;
+
+	ntfs_debug("Entering.");
+	if ((data1_len != data2_len) || (data1_len <= 0) || (data1_len & 3)) {
+		ntfs_error(vol->sb, "data1_len or data2_len not valid\n");
+		return -1;
+	}
+
+	p1 = (const __le32 *)data1;
+	p2 = (const __le32 *)data2;
+	len = data1_len;
+	do {
+		d1 = le32_to_cpup(p1);
+		p1++;
+		d2 = le32_to_cpup(p2);
+		p2++;
+	} while ((d1 == d2) && ((len -= 4) > 0));
+	if (d1 < d2)
+		rc = -1;
+	else {
+		if (d1 == d2)
+			rc = 0;
+		else
+			rc = 1;
+	}
+	ntfs_debug("Done, returning %i.", rc);
+	return rc;
+}
+
+/**
+ * ntfs_collate_file_name - Which of two filenames should be listed first
+ */
+static int ntfs_collate_file_name(struct ntfs_volume *vol,
+		const void *data1, const int __always_unused data1_len,
+		const void *data2, const int __always_unused data2_len)
+{
+	int rc;
+
+	ntfs_debug("Entering.\n");
+	rc = ntfs_file_compare_values(data1, data2, -2,
+			IGNORE_CASE, vol->upcase, vol->upcase_len);
+	if (!rc)
+		rc = ntfs_file_compare_values(data1, data2,
+			-2, CASE_SENSITIVE, vol->upcase, vol->upcase_len);
+	ntfs_debug("Done, returning %i.\n", rc);
+	return rc;
+}
+
+typedef int (*ntfs_collate_func_t)(struct ntfs_volume *, const void *, const int,
+		const void *, const int);
+
+static ntfs_collate_func_t ntfs_do_collate0x0[3] = {
+	ntfs_collate_binary,
+	ntfs_collate_file_name,
+	NULL/*ntfs_collate_unicode_string*/,
+};
+
+static ntfs_collate_func_t ntfs_do_collate0x1[4] = {
+	ntfs_collate_ntofs_ulong,
+	NULL/*ntfs_collate_ntofs_sid*/,
+	NULL/*ntfs_collate_ntofs_security_hash*/,
+	ntfs_collate_ntofs_ulongs,
+};
+
+/**
+ * ntfs_collate - collate two data items using a specified collation rule
+ * @vol:	ntfs volume to which the data items belong
+ * @cr:		collation rule to use when comparing the items
+ * @data1:	first data item to collate
+ * @data1_len:	length in bytes of @data1
+ * @data2:	second data item to collate
+ * @data2_len:	length in bytes of @data2
+ *
+ * Collate the two data items @data1 and @data2 using the collation rule @cr
+ * and return -1, 0, ir 1 if @data1 is found, respectively, to collate before,
+ * to match, or to collate after @data2.
+ *
+ * For speed we use the collation rule @cr as an index into two tables of
+ * function pointers to call the appropriate collation function.
+ */
+int ntfs_collate(struct ntfs_volume *vol, __le32 cr,
+		const void *data1, const int data1_len,
+		const void *data2, const int data2_len)
+{
+	int i;
+
+	ntfs_debug("Entering.");
+
+	BUG_ON(cr != COLLATION_BINARY && cr != COLLATION_NTOFS_ULONG &&
+	       cr != COLLATION_FILE_NAME && cr != COLLATION_NTOFS_ULONGS);
+	i = le32_to_cpu(cr);
+	BUG_ON(i < 0);
+	if (i <= 0x02)
+		return ntfs_do_collate0x0[i](vol, data1, data1_len,
+				data2, data2_len);
+	BUG_ON(i < 0x10);
+	i -= 0x10;
+	if (likely(i <= 3))
+		return ntfs_do_collate0x1[i](vol, data1, data1_len,
+				data2, data2_len);
+	BUG();
+	return 0;
+}
diff --git a/fs/ntfsplus/logfile.c b/fs/ntfsplus/logfile.c
new file mode 100644
index 000000000000..f6e47accb517
--- /dev/null
+++ b/fs/ntfsplus/logfile.c
@@ -0,0 +1,773 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel journal handling. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2002-2007 Anton Altaparmakov
+ */
+
+#include <linux/bio.h>
+
+#include "attrib.h"
+#include "aops.h"
+#include "logfile.h"
+#include "misc.h"
+#include "ntfs.h"
+
+/**
+ * ntfs_check_restart_page_header - check the page header for consistency
+ * @vi:		LogFile inode to which the restart page header belongs
+ * @rp:		restart page header to check
+ * @pos:	position in @vi at which the restart page header resides
+ *
+ * Check the restart page header @rp for consistency and return 'true' if it is
+ * consistent and 'false' otherwise.
+ *
+ * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
+ * require the full restart page.
+ */
+static bool ntfs_check_restart_page_header(struct inode *vi,
+		struct restart_page_header *rp, s64 pos)
+{
+	u32 logfile_system_page_size, logfile_log_page_size;
+	u16 ra_ofs, usa_count, usa_ofs, usa_end = 0;
+	bool have_usa = true;
+
+	ntfs_debug("Entering.");
+	/*
+	 * If the system or log page sizes are smaller than the ntfs block size
+	 * or either is not a power of 2 we cannot handle this log file.
+	 */
+	logfile_system_page_size = le32_to_cpu(rp->system_page_size);
+	logfile_log_page_size = le32_to_cpu(rp->log_page_size);
+	if (logfile_system_page_size < NTFS_BLOCK_SIZE ||
+			logfile_log_page_size < NTFS_BLOCK_SIZE ||
+			logfile_system_page_size &
+			(logfile_system_page_size - 1) ||
+			!is_power_of_2(logfile_log_page_size)) {
+		ntfs_error(vi->i_sb, "LogFile uses unsupported page size.");
+		return false;
+	}
+	/*
+	 * We must be either at !pos (1st restart page) or at pos = system page
+	 * size (2nd restart page).
+	 */
+	if (pos && pos != logfile_system_page_size) {
+		ntfs_error(vi->i_sb, "Found restart area in incorrect position in LogFile.");
+		return false;
+	}
+	/* We only know how to handle version 1.1. */
+	if (le16_to_cpu(rp->major_ver) != 1 ||
+	    le16_to_cpu(rp->minor_ver) != 1) {
+		ntfs_error(vi->i_sb,
+			"LogFile version %i.%i is not supported.  (This driver supports version 1.1 only.)",
+			(int)le16_to_cpu(rp->major_ver),
+			(int)le16_to_cpu(rp->minor_ver));
+		return false;
+	}
+	/*
+	 * If chkdsk has been run the restart page may not be protected by an
+	 * update sequence array.
+	 */
+	if (ntfs_is_chkd_record(rp->magic) && !le16_to_cpu(rp->usa_count)) {
+		have_usa = false;
+		goto skip_usa_checks;
+	}
+	/* Verify the size of the update sequence array. */
+	usa_count = 1 + (logfile_system_page_size >> NTFS_BLOCK_SIZE_BITS);
+	if (usa_count != le16_to_cpu(rp->usa_count)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent update sequence array count.");
+		return false;
+	}
+	/* Verify the position of the update sequence array. */
+	usa_ofs = le16_to_cpu(rp->usa_ofs);
+	usa_end = usa_ofs + usa_count * sizeof(u16);
+	if (usa_ofs < sizeof(struct restart_page_header) ||
+			usa_end > NTFS_BLOCK_SIZE - sizeof(u16)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent update sequence array offset.");
+		return false;
+	}
+skip_usa_checks:
+	/*
+	 * Verify the position of the restart area.  It must be:
+	 *	- aligned to 8-byte boundary,
+	 *	- after the update sequence array, and
+	 *	- within the system page size.
+	 */
+	ra_ofs = le16_to_cpu(rp->restart_area_offset);
+	if (ra_ofs & 7 || (have_usa ? ra_ofs < usa_end :
+			ra_ofs < sizeof(struct restart_page_header)) ||
+			ra_ofs > logfile_system_page_size) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart page specifies inconsistent restart area offset.");
+		return false;
+	}
+	/*
+	 * Only restart pages modified by chkdsk are allowed to have chkdsk_lsn
+	 * set.
+	 */
+	if (!ntfs_is_chkd_record(rp->magic) && le64_to_cpu(rp->chkdsk_lsn)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart page is not modified by chkdsk but a chkdsk LSN is specified.");
+		return false;
+	}
+	ntfs_debug("Done.");
+	return true;
+}
+
+/**
+ * ntfs_check_restart_area - check the restart area for consistency
+ * @vi:		LogFile inode to which the restart page belongs
+ * @rp:		restart page whose restart area to check
+ *
+ * Check the restart area of the restart page @rp for consistency and return
+ * 'true' if it is consistent and 'false' otherwise.
+ *
+ * This function assumes that the restart page header has already been
+ * consistency checked.
+ *
+ * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
+ * require the full restart page.
+ */
+static bool ntfs_check_restart_area(struct inode *vi, struct restart_page_header *rp)
+{
+	u64 file_size;
+	struct restart_area *ra;
+	u16 ra_ofs, ra_len, ca_ofs;
+	u8 fs_bits;
+
+	ntfs_debug("Entering.");
+	ra_ofs = le16_to_cpu(rp->restart_area_offset);
+	ra = (struct restart_area *)((u8 *)rp + ra_ofs);
+	/*
+	 * Everything before ra->file_size must be before the first word
+	 * protected by an update sequence number.  This ensures that it is
+	 * safe to access ra->client_array_offset.
+	 */
+	if (ra_ofs + offsetof(struct restart_area, file_size) >
+			NTFS_BLOCK_SIZE - sizeof(u16)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent file offset.");
+		return false;
+	}
+	/*
+	 * Now that we can access ra->client_array_offset, make sure everything
+	 * up to the log client array is before the first word protected by an
+	 * update sequence number.  This ensures we can access all of the
+	 * restart area elements safely.  Also, the client array offset must be
+	 * aligned to an 8-byte boundary.
+	 */
+	ca_ofs = le16_to_cpu(ra->client_array_offset);
+	if (((ca_ofs + 7) & ~7) != ca_ofs ||
+			ra_ofs + ca_ofs > NTFS_BLOCK_SIZE - sizeof(u16)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent client array offset.");
+		return false;
+	}
+	/*
+	 * The restart area must end within the system page size both when
+	 * calculated manually and as specified by ra->restart_area_length.
+	 * Also, the calculated length must not exceed the specified length.
+	 */
+	ra_len = ca_ofs + le16_to_cpu(ra->log_clients) *
+			sizeof(struct log_client_record);
+	if (ra_ofs + ra_len > le32_to_cpu(rp->system_page_size) ||
+			ra_ofs + le16_to_cpu(ra->restart_area_length) >
+			le32_to_cpu(rp->system_page_size) ||
+			ra_len > le16_to_cpu(ra->restart_area_length)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area is out of bounds of the system page size specified by the restart page header and/or the specified restart area length is inconsistent.");
+		return false;
+	}
+	/*
+	 * The ra->client_free_list and ra->client_in_use_list must be either
+	 * LOGFILE_NO_CLIENT or less than ra->log_clients or they are
+	 * overflowing the client array.
+	 */
+	if ((ra->client_free_list != LOGFILE_NO_CLIENT &&
+			le16_to_cpu(ra->client_free_list) >=
+			le16_to_cpu(ra->log_clients)) ||
+			(ra->client_in_use_list != LOGFILE_NO_CLIENT &&
+			le16_to_cpu(ra->client_in_use_list) >=
+			le16_to_cpu(ra->log_clients))) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies overflowing client free and/or in use lists.");
+		return false;
+	}
+	/*
+	 * Check ra->seq_number_bits against ra->file_size for consistency.
+	 * We cannot just use ffs() because the file size is not a power of 2.
+	 */
+	file_size = le64_to_cpu(ra->file_size);
+	fs_bits = 0;
+	while (file_size) {
+		file_size >>= 1;
+		fs_bits++;
+	}
+	if (le32_to_cpu(ra->seq_number_bits) != 67 - fs_bits) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent sequence number bits.");
+		return false;
+	}
+	/* The log record header length must be a multiple of 8. */
+	if (((le16_to_cpu(ra->log_record_header_length) + 7) & ~7) !=
+			le16_to_cpu(ra->log_record_header_length)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent log record header length.");
+		return false;
+	}
+	/* Dito for the log page data offset. */
+	if (((le16_to_cpu(ra->log_page_data_offset) + 7) & ~7) !=
+			le16_to_cpu(ra->log_page_data_offset)) {
+		ntfs_error(vi->i_sb,
+			"LogFile restart area specifies inconsistent log page data offset.");
+		return false;
+	}
+	ntfs_debug("Done.");
+	return true;
+}
+
+/**
+ * ntfs_check_log_client_array - check the log client array for consistency
+ * @vi:		LogFile inode to which the restart page belongs
+ * @rp:		restart page whose log client array to check
+ *
+ * Check the log client array of the restart page @rp for consistency and
+ * return 'true' if it is consistent and 'false' otherwise.
+ *
+ * This function assumes that the restart page header and the restart area have
+ * already been consistency checked.
+ *
+ * Unlike ntfs_check_restart_page_header() and ntfs_check_restart_area(), this
+ * function needs @rp->system_page_size bytes in @rp, i.e. it requires the full
+ * restart page and the page must be multi sector transfer deprotected.
+ */
+static bool ntfs_check_log_client_array(struct inode *vi,
+		struct restart_page_header *rp)
+{
+	struct restart_area *ra;
+	struct log_client_record *ca, *cr;
+	u16 nr_clients, idx;
+	bool in_free_list, idx_is_first;
+
+	ntfs_debug("Entering.");
+	ra = (struct restart_area *)((u8 *)rp + le16_to_cpu(rp->restart_area_offset));
+	ca = (struct log_client_record *)((u8 *)ra +
+			le16_to_cpu(ra->client_array_offset));
+	/*
+	 * Check the ra->client_free_list first and then check the
+	 * ra->client_in_use_list.  Check each of the log client records in
+	 * each of the lists and check that the array does not overflow the
+	 * ra->log_clients value.  Also keep track of the number of records
+	 * visited as there cannot be more than ra->log_clients records and
+	 * that way we detect eventual loops in within a list.
+	 */
+	nr_clients = le16_to_cpu(ra->log_clients);
+	idx = le16_to_cpu(ra->client_free_list);
+	in_free_list = true;
+check_list:
+	for (idx_is_first = true; idx != LOGFILE_NO_CLIENT_CPU; nr_clients--,
+			idx = le16_to_cpu(cr->next_client)) {
+		if (!nr_clients || idx >= le16_to_cpu(ra->log_clients))
+			goto err_out;
+		/* Set @cr to the current log client record. */
+		cr = ca + idx;
+		/* The first log client record must not have a prev_client. */
+		if (idx_is_first) {
+			if (cr->prev_client != LOGFILE_NO_CLIENT)
+				goto err_out;
+			idx_is_first = false;
+		}
+	}
+	/* Switch to and check the in use list if we just did the free list. */
+	if (in_free_list) {
+		in_free_list = false;
+		idx = le16_to_cpu(ra->client_in_use_list);
+		goto check_list;
+	}
+	ntfs_debug("Done.");
+	return true;
+err_out:
+	ntfs_error(vi->i_sb, "LogFile log client array is corrupt.");
+	return false;
+}
+
+/**
+ * ntfs_check_and_load_restart_page - check the restart page for consistency
+ * @vi:		LogFile inode to which the restart page belongs
+ * @rp:		restart page to check
+ * @pos:	position in @vi at which the restart page resides
+ * @wrp:	[OUT] copy of the multi sector transfer deprotected restart page
+ * @lsn:	[OUT] set to the current logfile lsn on success
+ *
+ * Check the restart page @rp for consistency and return 0 if it is consistent
+ * and -errno otherwise.  The restart page may have been modified by chkdsk in
+ * which case its magic is CHKD instead of RSTR.
+ *
+ * This function only needs NTFS_BLOCK_SIZE bytes in @rp, i.e. it does not
+ * require the full restart page.
+ *
+ * If @wrp is not NULL, on success, *@wrp will point to a buffer containing a
+ * copy of the complete multi sector transfer deprotected page.  On failure,
+ * *@wrp is undefined.
+ *
+ * Simillarly, if @lsn is not NULL, on success *@lsn will be set to the current
+ * logfile lsn according to this restart page.  On failure, *@lsn is undefined.
+ *
+ * The following error codes are defined:
+ *	-EINVAL	- The restart page is inconsistent.
+ *	-ENOMEM	- Not enough memory to load the restart page.
+ *	-EIO	- Failed to reading from LogFile.
+ */
+static int ntfs_check_and_load_restart_page(struct inode *vi,
+		struct restart_page_header *rp, s64 pos, struct restart_page_header **wrp,
+		s64 *lsn)
+{
+	struct restart_area *ra;
+	struct restart_page_header *trp;
+	int size, err;
+
+	ntfs_debug("Entering.");
+	/* Check the restart page header for consistency. */
+	if (!ntfs_check_restart_page_header(vi, rp, pos)) {
+		/* Error output already done inside the function. */
+		return -EINVAL;
+	}
+	/* Check the restart area for consistency. */
+	if (!ntfs_check_restart_area(vi, rp)) {
+		/* Error output already done inside the function. */
+		return -EINVAL;
+	}
+	ra = (struct restart_area *)((u8 *)rp + le16_to_cpu(rp->restart_area_offset));
+	/*
+	 * Allocate a buffer to store the whole restart page so we can multi
+	 * sector transfer deprotect it.
+	 */
+	trp = ntfs_malloc_nofs(le32_to_cpu(rp->system_page_size));
+	if (!trp) {
+		ntfs_error(vi->i_sb, "Failed to allocate memory for LogFile restart page buffer.");
+		return -ENOMEM;
+	}
+	/*
+	 * Read the whole of the restart page into the buffer.  If it fits
+	 * completely inside @rp, just copy it from there.  Otherwise map all
+	 * the required pages and copy the data from them.
+	 */
+	size = PAGE_SIZE - (pos & ~PAGE_MASK);
+	if (size >= le32_to_cpu(rp->system_page_size)) {
+		memcpy(trp, rp, le32_to_cpu(rp->system_page_size));
+	} else {
+		pgoff_t idx;
+		struct folio *folio;
+		int have_read, to_read;
+
+		/* First copy what we already have in @rp. */
+		memcpy(trp, rp, size);
+		/* Copy the remaining data one page at a time. */
+		have_read = size;
+		to_read = le32_to_cpu(rp->system_page_size) - size;
+		idx = (pos + size) >> PAGE_SHIFT;
+		BUG_ON((pos + size) & ~PAGE_MASK);
+		do {
+			folio = ntfs_read_mapping_folio(vi->i_mapping, idx);
+			if (IS_ERR(folio)) {
+				ntfs_error(vi->i_sb, "Error mapping LogFile page (index %lu).",
+						idx);
+				err = PTR_ERR(folio);
+				if (err != -EIO && err != -ENOMEM)
+					err = -EIO;
+				goto err_out;
+			}
+			size = min_t(int, to_read, PAGE_SIZE);
+			memcpy((u8 *)trp + have_read, folio_address(folio), size);
+			folio_put(folio);
+			have_read += size;
+			to_read -= size;
+			idx++;
+		} while (to_read > 0);
+	}
+	/*
+	 * Perform the multi sector transfer deprotection on the buffer if the
+	 * restart page is protected.
+	 */
+	if ((!ntfs_is_chkd_record(trp->magic) || le16_to_cpu(trp->usa_count)) &&
+	    post_read_mst_fixup((struct ntfs_record *)trp, le32_to_cpu(rp->system_page_size))) {
+		/*
+		 * A multi sector transfer error was detected.  We only need to
+		 * abort if the restart page contents exceed the multi sector
+		 * transfer fixup of the first sector.
+		 */
+		if (le16_to_cpu(rp->restart_area_offset) +
+				le16_to_cpu(ra->restart_area_length) >
+				NTFS_BLOCK_SIZE - sizeof(u16)) {
+			ntfs_error(vi->i_sb,
+				"Multi sector transfer error detected in LogFile restart page.");
+			err = -EINVAL;
+			goto err_out;
+		}
+	}
+	/*
+	 * If the restart page is modified by chkdsk or there are no active
+	 * logfile clients, the logfile is consistent.  Otherwise, need to
+	 * check the log client records for consistency, too.
+	 */
+	err = 0;
+	if (ntfs_is_rstr_record(rp->magic) &&
+			ra->client_in_use_list != LOGFILE_NO_CLIENT) {
+		if (!ntfs_check_log_client_array(vi, trp)) {
+			err = -EINVAL;
+			goto err_out;
+		}
+	}
+	if (lsn) {
+		if (ntfs_is_rstr_record(rp->magic))
+			*lsn = le64_to_cpu(ra->current_lsn);
+		else /* if (ntfs_is_chkd_record(rp->magic)) */
+			*lsn = le64_to_cpu(rp->chkdsk_lsn);
+	}
+	ntfs_debug("Done.");
+	if (wrp)
+		*wrp = trp;
+	else {
+err_out:
+		ntfs_free(trp);
+	}
+	return err;
+}
+
+/**
+ * ntfs_check_logfile - check the journal for consistency
+ * @log_vi:	struct inode of loaded journal LogFile to check
+ * @rp:		[OUT] on success this is a copy of the current restart page
+ *
+ * Check the LogFile journal for consistency and return 'true' if it is
+ * consistent and 'false' if not.  On success, the current restart page is
+ * returned in *@rp.  Caller must call ntfs_free(*@rp) when finished with it.
+ *
+ * At present we only check the two restart pages and ignore the log record
+ * pages.
+ *
+ * Note that the MstProtected flag is not set on the LogFile inode and hence
+ * when reading pages they are not deprotected.  This is because we do not know
+ * if the LogFile was created on a system with a different page size to ours
+ * yet and mst deprotection would fail if our page size is smaller.
+ */
+bool ntfs_check_logfile(struct inode *log_vi, struct restart_page_header **rp)
+{
+	s64 size, pos;
+	s64 rstr1_lsn, rstr2_lsn;
+	struct ntfs_volume *vol = NTFS_SB(log_vi->i_sb);
+	struct address_space *mapping = log_vi->i_mapping;
+	struct folio *folio = NULL;
+	u8 *kaddr = NULL;
+	struct restart_page_header *rstr1_ph = NULL;
+	struct restart_page_header *rstr2_ph = NULL;
+	int log_page_size, err;
+	bool logfile_is_empty = true;
+	u8 log_page_bits;
+
+	ntfs_debug("Entering.");
+	/* An empty LogFile must have been clean before it got emptied. */
+	if (NVolLogFileEmpty(vol))
+		goto is_empty;
+	size = i_size_read(log_vi);
+	/* Make sure the file doesn't exceed the maximum allowed size. */
+	if (size > MaxLogFileSize)
+		size = MaxLogFileSize;
+	/*
+	 * Truncate size to a multiple of the page cache size or the default
+	 * log page size if the page cache size is between the default log page
+	 * log page size if the page cache size is between the default log page
+	 * size and twice that.
+	 */
+	if (DefaultLogPageSize <= PAGE_SIZE &&
+	    DefaultLogPageSize * 2 <= PAGE_SIZE)
+		log_page_size = DefaultLogPageSize;
+	else
+		log_page_size = PAGE_SIZE;
+	/*
+	 * Use ntfs_ffs() instead of ffs() to enable the compiler to
+	 * optimize log_page_size and log_page_bits into constants.
+	 */
+	log_page_bits = ntfs_ffs(log_page_size) - 1;
+	size &= ~(s64)(log_page_size - 1);
+	/*
+	 * Ensure the log file is big enough to store at least the two restart
+	 * pages and the minimum number of log record pages.
+	 */
+	if (size < log_page_size * 2 || (size - log_page_size * 2) >>
+			log_page_bits < MinLogRecordPages) {
+		ntfs_error(vol->sb, "LogFile is too small.");
+		return false;
+	}
+	/*
+	 * Read through the file looking for a restart page.  Since the restart
+	 * page header is at the beginning of a page we only need to search at
+	 * what could be the beginning of a page (for each page size) rather
+	 * than scanning the whole file byte by byte.  If all potential places
+	 * contain empty and uninitialzed records, the log file can be assumed
+	 * to be empty.
+	 */
+	for (pos = 0; pos < size; pos <<= 1) {
+		pgoff_t idx = pos >> PAGE_SHIFT;
+
+		if (!folio || folio->index != idx) {
+			if (folio)
+				ntfs_unmap_folio(folio, kaddr);
+			folio = ntfs_read_mapping_folio(mapping, idx);
+			if (IS_ERR(folio)) {
+				ntfs_error(vol->sb, "Error mapping LogFile page (index %lu).",
+						idx);
+				goto err_out;
+			}
+		}
+		kaddr = (u8 *)kmap_local_folio(folio, 0) + (pos & ~PAGE_MASK);
+		/*
+		 * A non-empty block means the logfile is not empty while an
+		 * empty block after a non-empty block has been encountered
+		 * means we are done.
+		 */
+		if (!ntfs_is_empty_recordp((__le32 *)kaddr))
+			logfile_is_empty = false;
+		else if (!logfile_is_empty)
+			break;
+		/*
+		 * A log record page means there cannot be a restart page after
+		 * this so no need to continue searching.
+		 */
+		if (ntfs_is_rcrd_recordp((__le32 *)kaddr))
+			break;
+		/* If not a (modified by chkdsk) restart page, continue. */
+		if (!ntfs_is_rstr_recordp((__le32 *)kaddr) &&
+				!ntfs_is_chkd_recordp((__le32 *)kaddr)) {
+			if (!pos)
+				pos = NTFS_BLOCK_SIZE >> 1;
+			continue;
+		}
+		/*
+		 * Check the (modified by chkdsk) restart page for consistency
+		 * and get a copy of the complete multi sector transfer
+		 * deprotected restart page.
+		 */
+		err = ntfs_check_and_load_restart_page(log_vi,
+				(struct restart_page_header *)kaddr, pos,
+				!rstr1_ph ? &rstr1_ph : &rstr2_ph,
+				!rstr1_ph ? &rstr1_lsn : &rstr2_lsn);
+		if (!err) {
+			/*
+			 * If we have now found the first (modified by chkdsk)
+			 * restart page, continue looking for the second one.
+			 */
+			if (!pos) {
+				pos = NTFS_BLOCK_SIZE >> 1;
+				continue;
+			}
+			/*
+			 * We have now found the second (modified by chkdsk)
+			 * restart page, so we can stop looking.
+			 */
+			break;
+		}
+		/*
+		 * Error output already done inside the function.  Note, we do
+		 * not abort if the restart page was invalid as we might still
+		 * find a valid one further in the file.
+		 */
+		if (err != -EINVAL) {
+			ntfs_unmap_folio(folio, kaddr);
+			goto err_out;
+		}
+		/* Continue looking. */
+		if (!pos)
+			pos = NTFS_BLOCK_SIZE >> 1;
+	}
+	if (folio)
+		ntfs_unmap_folio(folio, kaddr);
+	if (logfile_is_empty) {
+		NVolSetLogFileEmpty(vol);
+is_empty:
+		ntfs_debug("Done.  (LogFile is empty.)");
+		return true;
+	}
+	if (!rstr1_ph) {
+		BUG_ON(rstr2_ph);
+		ntfs_error(vol->sb,
+			"Did not find any restart pages in LogFile and it was not empty.");
+		return false;
+	}
+	/* If both restart pages were found, use the more recent one. */
+	if (rstr2_ph) {
+		/*
+		 * If the second restart area is more recent, switch to it.
+		 * Otherwise just throw it away.
+		 */
+		if (rstr2_lsn > rstr1_lsn) {
+			ntfs_debug("Using second restart page as it is more recent.");
+			ntfs_free(rstr1_ph);
+			rstr1_ph = rstr2_ph;
+			/* rstr1_lsn = rstr2_lsn; */
+		} else {
+			ntfs_debug("Using first restart page as it is more recent.");
+			ntfs_free(rstr2_ph);
+		}
+		rstr2_ph = NULL;
+	}
+	/* All consistency checks passed. */
+	if (rp)
+		*rp = rstr1_ph;
+	else
+		ntfs_free(rstr1_ph);
+	ntfs_debug("Done.");
+	return true;
+err_out:
+	if (rstr1_ph)
+		ntfs_free(rstr1_ph);
+	return false;
+}
+
+/**
+ * ntfs_empty_logfile - empty the contents of the LogFile journal
+ * @log_vi:	struct inode of loaded journal LogFile to empty
+ *
+ * Empty the contents of the LogFile journal @log_vi and return 'true' on
+ * success and 'false' on error.
+ *
+ * This function assumes that the LogFile journal has already been consistency
+ * checked by a call to ntfs_check_logfile() and that ntfs_is_logfile_clean()
+ * has been used to ensure that the LogFile is clean.
+ */
+bool ntfs_empty_logfile(struct inode *log_vi)
+{
+	s64 vcn, end_vcn;
+	struct ntfs_inode *log_ni = NTFS_I(log_vi);
+	struct ntfs_volume *vol = log_ni->vol;
+	struct super_block *sb = vol->sb;
+	struct runlist_element *rl;
+	unsigned long flags;
+	int err;
+	bool should_wait = true;
+	char *empty_buf = NULL;
+	struct file_ra_state *ra = NULL;
+
+	ntfs_debug("Entering.");
+	if (NVolLogFileEmpty(vol)) {
+		ntfs_debug("Done.");
+		return true;
+	}
+
+	/*
+	 * We cannot use ntfs_attr_set() because we may be still in the middle
+	 * of a mount operation.  Thus we do the emptying by hand by first
+	 * zapping the page cache pages for the LogFile/DATA attribute and
+	 * then emptying each of the buffers in each of the clusters specified
+	 * by the runlist by hand.
+	 */
+	vcn = 0;
+	read_lock_irqsave(&log_ni->size_lock, flags);
+	end_vcn = (log_ni->initialized_size + vol->cluster_size_mask) >>
+			vol->cluster_size_bits;
+	read_unlock_irqrestore(&log_ni->size_lock, flags);
+	truncate_inode_pages(log_vi->i_mapping, 0);
+	down_write(&log_ni->runlist.lock);
+	rl = log_ni->runlist.rl;
+	if (unlikely(!rl || vcn < rl->vcn || !rl->length)) {
+map_vcn:
+		err = ntfs_map_runlist_nolock(log_ni, vcn, NULL);
+		if (err) {
+			ntfs_error(sb, "Failed to map runlist fragment (error %d).", -err);
+			goto err;
+		}
+		rl = log_ni->runlist.rl;
+		BUG_ON(!rl || vcn < rl->vcn || !rl->length);
+	}
+	/* Seek to the runlist element containing @vcn. */
+	while (rl->length && vcn >= rl[1].vcn)
+		rl++;
+
+	err = -ENOMEM;
+	empty_buf = ntfs_malloc_nofs(vol->cluster_size);
+	if (!empty_buf)
+		goto err;
+
+	memset(empty_buf, 0xff, vol->cluster_size);
+
+	ra = kzalloc(sizeof(*ra), GFP_NOFS);
+	if (!ra)
+		goto err;
+
+	file_ra_state_init(ra, sb->s_bdev->bd_mapping);
+	do {
+		s64 lcn;
+		loff_t start, end;
+		s64 len;
+
+		/*
+		 * If this run is not mapped map it now and start again as the
+		 * runlist will have been updated.
+		 */
+		lcn = rl->lcn;
+		if (unlikely(lcn == LCN_RL_NOT_MAPPED)) {
+			vcn = rl->vcn;
+			ntfs_free(empty_buf);
+			goto map_vcn;
+		}
+		/* If this run is not valid abort with an error. */
+		if (unlikely(!rl->length || lcn < LCN_HOLE))
+			goto rl_err;
+		/* Skip holes. */
+		if (lcn == LCN_HOLE)
+			continue;
+		start = lcn << vol->cluster_size_bits;
+		len = rl->length;
+		if (rl[1].vcn > end_vcn)
+			len = end_vcn - rl->vcn;
+		end = (lcn + len) << vol->cluster_size_bits;
+
+		page_cache_sync_readahead(sb->s_bdev->bd_mapping, ra, NULL,
+			start >> PAGE_SHIFT, (end - start) >> PAGE_SHIFT);
+
+		do {
+			err = ntfs_dev_write(sb, empty_buf, start,
+						  vol->cluster_size, should_wait);
+			if (err) {
+				ntfs_error(sb, "ntfs_dev_write failed, err : %d\n", err);
+				goto io_err;
+			}
+
+			/*
+			 * Submit the buffer and wait for i/o to complete but
+			 * only for the first buffer so we do not miss really
+			 * serious i/o errors.  Once the first buffer has
+			 * completed ignore errors afterwards as we can assume
+			 * that if one buffer worked all of them will work.
+			 */
+			if (should_wait)
+				should_wait = false;
+			start += vol->cluster_size;
+		} while (start < end);
+	} while ((++rl)->vcn < end_vcn);
+	up_write(&log_ni->runlist.lock);
+	kfree(empty_buf);
+	kfree(ra);
+	truncate_inode_pages(log_vi->i_mapping, 0);
+	/* Set the flag so we do not have to do it again on remount. */
+	NVolSetLogFileEmpty(vol);
+	ntfs_debug("Done.");
+	return true;
+io_err:
+	ntfs_error(sb, "Failed to write buffer.  Unmount and run chkdsk.");
+	goto dirty_err;
+rl_err:
+	ntfs_error(sb, "Runlist is corrupt.  Unmount and run chkdsk.");
+dirty_err:
+	NVolSetErrors(vol);
+	err = -EIO;
+err:
+	ntfs_free(empty_buf);
+	kfree(ra);
+	up_write(&log_ni->runlist.lock);
+	ntfs_error(sb, "Failed to fill LogFile with 0xff bytes (error %d).",
+			-err);
+	return false;
+}
diff --git a/fs/ntfsplus/misc.c b/fs/ntfsplus/misc.c
new file mode 100644
index 000000000000..fcb66c106c78
--- /dev/null
+++ b/fs/ntfsplus/misc.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS kernel debug support. Part of the Linux-NTFS project.
+ *
+ * Copyright (C) 1997 Martin von Löwis, Régis Duchesne
+ * Copyright (c) 2001-2005 Anton Altaparmakov
+ */
+
+#include <linux/module.h>
+#ifdef CONFIG_SYSCTL
+#include <linux/proc_fs.h>
+#include <linux/sysctl.h>
+#endif
+
+#include "misc.h"
+
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+/**
+ * __ntfs_warning - output a warning to the syslog
+ * @function:	name of function outputting the warning
+ * @sb:		super block of mounted ntfs filesystem
+ * @fmt:	warning string containing format specifications
+ * @...:	a variable number of arguments specified in @fmt
+ *
+ * Outputs a warning to the syslog for the mounted ntfs filesystem described
+ * by @sb.
+ *
+ * @fmt and the corresponding @... is printf style format string containing
+ * the warning string and the corresponding format arguments, respectively.
+ *
+ * @function is the name of the function from which __ntfs_warning is being
+ * called.
+ *
+ * Note, you should be using debug.h::ntfs_warning(@sb, @fmt, @...) instead
+ * as this provides the @function parameter automatically.
+ */
+void __ntfs_warning(const char *function, const struct super_block *sb,
+		const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int flen = 0;
+
+	if (function)
+		flen = strlen(function);
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+#ifndef DEBUG
+	if (sb)
+		pr_warn_ratelimited("(device %s): %s(): %pV\n",
+			sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_warn_ratelimited("%s(): %pV\n", flen ? function : "", &vaf);
+#else
+	if (sb)
+		pr_warn("(device %s): %s(): %pV\n",
+			sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_warn("%s(): %pV\n", flen ? function : "", &vaf);
+#endif
+	va_end(args);
+}
+
+/**
+ * __ntfs_error - output an error to the syslog
+ * @function:	name of function outputting the error
+ * @sb:		super block of mounted ntfs filesystem
+ * @fmt:	error string containing format specifications
+ * @...:	a variable number of arguments specified in @fmt
+ *
+ * Outputs an error to the syslog for the mounted ntfs filesystem described
+ * by @sb.
+ *
+ * @fmt and the corresponding @... is printf style format string containing
+ * the error string and the corresponding format arguments, respectively.
+ *
+ * @function is the name of the function from which __ntfs_error is being
+ * called.
+ *
+ * Note, you should be using debug.h::ntfs_error(@sb, @fmt, @...) instead
+ * as this provides the @function parameter automatically.
+ */
+void __ntfs_error(const char *function, struct super_block *sb,
+		const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int flen = 0;
+
+	if (function)
+		flen = strlen(function);
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+#ifndef DEBUG
+	if (sb)
+		pr_err_ratelimited("(device %s): %s(): %pV\n",
+		       sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_err_ratelimited("%s(): %pV\n", flen ? function : "", &vaf);
+#else
+	if (sb)
+		pr_err("(device %s): %s(): %pV\n",
+		       sb->s_id, flen ? function : "", &vaf);
+	else
+		pr_err("%s(): %pV\n", flen ? function : "", &vaf);
+#endif
+	va_end(args);
+
+	if (sb)
+		ntfs_handle_error(sb);
+}
+
+#ifdef DEBUG
+
+/* If 1, output debug messages, and if 0, don't. */
+int debug_msgs;
+
+void __ntfs_debug(const char *file, int line, const char *function,
+		const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int flen = 0;
+
+	if (!debug_msgs)
+		return;
+	if (function)
+		flen = strlen(function);
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	pr_debug("(%s, %d): %s(): %pV", file, line, flen ? function : "", &vaf);
+	va_end(args);
+}
+
+/* Dump a runlist. Caller has to provide synchronisation for @rl. */
+void ntfs_debug_dump_runlist(const struct runlist_element *rl)
+{
+	int i;
+	const char *lcn_str[5] = { "LCN_DELALLOC     ", "LCN_HOLE         ",
+				   "LCN_RL_NOT_MAPPED", "LCN_ENOENT       ",
+				   "LCN_unknown      " };
+
+	if (!debug_msgs)
+		return;
+	pr_debug("Dumping runlist (values in hex):\n");
+	if (!rl) {
+		pr_debug("Run list not present.\n");
+		return;
+	}
+	pr_debug("VCN              LCN               Run length\n");
+	for (i = 0; ; i++) {
+		s64 lcn = (rl + i)->lcn;
+
+		if (lcn < (s64)0) {
+			int index = -lcn - 1;
+
+			if (index > -LCN_ENOENT - 1)
+				index = 3;
+			pr_debug("%-16Lx %s %-16Lx%s\n",
+					(long long)(rl + i)->vcn, lcn_str[index],
+					(long long)(rl + i)->length,
+					(rl + i)->length ? "" :
+						" (runlist end)");
+		} else
+			pr_debug("%-16Lx %-16Lx  %-16Lx%s\n",
+					(long long)(rl + i)->vcn,
+					(long long)(rl + i)->lcn,
+					(long long)(rl + i)->length,
+					(rl + i)->length ? "" :
+						" (runlist end)");
+		if (!(rl + i)->length)
+			break;
+	}
+}
+
+#ifdef CONFIG_SYSCTL
+/* Definition of the ntfs sysctl. */
+static const struct ctl_table ntfs_sysctls[] = {
+	{
+		.procname	= "ntfs-debug",
+		.data		= &debug_msgs,		/* Data pointer and size. */
+		.maxlen		= sizeof(debug_msgs),
+		.mode		= 0644,			/* Mode, proc handler. */
+		.proc_handler	= proc_dointvec
+	},
+	{}
+};
+
+/* Storage for the sysctls header. */
+static struct ctl_table_header *sysctls_root_table;
+
+/**
+ * ntfs_sysctl - add or remove the debug sysctl
+ * @add:	add (1) or remove (0) the sysctl
+ *
+ * Add or remove the debug sysctl. Return 0 on success or -errno on error.
+ */
+int ntfs_sysctl(int add)
+{
+	if (add) {
+		BUG_ON(sysctls_root_table);
+		sysctls_root_table = register_sysctl("fs", ntfs_sysctls);
+		if (!sysctls_root_table)
+			return -ENOMEM;
+	} else {
+		BUG_ON(!sysctls_root_table);
+		unregister_sysctl_table(sysctls_root_table);
+		sysctls_root_table = NULL;
+	}
+	return 0;
+}
+#endif /* CONFIG_SYSCTL */
+#endif
diff --git a/fs/ntfsplus/unistr.c b/fs/ntfsplus/unistr.c
new file mode 100644
index 000000000000..fb52769d12cd
--- /dev/null
+++ b/fs/ntfsplus/unistr.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NTFS Unicode string handling. Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001-2006 Anton Altaparmakov
+ */
+
+#include "ntfs.h"
+#include "misc.h"
+
+/*
+ * IMPORTANT
+ * =========
+ *
+ * All these routines assume that the Unicode characters are in little endian
+ * encoding inside the strings!!!
+ */
+
+/*
+ * This is used by the name collation functions to quickly determine what
+ * characters are (in)valid.
+ */
+static const u8 legal_ansi_char_array[0x40] = {
+	0x00, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
+	0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
+
+	0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
+	0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10,
+
+	0x17, 0x07, 0x18, 0x17, 0x17, 0x17, 0x17, 0x17,
+	0x17, 0x17, 0x18, 0x16, 0x16, 0x17, 0x07, 0x00,
+
+	0x17, 0x17, 0x17, 0x17, 0x17, 0x17, 0x17, 0x17,
+	0x17, 0x17, 0x04, 0x16, 0x18, 0x16, 0x18, 0x18,
+};
+
+/**
+ * ntfs_are_names_equal - compare two Unicode names for equality
+ * @s1:			name to compare to @s2
+ * @s1_len:		length in Unicode characters of @s1
+ * @s2:			name to compare to @s1
+ * @s2_len:		length in Unicode characters of @s2
+ * @ic:			ignore case bool
+ * @upcase:		upcase table (only if @ic == IGNORE_CASE)
+ * @upcase_size:	length in Unicode characters of @upcase (if present)
+ *
+ * Compare the names @s1 and @s2 and return 'true' (1) if the names are
+ * identical, or 'false' (0) if they are not identical. If @ic is IGNORE_CASE,
+ * the @upcase table is used to performa a case insensitive comparison.
+ */
+bool ntfs_are_names_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len, const u32 ic,
+		const __le16 *upcase, const u32 upcase_size)
+{
+	if (s1_len != s2_len)
+		return false;
+	if (ic == CASE_SENSITIVE)
+		return !ntfs_ucsncmp(s1, s2, s1_len);
+	return !ntfs_ucsncasecmp(s1, s2, s1_len, upcase, upcase_size);
+}
+
+/**
+ * ntfs_collate_names - collate two Unicode names
+ * @name1:	first Unicode name to compare
+ * @name2:	second Unicode name to compare
+ * @err_val:	if @name1 contains an invalid character return this value
+ * @ic:		either CASE_SENSITIVE or IGNORE_CASE
+ * @upcase:	upcase table (ignored if @ic is CASE_SENSITIVE)
+ * @upcase_len:	upcase table size (ignored if @ic is CASE_SENSITIVE)
+ *
+ * ntfs_collate_names collates two Unicode names and returns:
+ *
+ *  -1 if the first name collates before the second one,
+ *   0 if the names match,
+ *   1 if the second name collates before the first one, or
+ * @err_val if an invalid character is found in @name1 during the comparison.
+ *
+ * The following characters are considered invalid: '"', '*', '<', '>' and '?'.
+ */
+int ntfs_collate_names(const __le16 *name1, const u32 name1_len,
+		const __le16 *name2, const u32 name2_len,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len)
+{
+	u32 cnt, min_len;
+	u16 c1, c2;
+
+	min_len = name1_len;
+	if (name1_len > name2_len)
+		min_len = name2_len;
+	for (cnt = 0; cnt < min_len; ++cnt) {
+		c1 = le16_to_cpu(*name1++);
+		c2 = le16_to_cpu(*name2++);
+		if (ic) {
+			if (c1 < upcase_len)
+				c1 = le16_to_cpu(upcase[c1]);
+			if (c2 < upcase_len)
+				c2 = le16_to_cpu(upcase[c2]);
+		}
+		if (c1 < 64 && legal_ansi_char_array[c1] & 8)
+			return err_val;
+		if (c1 < c2)
+			return -1;
+		if (c1 > c2)
+			return 1;
+	}
+	if (name1_len < name2_len)
+		return -1;
+	if (name1_len == name2_len)
+		return 0;
+	/* name1_len > name2_len */
+	c1 = le16_to_cpu(*name1);
+	if (c1 < 64 && legal_ansi_char_array[c1] & 8)
+		return err_val;
+	return 1;
+}
+
+/**
+ * ntfs_ucsncmp - compare two little endian Unicode strings
+ * @s1:		first string
+ * @s2:		second string
+ * @n:		maximum unicode characters to compare
+ *
+ * Compare the first @n characters of the Unicode strings @s1 and @s2,
+ * The strings in little endian format and appropriate le16_to_cpu()
+ * conversion is performed on non-little endian machines.
+ *
+ * The function returns an integer less than, equal to, or greater than zero
+ * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
+ * to be less than, to match, or be greater than @s2.
+ */
+int ntfs_ucsncmp(const __le16 *s1, const __le16 *s2, size_t n)
+{
+	u16 c1, c2;
+	size_t i;
+
+	for (i = 0; i < n; ++i) {
+		c1 = le16_to_cpu(s1[i]);
+		c2 = le16_to_cpu(s2[i]);
+		if (c1 < c2)
+			return -1;
+		if (c1 > c2)
+			return 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+
+/**
+ * ntfs_ucsncasecmp - compare two little endian Unicode strings, ignoring case
+ * @s1:			first string
+ * @s2:			second string
+ * @n:			maximum unicode characters to compare
+ * @upcase:		upcase table
+ * @upcase_size:	upcase table size in Unicode characters
+ *
+ * Compare the first @n characters of the Unicode strings @s1 and @s2,
+ * ignoring case. The strings in little endian format and appropriate
+ * le16_to_cpu() conversion is performed on non-little endian machines.
+ *
+ * Each character is uppercased using the @upcase table before the comparison.
+ *
+ * The function returns an integer less than, equal to, or greater than zero
+ * if @s1 (or the first @n Unicode characters thereof) is found, respectively,
+ * to be less than, to match, or be greater than @s2.
+ */
+int ntfs_ucsncasecmp(const __le16 *s1, const __le16 *s2, size_t n,
+		const __le16 *upcase, const u32 upcase_size)
+{
+	size_t i;
+	u16 c1, c2;
+
+	for (i = 0; i < n; ++i) {
+		c1 = le16_to_cpu(s1[i]);
+		if (c1 < upcase_size)
+			c1 = le16_to_cpu(upcase[c1]);
+		c2 = le16_to_cpu(s2[i]);
+		if (c2 < upcase_size)
+			c2 = le16_to_cpu(upcase[c2]);
+		if (c1 < c2)
+			return -1;
+		if (c1 > c2)
+			return 1;
+		if (!c1)
+			break;
+	}
+	return 0;
+}
+
+int ntfs_file_compare_values(const struct file_name_attr *file_name_attr1,
+		const struct file_name_attr *file_name_attr2,
+		const int err_val, const u32 ic,
+		const __le16 *upcase, const u32 upcase_len)
+{
+	return ntfs_collate_names((__le16 *)&file_name_attr1->file_name,
+			file_name_attr1->file_name_length,
+			(__le16 *)&file_name_attr2->file_name,
+			file_name_attr2->file_name_length,
+			err_val, ic, upcase, upcase_len);
+}
+
+/**
+ * ntfs_nlstoucs - convert NLS string to little endian Unicode string
+ *
+ * Convert the input string @ins, which is in whatever format the loaded NLS
+ * map dictates, into a little endian, 2-byte Unicode string.
+ *
+ * This function allocates the string and the caller is responsible for
+ * calling kmem_cache_free(ntfs_name_cache, *@outs); when finished with it.
+ *
+ * On success the function returns the number of Unicode characters written to
+ * the output string *@outs (>= 0), not counting the terminating Unicode NULL
+ * character. *@outs is set to the allocated output string buffer.
+ *
+ * On error, a negative number corresponding to the error code is returned. In
+ * that case the output string is not allocated. Both *@outs and *@outs_len
+ * are then undefined.
+ *
+ * This might look a bit odd due to fast path optimization...
+ */
+int ntfs_nlstoucs(const struct ntfs_volume *vol, const char *ins,
+		const int ins_len, __le16 **outs, int max_name_len)
+{
+	struct nls_table *nls = vol->nls_map;
+	__le16 *ucs;
+	wchar_t wc;
+	int i, o, wc_len;
+
+	/* We do not trust outside sources. */
+	if (likely(ins)) {
+		if (max_name_len > NTFS_MAX_NAME_LEN)
+			ucs = kvmalloc((max_name_len + 2) * sizeof(__le16),
+				       GFP_NOFS | __GFP_ZERO);
+		else
+			ucs = kmem_cache_alloc(ntfs_name_cache, GFP_NOFS);
+		if (likely(ucs)) {
+			if (vol->nls_utf8) {
+				o = utf8s_to_utf16s(ins, ins_len,
+						    UTF16_LITTLE_ENDIAN,
+						    ucs,
+						    max_name_len + 2);
+				if (o < 0 || o > max_name_len) {
+					wc_len = o;
+					goto name_err;
+				}
+			} else {
+				for (i = o = 0; i < ins_len; i += wc_len) {
+					wc_len = nls->char2uni(ins + i, ins_len - i,
+							&wc);
+					if (likely(wc_len >= 0 &&
+					    o < max_name_len)) {
+						if (likely(wc)) {
+							ucs[o++] = cpu_to_le16(wc);
+							continue;
+						} /* else if (!wc) */
+						break;
+					}
+
+					goto name_err;
+				}
+			}
+			ucs[o] = 0;
+			*outs = ucs;
+			return o;
+		} /* else if (!ucs) */
+		ntfs_debug("Failed to allocate buffer for converted name from ntfs_name_cache.");
+		return -ENOMEM;
+	} /* else if (!ins) */
+	ntfs_error(vol->sb, "Received NULL pointer.");
+	return -EINVAL;
+name_err:
+	if (max_name_len > NTFS_MAX_NAME_LEN)
+		kvfree(ucs);
+	else
+		kmem_cache_free(ntfs_name_cache, ucs);
+	if (wc_len < 0) {
+		ntfs_debug("Name using character set %s contains characters that cannot be converted to Unicode.",
+				nls->charset);
+		i = -EILSEQ;
+	} else {
+		ntfs_debug("Name is too long (maximum length for a name on NTFS is %d Unicode characters.",
+				max_name_len);
+		i = -ENAMETOOLONG;
+	}
+	return i;
+}
+
+/**
+ * ntfs_ucstonls - convert little endian Unicode string to NLS string
+ * @vol:	ntfs volume which we are working with
+ * @ins:	input Unicode string buffer
+ * @ins_len:	length of input string in Unicode characters
+ * @outs:	on return contains the (allocated) output NLS string buffer
+ * @outs_len:	length of output string buffer in bytes
+ *
+ * Convert the input little endian, 2-byte Unicode string @ins, of length
+ * @ins_len into the string format dictated by the loaded NLS.
+ *
+ * If *@outs is NULL, this function allocates the string and the caller is
+ * responsible for calling kfree(*@outs); when finished with it. In this case
+ * @outs_len is ignored and can be 0.
+ *
+ * On success the function returns the number of bytes written to the output
+ * string *@outs (>= 0), not counting the terminating NULL byte. If the output
+ * string buffer was allocated, *@outs is set to it.
+ *
+ * On error, a negative number corresponding to the error code is returned. In
+ * that case the output string is not allocated. The contents of *@outs are
+ * then undefined.
+ *
+ * This might look a bit odd due to fast path optimization...
+ */
+int ntfs_ucstonls(const struct ntfs_volume *vol, const __le16 *ins,
+		const int ins_len, unsigned char **outs, int outs_len)
+{
+	struct nls_table *nls = vol->nls_map;
+	unsigned char *ns;
+	int i, o, ns_len, wc;
+
+	/* We don't trust outside sources. */
+	if (ins) {
+		ns = *outs;
+		ns_len = outs_len;
+		if (ns && !ns_len) {
+			wc = -ENAMETOOLONG;
+			goto conversion_err;
+		}
+		if (!ns) {
+			ns_len = ins_len * NLS_MAX_CHARSET_SIZE;
+			ns = kmalloc(ns_len + 1, GFP_NOFS);
+			if (!ns)
+				goto mem_err_out;
+		}
+
+		if (vol->nls_utf8) {
+			o = utf16s_to_utf8s((const wchar_t *)ins, ins_len,
+					UTF16_LITTLE_ENDIAN, ns, ns_len);
+			if (o >= ns_len) {
+				wc = -ENAMETOOLONG;
+				goto conversion_err;
+			}
+			goto done;
+		}
+
+		for (i = o = 0; i < ins_len; i++) {
+retry:
+			wc = nls->uni2char(le16_to_cpu(ins[i]), ns + o,
+					ns_len - o);
+			if (wc > 0) {
+				o += wc;
+				continue;
+			} else if (!wc)
+				break;
+			else if (wc == -ENAMETOOLONG && ns != *outs) {
+				unsigned char *tc;
+				/* Grow in multiples of 64 bytes. */
+				tc = kmalloc((ns_len + 64) &
+						~63, GFP_NOFS);
+				if (tc) {
+					memcpy(tc, ns, ns_len);
+					ns_len = ((ns_len + 64) & ~63) - 1;
+					kfree(ns);
+					ns = tc;
+					goto retry;
+				} /* No memory so goto conversion_error; */
+			} /* wc < 0, real error. */
+			goto conversion_err;
+		}
+done:
+		ns[o] = 0;
+		*outs = ns;
+		return o;
+	} /* else (!ins) */
+	ntfs_error(vol->sb, "Received NULL pointer.");
+	return -EINVAL;
+conversion_err:
+	ntfs_error(vol->sb,
+		"Unicode name contains characters that cannot be converted to character set %s.  You might want to try to use the mount option nls=utf8.",
+		nls->charset);
+	if (ns != *outs)
+		kfree(ns);
+	if (wc != -ENAMETOOLONG)
+		wc = -EILSEQ;
+	return wc;
+mem_err_out:
+	ntfs_error(vol->sb, "Failed to allocate name!");
+	return -ENOMEM;
+}
+
+/**
+ * ntfs_ucsnlen - determine the length of a little endian Unicode string
+ * @s:		pointer to Unicode string
+ * @maxlen:	maximum length of string @s
+ *
+ * Return the number of Unicode characters in the little endian Unicode
+ * string @s up to a maximum of maxlen Unicode characters, not including
+ * the terminating (__le16)'\0'. If there is no (__le16)'\0' between @s
+ * and @s + @maxlen, @maxlen is returned.
+ *
+ * This function never looks beyond @s + @maxlen.
+ */
+static u32 ntfs_ucsnlen(const __le16 *s, u32 maxlen)
+{
+	u32 i;
+
+	for (i = 0; i < maxlen; i++) {
+		if (!le16_to_cpu(s[i]))
+			break;
+	}
+	return i;
+}
+
+/**
+ * ntfs_ucsndup - duplicate little endian Unicode string
+ * @s:		pointer to Unicode string
+ * @maxlen:	maximum length of string @s
+ *
+ * Return a pointer to a new little endian Unicode string which is a duplicate
+ * of the string s.  Memory for the new string is obtained with ntfs_malloc(3),
+ * and can be freed with free(3).
+ *
+ * A maximum of @maxlen Unicode characters are copied and a terminating
+ * (__le16)'\0' little endian Unicode character is added.
+ *
+ * This function never looks beyond @s + @maxlen.
+ *
+ * Return a pointer to the new little endian Unicode string on success and NULL
+ * on failure with errno set to the error code.
+ */
+__le16 *ntfs_ucsndup(const __le16 *s, u32 maxlen)
+{
+	__le16 *dst;
+	u32 len;
+
+	len = ntfs_ucsnlen(s, maxlen);
+	dst = ntfs_malloc_nofs((len + 1) * sizeof(__le16));
+	if (dst) {
+		memcpy(dst, s, len * sizeof(__le16));
+		dst[len] = cpu_to_le16(L'\0');
+	}
+	return dst;
+}
+
+/**
+ * ntfs_names_are_equal - compare two Unicode names for equality
+ * @s1:                 name to compare to @s2
+ * @s1_len:             length in Unicode characters of @s1
+ * @s2:                 name to compare to @s1
+ * @s2_len:             length in Unicode characters of @s2
+ * @ic:                 ignore case bool
+ * @upcase:             upcase table (only if @ic == IGNORE_CASE)
+ * @upcase_size:        length in Unicode characters of @upcase (if present)
+ *
+ * Compare the names @s1 and @s2 and return TRUE (1) if the names are
+ * identical, or FALSE (0) if they are not identical. If @ic is IGNORE_CASE,
+ * the @upcase table is used to perform a case insensitive comparison.
+ */
+bool ntfs_names_are_equal(const __le16 *s1, size_t s1_len,
+		const __le16 *s2, size_t s2_len,
+		const u32 ic,
+		const __le16 *upcase, const u32 upcase_size)
+{
+	if (s1_len != s2_len)
+		return false;
+	if (!s1_len)
+		return true;
+	if (ic == CASE_SENSITIVE)
+		return ntfs_ucsncmp(s1, s2, s1_len) ? false : true;
+	return ntfs_ucsncasecmp(s1, s2, s1_len, upcase, upcase_size) ? false : true;
+}
diff --git a/fs/ntfsplus/upcase.c b/fs/ntfsplus/upcase.c
new file mode 100644
index 000000000000..a2b8e56edeff
--- /dev/null
+++ b/fs/ntfsplus/upcase.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Generate the full NTFS Unicode upcase table in little endian.
+ * Part of the Linux-NTFS project.
+ *
+ * Copyright (c) 2001 Richard Russon <ntfs@flatcap.org>
+ * Copyright (c) 2001-2006 Anton Altaparmakov
+ */
+
+#include "misc.h"
+#include "ntfs.h"
+
+__le16 *generate_default_upcase(void)
+{
+	static const int uc_run_table[][3] = { /* Start, End, Add */
+	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
+	{0x00E0, 0x00F7,  -32}, {0x045E, 0x0460, -80}, {0x1F72, 0x1F76,  86},
+	{0x00F8, 0x00FF,  -32}, {0x0561, 0x0587, -48}, {0x1F76, 0x1F78, 100},
+	{0x0256, 0x0258, -205}, {0x1F00, 0x1F08,   8}, {0x1F78, 0x1F7A, 128},
+	{0x028A, 0x028C, -217}, {0x1F10, 0x1F16,   8}, {0x1F7A, 0x1F7C, 112},
+	{0x03AC, 0x03AD,  -38}, {0x1F20, 0x1F28,   8}, {0x1F7C, 0x1F7E, 126},
+	{0x03AD, 0x03B0,  -37}, {0x1F30, 0x1F38,   8}, {0x1FB0, 0x1FB2,   8},
+	{0x03B1, 0x03C2,  -32}, {0x1F40, 0x1F46,   8}, {0x1FD0, 0x1FD2,   8},
+	{0x03C2, 0x03C3,  -31}, {0x1F51, 0x1F52,   8}, {0x1FE0, 0x1FE2,   8},
+	{0x03C3, 0x03CC,  -32}, {0x1F53, 0x1F54,   8}, {0x1FE5, 0x1FE6,   7},
+	{0x03CC, 0x03CD,  -64}, {0x1F55, 0x1F56,   8}, {0x2170, 0x2180, -16},
+	{0x03CD, 0x03CF,  -63}, {0x1F57, 0x1F58,   8}, {0x24D0, 0x24EA, -26},
+	{0x0430, 0x0450,  -32}, {0x1F60, 0x1F68,   8}, {0xFF41, 0xFF5B, -32},
+	{0}
+	};
+
+	static const int uc_dup_table[][2] = { /* Start, End */
+	{0x0100, 0x012F}, {0x01A0, 0x01A6}, {0x03E2, 0x03EF}, {0x04CB, 0x04CC},
+	{0x0132, 0x0137}, {0x01B3, 0x01B7}, {0x0460, 0x0481}, {0x04D0, 0x04EB},
+	{0x0139, 0x0149}, {0x01CD, 0x01DD}, {0x0490, 0x04BF}, {0x04EE, 0x04F5},
+	{0x014A, 0x0178}, {0x01DE, 0x01EF}, {0x04BF, 0x04BF}, {0x04F8, 0x04F9},
+	{0x0179, 0x017E}, {0x01F4, 0x01F5}, {0x04C1, 0x04C4}, {0x1E00, 0x1E95},
+	{0x018B, 0x018B}, {0x01FA, 0x0218}, {0x04C7, 0x04C8}, {0x1EA0, 0x1EF9},
+	{0}
+	};
+
+	static const int uc_word_table[][2] = { /* Offset, Value */
+	{0x00FF, 0x0178}, {0x01AD, 0x01AC}, {0x01F3, 0x01F1}, {0x0269, 0x0196},
+	{0x0183, 0x0182}, {0x01B0, 0x01AF}, {0x0253, 0x0181}, {0x026F, 0x019C},
+	{0x0185, 0x0184}, {0x01B9, 0x01B8}, {0x0254, 0x0186}, {0x0272, 0x019D},
+	{0x0188, 0x0187}, {0x01BD, 0x01BC}, {0x0259, 0x018F}, {0x0275, 0x019F},
+	{0x018C, 0x018B}, {0x01C6, 0x01C4}, {0x025B, 0x0190}, {0x0283, 0x01A9},
+	{0x0192, 0x0191}, {0x01C9, 0x01C7}, {0x0260, 0x0193}, {0x0288, 0x01AE},
+	{0x0199, 0x0198}, {0x01CC, 0x01CA}, {0x0263, 0x0194}, {0x0292, 0x01B7},
+	{0x01A8, 0x01A7}, {0x01DD, 0x018E}, {0x0268, 0x0197},
+	{0}
+	};
+
+	int i, r;
+	__le16 *uc;
+
+	uc = ntfs_malloc_nofs(default_upcase_len * sizeof(__le16));
+	if (!uc)
+		return uc;
+	memset(uc, 0, default_upcase_len * sizeof(__le16));
+	/* Generate the little endian Unicode upcase table used by ntfs. */
+	for (i = 0; i < default_upcase_len; i++)
+		uc[i] = cpu_to_le16(i);
+	for (r = 0; uc_run_table[r][0]; r++)
+		for (i = uc_run_table[r][0]; i < uc_run_table[r][1]; i++)
+			le16_add_cpu(&uc[i], uc_run_table[r][2]);
+	for (r = 0; uc_dup_table[r][0]; r++)
+		for (i = uc_dup_table[r][0]; i < uc_dup_table[r][1]; i += 2)
+			le16_add_cpu(&uc[i + 1], -1);
+	for (r = 0; uc_word_table[r][0]; r++)
+		uc[uc_word_table[r][0]] = cpu_to_le16(uc_word_table[r][1]);
+	return uc;
+}
-- 
2.34.1


