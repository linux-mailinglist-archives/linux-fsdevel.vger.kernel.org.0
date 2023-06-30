Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1F17436E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjF3IV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 04:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjF3IV1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF90DF;
        Fri, 30 Jun 2023 01:21:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09D4B616FD;
        Fri, 30 Jun 2023 08:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE79C433C0;
        Fri, 30 Jun 2023 08:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688113285;
        bh=3WdNh6Grs+kqer6cZpf6hfvo7NtN46ck2Nwqp04SL3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoFiYN+b8NOjzxxfmch5nNhJF0KcD482ibkYZnlh79q3qu28yfegUQ3hOcg6T4uY+
         4CcRTAQBTWKEnK7VtF00v0bU7BCcACcMQ8uODrS8q31CnV4RJ/N3y16ntO4FxuGxCH
         SO+GSyJGX9yDa8Bl0snO11T6WU9sCoGIGfTrvGnlO8RJvsyUFbclbz8XJQwO7uRyVx
         XX3GXlftgzXajYYDZ1Nt3gbfGQQwAMxnsiuZGjxXCpmlUB5BEAiSszbV6Qz/OZcx2c
         lfpTZs23WKOdWd1igtiVjOulB7DtfhOfVvIIUuIEtzoq+ZS12OST7SrOhEX05LYffR
         ICocUIUIwirXA==
Date:   Fri, 30 Jun 2023 10:21:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <20230630-fegefeuer-urheber-0a25a219520d@brauner>
References: <20230628-faden-qualvoll-6c33b570f54c@brauner>
 <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner>
 <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
 <2023062845-stabilize-boogieman-1925@gregkh>
 <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
 <ZJyZWtK4nihRkTME@slm.duckdns.org>
 <CAJuCfpFKjhmti8k6OHoDHAu6dPvqP0jn8FFdSDPqmRfH97bkiQ@mail.gmail.com>
 <CAJuCfpH3JcwADEYPBhzUcunj0dcgYNRo+0sODocdhbuXQsbsUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH3JcwADEYPBhzUcunj0dcgYNRo+0sODocdhbuXQsbsUQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:59:07PM -0700, Suren Baghdasaryan wrote:
> On Wed, Jun 28, 2023 at 2:50 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 1:34 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > Hello, Suren.
> > >
> > > On Wed, Jun 28, 2023 at 01:12:23PM -0700, Suren Baghdasaryan wrote:
> > > > AFAIU all other files that handle polling rely on f_op->release()
> > > > being called after all the users are gone, therefore they can safely
> > > > free their resources. However kernfs can call ->release() while there
> > > > are still active users of the file. I can't use that operation for
> > > > resource cleanup therefore I was suggesting to add a new operation
> > > > which would be called only after the last fput() and would guarantee
> > > > no users. Again, I'm not an expert in this, so there might be a better
> > > > way to handle it. Please advise.
> > >
> > > So, w/ kernfs, the right thing to do is making sure that whatever is exposed
> > > to the kernfs user is terminated on removal - ie. after kernfs_ops->release
> > > is called, the ops table should be considered dead and there shouldn't be
> > > anything left to clean up from the kernfs user side. You can add abstraction
> > > kernfs so that kernfs can terminate the calls coming down from the higher
> > > layers on its own. That's how every other operation is handled and what
> > > should happen with the psi polling too.
> >
> > I'm not sure I understand. The waitqueue head we are freeing in
> > ->release() can be accessed asynchronously and does not require any
> > kernfs_op call. Here is a recap of that race:
> >
> >                                                 do_select
> >                                                       vfs_poll
> > cgroup_pressure_release
> >     psi_trigger_destroy
> >         wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
> >         synchronize_rcu()
> >         kfree(t) -> frees waitqueue head
> >                                                      poll_freewait() -> UAF
> >
> > Note that poll_freewait() is not part of any kernel_op, so I'm not
> > sure how adding an abstraction kernfs would help, but again, this is
> > new territory for me and I might be missing something.
> >
> > On a different note, I think there might be an easy way to fix this.
> > What if psi triggers reuse kernfs_open_node->poll waitqueue head?
> > Since we are overriding the ->poll() method, that waitqueue head is
> > unused AFAIKT. And best of all, its lifecycle is tied to the file's
> > lifecycle, so it does not have the issue that trigger waitqueue head
> > has. In the trigger I could simply store a pointer to that waitqueue
> > and use it. Then in ->release() freeing trigger would not affect the
> > waitqueue at all. Does that sound sane?
> 
> I think this approach is much cleaner and I'm guessing that's in line
> with what Tejun was describing (maybe it's exactly what he was telling
> me but it took time for me to get it). Posted the patch implementing
> this approach here:
> https://lore.kernel.org/all/20230630005612.1014540-1-surenb@google.com/

I'm sure that how things work today in kernfs are there for a reason.A

What I'm mostly reacting to is that there's a kernfs_ops->release()
method which mirrors f_op->release() but can be called when there are
still users which is counterintuitive for release semantics. And that
ultimately caused this UAF issue which was rather subtle given how long
it took to track down the root cause.

A rmdir() isn't triggering a f_op->release() if there are still file
references but it's apparently triggering a kernfs_ops->release(). It
feels like this should at least be documented in struct kernfs_ops...
