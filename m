Return-Path: <linux-fsdevel+bounces-38242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4729FDF33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 14:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766057A124F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58F17B50A;
	Sun, 29 Dec 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCAMcrm8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF01487FA
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735480692; cv=none; b=Iz5NugRYRKCF3V66qvJQftCjPKdvjnum9LF5+0EuZMlcI6/rDsKtYK7a2tlnypzmWCfkB9/onfdM5BClHePTV8VZlvUSfASChdl4VJrGf0s9eUEAlifgIlknugmjH0/IYu+nAOzub/54rY2res32swKbYWLzu8gdligm0TcfB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735480692; c=relaxed/simple;
	bh=CeyWTsicRjCGf57NsRgCwLsiCCMa/XrJHUBCm/RWiE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ln+wRGD1jPmfmiinxWU4vErA6V1nJ9tHkpxuZo5l4UjfAawQuTKtKTqo+Juml2j4W7f0BHlneIV5fSSipV9GJT2jULHrd/mNE1a81Jx6vnKTI6rQ4RM49vRelfcly1PpGDZiXwAqXi/zKY+YLgEGssXNPl2uFh3+kx08zLHwxs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCAMcrm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735480689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JOhmY6mJI+wprjoXJtAk4llUdfeFLMkjdkO4X7vaca0=;
	b=UCAMcrm8QEbkAunAec/Olsb66Tkn2ZZ3M5VTGXTTtJaV8/iZI9vmb3TSXiDi5o5q2tu1OW
	Yyc/tLJmLSYckiV23/cjE6KucV4eVuUNJaNP/KQn3F1ngNsIH9a2h0Rwu1mOuaI5pAjQob
	375x4BsumH/f2p0GrtpbyYHrAZjTOjs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-SS5qo2A2PuqUfF7gITEIMg-1; Sun,
 29 Dec 2024 08:58:08 -0500
X-MC-Unique: SS5qo2A2PuqUfF7gITEIMg-1
X-Mimecast-MFC-AGG-ID: SS5qo2A2PuqUfF7gITEIMg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CA391956087;
	Sun, 29 Dec 2024 13:58:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3C69D19560A2;
	Sun, 29 Dec 2024 13:58:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 29 Dec 2024 14:57:42 +0100 (CET)
Date: Sun, 29 Dec 2024 14:57:37 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: PATCH? avoid the unnecessary wakeups in pipe_read()
Message-ID: <20241229135737.GA3293@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The previous discussion was very confusing, let me start another thread.
This is orthogonal to the possible wq_has_sleeper() optimizations in fs/pipe.c
we discussed before.

Let me quote one of my previous emails. Consider

	int main(void)
	{
		int fd[2], cnt;
		char c;

		pipe(fd);

		if (!fork()) {
			// wait until the parent blocks in pipe_write() ->
			// wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
			sleep(1);

			for (cnt = 0; cnt < 4096; ++cnt)
				read(fd[0], &c, 1);
			return 0;
		}

		// parent
		for (;;)
			write(fd[1], &c, 1);
	}

If I read this code correctly, in this case the child will wakeup the parent
4095 times for no reason, pipe_writable() == !pipe_pull() will still be true
until the last read(fd[0], &c, 1) does

	if (!buf->len)
		tail = pipe_update_tail(pipe, buf, tail);

and after that the parent can write the next char.

Does the patch below make sense? With this patch pipe_read() wakes the
writer up only when pipe_full() changes from T to F.

Still incomplete, obviously not for inclusion. But is it correct or not?
I am not sure I understand this nontrivial logic...

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..27ffb650f131 100644
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
@@ -271,7 +271,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
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
 
@@ -391,14 +392,14 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 			return -ERESTARTSYS;
 
 		mutex_lock(&pipe->mutex);
-		was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 		wake_next_reader = true;
+		wake_writer = false;
 	}
 	if (pipe_empty(pipe->head, pipe->tail))
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
 
-	if (was_full)
+	if (wake_writer)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);


