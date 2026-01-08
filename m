Return-Path: <linux-fsdevel+bounces-72899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCADD05604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB0D93514E91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F834251F;
	Thu,  8 Jan 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEfgxOSR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98D3033FF;
	Thu,  8 Jan 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892536; cv=none; b=GaiWT4km/+vd1IGAM+KB1xnTiQg1Qo0vgzt2PfHiniU0q0oZPFPoU4aF3tu0DZZ6sDnjE3N7yYzT8namp/eiN02bx7ynzRPppnup1htmh8iJyIq9KBAr5F65dJUmxVtKHgL4tFVwSUQN2aXjP3Prz3oAYTIG29qBnh18FMNRxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892536; c=relaxed/simple;
	bh=MiPWr2DLJcKasX6F9v8+9rGglnlyvJqPKW48zd1al60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyu7+3RbQpzfP+ckTmp3cy601oCHVErZmUWkWLDqRcrk1BfgjNE+V13r5JkKCDtPrVCnMsyVoti5VBGiPLNnUG+wFEUgQOKnGsL6fZlPZnfW9L8CciSOdhaPbDvT6VfbulcwC8j2iLvlAb+g6gBNefLinFRsoKDWF413z3aCUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEfgxOSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30428C19423;
	Thu,  8 Jan 2026 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892536;
	bh=MiPWr2DLJcKasX6F9v8+9rGglnlyvJqPKW48zd1al60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FEfgxOSR26Tj6ECCXQ1kDI71xuD1hXG0pdgsfNZC4qjP9PM5lbfSx+Yybs1gCcecZ
	 5xVezzMwDcSNmCAOhMvgtKsCodYaQQ0THMfjeYU1Lka0ZfBQvNJSo7ZROk/8DWqqwS
	 z9CfvD4AgySuAldM2dO7tTufE31f/BCPAdnxWn1/LB9kJnwnj1jV/Nw1ca2KACETGl
	 J8f4IuU7G8YKWo7cRmlJQR4C0vPm9DRtuy04I5l4PODkstZAHL3jw8Nx1K9gAKC3OK
	 YiODwtzqw2h8Mvyvp8pwAs4PfIZ4y1YWFa7ryDGScMUbzDbIQyzQGIbkZGDOaQEX+r
	 xeKOdpkRHCqKw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:10 -0500
Subject: [PATCH 15/24] ocfs2: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-15-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MiPWr2DLJcKasX6F9v8+9rGglnlyvJqPKW48zd1al60=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W8O17HuY23tKG5Hc516pzPRtZ6MOWS5N7vz
 r/iJxDtMHOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 Fa41D/9uuWhzztHYPgXgRluKnu7erDAhmYdtz6gCOWZcNAGtLmln17MgKeXnmkqDLMrPGVckwT4
 fC7PobhFhcSNz2sSkcjk425Ir4n/1vzlHrGwFkpJLw4Kn2fjqQnx7gF8IbKic0lGeIbkIQbiv/M
 8jFiA/irOYflPM9HaGteXeTCHJ8i0+ULeKKhr/udChrv8wCSN/dIEHMDqryp0IfOtpmJQTvb5RZ
 3HCC4ofBYEz4ZCwq3xOjBjH9yLnbP9AIyEGC2LegAIND0PfwLhjS46AnEIEsUDiaDbhbzFxL134
 48fiomWRdRAG+WQ+FJmxb6WzuE5z5JyudmKfckYinC3ZMkz+qNgDfidFdXNBevMLS2ukjoWJ+iJ
 2EfSfdIaSUtE9amWUXmyMljqiLZWlHGyTMebwgN+VoRxnvGxD3vd0+HDPL0R7kJzKhsfgoRwH2n
 Dgdq4fET9XNtzIN9TzuFmn3ga2hYH6AG+x8d4Ll+Nk0C2jMtDJZZI57nFOVXELVh+mTrTvljKih
 nvP/dVB9FoRi/l1JWdbfaX74VqUwinlSeT/iqLJucuPyQG0GWP6nBGRB6iYgcNBqJXT2kVB0ats
 dVPUdyWpL93BCT7a1h/PdHaO2xKWw4Phq16fB9qNI1evyBT5qrdO1Ol8oCTrYo/VZNl7rhK29IJ
 9CXrYp95PfaAsQw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to ocfs2_fops, ocfs2_dops,
ocfs2_fops_no_plocks, and ocfs2_dops_no_plocks, pointing to
generic_setlease.  A future patch will change the default behavior to
reject lease attempts with -EINVAL when there is no setlease file
operation defined. Add generic_setlease to retain the ability to set
leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 732c61599159ccb1f8fbcbb44e848f78678221d9..ed961a854983d5e7abe935e160e3029c48e6fca4 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -19,6 +19,7 @@
 #include <linux/mount.h>
 #include <linux/writeback.h>
 #include <linux/falloc.h>
+#include <linux/filelock.h>
 #include <linux/quotaops.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
@@ -2823,6 +2824,7 @@ const struct file_operations ocfs2_fops = {
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
 	.fop_flags	= FOP_ASYNC_LOCK,
+	.setlease	= generic_setlease,
 };
 
 WRAP_DIR_ITER(ocfs2_readdir) // FIXME!
@@ -2840,6 +2842,7 @@ const struct file_operations ocfs2_dops = {
 	.lock		= ocfs2_lock,
 	.flock		= ocfs2_flock,
 	.fop_flags	= FOP_ASYNC_LOCK,
+	.setlease	= generic_setlease,
 };
 
 /*
@@ -2871,6 +2874,7 @@ const struct file_operations ocfs2_fops_no_plocks = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
+	.setlease	= generic_setlease,
 };
 
 const struct file_operations ocfs2_dops_no_plocks = {
@@ -2885,4 +2889,5 @@ const struct file_operations ocfs2_dops_no_plocks = {
 	.compat_ioctl   = ocfs2_compat_ioctl,
 #endif
 	.flock		= ocfs2_flock,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


