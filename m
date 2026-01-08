Return-Path: <linux-fsdevel+bounces-72884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7305D054B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB47340306D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DD28C037;
	Thu,  8 Jan 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMLaSOnD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE612C08A1;
	Thu,  8 Jan 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892422; cv=none; b=DzUBiaOkvm1QTwbOsgCYpICHzzuvnFWw6Jux3Et9b0hQ1f+o1DqCHfoEoDUJHB4estBi97w0JyKgBfYj1cE1D/iE7YouSxhvfwRu4wPW+qP/twO3wG4wfUQrkQFB7cl2OO79zgnNloagnmdEn2jOYaZ4U38eCjyoegFt7kM9f8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892422; c=relaxed/simple;
	bh=Oo05LcV8B4ObeCq3rrJEiTXLheQXnmVPy6EWKbJpWYY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QJazV/oIYNbxi0F3Op9jF+0GoVWN1yJMYQE1t0lZ7HMY5wqOxjfOcFcGUe8+FnGo3mZ43NHfuPGOXsdaUI7YYKO3NoWhcZ084oc8o8bQYdJ+BEd7uN6iUglVsIoaWC9/dkNGHNDC57HNBJI2oY7tFlhls/PxbfOFcYeBLNqhY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMLaSOnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2D4C116C6;
	Thu,  8 Jan 2026 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892422;
	bh=Oo05LcV8B4ObeCq3rrJEiTXLheQXnmVPy6EWKbJpWYY=;
	h=From:Subject:Date:To:Cc:From;
	b=sMLaSOnD+Lb34DqAv4+l1KIbr+z8ayCyntGOlgw1db2MmJQhOdIkWIrWeRcdIdKWS
	 S/zZ1aldQOEJt+M4gNNpgwr8njA+kY57ueYyzw69x62DB2y8ZdsNP0n7O2v8cGXFpi
	 Rqu92gjEkqK5VGOhWZChnPJ4VjzfqdTkQ5Pb550IY/fptv7JSzPczGvy4XqdhjJ5sA
	 l0a72cVjGZa+Jo45PjkXSM0qO0LbjExULNMK8lG/BaoQzQWxdDW9x19wy15yv5tDSd
	 cgmarBCaj12d1puK7fN4kFXY72IDiwfR7r7m0gQbOzLxetlMXGRug7hJ9c8PA8IU9d
	 DvLLUdQgizFew==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Date: Thu, 08 Jan 2026 12:12:55 -0500
Message-Id: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBRG4VfRXbs1pmY0XkUWgx+3hOZKSt7dZ
 PktznlIkQRKTfFQwiUq+5ZRlQUNS9xmsIzZZI31pjI1K84VUcGerWEbAnrngxtcpNwcCZPc/6/
 t3vcDWdlQRF8AAAA=
X-Change-ID: 20260107-setlease-6-20-299eb5695c5a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5826; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Oo05LcV8B4ObeCq3rrJEiTXLheQXnmVPy6EWKbJpWYY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+WzBv3HT+d1Fmmb4WJNh3VjXhmOx5cl7E+0X
 98Wl1lzspuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lswAKCRAADmhBGVaC
 FYaFD/49dAmx6k9hJ/TPfTiX5MGWuIm/Bb6hiQ3wYU8z7D5mM7bDA0JzI4uNC4IC4k7DtSaeW+t
 HW0GXcfmOc/2RNtvIURgrbNIKtr02nzAYWch3n94PXAZNhcygbpjjekIxTTpfmIp6Q3JR0VXmgj
 FPOGz1G9+W5jTp8JkJCS7rK3QI1nR+/TS195gfflVDsyGMEA252ZaGAWOXQucH8aMmL3SmL4Sw3
 SQIvSgZPcin8ppqmJM+SMqpJjims+KsIvBeiZ5RAX2koRTuCEpaimiM9mi7uvZTjn9qDUXstfCl
 j6vVSQyDrhB6qaSgIjGD31+J/UHY4GmSW7EXpo9hwYld6pajZ7JmgvQYyorZSADZQ1buPawi578
 2S+AKCmbogE/0eu1rDPfSf7+pgKL0PHCFCUHmNfl5kyVzMdQ5fEfhZa0HY103UgMpyn9CWEA426
 pzh9DY5Q7TVq+/Ml0m/iauvJ1NRfOvo1XZ6qodWqnFZEO7/lzreoUi45cpyDZzLiSQuca/VsCjV
 6m4pCflt/f0Ao2+yx3/gP9YDsugBwKA59y5BZvauge564wraKaWFFPDoPNSNY9aww3L7L1579eX
 mhWasindF/bS2ZuJ3k3obfEbzGrzZnRus+vFi5LvzlZIlOMMPaJ/pY9IJPoJjhxxacuSawLXV7W
 2iGXbdzTGfcW99w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Yesterday, I sent patches to fix how directory delegation support is
handled on filesystems where the should be disabled [1]. That set is
appropriate for v6.19. For v7.0, I want to make lease support be more
opt-in, rather than opt-out:

For historical reasons, when ->setlease() file_operation is set to NULL,
the default is to use the kernel-internal lease implementation. This
means that if you want to disable them, you need to explicitly set the
->setlease() file_operation to simple_nosetlease() or the equivalent.

This has caused a number of problems over the years as some filesystems
have inadvertantly allowed leases to be acquired simply by having left
it set to NULL. It would be better if filesystems had to opt-in to lease
support, particularly with the advent of directory delegations.

This series has sets the ->setlease() operation in a pile of existing
local filesystems to generic_setlease() and then changes
kernel_setlease() to return -EINVAL when the setlease() operation is not
set.

With this change, new filesystems will need to explicitly set the
->setlease() operations in order to provide lease and delegation
support.

I mainly focused on filesystems that are NFS exportable, since NFS and
SMB are the main users of file leases, and they tend to end up exporting
the same filesystem types. Let me know if I've missed any.

[1]: https://lore.kernel.org/linux-fsdevel/20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (24):
      fs: add setlease to generic_ro_fops and read-only filesystem directory operations
      affs: add setlease file operation
      btrfs: add setlease file operation
      erofs: add setlease file operation
      ext2: add setlease file operation
      ext4: add setlease file operation
      exfat: add setlease file operation
      f2fs: add setlease file operation
      fat: add setlease file operation
      gfs2: add a setlease file operation
      jffs2: add setlease file operation
      jfs: add setlease file operation
      nilfs2: add setlease file operation
      ntfs3: add setlease file operation
      ocfs2: add setlease file operation
      orangefs: add setlease file operation
      overlayfs: add setlease file operation
      squashfs: add setlease file operation
      tmpfs: add setlease file operation
      udf: add setlease file operation
      ufs: add setlease file operation
      xfs: add setlease file operation
      filelock: default to returning -EINVAL when ->setlease operation is NULL
      fs: remove simple_nosetlease()

 Documentation/filesystems/porting.rst |  9 +++++++++
 Documentation/filesystems/vfs.rst     |  9 ++++++---
 fs/9p/vfs_dir.c                       |  2 --
 fs/9p/vfs_file.c                      |  2 --
 fs/affs/dir.c                         |  2 ++
 fs/affs/file.c                        |  2 ++
 fs/befs/linuxvfs.c                    |  2 ++
 fs/btrfs/file.c                       |  2 ++
 fs/btrfs/inode.c                      |  2 ++
 fs/ceph/dir.c                         |  2 --
 fs/ceph/file.c                        |  1 -
 fs/cramfs/inode.c                     |  2 ++
 fs/efs/dir.c                          |  2 ++
 fs/erofs/data.c                       |  2 ++
 fs/erofs/dir.c                        |  2 ++
 fs/exfat/dir.c                        |  2 ++
 fs/exfat/file.c                       |  2 ++
 fs/ext2/dir.c                         |  2 ++
 fs/ext2/file.c                        |  2 ++
 fs/ext4/dir.c                         |  2 ++
 fs/ext4/file.c                        |  2 ++
 fs/f2fs/dir.c                         |  2 ++
 fs/f2fs/file.c                        |  2 ++
 fs/fat/dir.c                          |  2 ++
 fs/fat/file.c                         |  2 ++
 fs/freevxfs/vxfs_lookup.c             |  2 ++
 fs/fuse/dir.c                         |  1 -
 fs/gfs2/file.c                        |  3 +--
 fs/isofs/dir.c                        |  2 ++
 fs/jffs2/dir.c                        |  2 ++
 fs/jffs2/file.c                       |  2 ++
 fs/jfs/file.c                         |  2 ++
 fs/jfs/namei.c                        |  2 ++
 fs/libfs.c                            | 20 ++------------------
 fs/locks.c                            |  3 +--
 fs/nfs/dir.c                          |  1 -
 fs/nfs/file.c                         |  1 -
 fs/nilfs2/dir.c                       |  3 ++-
 fs/nilfs2/file.c                      |  2 ++
 fs/ntfs3/dir.c                        |  3 +++
 fs/ntfs3/file.c                       |  3 +++
 fs/ocfs2/file.c                       |  5 +++++
 fs/orangefs/dir.c                     |  4 +++-
 fs/orangefs/file.c                    |  1 +
 fs/overlayfs/file.c                   |  2 ++
 fs/overlayfs/readdir.c                |  2 ++
 fs/qnx4/dir.c                         |  2 ++
 fs/qnx6/dir.c                         |  2 ++
 fs/read_write.c                       |  2 ++
 fs/smb/client/cifsfs.c                |  1 -
 fs/squashfs/dir.c                     |  2 ++
 fs/squashfs/file.c                    |  4 +++-
 fs/udf/dir.c                          |  2 ++
 fs/udf/file.c                         |  2 ++
 fs/ufs/dir.c                          |  2 ++
 fs/ufs/file.c                         |  2 ++
 fs/vboxsf/dir.c                       |  1 -
 fs/vboxsf/file.c                      |  1 -
 fs/xfs/xfs_file.c                     |  3 +++
 include/linux/fs.h                    |  1 -
 mm/shmem.c                            |  2 ++
 61 files changed, 116 insertions(+), 42 deletions(-)
---
base-commit: 731ce71a6c8adb8b8f873643beacaeedc1564500
change-id: 20260107-setlease-6-20-299eb5695c5a

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


