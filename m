Return-Path: <linux-fsdevel+bounces-57851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF8B25ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 10:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C089758374A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 08:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07A2E7659;
	Thu, 14 Aug 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgnI8UJS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77892E7BB5;
	Thu, 14 Aug 2025 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160195; cv=none; b=cR0SCsZw2qgyBWxkWPUHR2TVUe0ENsgWFQIxUYBMEjUlXsZzJSl1qlJCKoLjOCBeoibYUkHTuhvyy2QibiSz5VuoZfvK9R31DITCfUQFRK84GxeBr3ucFwuveTYSsafoNW2ye+l+UOlelPhfT3p1zzrd9P5O3ioey/RjxaPTJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160195; c=relaxed/simple;
	bh=KdLgrtVpCnwmqBeEbXly/JQKZu+/Bf7kGD89aJGLLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJqt0+ktsyhnv5xiLQRFcSMbQ2fT/bhm8wwA/j4eRy0B6pGg+m2h5+rYsVW6qLixp+cJUl3zgMGiXI2OzFuwibRG2JBVNP9knikem9owpKOo/swgLBpI2y2zDTgMETdjDJ8ASM/JoC77S/VE/m/yCV4YdpW+bdq8tVXI7dQnZ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgnI8UJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1718BC4CEF5;
	Thu, 14 Aug 2025 08:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755160195;
	bh=KdLgrtVpCnwmqBeEbXly/JQKZu+/Bf7kGD89aJGLLrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgnI8UJSan+/NDSjk/Hl6AHksZNLCBmMyv7I6ottubTebiQRbsUfEbvIDnPI6gGb7
	 x6rD9peFnW3ZpIMR/9Sw0NCDT/TKaw9GCiZc5Tm55FyMr0EYl45K+764RG3cFz4fI/
	 AYu79A9WpUjtQRiQiYwZLHdOe36W/DJFoXdujFFfoxqO1zQwgTwyMW95wnwzWMRGVr
	 0ubAitkieacSV3z55Tv/q4eaRXLfMTuzFwh8g6rWiKGYF65msy96rF5AvL2JMO4N+f
	 hg4dAgcVfmh7oQtvcI/niV+/kdkNa8Z2tAOU4/svTc/b8E/uoCdmMTFgfc2wSMzcYB
	 qGs/EbpySPCPw==
Date: Thu, 14 Aug 2025 11:29:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 03/10] mm: convert prctl to mm_flags_*() accessors
Message-ID: <aJ2eaB_mguqgpJfb@kernel.org>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <b64f07b94822d02beb88d0d21a6a85f9ee45fc69.1755012943.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64f07b94822d02beb88d0d21a6a85f9ee45fc69.1755012943.git.lorenzo.stoakes@oracle.com>

On Tue, Aug 12, 2025 at 04:44:12PM +0100, Lorenzo Stoakes wrote:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/sys.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 1e28b40053ce..605f7fe9a143 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2392,9 +2392,9 @@ static inline unsigned long get_current_mdwe(void)
>  {
>  	unsigned long ret = 0;
>  
> -	if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE, current->mm))
>  		ret |= PR_MDWE_REFUSE_EXEC_GAIN;
> -	if (test_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags))
> +	if (mm_flags_test(MMF_HAS_MDWE_NO_INHERIT, current->mm))
>  		ret |= PR_MDWE_NO_INHERIT;
>  
>  	return ret;
> @@ -2427,9 +2427,9 @@ static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
>  		return -EPERM; /* Cannot unset the flags */
>  
>  	if (bits & PR_MDWE_NO_INHERIT)
> -		set_bit(MMF_HAS_MDWE_NO_INHERIT, &current->mm->flags);
> +		mm_flags_set(MMF_HAS_MDWE_NO_INHERIT, current->mm);
>  	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
> -		set_bit(MMF_HAS_MDWE, &current->mm->flags);
> +		mm_flags_set(MMF_HAS_MDWE, current->mm);
>  
>  	return 0;
>  }
> @@ -2627,7 +2627,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_GET_THP_DISABLE:
>  		if (arg2 || arg3 || arg4 || arg5)
>  			return -EINVAL;
> -		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
> +		error = !!mm_flags_test(MMF_DISABLE_THP, me->mm);
>  		break;
>  	case PR_SET_THP_DISABLE:
>  		if (arg3 || arg4 || arg5)
> @@ -2635,9 +2635,9 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		if (mmap_write_lock_killable(me->mm))
>  			return -EINTR;
>  		if (arg2)
> -			set_bit(MMF_DISABLE_THP, &me->mm->flags);
> +			mm_flags_set(MMF_DISABLE_THP, me->mm);
>  		else
> -			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
> +			mm_flags_clear(MMF_DISABLE_THP, me->mm);
>  		mmap_write_unlock(me->mm);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
> @@ -2770,7 +2770,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		if (arg2 || arg3 || arg4 || arg5)
>  			return -EINVAL;
>  
> -		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
> +		error = !!mm_flags_test(MMF_VM_MERGE_ANY, me->mm);
>  		break;
>  #endif
>  	case PR_RISCV_V_SET_CONTROL:
> -- 
> 2.50.1
> 

-- 
Sincerely yours,
Mike.

