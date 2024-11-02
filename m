Return-Path: <linux-fsdevel+bounces-33525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88449B9D0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE13B1C21F29
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7703A18A944;
	Sat,  2 Nov 2024 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="d8aabBWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB153BF7;
	Sat,  2 Nov 2024 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524114; cv=none; b=nDdOZpAK9trwbQ+xIYK2Q9iV4GA3KIYawwu6nC+vcurFw8yfOeYdb9vtgOJCbIvqwFY8YchtAFry6NED/xUQHTm1lhGrmLarMghU7KTicfRNdBq6fC9+pKyJskMZB5b5XyDZdZzDI9VF5RcxF/r5ZbwIPYsoj0XPVnOD9kQuuSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524114; c=relaxed/simple;
	bh=yurPUE3BC0wRqLY1D8u4wRlLV+idEwKbpMZZ5rjuZWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFexZdq4hYYJYw5ePn1/BAeSswI25QS0Gihve9OySfJ11gj7/B/TdW0pYTG0fZ2Ponqg65xK/uZctyFqdwgfD096KZBDbW4HOgNU/AGfjbJaoHfUVjGmM/TUwHRAg6MJqSX51/cl3CnHdQregQUz/PHL7N3rv0EBkjkEnNOdYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=d8aabBWO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hxqFjXnH7BwPpg5y6pfARQakEFU/n1A9zdRfJDGPNUE=; b=d8aabBWOPN3NHgeyjx9apgquGh
	5hSsBLQWfQtSokKSHnYccfabiHexKRN3g35ymSBsnDKvvGW6Dd7MZ2m2mMxVWB+4pvrrkQBUIStOS
	R1NZrMnlXQoUy5vGiPi8SeTauF22/Uj6/vSH5fj1zN/mI7GswFWsQ/2gr++t3Bf9AN1WWCb/iswfn
	qoxTU3Oj6OunR8gRckx6phVqRqXg1c8udvDKjCBBXDBnsKGAS5vjqlxZvL6EIxF7reMHo5f4M+5I/
	iHkXzuqEdBo+ct6MKlcy52cFlb+OX2DbK07MjqcRs3pp583QU0UxzF9/DutFC67tP/BX3nTFunsJd
	ocfjNgmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHoE-2WfP;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 24/28] do_pollfd(): convert to CLASS(fd)
Date: Sat,  2 Nov 2024 05:08:22 +0000
Message-ID: <20241102050827.2451599-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

lift setting ->revents into the caller, so that failure exits (including
the early one) would be plain returns.

We need the scope of our struct fd to end before the store to ->revents,
since that's shared with the failure exits prior to the point where we
can do fdget().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/select.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index b41e2d651cc1..e223d1fe9d55 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -855,15 +855,14 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 				     __poll_t busy_flag)
 {
 	int fd = pollfd->fd;
-	__poll_t mask = 0, filter;
-	struct fd f;
+	__poll_t mask, filter;
 
 	if (fd < 0)
-		goto out;
-	mask = EPOLLNVAL;
-	f = fdget(fd);
-	if (!fd_file(f))
-		goto out;
+		return 0;
+
+	CLASS(fd, f)(fd);
+	if (fd_empty(f))
+		return EPOLLNVAL;
 
 	/* userland u16 ->events contains POLL... bitmap */
 	filter = demangle_poll(pollfd->events) | EPOLLERR | EPOLLHUP;
@@ -871,13 +870,7 @@ static inline __poll_t do_pollfd(struct pollfd *pollfd, poll_table *pwait,
 	mask = vfs_poll(fd_file(f), pwait);
 	if (mask & busy_flag)
 		*can_busy_poll = true;
-	mask &= filter;		/* Mask out unneeded events. */
-	fdput(f);
-
-out:
-	/* ... and so does ->revents */
-	pollfd->revents = mangle_poll(mask);
-	return mask;
+	return mask & filter;		/* Mask out unneeded events. */
 }
 
 static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
@@ -909,6 +902,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 			pfd = walk->entries;
 			pfd_end = pfd + walk->len;
 			for (; pfd != pfd_end; pfd++) {
+				__poll_t mask;
 				/*
 				 * Fish for events. If we found one, record it
 				 * and kill poll_table->_qproc, so we don't
@@ -916,8 +910,9 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
 				 * this. They'll get immediately deregistered
 				 * when we break out and return.
 				 */
-				if (do_pollfd(pfd, pt, &can_busy_loop,
-					      busy_flag)) {
+				mask = do_pollfd(pfd, pt, &can_busy_loop, busy_flag);
+				pfd->revents = mangle_poll(mask);
+				if (mask) {
 					count++;
 					pt->_qproc = NULL;
 					/* found something, stop busy polling */
-- 
2.39.5


