Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB86637E83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 18:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiKXRqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 12:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXRq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:46:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EF1448FD;
        Thu, 24 Nov 2022 09:46:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B16011F8A4;
        Thu, 24 Nov 2022 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669311986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLDbKopsqSYRYJHElXBr/ZPd1GGcveXtKLTgTouIV0M=;
        b=bonQHjoHq9j353u7f0f2hlmq1hXUehrlQZMuxt5c+x8HYEaivPzXKqeBdIoyKHnqLt1aGB
        Rasde4mkAEAE1eqWjpYHm3yr0s0vEBDAA+TKMVhbR2wWPzqDMQhv6ETd/W1cfvAw6rN3Mt
        7IpjoAqSsaRS0YxUytLG/fzTx7J0Fxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669311986;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jLDbKopsqSYRYJHElXBr/ZPd1GGcveXtKLTgTouIV0M=;
        b=aAnzMeEfCWiQiL6WtVBHl49LDGMtZrAJQcsMiHSvmroHuJNfDp/Vd7HwxfLiosZSQ+yPFV
        H9T4SoFvzRG01sCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1C0F13488;
        Thu, 24 Nov 2022 17:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zUF6J/Ktf2MjMAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Nov 2022 17:46:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 27B6AA0715; Thu, 24 Nov 2022 18:46:26 +0100 (CET)
Date:   Thu, 24 Nov 2022 18:46:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124174626.lueg3f65ikhp2f3l@quack3>
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
 <20221124095840.zdcwnge4hbxqcz5d@quack3>
 <20221124161147.GQ4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124161147.GQ4001@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-11-22 08:11:47, Paul E. McKenney wrote:
> On Thu, Nov 24, 2022 at 10:58:40AM +0100, Jan Kara wrote:
> > On Thu 24-11-22 08:21:13, Amir Goldstein wrote:
> > > [+fsdevel]
> > > 
> > > On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > > > Hello!
> > > > >
> > > > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > > > as a building block we would need a mechanism to make sure write(2) has
> > > > > completed. For simplicity we could imagine it like a sequence
> > > > >
> > > > > write(2)
> > > > >   START
> > > > >   do stuff to perform write
> > > > >   END
> > > > >
> > > > > and we need a mechanism to wait for all processes that already passed START
> > > > > to reach END. Ideally without blocking new writes while we wait for the
> > > > > pending ones. Now this seems like a good task for SRCU. We could do:
> > > > >
> > > > > write(2)
> > > > >   srcu_read_lock(&sb->s_write_rcu);
> > > > >   do stuff to perform write
> > > > >   srcu_read_unlock(&sb->s_write_rcu);
> > > > >
> > > > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > > > >
> > > > > But the trouble with writes is there are things like aio or io_uring where
> > > > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > > > the part with srcu_read_unlock() happens from another context (usually worker
> > > > > thread triggered by IRQ reporting that the HW has finished the IO).
> > > > >
> > > > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > > > me in principle it should be possible to make this work but maybe there are
> > > > > some implementation constraints I'm missing...
> > > >
> > > > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > > > will work for this, though that is not their intended purpose.  Plus you
> > > > might want to trace these functions, which, as their names indicate, is
> > > > not permitted.  I assume that you do not intend to use these functions
> > > > from NMI handlers, though that really could be accommodated.  (But why
> > > > would you need that?)
> > > >
> > > > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > > > (untested) patch below?
> > > >
> > > > Note that you do still need to pass the return value from srcu_down_read()
> > > > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > > > that this value can be placed.  No idea about aio.
> > > >
> > > 
> > > Sure, aio completion has context.
> > > 
> > > > Thoughts?
> > > 
> > > That looks great! Thank you.
> > > 
> > > Followup question:
> > > Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
> > > thing:
> > > 
> > > /*
> > >  * Open-code file_start_write here to grab freeze protection,
> > >  * which will be released by another thread in
> > >  * aio_complete_rw().  Fool lockdep by telling it the lock got
> > >  * released so that it doesn't complain about the held lock when
> > >  * we return to userspace.
> > >  */
> > > if (S_ISREG(file_inode(file)->i_mode)) {
> > >     sb_start_write(file_inode(file)->i_sb);
> > >     __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> > > }
> > > 
> > > And in write completion:
> > > 
> > > /*
> > >  * Tell lockdep we inherited freeze protection from submission
> > >  * thread.
> > >  */
> > > if (S_ISREG(inode->i_mode))
> > >     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> > > file_end_write(kiocb->ki_filp);
> > > 
> > > I suppose we also need to "fool lockdep" w.r.t returning to userspace
> > > with an acquired srcu?
> > 
> > So AFAICT the whole point of Paul's new helpers is to not use lockdep and
> > thus not have to play the "fool lockdep" games.
> 
> Exactly!  ;-)
> 
> But if you do return to userspace after invoking srcu_down_read(), it
> is your responsibility to make sure that -something- eventually invokes
> srcu_up_read().  Which might or might not be able to rely on userspace
> doing something sensible.
> 
> I would guess that you have a timeout or rely on close() for that purpose,
> just as you presumably do for sb_start_write(), but figured I should
> mention it.

Yes. We actually do not rely on userspace but rather on HW to eventually
signal IO completion. For misbehaving HW there are timeouts but the details
depend very much on the protocol etc.. But as you say it is the same
business as with sb_start_write() so nothing new here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
