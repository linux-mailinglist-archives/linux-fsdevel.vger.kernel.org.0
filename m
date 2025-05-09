Return-Path: <linux-fsdevel+bounces-48651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF2AB1B5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8EF3A23F26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D723908B;
	Fri,  9 May 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgcJs+2g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE9E800;
	Fri,  9 May 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810632; cv=none; b=AwCYsssTVc0CunX0rtBZI6Zi48QpqAgT76vD81pyOojgQenFSjTuwZZ8/U+y2fEAqq5Lfrw98i1kjgTgVyds1T+Tmq644wuZVnoVDQMsyW+urQgBretqS8r+6XmlffLrKOlHwQuNDXWBqw38RHMVVp+42CJPhdqnUnLbsVBtE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810632; c=relaxed/simple;
	bh=Rg26xVepbKv+GhXzyO57+ntaAAUnjE9KukxV2nugKoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1OLEh7OTZMKZoOYg8LjmVikpt/7w0rTHKUqPaF54i7o6n5bQo3CiArGn6wkA46s7d67o1H/ayKSpv0rPhzm7eUTotCtPGixdPexH+l4fU+sobmXm0D3ZqU3Mmawl3HaRRhWrO0RA7TXNFLnOSre0cnfE7z+dv7jLxSatFQRtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgcJs+2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01317C4CEE4;
	Fri,  9 May 2025 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746810632;
	bh=Rg26xVepbKv+GhXzyO57+ntaAAUnjE9KukxV2nugKoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgcJs+2gmQcQQRtPJko2aZpyTLaujeLaSLfxYN4PC77ilDL+fivFo95iZkjr2coCg
	 x3R30fiwAmxHH9wGoQbqyklQqyRuT8riDJwThw+sKP4ZJCefANJEyCG4aeCAvpMWtf
	 aCqWWPayvy8jp1rXDkjzswwulALDGa5NPOGL7euPyopTMMr/9a4W6YEX8zGMD/Y7e7
	 G9tXQcmIUIi/Rf6SjgTsAQNdCHMtrfmMRHO6GqKSKT4HrZIRz6LtaPFMZ8ZefKa48L
	 mBq/mDOO2dQ2h1QiRWRllwyWGZeY/14OeTnRo0sOh6CwDm4Ur1Gfwauj6fpVIYY6rs
	 vopmEhIyNh3Bg==
Date: Fri, 9 May 2025 10:10:28 -0700
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
Subject: Re: [PATCH 07/12] Input: sysrq: mv sysrq into drivers/tty/sysrq.c
Message-ID: <202505091010.F2F8C676@keescook>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>

On Fri, May 09, 2025 at 02:54:11PM +0200, Joel Granados wrote:
> Move both sysrq ctl_table and supported sysrq_sysctl_handler helper
> function into drivers/tty/sysrq.c. Replaced the __do_proc_dointvec in
> helper function with do_proc_dointvec as the former is local to
> kernel/sysctl.c.

nit: do_proc_dointvec_minmax

> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

But yes, this looks correct.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  drivers/tty/sysrq.c | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/sysctl.c     | 30 ------------------------------
>  2 files changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 6853c4660e7c2586487fea83c12f0b7780db1ee1..8a304189749f3e33af48141a1aba5e456616c7de 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1119,6 +1119,44 @@ int sysrq_toggle_support(int enable_mask)
>  }
>  EXPORT_SYMBOL_GPL(sysrq_toggle_support);
>  
> +static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
> +				void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int tmp, ret;
> +	struct ctl_table t = *table;
> +
> +	tmp = sysrq_mask();
> +	t.data = &tmp;
> +
> +	ret = proc_dointvec_minmax(&t, write, buffer, lenp, ppos);
> +
> +	if (ret || !write)
> +		return ret;
> +
> +	if (write)
> +		sysrq_toggle_support(tmp);
> +
> +	return 0;
> +}
> +
> +static const struct ctl_table sysrq_sysctl_table[] = {
> +	{
> +		.procname	= "sysrq",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= sysrq_sysctl_handler,
> +	},
> +};
> +
> +static int __init init_sysrq_sysctl(void)
> +{
> +	register_sysctl_init("kernel", sysrq_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_sysrq_sysctl);
> +
>  static int __sysrq_swap_key_ops(u8 key, const struct sysrq_key_op *insert_op_p,
>  				const struct sysrq_key_op *remove_op_p)
>  {
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index febf328054aa5a7b2462a256598f86f5ded87c90..ebcc7d75acd9fecbf3c10f31480c3cb6960cb53e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -31,7 +31,6 @@
>  #include <linux/kernel.h>
>  #include <linux/kobject.h>
>  #include <linux/net.h>
> -#include <linux/sysrq.h>
>  #include <linux/highuid.h>
>  #include <linux/writeback.h>
>  #include <linux/ratelimit.h>
> @@ -964,26 +963,6 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
>  }
>  EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
>  
> -#ifdef CONFIG_MAGIC_SYSRQ
> -static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
> -				void *buffer, size_t *lenp, loff_t *ppos)
> -{
> -	int tmp, ret;
> -
> -	tmp = sysrq_mask();
> -
> -	ret = __do_proc_dointvec(&tmp, table, write, buffer,
> -			       lenp, ppos, NULL, NULL);
> -	if (ret || !write)
> -		return ret;
> -
> -	if (write)
> -		sysrq_toggle_support(tmp);
> -
> -	return 0;
> -}
> -#endif
> -
>  static int __do_proc_doulongvec_minmax(void *data,
>  		const struct ctl_table *table, int write,
>  		void *buffer, size_t *lenp, loff_t *ppos,
> @@ -1612,15 +1591,6 @@ static const struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dostring,
>  	},
>  #endif
> -#ifdef CONFIG_MAGIC_SYSRQ
> -	{
> -		.procname	= "sysrq",
> -		.data		= NULL,
> -		.maxlen		= sizeof (int),
> -		.mode		= 0644,
> -		.proc_handler	= sysrq_sysctl_handler,
> -	},
> -#endif
>  #ifdef CONFIG_PROC_SYSCTL
>  	{
>  		.procname	= "cad_pid",
> 
> -- 
> 2.47.2
> 
> 

-- 
Kees Cook

