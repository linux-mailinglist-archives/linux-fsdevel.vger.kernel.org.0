Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8443A5B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbhJYVVH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhJYVVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:21:06 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC12C061243
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:18:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m21so11926377pgu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4dFG4rs8hqlCuz/EfoYAZcUALMQAcileOXiGOM+GvSs=;
        b=h8zXHApiXwW7BGwOlRTSYeAOiIYlU/hMc4TbALJMI/0cihoZAHnZhaMeTUvABTDXH4
         5kFUw7f88DKj2ScaqsgEkCUCDGOUXuF76JmStbCrZkEf1poAl1epuiBjB6Wqp4mTm9QZ
         jt5LcTyHO1dqnK/b81084OhydFJoAMS1MxwZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4dFG4rs8hqlCuz/EfoYAZcUALMQAcileOXiGOM+GvSs=;
        b=74IcEnr639rCV8vF/tZwJ0kJUkSjS9C2h/OIDpf1itEjogm47u+i3w5q6OyXNde84Y
         20uNPdiEO5cWcbqy/J94wm4M4kL2g4Tzlij/3RqMGllyY8E7c2eIxvCcMM2LzvfYxQ/I
         Cl7NguMRkVm811MuhydorfVgXAC4ITPuSbju3dWgyop0LtQtZxRkImBAiyhC7v9nCRPu
         /nIEPYT6WsEShZP8Vm+c8ni2MYM7VJKBGM+tvujtS45sv5G+S/iyyquDlAgiVkv8TMAP
         E84auk32U0cOUJ9W1oodW9EdbzH9ispfZPvTw6MN51WORMHDhZAQ8/6+x44i57P11sUT
         4EIQ==
X-Gm-Message-State: AOAM532Yf+TFHx8X4TddWygW7GuWLL8tuyAKoVBBkbhE/hi9Al5280vV
        EEnCQLggBRl3dsEzSBo1g2NGnA==
X-Google-Smtp-Source: ABdhPJyS0ge/35NJ840NuvZ4u5yKuw5pNRnD/FZjdif7Rr5/oI4rIsLKUc08UKkwGfL8P+QzRMJDvg==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr15663430pgh.190.1635196723249;
        Mon, 25 Oct 2021 14:18:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm22788279pfu.12.2021.10.25.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:18:43 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:18:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 05/12] elfcore: make prpsinfo always get a nul
 terminated task comm
Message-ID: <202110251417.4D879366@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-6-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-6-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:08AM +0000, Yafang Shao wrote:
> kernel test robot reported a -Wstringop-truncation warning after I
> extend task comm from 16 to 24. Below is the detailed warning:
> 
>    fs/binfmt_elf.c: In function 'fill_psinfo.isra':
> >> fs/binfmt_elf.c:1575:9: warning: 'strncpy' output may be truncated copying 16 bytes from a string of length 23 [-Wstringop-truncation]
>     1575 |         strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This patch can fix this warning.
> 
> Replacing strncpy() with strscpy_pad() can avoid this warning.
> 
> This patch also replace the hard-coded 16 with TASK_COMM_LEN to make it
> more compatible with task comm size change.
> 
> I also verfied if it still work well when I extend the comm size to 24.
> struct elf_prpsinfo is used to dump the task information in userspace
> coredump or kernel vmcore. Below is the verfication of vmcore,
> 
> crash> ps
>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>       0      0   0  ffffffff9d21a940  RU   0.0       0      0  [swapper/0]
> >     0      0   1  ffffa09e40f85e80  RU   0.0       0      0  [swapper/1]
> >     0      0   2  ffffa09e40f81f80  RU   0.0       0      0  [swapper/2]
> >     0      0   3  ffffa09e40f83f00  RU   0.0       0      0  [swapper/3]
> >     0      0   4  ffffa09e40f80000  RU   0.0       0      0  [swapper/4]
> >     0      0   5  ffffa09e40f89f80  RU   0.0       0      0  [swapper/5]
>       0      0   6  ffffa09e40f8bf00  RU   0.0       0      0  [swapper/6]
> >     0      0   7  ffffa09e40f88000  RU   0.0       0      0  [swapper/7]
> >     0      0   8  ffffa09e40f8de80  RU   0.0       0      0  [swapper/8]
> >     0      0   9  ffffa09e40f95e80  RU   0.0       0      0  [swapper/9]
> >     0      0  10  ffffa09e40f91f80  RU   0.0       0      0  [swapper/10]
> >     0      0  11  ffffa09e40f93f00  RU   0.0       0      0  [swapper/11]
> >     0      0  12  ffffa09e40f90000  RU   0.0       0      0  [swapper/12]
> >     0      0  13  ffffa09e40f9bf00  RU   0.0       0      0  [swapper/13]
> >     0      0  14  ffffa09e40f98000  RU   0.0       0      0  [swapper/14]
> >     0      0  15  ffffa09e40f9de80  RU   0.0       0      0  [swapper/15]
> 
> It works well as expected.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  fs/binfmt_elf.c                | 2 +-
>  include/linux/elfcore-compat.h | 3 ++-
>  include/linux/elfcore.h        | 4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index a813b70f594e..a4ba79fce2a9 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1572,7 +1572,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
>  	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
>  	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
>  	rcu_read_unlock();
> -	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
> +	strscpy_pad(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));

This should use get_task_comm().

>  
>  	return 0;
>  }
> diff --git a/include/linux/elfcore-compat.h b/include/linux/elfcore-compat.h
> index e272c3d452ce..afa0eb45196b 100644
> --- a/include/linux/elfcore-compat.h
> +++ b/include/linux/elfcore-compat.h
> @@ -5,6 +5,7 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/compat.h>
> +#include <linux/sched.h>
>  
>  /*
>   * Make sure these layouts match the linux/elfcore.h native definitions.
> @@ -43,7 +44,7 @@ struct compat_elf_prpsinfo
>  	__compat_uid_t			pr_uid;
>  	__compat_gid_t			pr_gid;
>  	compat_pid_t			pr_pid, pr_ppid, pr_pgrp, pr_sid;
> -	char				pr_fname[16];
> +	char				pr_fname[TASK_COMM_LEN];
>  	char				pr_psargs[ELF_PRARGSZ];
>  };
>  
> diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
> index 2aaa15779d50..8d79cd58b09a 100644
> --- a/include/linux/elfcore.h
> +++ b/include/linux/elfcore.h
> @@ -65,8 +65,8 @@ struct elf_prpsinfo
>  	__kernel_gid_t	pr_gid;
>  	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
>  	/* Lots missing */
> -	char	pr_fname[16];	/* filename of executable */
> -	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
> +	char	pr_fname[TASK_COMM_LEN];	/* filename of executable */
> +	char	pr_psargs[ELF_PRARGSZ];		/* initial part of arg list */
>  };
>  
>  static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
> -- 
> 2.17.1
> 

These structs are externally parsed -- we can't change the size of
pr_fname AFAICT.

-- 
Kees Cook
