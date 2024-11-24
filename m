Return-Path: <linux-fsdevel+bounces-35670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E19D6EAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6EBB21FD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547381A9B43;
	Sun, 24 Nov 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVdgOD/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B301A3035;
	Sun, 24 Nov 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452112; cv=none; b=Wle0QHKH68/inJqFx54CBuT4tdWi6FDoholtGiyaJxGUhy+QFT9k73Z3PYeAl5WmY7+kPfqnkHTiHWkMs+mAlIOkPohgUlweYIZPeaS0S6VjlsTZimbjxjbzrBOgdtnoluCcBPiSTYGMe/Hj3i5giqEvYVMW+C6RSRTZ3hSYPh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452112; c=relaxed/simple;
	bh=ICKaszo58/M5MTx56qX3+bvtjH6Qm1RGqc6/gEmFHjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDZvIJ+E1pnw/QRmYd9jjwnxEdu3EWhvg1LkUzqHJuYA7QHsSv6hNmD+am7zdIUF0y1z6YpDlaMhuPGawk9WgCVszPKKXumjJlaRD9C3XZaUlzVFd/KNlw/bRbG2ZiaBw6APtAuFaqOa3Y1Ci331I717uudUhWKApyjctbD5+Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVdgOD/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD3FC4CECC;
	Sun, 24 Nov 2024 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452112;
	bh=ICKaszo58/M5MTx56qX3+bvtjH6Qm1RGqc6/gEmFHjY=;
	h=From:To:Cc:Subject:Date:From;
	b=UVdgOD/6SUSEPxCYvSubrs3tQoGa844K3nQHV9MWtP4j3ELy7hQDRoHPexy8pNyRw
	 7uerOq2q8hNQUmBrHj32gRUdNGUDi/k+BAlWcyD2FFb4MHmYCE6l8Iykg1De5HRL5/
	 ZkQ0DdYTINFOYIZKMX9izVplk/+dHJxKmLsoiap0guBJ/1tjYgnptFHuolbZR2px99
	 Lk6fdSo+u1j8mf7maE4KqRFTbltYvh23D3t7AqPVcHNANU9w+1oOneECRyfAPlXuWn
	 ErXGWJMCbZDtjTkCktSLzn/BGRaLG7P9Ri++cD7bRlfbAmHjjEy+DGSXIvaHgA9TgU
	 002kVxfDvfWOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/6] epoll: annotate racy check
Date: Sun, 24 Nov 2024 07:41:37 -0500
Message-ID: <20241124124149.3336868-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 6474353a5e3d0b2cf610153cea0c61f576a36d0a ]

Epoll relies on a racy fastpath check during __fput() in
eventpoll_release() to avoid the hit of pointlessly acquiring a
semaphore. Annotate that race by using WRITE_ONCE() and READ_ONCE().

Link: https://lore.kernel.org/r/66edfb3c.050a0220.3195df.001a.GAE@google.com
Link: https://lore.kernel.org/r/20240925-fungieren-anbauen-79b334b00542@brauner
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c            | 6 ++++--
 include/linux/eventpoll.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index b60edddf17870..7413b4a6ba282 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -696,7 +696,8 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	to_free = NULL;
 	head = file->f_ep;
 	if (head->first == &epi->fllink && !epi->fllink.next) {
-		file->f_ep = NULL;
+		/* See eventpoll_release() for details. */
+		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
 			struct epitems_head *v;
 			v = container_of(head, struct epitems_head, epitems);
@@ -1460,7 +1461,8 @@ static int attach_epitem(struct file *file, struct epitem *epi)
 			spin_unlock(&file->f_lock);
 			goto allocate;
 		}
-		file->f_ep = head;
+		/* See eventpoll_release() for details. */
+		WRITE_ONCE(file->f_ep, head);
 		to_free = NULL;
 	}
 	hlist_add_head_rcu(&epi->fllink, file->f_ep);
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd6..0c0d00fcd131f 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -42,7 +42,7 @@ static inline void eventpoll_release(struct file *file)
 	 * because the file in on the way to be removed and nobody ( but
 	 * eventpoll ) has still a reference to this file.
 	 */
-	if (likely(!file->f_ep))
+	if (likely(!READ_ONCE(file->f_ep)))
 		return;
 
 	/*
-- 
2.43.0


