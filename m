Return-Path: <linux-fsdevel+bounces-47029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F774A97DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EA57AA297
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B72265CAE;
	Wed, 23 Apr 2025 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdmSyIhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938E1FDD;
	Wed, 23 Apr 2025 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745384392; cv=none; b=LJgtz4dXkuz3VI7FAnxbcI/uDsrIsHWXpt226BlhiPld3dWCGTAbvhszxvZUlq7751B4m8EORlkCOYb81LAXi+WvrIiQnyy2VtQnrgdPJ88LX6Wc7At4ExiwFVQRJCReBoEYC5qz/58HHTqjpGk7EHWLRJEVqMeWWCxohqkxFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745384392; c=relaxed/simple;
	bh=ds41BEqIqYatZI1fMW/ECTKN+xA4yPzvIDtAXJpLEQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5nq5fYTGVWf/Vbr6ie08sagc9XxUxzUsV/T7iLq9HjjVgG7oFoBdl/JMwCvgoF0VFh8t29ghE79HAhfLX5O0esx9S6ZhcmXWjoreR8u+DTqsrelMOvVDp/28Xd4RCMPwJsFjsN/PLvzF5ENqe1gecaoVzBE7/IMMbFyYFPHdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdmSyIhN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=S6N01TOC5Iv6YGNQJlPO5UCkZ9t4v2DJaJMeccs0Ldo=; b=RdmSyIhNucAgHTJvdQyy1L/oaf
	UACsANSe2aJmVYAZBaQTEALupgOQIDKPMsiXE8lLFkflq1QHabXvbJgCiVN3r0mpbAg4b0zaEGMFv
	a73v27GHOge28JuNTtK2iHv3i/U7A4Qan223v+QNI5ImhnNqHEedYlA4vJNvqYdx7aalxqmKt8nzb
	TvXZ0EFILzs8EtIivhRNuAP3P72Z2RwNppZ2S2B6DTcBZUx9taQG+bNaZJK1vTsnn21TYFY1kburM
	e2PFdhW+EgW6fT6WH53TDAFU1bFAXF39QKB1fLW7K9l+qX9aBNS0r7+k8+mCWN8DsCRVTSNOfh6R9
	FBWUyhOQ==;
Received: from 2a02-8389-2341-5b80-c0c9-6b8d-e783-b2cd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c0c9:6b8d:e783:b2cd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7SD3-00000009DS4-2BFL;
	Wed, 23 Apr 2025 04:59:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	hca@linux.ibm.com,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Xiao Ni <xni@redhat.com>
Subject: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
Date: Wed, 23 Apr 2025 06:59:41 +0200
Message-ID: <20250423045941.1667425-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The recent move of the bdev_statx call to the low-level vfs_getattr_nosec
helper caused it being used by devtmpfs, which leads to deadlocks in
md teardown due to the block device lookup and put interfering with the
unusual lifetime rules in md.

But as handle_remove only works on inodes created and owned by devtmpfs
itself there is no need to use vfs_getattr_nosec vs simply reading the
mode from the inode directly.  Switch to that to avoid the bdev lookup
or any other unintentional side effect.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reported-by: Xiao Ni <xni@redhat.com>
Fixes: 777d0961ff95 ("fs: move the bdex_statx call to vfs_getattr_nosec")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Tested-by: Xiao Ni <xni@redhat.com>
---
 drivers/base/devtmpfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 6dd1a8860f1c..53fb0829eb7b 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -296,7 +296,7 @@ static int delete_path(const char *nodepath)
 	return err;
 }
 
-static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *stat)
+static int dev_mynode(struct device *dev, struct inode *inode)
 {
 	/* did we create it */
 	if (inode->i_private != &thread)
@@ -304,13 +304,13 @@ static int dev_mynode(struct device *dev, struct inode *inode, struct kstat *sta
 
 	/* does the dev_t match */
 	if (is_blockdev(dev)) {
-		if (!S_ISBLK(stat->mode))
+		if (!S_ISBLK(inode->i_mode))
 			return 0;
 	} else {
-		if (!S_ISCHR(stat->mode))
+		if (!S_ISCHR(inode->i_mode))
 			return 0;
 	}
-	if (stat->rdev != dev->devt)
+	if (inode->i_rdev != dev->devt)
 		return 0;
 
 	/* ours */
@@ -321,8 +321,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 {
 	struct path parent;
 	struct dentry *dentry;
-	struct kstat stat;
-	struct path p;
+	struct inode *inode;
 	int deleted = 0;
 	int err;
 
@@ -330,11 +329,8 @@ static int handle_remove(const char *nodename, struct device *dev)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	p.mnt = parent.mnt;
-	p.dentry = dentry;
-	err = vfs_getattr(&p, &stat, STATX_TYPE | STATX_MODE,
-			  AT_STATX_SYNC_AS_STAT);
-	if (!err && dev_mynode(dev, d_inode(dentry), &stat)) {
+	inode = d_inode(dentry);
+	if (dev_mynode(dev, inode)) {
 		struct iattr newattrs;
 		/*
 		 * before unlinking this node, reset permissions
@@ -342,7 +338,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 		 */
 		newattrs.ia_uid = GLOBAL_ROOT_UID;
 		newattrs.ia_gid = GLOBAL_ROOT_GID;
-		newattrs.ia_mode = stat.mode & ~0777;
+		newattrs.ia_mode = inode->i_mode & ~0777;
 		newattrs.ia_valid =
 			ATTR_UID|ATTR_GID|ATTR_MODE;
 		inode_lock(d_inode(dentry));
-- 
2.47.2


