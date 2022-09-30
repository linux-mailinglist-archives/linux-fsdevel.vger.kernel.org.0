Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB575F12F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiI3Tqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI3Tqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:46:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FA8F3702;
        Fri, 30 Sep 2022 12:46:37 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664567196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbW8DKX7zU09gxwJfrfX3jl8AILIcXKQL/EnvH/yi0w=;
        b=sznnd/ZBaWHzMHzT/EXwzgFvSRC3aw22KrO8TO7BrsfwZp+muqDUibOXqm3ZakE3wgpYTw
        e2fwRSZLBTsVjknFX217Ll4L+6iRv9Z7KSR0KCL06os9PQckjHxww4YcnwjO9aQl9lqYwb
        hWivWHgJVm79IsH/c0GqOXqOfuJ1A7YukiLm1On/5YEiNe+emfzOQDkRZ+oDZlGb10y6Iy
        1TYJeyfEfAaGGQWLFLSpdiZ/uXAzCBrLvfSzZEOE7cFHBVg/A2Iotpjdz5WqJu2k8+jVBe
        sFx+o1pWAR7zAAnjEglqQdUadU9B5GAvYZJC/YI7O+nTNI78FGJuwt9hX6QFFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664567196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nbW8DKX7zU09gxwJfrfX3jl8AILIcXKQL/EnvH/yi0w=;
        b=OBddV2cRP/x93aIFmWGJBp3bj20v/z+nxE/hxzVoW9P/G6exVpURQd4A/fI8/IXYJupuU7
        CZWGawnM3Iw9MhAg==
To:     Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH printk 11/18] printk: Convert console_drivers list to hlist
In-Reply-To: <db7bdf7a-597f-398e-9877-01e898733664@gmx.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-12-john.ogness@linutronix.de>
 <Yzb7Oh2Y8feej+Eh@alley> <db7bdf7a-597f-398e-9877-01e898733664@gmx.de>
Date:   Fri, 30 Sep 2022 21:52:35 +0206
Message-ID: <8735c88x2c.fsf@jogness.linutronix.de>
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

On 2022-09-30, Helge Deller <deller@gmx.de> wrote:
>> I know that it is all hope for good. But there is also a race between
>> the hlist_empty() and hlist_entry().
>
> I wonder if pdc_console() is still needed as it is today.  When this
> was written, early_console and such didn't worked for parisc as it
> should. That's proably why we have this register/unregister in here.
>
> Would it make sense, and would we gain something for this
> printk-series, if I'd try to convert pdc_console to a standard
> earlycon or earlyprintk device?

Having an earlycon or earlyprintk device will not really help you here
since those drivers will have already unregistered.

However, once we get the new atomic/kthread interface available, it
certainly would be useful to implement the pdc_console as an atomic
console.

John Ogness
