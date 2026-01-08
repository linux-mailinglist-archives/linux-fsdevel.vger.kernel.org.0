Return-Path: <linux-fsdevel+bounces-72901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18CAD0562B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D92C3541492
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7F345CA6;
	Thu,  8 Jan 2026 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEjw0/vg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4552DB7BC;
	Thu,  8 Jan 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892552; cv=none; b=Wr8Sfn+MyMlODGiKhc84UDCBfeFlF/5wYzcPlwuV5P7VDAoNIc2wrbQRZo4tTJ1xbCBXCnbGjWs5jUjsItaDgI51A95/Wnd1ZhczxJm3lTKL1/jCpzxbF5npnc1EGRqxx8R/1YU6Fg6GrUFwmbuPMpVtlVm6uqVuceOxSAE386g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892552; c=relaxed/simple;
	bh=/QjFws5fePN18OBYa8bISKhX2yIiYoWbwKUyTsCKvi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=faMo5q6b89OK/8eR2sJyF+RBH7coP6HGluLoe5NQClT1M/8Emymu/VdH2ltCBCNTUGaRfd6zrGiVBDI39FQVeF4Eu+QeICkNFiyfbboEMFtXEZDvFu9RQhqwWGx9IhJmr7bIrZBf0kB4qwP5ukwTLBvI08GmNvpc1y0cmA0/L1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEjw0/vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74598C19424;
	Thu,  8 Jan 2026 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892551;
	bh=/QjFws5fePN18OBYa8bISKhX2yIiYoWbwKUyTsCKvi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEjw0/vgT6GLsQDvxChTEJJWrZnAQSwT/oOYtarnEr1mnlXneb12dRn/+E7ODlH3e
	 lEscuNaICbpX+q+/6dO9siSu+ISv3W0K9wwdJ/mDEw92/56eNocyUzJjpaC6QdgIyG
	 TXJksMFDlSytDs24skqoMve70gF6oZNa7uvLK/sesVf1BfG3jX47nbuodaLg5SaXh5
	 LmcwS/E2mZY6CTlzB8FWEcmq3mPVRu19tuFt5HFUJmWTID9UfJc3ZPIB70pwGbpr4f
	 vHcBl/oxvixj+KEoGwXKpq84pv0rNzyvfBOZbbD9Nf9EOol0+LhwcwkX8AyEiOq27a
	 b5nd9nZ8BtLsg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:12 -0500
Subject: [PATCH 17/24] overlayfs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-17-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=/QjFws5fePN18OBYa8bISKhX2yIiYoWbwKUyTsCKvi8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W87k4FcETAMephFZz/qe7wC4C41gmjqLLfA
 Q/kBv6HQmOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 FYTHD/9CJrqt0jlrMR3MPzOXX6TESjSMY5U+1+dwGCcCtiGwGSBiK1ZY1GBC73psRJ+mYjVfSic
 MNCosL0YefLDvCp7QfNs9/ejLx7RUtyNCes+plJwrTahfnVJZ1uNYdK5DEZ44L2DqTFmrzcD4wQ
 oy1zj93AjNBYypMHV/k+qL1usyMtFr3jPnged5fSSsBkJ0C5Si0L3ZpP6TqWEWeOleYjDy2urwR
 fGkQUW+9Y6Xar5xRYHpGJwt5PKYAatcXU+SveMXOFbp35GKe+fnfNWZiABMI8W02Qp4Mf9CV2ZS
 45JLWGX1Hhj/0H/KewEpFamsXAQz298u+NwRFRypHdABGYAFB1wzK1r/D5p2LnmLKqrTaQe5bmi
 9Jgmywfj0M6wILCz2dDyEET+5PE0sipM9aPV9cHp/v/kpE/99FxGIVlFijqG1YuygTZ3CnEMEJu
 y6HITTLBUusNTrhTU0Khne6zJzbhrbr4Ank1yRCl3u3cBFZxLvFFUf7YuQpp9L+6yqXasB7W63h
 VKAGaSoSzMKxT87yMNEdOlgZcotY/MTm6wihQM7wiAsC80uzL7LVT26vWynyqiZeva+dO6UcZet
 rUCqoy4q+/P7Ir1xCA0rQQCgb99iKp2pznNbBKq1+cYFA4N3yihYKFOnTD8jO/9X9fRvFIvZWGS
 bhGnYs9Awrd5yCw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to ovl_file_operations and
ovl_dir_operations, pointing to generic_setlease.  A future patch will
change the default behavior to reject lease attempts with -EINVAL when
there is no setlease file operation defined. Add generic_setlease to
retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/file.c    | 2 ++
 fs/overlayfs/readdir.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index cbae894572348acb3ba6c2b6e7f84558379110c2..8269431ba3c66d49d2eea24c4ca63a3d2879580a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -5,6 +5,7 @@
 
 #include <linux/cred.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/mount.h>
 #include <linux/xattr.h>
 #include <linux/uio.h>
@@ -647,4 +648,5 @@ const struct file_operations ovl_file_operations = {
 
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
+	.setlease		= generic_setlease,
 };
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 160960bb0ad0b0cd219cb2d8e82d8bda08885af0..7fd415d7471ed58849710da9f8a414b2b7aca1b4 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/namei.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/xattr.h>
 #include <linux/rbtree.h>
 #include <linux/security.h>
@@ -1070,6 +1071,7 @@ const struct file_operations ovl_dir_operations = {
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
 	.release	= ovl_dir_release,
+	.setlease	= generic_setlease,
 };
 
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)

-- 
2.52.0


