Return-Path: <linux-fsdevel+bounces-55985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E091EB114C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 01:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488E81CE470E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010FC2459DC;
	Thu, 24 Jul 2025 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRIW9KGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4932B241C8C;
	Thu, 24 Jul 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400283; cv=none; b=F7EUOLQK34GTWEa8Erc5sgnZnEVSgxjiRhBsw1/C8Q4HNCDFuQESNRoE+wbG+3CL15WZtFaAXICRm6gMlpB+LxaGbli4+wFJpI2U+wEtqp0yRPW91HYk54fDm+l07A9FJ3PQ+vzJk0UkOHUkR+ySZQ0Wjg4Wdg2dJO4efWdDxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400283; c=relaxed/simple;
	bh=b5hCToxNeuwTg9pHwy7ASyHLcQ4WXMdqVI9hwgI69ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X24N4kPtu6aVMlqyjVbJInsJT6YL6Ql8YuV7v8N4I5eR8/M0lkCAAMZcmw8gp+8u8vymG0egSESyak1awThBnUYKjwAsJm3nnIzGv9fr7urG5v6KvYXAyvmZOW3FrtI6YGxfMU1NMBxpEw8byx3W9C3adpwwqo9ezZu5AN7Nu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRIW9KGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB12C4CEED;
	Thu, 24 Jul 2025 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753400282;
	bh=b5hCToxNeuwTg9pHwy7ASyHLcQ4WXMdqVI9hwgI69ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRIW9KGHcqL0Fmk+5ttu/lxjwJbU/eFI84L7Hj2MdW1ul6fOEUBmOnNycwc827Q4i
	 LJEsZJ4GrO/oavqNwFPm9QRw9JUObG/+JjzR4v93D3Z/GX86s3koBwvt/aib1W/GAM
	 3RexJjMDXqALCzOv+OU2x4dAPCS7pO0Y31VMtBcJ6qNYaNPH6sRFA3Mnsp8YtAIEBs
	 z3FgN22qFgnMhUL3M9Kn9FiIpuoW6nQxO/phd+Q1+C0IteuDAAlQ0Y242fixPEdh1m
	 DqLjhm17PE65XTYxL6aNBrQ0qbhAUzoCYsp2B2mMVvwDSjijsYmA9fI8vyAmTLKO38
	 kzpv0dDDyGK6w==
Date: Thu, 24 Jul 2025 16:38:02 -0700
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
	vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v6 3/3] include: Set tsk->comm length to 64 bytes
Message-ID: <202507241634.C0346AC@keescook>
References: <20250724123612.206110-1-bhupesh@igalia.com>
 <20250724123612.206110-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724123612.206110-4-bhupesh@igalia.com>

On Thu, Jul 24, 2025 at 06:06:12PM +0530, Bhupesh wrote:
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> 
> To fix the same, we now use a 64-byte TASK_COMM_EXT_LEN and
> set the comm element inside 'task_struct' to the same length:
>        struct task_struct {
> 	       .....
>                char    comm[TASK_COMM_EXT_LEN];
> 	       .....
>        };
> 
>        where TASK_COMM_EXT_LEN is 64-bytes.
> 
> Now, in order to maintain existing ABI, we ensure that:
> 
> - Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm'
>   truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
> - New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
>  'tsk->comm' supported up to the maximum of 'TASK_COMM_EXT_LEN' (64-bytes).
> 
> Note, that the existing users have not been modified to migrate to
> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm'.
> 
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  include/linux/sched.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 8bbd03f1b978..b6abb759292c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -317,6 +317,7 @@ struct user_event_mm;
>   */
>  enum {
>  	TASK_COMM_LEN = 16,
> +	TASK_COMM_EXT_LEN = 64,
>  };
>  
>  extern void sched_tick(void);
> @@ -1159,7 +1160,7 @@ struct task_struct {
>  	 *   - logic inside set_task_comm() will ensure it is always NUL-terminated and
>  	 *     zero-padded
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				comm[TASK_COMM_EXT_LEN];
>  
>  	struct nameidata		*nameidata;
>  
> @@ -1954,7 +1955,7 @@ extern void kick_process(struct task_struct *tsk);
>  
>  extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
>  #define set_task_comm(tsk, from) ({			\
> -	BUILD_BUG_ON(sizeof(from) != TASK_COMM_LEN);	\
> +	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
>  	__set_task_comm(tsk, from, false);		\
>  })
>  
> @@ -1974,6 +1975,10 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
>  #define get_task_comm(buf, tsk) ({			\
>  	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
>  	strscpy_pad(buf, (tsk)->comm);			\
> +	if ((sizeof(buf)) == TASK_COMM_LEN)		\
> +		buf[TASK_COMM_LEN - 1] = '\0';		\
> +	else						\
> +		buf[TASK_COMM_EXT_LEN - 1] = '\0';	\

strscpy_pad() will already make sure buf is NUL-terminated, so I don't
see why there is a need for explicit final byte termination? (And even
if we do need it, then it should just be buf[sizeof(buf) - 1] otherwise
using a buf that is < TASK_COMM_EXT_LEN but > TASK_COMM_LEN will have
a spurious NUL byte write beyond its buffer.)

-- 
Kees Cook

