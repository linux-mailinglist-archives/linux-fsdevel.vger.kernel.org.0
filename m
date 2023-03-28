Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAF6CB93A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 10:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjC1IU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 04:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1IUy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D644A7;
        Tue, 28 Mar 2023 01:20:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1807D1FD81;
        Tue, 28 Mar 2023 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679991628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRcn8tarDsWg3kdLklqiCIWLcIN+nPnBDYzbSZWYh8Y=;
        b=gZupk3tipjwAsFo6fQqtftzCaAwarwag9hpdUBGeMueBBBkNzMbWNCjWCUdWc+umQ3pGjm
        1hELF15qK4IdF7Gl+WNc1bWAD3sHlRQo0MeNCbEAhN5pnGXnf4Gj6gNC85BA2HMNrqjocL
        rtI67tDECoZrGzT+v6QPY+HRTVhKnDM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACFC22C142;
        Tue, 28 Mar 2023 08:20:27 +0000 (UTC)
Date:   Tue, 28 Mar 2023 10:20:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
Message-ID: <ZCKjSpDbiBVabbP5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZBnVkarywpyWlDWW@alley>
 <87y1nip3a1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1nip3a1.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2023-03-27 18:34:22, John Ogness wrote:
> On 2023-03-21, Petr Mladek <pmladek@suse.com> wrote:
> > It is not completely clear that that this struct is stored
> > as atomic_long_t atomic_state[2] in struct console.
> >
> > What about adding?
> >
> > 		atomic_long_t atomic;
> 
> The struct is used to simplify interpretting and creating values to be
> stored in the atomic state variable. I do not think it makes sense that
> the atomic variable type itself is part of it.

It was just an idea. Feel free to keep it as is (not to add the atomic
into the union).

> > Anyway, we should at least add a comment into struct console
> > about that atomic_state[2] is used to store and access
> > struct cons_state an atomic way. Also add a compilation
> > check that the size is the same.
> 
> A compilation check would be nice. Is that possible?

I think the following might do the trick:

static_assert(sizeof(struct cons_state) == sizeof(atomic_long_t));


> I am renaming the struct to nbcon_state. Also the variable will be
> called nbcon_state. With the description updated, I think it makes it
> clearer that "struct nbcon_state" is used to interpret/create values of
> console->nbcon_state.

Sounds good.

Best Regards,
Petr
