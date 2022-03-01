Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2994C8A4D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 12:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiCALIi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCALIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:08:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465F145506
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 03:07:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D63821F37E;
        Tue,  1 Mar 2022 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646132872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1bMr05sGKAIwCghPvlS7trxwr6WBYFi6/VuydVfhbs=;
        b=dMQdzHVXK7wf52E2SxzMEROHKtrLIE8Tsf75p4U09vsSLjY+n+Xvd76NPRH6ZH219vjo8S
        YWSXuZNLRPMDm7n+orYTAHd4oEIauMSZul5LjR8y6lchqNQVfIjJhnpHvZi9jnT70NFotX
        NrGE/ULw25kDgTMcgVj/6yV5bCZVDE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646132872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S1bMr05sGKAIwCghPvlS7trxwr6WBYFi6/VuydVfhbs=;
        b=4oW6Dg82ZtutcR/j5oy+3mRJbOVR243NNBZsVhvgtRphIe55BZSu2Mfgzj24ro3rHRbhtb
        ZZWWvAZfPyzkPiCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B811EA3B83;
        Tue,  1 Mar 2022 11:07:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7382DA0608; Tue,  1 Mar 2022 12:07:52 +0100 (CET)
Date:   Tue, 1 Mar 2022 12:07:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tycho Kirchner <tychokirchner@mail.de>
Subject: Re: [RFC] Volatile fanotify marks
Message-ID: <20220301110752.ouonih76tnbwjjfd@quack3.lan>
References: <CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com>
 <20220228140556.ae5rhgqsyzm5djbp@quack3.lan>
 <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiMp4HjSj01FZm8-jPzHD4jVugxuXBDW2JnSpVizhCeTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-02-22 19:40:07, Amir Goldstein wrote:
> On Mon, Feb 28, 2022 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Wed 23-02-22 20:42:37, Amir Goldstein wrote:
> > > I wanted to get your feedback on an idea I have been playing with.
> > > It started as a poor man's alternative to the old subtree watch problem.
> > > For my employer's use case, we are watching the entire filesystem using
> > > a filesystem mark, but would like to exclude events on a subtree
> > > (i.e. all files underneath .private/).
> > >
> > > At the moment, those events are filtered in userspace.
> > > I had considered adding directory marks with an ignored mask on every
> > > event that is received for a directory path under .private/, but that has the
> > > undesired side effect of pinning those directory inodes to cache.
> > >
> > > I have this old fsnotify-volatile branch [1] that I am using for an overlayfs
> > > kernel internal fsnotify backend. I wonder what are your thoughts on
> > > exposing this functionally to fanotify UAPI (i.e. FAN_MARK_VOLATILE).
> >
> > Interesting idea. I have some reservations wrt to the implementation (e.g.
> > fsnotify_add_mark_list() convention of returning EEXIST when it updated
> > mark's mask, or the fact that inode reclaim should now handle freeing of
> > mark connector and attached marks - which may get interesting locking wise)
> > but they are all fixable.
> 
> Can you give me a hint as to how to implement the freeing of marks?

OK, now I can see that fsnotify_inode_delete() gets called from
__destroy_inode() and thus all marks should be freed even for inodes
released by inode reclaim. Good.

> > I'm wondering a bit whether this is really useful enough (and consequently
> > whether we will not get another request to extend fanotify API in some
> > other way to cater better to some other usecase related to subtree watches
> > in the near future). I understand ignore marks are mainly a performance
> > optimization and as such allowing inodes to be reclaimed (which means they
> > are not used much and hence ignored mark is not very useful anyway) makes
> 
> The problem is that we do not know in advance which of the many dirs in
> the subtree are accessed often and which are accessed rarely (and that may
> change over time), so volatile ignore marks are a way to set up ignore marks
> on the most accessed dirs dynamically.

Yes, I understand.

> > sense. Thinking about this more, I guess it is useful to improve efficiency
> > when you want to implement any userspace event-filtering scheme.
> >
> > The only remaining pending question I have is whether we should not go
> > further and allow event filtering to happen using an eBPF program. That
> > would be even more efficient (both in terms of memory and CPU). What do you
> > think?
> >
> 
> I think that is an unrelated question.
> 
> I do agree that we should NOT add "subtree filter" functionality to fanotify
> (or any other filter) and that instead, we should add support for attaching an
> eBPF program that implements is_subdir().
> I found this [1] convection with Tycho where you had suggested this idea.
> I wonder if Tycho got to explore this path further?
> 
> But I think that it is one thing to recommend users to implement their
> filters as
> eBPF programs and another thing to stand in the way of users that prefer to
> implement userspace event filtering. It could be that the filter
> cannot be easily
> described by static rules to an eBPF program (e.g. need to query a database).
> 
> In my POV, FAN_MARK_VOLATILE does not add any new logic/filtering rule.
> It adds resource control by stating that the ignore mark is "best effort".
> 
> Does it make sense?

OK, makes sense. So I agree the functionality is worth it. Will you post
the patches for review of technical details?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
