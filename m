Return-Path: <linux-fsdevel+bounces-4297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E527FE6FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 03:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BC81C20A35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C3134B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA4010E0;
	Wed, 29 Nov 2023 17:33:34 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so453962b3a.1;
        Wed, 29 Nov 2023 17:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308014; x=1701912814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DqEdOzzpLXhICSCovYeDw12nQt86z03QQQINZokAFs=;
        b=oIb3c6B7MhlrhpPpvaQ2mEhh2UMS6k6/SETQNaOvINk1xAv1zGJBF7UnjEU7zXyYCB
         xrh2U2bq4BiQnIrpRLAynF4AQeQOaNLT6TePDz4o6oJ1OKFQAqG53xQA1kj7XM0BmXbY
         adyup8EZ6L7iwL2Nr0R4gixLQNlXgUxqydEYpo35aCSALvtMFnddbQ1F5h8HHGXRZLQj
         G/6RXAP9BgIUjRLULW4aUx3pH+YuhQee1H6QX6pJZTDThx8pv4PyKVpRbf8FqjfCc7Ht
         2o5XRstPHJnEPP3CZu1AhJeF6JLAJ8QXTWecJIHhurw5fMSGzQA5G7WBjI3zKU+9pV9Y
         nvMQ==
X-Gm-Message-State: AOJu0YyH0tngSrmGyC0DUhFBnXkjhG4uXz/7RKYuR7NMYTYwUatrbZLS
	MOfpU65GGNGaXpN71D33SAs=
X-Google-Smtp-Source: AGHT+IGIxp5nUj6nVmOUs2wjbFDIYaVcITCkexM1z0vHAJ8/NEtHtnxOUyKLJOOJqRrFJhqTUibVQg==
X-Received: by 2002:a05:6a21:2724:b0:15b:c800:48af with SMTP id rm36-20020a056a21272400b0015bc80048afmr17095559pzb.23.1701308013644;
        Wed, 29 Nov 2023 17:33:33 -0800 (PST)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm2021936pju.46.2023.11.29.17.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 17:33:33 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v5 02/17] fs: Move enum rw_hint into a new header file
Date: Wed, 29 Nov 2023 17:33:07 -0800
Message-ID: <20231130013322.175290-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130013322.175290-1-bvanassche@acm.org>
References: <20231130013322.175290-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move enum rw_hint into a new header file to prepare for using this data
type in the block layer. Add the attribute __packed to reduce the space
occupied by instances of this data type from four bytes to one byte.
Change the data type of i_write_hint from u8 into enum rw_hint. Change
the RWH_* constants into literal constants to prevent that
<uapi/linux/fcntl.h> would have to be included.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
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
index 9043cedfa12b..8e0c66a6b097 100644
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
index 3ff707bf2743..891a9ebcdef1 100644
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
index f238d987dec9..3b4f58932173 100644
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
index 98b7a7a8c42e..a08014b68d6e 100644
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

