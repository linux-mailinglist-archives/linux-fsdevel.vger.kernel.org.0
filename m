Return-Path: <linux-fsdevel+bounces-73954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC7D27956
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3EE32D3524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D423C1973;
	Thu, 15 Jan 2026 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOFwUkEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49083BF2EA;
	Thu, 15 Jan 2026 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499289; cv=none; b=ZmvHpRjvh/VgnPPBd1D2Jrpni7a+chVp98tl5GcykAZ00ukx/qzWbljfQt+Ga9opTKDTjYD3YZztvSHPKAbCSDUj2D5I8H8vfH6IE/HazAA4rN3VeRxjeCi0A8pBa7NLKhROS4fzaQRCAeRvT5Wy5cEsGe72k5X2kWeuK/Mj8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499289; c=relaxed/simple;
	bh=RatR/m42YXTf7CDA2CRhGedueCSbBBqPoEedVs8C9UA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L31+ucUkQsdvpe0aYQePTWRjkKdjsUGPWtSs4XL0n9YZVyYOLYVZORVNKbbmKW+7PWvbMbTzL0khCbe+KqNjofGC6nlVgohCOsQA431gjew5hSpFO/q0vC+HjnTPLLpE3KbCxJyMI/tAOgvOWRiUsEe/qKFuy97bSgDghhiuOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOFwUkEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76392C2BCAF;
	Thu, 15 Jan 2026 17:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499288;
	bh=RatR/m42YXTf7CDA2CRhGedueCSbBBqPoEedVs8C9UA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VOFwUkEJYHXeJXZRL0zb6eR6uUkxRN6kee6xDzHjmgu/5n0uJWSJAGIa3iEZf2Lg5
	 lrmFB48PnhjOkIGftUE7FVsqT4OhDUbx7K94Awns52sziz0jZpwHnSwAotvQh9go6G
	 Zo5qVJrJCTeW+EYm8RkT1AHIIjI4FEVXimKg+J0MhIDVSiFaPKoaNwen3lqywhgu7/
	 6LXz5VvJpXQJcRFroHj6/0MKUhMKcD4/ei6N/XtrqN80C8gSBdoXmdkSxh52BGo+am
	 jWfhM+WqcPi6cHCYVvHnXDhmoAc7qwGGCr9+E9m6pasHToUBBOCqkijjTvFPBJ55ff
	 ezWMduEtFCLPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:32 -0500
Subject: [PATCH 01/29] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-1-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RatR/m42YXTf7CDA2CRhGedueCSbBBqPoEedVs8C9UA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShEw8HrDl/7ZIM2OU/hVtFHsnd81WblzyW/e
 yPqA+8+5UGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRAAKCRAADmhBGVaC
 FYotEACEnxwn1zEGzienetvotgfcnP0KEaEoc3vEq4xPjrvl8qD8AzHl5lAD9pOV95V0vyU1jWl
 F+LEfCXY/wJ0q8m3Y2mFHyBxMY8nD5PoBm5N4fXW/WYFI8u99g9N4VNJkrMQ9HTzKeVAKTl/M1J
 mrbI22t/onu2ymRGzRqNb/kAFe3UnZKq5nzacFwoBRbfAKrjqjfaJPjermi4aUlVjCjekIh0TEE
 Ds0g+E5VMeObKsUc14iLHgf2OKqEIRvMP8DaK6mlvpMXaAD3YHzptTey4nYKQUZRFFZcleYPplo
 SWrEuNsKUdPrwdG65vHBuaIE9yEzchlvNdGyIGc7aqrMOax0dCU8qPoLhlLadC25xQrrazgFoH2
 l/Y92N1//yzg8uUwnicfsrF77KdgC9ImgrgBPrbAboDvmBqOCGgIiepgsb7Q62IXUYph956Fup4
 YiuHKS6eRp+flNlvzvNOVL21skn3W1rV/ffia9WkmS52EfWCBJLfMVFLlM5Fxs+XfASNsPkZcjk
 7A3T0E92BC/sj2ln5xSO/2PWamRs0o+Fjo1zTnuo4iAMVwDZQ5EpZMWc7wQnI3KnxwLfagRAPXu
 7gOokL39dJc1Puy9BUCKYlRaUcifcB3ctHJTgr0/wiT5j/Fovcjx2nirH3rLSgIbyorjoAiOcP2
 f+X4rzQbvEzY5lw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

At one time, nfsd could take the presence of struct export_operations to
be an indicator that a filesystem was exportable via NFS. Since then, a
lot of filesystems have grown export operations in order to provide
filehandle support. Some of those (e.g. kernfs, pidfs, and nsfs) are not
suitable for export via NFS since they lack filehandles that are
stable across reboot.

Add a new EXPORT_OP_STABLE_HANDLES flag that indicates that the
filesystem supports perisistent filehandles, a requirement for nfs
export. While in there, switch to the BIT() macro for defining these
flags.

For now, the flag is not checked anywhere. That will come later after
we've added it to the existing filesystems that need to remain
exportable.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/exportfs.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52dd942b8f1c455a25702bd7e412b3..159b679ef176dc710e9d0107ff9315534c44f715 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -3,6 +3,7 @@
 #define LINUX_EXPORTFS_H 1
 
 #include <linux/types.h>
+#include <linux/bits.h>
 #include <linux/path.h>
 
 struct dentry;
@@ -277,15 +278,16 @@ struct export_operations {
 			     int nr_iomaps, struct iattr *iattr);
 	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
 	struct file * (*open)(const struct path *path, unsigned int oflags);
-#define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
-#define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
-#define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
-#define EXPORT_OP_REMOTE_FS		(0x8) /* Filesystem is remote */
-#define EXPORT_OP_NOATOMIC_ATTR		(0x10) /* Filesystem cannot supply
+#define EXPORT_OP_NOWCC			BIT(0) /* don't collect v3 wcc data */
+#define EXPORT_OP_NOSUBTREECHK		BIT(1) /* no subtree checking */
+#define EXPORT_OP_CLOSE_BEFORE_UNLINK	BIT(2) /* close files before unlink */
+#define EXPORT_OP_REMOTE_FS		BIT(3) /* Filesystem is remote */
+#define EXPORT_OP_NOATOMIC_ATTR		BIT(4) /* Filesystem cannot supply
 						  atomic attribute updates
 						*/
-#define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
-#define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_FLUSH_ON_CLOSE	BIT(5) /* fs flushes file data on close */
+#define EXPORT_OP_NOLOCKS		BIT(6) /* no file locking support */
+#define EXPORT_OP_STABLE_HANDLES	BIT(7) /* required for nfsd export */
 	unsigned long	flags;
 };
 

-- 
2.52.0


