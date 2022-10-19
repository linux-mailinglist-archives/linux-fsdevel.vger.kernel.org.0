Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3F605233
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJSVq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 17:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJSVq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:46:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D617917FD6B;
        Wed, 19 Oct 2022 14:46:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666216013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/cyKDb3XuAnnMWhhd6eYOoPXNNHf1lClxqaTaQ49uDg=;
        b=u7szAcElL4FD4zdTMsK9ly0/JK7AsxSQxYkmURiBrOAjAapP46G7OlrpWG3FE9YvmPwfTH
        0t7VDO3hj0qCUfIfl8SvWL0m56X0XnWk3XkSt+iW34zthK1xu0vDYJ+ijqpg0Z1uOMJS5N
        WEO2xeBOfASAJiIHV8Of78VvHhfNo58z1z89n87tZ3ztLZfZ2t2fYHpwmA5zqINAwPpi6Y
        YFaMOpAqqg3FdsKqekNzAVfo8q7E3ylZYMSAAdZse1+GqKQ77w/1tUarXW3RJDnkZ3Dmyv
        7jAvya+rBuxJOccUDj5vRsh1bZfhtPrWBFqhbshhDHHAGQJbq7GgFQMg4Mmvvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666216013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/cyKDb3XuAnnMWhhd6eYOoPXNNHf1lClxqaTaQ49uDg=;
        b=V8Q0tclyd6pF7o042cEzobv5Q4u/k+J2N2Phwo9Ih7K5/lA5mE3iK1J4+PjKtagT8wKssj
        /ZDWVCTNtv9kqmCg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
In-Reply-To: <Y1AbcjQP4TGPxpsv@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
 <Y1AbcjQP4TGPxpsv@kroah.com>
Date:   Wed, 19 Oct 2022 23:52:53 +0206
Message-ID: <87r0z332r6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-10-19, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index e4f1e7478b52..867becc40021 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3229,32 +3244,30 @@ int unregister_console(struct console *console)
>>  	if (res > 0)
>>  		return 0;
>>  
>> -	res = -ENODEV;
>>  	console_lock();
>> -	if (console_drivers == console) {
>> -		console_drivers=console->next;
>> -		res = 0;
>> -	} else {
>> -		for_each_console(con) {
>> -			if (con->next == console) {
>> -				con->next = console->next;
>> -				res = 0;
>> -				break;
>> -			}
>> -		}
>> +
>> +	/* Disable it unconditionally */
>> +	console->flags &= ~CON_ENABLED;
>> +
>> +	if (hlist_unhashed(&console->node)) {
>
> How can this ever be hit?  The console lock is held, so it shouldn't
> have gone away already.  Or am I missing something else here?

Mainline also has this check. I expect it is for the case that some code
tries to call unregister_console() for a console that is not
registered.

Since register_console() does not return if it succeeded, I suppose some
code somewhere my try to unregister without knowing that it never
registered in the first place.

> Other than that minor question, looks good to me!
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

John
