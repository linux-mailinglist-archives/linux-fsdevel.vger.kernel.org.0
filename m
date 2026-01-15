Return-Path: <linux-fsdevel+bounces-73960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE985D2706E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 99D73308BA5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B23D3CE1;
	Thu, 15 Jan 2026 17:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6+XHbKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFC3C1983;
	Thu, 15 Jan 2026 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499328; cv=none; b=ZwMdYZl66tPdUxnZUM9GUzPtYwDfhcg8Mt1zwLQ83MgWeTQS90Pkkad2/msmtNnhB9v6k0egyCuRH2zc3tTZiFLJLZ7nnpeJnOhu2z9tcsw8ddSNfXE8P9cQU2h+kwGjnxkl+SzcgcuSWlhEsVJ/BCC6WtSyMFcxONKcqH2A70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499328; c=relaxed/simple;
	bh=vuk9Wvyv5ES6VnJs/c70quqpIAbNAzCUaJcxJKcbQlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2ev7flWWbce87Nd+oLjxjO506i5yQbMI1ydo4RwF81EP/4opHDo+fELvHJkQtJqF/QNDnxr8cu9KiwFZnz7VoXBuK/07Zv/IhrJZGRFSU3C4f+3Vp5SqJTuwgLE+n8Y1MJkL0IMrxF8gjmTcs/f+oAudEW8wbzvGhqrLSA8uJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6+XHbKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A39C16AAE;
	Thu, 15 Jan 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499328;
	bh=vuk9Wvyv5ES6VnJs/c70quqpIAbNAzCUaJcxJKcbQlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K6+XHbKxqod1uaKNGVLt+q96dw+BOnbjMcmu+xcP3xiYddgG/sJuefym6nZHrJfKi
	 uH5dyVS/KTA4hRUnraDib1V8YEkjK+G8GVjWdIm826RobU7wYg6pDfMglI8V+Xq9Bx
	 9pJ3DpoKFcm1Eq0APjx7imRbBy13g0E356azB26lJtgh0O5ScUdhZNVC/YkdtYSgi8
	 gmVhqy2XaaZjGGOepgCkNZyeiVv3OKETq63VZjHg0LQALYupnIm4QywOci9P10oDbV
	 pLqK1LQxhagszUU/8zfOn1rer6rnz7Rc+MW2csK90ADeRqcyCjpM3Gf8344us2SQbD
	 qJhmn1Zj47U5Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:38 -0500
Subject: [PATCH 07/29] xfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-7-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=676; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vuk9Wvyv5ES6VnJs/c70quqpIAbNAzCUaJcxJKcbQlw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShFUCOUlu0HwA0s7NudpYH2UNvJincQ80Jwg
 sEsHA/DeX2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRQAKCRAADmhBGVaC
 FSd7D/9HhL3CQRq9CDjJOgHiepYVXs1Z9+kqO1P1hOhsl8D7DDIrPttx5CuWUkhGAcKXXvzcPmi
 9TKdrUzG50aTMKrqulpKqOunGLLFir7B3FcVywRapPfJUqx0KLTsBaCdT8xUU3osoXsoeb3CQbX
 1KMKEJ/pU/MqyHNy1iKPHPkElMxX0QKsgVM69UadFRWjn2R3skLcJHutgI8INVYsrewANQfW4uS
 MscVfjtjTEcOZNxyFRYwlsCfSFUpDGunv543PqvRAVyvv0BQ+SFeO6U2aMErnOE7r56FTfvMOl5
 tuh937foFGakhJ8nJP9ZQy45v4wE4+/hQzwc8EVn3HWLC195i1O8tt+ewt74JopOTmYHtw9HWTd
 xpQiYgGhx4/DEAijagS/DXh1DHSEFxfNDJ0I9ale+NfJBNUS+zgavkkntEAPOI45FfOYcw0yIAp
 +JGVnw9DNGE9V/hefG0jVOiPj9uu5/A/hwgV5sHzf/Ck0PEZIPTmxsZbDRGdzyIzdk0Ht3Fh39p
 tYyLDOLZCOgznQbY65l6VAW/cvZI0oARSGpZJRy4OudPobv3MM1rd0m77loet1e8lq+9V7Y1oxM
 Q4C8bVqfBvhIO/ANW/XxX4fqO06IwLdqLVvdgppj/GI0MovVq4ZgjfwW9cKZ2xEQTiqm4AFJg9j
 k8Hn27V6ZD+gXng==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to xfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/xfs/xfs_export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index 201489d3de0899af34f0485e00fb8b36842d419d..1be2de3394841a2960c1b2791897067b83cc7763 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -248,4 +248,5 @@ const struct export_operations xfs_export_operations = {
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
 #endif
+	.flags			= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


