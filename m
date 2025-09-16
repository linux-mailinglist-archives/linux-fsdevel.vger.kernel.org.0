Return-Path: <linux-fsdevel+bounces-61514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60933B58980
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CA03AEA0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F04C1A0711;
	Tue, 16 Sep 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YToOzfPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36FA1D63CD;
	Tue, 16 Sep 2025 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982589; cv=none; b=edm5y2nryBKkU95j1HBmfsSxSGCpwS5skvIVvoCK8aUS2JaWCCatMQM08aJY6jPx6mZYop652Ujc8YniVgxJKBLZJwrwj50K/3L7o8mN+RRG0+QrE/Zo6+n9tdnFwfCoHE79Pec0jfxXLbVuLNX76A7a/+330t/pILw/gdr1oQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982589; c=relaxed/simple;
	bh=0zTk8Hu4PC6toKsAoFi+v4/Cnt/YcL2OGEzQtsGu9oU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3127p9c/h07nl/4mggyUQgOQRcRX8f/Hpj4HFulIwF3Z05ystBdtleLfQXHHYJC02SumcLIMbHMldMuNdEk8dZCvTSThaRqAam/MX8d/3R8E5Fmm5IVnMttt7ckEIFE/RKJSCWceAKaFoGZeMtXKxNnEANtQ2m8eJ3hGNMr8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YToOzfPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5686DC4CEF1;
	Tue, 16 Sep 2025 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982588;
	bh=0zTk8Hu4PC6toKsAoFi+v4/Cnt/YcL2OGEzQtsGu9oU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YToOzfPNpu1Myyfxj4JXSxb1P8tFo9K4cI7hLqToFHsZNKySXoNa9LVLmi84VsOro
	 jNLqcPwZRmREf3sxgr+lEEh8bhBz4adrUSYuc0waOvhLUiHlBh67CiK0LIRTVSkM8z
	 HWOloAJh17H5moJOcm9hAD2bcG51tmB9gRB027tGc10serTN1uNnOjdRvqCzoF+zXr
	 axjTQKFBGwqsIIjQ7m+H3xrlQvhG6g9JLVwbiLhS6XBSMe5l/CpdlirbJAJTYL7hWd
	 ZPjGumhDUuUCW++ThfQBQJbPcD7opE0gStXKyDcypOIP393ycUt8MS5qc9RNeCofIH
	 dXNgDcr9tVp1Q==
Date: Mon, 15 Sep 2025 17:29:47 -0700
Subject: [PATCH 07/28] fuse: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151416.382724.9368434710895586667.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a per-inode flag to control whether or not this inode actually
uses iomap.  This is required for non-regular files because iomap
doesn't apply there; and enables fuse filesystems to provide some
non-iomap files if desired.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   15 +++++++++++++++
 include/uapi/linux/fuse.h |    3 +++
 fs/fuse/file.c            |    1 +
 fs/fuse/file_iomap.c      |   32 ++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    2 ++
 5 files changed, 53 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3cda9bc6af23fe..791e868e568cc5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -250,6 +250,8 @@ enum {
 	FUSE_I_BTIME,
 	/* Wants or already has page cache IO */
 	FUSE_I_CACHE_IO_MODE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -1715,11 +1717,24 @@ extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_inode_has_iomap(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode_c(inode);
+
+	return test_bit(FUSE_I_IOMAP, &fi->state);
+}
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_init_inode(...)		((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 3a367f387795ff..cc4bca2941cb79 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -238,6 +238,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -578,9 +579,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP		(1 << 2)
 
 /**
  * Open flags
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ebdca39b2261d7..8982e0b9661bb1 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3127,4 +3127,5 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
+	fuse_iomap_init_inode(inode, flags);
 }
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 75e6f668baa9ef..6ffa5710a92ad5 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -633,3 +633,35 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_flush_requests_and_wait(fc);
 	fuse_send_destroy(fm);
 }
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(fuse_has_iomap(inode));
+
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_inode(struct inode *inode, unsigned attr_flags)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+
+	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
+		fuse_inode_set_iomap(inode);
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	if (fuse_inode_has_iomap(inode))
+		fuse_inode_clear_iomap(inode);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7cb1426ca3e767..b209db07e60e33 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -199,6 +199,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_iomap_evict_inode(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)


