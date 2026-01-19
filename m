Return-Path: <linux-fsdevel+bounces-74469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 222CFD3B145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE1F302C9C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15F32E721;
	Mon, 19 Jan 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSVUryJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4902EB85E;
	Mon, 19 Jan 2026 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840069; cv=none; b=mhlxbkibhQFZT55P+BnpsVTJr6blEu/LopmmgN2YalsORET5Q31FFsTJ72ND20OG50eCi1fcJB7+tbnQZEgQuvQvJbfUXX1TrK1WG5cMj2vyaDUgDa19/0D8a84rWKYE6lHFS8DZBY8Rxt18Bu/Ir6d2PbBrgVwbjMCkqMkn1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840069; c=relaxed/simple;
	bh=AjWutM65jGFPUYxo72jA+Ij0HC7LS8R/VDQO98k+B+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmc+zXbm7i+aNqSlZ7YDHOGqfcu9WVbOb7qYXO2bJkNB1pV99N+b7hbdnmr6uuAbVu4Q2BdL3DkXZo+V0CzMHGOK3UI6Z6krJDa6x4idKO6YQURqYeYylDoskHOre8hebHK7SfhKm8HKS7eDZGTuKG1BnRO4yNBksdYpioWwMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSVUryJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13C1C2BC86;
	Mon, 19 Jan 2026 16:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840068;
	bh=AjWutM65jGFPUYxo72jA+Ij0HC7LS8R/VDQO98k+B+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eSVUryJiGgJALG2ypJ4Yjr568W28w/8A+eXZrbsI4+hMfQOAzJdZQRV9oe+T3lPi5
	 4mMm87GheTCUUW69mQQVVSKcxiZ4TOh5VdvYEjNSP49v96zd3u2tkg8lkt9b8MPF60
	 AVhGJPZm0T5VDPMCYbVqD1onR6BQ2XhtS7tCp6xAW8IKiFKx/n7v6WobsF/eTJtxjA
	 Nd2qg/+nfdwpq+DqIytb+gszW5PETsTfZ44XEt0Fp/CAMv8hCj9bv2Z1ZnVwuMRGLt
	 B+ukQbLNhB9K9qN6/51qLpBXKria1HuayrhCMAS5caVGwiDxOhazJhCpK9AMP+L1Zt
	 /GayDKKSdC88Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:21 -0500
Subject: [PATCH v2 04/31] ext4: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-4-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AjWutM65jGFPUYxo72jA+Ij0HC7LS8R/VDQO98k+B+U=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltaIQXQCdDNYtxGH3/N2irOpG4/iK5HsTT1Z
 4iHLiLUl8KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWgAKCRAADmhBGVaC
 FbcrEACGpRl8GOPGkb17ykMrM5G/nRGznE7ZxuOH6ewcr6iKf0fOYadqPEBuyp34Xv2zArXNlNf
 459udNfZ2Blhwbz6pQWEwgTtXq3CYdske/+FYkdg++6FgJPzN7mBg76oRaCGCiL+xi4Q6Z+AaZD
 3K4u+njqrYntZw9j30opGiylxImbwjObkXvc/ZNM6L8pLOmEiGGT+ZEis4o1k97QZs3l8XOCmG6
 k+n+j7uS/3v/pHy3SWNTYBWq7OXzS4vn5YGu8nwBXymjuNdX/CijVLY2oV6Pgib5WS46Qvm6WqI
 OwvgpfxqmTcbN15+7Ypr7ATodGgOgeuroQo2DzlZ0JnZ4CVuSGBm6hkp7jnpGmq2q3Hs5TEREaI
 LA4cuyj0BVpV8rDNZAu1OKN+Vi4Ews3TcD5lIl/ZVyu69jsyh4ksqHFfhWmfkx37TnOivChumlO
 1DDGI4PZloQEDOExjfTtn+1xTF5ZPFgLMR69FJyDpexvcN+5uYEO277e+vMFfH9gDhJysYzFjOy
 jCxWdSNLbBll9mFbb3tbLoSV8e/ikoUzSk+vUn+ePpr6l/kwW9EC7NOdrEwECBcRqxpIjioa/Ea
 At0n0Ja2iF2ptFS/RPVXB5xcfDnEZveIInEcsypAva4ckDFGPFoT8TsrJLLrJsPvagzaaa4HHWK
 KsSCkMjtEOBxyZg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ext4 export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d026c3a73a64788757c288a03eaa5f..09b4c4bb8e559da087ec957de3115e4f7d450923 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1651,6 +1651,7 @@ static const struct export_operations ext4_export_ops = {
 	.fh_to_parent = ext4_fh_to_parent,
 	.get_parent = ext4_get_parent,
 	.commit_metadata = ext4_nfs_commit_metadata,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 enum {

-- 
2.52.0


