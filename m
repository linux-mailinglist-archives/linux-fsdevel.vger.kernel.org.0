Return-Path: <linux-fsdevel+bounces-44447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DEDA68E62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 15:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD1D87A4932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F3A178395;
	Wed, 19 Mar 2025 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guGu98zI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D53CF58
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392897; cv=none; b=IzTZYEpktiXYGAbhozjywM5gPH2Jvm0O7jb1VmKzCYUFdxOsMafHaSZhs6l4/jcXkTlNeDSR0PWOZObCwZSXpGKKoYeL+0lRA5FFVHOIbpf2s0EQFVJaQgoc6aWqRq4dL/zL07wwtN9lzz7mThXssyKwx5bndvSPsY+h2yNIJrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392897; c=relaxed/simple;
	bh=SGxlQSUbFHj87rPJIwQ1VMG5HKu1kde6EG0xj1of9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWG+/uM1AiW2fBWVXoLrgJXtcG5l9oe/VzGnY3trtqemfoa4G+psxrmr9LtHr7OufNn+UmDpUrxdVqAYsmlrO6y05LJkadesDg6pp3aOiqBk+rWcHEbDXs5zoURjVWBPrsAdtyYro9EXZw6GhfO4yCKRKKCeb5+EZGueXhf/5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=guGu98zI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742392893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Brqqr7byeWH6ccJprIqlbKvC+hSjcvLF6wD4yjGfEI=;
	b=guGu98zIvSyGwzoVnOSiIXITI0uXhj0lr3QQtUGEhu77kRcySTiOtfSVzpkQwObsukZGeQ
	fPmY7Ro1zlQtbbeJQDjZbAbU/p3DQ73l+ngto0zw7Gs6rerLpbRizPdXrsX/katdCerfFB
	j4N8SjmJPX7OBGvf0dIp9naGYX6za4o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-m6JZhkCIPjW3IOHTrqt-Ig-1; Wed,
 19 Mar 2025 10:01:30 -0400
X-MC-Unique: m6JZhkCIPjW3IOHTrqt-Ig-1
X-Mimecast-MFC-AGG-ID: m6JZhkCIPjW3IOHTrqt-Ig_1742392889
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2795F180AF4D;
	Wed, 19 Mar 2025 14:01:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.12])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 71C3B180174E;
	Wed, 19 Mar 2025 14:01:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Mar 2025 15:00:56 +0100 (CET)
Date: Wed, 19 Mar 2025 15:00:52 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC v2 1/3] pidfs: improve multi-threaded exec and
 premature thread-group leader exit polling
Message-ID: <20250319140052.GC26879@redhat.com>
References: <20250318-work-pidfs-thread_group-v2-0-2677898ffa2e@kernel.org>
 <20250318-work-pidfs-thread_group-v2-1-2677898ffa2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-work-pidfs-thread_group-v2-1-2677898ffa2e@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/18, Christian Brauner wrote:
>
> @@ -746,8 +751,23 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
>  	 * sub-thread or delay_group_leader(), wake up the
>  	 * PIDFD_THREAD waiters.
>  	 */
> -	if (!thread_group_empty(tsk))
> -		do_notify_pidfd(tsk);
> +	if (!thread_group_empty(tsk)) {
> +		if (delay_group_leader(tsk)) {
> +			struct pid *pid;
> +
> +			/*
> +			 * This is a thread-group leader exiting before
> +			 * all of its subthreads have exited allow pidfd
> +			 * polling to detect this case and delay exit
> +			 * notification until the last thread has
> +			 * exited.
> +			 */
> +			pid = task_pid(tsk);
> +			WRITE_ONCE(pid->delayed_leader, 1);

This is racy, tsk->exit_state is already set so pidfd_poll() can see
task->exit_state && !pid->delayed_leader.

But this is minor. I can't understand all these complications,
probably because I barely slept tonight ;) I will re-read this patch
again tomorrow, but could you explain why we can't simply use the
trivial patch below?

Oleg.
---

diff --git a/fs/pidfs.c b/fs/pidfs.c
index d980f779c213..8a95920aed98 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -210,7 +210,6 @@ static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
 static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 {
 	struct pid *pid = pidfd_pid(file);
-	bool thread = file->f_flags & PIDFD_THREAD;
 	struct task_struct *task;
 	__poll_t poll_flags = 0;
 
@@ -223,7 +222,7 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	task = pid_task(pid, PIDTYPE_PID);
 	if (!task)
 		poll_flags = EPOLLIN | EPOLLRDNORM | EPOLLHUP;
-	else if (task->exit_state && (thread || thread_group_empty(task)))
+	else if (task->exit_state && !delay_group_leader(task))
 		poll_flags = EPOLLIN | EPOLLRDNORM;
 
 	return poll_flags;
diff --git a/kernel/exit.c b/kernel/exit.c
index 9916305e34d3..356ca41d313b 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -746,7 +746,7 @@ static void exit_notify(struct task_struct *tsk, int group_dead)
 	 * sub-thread or delay_group_leader(), wake up the
 	 * PIDFD_THREAD waiters.
 	 */
-	if (!thread_group_empty(tsk))
+	if (!delay_group_leader(tsk))
 		do_notify_pidfd(tsk);
 
 	if (unlikely(tsk->ptrace)) {


