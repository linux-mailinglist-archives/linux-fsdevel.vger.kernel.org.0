Return-Path: <linux-fsdevel+bounces-73965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F46D27A37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBBD33B7929
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D633D5DA5;
	Thu, 15 Jan 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDsmjGIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931DB3BF2EA;
	Thu, 15 Jan 2026 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499355; cv=none; b=e0XkriH+yUOFZ5aeN/g4JbmCAI2kDlGHrZibh4CbgNtNWyWjOEgOa/jVV8n5HJJnaR45J0UIV5e6dLXNtdvw4YxZSUP5GHQmZPqjmQ8XUyXEjXAQm64po6PTbOG44L1L9wbQuc7/d+x6Xjghh0O8gPJzomnreUtwCAiBEwPEFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499355; c=relaxed/simple;
	bh=ttUZbbEr4qNvBmzcmWXht/0+Ro1g2UQElLV80PGUEuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W40olw2CBujvO83jNnfNi2SVaGkwesYseIi0hpRmK4SAv0RuOXrX2rExvsoCd1A6Jdo7ynKPMO9lnckeMMBMuGnTXjP8Hd39Ki3be4ApCbBoHeAbs0nUFHYvi89N5zDP4R7A7NxE2W+Nuu42p2Tv4RgAxpXmBErq1H8nB0wwNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDsmjGIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9B9C19423;
	Thu, 15 Jan 2026 17:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499355;
	bh=ttUZbbEr4qNvBmzcmWXht/0+Ro1g2UQElLV80PGUEuE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mDsmjGInXlxUuWrIRrwv5qZQIPlIgwVPfetY5f6z1Occkjrpc3fmt3P3+9xz/ygv5
	 2VfiWGSAHJiML0wE2XpjwiAoZh5JRHcQkW9nveDZvznbd9EFKdttqjkG9YMgGwPrq+
	 PoPKFWCJaCUDUeAtEPELAfNcvWqDJpXekdN0m6t1B1tBOmUbf1l2FPA/pGsDT1qacq
	 TCYMr2c/174ubIgDQ6lN2+7dAM2cYmP/VVGNWJgmk+LQIlVDOPnvmigPMbnwRm6bYj
	 A2aIx6YB7e4mVQjVXaE6WhGbiAOAqKdDIvpfXGwCIV/XYpJIWDH3uy9nHt0CQqDuqa
	 0XnNid1EB16xw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:42 -0500
Subject: [PATCH 11/29] ufs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-11-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ttUZbbEr4qNvBmzcmWXht/0+Ro1g2UQElLV80PGUEuE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShGDwr1sR2otFzq83UWoMQWbDlnYFlhI0cDH
 jWAJRbmq5WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 FZ1ED/46txz5ghIDvc3tR9xaLWo0GlwjYOwsC8m/aAkCADdaEu7da6Oy3D1vM6G2uDHmyabUcOx
 Tdu6BBafUm6ZljC9Exy+OuCvzYJQD9vaiTjprh9kniOU/PxPWTvaUt2VCuNf9SErwzt5728aucJ
 GSNLbDfJN4CbSWtP2bkREs2OrMDgS5Vqho86OgC4Zihzy3QZxeFVBcaAWsruB3qVXWCQHHLj/92
 gS2skgvBG2CxpzZhOyDEJk8jDS5niq4sQ3yIKjxNMlU9c6WqhOw9ZpxVa+gPvx+QVKtlgoUbkaF
 0uK2kCJ20r0TinNvfWM5ix0pgm+Z/nBs/Y62N+shReZKoF6iEK9H5kdwE26GSNEOFgTrt9cWIMd
 8eW+rzCrGY15bvgH6sJ301mMmYI4ffAG90yYsOa71pH4tyyFcij424nC0cXTG6rrJoItJXDlfKL
 IUDkCPRqPzPCCcsfjpk2g06rZIEi8b+vLtaVCgNjscK4HKGvKf9tKauE3ri82pE4swdQlcCFEE/
 4n+jTB5wHzAvRu91i176uz07JhXIlc+yF7jnsVNYCsP7+CGpRNwba1BWSbPAEViu4R/+JdmS8L/
 +pr7mvJn3aZMp0bNqipqZlidXRqUrSGwZk4SnaPs9/ptz7M0sm8z+Stj+/BEWks/d1JjYHVXRWi
 RqD0WGhd5bhccaw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ufs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ufs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 6e4585169f94bb9652aac29a14b0a64a7bb710d8..9cd9b6691849d52701058973f6b684f101df2634 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -141,6 +141,7 @@ static const struct export_operations ufs_export_ops = {
 	.fh_to_dentry	= ufs_fh_to_dentry,
 	.fh_to_parent	= ufs_fh_to_parent,
 	.get_parent	= ufs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 #ifdef CONFIG_UFS_DEBUG

-- 
2.52.0


