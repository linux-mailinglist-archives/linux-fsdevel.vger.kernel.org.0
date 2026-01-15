Return-Path: <linux-fsdevel+bounces-73980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 494F6D27140
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF4B030766C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D803EC82A;
	Thu, 15 Jan 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAduJ+b8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6B3D3486;
	Thu, 15 Jan 2026 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499448; cv=none; b=ZMwxAQruo2Y8HMeY/iqYCc3YDqrsEJR/Mh05fFkJg0pdhJS2WG10HVFyrjjx/D7wVJQJ+dKXw9K/dK+I/PNkE39fex9JbijCYrJ0khFLK21MHm6589KGgmBBMl0rKnPbWnsKJdhdH+Y8SkBzPaIogO6bbLhDfKQXiwE38leC5ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499448; c=relaxed/simple;
	bh=Sci10TD3wPs0X/nu0ytauQ8Ud8Tj5YY+K+HKIyo6zgs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9cjpuDdoowaQLiAUBA5IB3aOC29lkTdPwM1OABDAn5fVRfKJ1ni4GNEGbAKmhYsbDfguwfks32Z3OOQvrmuWRneiHuSQ/Q1yZN9c5nZhI1paarZjKGSl5p/OTbgMOAV3OD8OTLwNbPHPnxszNxJv31sh+KjT16jQLpISp3q4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAduJ+b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69144C19423;
	Thu, 15 Jan 2026 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499447;
	bh=Sci10TD3wPs0X/nu0ytauQ8Ud8Tj5YY+K+HKIyo6zgs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HAduJ+b8zSL3EqiL8BWAwWD8dLJQbeePf0bm85OdZfFLPWRA0jjDqsndpbY3aEeJm
	 bSZ2zePm5Ppt5CPtWSq8JfAuvTJdVTN0AalfbQr3+ZmEIVMgZLyre27TUJRL3q79RA
	 rNkOhzjaHEs8Tzs6m7a11HqVSOASVf1UDKrmf2BusNxr4F1ZrSa1AeV3FS1wualjMn
	 edCqfaB7swWMnieicMtljNq2srOk7m1vYCQ/WVyTx7lOJNCf5w6t5Jk73i+CIoGNhD
	 6u2o53je2uuUZ8idJMLxsPE8YuIFnNpQkINvbPOlSBG5OA+QWZzAYgsBIQtPf/0NuP
	 iaOi8AySDlRZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:56 -0500
Subject: [PATCH 25/29] gfs2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-25-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Sci10TD3wPs0X/nu0ytauQ8Ud8Tj5YY+K+HKIyo6zgs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShKEZOnS7UvOdedWpxM2vr6K3ZyrR8i984uP
 36Z/NOZVbSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSgAKCRAADmhBGVaC
 FUAzD/wO4B8LbZIbV1r9N1Hrd5ZJIB+G+pERUxRqQAMDSLuBtzpewxmtTH0hhbSp59SR4MkNgl/
 +2aCmWZWak0wchEfvWhMgfn8Qv3aoofYBRdM41RBXDiS73RXrNux5TRoeH/zHuixgf0wFmfed0i
 jxoj6camRvgEjWE4xs+S0WY2N+i4AAZpT+XPwydSIaDELoku8NFPtj9RKefKVNr0fJ94ul+dW49
 UTt+XNNx6KBm/QZz80fa/w26YhYVLBg6BNGkMity+VSgFJ7x4Ljaw6CqPe5iUSYu2G4wSh8xBbq
 LeNQpupNpNaQScnKKupFcAa/SbRco0dX4zI3o9g51BpGeptkq9hzkW5jBl2TWyOiUWS6/5tWrk8
 O5ziKdR4FKIeC7m2gShMwkA+AtGygxcZMfmt9JoTTJoxBbThAJ5sfZAQ5AqReLlaKBhZ9UxZiVM
 4sWy7ATcwjQoRMD5i/3CbBBtO2qkyWD7+mu06/fKwuoLq12mbWmihF5jaJjBgjsdC6Dlh53xyqB
 Mb1oGWtPvC4v1BTt1ckwG46Yj+uaKNZGbiHsptk0Kn2NWUUxjv1QmRgIuCsDYB1oUwnQbBDLV7G
 LVO7veomLBFg7//KAYREytEu6ObsV2lywlOTKdM5WmYw9LL4gj9OM8SPWkj69/NJPhRp0nQs6Lr
 iCHpJf6gr7VVjzg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the EXPORT_OP_STABLE_HANDLES flag to gfs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/gfs2/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/export.c b/fs/gfs2/export.c
index 3334c394ce9cbe26969809874a94e79bf068b11b..43fd2203b34fb0894d2b71e50278e5cd68216ce7 100644
--- a/fs/gfs2/export.c
+++ b/fs/gfs2/export.c
@@ -190,5 +190,6 @@ const struct export_operations gfs2_export_ops = {
 	.fh_to_parent = gfs2_fh_to_parent,
 	.get_name = gfs2_get_name,
 	.get_parent = gfs2_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 

-- 
2.52.0


