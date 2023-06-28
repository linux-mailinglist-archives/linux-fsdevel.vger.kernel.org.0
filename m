Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22207740AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjF1IJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjF1IGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2562956;
        Wed, 28 Jun 2023 01:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BF026132C;
        Wed, 28 Jun 2023 07:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CE5C433C0;
        Wed, 28 Jun 2023 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687937175;
        bh=KKTVALnymNGJ+x0EEK73YI4pMPfmDEYV5K+7qO8CGUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcS7JW5+a8i3+Z8giAru7YHmGUQvZNRoX56KWjc+y86DW90aKZvEtZfAe8F0tgTB6
         vODIPUXQFMnc7oyAgJHFtJ7WWUEOS8/xt+vtbj1Ec+jkkJhRb/33kVHz2LG8ACMbwf
         oX9ySoEp5rruTcNC78fWHKGMKVfWWMVSTRr6k2bJFZq64nMsR6Qb5uX/v266a97WQM
         Kmd8aSMjBU+2dR6lRv0NGfwBXFrrSU9iCVipztVIoJ+vAKGfzGkzrd46kPnt0Cve/x
         u0+00mGkMRvPE+GUMCKMwrLM0ey+apK3Gl7JoD4pYrdzGvsgTCWajYG0CMapDfdyOW
         lUeUocKXOHZdg==
Date:   Wed, 28 Jun 2023 09:26:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
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
Message-ID: <20230628-meisennest-redlich-c09e79fde7f7@brauner>
References: <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
 <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
 <ZJstlHU4Y3ZtiWJe@slm.duckdns.org>
 <CAJuCfpFUrPGVSnZ9+CmMz31GjRNN+tNf6nUmiCgx0Cs5ygD64A@mail.gmail.com>
 <CAJuCfpFe2OdBjZkwHW5UCFUbnQh7hbNeqs7B99PXMXdFNjKb5Q@mail.gmail.com>
 <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org>
 <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:09:46PM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 27, 2023 at 6:54 PM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello,
> >
> > On Tue, Jun 27, 2023 at 02:58:08PM -0700, Suren Baghdasaryan wrote:
> > > Ok in kernfs_generic_poll() we are using kernfs_open_node.poll
> > > waitqueue head for polling and kernfs_open_node is freed from inside
> > > kernfs_unlink_open_file() which is called from kernfs_fop_release().
> > > So, it is destroyed only when the last fput() is done, unlike the
> > > ops->release() operation which we are using for destroying PSI
> > > trigger's waitqueue. So, it seems we still need an operation which
> > > would indicate that the file is truly going away.
> >
> > If we want to stay consistent with how kernfs behaves w.r.t. severing, the
> > right thing to do would be preventing any future polling at severing and
> > waking up everyone currently waiting, which sounds fine from cgroup behavior
> > POV too.
> 
> That's actually what we are currently doing for PSI triggers.
> ->release() is handled by cgroup_pressure_release() which signals the
> waiters, waits for RCU grace period to pass (per
> https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L258)
> and then releases all the trigger resources including the waitqueue
> head. However as reported in
> https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com
> this does not save us from the synchronous polling case:
> 
>                                                   do_select
>                                                       vfs_poll
> cgroup_pressure_release
>     psi_trigger_destroy
>         wake_up_pollfree(&t->event_wait) -> unblocks vfs_poll
>         synchronize_rcu()
>         kfree(t) -> frees waitqueue head
>                                                      poll_freewait()
> -> uses waitqueue head
> 
> 
> This happens because we release the resources associated with the file
> while there are still file users (the file's refcount is non-zero).
> And that happens because kernfs can call ->release() before the last
> fput().
> 
> >
> > Now, the challenge is designing an interface which is difficult to make
> > mistake with. IOW, it'd be great if kernfs wraps poll call so that severing
> > is implemented without kernfs users doing anything, or at least make it
> > pretty obvious what the correct usage pattern is.
> >
> > > Christian's suggestion to rename current ops->release() operation into
> > > ops->drain() (or ops->flush() per Matthew's request) and introduce a
> > > "new" ops->release() which is called only when the last fput() is done
> > > seems sane to me. Would everyone be happy with that approach?
> >
> > I'm not sure I'd go there. The contract is that once ->release() is called,
> > the code backing that file can go away (e.g. rmmod'd). It really should
> > behave just like the last put from kernfs users' POV.
> 
> I 100% agree with the above statement.
> 
> > For this specific fix,
> > it's safe because we know the ops is always built into the kernel and won't
> > go away but it'd be really bad if the interface says "this is a normal thing
> > to do". We'd be calling into rmmod'd text pages in no time.
> >
> > So, I mean, even for temporary fix, we have to make it abundantly clear that
> > this is not for usual usage and can only be used if the code backing the ops
> > is built into the kernel and so on.
> 
> I think the root cause of this problem is that ->release() in kernfs
> does not adhere to the common rule that ->release() is called only
> when the file is going away and has no users left. Am I wrong?

So imho, ultimately this all comes down to rmdir() having special
semantics in kernfs. On any regular filesystem an rmdir() on a directory
which is still referenced by a struct file doesn't trigger an
f_op->release() operation. It's just that directory is unlinked and
you get some sort of errno like ENOENT when you try to create new files
in there or whatever. The actual f_op->release) however is triggered
on last fput().

But in essence, kernfs treats an rmdir() operation as being equivalent
to a final fput() such that it somehow magically kills all file
references. And that's just wrong and not supported.
