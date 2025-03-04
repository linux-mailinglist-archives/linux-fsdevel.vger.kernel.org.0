Return-Path: <linux-fsdevel+bounces-43121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39FA4E515
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 17:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A859E19C73DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320FD299B5A;
	Tue,  4 Mar 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erV+BR4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D2201256
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103095; cv=none; b=LB1EYXkrXCUtR7W/WcKwX+Z5JppfcSRcRouQMlYGse5sqAv6NPjyeKVPSGQGt2mg8/HHk+eKUDnmq4JYo+7wA/WBQokY92KtSfZmVREpT3ki75DyDSKS9T2W1M5oyrw1QIIsuF+JmXVKc2tcwS42UUZxP6uHhh+BIeZQtzMeg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103095; c=relaxed/simple;
	bh=P7zlqxS73dBlTunRicBMxfpsw7GvNiWmDWbC7VkkOnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcmwVUK2cB8KXQLjAtaiEAwYHNCj8dOnlq+kA/4uqrFbcZtShfhVGo7zHgcMqMdTy58YwnAj3eij+/yupiY+gUXUTNqrbIiXese+ejPl87dIwOQRVLkbU/+Cd3A9M7LTGcKs2EMiSSVVXyAMKsWGuLgWCL5abt8v4lKZ4L8L/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erV+BR4g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl83TUzrsDMAxwdtPBM+T12tQFrYoJHVzO8Es+0i5IA=;
	b=erV+BR4gf4MEBu0clhWMtxNsg9c8JMSYUMF37RGWy5m7xfhvitJVZlWgDMkmIOvN4bYhMO
	/chPqWMKER1imAqumLKCWRx3kO/JmuOasCmPrgJg8xyQF2eqYJXYQhg1ptYaA6h0AjkGDx
	7imhScyEqIkQzl7OePqpGsohewHkgYU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-_D6eKitbNrSWX_du191Xww-1; Tue,
 04 Mar 2025 10:44:49 -0500
X-MC-Unique: _D6eKitbNrSWX_du191Xww-1
X-Mimecast-MFC-AGG-ID: _D6eKitbNrSWX_du191Xww_1741103087
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA0CF18EB2D3;
	Tue,  4 Mar 2025 15:44:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.246])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B562E1800947;
	Tue,  4 Mar 2025 15:44:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  4 Mar 2025 16:44:16 +0100 (CET)
Date: Tue, 4 Mar 2025 16:44:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: pipes && EPOLLET, again
Message-ID: <20250304154410.GB5756@redhat.com>
References: <20250303230409.452687-1-mjguzik@gmail.com>
 <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304140726.GD26141@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Linus,

On 03/04, Oleg Nesterov wrote:
>
> and we need to cleanup the poll_usage
> logic first.

We have already discussed this before, I'll probably do this later,
but lets forget it for now.

Don't we need the trivial one-liner below anyway?

I am not saying this is a bug, but please consider

	#include <stdio.h>
	#include <stdbool.h>
	#include <stdlib.h>
	#include <unistd.h>
	#include <sys/epoll.h>
	#include <assert.h>

	static char buf[16 * 4096];

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLET };

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		write(pfd[1], buf, 4096);
		assert(epoll_wait(efd, &evt, 1, 0) == 1);

		if (!fork()) {
			write(pfd[1], buf, sizeof(buf));
			assert(0);
		}

		sleep(1);
		assert(epoll_wait(efd, &evt, 1, 0) == 1);

		return 0;
	}

the 2nd epoll_wait() fails, despite the fact that the child has already
written 15 * PAGE_SIZE bytes. This doesn't look consistent to me...

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index b0641f75b1ba..8a32257cc74f 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -554,7 +554,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		 * become empty while we dropped the lock.
 		 */
 		mutex_unlock(&pipe->mutex);
-		if (was_empty)
+		if (was_empty || pipe->poll_usage)
 			wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 		wait_event_interruptible_exclusive(pipe->wr_wait, pipe_writable(pipe));


