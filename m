Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFC76800C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jul 2023 16:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjG2O3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jul 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjG2O3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jul 2023 10:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284B35A2;
        Sat, 29 Jul 2023 07:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB2860C6D;
        Sat, 29 Jul 2023 14:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBCAC433C7;
        Sat, 29 Jul 2023 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690640974;
        bh=cptqgmzc2MqsuyFTFU2BcvHCbSItKXjhvYX4h/bDNYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBh7GFKC5+Bijjx67ikbrA0bhNbcHACINAkFfi4Sc5TPplQARAktjuaHCkyZI3lF/
         0qofJZG8P1PCmnAYvGpqy5Wijn4H1P+EJB8vLTlCRm22GvBg9E7I3UzSWayje2CejI
         fMrGDfZSeg1uBSyU7nmk2w+ZE7cQcmFgUX+rFUEo9pnpEztK6KF61tPsvsO7nj9ts3
         K/KWPcWNMbx/ozRx2v9W62OtglY+jDjjqpCRava0kTcdbpytTwx81RuftFgyv8uYpY
         XRop07KJ1Pim+c++hILTKFd3xD+QLWB9oKmU7fDKixV6Ttai8UpiKbryK69tm/A/YC
         nrUAdXHIMIsOg==
Date:   Sat, 29 Jul 2023 23:29:29 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-Id: <20230729232929.a3e962f46c16973031bb466c@kernel.org>
In-Reply-To: <20230728033701.817094-1-paulmck@kernel.org>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
        <20230728033701.817094-1-paulmck@kernel.org>
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

On Thu, 27 Jul 2023 20:37:00 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> show all kernel boot parameters, both those supplied by the boot loader
> and those embedded in the kernel image.  This works well for those who
> just want to see all of the kernel boot parameters, but is not helpful to
> those who need to see only those parameters supplied by the boot loader.
> This is especially important when these parameters are presented to the
> boot loader by automation that might gather them from diverse sources.
> 
> Therefore, provide a /proc/cmdline_load file that shows only those kernel
> boot parameters supplied by the boot loader.

If I understand correctly, /proc/cmdline_load is something like
/proc/cmdline_load - `/proc/bootconfig | grep ^kernel\\.`.

BTW, what about CONFIG_CMDLINE? We already have that Kconfig and it is also
merged with the command line specified by boot loader. Should we also
expose that? (when CONFIG_CMDLINE_OVERRIDE=y, we don't need it because
cmdline is always overridden by the CONFIG_CMDLINE) Unfortunatelly, this
option is implemented in each arch init, so we have to change all of them...

Thank you,

> 
> Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
> it makes sense to put it in the same place that /proc/cmdline is located.
> 
> [ sfr: Apply kernel test robot feedback. ]
> 
> Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> ---
>  fs/proc/cmdline.c    | 13 +++++++++++++
>  include/linux/init.h |  3 ++-
>  init/main.c          |  2 +-
>  3 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
> index a6f76121955f..1d0ef9d2949d 100644
> --- a/fs/proc/cmdline.c
> +++ b/fs/proc/cmdline.c
> @@ -3,6 +3,7 @@
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
> +#include <asm/setup.h>
>  #include "internal.h"
>  
>  static int cmdline_proc_show(struct seq_file *m, void *v)
> @@ -12,6 +13,13 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> +{
> +	seq_puts(m, boot_command_line);
> +	seq_putc(m, '\n');
> +	return 0;
> +}
> +
>  static int __init proc_cmdline_init(void)
>  {
>  	struct proc_dir_entry *pde;
> @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
>  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
>  	pde_make_permanent(pde);
>  	pde->size = saved_command_line_len + 1;
> +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> +		pde_make_permanent(pde);
> +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> +	}
>  	return 0;
>  }
>  fs_initcall(proc_cmdline_init);
> diff --git a/include/linux/init.h b/include/linux/init.h
> index 266c3e1640d4..29e75bbe7984 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -112,6 +112,7 @@
>  #define __REFCONST       .section       ".ref.rodata", "a"
>  
>  #ifndef __ASSEMBLY__
> +
>  /*
>   * Used for initialization calls..
>   */
> @@ -143,7 +144,7 @@ struct file_system_type;
>  
>  /* Defined in init/main.c */
>  extern int do_one_initcall(initcall_t fn);
> -extern char __initdata boot_command_line[];
> +extern char boot_command_line[];

FYI, boot_command_line[] is mixture of built-in cmdline string with
bootloader cmdline string.

>  extern char *saved_command_line;
>  extern unsigned int saved_command_line_len;
>  extern unsigned int reset_devices;
> diff --git a/init/main.c b/init/main.c
> index ad920fac325c..2121685c479a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
>  void (*__initdata late_time_init)(void);
>  
>  /* Untouched command line saved by arch-specific code. */
> -char __initdata boot_command_line[COMMAND_LINE_SIZE];
> +char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
>  /* Untouched saved command line (eg. for /proc) */
>  char *saved_command_line __ro_after_init;
>  unsigned int saved_command_line_len __ro_after_init;
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
