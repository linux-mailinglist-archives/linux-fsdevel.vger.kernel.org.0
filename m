Return-Path: <linux-fsdevel+bounces-72904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8FED05758
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248D5358A021
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D7348896;
	Thu,  8 Jan 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QT6pxXNq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3F5347FC7;
	Thu,  8 Jan 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892574; cv=none; b=B4EB8B25yQb9p6EUH7+RwfTiIVICBb54e5aqO0ZD57t2dU6B2FFYthrfrYABVt5tSElVvbpE400hzQxI5b13SPOKad4br/gqsieLPL2xsdLywxm/GZigeq4a3xuPidG0s7WhXa+y/xnkVGMRpgW5fhDhbWQ5CeDWhcIuy23PF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892574; c=relaxed/simple;
	bh=Y8yfU7wo+bv5PqTWloVhm87suTQkWJClSnAp6Ng9lro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCcUiQxJmWg6/WPf+JA0GshgICuED2qN8tAH6k6WYkJ9blUunBBc+ZqFBa+oUMUzq506AF5XPO8fZgJMHr7mo1yvDxv8iy9tq+zRknmsPXBaSK3vnYYlXjybpiduNSM+zHKjXzIehK9qKUWs8f7ifWOY1geJvp2wn+oUgAH/0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QT6pxXNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AC8C116C6;
	Thu,  8 Jan 2026 17:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892574;
	bh=Y8yfU7wo+bv5PqTWloVhm87suTQkWJClSnAp6Ng9lro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QT6pxXNqWvJHyOYg3hWSLfGXpNN0ZmYoWCbIqcBphUyd5e/CKnj3QxGONTxUKwuLh
	 P3M2Uh4IZvhWRfKOoTxPrLO4Qx7aS6dq4lupB62wDtNubrlN+ZO/AM2anEhhuC/LiA
	 S4YtlhE8SwXKIBaCk5YKr35l7JVcPVqP3SnK55MIMbgE3snGMQiHN9IHE/qEQW2mo0
	 drWHgjds0lmogHJW2CzrSvDkWeDElNISjTrsR8B8Kf0Pdy91ehwsPMVflis8LB0Asy
	 mAfM3J8hVwvaGyuDduGwmO4K3TZqj900lAYy0IXWDvxWjCK1SPgzZfeTGmlxdw5SG0
	 XpmYYxN4lDfmg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:15 -0500
Subject: [PATCH 20/24] udf: add setlease file operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-20-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y8yfU7wo+bv5PqTWloVhm87suTQkWJClSnAp6Ng9lro=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W9JGoO8MdfrKDSQqEUZX9WyGOSmm4CgIgoa
 LF6x3PhMYKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvQAKCRAADmhBGVaC
 FT13D/9bGlCwWclg64l01L8s9AmtXvKCjKI2CNeCYh93PBL/4q2X15I6MepVsfrIiXAm1UZ7A+Q
 ourJq67Bakw7EJg/rFsi/5kCxPyQKJOPOEEkKT+5/Zh6R6BovLHz260Zxx4RIKCmnbb/4QSnkyH
 DuY4cIYZFF0M0RhUl9dSXFAl+ho1SBw08F4biLMI+9+yzoZJpf/umpEmSB2ZAKmjd6ayRPatsYz
 SBhFcri2L1TiccU5x1ATzJEUt8nyChJwODOsanWhj2wPmJUvHXqtLhH7TVCJL236zsy8LaFGjXQ
 VzUYt8iKaOR26/G4RAe8R8p1pOz8dN1zEgXv7GkPvxUyYxr1Rn6ER2LQ1LBS4M5SpYVOxxaYuVn
 kyb5VwVhTjjUVZHky+DmcXjzlcoAlGe3R85uJRRydiODVKOFwF0YCgJuWEgbVSc7bSa15xs0aht
 nTeuIOx86PQRWEDbW2u++Rx/wMRnfD8C1cR5ZgM/8vxwy5KnxSLU5UAXS0fLKhLeH6yEmWpSnCJ
 a2skVhzmf7KpcBfWbnnmPHq6nbBD2e/zWKp/6izVesZKMIoekFls1uNZ90RG1IevBfpyphcGstW
 UC/BOdxVN+ppwk4nv6DVG/ew8zcCZXdJCt1onUubHPB1L3r+xoX9WJNHsN7LsR7wdkIB5a/o5xr
 uloIyHIPHURUlkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation pointing to generic_setlease to the udf
file_operations structures. A future patch will change the default
behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/udf/dir.c  | 2 ++
 fs/udf/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index 5023dfe191e8088b78396997a8915bf383f7a2d2..5bf75638f3520ecb3a0a2ade2279ab56787ecd11 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -24,6 +24,7 @@
 
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
@@ -157,4 +158,5 @@ const struct file_operations udf_dir_operations = {
 	.iterate_shared		= udf_readdir,
 	.unlocked_ioctl		= udf_ioctl,
 	.fsync			= generic_file_fsync,
+	.setlease		= generic_setlease,
 };
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0d76c4f37b3e71ffe6a883a8d97a6c3038d2a01d..32ae7cfd72c549958b70824b449cf146f6750f44 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -28,6 +28,7 @@
 #include <linux/string.h> /* memset */
 #include <linux/capability.h>
 #include <linux/errno.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 
@@ -208,6 +209,7 @@ const struct file_operations udf_file_operations = {
 	.splice_read		= filemap_splice_read,
 	.splice_write		= iter_file_splice_write,
 	.llseek			= generic_file_llseek,
+	.setlease		= generic_setlease,
 };
 
 static int udf_setattr(struct mnt_idmap *idmap, struct dentry *dentry,

-- 
2.52.0


