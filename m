Return-Path: <linux-fsdevel+bounces-72900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E8D04F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99855307FA50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313A52EAB83;
	Thu,  8 Jan 2026 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJag7iH3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CBA2DB7BC;
	Thu,  8 Jan 2026 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892544; cv=none; b=egteAPp5MYXc5xhj9pFrJXy366hUXMpi4zWX2IZr4+7yltHyXFfST+zRGcRLvOD3nkC7eQjyuP8Ypg6vSFT4YqfWAHb0yfzXGFLqZyrnbir7YOGn5r11q7etjDc6u81jU8qSgNKl0CA6oQs8dopbfz2RE2NXtzBwMiKICNE7Rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892544; c=relaxed/simple;
	bh=yVN7kiv7Ur9Q7AnxVgFewkb0L/ZX8mnNajC6Hfb4ItY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QALChOIoZphtgYluChQ5gQp6vSQOl1CEY38WjGGREMJ4SCk+9NOYCOAE0Yum4CylrCbyJs/o5o0Eenk0FNa8V8X4/NxKGHLSm8/GuAqMJrhHyCKTUXWaezniN3E20vRNpGMcqVonCi97MDzMdcrzcSZ0TFvTIPz20UTGdOQ52Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJag7iH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEF5C116D0;
	Thu,  8 Jan 2026 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892544;
	bh=yVN7kiv7Ur9Q7AnxVgFewkb0L/ZX8mnNajC6Hfb4ItY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SJag7iH3Ulhau+TT2S0OSUAXBwy5iFmcU6Lcje37qhWyUrVVIS0QTH2e5wxI2OWuV
	 uM0Dam7qLl6fl4teot25YDB/0LrIoV6VDVLM3R3t7DnQHbujCZPv6ddb9BKAedtSKV
	 t7+lntHNYOrLgAPao6XUgZGgqu8HjC4jex629eXoSfP4riBGPiL79zD76/2NIF5M+N
	 uX1qwg88WzADWZnJTDvKeIPDL1RrhDcY9+1Tyo7ILZF8wYpjcPUZbG8Kk/7gsRnW7M
	 UsjdAKxfEW+GG6kp5DFxc22CxtnZQjt0Ua7js1IxpNyLl6YAFmV6M9UkWWvJcPJkR3
	 TovnFOD6YpvAA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:11 -0500
Subject: [PATCH 16/24] orangefs: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-16-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yVN7kiv7Ur9Q7AnxVgFewkb0L/ZX8mnNajC6Hfb4ItY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W8gf6yTM9PqdgCO6Yh8PQSc1Poy4aktqHXE
 EqXCbQwiOyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 FRuXD/4oWPnRKMqdVVRPF71peTc836Dva171JxklgwmgsfBGNY9Coh6fglKyMqQ9V24XwbsVH7q
 SRxFfC/rZ6jRd8MVmFU4q1T864Bnzpra/VJ4veI4DPnrg77egeKX2Jx4mb0mba4rht+TFrkFCDK
 mhcPTMUj9KmWha9AOJ4147BC7Qf3qLGG9uxvqeIxHVjUN1BTNY7/BNqyZDjaygnRUIqJCWtjTOv
 YUN4eNnfRQLRKyfHAlMfbB/dlZgDLx7Q/W7Vou66JjuFzzyB17eRnChjoMC93Q44naBsb3lFX3K
 yvzZpsHh5/dCXj0hGaJ1QYi0Jg9b96rKOyntmvJpG9LPz7ciN3od6SzIH9dIvxov45RkSSGaEpy
 IuODOTTn6S41W6SKtB8fubBQCalo87arg2F+fCtLTgaMB0MsteZMBW4HgQnOFNQ9et5q4MSGTZ4
 gD/Xf6MItMTAI4y+k66u7nf3hJ5aYHRsVtsVqjfA2nWqduNGthfEsAjx0U/R/sxbYQXikUfsiOK
 2Q/74eTQIZa2aisqeUf91C+8I05nZsfE96suNoVb/cEL/V57lNG3stvWfm+owGEN3dovr8YFNqD
 lwM/fCzJuwDoCBqjnWCQ4bOIop1NH95s7W++pbtI3bHQhWhN7B3NYsK7YTHsRJOGC1ngl5pluTK
 +CL061T+fPDjdpw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to orangefs_file_operations and
orangefs_dir_operations, pointing to generic_setlease.	A future patch
will change the default behavior to reject lease attempts with -EINVAL
when there is no setlease file operation defined. Add generic_setlease
to retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/orangefs/dir.c  | 4 +++-
 fs/orangefs/file.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
index 6d1fbeca9d8172a2155f5b524cd19bc896748d64..3c32bf9f1296e5eb62a7a603faaf4a5493c57166 100644
--- a/fs/orangefs/dir.c
+++ b/fs/orangefs/dir.c
@@ -3,6 +3,7 @@
  * Copyright 2017 Omnibond Systems, L.L.C.
  */
 
+#include <linux/filelock.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -392,5 +393,6 @@ const struct file_operations orangefs_dir_operations = {
 	.read = generic_read_dir,
 	.iterate_shared = orangefs_dir_iterate,
 	.open = orangefs_dir_open,
-	.release = orangefs_dir_release
+	.release = orangefs_dir_release,
+	.setlease = generic_setlease,
 };
diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 919f99b16834160dd8cc87faf9b8802aa02796cf..afd610a3fc68855eba1c892d91a5c0686876cfc3 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -583,4 +583,5 @@ const struct file_operations orangefs_file_operations = {
 	.flush		= orangefs_flush,
 	.release	= orangefs_file_release,
 	.fsync		= orangefs_fsync,
+	.setlease	= generic_setlease,
 };

-- 
2.52.0


