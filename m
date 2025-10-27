Return-Path: <linux-fsdevel+bounces-65767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82120C10A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F104B566FA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B322A4DB;
	Mon, 27 Oct 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZWPMgvkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C2331A73;
	Mon, 27 Oct 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591907; cv=none; b=e9VYVWMFcbwS34+3cgDQ/wv4BIpehkZ2tSQEceOq7dRRmBao/nO7sUeNCYwWbczdXR/2iCF9tvOBswPnLWaAXx/oH25op6c2L4ly+ecTBqtBBcIEaqpiGFTc+qgxn14vNj1Ydj4bCdYCbFlQLUJeg5mYNpOPtsu4xwz4QJVXAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591907; c=relaxed/simple;
	bh=mnA/9i5tufMDK8xImbAsGVwYWGRbN6pUsNL+6wwI4Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uney2J/jOYlrXvQmNT0dp1Xl2Q9jUg5SIH7pXbkXkDR5LAh0up3J2FUV8ETimzL7TDP+2Toh2MwMbqBi52yZlh2w1B6RE3mJIvEIQRIf4HxZSt6BTq5Fyh+UhGHNTGzAqMlTTSp/VhD7wBqG9pEmQyIyx1d85U5JGKHeRaMka2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZWPMgvkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ABAC4CEF1;
	Mon, 27 Oct 2025 19:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591906;
	bh=mnA/9i5tufMDK8xImbAsGVwYWGRbN6pUsNL+6wwI4Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWPMgvkWw8AM+CGMxLZOEutdimqMcXCvPABf/61a7ZsPhkecU0TjiMDmoAO1Ctcjo
	 FZMC9ytwOBp/UKhsAJ2DYjSWxEG0SKUv0qaqG7/Yxq7NrT47H6RiNDWyS89CX4JGA7
	 Ub2Wn1ZGZDiDBrFvB8IUqrJMTgbE/06yEsUqNJmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 044/123] hfs: make proper initalization of struct hfs_find_data
Date: Mon, 27 Oct 2025 19:35:24 +0100
Message-ID: <20251027183447.580175060@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
References: <20251027183446.381986645@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index ef9498a6e88ac..6d37b4c759034 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -112,6 +112,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
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




