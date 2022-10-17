Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31336009EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiJQJJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiJQJJV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:09:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67714A13C;
        Mon, 17 Oct 2022 02:09:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 578FE3395C;
        Mon, 17 Oct 2022 09:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665997755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88wK67BDieF4b7nVysekk7pGFuWGHIsQOMr5btm2BLM=;
        b=pFQs5kwvcI1EdtNbOJS7NwkaeMtaNLx5QhgJrNdoOiix3xq5FIe5vQmkQTMkR7ofVR/PdF
        VIqcyGfcHCFrss89zpT4gF0Pz1/GbDVXl4t/qWuwdGYPd7rUByLz0GmLNaHhn+qtlKlNTh
        nvZ63sS8ACjXDuq8mVgRiNEmOYEuuH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665997755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88wK67BDieF4b7nVysekk7pGFuWGHIsQOMr5btm2BLM=;
        b=LGjSUJhrF0aM2/Wjccdsz30nZjjb4hhZkWKC7TmqlpGCn9k859nlnszziMw2paMSuKhYd7
        vdxPrupnM0X3SQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4711913398;
        Mon, 17 Oct 2022 09:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9jZVEbsbTWMbOAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 17 Oct 2022 09:09:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C8CACA06EF; Mon, 17 Oct 2022 11:09:14 +0200 (CEST)
Date:   Mon, 17 Oct 2022 11:09:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] fsnotify: allow sleepable child dentry flag update
Message-ID: <20221017090914.63b7p4655xrxycnz@quack3>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiXU72-cxbpqdv_5BC4VdjGx5V79zycfD3_tPSWixtT3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi guys!

On Fri 14-10-22 11:01:39, Amir Goldstein wrote:
> On Fri, Oct 14, 2022 at 1:27 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > Hi Jan, Amir, Al - this is a quite ugly patch but I want to discuss the idea
> > behind it, to see whether we can find something workable. I apologize for the
> > length of text here, but I think it's necessary to give full context and ideas.
> 
> > For background, on machines with lots of memory and weird workloads,
> > __fsnotify_update_child_dentry_flags() has been a real thorn in our side. It
> > grabs a couple spinlocks and iterates over the whole d_subdirs list. If that
> > list is long, this can take a while. The list can be long due to lots of
> > negative dentries (which can easily number in the hundreds of millions if you
> > have a process that's relatively frequently looking up nonexisting files). But
> > the list can also be long due to *positive* dentries. I've seen directories with
> > ~7 million positive dentry children falling victim to this function before (XFS
> > allows lots of files per dir)! Positive dentries take longer to process in this
> > function (since they're actually locked and written to), so you don't need as
> > many for them to be a problem.
> >
> > Anyway, if you have a huge d_subdirs list, then you can have problems with soft
> > lockups. From my measurements with ftrace, 100 million negative dentries means
> > that the function takes about 6 seconds to complete (varies wildly by CPU and
> > kernel config/version). That's bad, but it can get *much worse*. Imagine that
> > there are many frequently accessed files in such a directory, and you have an
> > inotify watch. As soon as that watch is removed, the last fsnotify connector
> > goes away, and i_fsnotify_mask becomes 0. System calls accessing dentries still
> > see DCACHE_FSNOTIFY_PARENT_WATCHED, so they fall into __fsnotify_parent and will
> > try to update the dentry flags. In my experience, a thundering herd of CPUs race
> > to __fsnotify_update_child_dentry_flags(). The winner begins updating and the
> > rest spin waiting for the parent inode's i_lock. Many CPUs make it to that
> > point, and they *all* will proceed to iterate through d_subdirs, regardless of
> > how long the list is, even though only the first CPU needed to do it. So now
> > your 6 second spin gets multiplied by 5-10. And since the directory is
> > frequently accessed, all the dget/dputs from other CPUs will all spin for this
> > long time. This amounts to a nearly unusable system.
> >
> > Previously I've tried to generally limit or manage the number of negative
> > dentries in the dcache, which as a general problem is very difficult to get
> > concensus on. I've also tried the patches to reorder dentries in d_subdirs so
> > negative dentries are at the end, which has some difficult issues interacting
> > with d_walk. Neither of those ideas would help for a directory full of positive
> > dentries either.
> >
> > So I have two more narrowly scoped strategies to improve the situation. Both are
> > included in the hacky, awful patch below.
> >
> > First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
> > is holding the spinlock for several seconds at a time. We can actually achieve
> > this via a cursor, the same way that simple_readdir() is implemented. I think
> > this might require moving the declaration of d_alloc_cursor() and maybe
> > exporting it. I had to #include fs/internal.h which is not ok.
> >
> > On its own, that actually makes problems worse, because it allows several tasks
> > to update at the same time, and they're constantly locking/unlocking, which
> > makes contention worse.
> >
> > So second is to add an inode flag saying that
> > __fsnotify_update_child_dentry_flags() is already in progress. This prevents
> > concurrent execution, and it allows the caller to skip updating since they know
> > it's being handled, so it eliminates the thundering herd problem.
> >
> > The patch works great! It eliminates the chances of soft lockups and makes the
> > system responsive under those weird loads. But now, I know I've added a new
> > issue. Updating dentry flags is no longer atomic, and we've lost the guarantee
> 
> Just between us ;) the update of the inode event mask is not atomic anyway,
> because the test for 'parent_watched' and fsnotify_inode_watches_children()
> in __fsnotify_parent() are done without any memory access synchronization.
> 
> IOW, the only guarantee for users is that *sometime* after adding events
> to a mark mask, events will start being delivered and *sometime* after
> removing events from a mark mask, events will stop being delivered.
> Some events may have implicit memory barriers that make event delivery
> more deterministic, but others may not.

This holds even for fsnotify_inode_watches_children() call in
__fsnotify_update_child_dentry_flags(). In principle we can have racing
calls to __fsnotify_update_child_dentry_flags() which result in temporary
inconsistency of child dentry flags with the mask in parent's connector.

> > that after fsnotify_recalc_mask(), child dentries are all flagged when
> > necessary. It's possible that after __fsnotify_update_child_dentry_flags() will
> > skip executing since it sees it's already happening, and inotify_add_watch()
> > would return without the watch being fully ready.
> >
> > I think the approach can still be salvaged, we just need a way to resolve this.
> > EG a wait queue or mutex in the connector would allow us to preserve the
> > guarantee that the child dentries are flagged when necessary. But I know that's
> > a big addition, so I wanted to get some feedback from you as the maintainers. Is
> > the strategy here stupid? Am I missing an easier option?
> 
> I think you may be missing an easier option.
> 
> The call to __fsnotify_update_child_dentry_flags() in
> __fsnotify_parent() is a very aggressive optimization
> and I think it may be an overkill, and a footgun, according
> to your analysis.
> 
> If only called from the context of fsnotify_recalc_mask()
> (i.e. update mark mask), __fsnotify_update_child_dentry_flags()
> can take the dir inode_lock() to synchronize.

This will nest inode lock into fsnotify group lock though. I'm not aware of
any immediate lock ordering problem with that but it might be problematic.
Otherwise this seems workable.

BTW if we call __fsnotify_update_child_dentry_flags() only from
fsnotify_recalc_mask(), I don't think we even need more state in the
connector to detect whether dentry flags update is needed or not.
fsnotify_recalc_mask() knows the old & new mask state so it has all the
information it needs to detect whether dentry flags update is needed or
not. We just have to resolve the flags update races first to avoid
maintaining the inconsistent flags state for a long time.

> I don't think that the dir inode spin lock needs to be held
> at all during children iteration.
> 
> I think that d_find_any_alias() should be used to obtain
> the alias with elevated refcount instead of the awkward
> d_u.d_alias iteration loop.
> 
> In the context of __fsnotify_parent(), I think the optimization
> should stick with updating the flags for the specific child dentry
> that had the false positive parent_watched indication,
> leaving the rest of the siblings alone.

Yep, that looks sensible to me. Essentially this should be just an uncommon
fixup path until the full child dentry walk from fsnotify_recalc_mask()
catches up with synchronizing all child dentry flags.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
