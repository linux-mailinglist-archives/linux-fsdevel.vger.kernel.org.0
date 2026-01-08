Return-Path: <linux-fsdevel+bounces-72906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD3D05175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4BE0309B428
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012E92F9984;
	Thu,  8 Jan 2026 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka0wy7tf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551D2BD5B4;
	Thu,  8 Jan 2026 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892590; cv=none; b=SeYcz8/dj1gfzxJ7VRyW/HBe+ogkLhv7XZPkXqtUIqwxgN4tHbnVSLIyJH7cCdiCYbof8DkVj9Fkyt0FO2RVlC8OrBDsFM/qk39UPxi4XWWn2B+fgD7340UuCWf5osiqK8r/FC/f4k+gCneCL+aCGD4kZiwXRsgyM7A+7Mr2iaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892590; c=relaxed/simple;
	bh=31kaSpuGA79pOQvjYXOIwkMusZ5I/9kl0pI7vxo79B0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hs9cFYUS6pShwb0NgG/Ir9LhMtOCJrdiCcxa2bzIEIV7UMndhnTLNlbdhZ8Y2pKm8d7AVmKSzpseM7rbdhDGW12RhXGkIkIC91sfs7VYKmvYA6RpLMT+8gtwEW2Dq8S3OzjwdnMKgqKN7m4t2dhHdwPhUjoAKGiTh9f67qT1zoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka0wy7tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5037FC19422;
	Thu,  8 Jan 2026 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892589;
	bh=31kaSpuGA79pOQvjYXOIwkMusZ5I/9kl0pI7vxo79B0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ka0wy7tfVbqJ8biZkl1dnF7zdBNpw2I/HL9Z4qvT7canG8yWttWmWRQ8y2bA5H2Ne
	 Hg1kLSaeL/MJqN/eLQrJ+0D74nyBul/1dg48cm4KybwYHPFxN2jDA0DG0JbZS9GgJH
	 YX0bgPuTqTt2qOuABV3Sh0WjERkrVZ8mA5j1puaJ7vvJQEjbKd1eF8mVQZSJI+ZJKN
	 +fRHCYR9Jhj0ZnSLSNSehLByTqec+/NNwTFW6FjkwP2zNBKgrJjpIbdazH4MUrGCoN
	 YFM4uhC2WPpbzqLdGmh6J9z/myyIQ398y3DCiuGgy6lIDUaJ/QXycwYIOEvZGejZ9n
	 yymoliwZ3EoMw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:17 -0500
Subject: [PATCH 22/24] xfs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-22-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=31kaSpuGA79pOQvjYXOIwkMusZ5I/9kl0pI7vxo79B0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W+/CMV6M0nr3SG7lwo2cpM9G7b0LqWdi9Ol
 v2q/8PSRRqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvgAKCRAADmhBGVaC
 FVSQEAChykiIZZ2qCoDgb3e10KiOX4j3Kq9XSCEqphrg9Pr8U0yza5P36Vy+bUEGsdgKPjDLqTQ
 q/949XOcYbiBcP+IEI7/gYaaYVJMEiIGImK6lABXNO2oMGOM6vLmEd3C+hnmhZlK8h2vCSnhIkw
 CqkUAOpj20VyRsjZhxXC62TQQO8/8Y1QDjwRM24rZXa9NLMVNIb9Nn085XnNY8+Ppa3eFSktXW9
 ihb7fODPt1Vn6Y+eTsFtU5FsC6SwCxOTMnfRJEfY2C9Yl+7ldIyvY+NSWFbd1iWDZ7EmBaqU6PK
 qrBu72lJYpbsDQz6g8wjru4v4bG8N8o0uQm0wo9K5ZDw3DyjYaa3ja3+c2uHUSiA7BKqCAx4smU
 Q5mE5CbEcfBU8OthZWBuIhfbrZeYXgiGW0722Wz/sF8uiPVXx0NNUtIVMw1iSvsgI2McyL2JLrj
 4VZm70XFpXu8ld9+0yoAZ/mUgmn4HBfNNG5qyOqJfFnnEteSMeBnpbPbC7mihmnqF+bUwfFMpx2
 rPK/34X8VljljNjLqhFk7XbPZz6v6m6AhuTblY7PbDlKBRzMM6jNhafVfVXrC23FeDGkeeeS0wq
 afbmnpmPSBOCXki9yf314rYtODExHP9j/c/bZvezn9USBq8VM89wiKzdf3Lm2UXyjR/QYwfw5Or
 Ae8nSsnmq7yvMOQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation pointing to generic_setlease to the xfs
file_operations structures. A future patch will change the default
behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/xfs_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7874cf745af372fe8d90af09c6916d4c635472e0..ecd7bf42446b38e075986d1c774dea4e8c0c0d01 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -36,6 +36,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/filelock.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -2007,6 +2008,7 @@ const struct file_operations xfs_file_operations = {
 	.fop_flags	= FOP_MMAP_SYNC | FOP_BUFFER_RASYNC |
 			  FOP_BUFFER_WASYNC | FOP_DIO_PARALLEL_WRITE |
 			  FOP_DONTCACHE,
+	.setlease	= generic_setlease,
 };
 
 const struct file_operations xfs_dir_file_operations = {
@@ -2019,4 +2021,5 @@ const struct file_operations xfs_dir_file_operations = {
 	.compat_ioctl	= xfs_file_compat_ioctl,
 #endif
 	.fsync		= xfs_dir_fsync,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


