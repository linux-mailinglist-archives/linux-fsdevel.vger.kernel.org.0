Return-Path: <linux-fsdevel+bounces-10220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C26C848D46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 12:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A3F1F214EA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 11:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80851224C6;
	Sun,  4 Feb 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XNEtcZmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF5224CC;
	Sun,  4 Feb 2024 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047861; cv=none; b=qjXpKVdkGb07tEOEZzEeHtZ8DOEgyhtSeOizCoH/I/+aCWtvvbWqrGxVJ17OK3lhVodUMGFURszIMB4hD5yfl5igY/DK040Rkiw8kKFdCYWrKlzK6h2H3ax6E7gXmkCnB067OxpGv+lEFV0cZBnL+KAy7ibYvAQMQZhtsjLjGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047861; c=relaxed/simple;
	bh=NQM9ewEAOMuQm+se/Npgt3IKsTDh+L8SAE7Lj7MYFvU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M2T15ekIPPEe2f1mi9Jzny1vbu+tC89IDNqvwRkLfO+dE/0oH/crSYCjW/XmDrQFw6S05Hd9iFRlAbChotCGDJIc9nALrRk+lgT/o39zbQZEY8cj3FAxf9u/uy4x/+RLqx7WpQEOhZbFlthsA0FjLh8l4FrHZGWa9wvmqcF0TF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XNEtcZmM; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707047849; bh=6IHcRw4gkKhhZegzn1OH3uiNgGEL9LqQ6Vszdi2xy6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XNEtcZmMiwTlKiTLDHEiKAaqccfnTRiFpyYhr1a8JFjz1ie5yikEjhQnKH7vkYgz7
	 CHTKs9YKDYe/Oe/xiy4i0Fw4tWPAJ9HUptw6SBNl+ztuc3D6cHwVIN/ktTUUdlAKgB
	 6ArgbqrGn45Etw2lb9vcqIKCT+UHGH7WUY419Tp8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id CD5A4A7F; Sun, 04 Feb 2024 19:51:21 +0800
X-QQ-mid: xmsmtpt1707047481t8mna7hj6
Message-ID: <tencent_164AB8743976ED67863C2F375496E236B009@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25tidAIa0px2wHqSkcb+RQFaqhNT1q4VDqpL/DSKIkClttaSJejqZ
	 oQkl8S+6CuffNTMlObsck87wXme7JbMeTk+lamkaB6OuCt++r5qO+ML+T8y2grA5l7dbNvacBbYh
	 TvNDtN3P8c+7KO5ub0//l2rBseiVjyqka+F4eaFlRnZ1lsJCQBTRkWVnSLVmRNOMiazPYWkfzLe1
	 VuhCX/i3pKNyxllhBgUOmXp36UTFsAZb5C2qJ8Rgk5z1LeCjR/dzF8eFEzg8cEs8/i7iGdeMm+VY
	 pkHH//REvMxc1J+ekB6sFzSG8iZn3EDvsQKh3qLaD1KKeo1xMZNe1M4jw1uFuQsqcyeqo5cpo6pz
	 molP7pK75fiKAHEuPkp3lI7EIEnKSzow1tLQxzKPDuqXfUun3gv3NIyzFhrZK9IMkE9GcF+vXdkg
	 GMqSls4E8Vk5u+PHo6HUwhkkh4QgIaHl/QqWigg+44Ij4zn/+JjMq+B4TuMgc6OljGqjnqFq3TKQ
	 5tmdo2gJ11QzuF3UMhgqNGJjAcOXYUTFhc0fyNikJ3l0B9cY8EXcvO+roWAGsc3fIdgILdym+BcT
	 A+wviPpOlDD5yklMwEZSYOniE7yJst6BXNzcIdA7FSwSJcX89FsfsJvBH+fJM2c+X8zfovJ8AkD6
	 u/H9fjt4EbaBE50Z+GnW5cDEaFVWIPaQgPcVXQQrOxuNok8L413CTapaPGfC/1LPX6B59TlAMKJ0
	 b0wTGQqh05W4W5rCHrKDT0k6xWsZgo5af+NrMWtskF6DYYS1nEK6xu8sLNDz/Dl5j33Z6rhqqrmA
	 yAEG91SypdEb/Bq9p5t+p3ExNFsmy1OuLIZih4NWp1Iy4Wqyf6NMwUbLVYBG2HSzO/iEnqGF17RS
	 8uVMkuen2XwJt7pZN5W7PVpUtZLQIe8eCjmbgkGxxN11/+Gi8gTP6grpwVd19sOHSEQfPb3kL+RO
	 N35bq/MNQ=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] hfsplus: fix oob in hfsplus_bnode_read_key
Date: Sun,  4 Feb 2024 19:51:22 +0800
X-OQ-MSGID: <20240204115121.1906264-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c37a740610762e55@google.com>
References: <000000000000c37a740610762e55@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfs_brec_insert(), if data has not been moved to "data_off + size", the size
should not be added when reading search_key from node->page.

Reported-and-tested-by: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/brec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..9e0e0c1f15a5 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + 
+				(idx_rec_off == data_rec_off ? 0 : size));
 		hfs_brec_update_parent(fd);
 	}
 
-- 
2.43.0


