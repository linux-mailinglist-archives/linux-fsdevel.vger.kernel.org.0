Return-Path: <linux-fsdevel+bounces-74489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD9AD3B388
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C67BC306D155
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DA3AA1A8;
	Mon, 19 Jan 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWFPBI+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE832B9BC;
	Mon, 19 Jan 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840205; cv=none; b=Tko+RnpQmrj2937Q7OOVrfVuDONsbN0LDpdHHGblqoSo3sZP07kUTC1W9S/hfBxQ7dhLM3VlD5hxr7SfGbg98CNQod6vbURtEPpG+7jfkg7iXVGvqOYQDVDTBurBiR/HbKOuxrzQ/6eah7oYMYCTPaQKxL6KfG+tHFIWcHe3zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840205; c=relaxed/simple;
	bh=vQTd4Jo5nWm0BtlMXBC/zeTqN+exhfZBAyMeslzDnKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bcj6hHDazCWFqMT9PWiEAF+ZXsykAtFv0bbQabKLjIeuVDa08mA57s9uAs1ij0R6oXBXDcEd4GTO0rjG0JIVI8MW6opdPhxAr+rxsmEI5HqQvAZZt4srY06mCugOTRs3sQ9nRkPY2KtGY1LMM0EldBHChse4eDmGjN9kAWgj82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWFPBI+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655B2C19424;
	Mon, 19 Jan 2026 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840205;
	bh=vQTd4Jo5nWm0BtlMXBC/zeTqN+exhfZBAyMeslzDnKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AWFPBI+DGZ6l+36k9cUcFG0hNFFKJ0WMx66O5cEYb4l62RB3MHZqQrMyu+l8KoFc1
	 TGdwQ1vZg0M8ySuA4DCPjGa2HYdhlWYqJglFLc8XmqEPvUHdJxxXLwvvLRoWe8vbm6
	 0aPh3Sk1rMoZ6/5Omzvw5StQLtIn16fGFg9VDhx/A2qqLLjS4Nqm5rKYDXgHs8gK0A
	 ok7XQ/JY5MkIHVzgoTLqIWhH1U/zaKEFZ2BnohVbeU/Hd0P7u/5wSiCw35RX4erZMO
	 zxVhM5nZ8z9dtS9jXJmWWwdhg+pY0UAUbzMiE5GZfJeJOnjoq3NzGXfuvGSE4FaPk9
	 OHv1hYqPynnMg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:40 -0500
Subject: [PATCH v2 23/31] jfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-23-d93368f903bd@kernel.org>
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
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Dave Kleikamp <dave.kleikamp@oracle.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vQTd4Jo5nWm0BtlMXBC/zeTqN+exhfZBAyMeslzDnKc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpblteCXSwo2a+8YGLaQolNYDg9J+5h600R9sGY
 lTKG5OkIWmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXgAKCRAADmhBGVaC
 FQ4+EACdlT3kWBo+HI6ruDanrebZFrOPBF8E+b+dbln0HfDwLb6pNFCgmgym+bnP/ZirP+ltIqG
 uJNypDGY1ttctOOFStuOce/RWd3J82M2fSTS4KTePxme9FxgWvfzlPqz43ArAM+CIkWGVgeaGKd
 mHaIKzNzUqg1BfEV3B9neORWkEe7FLYHuRjtd1leg8qBCG7g/NAJnxTEf6IhLFb6zUVI8WbEwXf
 SWw8IxyniAcvvpWPhkQEFgLr0JwYPezris3doWzeAyaa2RJuQcnk/HoA9+0NKyT3hW8nQyO4Fe+
 s5DfgIZe23cBvNTYaSp0xBbkqXcHoOX9oowmU7Y8Ke2Qk/sO3PNoy1GWQUlU7U1JMGB+Rh/80vl
 gzuUVkFpOWWFtTFkUayRdJta8LzXqmKzllI5a6Pi0c73/LLUxESAQFBh6barp4IuMUnmulh/03j
 NejtTplGwWPkizI1bVDryTcbMGjt1rPCpyN7gteUKA9FYFCci2pCBozoV8YVMbcgu8bMO0xSBj3
 g8cdqKbuYMp4kjSkuCkG/rs45okw8w7j/eQ/cStRAbHsUL9+mbf3ALihR7DcksQu0or91YqhDru
 hbkk9t9wwE/tcAokrVSpplMMM9ODfSLZ4IZwKUeWEpvMoVv3um/271BHFxRjaAyh2iKbaAlStLk
 7XhpMkBicI0ylbA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to jfs export operations to indicate
that this filesystem can be exported via NFS.

Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 3cfb86c5a36e8f0c46a2734a24fba6ffd36c7ad9..ac9b6d754f8c203baa7e91362aeb0dc9b3ce209f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -864,6 +864,7 @@ static const struct export_operations jfs_export_operations = {
 	.fh_to_dentry	= jfs_fh_to_dentry,
 	.fh_to_parent	= jfs_fh_to_parent,
 	.get_parent	= jfs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 static void jfs_init_options(struct fs_context *fc, struct jfs_context *ctx)

-- 
2.52.0


