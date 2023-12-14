Return-Path: <linux-fsdevel+bounces-6143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BD0813BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7C01F225EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5D6ABA3;
	Thu, 14 Dec 2023 20:42:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727AC6D1DF;
	Thu, 14 Dec 2023 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d05199f34dso50257905ad.3;
        Thu, 14 Dec 2023 12:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586533; x=1703191333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+EPIOgtWnZZFMdEPXVpPJg6okBBXxZhbiR/xWxI+Eo=;
        b=YgUKvTquvnWgBOqnl0y8jgNovtPLkbVYTurxerw6tWa2cHNCcPFJhHpQ3vLZjQmHvo
         9imRREgKo8D0c+UY7oDJRS2Q6MjCzDxsdwgWLVRqdb5CPXPky698uDz3iwrpj9YBnYbz
         KI9UBaEB0kdWZOGJLELsCP6FkF1m3J4+rHgaQK6OSigN3fTzR1q87uW7QyBu+HHo4bWH
         wtbo2ZBjv2TWQxgtsaQube3/iDiycGnLxTg0mtr3DbT36HhDwR6anElV9SUCd6Bl+ipZ
         Wxm3rrW6ovbP0+Z8kmog5Jm4We8GnvvUhnNKHZm9BUwP+4eM1BX7HlnaVvs7y5SNTwYA
         HizQ==
X-Gm-Message-State: AOJu0YxHddOCm2zQM/TTmeFo656TYH39fVznb5Nq231gRxz3+qAv6USs
	5PltQwu+HRNscSnmz3bktyo=
X-Google-Smtp-Source: AGHT+IGOveIsRlR2TbvADtzxeUCkk4blQ6POBkkA5ItgKWNEk6Xjj0zMRVvQEO6ezNGJPJ2/BsHRhA==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:6e90 with SMTP id h12-20020a170902704c00b001d06ffd6e90mr5526830plt.136.1702586532536;
        Thu, 14 Dec 2023 12:42:12 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:12 -0800 (PST)
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
	Jan Kara <jack@suse.cz>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 04/20] fs: Move enum rw_hint into a new header file
Date: Thu, 14 Dec 2023 12:40:37 -0800
Message-ID: <20231214204119.3670625-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
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
Change the data type of i_write_hint from u8 into enum rw_hint.

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
 include/linux/rw_hint.h | 21 +++++++++++++++++++++
 5 files changed, 26 insertions(+), 14 deletions(-)
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
index 5fa2d95114bf..fc73c5fae43c 100644
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
index edcd8a61975f..a1384807ab58 100644
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
index 000000000000..6334ec6e6663
--- /dev/null
+++ b/include/linux/rw_hint.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RW_HINT_H
+#define _LINUX_RW_HINT_H
+
+#include <linux/build_bug.h>
+#include <linux/compiler_attributes.h>
+#include <uapi/linux/fcntl.h>
+
+/* Block storage write lifetime hint values. */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET	= RWH_WRITE_LIFE_NOT_SET,
+	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+} __packed;
+
+static_assert(sizeof(enum rw_hint) == 1);
+
+#endif /* _LINUX_RW_HINT_H */

