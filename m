Return-Path: <linux-fsdevel+bounces-46129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D51A82F23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 20:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EDA8A10BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78427935B;
	Wed,  9 Apr 2025 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bg6ZO7Bb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A1278179
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224091; cv=none; b=M7gzEmcOJTXij3JvQ2XEHS0ckujMNe6F/oPDUE/4T4YsMN0qoSSXapaMY6a4WMDVHjRzz0kaoWaemM6SCOAEMmi/g6Qtg1WVQkPHb/1uvoPhrZyftLtVYD5P2gFb53SZ2Hw76sK6uUNeJ57cA/yyUS0E8qL3JmIaomHuu9vesVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224091; c=relaxed/simple;
	bh=FcHX028iX5LkisRplgkLc8pOcmbMwMbd35p1B7+k4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSXScjGF9rnmiBPSCLqrCoib+QNApgBPMBIRmuTVu56/Uk4FBtJzCcatxi7lU8Ast/GAk72j/FaFQmkb6rY/yzf5FMkPKCGX3PkBprlYHJYwp/NLWPpkC17VmIgq6uBPe0NuZ+FqWu3RX3JB2kMFS3XELq04Jtq95RBgB7E8BV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bg6ZO7Bb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744224086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/udgtrvs2rAgp9bOsMF5Zy+uqnCHPJnsUE8E48V9ktk=;
	b=Bg6ZO7Bb1J3UnfcQqA01BC0v+dl3lBBuY4JUIqazSHUHP9zeGJZu1F0pW2sDGPVt6fqhd7
	C1Fa5neKlGuPCUwORFF+IpQqTUR50eGtOok3nhSxcJFFmB9tUz1iyMJu/Xr4pDw+4yVuxc
	NXspY/xDd7kUmbPYs6zXeqgte+ct+GM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-nJIx-zFjOaWIkhAkafWLFg-1; Wed,
 09 Apr 2025 14:41:22 -0400
X-MC-Unique: nJIx-zFjOaWIkhAkafWLFg-1
X-Mimecast-MFC-AGG-ID: nJIx-zFjOaWIkhAkafWLFg_1744224080
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDE5B1800EC5;
	Wed,  9 Apr 2025 18:41:19 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id EE4761956094;
	Wed,  9 Apr 2025 18:41:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Apr 2025 20:40:44 +0200 (CEST)
Date: Wed, 9 Apr 2025 20:40:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org,
	Peter Ziljstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] pidfs: ensure consistent ENOENT/ESRCH reporting
Message-ID: <20250409184040.GF32748@redhat.com>
References: <20250409-sesshaft-absurd-35d97607142c@brauner>
 <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-rohstoff-ungnade-d1afa571f32c@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Christian,

I will actually read your patch tomorrow, but at first glance

On 04/09, Christian Brauner wrote:
>
> The seqcounter might be
> useful independent of pidfs.

Are you sure? ;) to me the new pid->pid_seq needs more justification...

Again, can't we use pid->wait_pidfd->lock if we want to avoid the
(minor) problem with the wrong ENOENT?

or even signal->siglock, although in this case we will need
pid_task() + lock_task_sighand()...

Oleg.

> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  include/linux/pid.h |  1 +
>  kernel/exit.c       | 11 +++++++++++
>  kernel/fork.c       | 22 ++++++++++++----------
>  kernel/pid.c        |  1 +
>  4 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 311ecebd7d56..b54a4c1ef602 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -65,6 +65,7 @@ struct pid
>  	struct hlist_head inodes;
>  	/* wait queue for pidfd notifications */
>  	wait_queue_head_t wait_pidfd;
> +	seqcount_rwlock_t pid_seq;
>  	struct rcu_head rcu;
>  	struct upid numbers[];
>  };
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 1b51dc099f1e..8050572fe682 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -133,17 +133,28 @@ struct release_task_post {
>  static void __unhash_process(struct release_task_post *post, struct task_struct *p,
>  			     bool group_dead)
>  {
> +	struct pid *pid;
> +
> +	lockdep_assert_held_write(&tasklist_lock);
> +
>  	nr_threads--;
> +
> +	pid = task_pid(p);
> +	raw_write_seqcount_begin(&pid->pid_seq);
>  	detach_pid(post->pids, p, PIDTYPE_PID);
>  	if (group_dead) {
>  		detach_pid(post->pids, p, PIDTYPE_TGID);
>  		detach_pid(post->pids, p, PIDTYPE_PGID);
>  		detach_pid(post->pids, p, PIDTYPE_SID);
> +	}
> +	raw_write_seqcount_end(&pid->pid_seq);
>  
> +	if (group_dead) {
>  		list_del_rcu(&p->tasks);
>  		list_del_init(&p->sibling);
>  		__this_cpu_dec(process_counts);
>  	}
> +
>  	list_del_rcu(&p->thread_node);
>  }
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4a2080b968c8..1480bf6f5f38 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2109,24 +2109,26 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
>  {
>  	int err = 0;
> +	unsigned int seq;
>  
> -	if (!(flags & PIDFD_THREAD)) {
> +	do {
> +		seq = raw_seqcount_begin(&pid->pid_seq);
>  		/*
>  		 * If this is struct pid isn't used as a thread-group
>  		 * leader pid but the caller requested to create a
>  		 * thread-group leader pidfd then report ENOENT to the
>  		 * caller as a hint.
>  		 */
> -		if (!pid_has_task(pid, PIDTYPE_TGID))
> +		if (!(flags & PIDFD_THREAD) && !pid_has_task(pid, PIDTYPE_TGID))
>  			err = -ENOENT;
> -	}
> -
> -	/*
> -	 * If this wasn't a thread-group leader struct pid or the task
> -	 * got reaped in the meantime report -ESRCH to userspace.
> -	 */
> -	if (!pid_has_task(pid, PIDTYPE_PID))
> -		err = -ESRCH;
> +		/*
> +		 * If this wasn't a thread-group leader struct pid or
> +		 * the task got reaped in the meantime report -ESRCH to
> +		 * userspace.
> +		 */
> +		if (!pid_has_task(pid, PIDTYPE_PID))
> +			err = -ESRCH;
> +	} while (read_seqcount_retry(&pid->pid_seq, seq));
>  	if (err)
>  		return err;
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 4ac2ce46817f..bbca61f62faa 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -271,6 +271,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  	upid = pid->numbers + ns->level;
>  	idr_preload(GFP_KERNEL);
>  	spin_lock(&pidmap_lock);
> +	seqcount_rwlock_init(&pid->pid_seq, &tasklist_lock);
>  	if (!(ns->pid_allocated & PIDNS_ADDING))
>  		goto out_unlock;
>  	pidfs_add_pid(pid);
> -- 
> 2.47.2
> 


