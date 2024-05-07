Return-Path: <linux-fsdevel+bounces-18969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE1E8BF271
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C5D2855C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F1E200133;
	Tue,  7 May 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGRBHtBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64451200118;
	Tue,  7 May 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123604; cv=none; b=HRMm7avJ8ghnKtkCUrlRORFWB1cUZO/nxUl4ju+X0PG2r5wMuQt45Pl0Qn48KHjMpcla1+dfjR3RKrudNjhZWwBDyLvLbRuGIebJaDL/cNvp8AilHqBHAjmNtKe2qpwvp2v5OLzT3wIC7lwWsOozcu4OGU8fl5OWH27rHZYX7Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123604; c=relaxed/simple;
	bh=Kkn5Q1zAH2ZDxZMDU2NxkdDU68U1JVkpW8MrlekulRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfXXqf7NDUT7wazWs6R+sIIo+YLZC6JFK3PkzU2rznxUSWMb9RhXc+a4u7mDFNkao/8zZn1gJ9zCnfgNdcmp3+515ZHwyytg2GFghNIDXBGLa2UY460bPGHTUEfUrEJ16gpZRSI++bYWuBvxIIxBA7AKrPo/C/wBvD4Oi7SfUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGRBHtBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493FCC3277B;
	Tue,  7 May 2024 23:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123604;
	bh=Kkn5Q1zAH2ZDxZMDU2NxkdDU68U1JVkpW8MrlekulRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGRBHtBRuQFuWTZm9jwvtJpc0Ia4uqX8TEl0KEzHCHuerBDDSolecjmWuhpdiZMTB
	 eZbf7lwOkaqqHlAxYz121LUfKFLRJAZ/jNgXIVSXz0TGF9l+tx9vATmt1HglKtOq9q
	 AJCbN/wCggDDTl+o6HfqxfIkqNNRNXa9HnKuMUGwSokibD4Grvwo1mgElqiBR61enr
	 SgB9WJ7Je8EVoyLOWEHAza/NTAAJyPgF5DHp7Tt721zZGNtjHeMIdf4tLOylAMolQe
	 rjIEsvRzVK7ScLazr9A/6t9WtPObdSd4ACfAa/aoQj7tmFxBB5wClGGCZ239Bp5Kt0
	 ZOlTkQFeVd6AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 25/25] epoll: be better about file lifetimes
Date: Tue,  7 May 2024 19:12:12 -0400
Message-ID: <20240507231231.394219-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 4efaa5acf0a1d2b5947f98abb3acf8bfd966422b ]

epoll can call out to vfs_poll() with a file pointer that may race with
the last 'fput()'. That would make f_count go down to zero, and while
the ep->mtx locking means that the resulting file pointer tear-down will
be blocked until the poll returns, it means that f_count is already
dead, and any use of it won't actually get a reference to the file any
more: it's dead regardless.

Make sure we have a valid ref on the file pointer before we call down to
vfs_poll() from the epoll routines.

Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
Reported-by: syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/eventpoll.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eccecd3fac90c..7221072f39fad 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -839,6 +839,34 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
@@ -847,14 +875,22 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file = epi_fget(epi);
 	__poll_t res;
 
+	/*
+	 * We could return EPOLLERR | EPOLLHUP or something, but let's
+	 * treat this more as "file doesn't exist, poll didn't happen".
+	 */
+	if (!file)
+		return 0;
+
 	pt->_key = epi->event.events;
 	if (!is_file_epoll(file))
 		res = vfs_poll(file, pt);
 	else
 		res = __ep_eventpoll_poll(file, pt, depth);
+	fput(file);
 	return res & epi->event.events;
 }
 
-- 
2.43.0


