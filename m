Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9261452C801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiERXxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiERXxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA319FAC;
        Wed, 18 May 2022 16:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9D2061762;
        Wed, 18 May 2022 23:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00AFC34113;
        Wed, 18 May 2022 23:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652918009;
        bh=W4in/ybmcjm+UrJuvAG7UeC7pkJyRJbDj25/2WE1Eh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lOAtpiNFQkTYZE91Q/t5P4je8t/RVIkVfNdzALCn4RoRU4e4sFnMKtE93c6dW/6rZ
         L//O7wlP73j+497ckrHMFzwwn8p0H6HbGOTHeoaSmWCFZADXvSqBBAH3IExgDuGJ2j
         uB1z4wbDKYKUKl6H3vD43vI5utDgaLZSwkF30Ap9o6+SAfhV1CU/2O16gwjnaf0/Cx
         O6WgzKb3DQ/d865dHztAoRmWomCcYWCmZECuR0Rj7/Wbi6yGhj5j6SqbWwrugT3/AZ
         HNrSCu7xlXphpO/cuvQqNSqP0BdXAPtyBb+rJz/ndUVdzFELKDPmCfCgz5hGua/cDd
         l/bdVDq9X6gtQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH v2 1/7] statx: add I/O alignment information
Date:   Wed, 18 May 2022 16:50:05 -0700
Message-Id: <20220518235011.153058-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220518235011.153058-1-ebiggers@kernel.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 5c2c94464e8b0..9d477218545b8 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -611,6 +611,9 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
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
 
-- 
2.36.1

