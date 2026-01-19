Return-Path: <linux-fsdevel+bounces-74484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D577CD3B253
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2ED2B3015ADE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A519032B9AA;
	Mon, 19 Jan 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQhJYRGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F57329E49;
	Mon, 19 Jan 2026 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840176; cv=none; b=eFmoSuUzDlu2Z23WYbeaZSECngl2y+8zWPwz7GSUg5fNMemt/5TZcKmcAwtV1NDyQh8H4/2WGlWHOiw3ZfN74ArM82GRpeAWZ40dMc9QooGR2VMK43innxRGOL+/4ZhYOckDF1rq5sgEk1JgRvfyKgEOR94Yk/xGsDYkg1pFsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840176; c=relaxed/simple;
	bh=wU0i80DF0FPqjAJHIRj1jzTtyUWnKNMBQnZ9bzzbTDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PByDE6HKTFdbC2yWngKeHB9U0+BhpNDvQabeX/9UJ/SFJkLEeRxkYFlNgwd0tMpOzxTKSQ2Ce++/OKHW/lUNX35R6NXBMoathzGDGuS6ANJYlW16SbqgYLete2EJJ9QEAXs/1NDzm3JnuxR0nmro6eL6oaPWyDO6V35Ui2ZR+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQhJYRGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2AC2BC86;
	Mon, 19 Jan 2026 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840175;
	bh=wU0i80DF0FPqjAJHIRj1jzTtyUWnKNMBQnZ9bzzbTDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQhJYRGsl++lczxBHEt0XaGrxt4g+6vUAYPrRcw73aIRch0FVGyVATEdpccesSqs9
	 URiwqrosG0CP1irk12+e/p6RW108GpwftJnbPgTyy2fk2ZtHaWu7YwXKfTUDCT7YYj
	 habn8bLFMPil4Fo9jX+sOzecRJ5OFTjN4cW2L+RT/+8p/XIBqiQIMLfoTEAaz/wSHh
	 doBGze5VI89ZR4tztzP2HdKsw/to1rJmbiB4hBqqDRpYdgi+Dj6yOzMVJaPZSCucM7
	 DQJ25RKNsgdm2ZepzIPIGXX2yldRuLVlW7b4p7/LwXoa0VcVJA9Oumg369d6XFDOIa
	 NZm1zFyOw6MWA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:36 -0500
Subject: [PATCH v2 19/31] ocfs2: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-19-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=724; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wU0i80DF0FPqjAJHIRj1jzTtyUWnKNMBQnZ9bzzbTDU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltdFQ9b2g6zsfezKJIAwvxbngmwk5KhwfiY8
 +38M8QDAHqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bXQAKCRAADmhBGVaC
 FVVbD/0SRJlTCFiMglDJE7H/jWRUflYuMXEi8SA2hCybpcjI0Lzhq3Dftiwn56jC0/slUH9eZYc
 9ZXJtO5rQMFFiob97e8ROh5R8oMwf9IvoJEgVnpO/91D+7bdk4yz4p7St+51XuIrbzvSEgdGEAr
 1/Ox4Xs2wr1PzX7Nv2qi516wzYN8pn8Mk86h9xYIqx/eEsKln5byAJOYF1JtQ5E+VtXf2hQ98va
 1yxfDCOCcAxWwPhsjwmXIVinqlwfejZj9y0mBOdaJTScAIB9E55sGMOQgTQnqr4rwl2tvvE77+T
 LCr533OwnRhMTIIoQSiysB24g6B8Q9WsZiKtZDZ2FK5VM+7+hGjBnj7WuU5akAKL0Yh+lQlq4wb
 f3Jdhocl0fC/LsL0xJ6Z+hm+GK3AavJw2cOREDtGmzE/+Gm/okWTQBg28Hfn1rfewYRsEUNryaB
 7NpT7W7kYaJB4F0KZJHEpQyidU62CBjmpds4LOuqg5dUwlyf/Cz41R9qEPolEWuxH9vIrOdcjSW
 KY6o65R+9LmUB5hnJ2ZB7baC8zppQdPF82yaEOO17NEB2Z9O755Vwf2eMRV2kyVz+/olzSvhG+v
 RRvie1TZQrd1n31fdwJYNIrYSyQoDqWTEJSqbkLU2i0JJRAjOJ5sGbimADbV2dyDswLBJTKrBDB
 xyY5rmCt0KvYE2Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to ocfs2 export operations to
indicate that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
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


