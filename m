Return-Path: <linux-fsdevel+bounces-74488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FEAD3B1EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A253830D2517
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD903A963A;
	Mon, 19 Jan 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2r46v+9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C932E6BD;
	Mon, 19 Jan 2026 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840197; cv=none; b=YiV4JhQRnTg/EQb20cOheFSNpa8uZqHacMCXXJoT026HsG5VhMie44qtxui0AcngiSV6C0760lLOB097LLPlH3goC4p7YX8JKsid9Z2r7Ozlx2jeDgOirj+tEX9CU1DgcbzyBSR2c5L1VDgTz1Pc9Ok+4kUk/PsAJAaquXxbr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840197; c=relaxed/simple;
	bh=ksDOdJgrlY0p5ZvKqSnF6dLYZLuuHG/nH15DeY9s8Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4sdeunL01MR1tCWN26lGCBb42RoLOzcYcU+PBNX73h0I+lALw9WFbE5ejSGAHfi6c0okb8d2lxhy4mhoWZizUdq7U4cUe4vh+iZI7TfshKii+xAKDRmzGLy41prqYu8RUdRt/8a4VBmEJca0MKqoXrKt+4Qo+pxRSsqxvUmLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2r46v+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41230C116C6;
	Mon, 19 Jan 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840197;
	bh=ksDOdJgrlY0p5ZvKqSnF6dLYZLuuHG/nH15DeY9s8Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t2r46v+9jsw3j0ykHvirXoon1iQeU5Fue4C2CsU43TaWml76meAChiFKMjw87LUdG
	 juk0q7Rh6yG59pa9K6QokouNNIzjCWmAeqPOvgr1EYnvaF5nOQITGaHkvHrt/rUvgA
	 fEXYEQAyRL3L8oXx3tbS1XeHAc6XZBuQGGIJVyzvBKwidBPPL8Fcsqa5DRBg9TQReL
	 UvqAZHhiaBCIIft95WmbFLD5gtkRNbUXauR8+FuRE+pVkpVRB+y3xG5HnZ0I9sh++R
	 BeJ0YEeVv3b119rg8K2AhsU3ALBbIRiuZsKHtJdlxfj4WLjPW4U0lYNo9Sp8RIRQ7F
	 lMzepaVQcyGbA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:39 -0500
Subject: [PATCH v2 22/31] nfs: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-22-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=710; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ksDOdJgrlY0p5ZvKqSnF6dLYZLuuHG/nH15DeY9s8Cc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltejvI4uCVHlIS2T5Sg9AWKXFFFdc6UAKuPC
 yIPRMUKgvmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXgAKCRAADmhBGVaC
 FTCUEACsqv/PKTuNRCX5fxjg+TwKNxbmij5eOneoSqEsTfckElQdAtODhSPDDyCNar8QgaQs7M+
 VXuPS2EI2WkFUsZI2CLVekpCYCUQndqX9wrbqzSuzjy3vnSINM2TO4exNBnjO/erVYxwQjhirKH
 3oI0cBXBHOqDbxYZ4BxvKKL3EzoSapKOG1AycaqjVaS7tSGkd8ErvvpNO5ge1DKKhaFv6SnQv9b
 FER7dx88BVVl6o3/9b2pbxTozggAgRisZBNKhc0V++Nc0TlEUM19Apu+O6ylzKOheaU7DfAYTN1
 Bi0vYNSlhHuDe0mO4uiKEVt13bdyxhSBAqAYffzWra5kfampsjGglFiw4wyUTuPHY7YKYvrU0th
 QLKaE8bFWcJDloaj2gdWRXjNlFnN7noHKGGzh9LK6PoKAYTXHy1j/63W2/O8uQ0OnC+WIuB3e2f
 AIeR7L3FB8HIZilZbF+zOUQ720FHIpZkOvqTxQUcwVKkjXjR5QmK7gBuOJJ3lH0dd7c+uTGqBLe
 LbF6IxDrakDOoOKLHOatndkjqZ78EMx2uzRvgnILErXqa3CLcNn0R943ZowUFuAOh6ZiFn9AV76
 4iQzASFRmeFhWX+P/KS3X4VpLpdTttEFY/0yzEN4+pHCkqJjhtY45bpC7kvUVo6crazXPily8NU
 THxmvjP1Wo0foqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to nfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index a10dd5f9d0786eb111113bf524a1af8b7da0fb6e..7592ef347a2eae5d6305b64effd22537d5ef5e74 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -162,5 +162,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
 		 EXPORT_OP_FLUSH_ON_CLOSE	|
-		 EXPORT_OP_NOLOCKS,
+		 EXPORT_OP_NOLOCKS		|
+		 EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


