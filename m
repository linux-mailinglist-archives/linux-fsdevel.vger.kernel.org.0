Return-Path: <linux-fsdevel+bounces-72886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DCD05508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41DE6346F530
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49AA2FDC22;
	Thu,  8 Jan 2026 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2tNeCP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9339FCE;
	Thu,  8 Jan 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892438; cv=none; b=SEcIwSrejx1V37rmZAfywjjLu8oJRZVYrAKIav0noHZVPhrawMI7xnSNArPt1OExn/UR3RfJuqyXdL+qXrMKrZuJIYEoQwcXhu/pCnCWw8j7k4V7vMLXgO9BoGYn98XQf7TGIb0VNOrPYTXledPYRc3pxDOB6OdA+IwzBEnxbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892438; c=relaxed/simple;
	bh=Pwijv5Tuh+c+DiE+MHlFZRInxzA5YXBkChKqagFjptw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahWnf1h8q+8KQBsmNSIm/pLoBV2xai7qF52cdyMfATAe1dRw1YmRrgT/apqbS+py7Tx2lL4hEi0yDdbq9T5huo3XsCvy+9An7u3aly9vSrtnzh+qFl1nJ53naank2psSXM4B4jUk7uKkRip8uM7STItiLo12MtQWwfpQmjfyuog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2tNeCP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFF7C2BCB2;
	Thu,  8 Jan 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892437;
	bh=Pwijv5Tuh+c+DiE+MHlFZRInxzA5YXBkChKqagFjptw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M2tNeCP8JvCAJC9IUlu2e0zizZP6ZQBZzWNHPfmEbBZ0zetXBKM296NJhSU7YqSpn
	 LteILbCxA57A7S+IeYEMwiideMe3sfW/5gv7fDscFgTzPh5AYvo8Ujt78vUZkXiSAq
	 m50i91DWk2yAUn0Wttdfcm4F0FCACyOm4gftTSpYTz65kZKap5L1nyrcppapkoefLG
	 6fC+lCadiEiJ+EQxkokfsvynFT8eNPgBYsf4u+HfENvfgtRSO1SFmQrfASP2UE3kgZ
	 ZPn7g9odE8Y1aCsATQnyJnrCkGD+QdO7d41CD4Pf0PJGo4XJP2HaCvnDm6S43fg6rg
	 Tht7Vqc7FmdcQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:12:57 -0500
Subject: [PATCH 02/24] affs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-2-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Pwijv5Tuh+c+DiE+MHlFZRInxzA5YXBkChKqagFjptw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W5Y9ye+Dm/rtqwxFL2Hdd+tE3YmpGaoSkLN
 ZcMw6xn0rGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luQAKCRAADmhBGVaC
 FeCBEACsTpjyfgcjG/GsZ4xzpgWq74Juli0DXZ1WVIUf0ss6GvOpMkY+uxFacz45n1ArzsjFBYA
 qSoTluOJD41qHwdDKGAdhFEsGj26fA3v7FUhqoN+IA0XCM7Q5JilKfVic1Jb7GnApj7qMRdR6gU
 B5xmOIsaXas0JxxmsF6a74mqSRmXo3ohjUjkSGHB0dYxgwAhQl6frG8PJmO6BmdhMf6j+Qcvjf4
 +pWs8jy2sS+8Vn5ZYPzH46DiFJ6bNqoETmBwWpG9FTmQ8zzlV8lq+QBuQTPpg9JMmE87T3mY79A
 PB3woVowC2Voz820ZEbCuByTzSYq3zU+nMBlhGuaAtPjtqF2/6aP1yCzRxJ8VoiE4KO0gyHUkFs
 84qO4+ZPqv/lRUPEXn+z28VYVWtzy6SV9Bxwx1K4iIKZLcwHj03Tk5Ay3OwbUdHHvmJea70tKU/
 Pnd8p8r3Zh3wZ0Zm3SHFL7CyUryOZe3NayKJMBsSodI8c6BqEpcbGSM/IwmjtuuuSt9aFAENA/t
 LqZWDcQTC8onUUXMCy0ila0bxBHfF2VUouHTVvO47koLUMpxSRy/v4XjRZyRDFIyv21c3Ja9RFB
 SSA/Pejl2la0pHZH2Ld420/K4HhPpbvOeD+lB6GWqkw69u+rZ5I9HhHwUM2EGpaC9H305b1sO18
 jw5ReV+iUjgSjOQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to affs_file_operations and
affs_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/dir.c  | 2 ++
 fs/affs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/affs/dir.c b/fs/affs/dir.c
index bd40d5f0881042e7e6b15b09a76a1793169a1d50..fe18caaf4d6557c67f5c0542ad86a6fe4c512aaf 100644
--- a/fs/affs/dir.c
+++ b/fs/affs/dir.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/iversion.h>
+#include <linux/filelock.h>
 #include "affs.h"
 
 struct affs_dir_data {
@@ -55,6 +56,7 @@ const struct file_operations affs_dir_operations = {
 	.iterate_shared	= affs_readdir,
 	.fsync		= affs_file_fsync,
 	.release	= affs_dir_release,
+	.setlease	= generic_setlease,
 };
 
 /*
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 765c3443663e6f542dce2ad5d9e055e14b0574e3..6c9258359ddb9ba344976dd5a9a435f71f3fabc1 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -15,6 +15,7 @@
 
 #include <linux/uio.h>
 #include <linux/blkdev.h>
+#include <linux/filelock.h>
 #include <linux/mpage.h>
 #include "affs.h"
 
@@ -1008,6 +1009,7 @@ const struct file_operations affs_file_operations = {
 	.release	= affs_file_release,
 	.fsync		= affs_file_fsync,
 	.splice_read	= filemap_splice_read,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations affs_file_inode_operations = {

-- 
2.52.0


