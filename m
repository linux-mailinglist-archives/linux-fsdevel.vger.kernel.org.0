Return-Path: <linux-fsdevel+bounces-1089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050E57D5474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 16:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BE5281A87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799982E65E;
	Tue, 24 Oct 2023 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vExzwc2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15902E625
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 14:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8252BC433C9;
	Tue, 24 Oct 2023 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159248;
	bh=b49zUp9bTmN4rXnxKu1Affh8QA+lRZC1QvcrUf077PA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vExzwc2atk5/L/W3huDrdYFrTK2X+sbLkIq0n8ADKvOHQjwJnRPkKVjia95QZZAc3
	 Iy4ELTSPC77p1gO1edmZmBnmkD/0nutDjE0SB9LXURiD6JntjBnZI86DG8hltTLmSe
	 NDdSn+9ONgtXRwuPza7OmEfH/1FJ46roK+4E7anXtHk1t12af8bg7YoYEmrdMDmu4t
	 AseD3JLkSlvfbgz7gBKDCViMJld2iCvM/0/8U5TmwxQiy+l1M9JVEwjfvCYfr+cMd3
	 OTnK5mge+gBDX5fOHIbKxgEf/fFzV4jK6KwlF2mNLgstg+CzWUkSylGFKH1NlLJE8I
	 7egRM83eQQRlg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Oct 2023 16:53:41 +0200
Subject: [PATCH RFC 3/6] ext4: simplify device handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-vfs-super-rework-v1-3-37a8aa697148@kernel.org>
References: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
In-Reply-To: <20231024-vfs-super-rework-v1-0-37a8aa697148@kernel.org>
To: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b49zUp9bTmN4rXnxKu1Affh8QA+lRZC1QvcrUf077PA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSa3+pS2OFeXvvO8N9pG16RKbkMbxxX2+yzOVhRWLR+LU/F
 wcknO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS1MjIcPlTgdnRljmJ7hfSvlm7uu
 d8vjVvsumRTc0bhX98tZzS6MHwV7hr407GN8LTi3dn9+sLNJU/PW6UOulsfSfzYfnyqdzijAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We removed all codepaths where s_umount is taken beneath open_mutex and
bd_holder_lock so don't make things more complicated than they need to
be and hold s_umount over block device opening.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d43f8324242a..e94df97ea440 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5855,11 +5855,8 @@ static struct bdev_handle *ext4_get_journal_blkdev(struct super_block *sb,
 	struct ext4_super_block *es;
 	int errno;
 
-	/* see get_tree_bdev why this is needed and safe */
-	up_write(&sb->s_umount);
 	bdev_handle = bdev_open_by_dev(j_dev, BLK_OPEN_READ | BLK_OPEN_WRITE,
 				       sb, &fs_holder_ops);
-	down_write(&sb->s_umount);
 	if (IS_ERR(bdev_handle)) {
 		ext4_msg(sb, KERN_ERR,
 			 "failed to open journal device unknown-block(%u,%u) %ld",

-- 
2.34.1


