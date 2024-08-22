Return-Path: <linux-fsdevel+bounces-26596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1595A904
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 02:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02C21F248AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 00:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C75879FD;
	Thu, 22 Aug 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jKGTLBdw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB66FB6;
	Thu, 22 Aug 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287267; cv=none; b=DlUmMnaod4pmcwU4aXXa6hqTgBNTOaIkxyKpjgzuM6u338PiX9zChEuzAacK9K8VB1wZFh45GBaRZBOosnOEyHkG/zA0rDD0m/DaKvkzlCt3haIH2iiEKjTRXaP6cqrn9no41RmUCmMC/xyV+YHWSc6Ax3ggIAhgKQPNZgXpZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287267; c=relaxed/simple;
	bh=jeP+XLfDddClKwlEdsbMg7Bm6b5gsxyaxuLCFEJxoaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpSKjQ+X1NlQz2KMqiCkuWD6xnlUfAWohJiRKu3TCXcbfPH2WnyUsfEyBIjlsCPYIg/W1cxUChOwLXj1+nEzs9usvULjs4z0o2W+DrGe/SAkGDaZtsJXCGGZe+3XU2WxVzTOlqLDk/iux58Xs2g0N0tb88rH5IYtiadOHAGoONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jKGTLBdw; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0acCXEga1tQ2jZR5fgXnw/FdPHpNodKENtiisHdpxw4=; b=jKGTLBdwj3fFgLZkRC60luLhi1
	4mG1GykwToQy3IZWydYIP2FcoCvnzp5pECwqKgQP+4SzrYo5VzWg9VsKwJ0HMgXlVQ1HAI5pT8H7b
	Hs4wui+i0UG6vPYP0RD84wivQITSHBswvrBCdvBboAg/Np7CpNeiAmcAVyw0Gi7oMumD6hbKRRW0n
	oXceYt/XFgCN/AkDonBLo4Kkbo4rlltdDaCEy3ZCU5UYIgwesFAZTXWxVc+cYTAlXD+Fvn8ByO7qD
	eAexgTXmMeJD4Fm3taq66TKe1QLp+ONJ+NqSx4ACn0kmuMmKctmFSlq/Kp01pyqTzHvD4MklplUVO
	kY1KEGdw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sgvsr-00000003wQe-2eP6;
	Thu, 22 Aug 2024 00:41:01 +0000
Date: Thu, 22 Aug 2024 01:41:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] lift grabbing path into caller of do_dentry_open()
Message-ID: <20240822004101.GQ504335@ZenIV>
References: <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822003359.GO504335@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

... and do that after the call.  Legitimate, since no ->open()
instance tries to modify ->f_path.  Never had been promised to
work, never had been done by any such instance, now it's clearly
forbidden.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst |  9 +++++++++
 fs/open.c                             | 10 +++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 92bffcc6747a..34f83613ad6f 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1141,3 +1141,12 @@ pointer are gone.
 
 set_blocksize() takes opened struct file instead of struct block_device now
 and it *must* be opened exclusive.
+
+
+---
+
+**mandatory**
+
+do not even think of modifying ->f_path in ->open() instance; it never had
+been expected to work and nobody had been insane enough to try it.  Now
+it is explicitly forbidden.
diff --git a/fs/open.c b/fs/open.c
index 2bda3aadfa24..0ec2e9a33856 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -912,7 +912,6 @@ static int do_dentry_open(struct file *f,
 	struct inode *inode = f->f_path.dentry->d_inode;
 	int error;
 
-	path_get(&f->f_path);
 	f->f_inode = inode;
 	f->f_mapping = inode->i_mapping;
 	f->f_wb_err = filemap_sample_wb_err(f->f_mapping);
@@ -1015,7 +1014,6 @@ static int do_dentry_open(struct file *f,
 	fops_put(f->f_op);
 	put_file_access(f);
 cleanup_file:
-	path_put(&f->f_path);
 	f->f_path.mnt = NULL;
 	f->f_path.dentry = NULL;
 	f->f_inode = NULL;
@@ -1042,10 +1040,14 @@ static int do_dentry_open(struct file *f,
 int finish_open(struct file *file, struct dentry *dentry,
 		int (*open)(struct inode *, struct file *))
 {
+	int err;
 	BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's opened */
 
 	file->f_path.dentry = dentry;
-	return do_dentry_open(file, open);
+	err = do_dentry_open(file, open);
+	if (file->f_mode & FMODE_OPENED)
+		path_get(&file->f_path);
+	return err;
 }
 EXPORT_SYMBOL(finish_open);
 
@@ -1095,6 +1097,8 @@ int vfs_open(const struct path *path, struct file *file)
 		 */
 		fsnotify_open(file);
 	}
+	if (file->f_mode & FMODE_OPENED)
+		path_get(&file->f_path);
 	return ret;
 }
 
-- 
2.39.2


