Return-Path: <linux-fsdevel+bounces-65778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C81C10E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F05582929
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695CB21576E;
	Mon, 27 Oct 2025 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pxLQYghU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A91FBC92;
	Mon, 27 Oct 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592606; cv=none; b=TNeM0QbVcACTkYogg/OEMWQZX8hQUUvDGh8JuDWa6ehVf6oljIQ2hvFdJIWFoYzT8+yMXBN7vPPlEU9tVZcWuQVcFMo2neyoIYyAJg61cBSMW7hPE2rotScPd/goRAKktSodpnFCI6DghEYlQfD2Wy0SKBzXzSbz0LzoDEDQIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592606; c=relaxed/simple;
	bh=alzehZZPAgOXKEXT5T07HQmPaTbJk1BkvAItk3yr/Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH0ALPCnitmBu9z1mg8VQ2Fd2x2UjpNHIJqDjz0I7sdF1QPMp8lelKN46Nj3FEVGEFwO5abPvSWeK/XZdjbhT9ST6gsG9aXgW52MypS6Z7H5MN8UMZ75V/pU3CQK8cIdiBQCHcW5X7SFePFAPL4xmRk9fECB0wRMV9mTwMw26MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pxLQYghU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C9C4CEF1;
	Mon, 27 Oct 2025 19:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592606;
	bh=alzehZZPAgOXKEXT5T07HQmPaTbJk1BkvAItk3yr/Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pxLQYghUg0E1sOVyRAtknntnNHvijgceol28KRRpXU5doDz8LC+DOiQwVFIq3gv2s
	 x9CNX4TRQABZ0llZ58l+8C33YdCD4RwBGwnL1052yeHObmDENm/Pq+SIvgOofoGhuQ
	 VH5mU7hlH6gxuczYNvF4+t3J9Kglq3lZz82xueUY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 04/84] hfs: make proper initalization of struct hfs_find_data
Date: Mon, 27 Oct 2025 19:35:53 +0100
Message-ID: <20251027183438.935884966@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
References: <20251027183438.817309828@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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




