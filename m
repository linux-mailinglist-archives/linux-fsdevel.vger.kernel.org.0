Return-Path: <linux-fsdevel+bounces-72889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F104ED05310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC866301066C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7562E6CD8;
	Thu,  8 Jan 2026 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSaPnWwg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F82EBBA2;
	Thu,  8 Jan 2026 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892460; cv=none; b=ZHy5K6uDEaIdrwLXytIqY3mjVM5dxakGOARhlX3VidK38Y4SPFEcX2OaoEJLTggIktgDLUIQC0my9OtHBJyNHnm2vMgZgM2zDuRMWl2YrXeiOG4gCXCTBch6N2YBIrkChKeJsWIhqodoHZ9uOyUxm5EBxZBqohgbVnonHrp44tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892460; c=relaxed/simple;
	bh=oF6oBWJVqDuAAjKOQDrehLsz3iDowLXPik5JXzWYc9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiRybsQbymB5kQwdiBQvU+fetSkK2Cmf/PIybh/CbLFO23Hslv9ngLq+z7wqxvCLKJ+SFxkN7pDTSB9YllauQSCCz+5UEF034VWkOyDFoq+r6MDlnwi4P9FlPG3pSKCX8YRJLxNQtD7nXurv0kD/9Srn11jdpBqYvY73atQ8coA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSaPnWwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C1FC116C6;
	Thu,  8 Jan 2026 17:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892460;
	bh=oF6oBWJVqDuAAjKOQDrehLsz3iDowLXPik5JXzWYc9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZSaPnWwgsRoKS590NDK2nAb5RgiDV815lEy8151AZJxlLARMNFc8t5dQmMkUz0JST
	 rhKyFwUz1dAGUm2NJr8lAPlp3DwDOHv/02nIAnvGd2M3IupL9oZhj0Grg9oVi4lN4w
	 g7D3z2STHURmDZ7NplBhcLcj2za4gZrXAivQc4lPJdJghdWPCkspzxfRd6035DGdLn
	 2CdUmU6nzbxgjhHov4TVJabLWt5UsKGi/wQpmKn+Y5aGNWkmIaPLTlfGqI9EjM04b5
	 SrCcVTmQGHH/I/azeRLaSBDgCI3GPNs34GWUzC/P/4BqmjEidn0sUaA6O/AFyqFh6q
	 wdrZtmGzHbQUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:00 -0500
Subject: [PATCH 05/24] ext2: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-5-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oF6oBWJVqDuAAjKOQDrehLsz3iDowLXPik5JXzWYc9k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W51+myyOp3T7N9nKeOj1w9UGryiKEWXK2c4
 uBs1ppIWy6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luQAKCRAADmhBGVaC
 FRkZD/9X9AfDEXdOTU0p1NyunRENOiWMn7NFym0pJGC1a/vMqoagJhOg8DJ6MWl0AR4frQh9bjS
 RRdYTAntz/vRZdUXQNmip65bTzlDHP+7il44wPVMcjDwHIsz/pUXTZ8ZNiOAV1M30DKxFJ9CT3u
 PdA9yreUBmEt/UK4x4lDQYF2NTE/9bbfJyB+jEe6nZoAWmq9g5u2qXSDCWUAoaJMshmpGRsAT9b
 iFxzTB72klqyvrmWMKxhZBRZ7rOm2zCChTQJjZ3/SIQPBG5ZVNNy45nlpsM5xHtfjk1j1n0c1rR
 nrs6DQmLE9iFxTz7Ls8SOyBXRP58fsWMaOjwWX3QAQjt9zdsJY/xkWuEg4E9VMD874HkO7HNI/G
 JO0oJrQplsRc/CdexbsnS88REfIKqU+aHZrP7FcdSMkiJkUllzUIg6KsHM1NeBhRaOKJu8BOVJl
 vP9oTLwaLmDSKUTSEmJuGeYeZGycAu7M3/Gjg5DMImjB8r7YXFJ+i6AwSZhrbin+pvpRRt5YdNG
 tS85T0sG8bfmsbqZA+Ehp5mxN15t+NE0o8yVF91nO8z++bAqPBiK11NiIq/J9xBYUp3zqQchc3c
 JtymSVf1sO2KPVdy+/ujVxsyUinNYAssa0lgopwLrTE1n2rzFWAEuElJ4wunlge9cvt2wpYCZNv
 NTn8dDHxmIim2RQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to ext2_file_operations and
ext2_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext2/dir.c  | 2 ++
 fs/ext2/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index b07b3b369710c4848d6091742cdd0b5c42d4674d..395fc36c089b7bb6360a8326727bd5606c7e2476 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -24,6 +24,7 @@
 
 #include "ext2.h"
 #include <linux/buffer_head.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/iversion.h>
@@ -734,4 +735,5 @@ const struct file_operations ext2_dir_operations = {
 	.compat_ioctl	= ext2_compat_ioctl,
 #endif
 	.fsync		= ext2_fsync,
+	.setlease	= generic_setlease,
 };
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 76bddce462fced77b24d64416cb9fdb172d8270b..ebe356a38b185e0d8662f704ad20e42fe618284e 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -22,6 +22,7 @@
 #include <linux/time.h>
 #include <linux/pagemap.h>
 #include <linux/dax.h>
+#include <linux/filelock.h>
 #include <linux/quotaops.h>
 #include <linux/iomap.h>
 #include <linux/uio.h>
@@ -325,6 +326,7 @@ const struct file_operations ext2_file_operations = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations ext2_file_inode_operations = {

-- 
2.52.0


