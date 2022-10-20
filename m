Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE32F6058E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 09:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJTHnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 03:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiJTHnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:43:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5F16D55C;
        Thu, 20 Oct 2022 00:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 150F261A2A;
        Thu, 20 Oct 2022 07:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A68FC433D6;
        Thu, 20 Oct 2022 07:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666251786;
        bh=pWk3r8z6RKGfrsVoShtieMSY97GKros1KMV1t/HlkQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s094BYtwA8PaTjvwYY/XjaG1+vTXVGrLj42am8Y+Y0pW3fJWEf16ZpP9wYUghuNcf
         W+C26CALL10oLni4dybRNIOtTU8nNsyPE6MTd5DYAkUJAJFIVA6nPnY9DA9Kzw8Hes
         Uf1AopPu1EUeEv4J3Jq/wx1Rhf4YNGbmbQhvrvUk=
Date:   Thu, 20 Oct 2022 09:43:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk v2 02/38] printk: Convert console_drivers list to
 hlist
Message-ID: <Y1D8CIAEfSRGkmLN@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-3-john.ogness@linutronix.de>
 <Y1AbcjQP4TGPxpsv@kroah.com>
 <87r0z332r6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0z332r6.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:52:53PM +0206, John Ogness wrote:
> On 2022-10-19, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index e4f1e7478b52..867becc40021 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -3229,32 +3244,30 @@ int unregister_console(struct console *console)
> >>  	if (res > 0)
> >>  		return 0;
> >>  
> >> -	res = -ENODEV;
> >>  	console_lock();
> >> -	if (console_drivers == console) {
> >> -		console_drivers=console->next;
> >> -		res = 0;
> >> -	} else {
> >> -		for_each_console(con) {
> >> -			if (con->next == console) {
> >> -				con->next = console->next;
> >> -				res = 0;
> >> -				break;
> >> -			}
> >> -		}
> >> +
> >> +	/* Disable it unconditionally */
> >> +	console->flags &= ~CON_ENABLED;
> >> +
> >> +	if (hlist_unhashed(&console->node)) {
> >
> > How can this ever be hit?  The console lock is held, so it shouldn't
> > have gone away already.  Or am I missing something else here?
> 
> Mainline also has this check. I expect it is for the case that some code
> tries to call unregister_console() for a console that is not
> registered.
> 
> Since register_console() does not return if it succeeded, I suppose some
> code somewhere my try to unregister without knowing that it never
> registered in the first place.

Ick, ok, that's fine for now.

What a mess, thanks for working to unwind it!

greg k-h
