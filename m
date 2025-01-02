Return-Path: <linux-fsdevel+bounces-38328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130049FFA2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 15:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C4C16039E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F41AB51F;
	Thu,  2 Jan 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yz96pmI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB942A1AA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735826871; cv=none; b=RPzNZehWIms4FSeRdprO3n02hudnbg0ESptzuYOEwApgNDgUdqh/dUmTFWFoqQ3AeZu2bFXKfy39y5TCvWUGwLJuB4w0TUwuAekKj9IS0BrUy6oyBVqGW0A6LgNDTu+yk8vT8VCWmE+W5kon1HKDQQTPQO8ZFvie2e1Cu+VQMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735826871; c=relaxed/simple;
	bh=SP6tOQ7+qMLzDmf69LS1bmdqrJlP9ctGwg+tzao5ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OuJx3Uphcy8lgmuXHyrx73+sECDGkORmo0sQfwh4RrcBiqssPeHNq7O4difWNNFx+j0tS3wb1Lf4HU2DiY8rdO/GXvNnf9vwJtR9pDZ4YhlFzsPhwK1GqyIrymveZtqIgRDNOQdNQNpNFgc7wm/0oiSgnZGMGCkOdyj/zLSSsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yz96pmI2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735826868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=axvnViIZa7VkYB1PPxwTNw9Zy5DI90SrXFQ66G7kX5w=;
	b=Yz96pmI29hseur/5o1SA0OKBE5sbbls2ohvs7ZWTmQyTZXBGblg0ntIOgy82tkiI4xrSa6
	a+PnjRD3HSdEMzNYdP7FUHMGLj1i7lu9AgRe/YpqrulkPwWr7f4BMA9Kmd5Nkk4QCXJs+u
	suDTG8TGd9eK/tBqS6qegXvCLOAS4Cc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-hw9gmk2WMoq1lbgjZOUOSQ-1; Thu,
 02 Jan 2025 09:07:45 -0500
X-MC-Unique: hw9gmk2WMoq1lbgjZOUOSQ-1
X-Mimecast-MFC-AGG-ID: hw9gmk2WMoq1lbgjZOUOSQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 059E419560B7;
	Thu,  2 Jan 2025 14:07:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C857019560AA;
	Thu,  2 Jan 2025 14:07:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Jan 2025 15:07:19 +0100 (CET)
Date: Thu, 2 Jan 2025 15:07:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
Message-ID: <20250102140715.GA7091@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

wake_up(pipe->wr_wait) makes no sense if pipe_full() is still true after
the reading, the writer sleeping in wait_event(wr_wait, pipe_writable())
will check the pipe_writable() == !pipe_full() condition and sleep again.

Only wake the writer if we actually released a pipe buf, and the pipe was
full before we did so.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pipe.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..82fede0f2111 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	bool was_full, wake_next_reader = false;
+	bool wake_writer = false, wake_next_reader = false;
 	ssize_t ret;
 
 	/* Null read succeeds. */
@@ -264,14 +264,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	mutex_lock(&pipe->mutex);
 
 	/*
-	 * We only wake up writers if the pipe was full when we started
-	 * reading in order to avoid unnecessary wakeups.
+	 * We only wake up writers if the pipe was full when we started reading
+	 * and it is no longer full after reading to avoid unnecessary wakeups.
 	 *
 	 * But when we do wake up writers, we do so using a sync wakeup
 	 * (WF_SYNC), because we want them to get going and generate more
 	 * data for us.
 	 */
-	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 	for (;;) {
 		/* Read ->head with a barrier vs post_one_notification() */
 		unsigned int head = smp_load_acquire(&pipe->head);
@@ -340,8 +339,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				buf->len = 0;
 			}
 
-			if (!buf->len)
+			if (!buf->len) {
+				wake_writer |= pipe_full(head, tail, pipe->max_usage);
 				tail = pipe_update_tail(pipe, buf, tail);
+			}
 			total_len -= chars;
 			if (!total_len)
 				break;	/* common path: read succeeded */
@@ -377,7 +378,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		 * _very_ unlikely case that the pipe was full, but we got
 		 * no data.
 		 */
-		if (unlikely(was_full))
+		if (unlikely(wake_writer))
 			wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 
@@ -390,15 +391,15 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		if (wait_event_interruptible_exclusive(pipe->rd_wait, pipe_readable(pipe)) < 0)
 			return -ERESTARTSYS;
 
-		mutex_lock(&pipe->mutex);
-		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
+		wake_writer = false;
 		wake_next_reader = true;
+		mutex_lock(&pipe->mutex);
 	}
 	if (pipe_empty(pipe->head, pipe->tail))
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
 
-	if (was_full)
+	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
-- 
2.25.1.362.g51ebf55



