Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B05F5F0D5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiI3OVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 10:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiI3OUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:20:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6762FFA71;
        Fri, 30 Sep 2022 07:20:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DB13E2191A;
        Fri, 30 Sep 2022 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664547645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJZugCLc1YNlHmEkQ68DPefG/jnc6zp1D99NraPkKU0=;
        b=LZFblkCaZPo0PC51T4GN6iIBhOOQOkdV1b0ZFgA53mMdxUqsClYjwmNlzEKqtyhyRq+yOc
        FyB+BkOxnxpx0sMJnjMwrfxGjuhsbHIMB2Ptb2Smh7keD6gRm1SHfi6HPDLGtvh4A/DCcJ
        +GQ5C+5LWgSigMzR0SmzPc77cB7Q8Og=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8489F2C161;
        Fri, 30 Sep 2022 14:20:45 +0000 (UTC)
Date:   Fri, 30 Sep 2022 16:20:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to
 hlist
Message-ID: <Yzb7Oh2Y8feej+Eh@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924000454.3319186-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2022-09-24 02:10:47, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the open coded single linked list with a hlist so a conversion to
> SRCU protected list walks can reuse the existing primitives.
> 
> --- a/arch/parisc/kernel/pdc_cons.c
> +++ b/arch/parisc/kernel/pdc_cons.c
> @@ -272,15 +267,17 @@ void pdc_console_restart(bool hpmc)
>  	if (pdc_console_initialized)
>  		return;
>  
> -	if (!hpmc && console_drivers)
> +	if (!hpmc && !hlist_empty(&console_list))
>  		return;
>  
>  	/* If we've already seen the output, don't bother to print it again */
> -	if (console_drivers != NULL)
> +	if (!hlist_empty(&console_list))
>  		pdc_cons.flags &= ~CON_PRINTBUFFER;
>  
> -	while ((console = console_drivers) != NULL)
> -		unregister_console(console_drivers);
> +	while (!hlist_empty(&console_list)) {
> +		unregister_console(READ_ONCE(hlist_entry(console_list.first,
> +							 struct console, node)));

The READ_ONCE() is in a wrong place. This is why it did not compile.
It should be:

		unregister_console(hlist_entry(READ_ONCE(console_list.first),
						struct console,
						node));

I know that it is all hope for good. But there is also a race between
the hlist_empty() and hlist_entry().

We might make it sligtly more safe by using hlist_entry_safe()

	struct console *con;

	while (con = hlist_entry_safe(READ_ONCE(console_list.first),
				      struct console, node)) {
		unregister_console(con);
	}

or

	while (tmp = READ_ONCE(console_list.first) {
		unregister_console(hlist_entry_safe(tmp, struct console, node));
	}

> +	}
>  
>  	/* force registering the pdc console */
>  	pdc_console_init_force();
> diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
> index 6775056eecd5..70994d1e52f6 100644
> --- a/fs/proc/consoles.c
> +++ b/fs/proc/consoles.c
> @@ -74,8 +74,11 @@ static void *c_start(struct seq_file *m, loff_t *pos)
>  static void *c_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct console *con = v;
> +
>  	++*pos;
> -	return con->next;
> +	hlist_for_each_entry_continue(con, node)
> +		break;

Nit: It looks weird and hacky. It does not look like a common patter.
     I see that another code reads the next entry instead.
     I would rather do:

     return hlist_entry_safe(con->node.next, struct *console, node);

and we should later make it rcu safe, something like:

     return hlist_entry_safe(rcu_dereference_raw(hlist_next_rcu(con, struct *console, node));

But I do not have strong opinion.


> +	return con;
>  }
>  
>  static void c_stop(struct seq_file *m, void *v)
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2979,7 +2984,15 @@ void console_flush_on_panic(enum con_flush_mode mode)
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
> +		hlist_for_each_entry(c, &console_list, node)
>  			c->seq = seq;

It is not a big deal. But I would use the _safe() variant to make
it slightly more robust.

>  	}
>  	console_unlock();
> @@ -3211,21 +3227,17 @@ void register_console(struct console *newcon)
>  	}
>  
>  	/*
> -	 *	Put this console in the list - keep the
> -	 *	preferred driver at the head of the list.
> +	 * Put this console in the list and keep the referred driver at the
> +	 * head of the list.
>  	 */
>  	console_lock();
> -	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
> -		newcon->next = console_drivers;
> -		console_drivers = newcon;
> -		if (newcon->next)
> -			newcon->next->flags &= ~CON_CONSDEV;
> -		/* Ensure this flag is always set for the head of the list */
> -		newcon->flags |= CON_CONSDEV;
> -	} else {
> -		newcon->next = console_drivers->next;
> -		console_drivers->next = newcon;
> -	}
> +	if (newcon->flags & CON_CONSDEV || hlist_empty(&console_list))
> +		hlist_add_head(&newcon->node, &console_list);
> +	else
> +		hlist_add_behind(&newcon->node, console_list.first);
> +
> +	/* Ensure this flag is always set for the head of the list */
> +	cons_first()->flags |= CON_CONSDEV;

The patch removed:

		if (newcon->next)
			newcon->next->flags &= ~CON_CONSDEV;

As a result, all consoles will have CON_CONSDEV flag set.
We need to remove it in the 2nd console when exists.
See below for more details.

>  	newcon->dropped = 0;
>  	if (newcon->flags & CON_PRINTBUFFER) {
> @@ -3263,7 +3277,6 @@ EXPORT_SYMBOL(register_console);
>  
>  static int console_unregister_locked(struct console *console)
>  {
> -	struct console *con;
>  	int res;
>  
>  	con_printk(KERN_INFO, console, "disabled\n");
> @@ -3274,32 +3287,28 @@ static int console_unregister_locked(struct console *console)
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
> -	}
>  
> -	if (res)
> -		goto out_disable_unlock;
> +	/* Disable it unconditionally */
> +	console->flags &= ~CON_ENABLED;
> +
> +	if (hlist_unhashed(&console->node))
> +		goto out_unlock;

We should return -ENODEV here. I think that Sergey found this as well.

> +	hlist_del_init(&console->node);
>  
>  	/*
> +	 * <HISTORICAL>
>  	 * If this isn't the last console and it has CON_CONSDEV set, we
>  	 * need to set it on the next preferred console.
> +	 * </HISTORICAL>
> +	 *
> +	 * The above makes no sense as there is no guarantee that the next
> +	 * console has any device attached. Oh well....

This is a sad story. CON_CONSDEV used to be an implementation detail.
It was used to associate the preferred console (last on the
command line) with /dev/console. It was achieved by putting
it at the beginning of the list. All consoled had tty binding at
that time.

The problem started when the flags became readable by user space
via /proc/consoles. There is even a tool (showconsole) that is
reading it. As a result people wanted to show correct value.

The problem is that con->device never exist during boot. The consoles
are registered before the tty subsystem is initialized.

I have a patch that sets the flag correctly in console_device()
that is called from tty_lookup_driver(). But it is part of a bigger
clean up patchset that is sitting in my drawer :-/

On the other hand, the current code kind of works. Most console
drivers have the tty binding. I can't recall what is the exception.
Maybe boot consoles?

>  	 */
> -	if (console_drivers != NULL && console->flags & CON_CONSDEV)
> -		console_drivers->flags |= CON_CONSDEV;
> +	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
> +		cons_first()->flags |= CON_CONSDEV;
>
>  
> -	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  	console_sysfs_notify();

Best Regards,
Petr
