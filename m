Return-Path: <linux-fsdevel+bounces-73953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57287D26FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C9332BE7BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2673C0092;
	Thu, 15 Jan 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv2wZs8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCE3BF2F6;
	Thu, 15 Jan 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499282; cv=none; b=LH8vQq7prCvD+4iih/TJR9/uUEZaH0rW97MRLW8iZM8BTRNHbNHNkQsI0HWUFlxSm+lP3t+mpKl1msd2yFfQfsJ96MerBwvsozic+cTOz4F+uhT7Fqk7HAnC/U8t93J2LtCr56yKkt7M0uDxIvn1m9kvEJb7ctySHqGN/MdelHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499282; c=relaxed/simple;
	bh=Jgrg+43s0ldgv37NKbEktTlLcn8JlZ4Z62/aDsJl2fE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CujYPFGutf/UKSzzB9mUg8xSAjsxk+hfR2VTrWMsOrY1IWpDdpjgpZEid4pkF5DXxUmxBjenSGlV7d97fBc/otdENxEaIuYjPrUqHYVmrmnk6dZsEaFyc5892YFXpC7UBbBx98oGimLga8BDcCxIxxKfYFlR8T4l9toyOStidIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv2wZs8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A44C16AAE;
	Thu, 15 Jan 2026 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499282;
	bh=Jgrg+43s0ldgv37NKbEktTlLcn8JlZ4Z62/aDsJl2fE=;
	h=From:Subject:Date:To:Cc:From;
	b=sv2wZs8WpKeI0wpddsdCzx5FPuJfiv0htyo+0abzJrCCFK9q4146ZE28BG441jorg
	 Qo1tIee7N/1MnShJaAey62z4lfLsmhIXMLkZMLSEMlmEhDwdr2qsSYaFrVZPxb77cF
	 i3aSCJl0gIo+M7JBkTxdAg7VvCpYnqzbG7R2Ohvdin1j12CbILNcI3w/DNWL7f9jbe
	 DBukUrRoDDoNluFnmhgrGDxPlIkvSUMcrjLUpjjJ1T7VqZOaz0YENa8tKyKu6CaX47
	 KOmCoEsEsYyGz5wli5gj5MnM7JWLaAPtkHWHG4sSZOBoGuAC5psY5ECRaP4FTl6A5n
	 5/8prxsy2NgBw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 00/29] fs: require filesystems to explicitly opt-in to nfsd
 export support
Date: Thu, 15 Jan 2026 12:47:31 -0500
Message-Id: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBMcyaKuEi0kx5qNhhMRiHdPW
 r7F/wWEMpPA0hXI9LBwig3Yd7CfLh6k2DeD0WbUiIOi90r5DqJiEK/QWLR6MjS7GVpzZQr8/r9
 1q/UDI1yMc18AAAA=
X-Change-ID: 20260114-exportfs-nfsd-12515072e9a9
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Jgrg+43s0ldgv37NKbEktTlLcn8JlZ4Z62/aDsJl2fE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaSg9V9dGf/ZUraP4b1Pq5RtyBLPKPHN6qkaxn
 8S9nULay2GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoPQAKCRAADmhBGVaC
 FU2HEACr1dom+IcUewiIOnk7xEbGWbqcKSzh/u8bfD7LubFnaY7GNt5n6p3PgjmIFAgE/Lfk2v+
 Do5G648LuI9AgNBffpq3Rou0EGw9+wxjXyRaSItdEWDshxbLnMS5D2dtmXeB4x2mF6Xo8wPho9c
 ncOUEwjZL61T/UOLGxpSOojluUsBXenixeUCTgPYWeDSKZSd1PrbfIIvNT3wwmmIpQAv0lasork
 Zl4qe+BiG1G0IPtketcJGFYIgXNp76Hnll+P8/EqVrDG+4nPn8MGAy3xqMQyq4+dCzENDy0DmS3
 AJMlGepQMU/y0tAmS4R1R2P27jpCMwpBj8HhdNo0JThYFgmCYeGwPxsTOTNG8XmrWn4zye1BAl9
 Oz/kXfQnSFwMzweZ9J7fT16IxYVpb12aXvYdwcnZ+IE/Suh66Nx8n52d4tuSwNkKYQf6d05G1bU
 I+lA7kAnXjIh/p4o4pNnALEld2Rn49OAx/yxtN5VOYrjpBIK6yRyYTXjz0PnCRFsn3V65+xhhPM
 CJTSVK9ZzU4nspmDSK5hdCvs1pnGqYR9dLF7QV60eUBpiDYnfsiOG+KZmrsLuWOd2/7/8V8giqf
 SBbuLOXJmeBQ1IbyaaZbzwsaK+7PAPY92+HTJ8jsZ6+vQhAXLJ40Y1ug6UAG1bGirhSbW+Ru3JH
 SgoO6jBDoISNHpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In recent years, a number of filesystems that can't present stable
filehandles have grown struct export_operations. They've mostly done
this for local use-cases (enabling open_by_handle_at() and the like).
Unfortunately, having export_operations is generally sufficient to make
a filesystem be considered exportable via nfsd, but that requires that
the server present stable filehandles.

This patchset declares a new EXPORT_OP_STABLE_HANDLES flag, adds it to
all of the filesystems that have stable filehandles, and then adds a
check in nfsd to ensure that that flag is set for any filesystem to
which it has been presented a handle. When a filesystem doesn't have
this flag, it will treat the filehandle as stale.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (29):
      exportfs: add new EXPORT_OP_STABLE_HANDLES flag
      tmpfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ext4: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ext2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      erofs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      efs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      xfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ceph: add EXPORT_OP_STABLE_HANDLES flag to export operations
      btrfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      befs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ufs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      udf: add EXPORT_OP_STABLE_HANDLES flag to export operations
      affs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      squashfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      smb/client: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ovl: add EXPORT_OP_STABLE_HANDLES flag to export operations
      orangefs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ocfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      ntfs3: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      jfs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      jffs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      isofs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      gfs2: add EXPORT_OP_STABLE_HANDLES flag to export operations
      fuse: add EXPORT_OP_STABLE_HANDLES flag to export operations
      fat: add EXPORT_OP_STABLE_HANDLES flag to export operations
      f2fs: add EXPORT_OP_STABLE_HANDLES flag to export operations
      nfsd: only allow filesystems that set EXPORT_OP_STABLE_HANDLES

 fs/affs/namei.c          |  1 +
 fs/befs/linuxvfs.c       |  1 +
 fs/btrfs/export.c        |  1 +
 fs/ceph/export.c         |  1 +
 fs/efs/super.c           |  1 +
 fs/erofs/super.c         |  1 +
 fs/ext2/super.c          |  1 +
 fs/ext4/super.c          |  1 +
 fs/f2fs/super.c          |  1 +
 fs/fat/nfs.c             |  2 ++
 fs/fuse/inode.c          |  2 ++
 fs/gfs2/export.c         |  1 +
 fs/isofs/export.c        |  1 +
 fs/jffs2/super.c         |  1 +
 fs/jfs/super.c           |  1 +
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/nfsfh.c          |  4 ++++
 fs/nilfs2/namei.c        |  1 +
 fs/ntfs3/super.c         |  1 +
 fs/ocfs2/export.c        |  1 +
 fs/orangefs/super.c      |  1 +
 fs/overlayfs/export.c    |  2 ++
 fs/smb/client/export.c   |  1 +
 fs/squashfs/export.c     |  3 ++-
 fs/udf/namei.c           |  1 +
 fs/ufs/super.c           |  1 +
 fs/xfs/xfs_export.c      |  1 +
 include/linux/exportfs.h | 16 +++++++++-------
 mm/shmem.c               |  1 +
 29 files changed, 45 insertions(+), 9 deletions(-)
---
base-commit: c537e12daeecaecdcd322c56a5f70659d2de7bde
change-id: 20260114-exportfs-nfsd-12515072e9a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


