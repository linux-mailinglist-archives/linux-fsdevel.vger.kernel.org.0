Return-Path: <linux-fsdevel+bounces-74496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E01D3B283
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D17FB30BF95E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548B3BF31C;
	Mon, 19 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRe9D5Sa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1838BDB5;
	Mon, 19 Jan 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840255; cv=none; b=e/u9My1BwlNZm/vT0ArGqfBfORhSvs1GJRpw/R10mEqqevcEFxwRR4Sp+s2Z6Izk8VsustkbBIDtTvclFCyTTgMKTzk5OHLFHfEPuCUHIDDhX7X8k9yXyWQXvg7MeWrtUqh1F4S7RS1U5qhdjAumyfgnUVuSU1i9Znplz6Y0v4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840255; c=relaxed/simple;
	bh=XGt/aZzfGK9zJQOZBzNGqpMmieKmh9kJIK51xGoE3lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISDaS1F/4LjM77pWoo8P7QmTwu6juI847v1KFKZ1DJJWI/KOakb2VwNQE5JWhcEHF7hVhVRLst99ZBtOldOJag0bzeC2PvGEu7+Sfjl2c4qft/afGy3aekKwpSU5JYXOh8EReD/wfk9+uVRSTLCubGWqo38gwwgtV8xOqTJZkvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRe9D5Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71889C116C6;
	Mon, 19 Jan 2026 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840255;
	bh=XGt/aZzfGK9zJQOZBzNGqpMmieKmh9kJIK51xGoE3lw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aRe9D5Sa7gMB/Ryp1GcMwBIJ0XwKuZ6UClP6Ug45QHAha8tYj9mJ1V510E+A9msBF
	 uIhFQ4ERVA2/a/89lazW/TqRbLmJXCbnATean6EIJEuIz/669usXdDh3OAv3cCVNyN
	 153NxFJ5bXU00TkkzzXLWoUrW/pQLk9vKivAvy3EIK99PwQxTlxQfnsqWQCzOs4xkV
	 djsQKErslPGQtEcNguvZIqh3BSoWwOetopyqoeBHApuQa2uwYZV8JERw+NxlC0nR0n
	 fOEHc48tTPF5j3kPLorwmV32bUWcgE0EFzjrgIlJjLHAtcT1r/8PEQ677OthtO1AHK
	 xGnYGFr1AXgiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:47 -0500
Subject: [PATCH v2 30/31] nfsd: only allow filesystems that set
 EXPORT_OP_STABLE_HANDLES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-30-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XGt/aZzfGK9zJQOZBzNGqpMmieKmh9kJIK51xGoE3lw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltg313cW2t8STVH2Q3f6eFFX8webaAfx8DOM
 GA1WXTggo+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bYAAKCRAADmhBGVaC
 Fd/6D/9j/oMVrJxeP2Mfuffs6X+mbihS90psuLoEJKbrjqZA7FdFGxRNUgHxspeg1JxUtDbEv7a
 uU4kSCajVCH2iOyDZQHDvyYwkkXW1+PdbM5uKZ/7DFLmaIxhriGPZjNE6IzpuJN48O73ngtU1bb
 P2CJLYNkWnxIJsMzVQaL4bwkbCVO8za/peoBtCgsO+8VOphfgjUEt0WDcgBxDOZdExrFOuNZlkA
 yVOd7lxKLAhNKynWzgdAd5sKikhudMp/54M1K2PccQWIGPdcv4xFGVS3GiU/csV9NzJSKjvCtjJ
 /K1MhVCHGVNaobSkaid3Tly/fXK4uha201p7DIspoVEewSSSXnhx5x0x3aBwwrld/gCO/BQlsYK
 5rZ2YOFFh/4TRhu7Gv3uRLHaXPpBIvj1iq70FX22A77FNzSrDm4qhCKISIaOPMyLDSI+t5ru9TZ
 j58AKvcl13B3sxdRak3OQWP4MHJncRuHJGlvXrEQaBf/aD6jxo0U6J/EdF0tJYPIILxRvkYndIB
 QsuTvSgf109v+B3Im9IKplrYJZ1er53jnSi8MzCOscRy3zHvch/igrvKIj0Mqnwjj/FRsnpuadV
 MVNdABzxnuvzbDIRfClDT3ehoVXweeSMvlteptmwg0EHO/sEA5XJWFSZvKdtodlu7Pj5Cn4Pepu
 OBCy4/+aVtv9EqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Some filesystems have grown export operations in order to provide
filehandles for local usage. Some of these filesystems are unsuitable
for use with nfsd, since their filehandles are not stable across
reboots.

In check_export(), check whether EXPORT_OP_STABLE_HANDLES is set
and return -EINVAL if it isn't.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 2a1499f2ad196a6033787260881e451146283bdc..bc703cf58bfa210c7c57d49f22f15bc10d7cfc91 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -422,13 +422,15 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 	if (*flags & NFSEXP_V4ROOT)
 		*flags |= NFSEXP_READONLY;
 
-	/* There are two requirements on a filesystem to be exportable.
-	 * 1:  We must be able to identify the filesystem from a number.
+	/* There are four requirements on a filesystem to be exportable:
+	 * 1: We must be able to identify the filesystem from a number.
 	 *       either a device number (so FS_REQUIRES_DEV needed)
 	 *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
-	 * 2:  We must be able to find an inode from a filehandle.
+	 * 2: We must be able to find an inode from a filehandle.
 	 *       This means that s_export_op must be set.
-	 * 3: We must not currently be on an idmapped mount.
+	 * 3: It must provide stable filehandles.
+	 *       This means that EXPORT_OP_STABLE_HANDLES is set
+	 * 4: We must not currently be on an idmapped mount.
 	 */
 	if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
 	    !(*flags & NFSEXP_FSID) &&
@@ -442,6 +444,11 @@ static int check_export(const struct path *path, int *flags, unsigned char *uuid
 		return -EINVAL;
 	}
 
+	if (!(inode->i_sb->s_export_op->flags & EXPORT_OP_STABLE_HANDLES)) {
+		dprintk("%s: fs does not provide stable filehandles!\n", __func__);
+		return -EINVAL;
+	}
+
 	if (is_idmapped_mnt(path->mnt)) {
 		dprintk("exp_export: export of idmapped mounts not yet supported.\n");
 		return -EINVAL;

-- 
2.52.0


