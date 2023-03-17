Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729986BEA17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 14:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjCQNbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 09:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCQNbI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:31:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E6E9773;
        Fri, 17 Mar 2023 06:31:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679059865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xwiYnSfLg++Dxe63z7Rudg/SCXqBpgsqo4DsQQRRiA=;
        b=zI7CvsK8ZXNBSAvmS7mWLv7RZTCEuYWuxA7DOpKERePz4wcKTDj8S4xIbs4kO3ITAhQGXq
        fIL42yegKZ5eWnzTbh9kJeuz9aVcs5qOUngCq8WOC+LTw5fi5I5vOXYFxWBZZzdLF7ANfS
        7U8AxqfrxnxP6cZhIYBngkqbBCjNkFnVl7xt5SNq3/CnGNs/Oc3u/HfiC9DOuh1DfSkkyT
        5r6HGJZ0T1RpDdCIyq9YH1+bUuV1QbGvU5AYRQD2UfFtV3Ko80sGO9nAW61kC8koS8sTzL
        cAjnp5jcvmGqcm0atii6kXwuubihpj59/jX+sDAJTb0rgwgHoJBDa7XWqTE0mw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679059865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1xwiYnSfLg++Dxe63z7Rudg/SCXqBpgsqo4DsQQRRiA=;
        b=W/wC8aNcCSZzj+7+zHMgh/6YXiaugRIvHjzrcSY9PGjqqyayaPXB2o+tx7hlkFT17JdaKw
        k62cp6d6xear99DQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: global states: was: Re: [PATCH printk v1 05/18] printk: Add
 non-BKL console basic infrastructure
In-Reply-To: <ZAnoa8A8geQt6ucf@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZAnoa8A8geQt6ucf@alley>
Date:   Fri, 17 Mar 2023 14:35:32 +0106
Message-ID: <87v8iz5ww3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-09, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3472,6 +3492,14 @@ void register_console(struct console *newcon)
>>  	newcon->dropped = 0;
>>  	console_init_seq(newcon, bootcon_registered);
>>  
>> +	if (!(newcon->flags & CON_NO_BKL))
>> +		have_bkl_console = true;
>
> We never clear this value even when the console gets unregistered.

OK. I'll allow it to be cleared on unregister by checking the registered
list.

>> @@ -3515,6 +3543,9 @@ void register_console(struct console *newcon)
>>  			if (con->flags & CON_BOOT)
>>  				unregister_console_locked(con);
>>  		}
>> +
>> +		/* All boot consoles have been unregistered. */
>> +		have_boot_console = false;
>
> The boot consoles can be removed also by printk_late_init().
>
> I would prefer to make this more error-proof and update both
> have_bkl_console and have_boot_console in unregister_console().

OK.

> A solution would be to use a reference counter instead of the boolean.
> I am not sure if it is worth it. But it seems that refcount_read()
> is just simple atomic read, aka READ_ONCE().

Well, we are holding the console_list_lock, so we can just iterate over
the list. Iteration happens later in the series anyway, in order to
create/run the NOBKL threads.

John
