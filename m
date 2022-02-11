Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB354B1E3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 07:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbiBKGNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 01:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344098AbiBKGN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:13:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF2264F;
        Thu, 10 Feb 2022 22:13:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACD31618D9;
        Fri, 11 Feb 2022 06:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64EDC340EE;
        Fri, 11 Feb 2022 06:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644560007;
        bh=v4Z7/3ccLV9l9/A9iCzRYflRcpiHdNFtsFH/Xy/He20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bV2HNQTYvNKD2d8C1h1tjhxxYn7oWtmG1QmA1eotxR7m9SehdeQRKf/NPoFtMFLFe
         Gd/i2PLmnI99H85dqGcG3uJHhZj61X6sZx3dWZQnshj71RrwqhjWESUDGXrY2zZqjX
         BUdu20XZuNz+g14WmApg8e8rAblQhBCWKXjNqkbqTT0Mgnf/URI9iUeANetbZG72pb
         CcstUxvrFgPqzGDWCc1/NvcCm8NEbHrQzu+Rqf/WYgxXwNBX2aLRefeMhsxypsfC0k
         39ALiuDziez8HgKNDbH2i7JjyoxO428h7ja700sf80XU+6QGy85/dzdTEq09AvIAzm
         Qbxa67AT3EqaA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/7] statx: add I/O alignment information
Date:   Thu, 10 Feb 2022 22:11:52 -0800
Message-Id: <20220211061158.227688-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211061158.227688-1-ebiggers@kernel.org>
References: <20220211061158.227688-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Traditionally, the conditions for when DIO (direct I/O) is supported
were fairly simple: filesystems either supported DIO aligned to the
block device's logical block size, or didn't support DIO at all.

However, due to filesystem features that have been added over time (e.g,
data journalling, inline data, encryption, verity, compression,
checkpoint disabling, log-structured mode), the conditions for when DIO
is allowed on a file have gotten increasingly complex.  Whether a
particular file supports DIO, and with what alignment, can depend on
various file attributes and filesystem mount options, as well as which
block device(s) the file's data is located on.

XFS has an ioctl XFS_IOC_DIOINFO which exposes this information to
applications.  However, as discussed
(https://lore.kernel.org/linux-fsdevel/20220120071215.123274-1-ebiggers@kernel.org/T/#u),
this ioctl is rarely used and not known to be used outside of
XFS-specific code.  It also was never intended to indicate when a file
doesn't support DIO at all, and it only exposes the minimum I/O
alignment, not the optimal I/O alignment which has been requested too.

Therefore, let's expose this information via statx().  Add the
STATX_IOALIGN flag and three fields associated with it:

* stx_mem_align_dio: the alignment (in bytes) required for user memory
  buffers for DIO, or 0 if DIO is not supported on the file.

* stx_offset_align_dio: the alignment (in bytes) required for file
  offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
  on the file.  This will only be nonzero if stx_mem_align_dio is
  nonzero, and vice versa.

* stx_offset_align_optimal: the alignment (in bytes) suggested for file
  offsets and I/O segment lengths to get optimal performance.  This
  applies to both DIO and buffered I/O.  It differs from stx_blocksize
  in that stx_offset_align_optimal will contain the real optimum I/O
  size, which may be a large value.  In contrast, for compatibility
  reasons stx_blocksize is the minimum size needed to avoid page cache
  read/write/modify cycles, which may be much smaller than the optimum
  I/O size.  For more details about the motivation for this field, see
  https://lore.kernel.org/r/20220210040304.GM59729@dread.disaster.area

Note that as with other statx() extensions, if STATX_IOALIGN isn't set
in the returned statx struct, then these new fields won't be filled in.
This will happen if the filesystem doesn't support STATX_IOALIGN, or if
the file isn't a regular file.  (It might be supported on block device
files in the future.)  It might also happen if the caller didn't include
STATX_IOALIGN in the request mask, since statx() isn't required to
return information that wasn't requested.

This commit adds the VFS-level plumbing for STATX_IOALIGN.  Individual
filesystems will still need to add code to support it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/stat.c                 | 3 +++
 include/linux/stat.h      | 3 +++
 include/uapi/linux/stat.h | 9 +++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f42..093c506e69c7b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -598,6 +598,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
 	tmp.stx_mnt_id = stat->mnt_id;
+	tmp.stx_mem_align_dio = stat->mem_align_dio;
+	tmp.stx_offset_align_dio = stat->offset_align_dio;
+	tmp.stx_offset_align_optimal = stat->offset_align_optimal;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 7df06931f25d8..48b8b1ad1567c 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -50,6 +50,9 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	u32		mem_align_dio;
+	u32		offset_align_dio;
+	u32		offset_align_optimal;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041a..f822b23e81091 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -124,9 +124,13 @@ struct statx {
 	__u32	stx_dev_minor;
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u64	__spare2;
+	__u32	stx_mem_align_dio;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_offset_align_dio;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_offset_align_optimal; /* Optimal file offset alignment for I/O */
+	__u32	__spare2;
+	/* 0xa8 */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -152,6 +156,7 @@ struct statx {
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_IOALIGN		0x00002000U	/* Want/got IO alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 

base-commit: cdaa1b1941f667814300799ddb74f3079517cd5a
-- 
2.35.1

