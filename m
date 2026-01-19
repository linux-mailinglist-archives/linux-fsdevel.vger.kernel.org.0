Return-Path: <linux-fsdevel+bounces-74467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B322AD3B181
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22E52306EF35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59199328B4D;
	Mon, 19 Jan 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFGw0Nlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B724C325714;
	Mon, 19 Jan 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840054; cv=none; b=PbOc3zg7PZ+aO9qUrD/JqYQ/TqvuX3ZMalNmP1WiWv5uhXfgbRa5g8fhwpOczauHq/kKzp5u7FBvye2K0uBHSksGuL3IZtTq/SW8kmSmA+cCIisv/PKZcl/C7mEBUpendik5s1anTJDWEvD8zhRzgVYBZ03YPK+n5sL0ntENsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840054; c=relaxed/simple;
	bh=WOmtIr1IsB2xi2+MQpnozeMDf4MRJ512rkEzgmzicq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHkqbj9HklFJlyhkC3aSdyE/wQsXvu1cH3GRwkL7m/K7kfw+n7Z73ZwPrkvEQM+TBrG5cjHt93cPjQrwfQS/XFh1IB1NBZdSCGDGpBu+GFPoFz6CW/NUf0DDvYBh6B4PxOd3N7r+TeYNOl/4BWREHG4ld8LokOVbSQBTM4MaWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFGw0Nlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F16C2BC86;
	Mon, 19 Jan 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840054;
	bh=WOmtIr1IsB2xi2+MQpnozeMDf4MRJ512rkEzgmzicq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fFGw0NlbN5TsRC2ZjlZjZn9IX/42PhPSQnnYH/4v7sgwhqTBMY/MxwIMIlKkHQgff
	 IsnuLQGgFH8eWVaaGOR+eMsdGER+dvGyTUfbMzLqADvcxjbHTL48XRw/G/ojzS6ubF
	 gxWUU+M9COq59S0/XzQ0Rg2QVwbbyQSi2S57Ixy4HGcUaYn0kCzvwW32x4YptCcCne
	 TC5kQgRykkBR+Q/5D8riOm2605W/IKWQgExzxr/JW0sdu9dkxBbhSvoXfvEW1caiEP
	 Jtfr/b52H65goyMqJXxHvpQS5ggVa0+AKp5u4wRq/MKYBMwp0R6Slbqb969DTxzRNV
	 Kdv1LlGm6aQKg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:19 -0500
Subject: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3825; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WOmtIr1IsB2xi2+MQpnozeMDf4MRJ512rkEzgmzicq0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltZJJ4Erxc99mz4JD4fpPhibGNL6s9qiEaxZ
 +ast/XYA8KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWQAKCRAADmhBGVaC
 FRr2EACvlm3De5JtqwIRiAJ+yR+TrnRM6zVnaaBcPqW7NWtaotgXHbjPmhHalzQ2ehLlMs4pBwW
 CJdzL/0SuDHd+1ninl8HscU8YeUjTL2yuS1baFgceqGQ56wAeo1gFcMtbsngMt0UiC5VhNd5lzQ
 hisUbwG+ATmkxRNQlt1jg5Knn2k28x7ZuUBDbB9vNczmKJ2P3gR4vHlU6toocVh4tp1XLS8YnS4
 /Th6ZoeqlrAyCsLW2EjmEjXRmVT3n9bN3rhj5BRL01f5sWIKM6YimBAXNaGgfT6UVTHVYycMqid
 z8zjumO5an17putv+hHHquqigVwMPoFkl/R//xJ/wD3NuR6WXPWj/YfRuSTQ6HrgP3/xw6XGitp
 THrn0RYY6owKt+oRWUEoL3eIf6yNlcLh6Z+A7iaacop4/RyPQcauGbboHVG+zQrFpRA0TYU2QWr
 OJuePE5rbnQL9s8mlCeoPUUbX0I0E2jges1C26w/uthmL5Jmlg1eyzXFafUNmt45LVS97O17yyA
 A2BOWaDmYRmleIMtYuRGy98LCY2KV91GcRPRO/n424NqA6H2dC2jvKwMZAfZLHNYZBLKEgJ+x1O
 GEgCl6Q0UBJ87Io0WzdKw7SlTPxZyLbVNRNcBAm3/kG8WoQXajMQfr4a1wQ/fclJWtptjFdnzZD
 anI/Pt3rN8rtBBA==
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

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/filesystems/nfs/exporting.rst |  7 +++++++
 include/linux/exportfs.h                    | 16 +++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 0583a0516b1e3a3e6a10af95ff88506cf02f7df4..0c29ee44e3484cef84d2d3d47819acf172d275a3 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -244,3 +244,10 @@ following flags are defined:
     nfsd. A case in point is reexport of NFS itself, which can't be done
     safely without coordinating the grace period handling. Other clustered
     and networked filesystems can be problematic here as well.
+
+  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that are
+    stable across the lifetime of a file. This is a hard requirement for export
+    via nfsd. Any filesystem that is eligible to be exported via nfsd must
+    indicate this guarantee by setting this flag. Most disk-based filesystems
+    can do this naturally. Pseudofilesystems that are for local reporting and
+    control (e.g. kernfs, pidfs, nsfs) usually can't support this.
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index f0cf2714ec52dd942b8f1c455a25702bd7e412b3..c4e0f083290e7e341342cf0b45b58fddda3af65e 100644
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
+#define EXPORT_OP_STABLE_HANDLES	BIT(7) /* fhs are stable across reboot */
 	unsigned long	flags;
 };
 

-- 
2.52.0


