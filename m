Return-Path: <linux-fsdevel+bounces-65777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC2C10E95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A9EA507D11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09FD32143F;
	Mon, 27 Oct 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9+loaUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CF202963;
	Mon, 27 Oct 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592604; cv=none; b=tMEpa5/N5XRdxN+s/QIeWPmJTmuLs6jbExQqcorwdG9hmoutGHMoSR6Cz2Z9AfUJ8bXLisCGkyyOo52zejESw2dvTvTU9hFrkN7/Tc5+xZ3JcgwBS5hVQZ3YH+L6z8aikc1lYrRz6/JhMbaKWL/jH3fUcSQ6r6m1sOmdlwEGzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592604; c=relaxed/simple;
	bh=2AZYDrMiawjiuqQBgevB7dQD6cXb/QXZrKUry77YOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBtNu2lIGwiUwkV73eCofBL3KDxuo1lKMKr7zEzyDK7qTWxGDTbF3m1BmMSrOnAHbEoW2JOYFvWR1cEqnS57rhoFQXxg8QlJnLT5URBldsQFfpVsyfUIiR59bsoosN6XmXrDuAcHR42Q3ZnUaLQWnikA4/M8IDrO0RWWQwwUpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9+loaUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE38C4CEFD;
	Mon, 27 Oct 2025 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592604;
	bh=2AZYDrMiawjiuqQBgevB7dQD6cXb/QXZrKUry77YOMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D9+loaUkycEYwIfbdCslxfLLshmNpgF9Wyjb0M0LkZ9ExZNtN6+e5P9nIV4KWeNzg
	 tbn8faUab6XR+kxsC5qE53UIXTUaa3g79M64ViFUqrLDGifo9dm9wIylalJ9yWBd81
	 T0HcODR2lp3VZN7OvLw2fDlBgn+5NF416CVsg9As=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 03/84] hfs: clear offset and space out of valid records in b-tree node
Date: Mon, 27 Oct 2025 19:35:52 +0100
Message-ID: <20251027183438.910632139@linuxfoundation.org>
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

[ Upstream commit 18b07c44f245beb03588b00b212b38fce9af7cc9 ]

Currently, hfs_brec_remove() executes moving records
towards the location of deleted record and it updates
offsets of moved records. However, the hfs_brec_remove()
logic ignores the "mess" of b-tree node's free space and
it doesn't touch the offsets out of records number.
Potentially, it could confuse fsck or driver logic or
to be a reason of potential corruption cases.

This patch reworks the logic of hfs_brec_remove()
by means of clearing freed space of b-tree node
after the records moving. And it clear the last
offset that keeping old location of free space
because now the offset before this one is keeping
the actual offset to the free space after the record
deletion.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250815194918.38165-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfs/brec.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc1..b01db1fae147c 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -179,6 +179,7 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int src, dst, len;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -208,10 +209,14 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	}
 	hfs_bnode_write_u16(node, offsetof(struct hfs_bnode_desc, num_recs), node->num_recs);
 
-	if (rec_off == end_off)
-		goto skip;
 	size = fd->keylength + fd->entrylength;
 
+	if (rec_off == end_off) {
+		src = fd->keyoffset;
+		hfs_bnode_clear(node, src, size);
+		goto skip;
+	}
+
 	do {
 		data_off = hfs_bnode_read_u16(node, rec_off);
 		hfs_bnode_write_u16(node, rec_off + 2, data_off - size);
@@ -219,9 +224,23 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	} while (rec_off >= end_off);
 
 	/* fill hole */
-	hfs_bnode_move(node, fd->keyoffset, fd->keyoffset + size,
-		       data_off - fd->keyoffset - size);
+	dst = fd->keyoffset;
+	src = fd->keyoffset + size;
+	len = data_off - src;
+
+	hfs_bnode_move(node, dst, src, len);
+
+	src = dst + len;
+	len = data_off - src;
+
+	hfs_bnode_clear(node, src, len);
+
 skip:
+	/*
+	 * Remove the obsolete offset to free space.
+	 */
+	hfs_bnode_write_u16(node, end_off, 0);
+
 	hfs_bnode_dump(node);
 	if (!fd->record)
 		hfs_brec_update_parent(fd);
-- 
2.51.0




