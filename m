Return-Path: <linux-fsdevel+bounces-35668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 024AD9D6E8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D73162DE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A541CDFD5;
	Sun, 24 Nov 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5cf9X7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50225190692;
	Sun, 24 Nov 2024 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452060; cv=none; b=EcFFtQBCUxH0BTpuaVRnLJSsIZWRdnDsRAmqjwqabZOCUOdnyP7ClrxV9lSfVpnP1ZfBleYKYEi2hd+RwNh7e6LmomjoMozD4Y6UUiynYqud8Bip3AqkouJRIxsPe7q/tlPTmmXCEApOwdv4iDaEYT6aK8t9RUYZ/gi1THWiAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452060; c=relaxed/simple;
	bh=4yBSHkSDUFaiIrpu1f34X7EqbVTnfC/+QQucMcpGif4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qF0GdgDp9HYcRzIBRTJvwIF5HOscAlHcBeJBRW7ZtJXxdfy0n0AkfaZcNfAzikyI2Lr+1bXLsjScaF3Ol/T/LEWEas1dxey1cFwLGMIratqO7USzlCp8OijToojbnCkDCT34ehSXXIGxwnj/JohbjdSEDhoZkH5Z+9uNhqLIgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5cf9X7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45774C4CECC;
	Sun, 24 Nov 2024 12:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452060;
	bh=4yBSHkSDUFaiIrpu1f34X7EqbVTnfC/+QQucMcpGif4=;
	h=From:To:Cc:Subject:Date:From;
	b=X5cf9X7KQ1EVYBOeMAHoTtSWTPLS2WqF8+laBqKJzo4U1Nx9etLpP3Edli71VSTsz
	 029MD2p5nxhrH3oWIApaP0zCIUH3ZdUtRNpTS0jUhTKFXywR8h2bh5blFpJScKQXov
	 PEaDL2lmuAES4Q/e4DkusawVCeyP/BFiVBaKzM5JGIWeQWOFG279LqKPi8ShXPHxs7
	 RWJ1vc4z3QtSX8RcwC+H8NoTVJM/HD/ohbEnqd4kxzgQ2CmbVyuZsa/1Akpvi9jsBy
	 li+PRpD3mJE4r0I3zkPvE6z7H0ri85fvBfElC4lbYOgrx9gX3uzpROeIBy3fEknK6c
	 UGUoe9XoJkqSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 1/9] epoll: annotate racy check
Date: Sun, 24 Nov 2024 07:40:39 -0500
Message-ID: <20241124124057.3336453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 0ed73bc7d4652..bcaad495930c3 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -741,7 +741,8 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 	to_free = NULL;
 	head = file->f_ep;
 	if (head->first == &epi->fllink && !epi->fllink.next) {
-		file->f_ep = NULL;
+		/* See eventpoll_release() for details. */
+		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
 			struct epitems_head *v;
 			v = container_of(head, struct epitems_head, epitems);
@@ -1498,7 +1499,8 @@ static int attach_epitem(struct file *file, struct epitem *epi)
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


