Return-Path: <linux-fsdevel+bounces-70999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE4CAEB2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 03:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C692030285D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3952737F2;
	Tue,  9 Dec 2025 02:15:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C117C9E;
	Tue,  9 Dec 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246532; cv=none; b=oTAJEMZ2sAVaGhhy73+FbGzXgnjNTW6Xc+Z0TNFjymFdeCkIW2vfSgzsE61mzbOX2+nYid9AYFvrZordL6Omc2yIGPVjQ3c+2P4JeO7QohnbcDPv0Y6Ogi1oWBQqLETrssOMbwgTVOmy+TTzPIZ6XgDxsHpl/JyDpQT2LXCtpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246532; c=relaxed/simple;
	bh=N0PP2yDPwfQ/fd63tqTe++LTz6I1qeGBbUfe1UvVs4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxjL7SjTFSrl3UDCFDsMUDCxc1CHO5NZah72lfk2KAtuCsKKql4uKePxQ8OFuxqbytx26463Y1qA1BUCW/uXTW98H42WQNVnYjGPcB9AoUFXz6LToxJEy+uYpRjAYYz8lBkOk3bDm9WSdNrsIR/sExOebE4IwmxJ8TCoG5g6+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from DESKTOP-L0HPE2S (unknown [124.16.141.245])
	by APP-03 (Coremail) with SMTP id rQCowACXuN87hjdpXHQQAA--.4240S2;
	Tue, 09 Dec 2025 10:15:24 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haotian Zhang <vulab@iscas.ac.cn>
Subject: [PATCH] HFS: btree: fix missing error check after hfs_bnode_find()
Date: Tue,  9 Dec 2025 10:14:01 +0800
Message-ID: <20251209021401.1854-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXuN87hjdpXHQQAA--.4240S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw13Cr1DWrW7CryDZw4ruFg_yoW8Jr4xpF
	y7CayYy39xtry7XrZ2qFy5Gw1ruw4xtF4293y8Xan3Xwn3Xr17ur1jvrWjqFyrur4Fg34U
	XF45Ga13Zr17XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwKA2k26JXOXwADsz

In hfs_brec_insert() and hfs_brec_update_parent(), hfs_bnode_find()
may return ERR_PTR() on failure, but the result was used without
checking, risking NULL pointer dereference or invalid pointer usage.

Add IS_ERR() checks after these calls and return PTR_ERR()
on error.

Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 fs/hfs/brec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index e49a141c87e5..afa1840a4847 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -149,6 +149,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 			new_node->parent = tree->root;
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
+		if (IS_ERR(fd->bnode))
+			return PTR_ERR(fd->bnode);
 
 		/* create index data entry */
 		cnid = cpu_to_be32(new_node->this);
@@ -449,6 +451,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			new_node->parent = tree->root;
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
+		if (IS_ERR(fd->bnode))
+			return PTR_ERR(fd->bnode);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key, 14);
 		cnid = cpu_to_be32(new_node->this);
-- 
2.25.1


