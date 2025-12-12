Return-Path: <linux-fsdevel+bounces-71204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15ACB9857
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E3DA30168CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EF2F6936;
	Fri, 12 Dec 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g64myGf3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E782F656F;
	Fri, 12 Dec 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563196; cv=none; b=LgsTVgfZZnThEabGq386k7d34qJQiLINJBqlxUPYNeVZVtdKESaaCIVsD9ohH9818GWBirsPHHTpEZY64vOwREdgGB7UTb0OAuWokEwQouhKisdh9wR9il40PFCCmkiZiS7oF20dM+hCDeW4/1zTlFsZ0s4JryOUFp8mSXmopd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563196; c=relaxed/simple;
	bh=ynhgHfak6jkPwGyW5W89VK1SLurq4Dbqfs8lTbnxLQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzsJy7/mzq32bsGQIVZpA1cfUX1OT+bUfd1cdxjDbS4oyc3C2qrw05ByacctmCBkQwD8XDN+4llsGoLsQIjjoeQlUa0UQIUT+/NEXmoJ6PzO6SFSb6Le1LTB3k4qKDG/k207GJGqFYXCcXPG9tZe3+t2Z3kCLQd9YCiQHKSE6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g64myGf3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vZrtZ0rYdYw9DSaqbNih5R5OgH1BU6sM72ak1569OCE=; b=g64myGf32DokboUe7Eu1J06T0v
	/Ae5lYdID8nvPHtckqIvhpGvQdHSRBM93ncL0lfq+6mFFDpP8RvoIAA/X3y/3milgpi+ng8Rbk4LH
	KemJfmpaotF8KWcoXBMQ5DGaSIpYS/iEHiTjkTncNRYwslj4cZR1Jx7O5lcv1k9Q8rHs9wdkH0wpP
	+ubwKzdN1Vbl+URh/UF2uK98w9R5SdBBopDmkFxpeVqQAvDDDb/FJwaRu0DQkBYG8nW/CT42NH2mR
	JaCK59g/PF98lu8CptfQlNNhptrCNQY9O795DCB15+wVxfMHMyB1SDtzROcAJrN4P+2gnEWYvzWos
	b7h0bS7g==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vU7dS-00C79C-A7; Fri, 12 Dec 2025 19:12:58 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bernd Schubert <bschubert@ddn.com>,
	Kevin Chen <kchen@ddn.com>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v2 3/6] fuse: initial infrastructure for FUSE_LOOKUP_HANDLE support
Date: Fri, 12 Dec 2025 18:12:51 +0000
Message-ID: <20251212181254.59365-4-luis@igalia.com>
In-Reply-To: <20251212181254.59365-1-luis@igalia.com>
References: <20251212181254.59365-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the initial infrastructure to implement the LOOKUP_HANDLE
operation.  It simply defines the new operation and the extra fuse_init_out
field to set the maximum handle size.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/fuse_i.h          | 4 ++++
 fs/fuse/inode.c           | 9 ++++++++-
 include/uapi/linux/fuse.h | 8 +++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1792ee6f5da6..fad05fae7e54 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -909,6 +909,10 @@ struct fuse_conn {
 	/* Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
+	/** Is LOOKUP_HANDLE implemented by fs? */
+	unsigned int lookup_handle:1;
+	unsigned int max_handle_sz;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ef63300c634f..bc84e7ed1e3d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1465,6 +1465,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if ((flags & FUSE_HAS_LOOKUP_HANDLE) &&
+			    (arg->max_handle_sz > 0) &&
+			    (arg->max_handle_sz <= FUSE_MAX_HANDLE_SZ)) {
+				fc->lookup_handle = 1;
+				fc->max_handle_sz = arg->max_handle_sz;
+			}
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1515,7 +1522,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
 		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_REQUEST_TIMEOUT | FUSE_LOOKUP_HANDLE;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..4acf71b407c9 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -495,6 +495,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_HAS_LOOKUP_HANDLE	(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
@@ -663,6 +664,7 @@ enum fuse_opcode {
 	FUSE_TMPFILE		= 51,
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
+	FUSE_LOOKUP_HANDLE	= 54,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -908,6 +910,9 @@ struct fuse_init_in {
 	uint32_t	unused[11];
 };
 
+/* Same value as MAX_HANDLE_SZ */
+#define FUSE_MAX_HANDLE_SZ 128
+
 #define FUSE_COMPAT_INIT_OUT_SIZE 8
 #define FUSE_COMPAT_22_INIT_OUT_SIZE 24
 
@@ -925,7 +930,8 @@ struct fuse_init_out {
 	uint32_t	flags2;
 	uint32_t	max_stack_depth;
 	uint16_t	request_timeout;
-	uint16_t	unused[11];
+	uint16_t	max_handle_sz;
+	uint16_t	unused[10];
 };
 
 #define CUSE_INIT_INFO_MAX 4096

