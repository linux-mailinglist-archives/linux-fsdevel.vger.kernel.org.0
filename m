Return-Path: <linux-fsdevel+bounces-73956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B41AD26EF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6469230C77C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159C23D1CB2;
	Thu, 15 Jan 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu31I0C1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3DD3BFE50;
	Thu, 15 Jan 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499302; cv=none; b=Lo0HN3GzwMJtS+LBGuTyNsv7lCrRXHVpnvIkKH5g2OvFheMKvzp/eRs4xbJpM8gW0jiub5Hq+ICFV010gP67HIiz4XAzM8r4eh2OUOHzZtVXkJdr2DVs70SGeZOS/tQtk1Mk2S0ZDfW+HKhOQfOAfZ/FPhtjqLK3Qir6hpL6+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499302; c=relaxed/simple;
	bh=cRlpRhg6xvxKE1542vTz8cBp9dDE4OGqd+9j2b595OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqQgdiBmei41zFgucGa43Iy5V04l3w8T1fTwHNrhO/f7Vi0lfnyZ1R21sfGrS2QSYA2w/rAbvFDLTnc7sgHxC2L0aTMKQ6kfX+ljdVLsd9fgKLTBrJSNiwqRz4hlojtpRbjgUI4IklAK3wdlnoTDhL8SGFT+aubREMbKJZ7fk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu31I0C1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F22C2BCB2;
	Thu, 15 Jan 2026 17:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499302;
	bh=cRlpRhg6xvxKE1542vTz8cBp9dDE4OGqd+9j2b595OM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fu31I0C1mcdk48lMcGV6EtvSTJtTvS7viT/oyZx3ky95KhA1IgSibc8Tcjmzk5uog
	 JhOfSN0w8eh5Z08O9hxA03062iTTRyFy4/ENNq/6sLAeHiEPsDHmsbAIgQEI0IjWpV
	 T/St+kEHBMhdyyRL/SqavuasePDHiTIF3g2iGd/j+IqyY/GUdWdAZidh6pKv4L+QqD
	 OMgBs/gdxX2ELQ7SDfAgshPh0CFXbDJQc4/Tduuex3ApWZoagP4zA/NahKjB8yVq/x
	 z2ul5X5032MbJsxbTe9zc46WwFLwjcxopwaev5EqdvJLAaXHPOxDwVojVBE/xr7G9f
	 0k+rR/8yf65yA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:34 -0500
Subject: [PATCH 03/29] ext4: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-3-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=701; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cRlpRhg6xvxKE1542vTz8cBp9dDE4OGqd+9j2b595OM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShEgnrZ5MvNZeLKEb4VrTRZtcLcYgm2Rrva6
 3/6K7cxfryJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRAAKCRAADmhBGVaC
 FVmlD/9gn1qIb6YReb8Ce9KEi8lP9mKlXfsYUelY1yljVioBDtrsj6dPS9mWtSjm8Uo0e8RBQUw
 3u+AYBYfiZztHHSK5RCTNlUjYWpIOmHSfhaFA+4R6tA1I1k+wi7KMOlFd56rQZv6qHSt1ux4hQV
 fOQZ4dgdIp+5Y02KZSKXCJO8T49s7NnWaTpmoqrRPKxAITVwK8tY4j+dYksoEjkWEYlmEseo48A
 hdWLdh0SSUK/KUBfEg7RBnvNnLiGIhzgdB4vbIZuQnGL7grlU1sE3BKU17GNyLtiCggOZi+ZybD
 Fw9/2DcXJRON+wjA49hKtjHtEfKG1Y8qAaH3idaqGpnoC8r+m4b79j8mE0sXsSd27plq8MRIOuF
 pMlERSHj1ExH6xOwzd6jpuVJkfOxWw/bBUNDlNsX+gw041SuiwHaGaMSyESM09G/84gr2guNJkB
 7aVdZndIARxy14e/XPziyJG0nJ2et7ls7dVfhAkrcFjxtqtS1qBZDCH+O5EojKDDoQkHXF/56fA
 kYYYvjqZCke8Jga71v8k+MdprNGd0kb9Cc+lhK3Jw+k7EbYR3AhygOt0L4FjWbOKZNYmJIxuENm
 J7q3k6kEC1/G0mhmtZHabQpfhJkZJRdW6fzCMS5Q4y3EE9WnfYwtVOrERWZLvlhEohG7qjkztgp
 GZ0EXfbh6QvTyTA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ext4 export operations to indicate
that this filesystem can be exported via NFS.

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


