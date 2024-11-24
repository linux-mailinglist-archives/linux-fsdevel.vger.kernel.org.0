Return-Path: <linux-fsdevel+bounces-35667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA59E9D6E5E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C25C162209
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FAE1B393C;
	Sun, 24 Nov 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fadSIDUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36D41B392A;
	Sun, 24 Nov 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452023; cv=none; b=TSJMsGSQjVHpeFzFrZyQpb/vdH2flmlxhZaLKRMzzqZCwTMxVzT7cdFqF3QyFxNF+HX0W0GiI3iECQmMU0g8kxpBaiOacS5AyoFCZCDWH6jUTBI1LfdtyRR9uTqwuIEgbawtAEGTzedXp3tYBS+Jt8BSeMu8xSRw+C04oUpo9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452023; c=relaxed/simple;
	bh=v1UNg7CvdP5kgv/xGfCT8szD1eimjdAibJNs4bWPmUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPJSlit2gykEU7ekkT/RS9wIyVRroTw0SV67FmJj9FKBzXziWzVTpzX/2/QwFbOJj71lEbOfzin6ECL29MXFxFzxYZ924R8Pbrg3j4gDC1rErMIrytFvosb9gm86cEWlng72pz4FBPcb+4RsMzwIed/GQeVP+inhIBSGhsg4uVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fadSIDUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10DFC4CECC;
	Sun, 24 Nov 2024 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452022;
	bh=v1UNg7CvdP5kgv/xGfCT8szD1eimjdAibJNs4bWPmUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fadSIDUY/uVWhKHLXqQaRCAj5UILDJhUNJq3R+SECo8nKAVqpoMhith15O2lbsuo+
	 6Z0NIACUtr1lmXuYZC+n/E9+p/fc3TBEKBY6C1gZNKlrajBdnw8ZjDPyt09q051D3b
	 HsJRWrTcKvuLq6YvgdOgVjN1nMlgavxLkL09lnh2+jwL+/kg2GVidbMmJslZnjEjwm
	 yEbtG2aUr8gCDIbpp2NdIyb9FnG0ZIeWHMV5ZlWAKTJPu1RBaYqWpbdi+DSXVAXeKi
	 XPBR4LcuV2cM+iQlMupJkIT3ReVR0d6zFrVdeffxatWb0fupAqn0Wh7RkJya2Tonxz
	 IKVvoJurHV0Lw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 04/16] epoll: annotate racy check
Date: Sun, 24 Nov 2024 07:39:41 -0500
Message-ID: <20241124124009.3336072-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 6d0e2f547ae7d..7428450920525 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -823,7 +823,8 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	to_free = NULL;
 	head = file->f_ep;
 	if (head->first == &epi->fllink && !epi->fllink.next) {
-		file->f_ep = NULL;
+		/* See eventpoll_release() for details. */
+		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
 			struct epitems_head *v;
 			v = container_of(head, struct epitems_head, epitems);
@@ -1603,7 +1604,8 @@ static int attach_epitem(struct file *file, struct epitem *epi)
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


