Return-Path: <linux-fsdevel+bounces-73973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 482BDD27241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B083114CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581FC3D7D36;
	Thu, 15 Jan 2026 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgcU8VF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145A3BFE25;
	Thu, 15 Jan 2026 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499401; cv=none; b=RvLrgO6PJa1kDIAsHkpZ2jprQd3s9WjGcQLWQDG2rRBK/k3IJpvomWaSUVE/a2CE1dC12xIzu3+3WVOydNchab7Id+lTzQQzhtQWVUWX63MHKotR3iHS/ay3qLBlG5KfEgMuDKmCk3TpA7cUIRg+eUvjmKuHvAlnfp6ZMvNQVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499401; c=relaxed/simple;
	bh=uwDrVoHbpPoBcmo/v3dHeiBewkzxqNNqtxlZm2e4dt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvELz6Ssmu/FoxM/taMeF03vn8Pcxr4NkIcm2+Q4SQoY2jxvJsec+bOU5+EaZMIcYAWhTl7M+Ojvtep4iVirmsRrQU1ASHzdAhw31J8myOBspma14yLePdyF73CSL2nIb5HIl8i3+q/rBlDc4bNyFUaFqb0T5QUZMsOaZa8r3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgcU8VF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D67C116D0;
	Thu, 15 Jan 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499401;
	bh=uwDrVoHbpPoBcmo/v3dHeiBewkzxqNNqtxlZm2e4dt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BgcU8VF4uU9VNdxjCqNfjET7gHGx/VAo0oeIqeLRdIsgPaTT6ct03dx2jrDd7o8BI
	 CCshVV1E208sOr9o2PH7/g+JfxDpXY9eZDUibvIq8pvFscodjQuSN8RWQxruSKXoI/
	 hgW78nAy8K5x9VS3/1/p3O1mrvpBnt2hfAlVpoyRe05AcB2r1c5qou3xP7ajy88NQs
	 ZIX0etbtDG0jg8MtYwH8eYXxe6RowC6CHSQkZ4tfMrgVWi0rtt4KD4G7v8NmX1SKpf
	 +ycIqXRbQcG6Cw7cOfPPhmE0wJkxag2JDFt9f2GH6540kL2VxJ2UyVpvitSiIDeIFm
	 tgS/jf+s8G1Vw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:49 -0500
Subject: [PATCH 18/29] ocfs2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-18-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uwDrVoHbpPoBcmo/v3dHeiBewkzxqNNqtxlZm2e4dt8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShITPD+RPkPMEpLXnnFoYUrWRBnV+i6/7ZXb
 2Cib6qgPF+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 Fc4lEACr6zvbp8mwIEyJqUBPypx0CbTv1b+btQfVmrA6CGpz6NlXnPBXu74SWbwJx78R9naDxSo
 4ujJV+JxC2vsZN3gMSbSryefeh8vZFixmZ9GKrLwy2JF+yR5MDnrhDIYFhoust1m/CpIYwTQLrN
 +OA58sbRtyhvTPNH4lrppknmtdvvnrgcMCc67prQQoAY7Kj3scJ/0f2hABl2MSEXjYjQGBAv58E
 h+6QcX9C2XIItQt7JJmt4EDshWg5v1sWm/f2qRitZE0LWnzNgY2OuGNuCDhWXzEDfCsTzUrlI4W
 mzdzEglnrL8uYAbYYwi0B7c/Lq/vHAOXHlJ16H0MzyYhPCFrt8PeDXExqTc5bRkzyIwecnQqV93
 ckgmq1M8drIiGpvkwBXihOVHAgYI/F9dJ22BRkXcTJKuCe1hEcqQiMrpjMU9l4o7EZv8tiR4Jmh
 aru/nnZVOrSyeFUiQLuQ+mpI1QKdrp5nuLV/2yhOXcHpv9wIYritLVYCn6uu+2yhjSywg34K9lK
 Y6+l5UAQpaFC8ea/mQaaeZYFDFhliHr8y3hTzrVvm0bl6YExJefRbNT3UPxPyRcGgQH+bVzthA7
 BLgRv7GlM/YDGxkyl7UNZlKjzauOn/nQxU6EqVlzLfm7Lt2s/99ujhx6ajeRupcwTat4e/vkE+b
 NnihSUwg08h5YFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ocfs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ocfs2/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index b95724b767e150e991ae4b8ea5d0505c1ae95984..77d82ff994c86037c14fbf7a1d9706f1dd2b87ac 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -280,4 +280,5 @@ const struct export_operations ocfs2_export_ops = {
 	.fh_to_dentry	= ocfs2_fh_to_dentry,
 	.fh_to_parent	= ocfs2_fh_to_parent,
 	.get_parent	= ocfs2_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


