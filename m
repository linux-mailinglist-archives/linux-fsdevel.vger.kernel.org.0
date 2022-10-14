Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543655FE9F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 10:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJNIBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 04:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJNIBx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:01:53 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E3B1BB944;
        Fri, 14 Oct 2022 01:01:51 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id y20so1647346uao.8;
        Fri, 14 Oct 2022 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PUmdXVMRMDwJt1I/xvyYzH+rBmWr4XVWti9DpHOSKBo=;
        b=kmNNVWt/AZwIijj5BQqmzv6Fu42dqFvmHqB3gdQp9DSUtbIu5FQECjshnYXD2ro2sR
         eK8cYeeFjyWEVWmQ5bzVhVs2CyIkwoS1Nuar0r2nh611vhEM+G+R+ACwgcveY333BWDk
         y6a8+F7FLNx0cWjSxlSnqcRHXSWq/EctsFst1gfb9OXOU0ZtCOz22BbYGdekCSZkD+3y
         QkJeyAfP6/57lYTXSi6EL7U4d6RDoKNNi/sl5g1SwuFh5SxllXBylpecYgnMrf1GjTpX
         VkmdbgUvCve/fm4CsN07Hdkz53Pl4/iuq5Fl0m0tmZ8Q023F0TTBgm7m6utVUu0eL4qq
         Ik4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUmdXVMRMDwJt1I/xvyYzH+rBmWr4XVWti9DpHOSKBo=;
        b=KWGf8wWIxt5etVE8a4wHQQc+1nTsxp+q31k0JajPv9o5oGH01Vfhlvr6x1dfGr/Cmn
         qxi5jsAgwWmzVrCmQBuJfKx5vWwQu28qRZaDtdhKNCUK8BptAwXKPasLdafM/TAi7anI
         hq//3qcCRCpKdlbhON5MOwXkbRuAH1mjqjFTVXFF6gPGeeQH24jt7m3Naffgsq6Yeasu
         a2h3CW4YaPXSAtAYQYPGKEWMdPA/UeRyQxvFOyZL48K7bDlV2sWYlAguLYWPbniPmIOX
         sxnHxKOkXG7KGXM7hKijFFLmzPdmdQuMBaugNQwlmu3JqYZwZSt12uUn608xdhMefnyv
         b9sQ==
X-Gm-Message-State: ACrzQf29aHPJgCaeONHcumgyRncyXPvs2GZPKM7Tm/NhhtutNnYoP4z7
        rbvQFMoBcVH3Y/OFh3U8qQrHSORWQJLCf2oVEVY=
X-Google-Smtp-Source: AMsMyM4fgO+VdJA5xsY/iY8FcaL80ZYSu6vfF7B69YFR1iZiXmKCHfeK0ox9U9GNuVFkTabXNjmDaD71qR+ZYkOS5JA=
X-Received: by 2002:ab0:7509:0:b0:3d6:9dcb:b3db with SMTP id
 m9-20020ab07509000000b003d69dcbb3dbmr1776833uap.9.1665734510633; Fri, 14 Oct
 2022 01:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 14 Oct 2022 11:01:39 +0300
Message-ID: <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
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

On Fri, Oct 14, 2022 at 1:27 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Jan, Amir, Al - this is a quite ugly patch but I want to discuss the idea
> behind it, to see whether we can find something workable. I apologize for the
> length of text here, but I think it's necessary to give full context and ideas.
>

Hi Stephen!

> For background, on machines with lots of memory and weird workloads,
> __fsnotify_update_child_dentry_flags() has been a real thorn in our side. It
> grabs a couple spinlocks and iterates over the whole d_subdirs list. If that
> list is long, this can take a while. The list can be long due to lots of
> negative dentries (which can easily number in the hundreds of millions if you
> have a process that's relatively frequently looking up nonexisting files). But
> the list can also be long due to *positive* dentries. I've seen directories with
> ~7 million positive dentry children falling victim to this function before (XFS
> allows lots of files per dir)! Positive dentries take longer to process in this
> function (since they're actually locked and written to), so you don't need as
> many for them to be a problem.
>
> Anyway, if you have a huge d_subdirs list, then you can have problems with soft
> lockups. From my measurements with ftrace, 100 million negative dentries means
> that the function takes about 6 seconds to complete (varies wildly by CPU and
> kernel config/version). That's bad, but it can get *much worse*. Imagine that
> there are many frequently accessed files in such a directory, and you have an
> inotify watch. As soon as that watch is removed, the last fsnotify connector
> goes away, and i_fsnotify_mask becomes 0. System calls accessing dentries still
> see DCACHE_FSNOTIFY_PARENT_WATCHED, so they fall into __fsnotify_parent and will
> try to update the dentry flags. In my experience, a thundering herd of CPUs race
> to __fsnotify_update_child_dentry_flags(). The winner begins updating and the
> rest spin waiting for the parent inode's i_lock. Many CPUs make it to that
> point, and they *all* will proceed to iterate through d_subdirs, regardless of
> how long the list is, even though only the first CPU needed to do it. So now
> your 6 second spin gets multiplied by 5-10. And since the directory is
> frequently accessed, all the dget/dputs from other CPUs will all spin for this
> long time. This amounts to a nearly unusable system.
>
> Previously I've tried to generally limit or manage the number of negative
> dentries in the dcache, which as a general problem is very difficult to get
> concensus on. I've also tried the patches to reorder dentries in d_subdirs so
> negative dentries are at the end, which has some difficult issues interacting
> with d_walk. Neither of those ideas would help for a directory full of positive
> dentries either.
>
> So I have two more narrowly scoped strategies to improve the situation. Both are
> included in the hacky, awful patch below.
>
> First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
> is holding the spinlock for several seconds at a time. We can actually achieve
> this via a cursor, the same way that simple_readdir() is implemented. I think
> this might require moving the declaration of d_alloc_cursor() and maybe
> exporting it. I had to #include fs/internal.h which is not ok.
>
> On its own, that actually makes problems worse, because it allows several tasks
> to update at the same time, and they're constantly locking/unlocking, which
> makes contention worse.
>
> So second is to add an inode flag saying that
> __fsnotify_update_child_dentry_flags() is already in progress. This prevents
> concurrent execution, and it allows the caller to skip updating since they know
> it's being handled, so it eliminates the thundering herd problem.
>
> The patch works great! It eliminates the chances of soft lockups and makes the
> system responsive under those weird loads. But now, I know I've added a new
> issue. Updating dentry flags is no longer atomic, and we've lost the guarantee

Just between us ;) the update of the inode event mask is not atomic anyway,
because the test for 'parent_watched' and fsnotify_inode_watches_children()
in __fsnotify_parent() are done without any memory access synchronization.

IOW, the only guarantee for users is that *sometime* after adding events
to a mark mask, events will start being delivered and *sometime* after
removing events from a mark mask, events will stop being delivered.
Some events may have implicit memory barriers that make event delivery
more deterministic, but others may not.

This may not be considered an issue for asynchronous events, but actually,
for permission events, I would like to fix that.
To understand my motivations you can look at:
https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#Evicting_file_content

> that after fsnotify_recalc_mask(), child dentries are all flagged when
> necessary. It's possible that after __fsnotify_update_child_dentry_flags() will
> skip executing since it sees it's already happening, and inotify_add_watch()
> would return without the watch being fully ready.
>
> I think the approach can still be salvaged, we just need a way to resolve this.
> EG a wait queue or mutex in the connector would allow us to preserve the
> guarantee that the child dentries are flagged when necessary. But I know that's
> a big addition, so I wanted to get some feedback from you as the maintainers. Is
> the strategy here stupid? Am I missing an easier option?

I think you may be missing an easier option.

The call to __fsnotify_update_child_dentry_flags() in
__fsnotify_parent() is a very aggressive optimization
and I think it may be an overkill, and a footgun, according
to your analysis.

If only called from the context of fsnotify_recalc_mask()
(i.e. update mark mask), __fsnotify_update_child_dentry_flags()
can take the dir inode_lock() to synchronize.

I don't think that the dir inode spin lock needs to be held
at all during children iteration.

I think that d_find_any_alias() should be used to obtain
the alias with elevated refcount instead of the awkward
d_u.d_alias iteration loop.

In the context of __fsnotify_parent(), I think the optimization
should stick with updating the flags for the specific child dentry
that had the false positive parent_watched indication,
leaving the rest of the siblings alone.

Would that address the performance issues of your workload?

Jan,

Can you foresee any problems with this change?

Thanks,
Amir.
