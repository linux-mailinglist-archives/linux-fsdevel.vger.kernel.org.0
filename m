Return-Path: <linux-fsdevel+bounces-56164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8CB14310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ACB18C2C69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AD27AC54;
	Mon, 28 Jul 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zjkz+Rld"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD536279907
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734692; cv=none; b=cjpxZpGWGDt0C6StGbN1XmPxsdRvTaNNbh4MZSjz3wAnkQMeRaE6FRAiwrpV3+ilGi+6NbHikkeCmAgNbTH2Uc/m/tokU6PPHm1PE1f83OJNUFFuLVesgebhAJIfjZ2KdFqarU97Xg8X0dOh44mJo4K5Q4U9ngUFY8RCfkpGct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734692; c=relaxed/simple;
	bh=vtEh005EKDpDotFFI+1Wg203jjL9iXcRk9HDHR9yBro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=er8L/qeyuw/4OMNT+E/TFzbzbEgRFwgT0/G9AW3xDE99/OBPkArlPSnD1JXrxDm2JaKws74okeevaHQ+bdxVNm6ZjrD6A6VG/XSNo9+XAHF/e9CcvRKiCWinKU/hg+le2vPydfQttQNMPemxEftJ+VMDsPYtjajfy1p0GYrYL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zjkz+Rld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=udEXP1NTqrVTD7aP+UIpVa47Z7hx6S3k4WMP0sChdIY=;
	b=Zjkz+Rld6KhCR/SH/lVvCa86XnIMDMe/wpqEBUMauerbCDqW6JmTnXHlac/pJsSYCxdSr5
	Quss0blMAEXwE17Nba0c7NE2+vbgyYcMu0JcODVK0jfBtLHETtQTBq5FAJqjIbPPT9X8xo
	7wcxsbBAU/6EqwxK5Bh8odNu2QSH6LM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-Adu3orhUPdiR0oLDg_KHnw-1; Mon, 28 Jul 2025 16:31:28 -0400
X-MC-Unique: Adu3orhUPdiR0oLDg_KHnw-1
X-Mimecast-MFC-AGG-ID: Adu3orhUPdiR0oLDg_KHnw_1753734687
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so6086855a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734687; x=1754339487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udEXP1NTqrVTD7aP+UIpVa47Z7hx6S3k4WMP0sChdIY=;
        b=nxpV6hpkA8tHsTR6FN5ZatiLWqATxT5m6frgf6ujczEU7Ry88aGkbM6SG+Im78AfPC
         zkEimhpERHzq+UGnCGsOJXo8aoo96z73ZhvkozFGAhbl6TkmTOBl2Rni0HUIphWewNwk
         PKWgX7yIPb7AOLuqLc3V93BRSo7cWX+kGL34X0L506cA7O0zVqm+wxf0A9vlzCVwNujI
         hOB/Auf44OTiZSg/SNVZqcn0trGapBJN1FTk6P7XaSIfBYsIK/LM2F05QNtcG7lw0J6E
         MvP4GExzu6UfJwpRSzB9NVktccKYVr+ANSUs4csc71gLChGpoLnbHy9GG5xtBKf2mxPK
         /PIA==
X-Forwarded-Encrypted: i=1; AJvYcCVgOsf0S+q8Zxk6wgD97t8FHhPJd21B/xEu/n7LGZlths6rowXYx/SSH/HkpeyplSkHCbXpfjxJFGMzCcyY@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmCBj+jW8b4N69Fh/CjuA98YAAGvJhu4nSK52ZE7zv7Afp2iC
	A5Pgs9GWJCO/3dHgu+BMjS+POhFGWwtzvvXIgUYlPX2h3XS9AyccATo8KOrTx3CDzxRW/P5J0lt
	1HCYbODCkc8Kg6nzVMVGIsmCLqydNZoBd6RTV9K5r6den8hd1T9C+P4SB20tYGbPuwQ==
X-Gm-Gg: ASbGncv9q33Nc04atjENrw40Njt9ks25OOed2xXluNoKjucWy68W/PxRMThMs5sxlji
	eoZIDU42cg+P6qWi3s1WRdBkmF9IbxQjHeuFwRm6691eoaEOy/n2mnK2ak9NUyr5bPmvnhmtHKV
	jZWxmFZvJMs+NEXQqXyaitthzPNKx2lpHWJqPoQ+9pv6vjGEbJ0dBqScaYGldi/MbsGrEFwD8V7
	62IjH21W+Z+nETj8lI/sb7Jb+pswzaXiiLrW0AimoiJ2uGlY7VtsfKAPZeb7Cy1Y54HOYBA9S0L
	7a5T/513AYwu7htfqQGb+wXp3JYiND8590Fz1JfCCJpreQ==
X-Received: by 2002:a05:6402:358b:b0:614:a23b:4959 with SMTP id 4fb4d7f45d1cf-614f1d1fe53mr12425636a12.10.1753734686866;
        Mon, 28 Jul 2025 13:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaaFKErrXH/4nNMLMgIEdNT/+wVU80xv876D9pn+I+rfx81s2qpSqObxivOn7N4osROcUwzA==
X-Received: by 2002:a05:6402:358b:b0:614:a23b:4959 with SMTP id 4fb4d7f45d1cf-614f1d1fe53mr12425599a12.10.1753734686262;
        Mon, 28 Jul 2025 13:31:26 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:25 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:09 +0200
Subject: [PATCH RFC 05/29] fsverity: add tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-5-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8381; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=zHxrqV5/JFTflwqY826/uVnZlU2AiK108yoYvS/c40o=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvic9ZZraiRjnraN3rTWnf85gupKocMTN0fZc5P
 5qRWWS+772OUhYGMS4GWTFFlnXSWlOTiqTyjxjUyMPMYWUCGcLAxSkAE5l/hJHh+tqJIR/X61Y7
 3mv/+FRu41mxoqcTgm/fzNF/2KT1cOvr7Qz/IzKiJNkfbOZb1hKusTFxs+5KiblvfW+q2jx4fNZ
 iod0RfgCBNko9
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

fs-verity previously had debug printk but it was removed. This patch
adds trace points to the same places where printk were used (with a
few additional ones).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix formatting]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MAINTAINERS                     |   1 +
 fs/verity/enable.c              |   4 ++
 fs/verity/fsverity_private.h    |   2 +
 fs/verity/init.c                |   1 +
 fs/verity/verify.c              |   9 +++
 include/trace/events/fsverity.h | 143 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..64575d2007f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9851,6 +9851,7 @@ T:	git https://git.kernel.org/pub/scm/fs/fsverity/linux.git
 F:	Documentation/filesystems/fsverity.rst
 F:	fs/verity/
 F:	include/linux/fsverity.h
+F:	include/trace/events/fsverity.h
 F:	include/uapi/linux/fsverity.h
 
 FT260 FTDI USB-HID TO I2C BRIDGE DRIVER
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index c284f46d1b53..7cf902051b2d 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -227,6 +227,8 @@ static int enable_verity(struct file *filp,
 	if (err)
 		goto out;
 
+	trace_fsverity_enable(inode, &params);
+
 	/*
 	 * Start enabling verity on this file, serialized by the inode lock.
 	 * Fail if verity is already enabled or is already being enabled.
@@ -269,6 +271,8 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	trace_fsverity_tree_done(inode, vi, &params);
+
 	/*
 	 * Tell the filesystem to finish enabling verity on the file.
 	 * Serialized with ->begin_enable_verity() by the inode lock.
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..04dd471d791c 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,4 +154,6 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+#include <trace/events/fsverity.h>
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/init.c b/fs/verity/init.c
index 6e8d33b50240..d65206608583 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -5,6 +5,7 @@
  * Copyright 2019 Google LLC
  */
 
+#define CREATE_TRACE_POINTS
 #include "fsverity_private.h"
 
 #include <linux/ratelimit.h>
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 30a3f6ada2ad..580486168467 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -109,6 +109,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Byte offset of the wanted hash relative to @addr */
 		unsigned int hoffset;
 	} hblocks[FS_VERITY_MAX_LEVELS];
+
+	trace_fsverity_verify_data_block(inode, params, data_pos);
+
 	/*
 	 * The index of the previous level's block within that level; also the
 	 * index of that block's hash within the current level.
@@ -184,6 +187,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			want_hash = _want_hash;
 			kunmap_local(haddr);
 			put_page(hpage);
+			trace_fsverity_merkle_hit(inode, data_pos, hblock_idx,
+					level,
+					hoffset >> params->log_digestsize);
 			goto descend;
 		}
 		hblocks[level].page = hpage;
@@ -219,6 +225,9 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		want_hash = _want_hash;
 		kunmap_local(haddr);
 		put_page(hpage);
+		trace_fsverity_verify_merkle_block(inode,
+				hblock_idx << params->log_blocksize,
+				level, hoffset >> params->log_digestsize);
 	}
 
 	/* Finally, verify the data block. */
diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
new file mode 100644
index 000000000000..dab220884b89
--- /dev/null
+++ b/include/trace/events/fsverity.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM fsverity
+
+#if !defined(_TRACE_FSVERITY_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_FSVERITY_H
+
+#include <linux/tracepoint.h>
+
+struct fsverity_descriptor;
+struct merkle_tree_params;
+struct fsverity_info;
+
+TRACE_EVENT(fsverity_enable,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_size)
+		__field(unsigned int, block_size)
+		__field(unsigned int, num_levels)
+		__field(u64, tree_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_size = i_size_read(inode);
+		__entry->block_size = params->block_size;
+		__entry->num_levels = params->num_levels;
+		__entry->tree_size = params->tree_size;
+	),
+	TP_printk("ino %lu data size %llu tree size %llu block size %u levels %u",
+		(unsigned long) __entry->ino,
+		__entry->data_size,
+		__entry->tree_size,
+		__entry->block_size,
+		__entry->num_levels)
+);
+
+TRACE_EVENT(fsverity_tree_done,
+	TP_PROTO(const struct inode *inode, const struct fsverity_info *vi,
+		 const struct merkle_tree_params *params),
+	TP_ARGS(inode, vi, params),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned int, levels)
+		__field(unsigned int, block_size)
+		__field(u64, tree_size)
+		__dynamic_array(u8, root_hash, params->digest_size)
+		__dynamic_array(u8, file_digest, params->digest_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->levels = params->num_levels;
+		__entry->block_size = params->block_size;
+		__entry->tree_size = params->tree_size;
+		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_array_len(root_hash));
+		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dynamic_array_len(file_digest));
+	),
+	TP_printk("ino %lu levels %d block_size %d tree_size %lld root_hash %s digest %s",
+		(unsigned long) __entry->ino,
+		__entry->levels,
+		__entry->block_size,
+		__entry->tree_size,
+		__print_hex_str(__get_dynamic_array(root_hash), __get_dynamic_array_len(root_hash)),
+		__print_hex_str(__get_dynamic_array(file_digest), __get_dynamic_array_len(file_digest)))
+);
+
+TRACE_EVENT(fsverity_verify_data_block,
+	TP_PROTO(const struct inode *inode,
+		 const struct merkle_tree_params *params,
+		 u64 data_pos),
+	TP_ARGS(inode, params, data_pos),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned int, block_size)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->block_size = params->block_size;
+	),
+	TP_printk("ino %lu pos %lld merkle_blocksize %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->block_size)
+);
+
+TRACE_EVENT(fsverity_merkle_hit,
+	TP_PROTO(const struct inode *inode, u64 data_pos,
+		 unsigned long hblock_idx, unsigned int level,
+		 unsigned int hidx),
+	TP_ARGS(inode, data_pos, hblock_idx, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(u64, data_pos)
+		__field(unsigned long, hblock_idx)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->data_pos = data_pos;
+		__entry->hblock_idx = hblock_idx;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu data_pos %llu hblock_idx %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->data_pos,
+		__entry->hblock_idx,
+		__entry->level,
+		__entry->hidx)
+);
+
+TRACE_EVENT(fsverity_verify_merkle_block,
+	TP_PROTO(const struct inode *inode, unsigned long index,
+		 unsigned int level, unsigned int hidx),
+	TP_ARGS(inode, index, level, hidx),
+	TP_STRUCT__entry(
+		__field(ino_t, ino)
+		__field(unsigned long, index)
+		__field(unsigned int, level)
+		__field(unsigned int, hidx)
+	),
+	TP_fast_assign(
+		__entry->ino = inode->i_ino;
+		__entry->index = index;
+		__entry->level = level;
+		__entry->hidx = hidx;
+	),
+	TP_printk("ino %lu index %lu level %u hidx %u",
+		(unsigned long) __entry->ino,
+		__entry->index,
+		__entry->level,
+		__entry->hidx)
+);
+
+#endif /* _TRACE_FSVERITY_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.50.0


