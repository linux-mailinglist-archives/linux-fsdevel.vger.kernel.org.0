Return-Path: <linux-fsdevel+bounces-46954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B85A96E1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349AC16B8CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BEC2857E4;
	Tue, 22 Apr 2025 14:15:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AE2857D8;
	Tue, 22 Apr 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331315; cv=none; b=ba0TW63LmTTC3pn6dA7oJGXSmqzVaYebBtaiYKdUKYEnCP2o4T0L43ek3MQx9ipaIwFvqoVVTTX8rmCTLhlRTTV3BZNVBWRZsBefHwcldTjeZdGKZ5vCJ7lJGv0OBKBu/6rV0PsPESy8AhYOSLqGbonRv6drxgDACEsWP6RY4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331315; c=relaxed/simple;
	bh=zlzyIV4mQM+zlKA4To9wK7eL4/X4xwlhgB5ljo/agLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XswfdTThgLGEg10X9npC00uyLuH1LoGsxPiFfopK23qUF5eOfZIn/YDnVCgUWdIXxfEqgIiwsG6Ca/JpMw3m0DLjYONw9EZHL6pQNfE9GFg4p0FmuBCzLGUIbb2VtitXLwHsTXcOoLcQgF2BytFgdoWRk7hWUgBPo3re40eeyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AF3C668C4E; Tue, 22 Apr 2025 16:15:06 +0200 (CEST)
Date: Tue, 22 Apr 2025 16:15:05 +0200
From: hch <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"djwong@kernel.org" <djwong@kernel.org>,
	"ebiggers@google.com" <ebiggers@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Xiao Ni <xni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH] fs: move the bdex_statx call to vfs_getattr_nosec
Message-ID: <20250422141505.GA25426@lst.de>
References: <20250417064042.712140-1-hch@lst.de> <xrvvwm7irr6dldsbfka3c4qjzyc4zizf3duqaroubd2msrbjf5@aiexg44ofiq3> <20250422055149.GB29356@lst.de> <20250422-angepackt-reisen-bc24fbec2702@brauner> <20250422081736.GA674@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422081736.GA674@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Turns out this doesn't work.  We used to have the request_mask, but it
got removed in 25fbcd62d2e1 ("bdev: use bdev_io_min() for statx block
size") so that stat can expose the block device min I/O size in
st_blkdev, and as the blksize doesn't have it's own request_mask flag
is hard to special case.

So maybe the better question is why devtmpfs even calls into
vfs_getattr?  As far as I can tell handle_remove is only ever called on
the actual devtmpfs file system, so we don't need to go through the
VFS to query i_mode.  i.e. the patch should also fix the issue.  The
modify_change is probably not needed either, but for now I'm aiming
for the minimal fix.

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

