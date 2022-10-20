Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B1606050
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 14:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJTMgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 08:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJTMgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:36:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA721217F4;
        Thu, 20 Oct 2022 05:36:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C8B06336C7;
        Thu, 20 Oct 2022 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666269365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o4ei7yu6QWFyLMaeYgPNpdUb6xNNxRYG7Pz1Chl8oOg=;
        b=TCTHPh2Er+wUmxpEnRpZf3ieCEOZOXhVL2OvOL/blhd9yLGgfPeGmwG9aJk+4KlkG8bQnb
        xV95E7D8OVyvBS76T0pDEPaEPG0qvcDIzCDjM+n4VCJBzC1E4NjBkD4mDXzatbXmzwIpT1
        zdnJxZ4wf+OCrFda3jhu4dDPBGPto7I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 857AB2C141;
        Thu, 20 Oct 2022 12:36:05 +0000 (UTC)
Date:   Thu, 20 Oct 2022 14:36:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
Message-ID: <Y1FAsgNc8Bh2si0U@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2022-10-19 17:01:24, John Ogness wrote:
> Replace the open coded single linked list with a hlist so a conversion
> to SRCU protected list walks can reuse the existing primitives.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just one nit below.

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
> +		res = -ENODEV;
> +		goto out_unlock;

Nit: It might make sense to replace this with:

		console_unlock();
		return -ENODEV;

This is the only code path using the extra goto target.

It is just an idea. I do not resist on this change.

>  	}
>  
> -	if (res)
> -		goto out_disable_unlock;
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
>  	 */
> -	if (console_drivers != NULL && console->flags & CON_CONSDEV)
> -		console_drivers->flags |= CON_CONSDEV;
> +	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
> +		console_first()->flags |= CON_CONSDEV;
>  
> -	console->flags &= ~CON_ENABLED;
>  	console_unlock();
>  	console_sysfs_notify();
>  
> @@ -3263,10 +3276,8 @@ int unregister_console(struct console *console)
>  
>  	return res;
>  
> -out_disable_unlock:
> -	console->flags &= ~CON_ENABLED;
> +out_unlock:
>  	console_unlock();
> -
>  	return res;
>  }
>  EXPORT_SYMBOL(unregister_console);

Best Regards,
Petr
