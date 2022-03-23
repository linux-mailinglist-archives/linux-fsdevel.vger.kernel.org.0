Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC494E5382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiCWNu1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiCWNuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:50:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA5A369DA
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 06:48:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0E881F387;
        Wed, 23 Mar 2022 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648043334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0wwxHHV6XvfFJaP4X86zLnWnqDWkt1I/WT6miUsagg=;
        b=DapBYRI3RjJ0kxppsIrfRTXeTym062Zapw7rY87Bn5xPROrRsLaBzES8jmNIwRDec/Xb6Q
        VViCPvqfAXaNnnPjo7u2wKHIgtE7p0KmzOGrPLio0Jfzi94kGM24fYsStEQq2JYeEKNlhg
        y1xJfRK8IEiXIKlQf2rR72WoGocKfGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648043334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o0wwxHHV6XvfFJaP4X86zLnWnqDWkt1I/WT6miUsagg=;
        b=00VMYElZKflxt5pkFqUagKClelX6K886R9Pug7vJzhc+KcmINkMRIKyKLGPSBwDjdGGCjT
        nxmgeNiLVs2xERCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AC44DA3B83;
        Wed, 23 Mar 2022 13:48:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3C36AA0610; Wed, 23 Mar 2022 14:48:51 +0100 (CET)
Date:   Wed, 23 Mar 2022 14:48:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Message-ID: <20220323134851.px6s4i6iiaj4zlju@quack3.lan>
References: <20220319001635.4097742-1-khazhy@google.com>
 <ea2afc67b92f33dbf406c3ebf49a0da9c6ec1e5b.camel@hammerspace.com>
 <CAOQ4uxgTJdcO-xZbtTSUkjD2g0vSHr=PLFc6-T6RgO0u5DS=0g@mail.gmail.com>
 <20220321112310.vpr7oxro2xkz5llh@quack3.lan>
 <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
 <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan>
 <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 23-03-22 13:40:18, Amir Goldstein wrote:
> On Wed, Mar 23, 2022 at 12:41 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 23-03-22 00:41:28, Amir Goldstein wrote:
> > > > > > So the cleanest solution I currently see is
> > > > > > to come up with helpers like "fsnotify_lock_group() &
> > > > > > fsnotify_unlock_group()" which will lock/unlock mark_mutex and also do
> > > > > > memalloc_nofs_save / restore magic.
> > > > > >
> > > > >
> > > > > Sounds good. Won't this cause a regression - more failures to setup new mark
> > > > > under memory pressure?
> > > >
> > > > Well, yes, the chances of hitting ENOMEM under heavy memory pressure are
> > > > higher. But I don't think that much memory is consumed by connectors or
> > > > marks that the reduced chances for direct reclaim would really
> > > > substantially matter for the system as a whole.
> > > >
> > > > > Should we maintain a flag in the group FSNOTIFY_GROUP_SHRINKABLE?
> > > > > and set NOFS state only in that case, so at least we don't cause regression
> > > > > for existing applications?
> > > >
> > > > So that's a possibility I've left in my sleeve ;). We could do it but then
> > > > we'd also have to tell lockdep that there are two kinds of mark_mutex locks
> > > > so that it does not complain about possible reclaim deadlocks. Doable but
> > > > at this point I didn't consider it worth it unless someone comes with a bug
> > > > report from a real user scenario.
> > >
> > > Are you sure about that?
> >
> > Feel free to try it, I can be wrong...
> >
> > > Note that fsnotify_destroy_mark() and friends already use lockdep class
> > > SINGLE_DEPTH_NESTING, so I think the lockdep annotation already
> > > assumes that deadlock from direct reclaim cannot happen and it is that
> > > assumption that was nearly broken by evictable inode marks.
> > >
> > > IIUC that means that we only need to wrap the fanotify allocations
> > > with GFP_NOFS (technically only after the first evictable mark)?
> >
> > Well, the dependencies lockdep will infer are: Once fsnotify_destroy_mark()
> > is called from inode reclaim, it will record mark_mutex as
> > 'fs-reclaim-unsafe' (essentially fs_reclaim->mark_mutex dependency). Once
> > filesystem direct reclaim happens from an allocation under mark_mutex,
> > lockdep will record mark_mutex as 'need-to-be-fs-reclaim-safe'
> > (mark_mutex->fs_reclaim) dependency. Hence a loop. Now I agree that
> > SINGLE_DEPTH_NESTING (which is BTW used in several other places for unclear
> > reasons - we should clean that up) might defeat this lockdep detection but
> > in that case it would also defeat detection of real potential deadlocks
> > (because the deadlock scenario you've found is real). Proper lockdep
> 
> Definitely. My test now reproduces the deadlock very reliably within seconds
> lockdep is unaware of the deadlock because of the SINGLE_DEPTH_NESTING
> subclass missguided annotation.
> 
> > annotation needs to distinguish mark_locks which can be acquired from under
> > fs reclaim and mark_locks which cannot be.
> >
> 
> I see. So technically we can annotate the fanotify group mark_mutex with
> a different key and then we have 4 subclasses of lock:
> - fanotify mark_mutex are NOT reclaim safe
> - non-fanotify mark_mutex are reclaim safe
> - ANY mark_mutex(SINGLE_DEPTH_NESTING) are fs-reclaim unsafe
> 
> The reason I am a bit uneasy with regressing inotify is that there are users
> of large recursive inotify watch crawlers out there (e.g. watchman) and when
> crawling a large tree to add marks, there may be a need to reclaim
> some memory by evicting inode cache (of non-marked subtrees).

Well, but reclaim from kswapd is always the main and preferred source of
memory reclaim. And we will kick kswapd to do work if we are running out of
memory. Doing direct filesystem slab reclaim from mark allocation is useful
only to throttle possibly aggressive mark allocations to the speed of
reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
big issue but I certainly won't stop you from implementing more fine
grained GFP mode selection and lockdep annotations if you want to go that
way :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
