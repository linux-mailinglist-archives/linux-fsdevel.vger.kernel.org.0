Return-Path: <linux-fsdevel+bounces-73970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71DD271AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D5A331F7B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70553D6F10;
	Thu, 15 Jan 2026 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpFXXnu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004183BFE35;
	Thu, 15 Jan 2026 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499382; cv=none; b=b23/4H2+h7THjISlbOisx60fEHdo0TS9f4sevpluW/rY4co9DpmY3x/rVDv931xXwSUNha7kiTt/aoMvukkDgnn4f6RVKp5c/lKxMnzan3crA8ytYLlrYPIcn5pGLCl+9lOhVsQenN7r0vY783o+eY9KeKSaVDQfg5Xn2/h2cQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499382; c=relaxed/simple;
	bh=3GhJ/qRusFZtrc5r83Yz5fW+XL13TprQK4YWfiaNH7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jJdqyryRC9mg55A3pQXC6hIQjDazA2eYWkLpecM+3h/7EnH++1uCBPhrfbaKQauVWBXhI7+qtpXReXGV1vqW9cdR20mD5+Gp6QCvxeaMb8s3GkaQ/x1Q2tMGXCEMtT6YgUr8SoWzvzZNheYW+FHQdErigXjjyLjkTS2FaLMDod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpFXXnu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA99C116D0;
	Thu, 15 Jan 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499381;
	bh=3GhJ/qRusFZtrc5r83Yz5fW+XL13TprQK4YWfiaNH7c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HpFXXnu7ERkPUAIQm1ZPAcxGId6eeLxlE0JRxT5UA4b8o91JC6MhQ6hmR8WhJIGya
	 u0ZPgVTfRojyBSEkyDYI3DwAmQo9WILZExRwe2UwHFCiNlmisjZ+6bSd+aE7ib61oJ
	 kNhQchrck1aUUpJ+OwOj/fCqXIwNg0ZxkdeofNkXA7xP2g7DfotgAEoSVqgkuY6SM5
	 Wpz8EZYj9+4Xj3LStuJyRf3j5Keqh7naAgj8vpr+lOmqqV4kroZVB7N0Bl859ATYgI
	 uzM5fmBJ5J7caSvvjP71MlmxnFVv4DuzFN9zwjzsgrw+/9iNkIATGHL5NAfE8fKRC8
	 k5qPRrxpUVgbQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:46 -0500
Subject: [PATCH 15/29] smb/client: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-15-8e80160e3c0c@kernel.org>
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
 h=from:subject:message-id; bh=3GhJ/qRusFZtrc5r83Yz5fW+XL13TprQK4YWfiaNH7c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShHXNqSO0AaJtAQ6e0iebWGL9gXuZogZL4NQ
 nd3994d03SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRwAKCRAADmhBGVaC
 FcJZD/995y2baNrZV9uOL0TNknTnSY1b+KmL3xbwd6ELV1X5P9GTRow0w8qgNhTp6DEdep17Xnl
 lV5nNz22mRp/8t/3leQwRnNobdVyWDmG+86VPwmUWRp3avVeIoa2Hq0+unljlviLLfMZvqyYy/P
 Kxs6fTJykAgSKjLX6C+rJOV1Mp3siFq7qgMalb81NvBiX9zHp1owHcyMqSQLk6dnRVhBpwvq8Yr
 HCE92A8xDJ3Ip129dtLuJhd2DRJMhmD7P0OezVt522x2tAQ1uGW9+y22/6QjAyty5uFASKCHvSI
 w3UV0CUln2DLh1/ExYGFtAVStJTrIxdzaoVBW95Wv/hqgnHPTA5ZPK9Mb7x6p1hGhTPsJyTJD+D
 ZfwxsjYG9BWi0T9CmUy63xFCzNqUQ2yS/5IVjEWwR90w95fFyvbdRWQqfBLXJR7156JlOwG9lmm
 LvYK/T5yQAN1YkPNeGXb/ojuDS1Qhax9xPuYWlGmJhpq9kmhgnNhCBrmeRxuXoSdsL8s3e0HFVx
 wPMeDrxdnCq4FIgMAjIVmEOYsxOVRowPOzVRxqVmY6La6z0MHQ1RC9VLmEOUHKcW5IQjJLDb2ld
 98lJr3+W1h6zW0rigSWwt4z1k87pChOwiG5A2qRhX7v35TRycTLzvQDQnkxDqIXyxoiRfeYXqGm
 8SLFEajMop9ifew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to cifs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/smb/client/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/export.c b/fs/smb/client/export.c
index d606e8cbcb7db2b4026675bd9cbc264834687807..c1c23e21bfe610f1b5bf8d0eea64ab49e2c6ee3a 100644
--- a/fs/smb/client/export.c
+++ b/fs/smb/client/export.c
@@ -47,6 +47,7 @@ const struct export_operations cifs_export_ops = {
  * Following export operations are mandatory for NFS export support:
  *	.fh_to_dentry =
  */
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 #endif /* CONFIG_CIFS_NFSD_EXPORT */

-- 
2.52.0


