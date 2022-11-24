Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBA7637D7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 17:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKXQLu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 11:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXQLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:11:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83B150449;
        Thu, 24 Nov 2022 08:11:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C738621BC;
        Thu, 24 Nov 2022 16:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8ED7C433C1;
        Thu, 24 Nov 2022 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669306307;
        bh=7lJ6Zi4ZHIuW40/2q3og7pNXwqn3nZ7x1JvkcGNv1Us=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=D9Q+rD1vcg5gil7BcfkwxnZbNHCgLVcm7RvX82hLzHZRAMt9SaZCJlZnPqs1bLcGh
         Tq+jYS1g3aD3ArY6wt0U7j2LP1ew2Nk8NqGLMmqgUDBwyNsYSRgUVb0PK7ZviCWdba
         E7EHz0La8XHAwXs6wJzTTE6KhNZJsVdKcoF3GpMRkAbQkRgC4BIF8ZXZXWj/qYPiGK
         G7+85NPOTWz4jx7VUwvxtHEAr2ceeJQe+XWJTPFXnpcp32YItEF/FARWx3213Nv2Oj
         lbOFCNLEXFUEn6CJCgtwo5air48wYBD8gbyZEO7T57OdSlAWIfNXN9Oy4c4F3C3R/W
         +xyG/OOw2JAMg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7DE6A5C094A; Thu, 24 Nov 2022 08:11:47 -0800 (PST)
Date:   Thu, 24 Nov 2022 08:11:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124161147.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
 <20221124095840.zdcwnge4hbxqcz5d@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124095840.zdcwnge4hbxqcz5d@quack3>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:58:40AM +0100, Jan Kara wrote:
> On Thu 24-11-22 08:21:13, Amir Goldstein wrote:
> > [+fsdevel]
> > 
> > On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > > Hello!
> > > >
> > > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > > as a building block we would need a mechanism to make sure write(2) has
> > > > completed. For simplicity we could imagine it like a sequence
> > > >
> > > > write(2)
> > > >   START
> > > >   do stuff to perform write
> > > >   END
> > > >
> > > > and we need a mechanism to wait for all processes that already passed START
> > > > to reach END. Ideally without blocking new writes while we wait for the
> > > > pending ones. Now this seems like a good task for SRCU. We could do:
> > > >
> > > > write(2)
> > > >   srcu_read_lock(&sb->s_write_rcu);
> > > >   do stuff to perform write
> > > >   srcu_read_unlock(&sb->s_write_rcu);
> > > >
> > > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > > >
> > > > But the trouble with writes is there are things like aio or io_uring where
> > > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > > the part with srcu_read_unlock() happens from another context (usually worker
> > > > thread triggered by IRQ reporting that the HW has finished the IO).
> > > >
> > > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > > me in principle it should be possible to make this work but maybe there are
> > > > some implementation constraints I'm missing...
> > >
> > > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > > will work for this, though that is not their intended purpose.  Plus you
> > > might want to trace these functions, which, as their names indicate, is
> > > not permitted.  I assume that you do not intend to use these functions
> > > from NMI handlers, though that really could be accommodated.  (But why
> > > would you need that?)
> > >
> > > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > > (untested) patch below?
> > >
> > > Note that you do still need to pass the return value from srcu_down_read()
> > > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > > that this value can be placed.  No idea about aio.
> > >
> > 
> > Sure, aio completion has context.
> > 
> > > Thoughts?
> > 
> > That looks great! Thank you.
> > 
> > Followup question:
> > Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
> > thing:
> > 
> > /*
> >  * Open-code file_start_write here to grab freeze protection,
> >  * which will be released by another thread in
> >  * aio_complete_rw().  Fool lockdep by telling it the lock got
> >  * released so that it doesn't complain about the held lock when
> >  * we return to userspace.
> >  */
> > if (S_ISREG(file_inode(file)->i_mode)) {
> >     sb_start_write(file_inode(file)->i_sb);
> >     __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > }
> > 
> > And in write completion:
> > 
> > /*
> >  * Tell lockdep we inherited freeze protection from submission
> >  * thread.
> >  */
> > if (S_ISREG(inode->i_mode))
> >     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> > file_end_write(kiocb->ki_filp);
> > 
> > I suppose we also need to "fool lockdep" w.r.t returning to userspace
> > with an acquired srcu?
> 
> So AFAICT the whole point of Paul's new helpers is to not use lockdep and
> thus not have to play the "fool lockdep" games.

Exactly!  ;-)

But if you do return to userspace after invoking srcu_down_read(), it
is your responsibility to make sure that -something- eventually invokes
srcu_up_read().  Which might or might not be able to rely on userspace
doing something sensible.

I would guess that you have a timeout or rely on close() for that purpose,
just as you presumably do for sb_start_write(), but figured I should
mention it.

							Thanx, Paul
