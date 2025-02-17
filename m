Return-Path: <linux-fsdevel+bounces-41853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEA4A384C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 14:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A09188A836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75921D3D3;
	Mon, 17 Feb 2025 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ihiNGOHw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD521A44E;
	Mon, 17 Feb 2025 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799167; cv=none; b=C5ADZbW0dNgfc6laUaVVCsiIoTN4gAzCB2ukxW+e7V3r+NGqaEHAsklwt7p949o3SgPPduZ1H/GSaCrkh0mmQqOiR9c850y7gDZlLlrzHf75KBt6bwX07G9FhwDNNyY4kzX2WI9BMuFlSferqDgLmo79NW/H4wQMzr+exibu8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799167; c=relaxed/simple;
	bh=VMsooz26XNfD4Gvyre+Xt1s+VZTiD2Rh3+Ym9Cu9Tt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE1vl1XQT6CJ8wWPlUZDjKHzFYhfGiOthlkH+5fpQXpRCkcX9KJ04PT9mOqlBkCKnqkiKoHxHi+LPj+dZ9jK1cZHYC6q6cwnqHKQar8SzcrBgqc4N01S4Df8EGmFvplsUR7bviSCuZO0bEFm0Nf9pHbxtsdxsCc+rMiMYeZyx/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ihiNGOHw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oFqlCRGxVvYgM3TqGIEG9NV9rrMbKs5vCfNY62alBbE=; b=ihiNGOHwnZY+SpUnKollP2VNZv
	f/+KvgdbZw1BQVrQJW8dfmZ3fvSaqUoJ6LPGf6iBpeG/TE+GtXPvwSlsfvpZD03xnTaxAgcoajv96
	gnvgc6o59YQzXEDL8+pc3o+1Gs9+G6ruszD5qhXNnAh6bbGpx07YGyB1kVT2lOXZpWqPLWNEq7qZ8
	vp1ZvaQ/PSmPdkBYlIEKKRuxUOhuRVfJyHj6LBbmhkYO1nnLdV3rLgQXuSD1Oa8f6s0hRy00n9H1x
	0qmal9OR1hOwxyF4fkV3w2xLeGMkkWr9W+Gr92iHvdJ/AHUpg+XBT9KRoDJvBpdr7hjZK4AqcAC/I
	TPIfBRzA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tk1EW-006AKC-AA; Mon, 17 Feb 2025 14:32:30 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
Date: Mon, 17 Feb 2025 13:32:28 +0000
Message-ID: <20250217133228.24405-3-luis@igalia.com>
In-Reply-To: <20250217133228.24405-1-luis@igalia.com>
References: <20250217133228.24405-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently userspace is able to notify the kernel to invalidate the cache
for an inode.  This means that, if all the inodes in a filesystem need to
be invalidated, then userspace needs to iterate through all of them and do
this kernel notification separately.

This patch adds a new option that allows userspace to invalidate all the
inodes with a single notification operation.  In addition to invalidate
all the inodes, it also shrinks the sb dcache.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/inode.c           | 34 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..64fa0806e97d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -547,6 +547,37 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 	return NULL;
 }
 
+static int fuse_reverse_inval_all(struct fuse_conn *fc)
+{
+	struct fuse_mount *fm;
+	struct inode *inode;
+
+	inode = fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
+	if (!inode || !fm)
+		return -ENOENT;
+	iput(inode);
+
+	/* Remove all possible active references to cached inodes */
+	shrink_dcache_sb(fm->sb);
+
+	/* Remove all unreferenced inodes from cache */
+	invalidate_inodes(fm->sb);
+
+	return 0;
+}
+
+/*
+ * Notify to invalidate inodes cache.  It can be called with @nodeid set to
+ * either:
+ *
+ * - An inode number - Any pending writebacks within the rage [@offset @len]
+ *   will be triggered and the inode will be validated.  To invalidate the whole
+ *   cache @offset has to be set to '0' and @len needs to be <= '0'; if @offset
+ *   is negative, only the inode attributes are invalidated.
+ *
+ * - FUSE_INVAL_ALL_INODES - All the inodes in the superblock are invalidated
+ *   and the whole dcache is shrinked.
+ */
 int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 			     loff_t offset, loff_t len)
 {
@@ -555,6 +586,9 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
 	pgoff_t pg_start;
 	pgoff_t pg_end;
 
+	if (nodeid == FUSE_INVAL_ALL_INODES)
+		return fuse_reverse_inval_all(fc);
+
 	inode = fuse_ilookup(fc, nodeid, NULL);
 	if (!inode)
 		return -ENOENT;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..e5852b63f99f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -669,6 +669,9 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_CODE_MAX,
 };
 
+/* The nodeid to request to invalidate all inodes */
+#define FUSE_INVAL_ALL_INODES 0
+
 /* The read buffer is required to be at least 8k, but may be much larger */
 #define FUSE_MIN_READ_BUFFER 8192
 

