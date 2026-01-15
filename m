Return-Path: <linux-fsdevel+bounces-73981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB2D27CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FCE931B97B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBFC3ECBFA;
	Thu, 15 Jan 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEhj0jPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52993BFE29;
	Thu, 15 Jan 2026 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499454; cv=none; b=t6OkVcWGNOMbDuJqrC+vXFvb/3ukkp9+bi1CQxyIYDDEMQjdNCDlKKnoxc6RT+PJhcRBtbzBt+xAUyHXctOz2IgMDnfQY1AtlHisENWZvgxy8EERlLuNDMITfJ6PqZnO5Ub+X20WLyCDsto4IIWMEmk98daDodqu1kJ1tmmGb9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499454; c=relaxed/simple;
	bh=B3iB8PdtmJXVVjQl2iu1kT0lUCYC1JH1znDIT/qACXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6uabWVCB7EqRWM7aGE28H+4XsMgCcHBCHsri4KVddRkdofBF+h5zMDR/sqK3OciDCVMFngBtvbzCg4QrGFPOQ1QrR4LD5TeEUHMN0+jzbFDef2FaRzwPLvxZunsWgR0swY2b4fPNUa1CfLEU24aS3Y8KAKwkssyj6tUJsesxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEhj0jPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E6C16AAE;
	Thu, 15 Jan 2026 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499454;
	bh=B3iB8PdtmJXVVjQl2iu1kT0lUCYC1JH1znDIT/qACXY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SEhj0jPg2LUbe6QdHiGaIMEcuXoET7yHO1nhDGM0eDszM0SkzMGpCOh4tVBq0wYyL
	 +R5LwCPJYRhA7AK+gW9/IbFUgM08yvctd7ijqfNZ8mQJaevD1wNAREr4FmZNj5n8xf
	 GOV5UKGAyGz6u8AbcPgrO7zJ66fc6qmzlj5cvbY15wa96qI/BbwvUh3PKlSbQh5uSX
	 CNNtI5BNm5gIP5lr/r+jxSQe6GCtwSrgG1o9W80MyO7XwXb0PCpDUV01pQuwqEtIlD
	 rYn5vWgythfAwpUx9EH2EXuifp6whNQDS6ojHLe4tCfa3mdIv5wzqNOWWc7rfo6Wqi
	 uqezwqjpSq/yQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:57 -0500
Subject: [PATCH 26/29] fuse: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-26-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=B3iB8PdtmJXVVjQl2iu1kT0lUCYC1JH1znDIT/qACXY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShKjlDTIgJ1oIUxVMm6eLiW1LORyjHFx57KE
 4mWRFnefO2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSgAKCRAADmhBGVaC
 FdvZD/96keRaeqAV/wN3y9Y3bEH/SWZiHa7J2LGHoRLFPk7NkJXw6qUjQ+fQke+zYjm5T8ipf0/
 j6OallhpMjyf76MSGKNtwDM12QPde6749iLhlkzuuiNUiBKcUPf1LB88v2dcrFx7PIrj+UVP27N
 sUNHGdsfD8Mo8NhMj4P4Ur5nrA/R31o39qaYZiHwZ+uv1oMfSYug1mGG5w/HaKvuZzyQWfmlJ00
 QzVRyhynYHefKf3BpO82gyCZ8I7cIIVYrTPM+kxTn9dYmIAJ5l2RY47dTWAWdeWutD0LjZ+crAp
 lDqJc7FuApQgNY2lTf6syc5cEOBAGZbTHhjuGcrfd94N+YvlpW2gHzNaHL+U6NzjA0SYlVgXdJt
 mA6emOY0KnTMNYYPWB58iMZtclcVe1bLiT6ebciSo6h9JK+QgrDInMpWTCaukHrjrXOu9ee1acQ
 OcyyLL7ZWDCXYd1zZMBqsv3sYlWJ9VMlyaJxIn9z3wl2dGnIBe+hW1AJpSRJvtKewKQkAMn7zWQ
 tmM4xAj+ZaBtdPGgPttvVBKKtnwxo/15PysDrxEm8RCLyrPCmV2/T8kMQeUgznoKgFjlS25W4/E
 eJvv4uMPQ/7FIHHyKEG2s54VKAbN9dDeqzkpIfBnZL8eiE9e3xOAUhS5xyNkgdFmxAgqVhQO61T
 Tc9M7AyQCooZV1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to fuse export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 819e50d666224a6201cfc7f450e0bd37bfe32810..1652a98db639fd75e8201b681a29c68b4eab093c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1208,6 +1208,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 /* only for fid encoding; no support for file handle */
 static const struct export_operations fuse_export_fid_operations = {
 	.encode_fh	= fuse_encode_fh,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static const struct export_operations fuse_export_operations = {
@@ -1215,6 +1216,7 @@ static const struct export_operations fuse_export_operations = {
 	.fh_to_parent	= fuse_fh_to_parent,
 	.encode_fh	= fuse_encode_fh,
 	.get_parent	= fuse_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static const struct super_operations fuse_super_operations = {

-- 
2.52.0


