Return-Path: <linux-fsdevel+bounces-73968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA111D27139
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 813D130A13E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7E3D6481;
	Thu, 15 Jan 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrC6gPMN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AAD3D1CA1;
	Thu, 15 Jan 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499368; cv=none; b=GO7kAQfCfyDTSUy5CXknfFhVQcHzkL2f3A/CC1atOfdqIEfhLb9hUX7FpHhrm29TH9lvhwUnTJqzC/0v6WTdsjXhn1WhV4ucpvBXxZn4xU5pGegTEU+Dx1DZYAakOP9h0Vxyi8p+PHDuF3HGvYoSO2TJ2Jp1V7oTfxNx26ziWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499368; c=relaxed/simple;
	bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCg4TByoruZI+/DDRaawGNSzBnzMQwvuiLYhtnaz9MXNgRMRznOu4F5XqGhnNrWo2pnYAhFve1frcYUVPRlZyH23mwopvx+WoVJst4laHKbdN7kYroU8Zk8JdKccTT+g9iDoOTL0Pj1n84rOrq+z6wD2kuzk6QRQ1HlZUVx+RpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrC6gPMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C14C19425;
	Thu, 15 Jan 2026 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499368;
	bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WrC6gPMNbrPphwr9B2OdMVMQWD3w6Mv/nOHw1pbDBE9bxWiXfLBlumR/OK5kPYvhN
	 apkCGc+VCRQbuTwUzoMWQokSRmciqLfDU1cKQaB0vDgFmguXC/lEKFQuA1jBtQO1aF
	 nY3Vqv/eIQMRVKyVDelnHsTtCA/b3gjlScr6ZDHjRk3uLay+tzhSV4lLC/9YEnS5PX
	 mOoXSwKkjcNHnMBAWgQ1xuVpR4uWZcftB/FcM9PxN63hPvsYuMkuUDkxoOxaS/5EE3
	 hJFC4jBF3M1DIGPw7w+cQqHCLPWAeseUgepLBm2x4n/2+78QiklR79Cs3+JFj4Ixb/
	 cC6zieYF97tJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:44 -0500
Subject: [PATCH 13/29] affs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-13-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eujLaXiTUgNyjxHmQdWX3y0IvgSLWTxRgF6WqDofLiM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHf9xsknLmtYtQUrLBjji8uf4+uPYffbqfL
 wgOw9E+mmaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FXbXEAC0895+UA8PrkFaOQufVJ/wApB6ITexKHprwSNunNO41jBbrtLkZkJ2sv0koCiZt90R2ZK
 lDcmy1jDGxHDAoeS+2s/+Dj1hyXFroy/xyIvQgDKnouziNx5qID1fnGi5BUM0th5keSDytGUuc2
 t1IfxlsMKP9kq9+tOQHdzMwlju0cH3P5LVsal1qPuxp3wefns1spTXKz8PNsXlSQjqHkFE1i5mM
 rbyG6PTv08LCt/VcusU6PoZ3u1stNRIt6uKT0vzEnO50P+Yj0sHQxEnoX+Bod6emLLeH2eTMEHN
 wuEd/bsRVBogUBGLgr68r57KJxfT93SdeBFK+gHvb1jPbAAhh5cGNAJPqzpumHEbLkKMuLd/Ye0
 nIgKzkZs4U2z5jqviDwSJ6c4wEkvItIzYPZ3PwvGABupEupo5QluuZyftB0AZM0afQWDn08238O
 qbPIrfeH6fKrGYEVVXUuvVJyBDK4LdBJj9OV9OHOHpv8K2WsopPfKfiZgTXTBmXOnJ1302CZH2Y
 eX4T3kDcoEe46PYP5+BtNXT4lpKazM99sT7Qh7ingPdHcFB0kcUp2MYsavYRSaGoYKFQ3mjlIWT
 qXve3+HMCZ60tdt8a0IIZCFnqRO1vasQ9qrLpmhyye3NkmxHM05dXIQjSEO5amwJr/l7RLg/KZt
 t/2RgC4+1Mljlkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to affs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/affs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index f883be50db122d3b09f0ae4d24618bd49b55186b..edea4d868b5131fa69912655879231912ceff168 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -569,6 +569,7 @@ const struct export_operations affs_export_ops = {
 	.fh_to_dentry = affs_fh_to_dentry,
 	.fh_to_parent = affs_fh_to_parent,
 	.get_parent = affs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct dentry_operations affs_dentry_operations = {

-- 
2.52.0


