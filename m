Return-Path: <linux-fsdevel+bounces-48660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC969AB1CDE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AF63BF169
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EA242938;
	Fri,  9 May 2025 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASCU+MKM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96307221293;
	Fri,  9 May 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817286; cv=none; b=IRH/Xe2qn2jNIaCVnwljCaJtGh3OH7oAQznyxWqgrA7Svk7zfFWmCkvrbZ/xWHQFKdjzoX37UmzKGefsZdVbL+c+4Qk8SsXlca820b5CgYiACUPjAf4ncq3oz6ICHEDI2fMdI3CLXF2dSCV0xB1Nj03q6MhPvxpCV2SVPUOqBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817286; c=relaxed/simple;
	bh=akbEbL1UVIv55uwYZyCLqwKBc4CH9+Dt5Oh8Z2+LGg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeJRuNJNcyWBDgXOvLwwAZVV5AJKUMl6CnT+HXLuQEY45gbK+iA3GsZT6P8FZ/O0BqoJIXPqk9/P2oXTFUjNsUAJaC1mSFeN0oFW55cRv4pBhQT/R2OFCkjlk4gxAW5CsGopoxv41lRMimkXWZkrB3VhKyAi21rrVkafQTOtEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASCU+MKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3397C4CEE9;
	Fri,  9 May 2025 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817286;
	bh=akbEbL1UVIv55uwYZyCLqwKBc4CH9+Dt5Oh8Z2+LGg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASCU+MKMY+5fj8xnGHpAf+qHr+WP+BQJimdKR2SUdXCZprN/m18ScjHOTwr+Kv2ms
	 vU4Cr4UtBLeL/IizRm/1tvQzf8fdKn+XCXZ/Tm3cUaY823LAJ6u8rb79eJEmrSZvdG
	 6SxD677NiUuRZzQQJxTVf2BT7ii0Aa6OiMOokKJ0L2M/pHglOcqCfTJntdkim8rzew
	 kuuexECDIzoD8MEF9aPuzhEjSwJUWDkMDy1R+0+7jawNqWQ+u8MeLePmbhevoIBHSX
	 Gkx9rxQC9jFKY9d3UvCu3W323e8viGtRWCf/Nn7L0+bLhRkH/qyT86s50EwWZZoLJz
	 xNDlsfUB9m7HQ==
Date: Fri, 9 May 2025 12:01:24 -0700
From: Kees Cook <kees@kernel.org>
To: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org,
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 09/12] sysctl: move cad_pid into kernel/pid.c
Message-ID: <202505091200.FC2683DD@keescook>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-9-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-9-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:13PM +0200, Joel Granados wrote:
> Move cad_pid as well as supporting function proc_do_cad_pid into
> kernel/pic.c. Replaced call to __do_proc_dointvec with proc_dointvec
> inside proc_do_cad_pid which requires the copy of the ctl_table to
> handle the temp value.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  kernel/pid.c    | 32 ++++++++++++++++++++++++++++++++
>  kernel/sysctl.c | 31 -------------------------------
>  2 files changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 4ac2ce46817fdefff8888681bb5ca3f2676e8add..bc87ba08ae8b7c67f3457b31309b56b5d90f8c52 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -717,6 +717,29 @@ static struct ctl_table_root pid_table_root = {
>  	.set_ownership	= pid_table_root_set_ownership,
>  };
>  
> +static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffer,
> +		size_t *lenp, loff_t *ppos)
> +{
> +	struct pid *new_pid;
> +	pid_t tmp_pid;
> +	int r;
> +	struct ctl_table tmp_table = *table;
> +
> +	tmp_pid = pid_vnr(cad_pid);
> +	tmp_table.data = &tmp_pid;
> +
> +	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
> +	if (r || !write)
> +		return r;
> +
> +	new_pid = find_get_pid(tmp_pid);
> +	if (!new_pid)
> +		return -ESRCH;
> +
> +	put_pid(xchg(&cad_pid, new_pid));
> +	return 0;
> +}
> +
>  static const struct ctl_table pid_table[] = {
>  	{
>  		.procname	= "pid_max",
> @@ -727,6 +750,15 @@ static const struct ctl_table pid_table[] = {
>  		.extra1		= &pid_max_min,
>  		.extra2		= &pid_max_max,
>  	},
> +#ifdef CONFIG_PROC_SYSCTL
> +	{
> +		.procname	= "cad_pid",
> +		.data		= NULL,

nit: this is redundant, any unspecified member will be zero-initialized.

Regardless:

Reviewed-by: Kees Cook <kees@kernel.org>


> +		.maxlen		= sizeof(int),
> +		.mode		= 0600,
> +		.proc_handler	= proc_do_cad_pid,
> +	},
> +#endif
>  };
>  #endif
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9d8db9cef11122993d850ab5c753e3da1cbfb5cc..d5bebdd02cd4f1def7d9dd2b85454a9022b600b7 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1224,28 +1224,6 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buf
>  				do_proc_dointvec_ms_jiffies_conv, NULL);
>  }
>  
> -static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffer,
> -		size_t *lenp, loff_t *ppos)
> -{
> -	struct pid *new_pid;
> -	pid_t tmp;
> -	int r;
> -
> -	tmp = pid_vnr(cad_pid);
> -
> -	r = __do_proc_dointvec(&tmp, table, write, buffer,
> -			       lenp, ppos, NULL, NULL);
> -	if (r || !write)
> -		return r;
> -
> -	new_pid = find_get_pid(tmp);
> -	if (!new_pid)
> -		return -ESRCH;
> -
> -	put_pid(xchg(&cad_pid, new_pid));
> -	return 0;
> -}
> -
>  /**
>   * proc_do_large_bitmap - read/write from/to a large bitmap
>   * @table: the sysctl table
> @@ -1541,15 +1519,6 @@ static const struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dostring,
>  	},
> -#endif
> -#ifdef CONFIG_PROC_SYSCTL
> -	{
> -		.procname	= "cad_pid",
> -		.data		= NULL,
> -		.maxlen		= sizeof (int),
> -		.mode		= 0600,
> -		.proc_handler	= proc_do_cad_pid,
> -	},
>  #endif
>  	{
>  		.procname	= "overflowuid",
> 
> -- 
> 2.47.2
> 
> 

-- 
Kees Cook

