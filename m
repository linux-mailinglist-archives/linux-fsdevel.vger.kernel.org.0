Return-Path: <linux-fsdevel+bounces-72898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0347D055FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E62350CAE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8134104B;
	Thu,  8 Jan 2026 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6pSqLEj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5F73033EF;
	Thu,  8 Jan 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892529; cv=none; b=CrQo1NryyLjtz3nP751BSztqtApkA59BsKWQUc3gx4dqU8cTp/KIAFSnFIj95pWJFiG30qRJb4BSahWwABmN/Kn9tssrQ0APiRJe7DL1HdnVMCsj4+c2KJDhxbeRWtU91yE98UzFfvfQiZwz60TMp0DCSxSrBJuhza/sB9755mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892529; c=relaxed/simple;
	bh=lPmy5m2b6fstUP4HTh/TkAWFgE8sM8Qul7SD/NBtEMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbkjjqTKuLbao9Slumv5q7ZvwUi4prOzl2Jvg9v4JHZHHiE6n9SqhMaOjlSWLuHNI+H9hbFotqT3DkvKLvzyN4LNURnxBtPITOKOujnf9t7Xi0SO3WDwL4+fkIUUKVKw1irg1RTaJsnKmXIex4FDxj3gb67gtdaY0nUr8Uoy9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6pSqLEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1798C116C6;
	Thu,  8 Jan 2026 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892528;
	bh=lPmy5m2b6fstUP4HTh/TkAWFgE8sM8Qul7SD/NBtEMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o6pSqLEjn8qK7qYNebbAPkZ/JyIkQW++u82AhUwHi9H+QW2iAyt2/YV8OGsxZd1A9
	 ENrWknJg3NuxCTQ3tUkQ1nzJNdFeu2kkZmIWZslXtUy6vu4vYwlwaK2LDvMonkrRhF
	 3DHPRixwdk37Z3HJCNoiFPBNw4693o6PHwWpI06acd0vWqBNZaKtDxOBBL5GKH39ZA
	 mbERBl79ANFf6jGKxR6nRABJR3U3eh0aPlvqDAYupbvpmt5OfNovh+dgAcWgFcY9LU
	 VS2ZwmFVEW/NiRBVP3QjkmbYkj70bOwxmxx8gLNaqaMxaDmsgaKB3rvo5lQYD+x3aZ
	 OaVj5eawcoMtg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:09 -0500
Subject: [PATCH 14/24] ntfs3: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-14-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lPmy5m2b6fstUP4HTh/TkAWFgE8sM8Qul7SD/NBtEMM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W8LwtRNR2sBvsfy/GEh9ZefE4EjXAmzXj3h
 zdKm8qXc5GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 FbfXEADAKoRXZYBYCpltQSV7jdjNKk/JyP9tf3Coi/d7GV8fbo+eZK1ue3cTjR/mnT8hTfpD1xc
 5iB3iihAi3kCkIJSXzhpU5KSj5hFQCw343IkafmT3BIx5qzB72aiZMDoAsWRpM3GIreEyEh1sl3
 5Ox+8W9SmDsCzuHZ6gkAXHoarhyBNbRNlsYF+9XHx12xDx2EPVsr7cNp2IEOTtznxjB4k+JBIHG
 UlXRMlUV2UsOWJuS5EheCi2MMjIz+jrNb10YTMZO/ViLSG5b4xfU4a0BjaxfLJmzlNuVxFt5u47
 jJE74krY8s7YAOgW6N5+RB4czfrDPInVhccAdJcQYtAooHkgCDp+mTfMqlqZR7yyjeJf76atjl+
 +u8kOrnz9IXqT0pc8a1QsuAMA7SsW0nBEHcoGbobIpfstwgPDADr+lEqBOAu/SO2hbsAvBVN5n8
 Cx3bipjsINEhrXXbawsgNTUG/Ju8P6zGspNVcDL9yp9ry86Vnp/+WihRVDWnd7/O3XrcpKNtQ9e
 0xmTkabjcapHBXNsYeAA+dnMdTzCt3N16zrQsDrFEw2RublZKzJfg5f2O6eRXDt8/yXbFJ86oxp
 QBcIiI+HCS2lppFLxe4GtpIu69t48Rv29J2fKJ3q5RTb3WDfYDxGbNkeift5ZptZ9QJ7hvm8Lam
 SG2twaW+WuHsXSQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to ntfs_file_operations,
ntfs_legacy_file_operations, ntfs_dir_operations, and
ntfs_legacy_dir_operations, pointing to generic_setlease.  A future
patch will change the default behavior to reject lease attempts with
-EINVAL when there is no setlease file operation defined. Add
generic_setlease to retain the ability to set leases on this
filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/dir.c  | 3 +++
 fs/ntfs3/file.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index b98e95d6b4d993db114283a0f38cf10b1a7520a9..b66438e34bbb84483c5e6a5dde437251339d4335 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -630,6 +631,7 @@ const struct file_operations ntfs_dir_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = ntfs_compat_ioctl,
 #endif
+	.setlease	= generic_setlease,
 };
 
 #if IS_ENABLED(CONFIG_NTFS_FS)
@@ -638,6 +640,7 @@ const struct file_operations ntfs_legacy_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= ntfs_readdir,
 	.open		= ntfs_file_open,
+	.setlease	= generic_setlease,
 };
 #endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe18c173319c7cfd4304c22ddd2f28..6cb4479072a66dc9c3429be1c4bcebce176e5913 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
+#include <linux/filelock.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -1477,6 +1478,7 @@ const struct file_operations ntfs_file_operations = {
 	.fsync		= ntfs_file_fsync,
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
+	.setlease	= generic_setlease,
 };
 
 #if IS_ENABLED(CONFIG_NTFS_FS)
@@ -1486,6 +1488,7 @@ const struct file_operations ntfs_legacy_file_operations = {
 	.splice_read	= ntfs_file_splice_read,
 	.open		= ntfs_file_open,
 	.release	= ntfs_file_release,
+	.setlease	= generic_setlease,
 };
 #endif
 // clang-format on

-- 
2.52.0


