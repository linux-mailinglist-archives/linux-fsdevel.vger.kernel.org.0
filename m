Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A215628F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2020 02:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBHBlT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 20:41:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgBHBlS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 20:41:18 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9D720715;
        Sat,  8 Feb 2020 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581126077;
        bh=ok8xnRwzPxoEz7l61eArC1oYHCRcgYe7TQOp0xr9TV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yhnUbYriL5zCcdupDniUdDrLcUgi/cyld1UcctrqLj8Tx2ojXY3QkP4vktVb9Ql7c
         0IRS4pu4LiOXe7LsVDMK69IygHpYXngZKEB4EDLpFXXwiFDpRXOZAlvt6cD8cfSuK/
         w+X5YCZKQQaapPzMlT/LozACyAIj8vUVxNiM22Yc=
Date:   Sat, 8 Feb 2020 10:41:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Use parse_args() to find bootconfig and
 '--'
Message-Id: <20200208104111.a124ba3a026dfd9c408a44cf@kernel.org>
In-Reply-To: <20200207192632.0cd953a7@oasis.local.home>
References: <20200207192632.0cd953a7@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 7 Feb 2020 19:26:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The current implementation does a naive search of "bootconfig" on the kernel
> command line. But this could find "bootconfig" that is part of another
> option in quotes (although highly unlikely). But it also needs to find '--'
> on the kernel command line to know if it should append a '--' or not when a
> bootconfig in the initrd file has an "init" section. The check uses the
> naive strstr() to find to see if it exists. But this can return a false
> positive if it exists in an option and then the "init" section in the initrd
> will not be appended properly.
> 
> Using parse_args() to find both of these will solve both of these problems.

Thanks Steve and Kees! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


> 
> Link: https://lore.kernel.org/r/202002070954.C18E7F58B@keescook
> 
> Fixes: 7495e0926fdf3 ("bootconfig: Only load bootconfig if "bootconfig" is on the kernel cmdline")
> Fixes: 1319916209ce8 ("bootconfig: init: Allow admin to use bootconfig for init command line")
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  init/main.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 491f1cdb3105..e7261f1a3523 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -142,6 +142,15 @@ static char *extra_command_line;
>  /* Extra init arguments */
>  static char *extra_init_args;
>  
> +#ifdef CONFIG_BOOT_CONFIG
> +/* Is bootconfig on command line? */
> +static bool bootconfig_found;
> +static bool initargs_found;
> +#else
> +# define bootconfig_found false
> +# define initargs_found false
> +#endif
> +
>  static char *execute_command;
>  static char *ramdisk_execute_command;
>  
> @@ -336,17 +345,31 @@ u32 boot_config_checksum(unsigned char *p, u32 size)
>  	return ret;
>  }
>  
> +static int __init bootconfig_params(char *param, char *val,
> +				    const char *unused, void *arg)
> +{
> +	if (strcmp(param, "bootconfig") == 0) {
> +		bootconfig_found = true;
> +	} else if (strcmp(param, "--") == 0) {
> +		initargs_found = true;
> +	}
> +	return 0;
> +}
> +
>  static void __init setup_boot_config(const char *cmdline)
>  {
> +	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
>  	u32 size, csum;
>  	char *data, *copy;
>  	const char *p;
>  	u32 *hdr;
>  	int ret;
>  
> -	p = strstr(cmdline, "bootconfig");
> -	if (!p || (p != cmdline && !isspace(*(p-1))) ||
> -	    (p[10] && !isspace(p[10])))
> +	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
> +	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> +		   bootconfig_params);
> +
> +	if (!bootconfig_found)
>  		return;
>  
>  	if (!initrd_end)
> @@ -563,11 +586,12 @@ static void __init setup_command_line(char *command_line)
>  		 * to init.
>  		 */
>  		len = strlen(saved_command_line);
> -		if (!strstr(boot_command_line, " -- ")) {
> +		if (initargs_found) {
> +			saved_command_line[len++] = ' ';
> +		} else {
>  			strcpy(saved_command_line + len, " -- ");
>  			len += 4;
> -		} else
> -			saved_command_line[len++] = ' ';
> +		}
>  
>  		strcpy(saved_command_line + len, extra_init_args);
>  	}
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
