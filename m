Return-Path: <linux-fsdevel+bounces-30048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330D985604
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092401F24451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847913D291;
	Wed, 25 Sep 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olhBCLWU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD3156222
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255124; cv=none; b=aeTdki1sDrXs/nc3QpoQdb12aigfTieoiVFEzQED9gKA+mHa8yYZ04OI09mWWOZmUJkbOnZcXBOtmow6wS1Yb/xhzdlL/5CLVl7t9fziCvfgVmYTGkYNeRNXrXVV8DgZdnMW1IfIyuOLI+xa5ek+BsPqKm5vtxECoXswUTk6IwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255124; c=relaxed/simple;
	bh=KeO65vodHgmpUQvTI9PB2YFDaLPirslzRU5NIxJohfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyrfBGsSjqPRaJjrCnjerm0lV54bKyBvhoyCNhHZ3GMgbnR6RgW/DEonsH3vHGvPLlqkv5FIchKcDkPl4Y197OkDSrL1udScZdLfWi57KAOAGZg5kCTEMNiMPJMPpSqTtwkte77CjoG+4uil9ey3TQfahtUpvmXuf18gr06CJPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olhBCLWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9CAC4CEC3;
	Wed, 25 Sep 2024 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727255123;
	bh=KeO65vodHgmpUQvTI9PB2YFDaLPirslzRU5NIxJohfw=;
	h=From:To:Cc:Subject:Date:From;
	b=olhBCLWUglYsi9KuxFq/211dqvT7ytvyp0pxxaLS+PrTJvK31Y0+SRK5tneyaG5yn
	 e/rh4QuPUejSP8uACrtSntEKCfnNWXLYJ9SH6kFJ5sFGsX9rOcwSYjGZkvu3Tkm376
	 M9DsO1B5XOL75KQUNpDJWw0VxfVZpw8dv+2jeqUji51wClGNoYC35ZCfDczZP0jCQN
	 wlZ4o3ZXUbvJ2RpSYDjMJN8guF53e1NBQP+8DJr3Eebf/4nyNuyX1jtBTO72PdBDN5
	 HsiqjVfzI5FT+0PsCGwjXtdeH0R68EBN8g6ewY2mjmObSzyJ9c2UG57pXvFHliTgZk
	 yQ2ZtgEJIeELA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk,
	syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
Subject: [PATCH] epoll: annotate racy check
Date: Wed, 25 Sep 2024 11:05:16 +0200
Message-ID: <20240925-fungieren-anbauen-79b334b00542@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=brauner@kernel.org; h=from:subject:message-id; bh=KeO65vodHgmpUQvTI9PB2YFDaLPirslzRU5NIxJohfw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9vuQjVKf2vu7Zsc8nNHm+GvPPWjinx6CkNDLt/mIbH zszB1fujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlInmX4Z948Z/HsFKNvs7Xu O/kbN69oexTuHrzHaW6hbcW0x0/PMTAytPjXHPLUnczZyB706anqaZ/plpvXLwycvoXbjaeL+c4 6XgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Epoll relies on a racy fastpath check during __fput() in
eventpoll_release() to avoid the hit of pointlessly acquiring a
semaphore. Annotate that race by using WRITE_ONCE() and READ_ONCE().

Link: https://lore.kernel.org/r/66edfb3c.050a0220.3195df.001a.GAE@google.com
Reported-by: syzbot+3b6b32dc50537a49bb4a@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c            | 3 ++-
 include/linux/eventpoll.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..fa766695f886 100644
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
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd..0c0d00fcd131 100644
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
2.45.2


