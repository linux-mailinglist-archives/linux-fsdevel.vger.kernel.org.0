Return-Path: <linux-fsdevel+bounces-72892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF7D05352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F6CE306C80A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D432ABEC;
	Thu,  8 Jan 2026 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYNgBgcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E0029BDB5;
	Thu,  8 Jan 2026 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892484; cv=none; b=MNQI9+jVJS3GyCTOicfdqr2Q2sj8Lr1idVzaydOkDCmkhnd/4HJrgF70HNGvgG5KyHH2zFqJLjXd+/fPSa/KGIvZq5O4A/+jpZGd868z5xbRQ9e77mp/atYSQ/5D4wZ/4J7GszXiWaa0/w5BkUpyEaSXVZw4Es0VhFrSKaaVOfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892484; c=relaxed/simple;
	bh=94xq5tNwwGdVFEbsY7qMy4HxVAW7YcdB4S8NrCMz7tI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0GYacTOQIpUvAtT7tyUD380jHSSiEGSyc0TjZQcLOeFk03bu0zXDY1MFI4oUq8wIGEcHglZPNlvhOlpChDO49dLwp60KzYFqXjyrcnrYLMj7eUCUiTg6gqGWFqPUHU1I+FU42iYZDzwFVo6oeoxnlxmD2NFCTi+4mFiK+fd/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYNgBgcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92A5C19422;
	Thu,  8 Jan 2026 17:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892483;
	bh=94xq5tNwwGdVFEbsY7qMy4HxVAW7YcdB4S8NrCMz7tI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UYNgBgcZejmmXe9+DGorQt4RzpRE+LAfkhZHZp2epE14mjVE0kdPbmDA9FBeWHjMv
	 u9grV7ZUhfGqgp292cdxMQ4ebVh+7j4zYMeVX1AUvqsmp+m4hG8sTJKXY2bL0uXnmL
	 OIxyKXSpQg2ocYvNdp4AE5BMRYSlBgMdQrdbza/DISv7Cy76VCfxYvp5i3I5TcTajk
	 YJOEyp1ppteph8H2ZBkKGtwhMld0tUqpbaGdbkBKjsRPR4g/kFdS9O8y8483fi2fAe
	 qoPICRyBKGoVVHyK9qAZiaZUwXNNW3OJnBSiavsAbReAdv/Zgh89GbNfcesC6s4T0d
	 QFBYXqYE9Z5vA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:03 -0500
Subject: [PATCH 08/24] f2fs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-8-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=94xq5tNwwGdVFEbsY7qMy4HxVAW7YcdB4S8NrCMz7tI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W61b/MyUzbdcdSmodRmXRKd3YgHTA99dyp1
 aKrHFL8B/qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lugAKCRAADmhBGVaC
 FZP9EAC/KfvgDBVB+iOugVAOgIuiH2lLp5UGHRZYXoccQ7RsLXt40LrXwHbIuUnBnPTDl6Q24dk
 c+qR4vCzUsvTs6ZoB/hQgF5t7enFKO97X64gMM1cI/L5SVv9wJHkr+SlWYrN0ZRkMYbYkqh6Qvn
 YdDpzNnL+2CHJm6WeWY9m3G6MP5VpD6AFQcWS32/nlYcAiAeE8U5UDm6yRPub2BRgLrQMMLwo0F
 gT5ML+oeaRwNhBAtuUc2ywXWSazgnDwe9Nl4vdX9hsgfjqEd5ByGvhbHi5apdnDTqT/qbVjXKig
 +iWXByE7jJlTpLGiOJFwwFEPTEukug/2WKCgwXoSbYea46YVqKLq9pUVapamKmSCjXPDr9DWfYQ
 r8y4tje1jnoLB4Fp8cn9lRtS3Y4EXDQRY0n7L7VKSOtOvyFI4VGIHpsTF+SCJY+VcgswGTMeqVU
 kDjGI23wvqX81gZd7GFSgWewsEYkwNit/sgV7LOVnfE4EUSCygGym8eAfR0jWZ24zMWCeUcEGZn
 03QVAgVIEkYdmz52qL0NWwbiUb8fhK7fLvEUD/dMUt6q1Ot/7vl/H8/z/LaCO2baW1UpCuaPnIY
 maDRAn3wF963W2+JRVkZWEzuiaXz7m2dr0S/XOxltRGXHKRIM0xY+sla9/h8+M3PIOmfyRFvtqt
 V+typZtw20n9PeA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to f2fs_file_operations and
f2fs_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/f2fs/dir.c  | 2 ++
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 48f4f98afb0138aefabaa10608961812165e2312..be70dfb3b15203d6d92c80b4bb64fec879864988 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -8,6 +8,7 @@
 #include <linux/unaligned.h>
 #include <linux/fs.h>
 #include <linux/f2fs_fs.h>
+#include <linux/filelock.h>
 #include <linux/sched/signal.h>
 #include <linux/unicode.h>
 #include "f2fs.h"
@@ -1136,4 +1137,5 @@ const struct file_operations f2fs_dir_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = f2fs_compat_ioctl,
 #endif
+	.setlease	= generic_setlease,
 };
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d7047ca6b98d8a41d69ea79bcbab3e4ae4cf30b6..cd4b1d3c90ab8114533d939e8dc129cbefc85c15 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -11,6 +11,7 @@
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
 #include <linux/falloc.h>
+#include <linux/filelock.h>
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/uaccess.h>
@@ -5457,4 +5458,5 @@ const struct file_operations f2fs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


