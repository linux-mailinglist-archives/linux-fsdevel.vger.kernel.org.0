Return-Path: <linux-fsdevel+bounces-74465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C55D3B156
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 263F6304A51F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A831197E;
	Mon, 19 Jan 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f237MPyH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5E2E2840;
	Mon, 19 Jan 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840040; cv=none; b=dYfi+9s5Ccw6TCWHBNAnCG1A4ovGsNSVAQqM/D9M2ydPwUUtFxnG3/VjGh8tvlX1kugczm6seXyEPhGuvKOZcmm76ALU5Sg0WOmN4KPWdLD7dDIqC7urzfCk3s5HieVr7etZQgYSG4BHc4buvVekaiemM1oiT42NwadtZ4iH1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840040; c=relaxed/simple;
	bh=yX5wj9VHSThOjafnyKvHMJdYbGSk/5OP4p9PS/zazFw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TJAh5CTpPQmhAkpB8JOeS5jCD/qT0kXbo13BTe64YTdO1MhAAT1JcGocv01NbZEJ6T5H2PW8V3hz4fG17oPHFA/R7dGEfkgeTCZgUBUyxo00vrc9fORDEg9VG9HqoSghgk1B9wTbQDWFYlzaXxXfVikY532cpej8TJRghcSa/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f237MPyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BF7C116C6;
	Mon, 19 Jan 2026 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840040;
	bh=yX5wj9VHSThOjafnyKvHMJdYbGSk/5OP4p9PS/zazFw=;
	h=From:Subject:Date:To:Cc:From;
	b=f237MPyHkZbdY+WPcsLBi0kuGtUgJbV4HoKceS3Jz1Lmrv4gP0tgEIWx9faQo//X+
	 +UUjREu/69qFBMgdHch+q9bk9Ep8RKPHs/QzSabx4v5reJiL9v0kEdJGMeWqOPK39A
	 0jSEKULtL05hYKWy8N1WS+HOt5YyvBcESAtJ0ZmYc6dhEbBinazAzj9QJSGklzZ9p9
	 LbTYD833qVCL0hCJmQS+SihR6ziWecIunpgB2VxOhgkmSC9roap7mrwb5zOJntllqQ
	 se8GRkweMjAwYRoYx2aL3RsVvvEMBUqvD1Pqmz58J3HWTOMdRGmvio/OwXlAFPl4n+
	 HkGliBF8cqqKg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 00/31] fs: require filesystems to explicitly opt-in to
 nfsd export support
Date: Mon, 19 Jan 2026 11:26:17 -0500
Message-Id: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQqDMBCF4avIrJsykzZWXfUexYXEUUNLIhMJF
 vHuTYVuuvwfvG+DyOI4QlNsIJxcdMHn0KcC7NT5kZXrc4NGXSLRVfE6B1mGqPwQe0XakMGb5rq
 rIX9m4cGth/doc08uLkHeB5/ou/4k8yclUqgqrpBK5ItFe3+yeH6dg4zQ7vv+ATyiSsWrAAAA
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
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
 Dave Kleikamp <dave.kleikamp@oracle.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5453; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yX5wj9VHSThOjafnyKvHMJdYbGSk/5OP4p9PS/zazFw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltSzbGzajTJvmhlV7jB47UePrPRdt3Wu5GHL
 L1B0sA8PKeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bUgAKCRAADmhBGVaC
 FXY4D/42rFsMWqLxlGJh5AWMBxSb1l17atmfl6mxPzMfAPokDVOiTK0fNOZalTR4OcT31QZxTed
 nkOmw7Qd+RTSm3dThDf1+et1RhMguer4Bj1ll4VmaZ/poVmu4fIUqbDcyU54UE4F3/M+fsmJXJF
 3s1+tqIyC+7WzF6/x/HWQY9RkQLGkUqkteSCoXdzEDc+WnhRgXntOXZFP/HpDfxG/pkaHnd+RBz
 4lFdhCAZ/xSuv67OWqva7ifRVDMiF1E1jM7uLNP2SeE/hd0wYNuORHvkzf0PBL9T0k2Xtf89p3W
 re4QkZpVZiycpFTZTWt04k1pqWuWK0n8tjfz/V3hdvnGOrpI230p/dDpXhnTN9sdFWylM4U9ya4
 qshCtu+DBJBGHEinp1+ZpE1k5xl1aig3/uN9f7VhUaZWww3qx9qr4g5LvGXfxxoxzZ9wBjiF9KO
 N6VxYj2loIjuU0+56wmYIb9mvXWeQ3O5IJtU9xTAV91iUxWYiRU9dcBVDvwk0wF6sm/fKmizn3g
 YPMFjbuTpkp5VsApqvODwDyEo97gF8luB/qvkGPpxV0AKc1MyfjvFpPOyECG1xpqAW1/f4Iph0F
 ju2zuNnVWaPFBf5KCowY4rq8s1kCTJxt/dnIpOlxVJ6FNlp9OpxryB048OYYuKuRfAwjC8gjHz+
 qu3QGNImWfKzpxQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This patchset adds a flag that indicates whether the filesystem supports
stable filehandles (i.e. that they don't change over the life of the
file). It then makes any filesystem that doesn't set that flag
ineligible for nfsd export.

The main only place I found where this was an issue today is cgroupfs,
which sane people don't export anyway. So, I don't see this as
addressing a major problem that we have today. Rather, this patchset
ensures that new filesystems that are added in the future make export
eligibility via nfsd a deliberate step, rather than something they've
inadvertently enabled just by adding filehandle support.

After some lively bikeshedding on v1, I think the consensus is to stick
with EXPORT_OP_STABLE_HANDLES as the flag name. Amir is correct that
checking this in check_export() is the better place to do this, since
the filehandle can't be decoded without resolving the export first.

There are a few other fixes and cleanups, and some doc updates too.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- don't set flag in ovl_export_fid_operations or fuse_export_fid_operations
- check for flag in check_export() instead of __fh_verify()
- document missing flags in exporting.rst
- convert dprintk() messages in check_export() to static tracepoints
- Link to v1: https://lore.kernel.org/r/20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org

---
Jeff Layton (31):
      Documentation: document EXPORT_OP_NOLOCKS
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
      nfsd: convert dprintks in check_export() to tracepoints

 Documentation/filesystems/nfs/exporting.rst | 13 ++++++++
 fs/affs/namei.c                             |  1 +
 fs/befs/linuxvfs.c                          |  1 +
 fs/btrfs/export.c                           |  1 +
 fs/ceph/export.c                            |  1 +
 fs/efs/super.c                              |  1 +
 fs/erofs/super.c                            |  1 +
 fs/ext2/super.c                             |  1 +
 fs/ext4/super.c                             |  1 +
 fs/f2fs/super.c                             |  1 +
 fs/fat/nfs.c                                |  2 ++
 fs/fuse/inode.c                             |  1 +
 fs/gfs2/export.c                            |  1 +
 fs/isofs/export.c                           |  1 +
 fs/jffs2/super.c                            |  1 +
 fs/jfs/super.c                              |  1 +
 fs/nfs/export.c                             |  3 +-
 fs/nfsd/export.c                            | 24 ++++++++-----
 fs/nfsd/trace.h                             | 52 +++++++++++++++++++++++++++++
 fs/nilfs2/namei.c                           |  1 +
 fs/ntfs3/super.c                            |  1 +
 fs/ocfs2/export.c                           |  1 +
 fs/orangefs/super.c                         |  1 +
 fs/overlayfs/export.c                       |  1 +
 fs/smb/client/export.c                      |  1 +
 fs/squashfs/export.c                        |  3 +-
 fs/udf/namei.c                              |  1 +
 fs/ufs/super.c                              |  1 +
 fs/xfs/xfs_export.c                         |  1 +
 include/linux/exportfs.h                    | 16 +++++----
 mm/shmem.c                                  |  1 +
 31 files changed, 120 insertions(+), 17 deletions(-)
---
base-commit: c537e12daeecaecdcd322c56a5f70659d2de7bde
change-id: 20260114-exportfs-nfsd-12515072e9a9

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


