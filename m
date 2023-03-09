Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60846B2658
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 15:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCIOKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjCIOKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:10:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A7A6148;
        Thu,  9 Mar 2023 06:08:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75E7B219E3;
        Thu,  9 Mar 2023 14:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678370925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02cwensYYfPLwV4kjxWXiviNQrLpEu8A11nprCgOsxA=;
        b=V8VSKNaWl75655qTvaV3eSxW6t2Zfs/mi0+1M/z/YmkQA0Y4+WSsOVb9ovRvaoffK5XI7s
        ICiDkzieFzksEGZlBsxn/+XeFaOcyBids4pA4tvEJ+ptkOdi3U4Y6/Uwkj64Ds1Ft9iAR2
        jyboAjbFhhBxgon1QkIMUJRoOKQs/+U=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94D042C141;
        Thu,  9 Mar 2023 14:08:44 +0000 (UTC)
Date:   Thu, 9 Mar 2023 15:08:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: global states: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
Message-ID: <ZAnoa8A8geQt6ucf@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 2023-03-02 21:02:05, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current console/printk subsystem is protected by a Big Kernel Lock,
> (aka console_lock) which has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and
> makes forced takeover and output in emergency and panic situations a
> fragile endavour which is based on try and pray.
> 
> The goal of non-BKL consoles is to break out of the console lock jail
> and to provide a new infrastructure that avoids the pitfalls and
> allows console drivers to be gradually converted over.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3472,6 +3492,14 @@ void register_console(struct console *newcon)
>  	newcon->dropped = 0;
>  	console_init_seq(newcon, bootcon_registered);
>  
> +	if (!(newcon->flags & CON_NO_BKL))
> +		have_bkl_console = true;

We never clear this value even when the console gets unregistered.

> +	else
> +		cons_nobkl_init(newcon);
> +
> +	if (newcon->flags & CON_BOOT)
> +		have_boot_console = true;
> +
>  	/*
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
> @@ -3515,6 +3543,9 @@ void register_console(struct console *newcon)
>  			if (con->flags & CON_BOOT)
>  				unregister_console_locked(con);
>  		}
> +
> +		/* All boot consoles have been unregistered. */
> +		have_boot_console = false;

The boot consoles can be removed also by printk_late_init().

I would prefer to make this more error-proof and update both
have_bkl_console and have_boot_console in unregister_console().

A solution would be to use a reference counter instead of the boolean.
I am not sure if it is worth it. But it seems that refcount_read()
is just simple atomic read, aka READ_ONCE().


>  	}
>  unlock:
>  	console_list_unlock();

Best Regards,
Petr
