Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60D560F1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 04:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiF3CYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 22:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiF3CYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ADA22B33;
        Wed, 29 Jun 2022 19:24:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C052561962;
        Thu, 30 Jun 2022 02:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF22EC34114;
        Thu, 30 Jun 2022 02:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656555876;
        bh=yJeJ8cxCY1JPgvNnKkpCGOCqg6IUmcfcvP4TCv5bff0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2AiqIjuhS5T+jbkNlITFAdB4je3qEdSDNFbTndEgoO0p/HibCpc+8FT781kPXIdZH
         qxkwGDFH1BW2EcPyZAD+7AUSj+j2EuK6roYIiid7fqgAvnKuU8ek6vKRAgJZHfLXFt
         sIApNFeR8JfgYlbzzmkAz1NxBEPkqUkL9MJgH1mY=
Date:   Wed, 29 Jun 2022 19:24:35 -0700
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
Message-Id: <20220629192435.df27c0dbb07ef72165e1de5e@linux-foundation.org>
In-Reply-To: <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com>
References: <xm26fsjotqda.fsf@google.com>
        <20220629165542.da7fc8a2a5dbd53cf99572aa@linux-foundation.org>
        <CALvZod5KX7XEHR9h_jFHf5pJcYB+dODEeaLKrQLtSy9EUqgvWw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022 18:12:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Jun 29, 2022 at 4:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 15 Jun 2022 14:24:23 -0700 Benjamin Segall <bsegall@google.com> wrote:
> >
> > > If a process is killed or otherwise exits while having active network
> > > connections and many threads waiting on epoll_wait, the threads will all
> > > be woken immediately, but not removed from ep->wq. Then when network
> > > traffic scans ep->wq in wake_up, every wakeup attempt will fail, and
> > > will not remove the entries from the list.
> > >
> > > This means that the cost of the wakeup attempt is far higher than usual,
> > > does not decrease, and this also competes with the dying threads trying
> > > to actually make progress and remove themselves from the wq.
> > >
> > > Handle this by removing visited epoll wq entries unconditionally, rather
> > > than only when the wakeup succeeds - the structure of ep_poll means that
> > > the only potential loss is the timed_out->eavail heuristic, which now
> > > can race and result in a redundant ep_send_events attempt. (But only
> > > when incoming data and a timeout actually race, not on every timeout)
> > >
> >
> > Thanks.  I added people from 412895f03cbf96 ("epoll: atomically remove
> > wait entry on wake up") to cc.  Hopefully someone there can help review
> > and maybe test this.
> >
> >
> 
> Thanks Andrew. Just wanted to add that we are seeing this issue in
> production with real workloads and it has caused hard lockups.
> Particularly network heavy workloads with a lot of threads in
> epoll_wait() can easily trigger this issue if they get killed
> (oom-killed in our case).

Hard lockups are undesirable.  Is a cc:stable justified here?
