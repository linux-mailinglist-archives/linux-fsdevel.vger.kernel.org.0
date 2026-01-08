Return-Path: <linux-fsdevel+bounces-72887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 992B6D04F24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 324CE307B610
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06B2E8E16;
	Thu,  8 Jan 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr7TVxvj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E7B2E5B1B;
	Thu,  8 Jan 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892446; cv=none; b=lar2y/huT29q8P4lvkpVwwQN6H8PehKtBw83f0rgiuiRB3hUBlCw7JaD/O9dToyINdR7xelZC35MLRsgNjMwr/CVlQd1TbInxA/4EK4Eq7KHmJ1m+dGxN3PYUd9jfRl2jRyEndBdO5HbhyEa1QdTkops5+5aj/pWSi4fsikmMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892446; c=relaxed/simple;
	bh=r6yK8bK+kkMgdLh1w8q65yIEqjkb/IjmfMvjzt63UDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mYcOkpCQEasqQ0ZxzuqX0gzifRwPXl+KPOb9Wm0a/WWRZlaPqMEnyGeND3qCVove/fveDHyn/ftRtx/IgDY/lGaCDGeu37Tic6443Qvo9R0/gYf92UMJKWTuDKic4ma+ZW5Im4WxtAIll7jQ8lOz3nOdbh9jte3XGOaMLnOzccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr7TVxvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8029C116D0;
	Thu,  8 Jan 2026 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892445;
	bh=r6yK8bK+kkMgdLh1w8q65yIEqjkb/IjmfMvjzt63UDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qr7TVxvjzjLDifiDNwgbz5Utlv1xXYOFRFXz45doMG8Cdh5Klxpemaa34l6LJokhA
	 LFa84+w6J2qISvcYOsLfUBUSL9MwYOCY+AMEM0SAde8YfqlKywdQkHZSg+Ogf9pjzQ
	 aFpq+UOCKzyyuR2vxCOphzBHlhmhgOw3MDspuwMRqEYAJz9tNnga4+EJpK1D2ociJW
	 SANMkPyTno9YLvlxnw/Lsx6RGruAjUhICO986WMabplDp+6TiuUuX2xPPwNcBFGQfF
	 69HtUgtVBqbMsF7uMl1/aNC1vnXN6NRGfWYioeAlTU2AE6rPRYyHHQqJes8E1lstCt
	 KWb4D2+xXXgCQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:12:58 -0500
Subject: [PATCH 03/24] btrfs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-3-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=r6yK8bK+kkMgdLh1w8q65yIEqjkb/IjmfMvjzt63UDI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W59KQJzkynnqRywsxn8vf6E7WkYLaalZHcn
 hqXE1iesQmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luQAKCRAADmhBGVaC
 FaJdD/4l9fv7mklHKjKkjTHpTVCuJPpIKuHhUtEoAqSprUNpwgQfDYLR6f54jMEQA9jS1LBj+Dy
 QyeVCVp55DoP+wWIXayOwD+klKX2cjtKHEwQH5WNOE+citJTM6zNMzIBsDuWMPletL+BrqbrBxR
 HQDrOyGoBCNw3T1Y3bJodEqe17RMpbrM5KQW+uFl//FLm8KIwd3cLbRjHZuex9cILVJooiBg9l7
 hUE52fcXEYxfjxHGR+zyVf6kogJj4y74vQx4i8b8B2Ji0IdoaBOVwiZpxIuDdQRGx00T4PkN5pE
 bI0JaolvkVkIP58mQT0gLpRrctVhJ7Fm0DRISz+BmhTcfaaeTwcgO2m35EL5Df2ExhjnuyRvPIR
 79MM+Z+RIyV4mUCgXq2Ew49Qxpsd50AoG1moCPbZ/o5bQwqkL1OW1HDV8svhp7gU1n4Pmsf5he6
 U8/NR75X8fqtFciebf0UxTzmneWSw0zcIw2QKAsBUmQukDXYH/gJYnWSF9UAj/JrIC3fNunArUq
 llAH6702SuQcGU6kAt4IxAZNCFIjdu1g5UiVgOaxJcCh3emmvOFhVMzCWpAuGiOFbdbwEed/7pH
 iNMhOMoloJOXkThvtx3egvJavKsX+vhYLTgSnhPuQ83dhuILLuHFQaySEbcaXOac64sdVpwJc3b
 Yr+dTsCBfX540XQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to btrfs_file_operations and
btrfs_dir_file_operations, pointing to generic_setlease.  A future
patch will change the default behavior to reject lease attempts with
-EINVAL when there is no setlease file operation defined. Add
generic_setlease to retain the ability to set leases on this
filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/btrfs/file.c  | 2 ++
 fs/btrfs/inode.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 1abc7ed2990e0e956dc0550cba8b0cfc90109e65..aca2b541e72df3638bdc6cd7551a018ae959039b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/filelock.h>
 #include <linux/writeback.h>
 #include <linux/compat.h>
 #include <linux/slab.h>
@@ -3867,6 +3868,7 @@ const struct file_operations btrfs_file_operations = {
 	.remap_file_range = btrfs_remap_file_range,
 	.uring_cmd	= btrfs_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
+	.setlease	= generic_setlease,
 };
 
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 599c03a1c5737ee4129c0bc1743b345847fa5dfc..5d1bdc862ed2711e349af085512f3bda6cb63278 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8,6 +8,7 @@
 #include <linux/bio.h>
 #include <linux/blk-cgroup.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/fs.h>
 #include <linux/fs_struct.h>
 #include <linux/pagemap.h>
@@ -10573,6 +10574,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 #endif
 	.release        = btrfs_release_file,
 	.fsync		= btrfs_sync_file,
+	.setlease	= generic_setlease,
 };
 
 /*

-- 
2.52.0


