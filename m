Return-Path: <linux-fsdevel+bounces-69220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3AC73964
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52F033598DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A946832D0D9;
	Thu, 20 Nov 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UwKYV+87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00251314B96;
	Thu, 20 Nov 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636160; cv=none; b=XgYUCn5vZaR74AOkf5wC04V4RaduO5MgHjnp1XUNEjhIaLqelCKc4nElWbFGHgKP2lnsRWGTleToH52X9NSjwjaSvOgyaNzPIN30c5VSFaV+4vuiZwgwy7Dxzk9yJMeFp26M9OLouoTVD3vzDIpkohpn7enlHS4A/7ZJGekkiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636160; c=relaxed/simple;
	bh=mHE9ACXaJXEb5ZT2zCIjTT3JDtkwqQurNM8sSTyuVos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfoaZMY1Zql49QQxQkhr04Eb5KgeitT4sDy3BFdVJ3M2q6qo1AgHgrDpF3MIqowv6MOVERZP2PiQfrNBBz6xVQhVHE+kYPcg7QgOZi5xOL/1WX22CZCrjTha9EBf8eeFVXS1AoOgurVC/tb8XktxRn8/mXoKMEhrUw5nHl6qHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UwKYV+87; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8A1jHotXqbmJPnzV6LLfiYW6BWj2RdG0wHHL2RIxwZE=; b=UwKYV+87Agbsu3m6SLQh80cCuW
	v39IYAGoRayZouUvRiD2XPbSLvZkAN1FIkJ6nqB6Ic7IB2ef/A7z8suapveuIdPLff+NHjawVSJlm
	vvXrRkKCM92ht5e/ow9NBqkCORCo4eiW3JH+tMASBXgThQwSibFPFw6pZ16v+Z07Upawy/j2gXbnN
	3+W6vGB97ndeun4ULs9SKLA9LflsT0WjDq6EyYHNyiqUS0j6x5wvThvKGYvrgw6FCbh6XgUI7n/dI
	6BJ/YK1+e0KdgjDfzGmHTwjURFAbtOQ9vmaybuXuCEzI36paevhYU0qPioCy94m/nwq70wosfPpdn
	LoCNOeGQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vM2KE-003CK9-OC; Thu, 20 Nov 2025 11:55:42 +0100
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
Subject: [RFC PATCH v1 1/3] fuse: initial infrastructure for FUSE_LOOKUP_HANDLE support
Date: Thu, 20 Nov 2025 10:55:33 +0000
Message-ID: <20251120105535.13374-2-luis@igalia.com>
In-Reply-To: <20251120105535.13374-1-luis@igalia.com>
References: <20251120105535.13374-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the initial infrastructure to implement the
FUSE_LOOKUP_HANDLE operation.  It simply defines the new operation and the
extra fuse_init_out field to set the maximum handle size.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/fuse_i.h          | 4 ++++
 fs/fuse/inode.c           | 9 ++++++++-
 include/uapi/linux/fuse.h | 8 +++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c2f2a48156d6..f4e9747ed8c7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -907,6 +907,10 @@ struct fuse_conn {
 	/* Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
+	/** Is LOOKUP_HANDLE implemented by fs? */
+	unsigned int lookup_handle:1;
+	unsigned int max_handle_sz;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d1babf56f254..b9b094c1bc36 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1453,6 +1453,13 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
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
@@ -1503,7 +1510,7 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
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

