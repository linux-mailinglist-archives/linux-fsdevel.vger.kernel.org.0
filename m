Return-Path: <linux-fsdevel+bounces-563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66C7CCE97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58925281B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ADF2E3FA;
	Tue, 17 Oct 2023 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798E2430E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:19 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C2CED;
	Tue, 17 Oct 2023 13:48:18 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6b709048f32so3130633b3a.0;
        Tue, 17 Oct 2023 13:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575698; x=1698180498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoHPYDQbTkwUBMMunMv9kXgtGCryiEzUWGYqg25wuEw=;
        b=S+3GwpSZI88XIlFDGt7RMfiqSVDPkaZp+yMnkM0kPsx+MZDc6xZIH/2DBmxVwuGSHk
         n/G4KQIu8vc+LazMn0yBmmRgVhGB2UGdZ4nzJnRqZhuuCodJv5dOANEzVXsczEzSLn0V
         k5kp9ZV8rlSD9CsmVhMvBW1Pj3aiJK+Y0T+Ng5OTeeiab612tXZ8Sfe+KImPxwERW1mi
         2OkiPBfzvSnuIBw28yFTQD7YxE4gmGFI38c1KgrgywSzaKL0Qbx3ClF6Cdzp6bvMH6jw
         bLXyiodnz/lB5vs71SS8VSzhpF3p1YCZ3E42gf473gqfsZSm4PIRO1zOHayFbaoyj/lD
         mpWA==
X-Gm-Message-State: AOJu0YxRFuZ8bYFhpVw5k5dP7LwU0yxGJgtdEx3doUUr7Hf0lEcNm28M
	6CXncvD8Fazp8Ydau268C88=
X-Google-Smtp-Source: AGHT+IGGo232JgEpvGCW1xTE/zif4CZSXY7EyIlhzXdDHgWYzLvrFd1xG6e4xQ2gZEvytT8a+UK0wg==
X-Received: by 2002:a05:6a00:230b:b0:68b:c562:da65 with SMTP id h11-20020a056a00230b00b0068bc562da65mr3422101pfh.26.1697575697688;
        Tue, 17 Oct 2023 13:48:17 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:17 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 01/14] fs: Move enum rw_hint into a new header file
Date: Tue, 17 Oct 2023 13:47:09 -0700
Message-ID: <20231017204739.3409052-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017204739.3409052-1-bvanassche@acm.org>
References: <20231017204739.3409052-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move enum rw_hint into a new header file to prepare for using this data
type in the block layer. Add the attribute __packed to reduce the space
occupied by instances of this data type from four bytes to one byte.
Change the data type of i_write_hint from u8 into enum rw_hint. Change
the RWH_* constants into literal constants to prevent that
<uapi/linux/fcntl.h> would have to be included.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/f2fs.h          |  1 +
 fs/fcntl.c              |  1 +
 fs/inode.c              |  1 +
 include/linux/fs.h      | 16 ++--------------
 include/linux/rw_hint.h | 20 ++++++++++++++++++++
 5 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/rw_hint.h

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6d688e42d89c..56ee7fff55c7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
+#include <linux/rw_hint.h>
 #include <crypto/hash.h>
 
 #include <linux/fscrypt.h>
diff --git a/fs/fcntl.c b/fs/fcntl.c
index e871009f6c88..ed923640aecf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -27,6 +27,7 @@
 #include <linux/memfd.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
+#include <linux/rw_hint.h>
 
 #include <linux/poll.h>
 #include <asm/siginfo.h>
diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..ebcc41ac9682 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/rw_hint.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b528f063e8ff..971f0bafa782 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/rw_hint.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -309,19 +310,6 @@ struct address_space;
 struct writeback_control;
 struct readahead_control;
 
-/*
- * Write life time hint values.
- * Stored in struct inode as u8.
- */
-enum rw_hint {
-	WRITE_LIFE_NOT_SET	= 0,
-	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
-	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
-	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
-	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
-	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
-};
-
 /* Match RWF_* bits to IOCB bits */
 #define IOCB_HIPRI		(__force int) RWF_HIPRI
 #define IOCB_DSYNC		(__force int) RWF_DSYNC
@@ -677,7 +665,7 @@ struct inode {
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
-	u8			i_write_hint;
+	enum rw_hint		i_write_hint;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
new file mode 100644
index 000000000000..4a7d28945973
--- /dev/null
+++ b/include/linux/rw_hint.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RW_HINT_H
+#define _LINUX_RW_HINT_H
+
+#include <linux/build_bug.h>
+#include <linux/compiler_attributes.h>
+
+/* Block storage write lifetime hint values. */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET	= 0, /* RWH_WRITE_LIFE_NOT_SET */
+	WRITE_LIFE_NONE		= 1, /* RWH_WRITE_LIFE_NONE */
+	WRITE_LIFE_SHORT	= 2, /* RWH_WRITE_LIFE_SHORT */
+	WRITE_LIFE_MEDIUM	= 3, /* RWH_WRITE_LIFE_MEDIUM */
+	WRITE_LIFE_LONG		= 4, /* RWH_WRITE_LIFE_LONG */
+	WRITE_LIFE_EXTREME	= 5, /* RWH_WRITE_LIFE_EXTREME */
+} __packed;
+
+static_assert(sizeof(enum rw_hint) == 1);
+
+#endif /* _LINUX_RW_HINT_H */

