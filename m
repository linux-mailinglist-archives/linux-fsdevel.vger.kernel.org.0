Return-Path: <linux-fsdevel+bounces-38165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ADE9FD60D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 17:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0F316588A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399241F76AB;
	Fri, 27 Dec 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0LSy6b1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56D3D69
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Dec 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735317863; cv=none; b=jbagVJsJQAvpWsfY4teG/Gg2/X7jNEMjZrcmjtfP094yVaBrwZd4PJ7wyl2vQaYej9bJiaP4DLbbii414Rz2f6s97y7Zn/wuj4jUsw1fy3avSVvJMZLLkkdsdv2HDafSHLxYyab7u84aPG1+MtzRwL0FAsiC/bWfBqO9WScnp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735317863; c=relaxed/simple;
	bh=Ddqky6asYR+HEx0JjHKWJ+DwSBI4BiiSESdJ/JOSZso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlpBszD1PEZwonlbQ4Bk3gPz4X1lj5Csei7YwWGQS7npGm3HoXkYtySbI7hpEfC+PLlcs8IOJyodErrPnZNGzuE24Zgmd/x6Bli4gZMQQ2W7eQI9seWpwxvvpZSbEsUxYeSZpAxro8i4LM9/hdz5lAVr9Ocyg2fkijdU2Nw/YNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0LSy6b1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735317859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmaDO8t39DYdCrTTERy2FWhe4hvJtsqMCWb30Ppe+SA=;
	b=N0LSy6b1OrKaO36RoBxltRImhov53SByaalSGVT9LPSw6ZRgyJMuFVvt/uWVXaQYTQuTa5
	S5OeWDwOvb+Gd+vTR+nHmPBYFC0lY5pBwjj77lG/iUe+ACfwCbgA+BvzjWe2PGTqkmt+Gt
	jrnciwku+PLSTTIVUhrEJPm2Tl6HvqA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-3k4vK_9gNIiQAXUcMOa20Q-1; Fri,
 27 Dec 2024 11:44:18 -0500
X-MC-Unique: 3k4vK_9gNIiQAXUcMOa20Q-1
X-Mimecast-MFC-AGG-ID: 3k4vK_9gNIiQAXUcMOa20Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A929C1955F42;
	Fri, 27 Dec 2024 16:44:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6FA051956086;
	Fri, 27 Dec 2024 16:44:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 27 Dec 2024 17:43:52 +0100 (CET)
Date: Fri, 27 Dec 2024 17:43:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <20241227164348.GB15300@redhat.com>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <CAHk-=wj5A-fO+GnfwqGpXhFbfpS4+_8xU+dnXkSx+0AfwBYrxA@mail.gmail.com>
 <20241226201158.GB11118@redhat.com>
 <CAHk-=whRnW3e3g5PkEtH6geVVYZO2MPUH4ZV5a=khePC9evY4g@mail.gmail.com>
 <20241226205746.GC11118@redhat.com>
 <20241227155428.GA15300@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227155428.GA15300@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 12/27, Oleg Nesterov wrote:
>
> Consider
>
> 	int main(void)
> 	{
> 		int fd[2], cnt;
> 		char c;
>
> 		pipe(fd);
>
> 		if (!fork()) {
> 			// wait until the parent blocks in pipe_write() ->
> 			// wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));
> 			sleep(1);
>
> 			for (cnt = 0; cnt < 4096; ++cnt)
> 				read(fd[0], &c, 1);
> 			return 0;
> 		}
>
> 		// parent
> 		for (;;)
> 			write(fd[1], &c, 1);
> 	}
>
> In this case the child will wakeup the parent 4095 times for no reason,
> pipe_writable() == !pipe_pull() will still be true until the last
> read(fd[0], &c, 1) does
>
> 	if (!buf->len)
> 		tail = pipe_update_tail(pipe, buf, tail);
>
> and after that the parent can write the next char.

perhaps something like below makes sense in this particular case.
Incomplete and ugly, just for illustration.

Oleg.

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..b8eef9e75639 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -253,7 +253,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	size_t total_len = iov_iter_count(to);
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
-	bool was_full, wake_next_reader = false;
+	bool was_full, xxx, wake_next_reader = false;
 	ssize_t ret;
 
 	/* Null read succeeds. */
@@ -277,6 +277,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		unsigned int head = smp_load_acquire(&pipe->head);
 		unsigned int tail = pipe->tail;
 		unsigned int mask = pipe->ring_size - 1;
+		xxx = false;
 
 #ifdef CONFIG_WATCH_QUEUE
 		if (pipe->note_loss) {
@@ -340,8 +341,10 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				buf->len = 0;
 			}
 
-			if (!buf->len)
+			if (!buf->len) {
 				tail = pipe_update_tail(pipe, buf, tail);
+				xxx = true;
+			}
 			total_len -= chars;
 			if (!total_len)
 				break;	/* common path: read succeeded */
@@ -398,7 +401,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		wake_next_reader = false;
 	mutex_unlock(&pipe->mutex);
 
-	if (was_full)
+	if (was_full && xxx)
 		wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
 	if (wake_next_reader)
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);


