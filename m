Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF93576BEC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jul 2022 06:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiGPEzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Jul 2022 00:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGPEzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Jul 2022 00:55:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8538488F25;
        Fri, 15 Jul 2022 21:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DE9260A6E;
        Sat, 16 Jul 2022 04:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D4FC34114;
        Sat, 16 Jul 2022 04:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657947329;
        bh=pMVy+7ApQ1a3/ZhtsqYbelRKmEogN0bTAJep1ceVhbo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCSI4gJTo+N76KhNPvtEgm53nX9O3Bt3RV5RH49+RR7CuTQ1Xa1jKnwhiMsOjhPkL
         OGOaUrQbFdJsLCktWDenvSOy0vtgTuudcvyeO1g8cgxn2uU9EYf2ow+nGm5jNjMjAy
         SAWUVSzI+z9X5aUvqSmfCJm3G6QqnV9zmn+q2edg=
Date:   Fri, 15 Jul 2022 21:55:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Khazhismel Kumykov <khazhy@google.com>, Heiher <r@hev.cc>
Subject: Re: [RESEND RFC PATCH] epoll: autoremove wakers even more
 aggressively
Message-Id: <20220715215528.213e9340e62df36320e89b22@linux-foundation.org>
In-Reply-To: <20220716012731.2zz7hpg3qbhwgeqd@google.com>
References: <xm26fsjotqda.fsf@google.com>
        <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
        <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com>
        <20220629192435.df27c0dbb07ef72165e1de5e@linux-foundation.org>
        <CALvZod5hJ8VJ4E9jhqjCKc8au8_b-h_q+g=2pbQVUSBvappE6g@mail.gmail.com>
        <20220716012731.2zz7hpg3qbhwgeqd@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 16 Jul 2022 01:27:31 +0000 Shakeel Butt <shakeelb@google.com> wrote:

>
> ...
>
> > > > production with real workloads and it has caused hard lockups.
> > > > Particularly network heavy workloads with a lot of threads in
> > > > epoll_wait() can easily trigger this issue if they get killed
> > > > (oom-killed in our case).
> > >
> > > Hard lockups are undesirable.  Is a cc:stable justified here?
> > 
> > Not for now as I don't know if we can blame a patch which might be the
> > source of this behavior.
> 
> I am able to repro the epoll hard lockup on next-20220715 with Ben's
> patch reverted. The repro is a simple TCP server and tens of clients
> communicating over loopback. Though to cause the hard lockup I have to
> create a couple thousand threads in epoll_wait() in server and also
> reduce the kernel.watchdog_thresh. With Ben's patch the repro does not
> cause the hard lockup even with kernel.watchdog.thresh=1.
> 
> Please add:
> 
> Tested-by: Shakeel Butt <shakeelb@google.com>

OK, thanks.  I added the cc:stable.  No Fixes:, as it has presumably
been there for a long time, perhaps for all time.

