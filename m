Return-Path: <linux-fsdevel+bounces-74493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA487D3B398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9CD931143E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2E3B8BDC;
	Mon, 19 Jan 2026 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+/nI7pA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7206B2EFD86;
	Mon, 19 Jan 2026 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840234; cv=none; b=LR+Hmi10RFimZkWL5cjCdYUtanVkbGSYsd2BuYtEUAfP46TbBKryep2lbvNADEqdtHC1yXFb2Llz8izo81qTyiGIIDqRMU4Hzl3K14sh6/zlNggNUCecn7CUBguf/s26JGTiuHvbS+8t3xprt4YoPFrEa+Rr2c56FJHv3YqjhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840234; c=relaxed/simple;
	bh=tb2VPLHr94Dp22tk5fzRHLdxd/4iteNlVo/o/3ilPx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfynoIHVMbp6lp12qsjZwpv4MoFN6O03dxNkrS7HV31Fvqi2211OsnoHzxkVo2QwlXosEGbfON5gRvfEZfA3DDDFT4SNjG+3kZ+Wv2PLdlLMsuFUMx1jwIMrijaZkQi1IpTPiEm0eDgwCBije4za02iRPwCDHr4tBCQCiRmT8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+/nI7pA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22817C19425;
	Mon, 19 Jan 2026 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840234;
	bh=tb2VPLHr94Dp22tk5fzRHLdxd/4iteNlVo/o/3ilPx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N+/nI7pA5qB+2Wz8qmSRVw4ZurFxnPM9ckLYAe+J8efO1KKkatPx0ewmIZNlxvWXb
	 ehSxxq977A1EuK8KJylqhf1esVoZqPGBZhoZJcBoA3mqYaLaW9B30srSQpH9hhu8Hp
	 PhKT/itkrIVlWPv18zFYArEJrHAxv5Hh5hdum9w4ASu2Koqkh2R0ETKB9RjvkwvnHe
	 ZsPzKT3ukVUd5DpTIIKnZ/kWFchLil9blOQXOgHLTeyPwYzf/prSDarZt0MgmoTCQ3
	 1WFKnzQCCnQHor68WzbSce1iBiR3KYVLHyBpGf+FocFkapRxQcbWCo7gewPvNqKVbB
	 RYKYSblZfnPuw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:44 -0500
Subject: [PATCH v2 27/31] fuse: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-27-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=tb2VPLHr94Dp22tk5fzRHLdxd/4iteNlVo/o/3ilPx4=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGluW1/IaPfueYIufakRk1Wy7VajFvE5Mi0rJeiI8SyJNibea
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpbltfAAoJEAAOaEEZVoIV1NgP/3Hx
 4TQHJF/6t36D5pyiFxAckKtnLQWuKxq4WEPD5FlhEh6Ptylt+qeF3wJM2gvcXH2VxwirFBR8cjd
 6bOvlXOHQH+nhfO1lRSkytQlbq6UxY0vPkg30u3xphifyBZ5UaEOu9j18/mTiVDYtgOjthfRJMZ
 ixd2vn9fIZvVGyjLubw8BKozpjyEV42epDShz263DxizQ9ckGpQvOd/lNNLM00tT+zhK1rYHDRN
 uAqizwREj9nMJnsCwEzqbAGURMWTq7KKRWlVJSAU7NcmZsCO06+eW6E00PRDYFP+SqsG2ALbkZ3
 0rdBMRTbkJnt8WWL6dwrqSZnGFnkJhVeyMXXqHaieZau2yPGuevBcMUnHmJfUAcZMZLK02tC4KZ
 BfRCYFjEorMqchCziN1COr5DxREd6c09F5IYSy8V6aRDl+OIhwzO/BVZegkxZI9XsUmExpocSoE
 D8kpU2BZ3GGA+GD6NuzTDTyzE3kbEB+2rbIMCT29YSv69mYy8L9D3tCmVEVSKG1D/amCfPatX/s
 xYwgFAsXGOSnsGGzgCLoU4p/mXsV2cdq0yj5uYa+h3U2/yQIu3OEeNDdsXCTSZJ4XzcSdg8wM36
 DVfZqz28XNdL0SYvbvvCiuQShuu9bYTFT639GxoqXNPIKhIKveBMs+6uqXLUqbbYBYUdDy1RDVd
 kClwI
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d666224a6201cfc7f450e0bd37bfe32810..df92414e903b200fedb9dc777b913dae1e2d0741 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1215,6 +1215,7 @@ static const struct export_operations fuse_export_operations = {
 	.fh_to_parent	= fuse_fh_to_parent,
 	.encode_fh	= fuse_encode_fh,
 	.get_parent	= fuse_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static const struct super_operations fuse_super_operations = {

-- 
2.52.0


