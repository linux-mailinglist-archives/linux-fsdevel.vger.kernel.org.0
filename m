Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A18991373D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgAJQkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbgAJQki (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:40:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93009205F4;
        Fri, 10 Jan 2020 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578674438;
        bh=ghwT9udGzFrI759DFzCiR1cP5wbf5wcwUL/Ty1oAAt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FcRjA3WCXsltMm/vW2YxcIFxXQ9LJ7UMhG+2itz701PCG1v3z3I8/3D8ROl81la8V
         9p+q8NmV9m0PHSZF8+P0goioG1ox055bD67dhTIoYjdTQUxn3HBFduEuICthJPv1Yo
         YCyBoH3EMvZkQmKiIcomfnwVpukeNyWEdVsrJ/OM=
Date:   Fri, 10 Jan 2020 17:40:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
Message-ID: <20200110164035.GA1822445@kroah.com>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109215444.95995-3-dima@arista.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:54:43PM +0000, Dmitry Safonov wrote:
> Many embedded boards have a disconnected TTL level serial which can
> generate some garbage that can lead to spurious false sysrq detects.
> 
> Currently, sysrq can be either completely disabled for serial console
> or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
> commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")
> 
> At Arista, we have such boards that can generate BREAK and random
> garbage. While disabling sysrq for serial console would solve
> the problem with spurious false sysrq triggers, it's also desirable
> to have a way to enable sysrq back.
> 
> Having the way to enable sysrq was beneficial to debug lockups with
> a manual investigation in field and on the other side preventing false
> sysrq detections.
> 
> As a preparation to add sysrq_toggle_support() call into uart,
> remove a private copy of sysrq_enabled from sysctl - it should reflect
> the actual status of sysrq.
> 
> Furthermore, the private copy isn't correct already in case
> sysrq_always_enabled is true. So, remove __sysrq_enabled and use a
> getter-helper for sysrq enabled status.
> 
> Cc: Iurii Zaikin <yzaikin@google.com>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  drivers/tty/sysrq.c   |  7 +++++++
>  include/linux/sysrq.h |  1 +
>  kernel/sysctl.c       | 41 ++++++++++++++++++++++-------------------
>  3 files changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f724962a5906..ef3e78967146 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -73,6 +73,13 @@ static bool sysrq_on_mask(int mask)
>  	       (sysrq_enabled & mask);
>  }
>  
> +int sysrq_get_mask(void)
> +{
> +	if (sysrq_always_enabled)
> +		return 1;
> +	return sysrq_enabled;
> +}
> +
>  static int __init sysrq_always_enabled_setup(char *str)
>  {
>  	sysrq_always_enabled = true;
> diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
> index 8c71874e8485..4a0b351fa2d3 100644
> --- a/include/linux/sysrq.h
> +++ b/include/linux/sysrq.h
> @@ -50,6 +50,7 @@ int unregister_sysrq_key(int key, struct sysrq_key_op *op);
>  struct sysrq_key_op *__sysrq_get_key_op(int key);
>  
>  int sysrq_toggle_support(int enable_mask);
> +int sysrq_get_mask(void);
>  
>  #else
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index d396aaaf19a3..6ddb4d7df0e1 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -229,25 +229,8 @@ static int proc_dopipe_max_size(struct ctl_table *table, int write,
>  		void __user *buffer, size_t *lenp, loff_t *ppos);
>  
>  #ifdef CONFIG_MAGIC_SYSRQ
> -/* Note: sysrq code uses its own private copy */
> -static int __sysrq_enabled = CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE;
> -
>  static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> -				void __user *buffer, size_t *lenp,
> -				loff_t *ppos)
> -{
> -	int error;
> -
> -	error = proc_dointvec(table, write, buffer, lenp, ppos);
> -	if (error)
> -		return error;
> -
> -	if (write)
> -		sysrq_toggle_support(__sysrq_enabled);
> -
> -	return 0;
> -}
> -
> +			void __user *buffer, size_t *lenp, loff_t *ppos);
>  #endif
>  
>  static struct ctl_table kern_table[];
> @@ -747,7 +730,7 @@ static struct ctl_table kern_table[] = {
>  #ifdef CONFIG_MAGIC_SYSRQ
>  	{
>  		.procname	= "sysrq",
> -		.data		= &__sysrq_enabled,
> +		.data		= NULL,
>  		.maxlen		= sizeof (int),
>  		.mode		= 0644,
>  		.proc_handler	= sysrq_sysctl_handler,
> @@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
>  }
>  #endif
>  
> +#ifdef CONFIG_MAGIC_SYSRQ
> +static int sysrq_sysctl_handler(struct ctl_table *table, int write,
> +				void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	int tmp, ret;
> +
> +	tmp = sysrq_get_mask();
> +
> +	ret = __do_proc_dointvec(&tmp, table, write, buffer,
> +			       lenp, ppos, NULL, NULL);
> +	if (ret || !write)
> +		return ret;
> +
> +	if (write)
> +		sysrq_toggle_support(tmp);
> +
> +	return 0;
> +}
> +#endif

Why did you move this function down here?  Can't it stay where it is and
you can just fix the logic there?  Now you have two different #ifdef
blocks intead of just one :(

thanks,

greg k-h
