Return-Path: <linux-fsdevel+bounces-65784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD7C10EF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349B819A514A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396AE328637;
	Mon, 27 Oct 2025 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKBoLXPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A731D73E;
	Mon, 27 Oct 2025 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592834; cv=none; b=WKnuG7UQ84UWtuUUTPKtI5CBw/O3b+l5SNDfrauZNVvhmwOqO7Gg6VzByOL5sWoSFRxoGsPYaSUo2sJEB5C0JRklJzF3U/PACj0sMmHmfTf5sT1AaZrrcKpqDCaA3FGer3S+WVCnm3uVU8rFGXrqPzi64uZ9SRKYs3Jf3jCyqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592834; c=relaxed/simple;
	bh=ZFLKGEk0k18xX0ZTt5W/YgA/l19S4agYBu0wS6kySWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krZzsy97kIclCfZW0NURtX3POqyVZci7H8h0JYSZ4toZHpt2JBbFTcZiaTzSTv/cnM7zCPhtsqXrtAX040DiMG2pqsLiSsrzp0opmiY46I1H76fUDAo3vhPWvBt5d4m7n9xrfTVeb7nasfG71EMdFkNBvDTSVNRByHeUO55Rbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKBoLXPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2EBC4CEFD;
	Mon, 27 Oct 2025 19:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592834;
	bh=ZFLKGEk0k18xX0ZTt5W/YgA/l19S4agYBu0wS6kySWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKBoLXPS7Tc3kSRXYaiox0+AQRDstdx654ErSpkNFJYwLAqt5FN8WoJcky5mJNNGt
	 X3NdovgMBPp/59Px/eZy2IQlkIxm9WHeBmlj96QnHGz3ynZ0DG6m1M/2L6R26kPatq
	 p4ri54NYFuZDu3ygKqgjsCZgoObekrH/XedSefpg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 004/117] hfs: make proper initalization of struct hfs_find_data
Date: Mon, 27 Oct 2025 19:35:30 +0100
Message-ID: <20251027183454.050799745@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit c62663a986acee7c4485c1fa9de5fc40194b6290 ]

Potenatially, __hfs_ext_read_extent() could operate by
not initialized values of fd->key after hfs_brec_find() call:

static inline int __hfs_ext_read_extent(struct hfs_find_data *fd, struct hfs_extent *extent,
                                        u32 cnid, u32 block, u8 type)
{
        int res;

        hfs_ext_build_key(fd->search_key, cnid, block, type);
        fd->key->ext.FNum = 0;
        res = hfs_brec_find(fd);
        if (res && res != -ENOENT)
                return res;
        if (fd->key->ext.FNum != fd->search_key->ext.FNum ||
            fd->key->ext.FkType != fd->search_key->ext.FkType)
                return -ENOENT;
        if (fd->entrylength != sizeof(hfs_extent_rec))
                return -EIO;
        hfs_bnode_read(fd->bnode, extent, fd->entryoffset, sizeof(hfs_extent_rec));
        return 0;
}

This patch changes kmalloc() on kzalloc() in hfs_find_init()
and intializes fd->record, fd->keyoffset, fd->keylength,
fd->entryoffset, fd->entrylength for the case if hfs_brec_find()
has been found nothing in the b-tree node.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250818225252.126427-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/bfind.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f360..e46f650b5e9c2 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,7 +21,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -115,6 +115,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
-- 
2.51.0




