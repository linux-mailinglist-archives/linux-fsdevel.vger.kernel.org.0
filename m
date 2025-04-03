Return-Path: <linux-fsdevel+bounces-45664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B2A7A801
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F067A4949
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6B2E3387;
	Thu,  3 Apr 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJxNpYzI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FF2D052;
	Thu,  3 Apr 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697827; cv=none; b=NCFcR5R8mu/Rxs0RMXBtHdwNLFyxaIMWoHLK/xyDT+VJekOWCvO9R+Itogmh2WW9mXJmyrB4AYNujdNsm8Dbd5kzDY+zNiIp++CHRIlCYzcTz72XeNkbAjK4BlQXCJffQQpqGULSmCJSrpTsA4jT5n5w2U4J4wwmJR4TDSYjgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697827; c=relaxed/simple;
	bh=od+jl7zVZvKgoDBSmlp+LMyewxJFQr/Zo9tM+HJKCps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X34KOPXMWGCBMPecgu0koci/QUgC/I4hl57miQoA3ZasNdiDwpVsQ2uo8mz0XFluXKee69wHVRS2ibCKsmMFZ71eNKILUGzP3ouQp8RZ1Ea5k/IsuaBbAlS9RvheaFXEzjBIqU4RCRk9tUW2PfR8KYRaU2opLzL2n+LovlI6n4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJxNpYzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184DDC4CEE3;
	Thu,  3 Apr 2025 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743697826;
	bh=od+jl7zVZvKgoDBSmlp+LMyewxJFQr/Zo9tM+HJKCps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJxNpYzI0tSBL5Fd29YBqt79bpQuPHJNkgU4HWnA1ipoJVQQZT04gS6GlTXUNKCwy
	 3rcJdbbtZ1g5w0e2VEc4waAwbeLBmoazhpr56/B+rqY2+09YmOSm3SK7rhCp68n+Lr
	 R3G+z+RTFDsgCo2N5w5VeWUNyc9m/eisSE7A4xc0VMJ4DNcGiXJgqitCxfSFpKrmqM
	 lpbZ7wkGZQgQbumA5YCATMoACJohz5/36tiJVZuB6+isXlsuNB3XJ80QqhbjYcEkut
	 buu/3pAZLr+gH0MryQDouwotjTR47MnGIKmSAPS7JraCOv/Tq9a4zA0NG4H1RtoHU7
	 yE9OI/ry0AzBg==
Date: Thu, 3 Apr 2025 09:30:22 -0700
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
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Message-ID: <202504030924.50896AD12@keescook>
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331121820.455916-2-bhupesh@igalia.com>

On Mon, Mar 31, 2025 at 05:48:18PM +0530, Bhupesh wrote:
> Provide a parallel implementation for get_task_comm() called
> get_task_full_name() which allows the dynamically allocated
> and filled-in task's full name to be passed to interested
> users such as 'gdb'.
> 
> Currently while running 'gdb', the 'task->comm' value of a long
> task name is truncated due to the limitation of TASK_COMM_LEN.
> 
> For example using gdb to debug a simple app currently which generate
> threads with long task names:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
> 
>   NameThatIsTooLo
> 
> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
> that all the legacy / existing ABI, continue to work as before using
> '/proc/$pid/task/$tid/comm'.
> 
> This patch only adds a parallel, dynamically-allocated
> 'task->full_name' which can be used by interested users
> via '/proc/$pid/task/$tid/full_name'.
> 
> After this change, gdb is able to show full name of the task:
>   # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>   # cat log
> 
>   NameThatIsTooLongForComm[4662]
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  fs/exec.c             | 21 ++++++++++++++++++---
>  include/linux/sched.h |  9 +++++++++
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index f45859ad13ac..4219d77a519c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  {
>  	struct task_struct *me = current;
>  	int retval;
> +	va_list args;
> +	char *name;
> +	const char *fmt;
>  
>  	/* Once we are committed compute the creds */
>  	retval = bprm_creds_from_file(bprm);
> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		 * detecting a concurrent rename and just want a terminated name.
>  		 */
>  		rcu_read_lock();
> -		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
> -				true);
> +		fmt = smp_load_acquire(&bprm->file->f_path.dentry->d_name.name);
> +		name = kvasprintf(GFP_KERNEL, fmt, args);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		me->full_name = name;
> +		__set_task_comm(me, fmt, true);

I don't want to add new allocations to the default exec path unless we
absolutely must.

In the original proposal this was about setting thread names (after
exec), and I think that'll be fine.

>  		rcu_read_unlock();
>  	} else {
> -		__set_task_comm(me, kbasename(bprm->filename), true);
> +		fmt = kbasename(bprm->filename);
> +		name = kvasprintf(GFP_KERNEL, fmt, args);
> +		if (!name)
> +			return -ENOMEM;
> +
> +		me->full_name = name;
> +		__set_task_comm(me, fmt, true);
>  	}

I think we can just set me->full_name = me->comm by default.

>  
>  	/* An exec changes our domain. We are no longer part of the thread
> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	return 0;
>  
>  out_unlock:
> +	kfree(me->full_name);
>  	up_write(&me->signal->exec_update_lock);
>  	if (!bprm->cred)
>  		mutex_unlock(&me->signal->cred_guard_mutex);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 56ddeb37b5cd..053b52606652 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1166,6 +1166,9 @@ struct task_struct {
>  	 */
>  	char				comm[TASK_COMM_LEN];
>  
> +	/* To store the full name if task comm is truncated. */
> +	char				*full_name;
> +
>  	struct nameidata		*nameidata;
>  
>  #ifdef CONFIG_SYSVIPC
> @@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
>  	buf;						\
>  })
>  
> +#define get_task_full_name(buf, buf_size, tsk) ({	\
> +	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
> +	strscpy_pad(buf, (tsk)->full_name, buf_size);	\
> +	buf;						\
> +})

I think it should be possible to just switch get_task_comm() to use
(tsk)->full_name.

-- 
Kees Cook

