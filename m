Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865A12E1726
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 04:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgLWDG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 22:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728457AbgLWCTD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:19:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5118223433;
        Wed, 23 Dec 2020 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1608689888;
        bh=R0GgtW0Z1JE6ep06gBJirpvx2dF4VWd/qcbtrwZGKWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ymOdiXAuiLNwRDOhtFvmsllhv+v91pv9FpgDvx28VXnPupm5V9ykvv5dQJ+aBsgMS
         559RPS+VA/W+AyrLCpBfr3FUHSuy2HsottWtif4pFNIxEkxAskQc1ptWIGMxlkPc7N
         Hou3SfBOHIPhTZF6FVOYAWpNUsC5Z+FGRaRVDGEs=
Date:   Tue, 22 Dec 2020 18:18:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/wchan: Use printk format instead of
 lookup_symbol_name()
Message-Id: <20201222181807.360cd9458d50b625608b8b44@linux-foundation.org>
In-Reply-To: <20201217165413.GA1959@ls3530.fritz.box>
References: <20201217165413.GA1959@ls3530.fritz.box>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 17 Dec 2020 17:54:13 +0100 Helge Deller <deller@gmx.de> wrote:

> To resolve the symbol fuction name for wchan, use the printk format
> specifier %ps instead of manually looking up the symbol function name
> via lookup_symbol_name().
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 

Please don't forget the "^---$" to separate the changelog from the
diff.

>  #include <linux/module.h>
> @@ -386,19 +385,17 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
>  			  struct pid *pid, struct task_struct *task)
>  {
>  	unsigned long wchan;
> -	char symname[KSYM_NAME_LEN];
> 
> -	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> -		goto print0;
> +	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
> +		wchan = get_wchan(task);
> +	else
> +		wchan = 0;
> 
> -	wchan = get_wchan(task);
> -	if (wchan && !lookup_symbol_name(wchan, symname)) {
> -		seq_puts(m, symname);
> -		return 0;
> -	}
> +	if (wchan)
> +		seq_printf(m, "%ps", (void *) wchan);
> +	else
> +		seq_putc(m, '0');
> 
> -print0:
> -	seq_putc(m, '0');
>  	return 0;
>  }

We can simplify this further?

static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
			  struct pid *pid, struct task_struct *task)
{
	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
		seq_printf(m, "%ps", (void *)get_wchan(task));
	else
		seq_putc(m, '0');

	return 0;
}


--- a/fs/proc/base.c~proc-wchan-use-printk-format-instead-of-lookup_symbol_name-fix
+++ a/fs/proc/base.c
@@ -384,15 +384,8 @@ static const struct file_operations proc
 static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
-	unsigned long wchan;
-
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		wchan = get_wchan(task);
-	else
-		wchan = 0;
-
-	if (wchan)
-		seq_printf(m, "%ps", (void *) wchan);
+		seq_printf(m, "%ps", (void *)get_wchan(task));
 	else
 		seq_putc(m, '0');
 
_

