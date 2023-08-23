Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9B785AE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbjHWOhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 10:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjHWOhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:37:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E371719
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 07:37:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FE2B21F13;
        Wed, 23 Aug 2023 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692801429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4DrqhhlHrVT4jw+BftEwDqmqT4Iy+15pFNiSxIVZrQ=;
        b=b42RhoREl15qyn/TmXWyGw4/Lw1AlVU8oIDCV7rirY15llUO2ydzbQtQzRPhFzVBVVzlGr
        +E6gQZIcEjEfvJ1s9IjJlFrNqIAoQcVPgj+jQMB8dC/+ouhIm7rQ3XVcKZ2I9TwbjulOZD
        QCxWWdN/xVsMj64ildARJvJhjVGBYSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692801429;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4DrqhhlHrVT4jw+BftEwDqmqT4Iy+15pFNiSxIVZrQ=;
        b=y461aZ0rVlUQwSdShjsuFYeOVAROysSKt+dfQBOTLnPWm890APDXhOk5Bu8rB1SepnfZf8
        yMRDf3t0Vbk7KZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 275621351F;
        Wed, 23 Aug 2023 14:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YgOSCZUZ5mSbEgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Aug 2023 14:37:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AF5B2A0774; Wed, 23 Aug 2023 16:37:08 +0200 (CEST)
Date:   Wed, 23 Aug 2023 16:37:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify HSM open issues
Message-ID: <20230823143708.nry64nytwbeijtsq@quack3>
References: <20230629171157.54l44agwejgnquw3@quack3>
 <CAOQ4uxgxFtBZy4V8vccV2F7Lbg_9=OFNhgdgCP6Hu=o7gjcsVQ@mail.gmail.com>
 <20230703183029.nn5adeyphijv5wl6@quack3>
 <CAOQ4uxiS6R9hGFmputP6uRHGKywaCca0Ug53ihGcrgxkvMHomg@mail.gmail.com>
 <CAOQ4uxhk_rydFejNqsmn4AydZfuknp=vPunNODNcZ_8qW-AykQ@mail.gmail.com>
 <20230816094702.zztx3dctxvnfeh6o@quack3>
 <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3>
 <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-08-23 10:01:40, Amir Goldstein wrote:
> [adding fsdevel]
> 
> On Thu, Aug 17, 2023 at 9:22 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 17-08-23 10:13:20, Amir Goldstein wrote:
> > > [CC Christian and Jens for the NOWAIT semantics]
> > >
> > > Jan,
> > >
> > > I was going to post start-write-safe patches [1], but now that this
> > > design issue has emerged, with your permission, I would like to
> > > take this discussion to fsdevel, so please reply to the list.
> > >
> > > For those who just joined, the context is fanotify HSM API [2]
> > > proposal and avoiding the fanotify deadlocks I described in my
> > > talk on LSFMM [3].
> >
> > OK, sure. I'm resending the reply which I sent only to you here.
> >
> > > On Wed, Aug 16, 2023 at 8:18 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Aug 16, 2023 at 12:47 PM Jan Kara <jack@suse.cz> wrote:
> > > > > On Mon 14-08-23 16:57:48, Amir Goldstein wrote:
> > > > > > On Mon, Jul 3, 2023 at 11:03 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > On Mon, Jul 3, 2023, 9:30 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > do_sendfile() or ovl_copy_up() from ovl1 to xfs1, end up calling
> > > > > > do_splice_direct() with sb_writers(xfs1) held.
> > > > > > Internally, the splice operation calls into ovl_splice_read(), which
> > > > > > has to call the rw_verify_area() check with the fsnotify hook on the
> > > > > > underlying xfs file.
> > > > >
> > > > > Right, we can call rw_verify_area() only after overlayfs has told us what
> > > > > is actually the underlying file that is really used for reading. Hum,
> > > > > nasty.
> > > > >
> > > > > > This is a violation of start-write-safe permission hooks and the
> > > > > > lockdep_assert that I added in fsnotify_permission() catches this
> > > > > > violation.
> > > > > >
> > > > > > I believe that a similar issue exists with do_splice_direct() from
> > > > > > an fs that is loop mounted over an image file on xfs1 to xfs1.
> > > > >
> > > > > I don't see how that would be possible. If you have a loop image file on
> > > > > filesystem xfs1, then the filesystem stored in the image is some xfs2.
> > > > > Overlayfs case is special here because it doesn't really work with
> > > > > filesystems but rather directory subtrees and that causes the
> > > > > complications.
> > > > >
> > > >
> > > > I was referring to sendfile() from xfs2 to xfs1.
> > > > sb_writers of xfs1 is held, but loop needs to read from the image file
> > > > in xfs1. No?
> >
> > Yes, that seems possible and it would indeed trigger rw_verify_area() in
> > do_iter_read() on xfs1 while freeze protection for xfs1 is held.
> >
> 
> Recap for new people joining this thread.
> 
> The following deadlock is possible in upstream kernel
> if fanotify permission event handler tries to make
> modifications to the filesystem it is watching in the context
> of FAN_ACCESS_PERM handling in some cases:
> 
> P1                             P2                      P3
> -----------                    ------------            ------------
> do_sendfile(fs1.out_fd, fs1.in_fd)
> -> sb_start_write(fs1.sb)
>   -> do_splice_direct()                         freeze_super(fs1.sb)
>     -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ......
>       -> security_file_permission()
>         -> fsnotify_perm() --> FAN_ACCESS_PERM
>                                  -> do_unlinkat(fs1.dfd, ...)
>                                    -> sb_start_write(fs1.sb) ......
> 
> start-write-safe patches [1] (not posted) are trying to solve this
> deadlock and prepare the ground for a new set of permission events
> with cleaner/safer semantics.
> 
> The cases described above of sendfile from a file in loop mounted
> image over fs1 or overlayfs over fs1 into a file in fs1 can still deadlock
> despite the start-write-safe patches [1].

Yep, nice summary.

> > > > > > My earlier patches had annotated the rw_verify_area() calls
> > > > > > in splice iterators as "MAY_NOT_START_WRITE" and the
> > > > > > userspace event listener was notified via flag whether modifying
> > > > > > the content of the file was allowed or not.
> > > > > >
> > > > > > I do not care so much about HSM being able to fill content of files
> > > > > > from a nested context like this, but we do need some way for
> > > > > > userspace to at least deny this access to a file with no content.
> > > > > >
> > > > > > Another possibility I thought of is to change file_start_write()
> > > > > > do use file_start_write_trylock() for files with FMODE_NONOTIFY.
> > > > > > This should make it safe to fill file content when event is generated
> > > > > > with sb_writers held (if freeze is in progress modification will fail).
> > > > > > Right?
> > > > >
> > > > > OK, so you mean that the HSM managing application will get an fd with
> > > > > FMODE_NONOTIFY set from an event and use it for filling in the file
> > > > > contents and the kernel functions grabbing freeze protection will detect
> > > > > the file flag and bail with error instead of waiting? That sounds like an
> > > > > attractive solution - the HSM managing app could even reply with error like
> > > > > ERESTARTSYS to fanotify event and make the syscall restart (which will
> > > > > block until the fs is unfrozen and then we can try again) and thus handle
> > > > > the whole problem transparently for the application generating the event.
> > > > > But I'm just dreaming now, for start it would be fine to just fail the
> > > > > syscall.
> > > > >
> > > >
> > > > IMO, a temporary error from an HSM controlled fs is not a big deal.
> > > > Same as a temporary error from a network fs or FUSE - should be
> > > > tolerable when the endpoint is not connected.
> > > > One of my patches allows HSM returning an error that is not EPERM as
> > > > response - this can be useful in such situations.
> >
> > OK.
> >
> > > > > I see only three possible problems with the solution. Firstly, the HSM
> > > > > application will have to be careful to only access the managed filesystem
> > > > > with the fd returned from fanotify event as otherwise it could deadlock on
> > > > > frozen filesystem.
> > > >
> > > > Isn't that already the case to some extent?
> > > > It is not wise for permission event handlers to perform operations
> > > > on fd without  FMODE_NONOTIFY.
> >
> > Yes, it isn't a new problem. The amount of bug reports in our bugzilla
> > boiling down to this kind of self-deadlock just shows that fanotify users
> > get this wrong all the time.
> >
> > > > > That may seem obvious but practice shows that with
> > > > > complex software stacks with many dependencies, this is far from trivial.
> > > >
> > > > It will be especially important when we have permission events
> > > > on directory operations that need to perform operations on O_PATH
> > > > dirfd with FMODE_NONOTIFY.
> > > >
> > > > > Secondly, conditioning the trylock behavior on FMODE_NONOTIFY seems
> > > > > somewhat arbitary unless you understand our implementation issues and
> > > > > possibly it could regress current unsuspecting users. So I'm thinking
> > > > > whether we shouldn't rather have an explicit open flag requiring erroring
> > > > > out on frozen filesystem instead of blocking and the HSM application will
> > > > > need to use it to evade freezing deadlocks. Or we can just depend on
> > > > > RWF_NOWAIT flag (we currently block on frozen filesystem despite this flag
> > > > > but that can be viewed as a bug) but that's limited to writes (i.e., no way
> > > > > to e.g. do fallocate(2) without blocking on frozen fs).
> > > >
> > > > User cannot ask for fd with FMODE_NONOTIFY as it is - this is provided
> > > > as a means to an end by fanotify - so it would not be much different if
> > > > the new events would provide an fd with FMODE_NONOTIFY |
> > > > FMODE_NOWAIT. It will be up to documentation to say what is and what
> > > > is not allowed with the event->fd provided by fanotify.
> > > >
> > >
> > > This part needs clarifying.
> > > Technically, we can use the flag FMODE_NOWAIT to prevent waiting in
> > > file_start_write() *when* it is combined with FMODE_NONOTIFY.
> > >
> > > Yes, it would be a change of behavior, but I think it would be a good change,
> > > because current event->fd from FAN_ACCESS_PERM events is really not
> > > write-safe (could deadlock with freezing fs).
> >
> > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> > this fd. It says nothing about freeze handling or so. Furthermore as you
> > observe FMODE_NONOTIFY cannot be set by userspace but practically all
> > current fanotify users need to also do IO on other files in order to handle
> > fanotify event. So ideally we'd have a way to do IO to other files in a
> > manner safe wrt freezing. We could just update handling of RWF_NOWAIT flag
> > to only trylock freeze protection - that actually makes a lot of sense to
> > me. The question is whether this is enough or not.
> >
> 
> Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> to a file is not the only thing that HSM needs to do.
> Eventually, event handler for lookup permission events should be
> able to also create files without blocking on vfs level freeze protection.

So this is what I wanted to clarify. The lookup permission event never gets
called under a freeze protection so the deadlock doesn't exist there. In
principle the problem exists only for access and modify events where we'd
be filling in file data and thus RWF_NOWAIT could be enough. That being
said I understand this may be assuming too much about the implementations
of HSM daemons and as you write, we might want to provide a way to do IO
not blocking on freeze protection from any hook. But I wanted to point this
out explicitely so that it's a conscious decision.

> In theory, I am not saying we should do it, but as a thought experiment:
> if the requirement from permission event handler is that is must use a
> O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> any filesystem modifications, then instead of aiming for NOWAIT
> semantics using sb_start_write_trylock(), we could use a freeze level
> SB_FREEZE_FSNOTIFY between
> SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> 
> As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> make it clear how userspace should avoid nesting "VFS faults" there is
> a model that can solve the deadlock correctly.

OK, yes, in principle another freeze level which could be used by handlers
of fanotify permission events would solve the deadlock as well. Just you
seem to like to tie this functionality to the particular fd returned from
fanotify and I'm not convinced that is a good idea. What if the application
needs to do write to some other location besides the one fd it got passed
from fanotify event? E.g. imagine it wants to fetch a whole subtree on
first access to any file in a subtree. Or maybe it wants to write to some
DB file containing current state or something like that.

One solution I can imagine is to create an open flag that can be specified
on open which would result in the special behavior wrt fs freezing. If the
special behavior would be just trylocking the freeze protection then it
would be really easy. If the behaviour would be another freeze protection
level, then we'd need to make sure we don't generate another fanotify
permission event with such fd - autorejecting any such access is an obvious
solution but I'm not sure if practical for applications.

> > > Then we have two options:
> > > 1. Generate "write-safe" FAN_PRE_ACCESS events only for fs that set
> > >     FMODE_NOWAIT.
> > >     Other fs will still generate the legacy FAN_ACCESS_PERM events
> > >     which will be documented as write-unsafe
> > > 2. Use a new internal flag (e.g. FMODE_NOSBWAIT) for the stronger
> > >     NOWAIT semantics that fanotify will always set on event->fd for the
> > >     new write-safe FAN_PRE_ACCESS events
> > >
> > > TBH, the backing fs for HSM [2] is anyway supposed to be a "normal"
> > > local fs and I'd be more comfortable with fs opting in to support fanotify
> > > HSM events, so option #1 doesn't seem like a terrible idea??
> >
> > Yes, I don't think 1) would be really be a limitation that would matter too
> > much in practice.
> >
> > > > Currently, the documentation is missing, because there are operations
> > > > that are not really safe in the permission event context, but there is no
> > > > documentation about that.
> > > >
> > > > > Thirdly, unless we
> > > > > propagate to the HSM app the information whether the freeze protection is
> > > > > held in the kernel or not, it doesn't know whether it should just wait for
> > > > > the filesystem to unfreeze or whether it should rather fail the request to
> > > > > avoid the deadlock. Hrm...
> > > >
> > > > informing HSM if freeze protection is held by this thread may be a little
> > > > challenging, but it is easy for me to annotate possible risky contexts
> > > > like the hooks inside splice read.
> > > > I am just not sure that waiting in HSM context is that important and
> > > > if it is not better to always fail in the frozen fs case.
> >
> > Always failing in frozen fs case is certainly possible but that will make
> > fs freezing a bit non-transparent - the application may treat such failures
> > as fatal errors and abort. So it's ok for the first POC but eventually we
> > should have a plan how we could make fs freezing transparent for the
> > applications even for HSM managed filesystems.
> >
> 
> OK. ATM, the only solution I can think of that is both maintainable
> and lets HSM live in complete harmony with fsfreeze is adding the
> extra SB_FREEZE_FSNOTIFY level.

To make things clear: if the only problems would be with those sendfile(2)
rare corner-cases, then I guess we can live with that and implement retry
in the kernel if userspace ever complains about unexpected short copy or
EAGAIN...  The problem I see is that if we advise that all IO from the
fanotify event handler should happen in the freeze-safe manner, then with
the non-blocking solution all HSM IO suddently starts failing as soon as
the filesystem is frozen. And that is IMHO not nice.

> I am not sure how big of an overhead that would be?
> I imagine that sb_writers is large enough as it is w.r.t fitting into
> cache lines?
> I don't think that it adds much complexity or maintenance burden
> to vfs?? I'm really not sure.
 
Well, the overhead is effectively one percpu counter per superblock.
Negligible in terms of CPU time, somewhat annoying in terms of memory but
bearable. So this may be a way forward.

> > > > I wonder if we go down this path, if we need any of the start-write-safe
> > > > patches at all? maybe only some of them to avoid duplicate hooks?
> >
> > Yes, avoiding duplicate hooks would be nice in any case.
> 
> OK. I already posted some patches from the series to vfs [4] and ovl [5].
> 
> The rest of the series can be justified also for avoiding duplicate
> permission hook and also to greatly reduce the risk of the aforementioned
> deadlock, despite the remaining loop/ovl corner cases.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/start-write-safe
> [2] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API
> [3] https://youtu.be/z3A7mzfceKM
> [4] https://lore.kernel.org/linux-fsdevel/20230817141337.1025891-1-amir73il@gmail.com/
> [5] https://lore.kernel.org/linux-unionfs/20230816152334.924960-1-amir73il@gmail.com/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
