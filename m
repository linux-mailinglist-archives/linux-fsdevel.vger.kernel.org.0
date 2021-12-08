Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF346DB61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 19:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhLHSoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 13:44:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbhLHSoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:44:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D73AB82273;
        Wed,  8 Dec 2021 18:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C26CC341D1;
        Wed,  8 Dec 2021 18:40:47 +0000 (UTC)
Date:   Wed, 8 Dec 2021 13:40:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org, pmladek@suse.com,
        david@redhat.com, arnaldo.melo@gmail.com,
        andrii.nakryiko@gmail.com, linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH -mm 2/5] cn_proc: replaced old hard-coded 16 with
 TASK_COMM_LEN_16
Message-ID: <20211208134045.163052f1@gandalf.local.home>
In-Reply-To: <20211204095256.78042-3-laoar.shao@gmail.com>
References: <20211204095256.78042-1-laoar.shao@gmail.com>
        <20211204095256.78042-3-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat,  4 Dec 2021 09:52:53 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> This TASK_COMM_LEN_16 has the same meaning with the macro defined in
> linux/sched.h, but we can't include linux/sched.h in a UAPI header, so
> we should specifically define it in the cn_proc.h.
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  include/uapi/linux/cn_proc.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
> index db210625cee8..6dcccaed383f 100644
> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -21,6 +21,8 @@
>  
>  #include <linux/types.h>
>  
> +#define TASK_COMM_LEN_16 16
> +
>  /*
>   * Userspace sends this enum to register with the kernel that it is listening
>   * for events on the connector.
> @@ -110,7 +112,7 @@ struct proc_event {
>  		struct comm_proc_event {
>  			__kernel_pid_t process_pid;
>  			__kernel_pid_t process_tgid;
> -			char           comm[16];
> +			char           comm[TASK_COMM_LEN_16];
>  		} comm;
>  
>  		struct coredump_proc_event {

