Return-Path: <linux-fsdevel+bounces-35669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C5C9D6E95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C5328137A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86E19B5B8;
	Sun, 24 Nov 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejAjUmCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D815CD78;
	Sun, 24 Nov 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452089; cv=none; b=aOX5Le42uM1n2QeZDvIArzLXDfE9N2OIPy7NFyuoIr9AoWtEDuLa51Sv/SdN8DlSaNUoGGm2oK5ynlBIPXDpiMyCpqR3lFttoLmNmaQ994C6/60mgGYJ1Sp7EhpFRdEYyu/X9bMXcPgNbM4cucVXzYk39sS+DxRO5/qvBth2EyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452089; c=relaxed/simple;
	bh=0D9xhHepQPzxIJtCZNP6S3YT7qLq7nKYk3vHfPFPVVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYKeaywFYynRaZ/uovi+lFW6XtkgSNB5gMlWiZPG74XTpSHnHT4Dq3XuiAVmOwwAJHnBjBW3y4yGw5hu9WQ466/TtB2Xjh6EunPpY8HZ3/eleYSKurJ2kTo4grARyiqd3a6m1ZAnGiP20dNpVgxjLKInFwr0TIHGTiwOsgmH0C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejAjUmCQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE947C4CECC;
	Sun, 24 Nov 2024 12:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452088;
	bh=0D9xhHepQPzxIJtCZNP6S3YT7qLq7nKYk3vHfPFPVVg=;
	h=From:To:Cc:Subject:Date:From;
	b=ejAjUmCQwrHmLrgd1x+ca6/9HryM6rf1UVr6ESRMl/dCbQLcFtScX3+zt4QwVT6mG
	 klyg+JUDTtK6lIUogGkLNxt1FFo+NUjXdzlqs2SsLRszNiv+0tACTwgkREzzsZ8zx9
	 2Jn04yhtlLIwaCoXx15pA1/HkdgIcOoLIIRMx9sGmjUwi6Hej25qZtb0nzrjp6jbEn
	 doA/LGRsR/8gQeLKn5YSwKEjMIettr5PrHZn1P4wsRwMBn5KcWRuB6SktHTb6CDjTd
	 f84s8FRrNDqtXHkEhDz9SSdlOER/qYAoZQu2Q1sLxLQRcXuDP5Lj5rH0uMNHdLaBIc
	 6cEv6FRYEfKnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/7] epoll: annotate racy check
Date: Sun, 24 Nov 2024 07:41:12 -0500
Message-ID: <20241124124126.3336691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 7221072f39fad..f296ffb57d052 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -703,7 +703,8 @@ static int ep_remove(struct eventpoll *ep, struct epitem *epi)
 	to_free = NULL;
 	head = file->f_ep;
 	if (head->first == &epi->fllink && !epi->fllink.next) {
-		file->f_ep = NULL;
+		/* See eventpoll_release() for details. */
+		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {
 			struct epitems_head *v;
 			v = container_of(head, struct epitems_head, epitems);
@@ -1467,7 +1468,8 @@ static int attach_epitem(struct file *file, struct epitem *epi)
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


