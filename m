Return-Path: <linux-fsdevel+bounces-45848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DB8A7DA58
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485647A3223
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BC123098D;
	Mon,  7 Apr 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt2Ze6L+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA822FF4C
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Apr 2025 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744019682; cv=none; b=kW6IAHmtAEhFPDO05dvG7ms+mGTyvbSm4vpYr9nagu0dt0v6ZWrKPK6zAY8/lqPknGEIFnCm2WR3g5UKwVOnQOYvKbXnxFE85rthe7ZE991fFO7JdEkSUpVmFbBT5qP86m7e/Pn5vhST7HafddNGdioK4ndXO/DBVAbM7okFsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744019682; c=relaxed/simple;
	bh=jhlqxm/LtGJSpV927Vj90n5RoT+r+ciMarzN97pSa58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HYAyiJoMddVV/2uPd9VXWhWrGtMJFH9XGb/4oq8RrEpNCzYDgoZAxldy2+56MSpcPY+wmmKmFRgT5inEudM7i4vcC7HL/NRr7Rx4vRE8D9zdfbnyY0Kgo53Px/kk4rfcItRDB5yJZ7vkX7gC/0SgYpVHJIM/o/vr4a/sEppsynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt2Ze6L+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D4C4CEE9;
	Mon,  7 Apr 2025 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744019680;
	bh=jhlqxm/LtGJSpV927Vj90n5RoT+r+ciMarzN97pSa58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vt2Ze6L+b3CmRGCAiyXqYzXRoClhwvBJJ3fO7JE82EdQyN+txHlBhoL/4MPeu6cwq
	 lcXZk8N7tL//9G/I26GgobOlF2BUZN2y+UhaBTCaYRo+4yhtLd3ld/PrdjhI/USne7
	 OctKFlOafkadbOYYv8kMGieUGKL7QV5QounF+SPVnYv2jP5CBCtsQtP3TRK2ZWhetF
	 t4f8p2wtzDk4OuCVCqmU9j6WHqWRKfK7XFH0LhQREt8LtCMQUw3XzsfrtxSTTq8eNi
	 P1sQOij22aIklNLhPjJn1fZ51XlNFqUPPKXghS1XWKXDU+fP7pG9kPA15OmserfUSR
	 N2QfJzR11CyTA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 07 Apr 2025 11:54:16 +0200
Subject: [PATCH 2/9] pidfs: use anon_inode_getattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-work-anon_inode-v1-2-53a44c20d44e@kernel.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
In-Reply-To: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, 
 Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jhlqxm/LtGJSpV927Vj90n5RoT+r+ciMarzN97pSa58=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR/XnDdIqT8aq8wd1/MB8nc2w/CnvazrVjgWPftjE7Rm
 nR112WpHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZ+Ynhf7Fn02rByx/XrDvs
 +n9Vt5Kld42cXN666p3lQpNdD5oXuDP8z+jxmGF1qax55796lg4PxWvqqq5Hzx6anZbRt1lou+4
 lXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So far pidfs did use it's own version. Just use the generic version. We
use our own wrappers because we're going to be implementing our own
retrieval properties soon.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d64a4cbeb0da..809c3393b6a3 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -572,33 +572,11 @@ static int pidfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	return -EOPNOTSUPP;
 }
 
-
-/*
- * User space expects pidfs inodes to have no file type in st_mode.
- *
- * In particular, 'lsof' has this legacy logic:
- *
- *	type = s->st_mode & S_IFMT;
- *	switch (type) {
- *	  ...
- *	case 0:
- *		if (!strcmp(p, "anon_inode"))
- *			Lf->ntype = Ntype = N_ANON_INODE;
- *
- * to detect our old anon_inode logic.
- *
- * Rather than mess with our internal sane inode data, just fix it
- * up here in getattr() by masking off the format bits.
- */
 static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
 {
-	struct inode *inode = d_inode(path->dentry);
-
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	stat->mode &= ~S_IFMT;
-	return 0;
+	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
 }
 
 static const struct inode_operations pidfs_inode_operations = {

-- 
2.47.2


