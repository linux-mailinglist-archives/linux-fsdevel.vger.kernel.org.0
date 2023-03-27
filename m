Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2421E6CAA95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjC0QaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 12:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjC0QaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:30:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916E1BF8;
        Mon, 27 Mar 2023 09:30:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679934603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VyqB3wrZqFlFld9RbfDWTT11IJPITUDR5qvT0cnykYs=;
        b=TP9hM5Rk04UufjUfoZTutu+arAapZmjAu5FmP7S5tErBzE2R6ghjfdGCwS106VMbgtD9q9
        K8OnmvTRcvJm1Q/0wbHo+sIQYNDxsFB4biyYlrUqYG2LWMnPltOcoKC3ynSj8GhWLAv9yx
        DtLbiqGmciTywf29Gb1+ovA2itjVYXS9ot7IHsJ3njmsF9XHu0UP4h5FRHT1TadZxfFxpQ
        YlPlKXLRc/3EmlElSgQju6f+L1sCBryw6KEaEug7UQFFHhFuo4IZJK6L2P8iDOUNmK+XfP
        IDp8z+qF7s0/GEQx4z2Fya+mNZGXLEOYfiMuMAlzzeMs30R1a/mJTkAE5aPoQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679934603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VyqB3wrZqFlFld9RbfDWTT11IJPITUDR5qvT0cnykYs=;
        b=jh1h+9aAhlNU4Vxf2LDuHH7K9fGCUAw/ulJdS5CkSIir690atArOJjnvmb6LIhThfQ1xty
        FJtuVdcOX8+AlNCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: union: was: Re: [PATCH printk v1 05/18] printk: Add non-BKL
 console basic infrastructure
In-Reply-To: <ZBnVkarywpyWlDWW@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-6-john.ogness@linutronix.de>
 <ZBnVkarywpyWlDWW@alley>
Date:   Mon, 27 Mar 2023 18:34:22 +0206
Message-ID: <87y1nip3a1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-21, Petr Mladek <pmladek@suse.com> wrote:
> It is not completely clear that that this struct is stored
> as atomic_long_t atomic_state[2] in struct console.
>
> What about adding?
>
> 		atomic_long_t atomic;

The struct is used to simplify interpretting and creating values to be
stored in the atomic state variable. I do not think it makes sense that
the atomic variable type itself is part of it.

> Anyway, we should at least add a comment into struct console
> about that atomic_state[2] is used to store and access
> struct cons_state an atomic way. Also add a compilation
> check that the size is the same.

A compilation check would be nice. Is that possible?

I am renaming the struct to nbcon_state. Also the variable will be
called nbcon_state. With the description updated, I think it makes it
clearer that "struct nbcon_state" is used to interpret/create values of
console->nbcon_state.

John Ogness
