Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9D4E7003
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356470AbiCYJav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiCYJau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:30:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638B7CF4BA
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 02:29:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 074E6210DD;
        Fri, 25 Mar 2022 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648200555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1v1XIVByLQ34phodUlsoo1UGythbajf2AygU4JMpU8Q=;
        b=Sklm7/D56iGlC3XMsgPJyP2d2O9N9vDUC2PbSZrK6qdK76HLzaksWp4l+6DM0BtT1ry5OA
        vXPVpQQEZ1yxgQr9dA5ppZMc/eiHLpdd1d9mbhvnargW+E+TqA7HavnxHa3PWXOtgzdTLG
        phd3ap9sP7d5Beau6Me024fWBwRKtxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648200555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1v1XIVByLQ34phodUlsoo1UGythbajf2AygU4JMpU8Q=;
        b=OPZfoFocy0vcoPOSn/AIyId4zzrcpNq9VQA0zPtlQR51tJ/hIxE3BEiFdS4yEzr2xxlkZM
        hwpZO01LFwJVKrCw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E800FA3B82;
        Fri, 25 Mar 2022 09:29:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 922AEA0610; Fri, 25 Mar 2022 10:29:11 +0100 (CET)
Date:   Fri, 25 Mar 2022 10:29:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, "khazhy@google.com" <khazhy@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] nfsd: avoid recursive locking through fsnotify
Message-ID: <20220325092911.fnttlyrvw7qzggc7@quack3.lan>
References: <CAOQ4uxiLXqmAC=769ufLA2dKKfHxm=c_8B0N2y4c-aZ5Qci2hg@mail.gmail.com>
 <20220321145111.qz3bngofoi5r5cmh@quack3.lan>
 <CAOQ4uxgOpfezQ4ydjP4SPA8-7x9xSXjTmTyZOYQE3d24c2Zf7Q@mail.gmail.com>
 <20220323104129.k4djfxtjwdgoz3ci@quack3.lan>
 <CAOQ4uxgH3aCKnXfUFuyC7JXGtuprzWr6U9Y2T1rTQT3COoZtzw@mail.gmail.com>
 <20220323134851.px6s4i6iiaj4zlju@quack3.lan>
 <CAOQ4uxhBH_0UqEmOdcUaV0E8oGTGF7arr+Q_EZPuQ=KWfvJWoQ@mail.gmail.com>
 <20220323142835.epitipiq7zc55vgb@quack3.lan>
 <CAOQ4uxjEj4FWsd87cuYHR+vKb0ogb=zqrKHJLapqaPovUhgfFQ@mail.gmail.com>
 <CAOQ4uxgkV8ULePEuxgMp2zSsYR_N0UPdGZcCJzB49Ndeyo2paw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgkV8ULePEuxgMp2zSsYR_N0UPdGZcCJzB49Ndeyo2paw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-03-22 21:17:09, Amir Goldstein wrote:
> On Wed, Mar 23, 2022 at 5:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Mar 23, 2022 at 4:28 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 23-03-22 16:00:30, Amir Goldstein wrote:
> > > > > Well, but reclaim from kswapd is always the main and preferred source of
> > > > > memory reclaim. And we will kick kswapd to do work if we are running out of
> > > > > memory. Doing direct filesystem slab reclaim from mark allocation is useful
> > > > > only to throttle possibly aggressive mark allocations to the speed of
> > > > > reclaim (instead of getting ENOMEM). So I'm still not convinced this is a
> > > > > big issue but I certainly won't stop you from implementing more fine
> > > > > grained GFP mode selection and lockdep annotations if you want to go that
> > > > > way :).
> > > >
> > > > Well it was just two lines of code to annotate the fanotify mutex as its own
> > > > class, so I just did that:
> > > >
> > > > https://github.com/amir73il/linux/commit/7b4b6e2c0bd1942cd130e9202c4b187a8fb468c6
> > >
> > > But this implicitely assumes there isn't any allocation under mark_mutex
> > > anywhere else where it is held. Which is likely true (I didn't check) but
> > > it is kind of fragile. So I was rather imagining we would have per-group
> > > "NOFS" flag and fsnotify_group_lock/unlock() would call
> > > memalloc_nofs_save() based on the flag. And we would use
> > > fsnotify_group_lock/unlock() uniformly across the whole fsnotify codebase.
> > >
> >
> > I see what you mean, but looking at the code it seems quite a bit of churn to go
> > over all the old backends and convert the locks to use wrappers where we "know"
> > those backends are fs reclaim safe (because we did not get reports of deadlocks
> > over the decades they existed).
> >
> > I think I will sleep better with a conversion to three flavors:
> >
> > 1. pflags = fsnotify_group_nofs_lock(fanotify_group);
> > 2. fsnotify_group_lock(dnotify_group) =>
> >     WARN_ON_ONCE(group->flags & FSNOTIFY_NOFS)
> >     mutex_lock(&group->mark_mutex)
> > 3. fsnotify_group_lock_nested(group) =>
> >     mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING)
> >
> 
> I think I might have misunderstood you and you meant that the
> SINGLE_DEPTH_NESTING subcalls should be eliminated and then
> we are left with two lock classes.
> Correct?

Yeah, at least at this point I don't see a good reason for using
SINGLE_DEPTH_NESTING lockdep annotation. In my opinion it has just a
potential of silencing reports of real locking problems. So removing it and
seeing what complains would be IMO a way to go.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
