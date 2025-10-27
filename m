Return-Path: <linux-fsdevel+bounces-65766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1123C10A4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79820566077
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B4331A46;
	Mon, 27 Oct 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z/9x39zk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05C629E110;
	Mon, 27 Oct 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591906; cv=none; b=KJ3RicMFtBzXhytZGRZt9/V1WkHmYxA0E6GpEGLe11IE/gOJPNp8fd0Q4WX/RBfyknZp9dD9an95QE7NSnL3TX+0fNBdUk5qroRYNGC+xVdVNr/aG2xD2w7UUly1gCOwYKp2Mxk3aCkWCIDMdgUTS5z0PzQ68ou77WERz+jdLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591906; c=relaxed/simple;
	bh=ygj/HSQHjdeQV2sB903Xdbw9MoB5uxy7cXMfuze5x4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpagRI/AZKxKRYYrSu3zx/at91ZJ/hB99euV21SsW+8YWLJ/5WJyS/beGQoejhgR4ZO0zRf4N5GtPx4Kb95qxcZsWl7qpk3xi+r3iEBLBp2vbKmmaq0bbxt9dxxH4nPwXjmo2ZF1sV0+2+M9UMmWWu7HYOAlKyvG04jGmTvpUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z/9x39zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B34C4CEF1;
	Mon, 27 Oct 2025 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591904;
	bh=ygj/HSQHjdeQV2sB903Xdbw9MoB5uxy7cXMfuze5x4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z/9x39zkCGim/OcXoLlFOWWPgj5qovKA12zLEV7xBjY0rp6wSuX1wnS8CXhftOH2q
	 QaVIqTLdYiUh35hH6vmQTOZBg7A26tKeLBIQI2F7+uV3mAeMBeaf/MlF3QTZizqwJG
	 kLbRBeO/Ehrd6s828DpNtlSQ2fwvAfCYYyUeF4rU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 043/123] hfs: clear offset and space out of valid records in b-tree node
Date: Mon, 27 Oct 2025 19:35:23 +0100
Message-ID: <20251027183447.554869992@linuxfoundation.org>
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




