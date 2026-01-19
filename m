Return-Path: <linux-fsdevel+bounces-74474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2196D3B1B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A29043054DF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220D392C3D;
	Mon, 19 Jan 2026 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJKjaF8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AD6BB5B;
	Mon, 19 Jan 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840105; cv=none; b=AbBrTlDe5ClmZ3iMUvf9P1E6bF4OlHpy0NwXfZbwBTyoGvLcFycldHEFx8s8fBS37m0M1Z+jsudCxYSREHbBPyXblGyYjAFeoNt50zawpBszapO1UukuVkb/bxv7ASHXMB+B8/4NAzgOTnxp4JcC3prw7R127LafmG1+J0haJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840105; c=relaxed/simple;
	bh=x2khPUUCfCV6ZHITK1kpgcwN39t2U+Jx7hzhd06hCuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQ51cSJPXDg0DpASAaraiJKhgHBpLksYRfcq74SCZ0E0OFwnQOFtBVptuhNEYX63zKK5ePy51on79hYH5kxyFE12NV350QLyjNLJ2MGkf4x9srSMGmEsV/mkv/9D6JrTlZiW5wSL2y+wSHkVdXBlDd+Z3Mb6O2DZ/L7p5cUlKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJKjaF8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC61C116C6;
	Mon, 19 Jan 2026 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840104;
	bh=x2khPUUCfCV6ZHITK1kpgcwN39t2U+Jx7hzhd06hCuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJKjaF8o2BvQf0lZo3JR5j8yKQWUqbZaVMaucg0C2gAY7K613riepptLGYNGkjS5B
	 LW1AiCj8azKp5kKcfysLFFkKHO036/KjYmTimnvt40NtB2a6GLrAx3+Jntr1TP5P5F
	 MDzaqdPTdSpMulnzOIN9JyqH5T/xodDX1QSS+ItEd/mnwf+DMO5ERX0odk5EVZWTiF
	 m7G3rt08Hg7HgPZDSuqwG7w1v91ex1fNu9EHbC7dhc5Wn8hE19ATEpvra+Pl3Nsykk
	 Zb0la5tlztNcL7LlQQx+i3zLc50jGfipuklNdgVLg+ANoGPjsTH3MOa8nnQroHJOak
	 EmL7aV9aoTdcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:26 -0500
Subject: [PATCH v2 09/31] ceph: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-9-d93368f903bd@kernel.org>
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
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x2khPUUCfCV6ZHITK1kpgcwN39t2U+Jx7hzhd06hCuU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltbP/9gZQV2DEc3YZ56hrcGZmfoDaIAhNhl8
 71GFh2V4kiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWwAKCRAADmhBGVaC
 Fcz7EAC3hszuWhkIWgvqtaP7NMpfIAj4jYdz8JhqYJHCVh1jzoSx8uhtsLlz4U8StET9O2eo5QK
 6MUGG5HqfNER6iLS5bgRkjG2wDjX8E9iopPSx43wvER0Vkjgq1U8jBg2RzFYANb+9PjMsYmpiWb
 YutyhYiK4by/a8827D+ieAR0CuGxGHBirD+Dl+CLFunH8qtmyJ8d77FX1nTSt+klSc3oBcDXKjR
 TRgPy3m8aIZM4/I6lUMfZt5JHOlbTRz8odScA9LNItp+gtQGMpbSLvNJEUdeoT11kESD9/Y208A
 rF71Oan1XbCh6q5s55NXTzBtazswwEfEXh/8hPTfcO8dJy6l8Aud8vEZKw+QKAmuYX5i8tdF2tM
 kd3GQlDlMeJYcWI4zneadkxvBu3gYPsWGm4fh4HrC6rvP4zqbILG+yYKE1QsXaeqex1BGmTOlCy
 RtGWqZkQAjB2hrrQJWzZL5fGhELvmxcrTBzfucyMLCSu343EsfyuubtnISeEcFvdu5JJfiaFKbZ
 jWcfxHqkXjfiD/GaZ5U8UJBPdPcbFa9yEpm17SCHbm/7rEbaooK/jSO6FmTB4edy9zYyi2ERZyd
 5ifYN2ou0miM92U7fBoOt5pE1/cBzxuvwcIB3IVbfwrzbVr1BVGnX40AA0P2jOAylEtUN5FRTY3
 na81VuEcE6bQ0cQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ceph export operations to indicate
that this filesystem can be exported via NFS.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index b2f2af1046791d8423c91b79556bde384a2fe627..10104d20f736a8092ed847ecb27030be286c0ede 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -615,4 +615,5 @@ const struct export_operations ceph_export_ops = {
 	.fh_to_parent = ceph_fh_to_parent,
 	.get_parent = ceph_get_parent,
 	.get_name = ceph_get_name,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


