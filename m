Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0373604C21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiJSPun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiJSPuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:50:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E3E17C16D;
        Wed, 19 Oct 2022 08:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63F5D61934;
        Wed, 19 Oct 2022 15:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62571C433D7;
        Wed, 19 Oct 2022 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666194292;
        bh=o/OD8G+vdbJhbgJ+vsqXUdwiAK3G61HKg2CQBjPlGkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHHiqjGkehEg/AkuyeLHuX2EdV5e88bsfARJwW6e8C2unj4RBOHSrewe6uV8oheFI
         KJxe2eME3LrDoxyJib9y5Ti9GTyHkhmL8i2ugLpIn9RoxmH8Rq5FdgGA4PQDtDVpUE
         JAEEXkYwLB9H5uvx4w685YPrz1x+vYKcChk7l+5M=
Date:   Wed, 19 Oct 2022 17:44:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
Message-ID: <Y1AbcjQP4TGPxpsv@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:24PM +0206, John Ogness wrote:
> Replace the open coded single linked list with a hlist so a conversion
> to SRCU protected list walks can reuse the existing primitives.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  fs/proc/consoles.c      |  3 +-
>  include/linux/console.h |  8 ++--
>  kernel/printk/printk.c  | 99 +++++++++++++++++++++++------------------
>  3 files changed, 63 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
> index dfe6ce3505ce..cf2e0788f9c7 100644
> --- a/fs/proc/consoles.c
> +++ b/fs/proc/consoles.c
> @@ -74,8 +74,9 @@ static void *c_start(struct seq_file *m, loff_t *pos)
>  static void *c_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct console *con = v;
> +
>  	++*pos;
> -	return con->next;
> +	return hlist_entry_safe(con->node.next, struct console, node);
>  }
>  
>  static void c_stop(struct seq_file *m, void *v)
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 8c1686e2c233..7b5f21f9e469 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_CONSOLE_H_ 1
>  
>  #include <linux/atomic.h>
> +#include <linux/list.h>
>  #include <linux/types.h>
>  
>  struct vc_data;
> @@ -154,14 +155,16 @@ struct console {
>  	u64	seq;
>  	unsigned long dropped;
>  	void	*data;
> -	struct	 console *next;
> +	struct hlist_node node;
>  };
>  
> +extern struct hlist_head console_list;
> +
>  /*
>   * for_each_console() allows you to iterate on each console
>   */
>  #define for_each_console(con) \
> -	for (con = console_drivers; con != NULL; con = con->next)
> +	hlist_for_each_entry(con, &console_list, node)
>  
>  extern int console_set_on_cmdline;
>  extern struct console *early_console;
> @@ -174,7 +177,6 @@ enum con_flush_mode {
>  extern int add_preferred_console(char *name, int idx, char *options);
>  extern void register_console(struct console *);
>  extern int unregister_console(struct console *);
> -extern struct console *console_drivers;
>  extern void console_lock(void);
>  extern int console_trylock(void);
>  extern void console_unlock(void);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e4f1e7478b52..867becc40021 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -79,13 +79,12 @@ int oops_in_progress;
>  EXPORT_SYMBOL(oops_in_progress);
>  
>  /*
> - * console_sem protects the console_drivers list, and also
> - * provides serialisation for access to the entire console
> - * driver system.
> + * console_sem protects console_list and console->flags updates, and also
> + * provides serialization for access to the entire console driver system.
>   */
>  static DEFINE_SEMAPHORE(console_sem);
> -struct console *console_drivers;
> -EXPORT_SYMBOL_GPL(console_drivers);
> +HLIST_HEAD(console_list);
> +EXPORT_SYMBOL_GPL(console_list);
>  
>  /*
>   * System may need to suppress printk message under certain
> @@ -2556,7 +2555,7 @@ static int console_cpu_notify(unsigned int cpu)
>   * console_lock - lock the console system for exclusive use.
>   *
>   * Acquires a lock which guarantees that the caller has
> - * exclusive access to the console system and the console_drivers list.
> + * exclusive access to the console system and console_list.
>   *
>   * Can sleep, returns nothing.
>   */
> @@ -2576,7 +2575,7 @@ EXPORT_SYMBOL(console_lock);
>   * console_trylock - try to lock the console system for exclusive use.
>   *
>   * Try to acquire a lock which guarantees that the caller has exclusive
> - * access to the console system and the console_drivers list.
> + * access to the console system and console_list.
>   *
>   * returns 1 on success, and 0 on failure to acquire the lock.
>   */
> @@ -2940,11 +2939,20 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	console_may_schedule = 0;
>  
>  	if (mode == CONSOLE_REPLAY_ALL) {
> +		struct hlist_node *tmp;
>  		struct console *c;
>  		u64 seq;
>  
>  		seq = prb_first_valid_seq(prb);
> -		for_each_console(c)
> +		/*
> +		 * This cannot use for_each_console() because it's not established
> +		 * that the current context has console locked and neither there is
> +		 * a guarantee that there is no concurrency in that case.
> +		 *
> +		 * Open code it for documentation purposes and pretend that
> +		 * it works.
> +		 */
> +		hlist_for_each_entry_safe(c, tmp, &console_list, node)
>  			c->seq = seq;
>  	}
>  	console_unlock();
> @@ -3081,6 +3089,9 @@ static void try_enable_default_console(struct console *newcon)
>  	       (con->flags & CON_BOOT) ? "boot" : "",	\
>  	       con->name, con->index, ##__VA_ARGS__)
>  
> +#define console_first()				\
> +	hlist_entry(console_list.first, struct console, node)
> +
>  /*
>   * The console driver calls this routine during kernel initialization
>   * to register the console printing procedure with printk() and to
> @@ -3140,8 +3151,8 @@ void register_console(struct console *newcon)
>  	 * flag set and will be first in the list.
>  	 */
>  	if (preferred_console < 0) {
> -		if (!console_drivers || !console_drivers->device ||
> -		    console_drivers->flags & CON_BOOT) {
> +		if (hlist_empty(&console_list) || !console_first()->device ||
> +		    console_first()->flags & CON_BOOT) {
>  			try_enable_default_console(newcon);
>  		}
>  	}
> @@ -3169,20 +3180,22 @@ void register_console(struct console *newcon)
>  	}
>  
>  	/*
> -	 *	Put this console in the list - keep the
> -	 *	preferred driver at the head of the list.
> +	 * Put this console in the list - keep the
> +	 * preferred driver at the head of the list.
>  	 */
>  	console_lock();
> -	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
> -		newcon->next = console_drivers;
> -		console_drivers = newcon;
> -		if (newcon->next)
> -			newcon->next->flags &= ~CON_CONSDEV;
> -		/* Ensure this flag is always set for the head of the list */
> +	if (hlist_empty(&console_list)) {
> +		/* Ensure CON_CONSDEV is always set for the head. */
>  		newcon->flags |= CON_CONSDEV;
> +		hlist_add_head(&newcon->node, &console_list);
> +
> +	} else if (newcon->flags & CON_CONSDEV) {
> +		/* Only the new head can have CON_CONSDEV set. */
> +		console_first()->flags &= ~CON_CONSDEV;
> +		hlist_add_head(&newcon->node, &console_list);
> +
>  	} else {
> -		newcon->next = console_drivers->next;
> -		console_drivers->next = newcon;
> +		hlist_add_behind(&newcon->node, console_list.first);
>  	}
>  
>  	newcon->dropped = 0;
> @@ -3209,16 +3222,18 @@ void register_console(struct console *newcon)
>  	if (bootcon_enabled &&
>  	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
>  	    !keep_bootcon) {
> -		for_each_console(con)
> +		struct hlist_node *tmp;
> +
> +		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
>  			if (con->flags & CON_BOOT)
>  				unregister_console(con);
> +		}
>  	}
>  }
>  EXPORT_SYMBOL(register_console);
>  
>  int unregister_console(struct console *console)
>  {
> -	struct console *con;
>  	int res;
>  
>  	con_printk(KERN_INFO, console, "disabled\n");
> @@ -3229,32 +3244,30 @@ int unregister_console(struct console *console)
>  	if (res > 0)
>  		return 0;
>  
> -	res = -ENODEV;
>  	console_lock();
> -	if (console_drivers == console) {
> -		console_drivers=console->next;
> -		res = 0;
> -	} else {
> -		for_each_console(con) {
> -			if (con->next == console) {
> -				con->next = console->next;
> -				res = 0;
> -				break;
> -			}
> -		}
> +
> +	/* Disable it unconditionally */
> +	console->flags &= ~CON_ENABLED;
> +
> +	if (hlist_unhashed(&console->node)) {

How can this ever be hit?  The console lock is held, so it shouldn't
have gone away already.  Or am I missing something else here?

Other than that minor question, looks good to me!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
