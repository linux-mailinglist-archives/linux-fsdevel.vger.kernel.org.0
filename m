Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA76375BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiKXJ6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 04:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKXJ6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:58:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81CB13FA4;
        Thu, 24 Nov 2022 01:58:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A067021AB4;
        Thu, 24 Nov 2022 09:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669283920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=if/Jal5dwKoW5tQi1rAcUw9/mK/s4E/k1q/HIMl3p0U=;
        b=ZrRiIvOAHOyBjT4tF+6VBUaqqX4dd19V2idOx7NskpPkPS9AL5weKgeBvf6HjnZAvSonSg
        tzbVN9OJc/JUEVk5zrTW9XMTzquwyWc+Rwub89o+O/Ke6tQwa2RYu8EyKs/x3cPDVc8vJ8
        cstb3PNqDXg1nBK2A5G/DukJD6/wk/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669283920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=if/Jal5dwKoW5tQi1rAcUw9/mK/s4E/k1q/HIMl3p0U=;
        b=4Md9VdPo+mI6U9iiOHHVItOjR1KYnfKZFHwBdTD606k08qPy/B2lNlzS2ecFTLu+SD5w88
        PZZvCy8SQJ0gDMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9275813488;
        Thu, 24 Nov 2022 09:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jv64I1BAf2OMMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 24 Nov 2022 09:58:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0FD1DA070B; Thu, 24 Nov 2022 10:58:40 +0100 (CET)
Date:   Thu, 24 Nov 2022 10:58:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     paulmck@kernel.org, Jan Kara <jack@suse.cz>, rcu@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: SRCU use from different contexts
Message-ID: <20221124095840.zdcwnge4hbxqcz5d@quack3>
References: <20221123114645.3aowv3hw4hxqr2ed@quack3>
 <20221124002128.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxge4cF_o80bbXPE2ZAjRwy9zNA6U1oXsdyYsiF-wVRvpA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 24-11-22 08:21:13, Amir Goldstein wrote:
> [+fsdevel]
> 
> On Thu, Nov 24, 2022 at 2:21 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Nov 23, 2022 at 12:46:45PM +0100, Jan Kara wrote:
> > > Hello!
> > >
> > > We were pondering with Amir about some issues with fsnotify subsystem and
> > > as a building block we would need a mechanism to make sure write(2) has
> > > completed. For simplicity we could imagine it like a sequence
> > >
> > > write(2)
> > >   START
> > >   do stuff to perform write
> > >   END
> > >
> > > and we need a mechanism to wait for all processes that already passed START
> > > to reach END. Ideally without blocking new writes while we wait for the
> > > pending ones. Now this seems like a good task for SRCU. We could do:
> > >
> > > write(2)
> > >   srcu_read_lock(&sb->s_write_rcu);
> > >   do stuff to perform write
> > >   srcu_read_unlock(&sb->s_write_rcu);
> > >
> > > and use synchronize_srcu(&sb->s_write_rcu) for waiting.
> > >
> > > But the trouble with writes is there are things like aio or io_uring where
> > > the part with srcu_read_lock() happens from one task (the submitter) while
> > > the part with srcu_read_unlock() happens from another context (usually worker
> > > thread triggered by IRQ reporting that the HW has finished the IO).
> > >
> > > Is there any chance to make SRCU work in a situation like this? It seems to
> > > me in principle it should be possible to make this work but maybe there are
> > > some implementation constraints I'm missing...
> >
> > The srcu_read_lock_notrace() and srcu_read_unlock_notrace() functions
> > will work for this, though that is not their intended purpose.  Plus you
> > might want to trace these functions, which, as their names indicate, is
> > not permitted.  I assume that you do not intend to use these functions
> > from NMI handlers, though that really could be accommodated.  (But why
> > would you need that?)
> >
> > So how about srcu_down_read() and srcu_up_read(), as shown in the
> > (untested) patch below?
> >
> > Note that you do still need to pass the return value from srcu_down_read()
> > into srcu_up_read().  I am guessing that io_uring has a convenient place
> > that this value can be placed.  No idea about aio.
> >
> 
> Sure, aio completion has context.
> 
> > Thoughts?
> 
> That looks great! Thank you.
> 
> Followup question:
> Both fs/aio.c:aio_write() and io_uring/rw.c:io_write() do this ugly
> thing:
> 
> /*
>  * Open-code file_start_write here to grab freeze protection,
>  * which will be released by another thread in
>  * aio_complete_rw().  Fool lockdep by telling it the lock got
>  * released so that it doesn't complain about the held lock when
>  * we return to userspace.
>  */
> if (S_ISREG(file_inode(file)->i_mode)) {
>     sb_start_write(file_inode(file)->i_sb);
>     __sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
> }
> 
> And in write completion:
> 
> /*
>  * Tell lockdep we inherited freeze protection from submission
>  * thread.
>  */
> if (S_ISREG(inode->i_mode))
>     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
> file_end_write(kiocb->ki_filp);
> 
> I suppose we also need to "fool lockdep" w.r.t returning to userspace
> with an acquired srcu?

So AFAICT the whole point of Paul's new helpers is to not use lockdep and
thus not have to play the "fool lockdep" games.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
