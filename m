Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B06BEA51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCQNk7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCQNk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:40:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B150DE7EEF;
        Fri, 17 Mar 2023 06:40:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679060435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2qjcq7Og9+cY7Q3Q+N0zVW/Adz9r4YtdDCBJr6HAN8=;
        b=3z9VaqExDeurayvWwbwkpIKiUN8Qk3gVEtw3OVFXf7+HmhSOJScZnokF/TKs9QOul4xoL+
        gQoEBCUSUCoAOqx/9ad2LNRHSik3B7SGYxT4etHLAbX498hIlIIzrJIeq4pIYzGCluHG2P
        n8WC4xbFxRA0UQcVUMlxOuDpEXAcoLlEov0UwGH/2h8nO85GZR9LTfCutQ6eMyB1/qYnFq
        u0PVT6ANHjWkRt86aZ6ksLLpctydK3MKOZDBl2BKtvOqLqD33fhHhd7dABd5WNSARKVCVd
        IyMOiCuA7u62SAbZwXYaJi0gbID7TvI8+SEmX1AZ1ci9zVF5QHZ2cIeIV8wHNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679060435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L2qjcq7Og9+cY7Q3Q+N0zVW/Adz9r4YtdDCBJr6HAN8=;
        b=2ZxOvBuBC3yMTs2VbQ1JeWPo8CJwOhzK0hW5rogAyJRnu/+6eZj3Nr6etItOq+BoV6A4Ek
        frwbuHxPfU5qbTCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: naming: Re: [PATCH printk v1 05/18] printk: Add non-BKL console
 basic infrastructure
In-Reply-To: <ZAn8IC+hj+y01vgs@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZAn8IC+hj+y01vgs@alley>
Date:   Fri, 17 Mar 2023 14:45:02 +0106
Message-ID: <87sfe35wg9.fsf@jogness.linutronix.de>
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
> So, this patch adds:
>
> [...]
>
> All the above names seem to be used only by the NOBLK consoles.
> And they use "cons", "NO_BKL", "nobkl", "cons_atomic", "atomic", "console".
>
> I wonder if there is a system or if the names just evolved during several
> reworks.

Yes. And because we didn't really know how to name these different yet
related pieces.

Note that the "atomic" usage is really only referring to the things
related to the atomic part of the console. The console also has a
threaded component.

>    ... an easy to distinguish shortcat would be nice
>    as a common prefix. The following comes to my mind:
>
>    + nbcon - aka nobkl/noblk consoles API
>    + acon  - atomic console API

"acon" is not really appropriate because they are threaded+atomic
consoles, not just atomic consoles. But it probably isn't necessary to
have separate atomic and threaded API forms. The atomic can still be
used as (for example) nbcon_atomic_enter().

> It would look like:
>
> a) variant with nbcom:
>
>
> 	CON_NB		= BIT(8),
>
> 	struct nbcon_state {
> 	atomic_long_t		__private atomic_nbcon_state[2];
>
> 	include/linux/console.h
> 	kernel/printk/nbcon.c
>
> 	enum nbcon_state_selector {
> 		NBCON_STATE_CUR,
>
> 	nbcon_state_set()
> 	nbcon_state_try_cmpxchg()
>
> 	nbcon_init()
> 	nbcon_cleanup()
>
> 	nbcon_can_proceed(struct cons_write_context *wctxt);
> 	nbcon_enter_unsafe(struct cons_write_context *wctxt);
>
> 	nbcon_enter()
> 	nbcon_flush_all();
>
> 	nbcon_emit_next_record()
>
> I would prefer the variant with "nbcon" because
>
> 	$> git grep nbcon | wc -l
> 	0

I also prefer "nbcon". Thanks for finding a name and unique string for
this new code. I will also rename the file to printk_nbcon.c.

John
