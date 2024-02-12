Return-Path: <linux-fsdevel+bounces-11150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD74851A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C271C21C13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF83F8ED;
	Mon, 12 Feb 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wdno7twC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09D3E47B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757209; cv=none; b=LMjRlOda5myVd7eNTBwidqHuwxBeHxPKDQJjnHwdPJ2o4mejAAj+RdVyVCcksSgq5H+zVs3HH4fS1DtAAhWitYtrVib3z1kW42JVcEI2tHnczmbGvyJ1h8gQZtD1oyoo8ApAL0oSg/RmTjn0i23P2+V37GD+xvlZzLnI0I0UmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757209; c=relaxed/simple;
	bh=vytFJhafSlNOFYEGf84JO8aTnuZyHLMQrT6EUAXU8QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKVgle7q5jmZ9hA1rBMtCfdvY/AdYfS71r1dHsDcnJwc837DLtJwinJaMJdbF8042jvCc89hQYLwIwwp9o2JKQmQ+ebDrKO4TshDUTMn/AwKsqG1X1bBJ6GzgQ+ByHp5Dpu6+Fdl4qJDuUdIU/M1RMP8fmnzsn7VDm2+ZPhXaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wdno7twC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebt0keKqegC1RQu3ybPvxOlJeNn/hqPElNtU8o7e1Xg=;
	b=Wdno7twCitCYJ65j9Bo/4lu+gWbogpl1R8FEMSQLRNOHchJwk7D5nny/1DIWgBNY1WaZTa
	+u48uri6rSuOguOPoX2jBT9GN5DJvkpybFbEN+wsro2zHT6xwx2itFcSiFx5EmccFRTol4
	LfpEadV9u36qzV90hdNu0LL4saPZgLo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-dnAk2wTbOWupvTCmJylfpA-1; Mon, 12 Feb 2024 12:00:05 -0500
X-MC-Unique: dnAk2wTbOWupvTCmJylfpA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-55d71ec6ef3so2348801a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757203; x=1708362003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebt0keKqegC1RQu3ybPvxOlJeNn/hqPElNtU8o7e1Xg=;
        b=JYMTsPfXH91ev4zj/rV1cK18aRzxgvzdWgHlaPByQljKuW5dmL9YFujgtgwj8LQnvT
         TPmA+cDX93JWEEtc3uceJicSwIFQHceoragc6neyYUL2DInjdU1PXb1oWwJCEx0mHrt1
         PwX86D4JcCfGiTEDZF5GGGuNP9euNKhkM9fDflkCYOMWW46Rahi4jOemb7lgqYYCde9Q
         TwOyb3usyg6BY3BcmPXxCBCEwWVrJxapb36VABltExX0xV4yMp8n0MBZkPD/upkTHUr8
         mHEZ+d6Rwp6dSbpOUdmFa1EkomT/eEODDBPoJ8Q7cXfK6LuOObum095CvR1RgrXnWNGS
         01Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUvDlXcvVM3pBCJedqlTvzEHOUyNQALFffCc94ezkeY03T22VYzxvKq4PDmgZwD3Hx3N45va06a42vw9BoTTQS6frZxUhjrybc3zg2EeA==
X-Gm-Message-State: AOJu0YybGM0dtCKaWYpBY8XTdxxL0tW2pdoMOkah4V62Vhw4YaOoOwwc
	t7V+hlJqXEPU1stGCiRWpeV2JKhBf52e3Avqqpf5AV7eEG4ZeeIxZwxEP79D3US1fUkM0RW9QaZ
	J+1EglkJu6VRcwLhnRgj1oGATJjZexcDBD56nZ2kL4RqkRC9eD0DGDbpXJ73wITa2dvFrow==
X-Received: by 2002:aa7:d7c9:0:b0:560:58f:7148 with SMTP id e9-20020aa7d7c9000000b00560058f7148mr5859419eds.34.1707757203653;
        Mon, 12 Feb 2024 09:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5d7NhSXUd+Ka9mWVzMAjZ/5gYk1koRVf36bry7me67qozD1nqge7/dD2Vllab+yEamrtJ+g==
X-Received: by 2002:aa7:d7c9:0:b0:560:58f:7148 with SMTP id e9-20020aa7d7c9000000b00560058f7148mr5859407eds.34.1707757203481;
        Mon, 12 Feb 2024 09:00:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXv5yKVk4z2uZA0lhzKt7e5aAhzh2djpqVE42qk88sc1IcDfr7k1epqpOlxq9cCgGoiM3JkoS98ubqWE2iYwMMgVUDxjUqgmNwh7i/1FsrE94bZKrSmgASPboLl4u/cpkAlt0hBmWNoBgoyVk1UvAyqI6x3m9JJ7z73My/znP7Wo/ElrYulT1ky1ZcFmXukQBQRECf2gvpqKOfOYQAJ7Gz7L6peUHGquvy5
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:01 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 11/25] xfs: add XBF_VERITY_SEEN xfs_buf flag
Date: Mon, 12 Feb 2024 17:58:08 +0100
Message-Id: <20240212165821.1901300-12-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of essential ideas of fs-verity is that pages which are already
verified won't need to be re-verified if they still in page cache.

XFS will store Merkle tree blocks in extended file attributes. When
read extended attribute data is put into xfs_buf.

fs-verity uses PG_checked flag to track status of the blocks in the
page. This flag can has two meanings - page was re-instantiated and
the only block in the page is verified.

However, in XFS, the data in the buffer is not aligned with xfs_buf
pages and we don't have a reference to these pages. Moreover, these
pages are released when value is copied out in xfs_attr code. In
other words, we can not directly mark underlying xfs_buf's pages as
verified as it's done by fs-verity for other filesystems.

One way to track that these pages were processed by fs-verity is to
mark buffer as verified instead. If buffer is evicted the incore
XBF_VERITY_SEEN flag is lost. When the xattr is read again
xfs_attr_get() returns new buffer without the flag. The xfs_buf's
flag is then used to tell fs-verity this buffer was cached or not.

The second state indicated by PG_checked is if the only block in the
PAGE is verified. This is not the case for XFS as there could be
multiple blocks in single buffer (page size 64k block size 4k). This
is handled by fs-verity bitmap. fs-verity is always uses bitmap for
XFS despite of Merkle tree block size.

The meaning of the flag is that value of the extended attribute in
the buffer is processed by fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_buf.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index b470de08a46c..8f418f726592 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -24,14 +24,15 @@ struct xfs_buf;
 
 #define XFS_BUF_DADDR_NULL	((xfs_daddr_t) (-1LL))
 
-#define XBF_READ	 (1u << 0) /* buffer intended for reading from device */
-#define XBF_WRITE	 (1u << 1) /* buffer intended for writing to device */
-#define XBF_READ_AHEAD	 (1u << 2) /* asynchronous read-ahead */
-#define XBF_NO_IOACCT	 (1u << 3) /* bypass I/O accounting (non-LRU bufs) */
-#define XBF_ASYNC	 (1u << 4) /* initiator will not wait for completion */
-#define XBF_DONE	 (1u << 5) /* all pages in the buffer uptodate */
-#define XBF_STALE	 (1u << 6) /* buffer has been staled, do not find it */
-#define XBF_WRITE_FAIL	 (1u << 7) /* async writes have failed on this buffer */
+#define XBF_READ		(1u << 0) /* buffer intended for reading from device */
+#define XBF_WRITE		(1u << 1) /* buffer intended for writing to device */
+#define XBF_READ_AHEAD		(1u << 2) /* asynchronous read-ahead */
+#define XBF_NO_IOACCT		(1u << 3) /* bypass I/O accounting (non-LRU bufs) */
+#define XBF_ASYNC		(1u << 4) /* initiator will not wait for completion */
+#define XBF_DONE		(1u << 5) /* all pages in the buffer uptodate */
+#define XBF_STALE		(1u << 6) /* buffer has been staled, do not find it */
+#define XBF_WRITE_FAIL		(1u << 7) /* async writes have failed on this buffer */
+#define XBF_VERITY_SEEN		(1u << 8) /* buffer was processed by fs-verity */
 
 /* buffer type flags for write callbacks */
 #define _XBF_INODES	 (1u << 16)/* inode buffer */
@@ -65,6 +66,7 @@ typedef unsigned int xfs_buf_flags_t;
 	{ XBF_DONE,		"DONE" }, \
 	{ XBF_STALE,		"STALE" }, \
 	{ XBF_WRITE_FAIL,	"WRITE_FAIL" }, \
+	{ XBF_VERITY_SEEN,	"VERITY_SEEN" }, \
 	{ _XBF_INODES,		"INODES" }, \
 	{ _XBF_DQUOTS,		"DQUOTS" }, \
 	{ _XBF_LOGRECOVERY,	"LOG_RECOVERY" }, \
-- 
2.42.0


