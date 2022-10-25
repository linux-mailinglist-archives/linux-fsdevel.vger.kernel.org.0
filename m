Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3960CF37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJYOkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 10:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJYOkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:40:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128D562F8;
        Tue, 25 Oct 2022 07:40:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B585C1FE0F;
        Tue, 25 Oct 2022 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666708806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3YzEHDwj4cQ9BO4Yvk8dTKpAMe3kaW5ieC7IbAHjNo=;
        b=biHFGWrz7Oi1CgWQD1wzf19ZV4E8eBh0N1ZnSb/tXh44OrG2VYYXLo3u9QoZGtIPPVjygK
        Gw8/tb9A4rEROK7B0bzVp/4dGQjpsgDVjfLlEp6vEyke11+zwMQPiQ6Ip8T911dyeKJ8VT
        XSyXLezmHs01p2vZ/IzzGNpDCb1mFjE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 896502C171;
        Tue, 25 Oct 2022 14:40:06 +0000 (UTC)
Date:   Tue, 25 Oct 2022 16:40:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 25/38] proc: consoles: document console_lock
 usage
Message-ID: <Y1f1RpMVAo2vHxce@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-26-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-26-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2022-10-19 17:01:47, John Ogness wrote:
> The console_lock is held throughout the start/show/stop procedure
> to print out device/driver information about all registered
> consoles. Since the console_lock is being used for multiple reasons,
> explicitly document these reasons. This will be useful when the
> console_lock is split into fine-grained locking.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  fs/proc/consoles.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
> index cf2e0788f9c7..32512b477605 100644
> --- a/fs/proc/consoles.c
> +++ b/fs/proc/consoles.c
> @@ -63,6 +63,14 @@ static void *c_start(struct seq_file *m, loff_t *pos)
>  	struct console *con;
>  	loff_t off = 0;
>  
> +	/*
> +	 * Stop console printing because the device() callback may
> +	 * assume the console is not within its write() callback.

Like in previous patches, I would prefer to add more information
about this dependency. An example or if it is just to stay
on the safe side.

> +	 *
> +	 * Hold the console_lock to guarantee safe traversal of the
> +	 * console list. SRCU cannot be used because there is no
> +	 * place to store the SRCU cookie.

It might be possible to crate a custom struct for passing both
the next struct console and SRCU cookie. But it probably
is not worth it.

> +	 */
>  	console_lock();
>  	for_each_console(con)
>  		if (off++ == *pos)

Best Regards,
Petr
