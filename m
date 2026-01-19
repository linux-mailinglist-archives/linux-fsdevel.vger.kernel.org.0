Return-Path: <linux-fsdevel+bounces-74491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A52D3B208
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 118E431A1897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6E63AEF2E;
	Mon, 19 Jan 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW0qRezF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8E3AE707;
	Mon, 19 Jan 2026 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840219; cv=none; b=sdQ2Md65ekpltQz8D6pETwaDP2Tz8/MI7vNS5na0P2qSiCytr667auIruovGolW+XW9Fvuna71Y2y1hqa2BfcsKtdo98ASleWjAeiwx3gbovfsWUk3jDqL1wSaEH6fVZeRQXXoH4KRjd8RXATCXeB+dEDN2B94bidAMxZnvdgSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840219; c=relaxed/simple;
	bh=6tWMcuw4SXKKliFxuwUspWBYz3IXPKjAO64IS1gzwy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaGBKwvP8V1FIQFM5bWGNVhpTycD7FOYvcNh/R3Ls1Hr1sahdDBzqxyFPaxtpgdB3rT/8RIIkUQbLqnHryp4dbOeGireutHBSjYNjTBx/FPdhxkq1dG2BuA/P53aULIYKeBpWRCyXxiZl7La0koFgoMdUrTzjfwBQFsdEH6xMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW0qRezF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8EDC19424;
	Mon, 19 Jan 2026 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840219;
	bh=6tWMcuw4SXKKliFxuwUspWBYz3IXPKjAO64IS1gzwy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uW0qRezFzlerNDs8PuKGdJ441QJHOwe7SSO/QFQMzNVYXoOjiHcP//yxHRemE39qk
	 YwGPcQkEKt0Jg3XXVxeeWGLZOiZLMUNBT4M1H8Wy+FTFY5CwgHKCm5qxayW2GQmXmD
	 7vXoIKkqjyAzSevqKKCRd3RcIDgYuedYJ2ae2utlrBNPLHM5GNf6na/9xre//+UBol
	 i3xuRLUMWw2Y70PMjpIIXwQqmUp8t4Xt9ge+QmqWKHifKN3ikXmJKEvG71VgxRYeHp
	 zV+2Wqzblek8MtOUKv8VZSWgUhMcF88IV6nE4gWeU2mVJRx5J+IVMMOz2RNWeGIJj7
	 pMuB0z/K6YhWg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:42 -0500
Subject: [PATCH v2 25/31] isofs: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-25-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=735; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6tWMcuw4SXKKliFxuwUspWBYz3IXPKjAO64IS1gzwy8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltf9nl3RQPci4dHsMHCsM+umo8MjeqaXnesW
 HnO9Lsm4E2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXwAKCRAADmhBGVaC
 FReXD/wIPrLFtBRy7dk3dDTSyjTIH1yJqNgp9Y57L7fa5RL3gAQMGxKbzGjfF5DwWc35pqFfmu2
 H1PTOoCJC/fAYdmdr/3RlcvQHPDNxYIe2izXZY5L0jg02nus05q7iu3i3gsftQ3wI13cFWTyOxp
 SVoAc+i1h6QgfYXpqz4CtCpIGm3rhofWC61ioVAb/S0T7i/BLNDL5iydoVga6uGjhUaXrJO4Xjm
 47OuJ4NhcP/pg4uTpAjmYlQQ1c75RVYJ28CoECZqrqf9BPqdFBFXV2l609ny0NqluGTVypPG9MK
 fg/lfPdwNjBqfeCQHEeqlMPD8vRL2jskqfbGAZ0Erni/nJB41Z04M3U6vrsfy4XGrAC2X2gK/kw
 ExJ/dt/CBBv7a9uFqeA18YaCYtFR2LMOQLlwESdHjQxLunZb0f87fZp3KyAab5u9AI7aBfT+9dK
 1QD0+nfWTS7X4aInbGGhgrtSQMTQ3mTHoknCDwu53pNH1oNlIyazOIfLfBwI8tcoTBYqpuqoS9g
 xev6gXz3JYDe91SFY1cyMnOb8dZeEeRHTPAmhxXB3UnfKlLqNmafMSmelfv4Lw9RXmQRHBMB27F
 2ws5gpBEdy7haX4itXzRZmZah70fjOslHqzInfRoznnLOfY04dMlmNxBkr+5r+BZOfjT3UGyWNQ
 mAGdsC+47hLn5Qw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to isofs export operations to
indicate that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52301b778f0589b27fcf48f2372832..7c17eb4e030813d1d22456ccbfb005c6b6934500 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -190,4 +190,5 @@ const struct export_operations isofs_export_ops = {
 	.fh_to_dentry	= isofs_fh_to_dentry,
 	.fh_to_parent	= isofs_fh_to_parent,
 	.get_parent     = isofs_export_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


