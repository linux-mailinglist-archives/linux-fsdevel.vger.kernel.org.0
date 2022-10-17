Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676B2600DFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiJQLpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJQLo6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:44:58 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46226573;
        Mon, 17 Oct 2022 04:44:56 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id g85so5185423vkf.10;
        Mon, 17 Oct 2022 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QbxqZ4AHlFECMTl1lIRRR7lorfpvpayAlobI+bZV+W8=;
        b=aHU3okzNxlozGQQjhVhJ4T5AL+hGheQAvWYexiYrAwvMuz48sXLRRuORtuVOPp2Je+
         kRGn2z4wjumzWc5pfxfmyIUNXzjHTJPbZ8VSBV2B4K1TUlmXvJbrQJgQDdOX7O2dSUCw
         1LfsSlVTnUY4uqFbn2zyUNsUTCXEs1AomGbaK92htSS09WyTIswZTtE2xuDmUxm562tN
         7OLdqG9e5dafrTkmlLiznvhCTdU4Om87MPQCoa79FqsNznqjsN1+TvNlrzGp8miJ9lx0
         mef1DaYoNhnOpydEBsb1TJzEOOKb41Ket9CBT1s/J1EEvjfzCMCO5GITgW+kL8GD+av8
         YzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbxqZ4AHlFECMTl1lIRRR7lorfpvpayAlobI+bZV+W8=;
        b=IXEOOn0vvkO4Z8t9+17vx8ASNJPG0XD0RFwpTk9ABC+4nU1t4dRw3hAru2ijzjRhCr
         hE6im+pxMyZnn0i87enTzDPmwatx9OD1MpBHSghl7JKN3xkd706CyrZ9UOn/kX/RU+YO
         Yl4w2OC7jqdv3/Fk8T3Fxczwj+AZbPw8l7bPwkbej+hRtxPeo0m1BkXKTCkN532NeCAj
         36/HpeWWpDB+Ics9NI3tGHXaRU+6aeghYW7opG7qNQ8UQWo+j37dJLQW7SqOdy532tkz
         5rQs56ZVj3jUVr9R8dKlBUFeuB+VlzShOBm4eK+90npTI6B9wqCrSLJA20VcCLoSJBSl
         l+fw==
X-Gm-Message-State: ACrzQf1+1xRoBZK9znSDpXnquOdUcgswV5JmaNDU4CuWljNUV9HAS6f6
        Ol0J7u5J1F9roy6G2X0pLQ99PvojfsZ6PG1lMsg=
X-Google-Smtp-Source: AMsMyM773i9go4n7nuEzuU4x+IlCB/6Z0sQwob60RLKsrRAlzb1Q5VzNE39dzuqEMBvbc561hhZeXFzZaVMvSpVO0pM=
X-Received: by 2002:a1f:1eca:0:b0:3ab:b4a6:bec2 with SMTP id
 e193-20020a1f1eca000000b003abb4a6bec2mr3919335vke.25.1666007095701; Mon, 17
 Oct 2022 04:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com> <87o7ua519v.fsf@oracle.com>
In-Reply-To: <87o7ua519v.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 17 Oct 2022 14:44:44 +0300
Message-ID: <CAOQ4uxiamB8zfr=XTrnKA9BB4=B-DtwOim=xcYNc+vcW=WXv9Q@mail.gmail.com>
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:59 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
> > On Fri, Oct 14, 2022 at 1:27 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> Hi Jan, Amir, Al - this is a quite ugly patch but I want to discuss the idea
> >> behind it, to see whether we can find something workable. I apologize for the
> >> length of text here, but I think it's necessary to give full context and ideas.
> >>
> >
> > Hi Stephen!
> >
> >> For background, on machines with lots of memory and weird workloads,
> >> __fsnotify_update_child_dentry_flags() has been a real thorn in our side. It
> >> grabs a couple spinlocks and iterates over the whole d_subdirs list. If that
> >> list is long, this can take a while. The list can be long due to lots of
> >> negative dentries (which can easily number in the hundreds of millions if you
> >> have a process that's relatively frequently looking up nonexisting files). But
> >> the list can also be long due to *positive* dentries. I've seen directories with
> >> ~7 million positive dentry children falling victim to this function before (XFS
> >> allows lots of files per dir)! Positive dentries take longer to process in this
> >> function (since they're actually locked and written to), so you don't need as
> >> many for them to be a problem.
> >>
> >> Anyway, if you have a huge d_subdirs list, then you can have problems with soft
> >> lockups. From my measurements with ftrace, 100 million negative dentries means
> >> that the function takes about 6 seconds to complete (varies wildly by CPU and
> >> kernel config/version). That's bad, but it can get *much worse*. Imagine that
> >> there are many frequently accessed files in such a directory, and you have an
> >> inotify watch. As soon as that watch is removed, the last fsnotify connector
> >> goes away, and i_fsnotify_mask becomes 0. System calls accessing dentries still
> >> see DCACHE_FSNOTIFY_PARENT_WATCHED, so they fall into __fsnotify_parent and will
> >> try to update the dentry flags. In my experience, a thundering herd of CPUs race
> >> to __fsnotify_update_child_dentry_flags(). The winner begins updating and the
> >> rest spin waiting for the parent inode's i_lock. Many CPUs make it to that
> >> point, and they *all* will proceed to iterate through d_subdirs, regardless of
> >> how long the list is, even though only the first CPU needed to do it. So now
> >> your 6 second spin gets multiplied by 5-10. And since the directory is
> >> frequently accessed, all the dget/dputs from other CPUs will all spin for this
> >> long time. This amounts to a nearly unusable system.
> >>
> >> Previously I've tried to generally limit or manage the number of negative
> >> dentries in the dcache, which as a general problem is very difficult to get
> >> concensus on. I've also tried the patches to reorder dentries in d_subdirs so
> >> negative dentries are at the end, which has some difficult issues interacting
> >> with d_walk. Neither of those ideas would help for a directory full of positive
> >> dentries either.
> >>
> >> So I have two more narrowly scoped strategies to improve the situation. Both are
> >> included in the hacky, awful patch below.
> >>
> >> First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
> >> is holding the spinlock for several seconds at a time. We can actually achieve
> >> this via a cursor, the same way that simple_readdir() is implemented. I think
> >> this might require moving the declaration of d_alloc_cursor() and maybe
> >> exporting it. I had to #include fs/internal.h which is not ok.
> >>
> >> On its own, that actually makes problems worse, because it allows several tasks
> >> to update at the same time, and they're constantly locking/unlocking, which
> >> makes contention worse.
> >>
> >> So second is to add an inode flag saying that
> >> __fsnotify_update_child_dentry_flags() is already in progress. This prevents
> >> concurrent execution, and it allows the caller to skip updating since they know
> >> it's being handled, so it eliminates the thundering herd problem.
> >>
> >> The patch works great! It eliminates the chances of soft lockups and makes the
> >> system responsive under those weird loads. But now, I know I've added a new
> >> issue. Updating dentry flags is no longer atomic, and we've lost the guarantee
> >
> > Just between us ;) the update of the inode event mask is not atomic anyway,
> > because the test for 'parent_watched' and fsnotify_inode_watches_children()
> > in __fsnotify_parent() are done without any memory access synchronization.
> >
> > IOW, the only guarantee for users is that *sometime* after adding events
> > to a mark mask, events will start being delivered and *sometime* after
> > removing events from a mark mask, events will stop being delivered.
> > Some events may have implicit memory barriers that make event delivery
> > more deterministic, but others may not.
>
> I did wonder about whether it was truly atomic even without the
> sleeping... the sleeping just makes matters much worse. But without the
> sleeping, I feel like it wouldn't take much memory synchronization.
> The dentry flags modification is protected by a spinlock, I assume we
> would just need a memory barrier to pair with the unlock?
>

Haha "just" cannot be used here :)
Yes, some sort of memory barrier is missing.
The trick is not hurting performance in the common fast path
where the event subscription mask has not been changed.

This is especially true considering that all applications to date
did just fine without atomic semantics for updating mark masks.
Some applications may have been living in blissful ignorance ...

> (But then again, I really need to read and then reread the memory model
> document, and think about it when it's not late for me.)
>
> > This may not be considered an issue for asynchronous events, but actually,
> > for permission events, I would like to fix that.
> > To understand my motivations you can look at:
> > https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Evicting_file_content
>
> I'll take a deeper look in (my) morning! It definitely helps for me to
> better understand use cases since I really don't know much beyond
> inotify.
>

Don't stress yourself over this doc, it's a WIP, but it describes
a system where the atomic update of mark masks would be
important for correctness.

The document does provide a method of working around
the atomic mask update requirement (making sure that
sb event mask includes the needed event), which should be
good enough for the described use case.

> >> that after fsnotify_recalc_mask(), child dentries are all flagged when
> >> necessary. It's possible that after __fsnotify_update_child_dentry_flags() will
> >> skip executing since it sees it's already happening, and inotify_add_watch()
> >> would return without the watch being fully ready.
> >>
> >> I think the approach can still be salvaged, we just need a way to resolve this.
> >> EG a wait queue or mutex in the connector would allow us to preserve the
> >> guarantee that the child dentries are flagged when necessary. But I know that's
> >> a big addition, so I wanted to get some feedback from you as the maintainers. Is
> >> the strategy here stupid? Am I missing an easier option?
> >
> > I think you may be missing an easier option.
> >
> > The call to __fsnotify_update_child_dentry_flags() in
> > __fsnotify_parent() is a very aggressive optimization
> > and I think it may be an overkill, and a footgun, according
> > to your analysis.
>
> Agreed!
>
> > If only called from the context of fsnotify_recalc_mask()
> > (i.e. update mark mask), __fsnotify_update_child_dentry_flags()
> > can take the dir inode_lock() to synchronize.
> >
> > I don't think that the dir inode spin lock needs to be held
> > at all during children iteration.
>
> Definitely a sleeping lock is better than the spin lock. And if we did
> something like that, it would be worth keeping a little bit of state in
> the connector to keep track of whether the dentry flags are set or not.
> This way, if several marks are added in a row, you don't repeatedly
> iterate over the children to do the same operation over and over again.
>
> No matter what, we have to hold the parent dentry's spinlock, and that's
> expensive. So if we can make the update happen only when it would
> actually enable or disable the flags, that's worth a few bits of state.
>

As Jan wrote, this state already exists in i_fsnotify_mask.
fsnotify_recalc_mask() is very capable of knowing when the
state described by fsnotify_inode_watches_children() is
going to change.

> > I think that d_find_any_alias() should be used to obtain
> > the alias with elevated refcount instead of the awkward
> > d_u.d_alias iteration loop.
>
> D'oh! Much better idea :)
> Do you think the BUG_ON would still be worthwhile?
>

Which BUG_ON()?
In general no, if there are ever more multiple aliases for
a directory inode, updating dentry flags would be the last
of our problems.


> > In the context of __fsnotify_parent(), I think the optimization
> > should stick with updating the flags for the specific child dentry
> > that had the false positive parent_watched indication,
> > leaving the rest of
>
> > WOULD that address the performance issues of your workload?
>
> I think synchronizing the __fsnotify_update_child_dentry_flags() with a
> mutex and getting rid of the call from __fsnotify_parent() would go a
> *huge* way (maybe 80%?) towards resolving the performance issues we've
> seen. To be clear, I'm representing not one single workload, but a few
> different customer workloads which center around this area.
>
> There are some extreme cases I've seen, where the dentry list is so
> huge, that even iterating over it once with the parent dentry spinlock
> held is enough to trigger softlockups - no need for several calls to
> __fsnotify_update_child_dentry_flags() queueing up as described in the
> original mail. So ideally, I'd love to try make *something* work with
> the cursor idea as well. But I think the two ideas can be separated
> easily, and I can discuss with Al further about if cursors can be
> salvaged at all.
>

Assuming that you take the dir inode_lock() in
__fsnotify_update_child_dentry_flags(), then I *think* that children
dentries cannot be added to dcache and children dentries cannot
turn from positive to negative and vice versa.

Probably the only thing that can change d_subdirs is children dentries
being evicted from dcache(?), so I *think* that once in N children
if you can dget(child), drop alias->d_lock, cond_resched(),
and then continue d_subdirs iteration from child->d_child.

Thanks,
Amir.
