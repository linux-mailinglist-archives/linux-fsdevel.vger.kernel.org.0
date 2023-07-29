Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67002768001
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjG2OXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 10:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjG2OXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5F30F3;
        Sat, 29 Jul 2023 07:23:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE88960C0B;
        Sat, 29 Jul 2023 14:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D54C433C7;
        Sat, 29 Jul 2023 14:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690640631;
        bh=Y6XLivR35U3l92U/t1ajfxY4CEDNQ0gQnBoe7QqWXh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GfFDsR6FCIuPH5YsMEwGoOk9Z43Cxejcu9K1Rs4wXJB4OoSJpUQ9QWAEiOKVMUfNO
         L67UVJukSeLHj14g8Bgs32C3kcf41WcgYYn/SB0Bs8LmJKCcVWZ62DDKri37YJ4Unn
         NTymznNWEHehIBeOCsuBqlk1frqI08i/H7ZxSB/IfRNeLkyxgJqVR1KDGqni5Ru5BR
         uplW4mmnHrhOespkc9ImsDDrZ4JcuM8f9ZXoZsvS5r25YHrNyeTYEtWhkAFx+FkgNN
         v1zsC25zOtloDns4HnI9urXrdUPbuzPBnmN79LFIkxtDTdOk9/cPGxMQ1WSM3DlX9G
         W5zy+v6aZ4Prw==
Date:   Sat, 29 Jul 2023 23:23:46 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 2/2] fs/proc: Add /proc/cmdline_image
 for embedded arguments
Message-Id: <20230729232346.a09a94e5586942aeda5df188@kernel.org>
In-Reply-To: <20230728033701.817094-2-paulmck@kernel.org>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
        <20230728033701.817094-2-paulmck@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Paul,

On Thu, 27 Jul 2023 20:37:01 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will show
> all kernel boot parameters, both those supplied by the boot loader and
> those embedded in the kernel image.  This works well for those who just
> want to see all of the kernel boot parameters, but is not helpful to those
> who need to see only those parameters that were embedded into the kernel
> image.  This is especially important in situations where there are many
> kernel images for different kernel versions and kernel configurations,
> all of which opens the door to a great deal of human error.

There is /proc/bootconfig file which shows all bootconfig entries and is
formatted as easily filter by grep (or any other line-based commands).
(e.g. `grep ^kernel\\. /proc/cmdline` will filter all kernel cmdline
parameters in the bootconfig)
Could you clarify the reason why you need a dump of bootconfig file?

Thank you,

> 
> Therefore, provide a /proc/cmdline_image file that shows only those kernel
> boot parameters that were embedded in the kernel image.  The output
> is in boot-image format, which allows easy reconcilation against the
> boot-config source file.
> 
> Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
> it makes sense to put it in the same place that /proc/cmdline is located.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  fs/proc/cmdline.c    | 12 ++++++++++++
>  include/linux/init.h | 11 ++++++-----
>  init/main.c          |  9 +++++++++
>  3 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
> index 1d0ef9d2949d..4ab5223198cb 100644
> --- a/fs/proc/cmdline.c
> +++ b/fs/proc/cmdline.c
> @@ -20,6 +20,15 @@ static int cmdline_load_proc_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +static int cmdline_image_proc_show(struct seq_file *m, void *v)
> +{
> +#ifdef CONFIG_BOOT_CONFIG_FORCE
> +	seq_puts(m, saved_bootconfig_string);
> +	seq_putc(m, '\n');
> +#endif
> +	return 0;
> +}
> +
>  static int __init proc_cmdline_init(void)
>  {
>  	struct proc_dir_entry *pde;
> @@ -31,6 +40,9 @@ static int __init proc_cmdline_init(void)
>  		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
>  		pde_make_permanent(pde);
>  		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> +		pde = proc_create_single("cmdline_image", 0, NULL, cmdline_image_proc_show);
> +		pde_make_permanent(pde);
> +		pde->size = strnlen(saved_bootconfig_string, COMMAND_LINE_SIZE) + 1;
>  	}
>  	return 0;
>  }
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 29e75bbe7984..c075983c5015 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -14,7 +14,7 @@
>  #define __noinitretpoline
>  #endif
>  
> -/* These macros are used to mark some functions or 
> +/* These macros are used to mark some functions or
>   * initialized data (doesn't apply to uninitialized data)
>   * as `initialization' functions. The kernel can take this
>   * as hint that the function is used only during the initialization
> @@ -22,7 +22,7 @@
>   *
>   * Usage:
>   * For functions:
> - * 
> + *
>   * You should add __init immediately before the function name, like:
>   *
>   * static void __init initme(int x, int y)
> @@ -148,6 +148,7 @@ extern char boot_command_line[];
>  extern char *saved_command_line;
>  extern unsigned int saved_command_line_len;
>  extern unsigned int reset_devices;
> +extern char saved_bootconfig_string[];
>  
>  /* used by init/main.c */
>  void setup_arch(char **);
> @@ -184,7 +185,7 @@ extern void (*late_time_init)(void);
>  extern bool initcall_debug;
>  
>  #endif
> -  
> +
>  #ifndef MODULE
>  
>  #ifndef __ASSEMBLY__
> @@ -192,8 +193,8 @@ extern bool initcall_debug;
>  /*
>   * initcalls are now grouped by functionality into separate
>   * subsections. Ordering inside the subsections is determined
> - * by link order. 
> - * For backwards compatibility, initcall() puts the call in 
> + * by link order.
> + * For backwards compatibility, initcall() puts the call in
>   * the device init subsection.
>   *
>   * The `id' arg to __define_initcall() is needed so that multiple initcalls
> diff --git a/init/main.c b/init/main.c
> index 2121685c479a..981170da0b1c 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -146,6 +146,11 @@ static char *extra_command_line;
>  /* Extra init arguments */
>  static char *extra_init_args;
>  
> +/* Untouched boot-config string */
> +#ifdef CONFIG_BOOT_CONFIG_FORCE
> +char saved_bootconfig_string[COMMAND_LINE_SIZE] __ro_after_init;
> +#endif
> +
>  #ifdef CONFIG_BOOT_CONFIG
>  /* Is bootconfig on command line? */
>  static bool bootconfig_found;
> @@ -435,6 +440,10 @@ static void __init setup_boot_config(void)
>  		return;
>  	}
>  
> +#ifdef CONFIG_BOOT_CONFIG_FORCE
> +	strncpy(saved_bootconfig_string, data, COMMAND_LINE_SIZE);
> +#endif
> +
>  	if (size >= XBC_DATA_MAX) {
>  		pr_err("bootconfig size %ld greater than max size %d\n",
>  			(long)size, XBC_DATA_MAX);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
