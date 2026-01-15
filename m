Return-Path: <linux-fsdevel+bounces-73958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE7D26F10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032C531568BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3853D3013;
	Thu, 15 Jan 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me7Bh6Oz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFA3BFE36;
	Thu, 15 Jan 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499315; cv=none; b=b3qn+GxJoPG9rsxd33+Cckk+XtVNYCwrxG/XpCYG9Jxg7xnTSFZAI4bVES5fOKMIhsPOO2PVX/HSw2X304W9L2uWez9mw9Dfn3Ym60MS2h9oSaESxg8TYyIeO9/LlKHEk2EC+VKQBIUp9K/LJywrWoNXA7jsKp3FPwQeQiKqU20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499315; c=relaxed/simple;
	bh=fC2wTmyLrxw3hMRoJZcWwwZeJ07trZnOuWc2J0sqBYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPGzjHQ8fax2IL7VQ189oFdLQrfLvGwPP9kRHu04k4hP6MWIl7mu2YbMNp2SF1rHwciZfEGJvb5dCKha9fL15BvMrM9f+gVz60aTMtOqtfq6H16tHG+GFtRqRUiIDhGNRUzcqsy8w5xILi/3lNGCFbMIb8AF7jK/k7OeMYlp/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me7Bh6Oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BA3C116D0;
	Thu, 15 Jan 2026 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499315;
	bh=fC2wTmyLrxw3hMRoJZcWwwZeJ07trZnOuWc2J0sqBYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=me7Bh6Oz8yi3rtCvKE31NfEQV3586FDcB9subrRTMuet/g+LjUJ2eN0apKlzh3EHy
	 EZA5I8Cald4Pe5R7q40z0pYJ+IrgezPmzSAotRFzHaHcrQ/RdU/9zaOrAJWfq/d+gp
	 mvoRSdcMbzlJh3Ahip8TzNw4ZxybZ7JtzPKseJsi6FzB6BjxrHP8FHrjKtLFuf87Zv
	 Oxk3GdN3TnzFdcGrmP/M4IUNRiAQCbSXEmduK4aEsRDfNgoES95KukLgmQ7s0Qm/y+
	 GmmmovOi6oy5f6J55yNmRYBZmRkoRTn3DxKDX83Mu5yoFwszUj9Wep3F83P1yJbeR0
	 320NVCxUCVrgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:36 -0500
Subject: [PATCH 05/29] erofs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-5-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fC2wTmyLrxw3hMRoJZcWwwZeJ07trZnOuWc2J0sqBYo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShF9i2GSaSPlHSIuC7Yfec4kziAdHH6jdF9n
 v8rm53zuoCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRQAKCRAADmhBGVaC
 FcTGD/wISjKyKX0w/AhoM44k1zgySDfZixa6IbiGISyVcL25s2rWSy0ZGfZJayD/EPpD4m0zcui
 9Bgbta1ta+miyPZ9wOc4v+48+fiNjNvYr47ar/X0f0sQvet+DpTwskwHfwdQppxLgVjKVuMVdNy
 gck+0tCrIxsD4Oup77mdZf2ouvL7KYYRz32YuszzQr48OJ/qjKDCh+JnXb5KnsvwhuQim0CeRN8
 URkz7aAqGpXu/VOl1oUZ22AKHlAWuSrvTvkcTpncPKLu90Oca6NsDTIX/ON3orkHG4rOdzAGc/9
 RQqt9GmbiUBUdhpF5o1OL90v/ZnZPiG2su5SGPIaGIf5DQWHvpStMhLsuEPeCU3sWgdmjPqYwLC
 iXyRAONUm2KR+WThIgxBjqKyE34WHKpTr8RPwywaJZzzGZZPbKDj6psf6+b1i63wqY40oMyE1Ns
 hEZbql0rYeMGFxCjcVNDxzS3kqNDqGCfS+pC2ECWoCeEditYYF4yz/TOqROEqGtnToNPVyznKeY
 7c12ScEV9IdfwSl9r8CDZxKNpoWPnO4Pl/Rv769XSw/XhUxOLkUF1VqRwTv8Hy/Kz91OuWZ9X4Z
 Mez2MQAmmUG7Xr5Ozdu+dpiMok2IcUzuuuqbWxY+Qr0miQd21xwY3y60kPYiqSZKJ91tJpwnlhX
 ZAXGE9C+nE6tINQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to erofs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/erofs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5136cda5972a986dece863290d20ab103791cb98..7b43ad2dd3eada8c132b26f851394492dfe4bfe3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -608,6 +608,7 @@ static const struct export_operations erofs_export_ops = {
 	.fh_to_dentry = erofs_fh_to_dentry,
 	.fh_to_parent = erofs_fh_to_parent,
 	.get_parent = erofs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 static void erofs_set_sysfs_name(struct super_block *sb)

-- 
2.52.0


