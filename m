Return-Path: <linux-fsdevel+bounces-74497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C33FD3B1E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF13309B651
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FB3C199E;
	Mon, 19 Jan 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2eWuvDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691C3C1967;
	Mon, 19 Jan 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840263; cv=none; b=t/wJw3DUzP7MY9CpPmknPgBIw27N1lGdUfvpiVEI3uI0q8WwAkEdNGHPoWhYx6F4v4PDURRhUmUJgmIgk/HiqnFtvkEwJvPoFpjVle0LrYYyuRwJOMHbjO005N9kYL74iUDv5QRxhtMAE4Ji8af5af0ApNnPwhctth4de/rWRSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840263; c=relaxed/simple;
	bh=YvhqTu858V2nHA/DvphvNPgy0WWoXV1XH8O4vHs3r6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hQDsF9EttYuVcqT8VGo0T23Te8h7hyhWB+ID+1nhNfs2cCMleb14r4dNEPKVwNvSnWZN9hcufxapm2zr7hAgWCVrZ40sHUfu8oRRUrohOictb+wPc0VThHUP99HdU7h/3oqlm8fI9qN13xnlRFKg5P2FVE2SPS83/UW8tAraens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2eWuvDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CBEC2BC86;
	Mon, 19 Jan 2026 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840263;
	bh=YvhqTu858V2nHA/DvphvNPgy0WWoXV1XH8O4vHs3r6s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h2eWuvDHO+FHNVWC0HtfYiwQLGD+wYaxR9D3B3Ed9tIu0JUYT/Du8NCPJr2Kni+6j
	 FzBHjGuc/OLKKlytLlDDSMvG6K/lZ+1yYDEkp/N9zqPCokk75ZABfwL6avEwi42vps
	 0f/64rbZnR08cTk3Jklqr4LP4IF+Xj2tBebaD1y0phkAa+Asd/Q4cqS9Zfs0k0IMkF
	 Wcd+HNSs1kfJ+gcQ5lC7WEcMywntkKV3L2fJFu0mtjX/DfTm1UQD/RZLxzC0HuvTay
	 SahYNV1qOWaAxchZUrdKt84Zn3hO16NvxYRmiTOmxr3zcnvDdJtPkIgDlJWEZ0vCK2
	 XLTl9TlK3VJ0g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:48 -0500
Subject: [PATCH v2 31/31] nfsd: convert dprintks in check_export() to
 tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-31-d93368f903bd@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
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
 Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YvhqTu858V2nHA/DvphvNPgy0WWoXV1XH8O4vHs3r6s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltg7KaYG+cOnqGQwFogykRFEv2vvWPelc3rm
 NkydLb2mGCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bYAAKCRAADmhBGVaC
 FWqbEACWyEMei5YgEgZwLPtZYTWHb8tmOW7eGn745dbexN721w1XJin+y0uFuiiEqpYtbB01+nV
 8eGJXblAwZWOM56qXzH8kIp9IF0Do5UMXMJTyUb79WR1Vxz5+svm6rH4ORCbDMoohslm0Ey+odn
 Zx62FtcwzZ/STJY531c69lQu2bhr3cC/ykvj+MnpDF1L6iyuPTl056aSkCGs+2TRjxpwsRGp0tV
 7FV1mQVZyW+b344OwsU12+VtzNEUh3CAPnxW20OYd9f0s9HFEpZK4Y9Ep/WsEqP0165/LeBaVXZ
 Tihw250Wgn1dTNDwYC3840yoGmtFEjRpYdrQxlR1fxUi+1e02u+G+A2z8VPXC2UMtR7HTpWR3kq
 0gpbEU4+t6RXYZ2KSP1Qp1R60LWabc62qCpOU1l2LsxieR9zzMNQzgrLEkvEzam75nzR1SYp0M1
 MAZjAICvnrvk2txw2ibnrnHJErb9vl+kLuB3btLLAaMmNVQQO9QZiA3QpDitFCH5aU6ZVYP8fdD
 r/l2xb9t2bkCY+uL5zGtY5a9B+sKZHy6JRgOd3o/SiUBbmV6dnxq4JqqdXpdxKAPH7RgwPtK224
 H9hNJK7Mkv5H+8Si6seHr0qbAPwccoRdGVCztXQ1fdG5MLjNTJb3M6cVTt5Wicf6NlgjQa664oA
 Z9sNNAkM0OHYjQA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Get rid of the dprintk messages in check_export(). Instead add new
tracepoints that show the terminal inode and the flags.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c | 11 ++++++-----
 fs/nfsd/trace.h  | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index bc703cf58bfa210c7c57d49f22f15bc10d7cfc91..3cc336b953b38573966c43000f31cd341380837b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -435,31 +435,32 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(*flags & NFSEXP_FSID) &&
 	    uuid == NULL) {
-		dprintk("exp_export: export of non-dev fs without fsid\n");
+		trace_nfsd_check_export_need_fsid(inode, *flags);
 		return -EINVAL;
 	}
 
 	if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
-		dprintk("exp_export: export of invalid fs type.\n");
+		trace_nfsd_check_export_invalid_fstype(inode, *flags);
 		return -EINVAL;
 	}
 
 	if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES)) {
-		dprintk("%s: fs does not provide stable filehandles!\n", __func__);
+		trace_nfsd_check_export_no_stable_fh(inode, *flags);
 		return -EINVAL;
 	}
 
 	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
+		trace_nfsd_check_export_idmapped(inode, *flags);
 		return -EINVAL;
 	}
 
 	if (inode->i_sb->s_export_op->flags & EXPORT_OP_NOSUBTREECHK &&
 	    !(*flags & NFSEXP_NOSUBTREECHECK)) {
-		dprintk("%s: %s does not support subtree checking!\n",
-			__func__, inode->i_sb->s_type->name);
+		trace_nfsd_check_export_subtree(inode, *flags);
 		return -EINVAL;
 	}
+	trace_nfsd_check_export_success(inode, *flags);
 	return 0;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ae2a611e57f4b4e51a4d9eb6e0fccb66ad8d288..e3f5fe1181b605b34cb70d53f32739c3ef9b82f6 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -339,6 +339,58 @@ DEFINE_EVENT_CONDITION(nfsd_fh_err_class, nfsd_##name,	\
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badexport);
 DEFINE_NFSD_FH_ERR_EVENT(set_fh_dentry_badhandle);
 
+#define show_export_flags(val)						\
+	__print_flags(val, "|",						\
+		{ NFSEXP_READONLY,		"READONLY" },		\
+		{ NFSEXP_INSECURE_PORT,		"INSECURE" },		\
+		{ NFSEXP_ROOTSQUASH,		"ROOTSQUASH" },		\
+		{ NFSEXP_ALLSQUASH,		"ALLSQUASH" },		\
+		{ NFSEXP_ASYNC,			"ASYNC" },		\
+		{ NFSEXP_GATHERED_WRITES,	"GATHERED_WRITES" },	\
+		{ NFSEXP_NOREADDIRPLUS,		"NOREADDIRPLUS" },	\
+		{ NFSEXP_SECURITY_LABEL,	"SECURITY_LABEL" },	\
+		{ NFSEXP_NOHIDE,		"NOHIDE" },		\
+		{ NFSEXP_NOSUBTREECHECK,	"NOSUBTREECHECK" },	\
+		{ NFSEXP_NOAUTHNLM,		"NOAUTHNLM" },		\
+		{ NFSEXP_MSNFS,			"MSNFS" },		\
+		{ NFSEXP_FSID,			"FSID" },		\
+		{ NFSEXP_CROSSMOUNT,		"CROSSMOUNT" },		\
+		{ NFSEXP_NOACL,			"NOACL" },		\
+		{ NFSEXP_V4ROOT,		"V4ROOT" },		\
+		{ NFSEXP_PNFS,			"PNFS" })
+
+DECLARE_EVENT_CLASS(nfsd_check_export_class,
+	TP_PROTO(const struct inode *inode,
+		 int flags),
+	TP_ARGS(inode, flags),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__field(int, flags)
+	),
+	TP_fast_assign(
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->ino = inode->i_ino;
+		__entry->flags = flags;
+	),
+	TP_printk("dev=%u:%u:%lu flags=%s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino, show_export_flags(__entry->flags))
+)
+
+#define DEFINE_NFSD_CHECK_EXPORT_EVENT(name)			\
+DEFINE_EVENT(nfsd_check_export_class, nfsd_check_export_##name,	\
+	TP_PROTO(const struct inode *inode,			\
+		 int flags),					\
+	TP_ARGS(inode, flags))
+
+DEFINE_NFSD_CHECK_EXPORT_EVENT(need_fsid);
+DEFINE_NFSD_CHECK_EXPORT_EVENT(invalid_fstype);
+DEFINE_NFSD_CHECK_EXPORT_EVENT(no_stable_fh);
+DEFINE_NFSD_CHECK_EXPORT_EVENT(idmapped);
+DEFINE_NFSD_CHECK_EXPORT_EVENT(subtree);
+DEFINE_NFSD_CHECK_EXPORT_EVENT(success);
+
 TRACE_EVENT(nfsd_exp_find_key,
 	TP_PROTO(const struct svc_expkey *key,
 		 int status),

-- 
2.52.0


