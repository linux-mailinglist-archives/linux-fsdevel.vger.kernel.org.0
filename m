Return-Path: <linux-fsdevel+bounces-18568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C82308BA5F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 06:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88971C21FF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 04:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B11F2E645;
	Fri,  3 May 2024 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HBfvNp2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395D22083
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709864; cv=none; b=WH4C+vANM6b9l3ypL92r3KQEwxjEfQFxHb5J13zXx+ORTvTzp2iSHYmp8MRXYYZri6Vx1PI06IpbzmbjMwlN3O2l0uOhMVsJmgwhNnqWdyfa7bJI+mVpre1MT2eIXoGi/xxjupLkryTczIHs8VuGDzbJ8msZ4K6nR8oshZEiGGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709864; c=relaxed/simple;
	bh=8ebE4XUh6TIL3U3rsVcYwl6FXdU+e0pvqo+4boUMA0U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnIU2LyBoyke1XA9+Cc/dd4kdW0Q0QhShtMhXDBUeNdrILbLTInv5fpBFZLML2oeZPIm2dXfZpeU+KmTt+ls4dSimrARclkeEZfGSgYhM8D+cHzHBkwvs5OrSBEivSnO7I4Zu9s035YXlQHq1F97D5+ytQ0RkOJLkTmaRNJ/rHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HBfvNp2c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=Ve7iu3CXoCO+LauZkbPs8hbuR/S5IyZ4gzxOBBwRvaY=; b=HBfvNp2cUhncOpy3Cv0hawH6H2
	jNjSz5vUCJRSQpK54Be+clJNJy+4kLPxzcJNJzBhM+ZFHuDnZbKvo0rCQxheYKajheyK6YZ7wrQGi
	r2eZk8VYM4RAcGVeH+/7eHmu//GSAM3KTtVYFSK4/xEoFuTWHeC9vljHCt4DUW8NM1K0+oEsPwnJ6
	OtDWFD98peNzReEaCQEMFR6l938mMNuNqSrOZnPJ/YFPAQIxnPonyvZAfEaDVVQQgCHrsrRBYtoAK
	uX9JdvHF+P6AtC/YFchb8Uq2nDuLWupnCcjDDlLUyc8WPGfHECu4To83qJy6LQp5YhPBzHh/3F+Cy
	78Bh7VDw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2kMf-00A5VU-1t
	for linux-fsdevel@vger.kernel.org;
	Fri, 03 May 2024 04:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/9] btrfs_get_bdev_and_sb(): call set_blocksize() only for exclusive opens
Date: Fri,  3 May 2024 05:17:38 +0100
Message-Id: <20240503041740.2404425-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503041740.2404425-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

btrfs_get_bdev_and_sb() has two callers - btrfs_open_one_device(),
which asks for open to be exclusive and btrfs_get_dev_args_from_path(),
which doesn't.  Currently it does set_blocksize() in all cases.

I'm rather dubious about the need to do set_blocksize() anywhere in btrfs,
to be honest - there's some access to page cache of underlying block
devices in there, but it's nowhere near the hot paths, AFAICT.

In any case, btrfs_get_dev_args_from_path() only needs to read
the on-disk superblock and copy several fields out of it; all
callers are only interested in devices that are already opened
and brought into per-filesystem set, so setting the block size
is redundant for those and actively harmful if we are given
a pathname of unrelated device.

So we only need btrfs_get_bdev_and_sb() to call set_blocksize()
when it's asked to open exclusive.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/volumes.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f15591f3e54f..43af5a9fb547 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -482,10 +482,12 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 
 	if (flush)
 		sync_blockdev(bdev);
-	ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
-	if (ret) {
-		fput(*bdev_file);
-		goto error;
+	if (holder) {
+		ret = set_blocksize(bdev, BTRFS_BDEV_BLOCKSIZE);
+		if (ret) {
+			fput(*bdev_file);
+			goto error;
+		}
 	}
 	invalidate_bdev(bdev);
 	*disk_super = btrfs_read_dev_super(bdev);
@@ -498,6 +500,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	return 0;
 
 error:
+	*disk_super = NULL;
 	*bdev_file = NULL;
 	return ret;
 }
-- 
2.39.2


