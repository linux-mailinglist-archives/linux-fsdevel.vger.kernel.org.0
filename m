Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388763B66C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiK2ANE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 19:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiK2AM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:12:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E302DD7;
        Mon, 28 Nov 2022 16:12:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D76661512;
        Tue, 29 Nov 2022 00:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22E5C433C1;
        Tue, 29 Nov 2022 00:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669680774;
        bh=FjN5V5IHuRq3L7i0ZyJcoPqFG6uIYmaYihyqL7Linvc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GjS3cTpOTPEZzt0LC7D0IbEoscl17AJCHJAgV2OFe9JXwh11oiWBPJNsCUapMCC9S
         ueVTsGhhFIyJ1LOhLDPLn7uhr1Jc6dsd7FSy+ohyyr4VCuu0nOMMXp+5a+GCvX//pw
         /JVYYeRcUIA8NLJUgCnQh0wezWrMVq1b3/+Vs23+OsgbHWO2L4vL/Lvi07qCfIUTe2
         4fG1g0UrO2svpa8mSWRsRsiMo6MGUUrT2ff1XIBPNO3oF6Ecv/islMBX8ablJRn19Y
         H2X/CqiawIdZguN8SnMLTbc3q8gg1fIrRdNPlvWOR3FBXJvBQu/zZ6JvMJhAp2Ed6+
         /NasBuTTHceZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 956725C0EBE; Mon, 28 Nov 2022 16:12:53 -0800 (PST)
Date:   Mon, 28 Nov 2022 16:12:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU use from different contexts
Message-ID: <20221129001253.GO4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
 <20221124095840.zdcwnge4hbxqcz5d@quack3>
 <20221124161147.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221124174626.lueg3f65ikhp2f3l@quack3>
 <CAOQ4uxhL4Rmk1ria2_AEc0rJXPAaHLeuWQj9RKZqSv9TU_paTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhL4Rmk1ria2_AEc0rJXPAaHLeuWQj9RKZqSv9TU_paTw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 25, 2022 at 02:45:53PM +0200, Amir Goldstein wrote:
> On Thu, Nov 24, 2022 at 7:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 24-11-22 08:11:47, Paul E. McKenney wrote:
> > > On Thu, Nov 24, 2022 at 10:58:40AM +0100, Jan Kara wrote:
> > > > On Thu 24-11-22 08:21:13, Amir Goldstein wrote:
> > > > > [+fsdevel]
> > > > >
> > > > > On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > > > > > Hello!
> > > > > > >
> > > > > > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > > > > > as a building block we would need a mechanism to make sure write(2) has
> > > > > > > completed. For simplicity we could imagine it like a sequence
> > > > > > >
> > > > > > > write(2)
> > > > > > >   START
> > > > > > >   do stuff to perform write
> > > > > > >   END
> > > > > > >
> > > > > > > and we need a mechanism to wait for all processes that already passed START
> > > > > > > to reach END. Ideally without blocking new writes while we wait for the
> > > > > > > pending ones. Now this seems like a good task for SRCU. We could do:
> > > > > > >
> > > > > > > write(2)
> > > > > > >   srcu_read_lock(&sb->s_write_rcu);
> > > > > > >   do stuff to perform write
> > > > > > >   srcu_read_unlock(&sb->s_write_rcu);
> > > > > > >
> > > > > > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > > > > > >
> > > > > > > But the trouble with writes is there are things like aio or io_uring where
> > > > > > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > > > > > the part with srcu_read_unlock() happens from another context (usually worker
> > > > > > > thread triggered by IRQ reporting that the HW has finished the IO).
> > > > > > >
> > > > > > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > > > > > me in principle it should be possible to make this work but maybe there are
> > > > > > > some implementation constraints I'm missing...
> > > > > >
> > > > > > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > > > > > will work for this, though that is not their intended purpose.  Plus you
> > > > > > might want to trace these functions, which, as their names indicate, is
> > > > > > not permitted.  I assume that you do not intend to use these functions
> > > > > > from NMI handlers, though that really could be accommodated.  (But why
> > > > > > would you need that?)
> > > > > >
> > > > > > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > > > > > (untested) patch below?
> > > > > >
> > > > > > Note that you do still need to pass the return value from srcu_down_read()
> > > > > > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > > > > > that this value can be placed.  No idea about aio.
> > > > > >
> > > > >
> > > > > Sure, aio completion has context.
> > > > >
> > > > > > Thoughts?
> > > > >
> > > > > That looks great! Thank you.
> > > > >
> > > > > Followup question:
> > > > > Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
> > > > > thing:
> > > > >
> > > > > /*
> > > > >  * Open-code file_start_write here to grab freeze protection,
> > > > >  * which will be released by another thread in
> > > > >  * aio_complete_rw().  Fool lockdep by telling it the lock got
> > > > >  * released so that it doesn't complain about the held lock when
> > > > >  * we return to userspace.
> > > > >  */
> > > > > if (S_ISREG(file_inode(file)->i_mode)) {
> > > > >     sb_start_write(file_inode(file)->i_sb);
> > > > >     __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > > > > }
> > > > >
> > > > > And in write completion:
> > > > >
> > > > > /*
> > > > >  * Tell lockdep we inherited freeze protection from submission
> > > > >  * thread.
> > > > >  */
> > > > > if (S_ISREG(inode->i_mode))
> > > > >     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> > > > > file_end_write(kiocb->ki_filp);
> > > > >
> > > > > I suppose we also need to "fool lockdep" w.r.t returning to userspace
> > > > > with an acquired srcu?
> > > >
> > > > So AFAICT the whole point of Paul's new helpers is to not use lockdep and
> > > > thus not have to play the "fool lockdep" games.
> > >
> > > Exactly!  ;-)
> > >
> > > But if you do return to userspace after invoking srcu_down_read(), it
> > > is your responsibility to make sure that -something- eventually invokes
> > > srcu_up_read().  Which might or might not be able to rely on userspace
> > > doing something sensible.
> > >
> > > I would guess that you have a timeout or rely on close() for that purpose,
> > > just as you presumably do for sb_start_write(), but figured I should
> > > mention it.
> >
> > Yes. We actually do not rely on userspace but rather on HW to eventually
> > signal IO completion. For misbehaving HW there are timeouts but the details
> > depend very much on the protocol etc.. But as you say it is the same
> > business as with sb_start_write() so nothing new here.
> >
> 
> FYI, here is my POC branch that uses srcu_down,up_read()
> for aio writes:
> 
> https://github.com/amir73il/linux/commits/sb_write_barrier
> 
> Note that NOT all writes take s_write_srcu, but all writes that
> generate fsnotify pre-modify events without sb_start_write() held
> MUST take s_write_srcu, so there is an assertion in fsnotify():
> 
> if (mask & FS_PRE_VFS) {
>     /* Avoid false positives with LOCK_STATE_UNKNOWN */
>     lockdep_assert_once(sb_write_started(sb) != LOCK_STATE_HELD);
>     if (mask & FSNOTIFY_PRE_MODIFY_EVENTS)
>         lockdep_assert_once(sb_write_srcu_started(sb));
> }
> 
> For testing, I've added synchronize_srcu(&sb->s_write_srcu) at
> the beginning of syncfs() and freeze_super().
> 
> Even though syncfs() is not the intended UAPI, it is a UAPI that could
> make sense in the future (think SYNC_FILE_RANGE_WAIT_BEFORE
> for the vfs level).
> 
> I've run the fstests groups aio and freeze that exercises these code
> paths on xfs and on overlayfs and (after fixing all my bugs) I have not
> observed any regressions nor any lockdep splats.
> 
> So you may add:
> Tested-by: Amir Goldstein <amir73il@gmail.com>

Very good, and thank you!  I will apply this on my next rebase.

> Thanks again for the patch Paul!

I will be cherry-picking this on top of -rcu's srcunmisafe.2022.11.09a
branch and sending you a public branch.  I do -not- expect to push this
into the upcoming merge window unless you tell me that you need it.
Preferably sooner rather than later.  ;-)

							Thanx, Paul
