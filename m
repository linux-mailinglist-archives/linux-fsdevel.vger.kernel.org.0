Return-Path: <linux-fsdevel+bounces-45662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246BA7A7E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EBF172A93
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBA2512E1;
	Thu,  3 Apr 2025 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbbT45SN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A9D190679;
	Thu,  3 Apr 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697457; cv=none; b=DH/GGeA+1QAXVkKcPVIDXmXUr+DZFZSqBGMOc2rKIh6fv3RTde1AFin0qq9W+ROGgZXfpGRIPr5Twn4rURoscKpveXSCynm85ZyRlTZN9SIrs1QIY3RY+4h3SupwB2MwImewRzd5JvRQd/SbQojZJaVg0vDK1ziKKAo/wzaGQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697457; c=relaxed/simple;
	bh=vhrl4p3qftt6QxANAuIi+azQRkD9hhqzoqCdg7PCsT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBAWPdu7cXR40ujx2OejRXRWSG01FXlBSheePfNW1Ct+FsHW/f8EPDIGSgsmfcEBadP0accwsCSGkxpQRwj5fBVBxfiR5qCX2h1ohpuLTTNKhSpdDwMydZxu5Y8sEgjrnVpD9a+PYXnL5UiytEawGIKigvMBUjllHV+iKoceFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbbT45SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D490C4CEE3;
	Thu,  3 Apr 2025 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697457;
	bh=vhrl4p3qftt6QxANAuIi+azQRkD9hhqzoqCdg7PCsT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbbT45SNiUqNV3TyRh2EOo0pHftvGWFWRH6vBPJudMPmwiLb6WS7wgiK5Q59kVq/l
	 /YJb64mzcTT2KqJ9UYP5d2xZ5n9/Jvr/cWUkrkbGnIXzQjEBIO38AGnM9vTtABopU/
	 YAJHsePiJIqDiBQELEuWxMPSSa2HKRV53DWvBXptAhBL1IgRu2Lxwm90pLLwMLv38o
	 ONUPyD3uH/jCdrUJkyhbEpCcdp2Ys7NwBdEd1sF/A4gIxp7Hoyh0Cl3b9gddvXT4lz
	 XKzokxWQ8vKM0QK/Wccns5rkNWZemPG6vH3fGD9ZTEESdQgFsLCw6SC2OTh/RL0pZI
	 yU+rwKUcUY4TA==
Date: Thu, 3 Apr 2025 09:24:13 -0700
From: Kees Cook <kees@kernel.org>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
	juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com
Subject: Re: [PATCH v2 3/3] kthread: Use 'task_struct->full_name' to store
 kthread's full name
Message-ID: <202504030923.1FE7874F@keescook>
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331121820.455916-4-bhupesh@igalia.com>

On Mon, Mar 31, 2025 at 05:48:20PM +0530, Bhupesh wrote:
> Commit 6986ce24fc00 ("kthread: dynamically allocate memory to store
> kthread's full name"), added 'full_name' in parallel to 'comm' for
> kthread names.
> 
> Now that we have added 'full_name' added to 'task_struct' itself,
> drop the additional 'full_name' entry from 'struct kthread' and also
> its usage.
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>

I'd like to see this patch be the first patch in the series. This show
the existing use for "full_name". (And as such it'll probably need bits
from patch 1.)

-Kees

> ---
>  kernel/kthread.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 5dc5b0d7238e..46fe19b7ef76 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -66,8 +66,6 @@ struct kthread {
>  #ifdef CONFIG_BLK_CGROUP
>  	struct cgroup_subsys_state *blkcg_css;
>  #endif
> -	/* To store the full name if task comm is truncated. */
> -	char *full_name;
>  	struct task_struct *task;
>  	struct list_head hotplug_node;
>  	struct cpumask *preferred_affinity;
> @@ -108,12 +106,12 @@ void get_kthread_comm(char *buf, size_t buf_size, struct task_struct *tsk)
>  {
>  	struct kthread *kthread = to_kthread(tsk);
>  
> -	if (!kthread || !kthread->full_name) {
> +	if (!kthread || !tsk->full_name) {
>  		strscpy(buf, tsk->comm, buf_size);
>  		return;
>  	}
>  
> -	strscpy_pad(buf, kthread->full_name, buf_size);
> +	strscpy_pad(buf, tsk->full_name, buf_size);
>  }
>  
>  bool set_kthread_struct(struct task_struct *p)
> @@ -153,7 +151,6 @@ void free_kthread_struct(struct task_struct *k)
>  	WARN_ON_ONCE(kthread->blkcg_css);
>  #endif
>  	k->worker_private = NULL;
> -	kfree(kthread->full_name);
>  	kfree(kthread);
>  }
>  
> @@ -430,7 +427,7 @@ static int kthread(void *_create)
>  		kthread_exit(-EINTR);
>  	}
>  
> -	self->full_name = create->full_name;
> +	self->task->full_name = create->full_name;
>  	self->threadfn = threadfn;
>  	self->data = data;
>  
> -- 
> 2.38.1
> 

-- 
Kees Cook

