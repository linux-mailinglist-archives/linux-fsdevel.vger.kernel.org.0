Return-Path: <linux-fsdevel+bounces-4044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17DC7FBDD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788992838F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B55CD33;
	Tue, 28 Nov 2023 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqEmZRN0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C54F8B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0CAC433C8;
	Tue, 28 Nov 2023 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701184398;
	bh=PodrA+Cl22L8W6bfo1He1dm+rQocazm0HIX0f5eVxHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqEmZRN0SnTz4IuEVez1P5jNoYi7xwLrIQatuXlsqmnvmDNJ+87IIeZmjN7qmrAbT
	 dyA1ryObBrJOT8/CK+D+v0SK27ywzNyAOLUGsd6XZp5LSpTHcQGflH7IgWZMD1JVZk
	 CgLDuuGHGYUBqbCQImD2V0bZrLD1YO+qhfM5+74fveOazxl5A2wP9CvNOvfTeoIIm3
	 gDx81wLlkHwjtC64n8Vr+rs/cbk7w0PsZeNU/cOU17USe8gk6HZ6aoOBR/Ny8epPDk
	 wZpqBc52tE99dHw4b0S+HnYuUK8IcmkTdqKNiZPS1iKxHPqT1uqi8HXZ7LjC2uBc3G
	 /vU+sRA7JwZ3g==
Date: Tue, 28 Nov 2023 16:13:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>, Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify HSM open issues
Message-ID: <20231128-deich-umgeschaltet-4fe1bd92531c@brauner>
References: <20230817182220.vzzklvr7ejqlfnju@quack3>
 <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3>
 <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3>
 <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
 <20231127191153.GH2366036@perftesting>
 <CAOQ4uxjLZZavhkKaWFa8T7+bCR+N2VRVsv4VusXvN5UMJjBiRA@mail.gmail.com>
 <20231128145547.GA2382537@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128145547.GA2382537@perftesting>

On Tue, Nov 28, 2023 at 09:55:47AM -0500, Josef Bacik wrote:
> On Tue, Nov 28, 2023 at 01:05:50PM +0200, Amir Goldstein wrote:
> > On Mon, Nov 27, 2023 at 9:11 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> > > > On Mon, Nov 20, 2023 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > Hi Amir,
> > > > >
> > > > > sorry for a bit delayed reply, I did not get to "swapping in" HSM
> > > > > discussion during the Plumbers conference :)
> > > > >
> > > > > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > > > > On Wed, Aug 23, 2023 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > On Wed, Aug 23, 2023 at 5:37 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > > Recap for new people joining this thread.
> > > > > > > > >
> > > > > > > > > The following deadlock is possible in upstream kernel
> > > > > > > > > if fanotify permission event handler tries to make
> > > > > > > > > modifications to the filesystem it is watching in the context
> > > > > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > > > > >
> > > > > > > > > P1                             P2                      P3
> > > > > > > > > -----------                    ------------            ------------
> > > > > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > > > > -> sb_start_write(fs1.sb)
> > > > > > > > >   -> do_splice_direct()                         freeze_super(fs1.sb)
> > > > > > > > >     -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ......
> > > > > > > > >       -> security_file_permission()
> > > > > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > > > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > > > > > > >                                    -> sb_start_write(fs1.sb) ......
> > > > > > > > >
> > > > > > > > > start-write-safe patches [1] (not posted) are trying to solve this
> > > > > > > > > deadlock and prepare the ground for a new set of permission events
> > > > > > > > > with cleaner/safer semantics.
> > > > > > > > >
> > > > > > > > > The cases described above of sendfile from a file in loop mounted
> > > > > > > > > image over fs1 or overlayfs over fs1 into a file in fs1 can still
> > > > > > > > > deadlock despite the start-write-safe patches [1].
> > > > > > > >
> > > > > > > > Yep, nice summary.
> > > > > ...
> > > > > > > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > > > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> > > > > > > > > > this fd. It says nothing about freeze handling or so. Furthermore as you
> > > > > > > > > > observe FMODE_NONOTIFY cannot be set by userspace but practically all
> > > > > > > > > > current fanotify users need to also do IO on other files in order to handle
> > > > > > > > > > fanotify event. So ideally we'd have a way to do IO to other files in a
> > > > > > > > > > manner safe wrt freezing. We could just update handling of RWF_NOWAIT flag
> > > > > > > > > > to only trylock freeze protection - that actually makes a lot of sense to
> > > > > > > > > > me. The question is whether this is enough or not.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > > > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > > > > Eventually, event handler for lookup permission events should be
> > > > > > > > > able to also create files without blocking on vfs level freeze protection.
> > > > > > > >
> > > > > > > > So this is what I wanted to clarify. The lookup permission event never gets
> > > > > > > > called under a freeze protection so the deadlock doesn't exist there. In
> > > > > > > > principle the problem exists only for access and modify events where we'd
> > > > > > > > be filling in file data and thus RWF_NOWAIT could be enough.
> > > > > > >
> > > > > > > Yes, you are right.
> > > > > > > It is possible that RWF_NOWAIT could be enough.
> > > > > > >
> > > > > > > But the discovery of the loop/ovl corner cases has shaken my
> > > > > > > confidence is the ability to guarantee that freeze protection is not
> > > > > > > held somehow indirectly.
> > > > > > >
> > > > > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > > > > > same ovl corner case, because with splice from ovl1 to fs1,
> > > > > > > fs1 freeze protection is held and:
> > > > > > >   ovl_splice_read(ovl1.file)
> > > > > > >     ovl_real_fdget()
> > > > > > >       ovl_open_realfile(fs1.file)
> > > > > > >          ... security_file_open(fs1.file)
> > > > > > >
> > > > > > > > That being
> > > > > > > > said I understand this may be assuming too much about the implementations
> > > > > > > > of HSM daemons and as you write, we might want to provide a way to do IO
> > > > > > > > not blocking on freeze protection from any hook. But I wanted to point this
> > > > > > > > out explicitly so that it's a conscious decision.
> > > > > > > >
> > > > > >
> > > > > > I agree and I'd like to explain using an example, why RWF_NOWAIT is
> > > > > > not enough for HSM needs.
> > > > > >
> > > > > > The reason is that often, when HSM needs to handle filling content
> > > > > > in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
> > > > > > HSM needs to be able to avoid blocking on freeze protection
> > > > > > for any operations on the filesystem, not just pwrite().
> > > > > >
> > > > > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > > > > from the lookup event and uses it in the handling of access events to
> > > > > > update the metadata files that store which parts of the file were already
> > > > > > filled (relying of fiemap is not always a valid option).
> > > > > >
> > > > > > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > > > > > is propagated from dirfd to an fd opened with openat(dirfd, ...), so
> > > > > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> > > > > >
> > > > > > Another use case is that HSM may want to download content to a
> > > > > > temp file on the same filesystem, verify the downloaded content and
> > > > > > then clone the data into the accessed file range.
> > > > > >
> > > > > > I think that a PF_ flag (see below) would work best for all those cases.
> > > > >
> > > > > Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not be
> > > > > enough for all sensible usecases to avoid deadlocks with freezing. However
> > > > > note that if we want to really properly handle all possible operations, we
> > > > > need to start handling error from all sb_start_write() and
> > > > > file_start_write() calls and there are quite a few of those.
> > > > >
> > > >
> > > > Darn, forgot about those.
> > > > I am starting to reconsider adding a freeze level.
> > > > I cannot shake the feeling that there is a simpler solution that escapes us...
> > > > Maybe fs anti-freeze (see blow).
> > > >
> > > > > > > > > In theory, I am not saying we should do it, but as a thought experiment:
> > > > > > > > > if the requirement from permission event handler is that is must use a
> > > > > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > > > > > > > any filesystem modifications, then instead of aiming for NOWAIT
> > > > > > > > > semantics using sb_start_write_trylock(), we could use a freeze level
> > > > > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > > > > >
> > > > > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> > > > > > > > > make it clear how userspace should avoid nesting "VFS faults" there is
> > > > > > > > > a model that can solve the deadlock correctly.
> > > > > > > >
> > > > > > > > OK, yes, in principle another freeze level which could be used by handlers
> > > > > > > > of fanotify permission events would solve the deadlock as well. Just you
> > > > > > > > seem to like to tie this functionality to the particular fd returned from
> > > > > > > > fanotify and I'm not convinced that is a good idea. What if the application
> > > > > > > > needs to do write to some other location besides the one fd it got passed
> > > > > > > > from fanotify event? E.g. imagine it wants to fetch a whole subtree on
> > > > > > > > first access to any file in a subtree. Or maybe it wants to write to some
> > > > > > > > DB file containing current state or something like that.
> > > > > > > >
> > > > > > > > One solution I can imagine is to create an open flag that can be specified
> > > > > > > > on open which would result in the special behavior wrt fs freezing. If the
> > > > > > > > special behavior would be just trylocking the freeze protection then it
> > > > > > > > would be really easy. If the behaviour would be another freeze protection
> > > > > > > > level, then we'd need to make sure we don't generate another fanotify
> > > > > > > > permission event with such fd - autorejecting any such access is an obvious
> > > > > > > > solution but I'm not sure if practical for applications.
> > > > > > > >
> > > > > > >
> > > > > > > I had also considered marking the listener process with the FSNOTIFY
> > > > > > > context and enforcing this context on fanotify_read().
> > > > > > > In a way, this is similar to the NOIO and NOFS process context.
> > > > > > > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > > > > > > and to activate the desired freeze protection behavior
> > > > > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > > > > >
> > > > > >
> > > > > > My feeling is that the best approach would be a PF_NOWAIT task flag:
> > > > > >
> > > > > > - PF_NOWAIT will prevent blocking on freeze protection
> > > > > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > > > > - PF_NOWAIT could be auto-set on the reader of a permission event
> > > > > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > > > > > - We could add user API to set this personality explicitly to any task
> > > > > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > > > > >
> > > > > > Please let me know if you agree with this design and if so,
> > > > > > which of the methods to set PF_NOWAIT are a must for the first version
> > > > > > in your opinion?
> > > > >
> > > > > Yeah, the PF flag could work. It can be set for the process(es) responsible
> > > > > for processing the fanotify events and filling in filesystem contents. I
> > > > > don't think automatic setting of this flag is desirable though as it has
> > > > > quite wide impact and some of the consequences could be surprising.  I
> > > > > rather think it should be a conscious decision when setting up the process
> > > > > processing the events. So I think API to explicitly set / clear the flag
> > > > > would be the best. Also I think it would be better to capture in the name
> > > > > that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
> > > > > something like that?
> > > > >
> > > >
> > > > Sure.
> > > >
> > > > > Also we were thinking about having an open(2) flag for this (instead of PF
> > > > > flag) in the past. That would allow finer granularity control of the
> > > > > behavior but I guess you are worried that it would not cover all the needed
> > > > > operations?
> > > > >
> > > >
> > > > Yeh, it seems like an API that is going to be harder to write safe HSM
> > > > programs with.
> > > >
> > > > > > Do you think we should use this method to fix the existing deadlocks
> > > > > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> > > > >
> > > > > No, I think if someone cares about these, they should explicitly set the
> > > > > PF flag in their task processing the events.
> > > > >
> > > >
> > > > OK.
> > > >
> > > > I see an exit hatch in this statement -
> > > > If we are going leave the responsibility to avoid deadlock in corner
> > > > cases completely in the hands of the application, then I do not feel
> > > > morally obligated to create the PF_NOWAIT_FREEZE API *before*
> > > > providing the first HSM API.
> > > >
> > > > If the HSM application is running in a controlled system, on a filesystem
> > > > where fsfreeze is not expected or not needed, then a fully functional and
> > > > safe HSM does not require PF_NOWAIT_FREEZE API.
> > > >
> > > > Perhaps an API to make an fs unfreezable is just as practical and a much
> > > > easier option for the first version of HSM API?
> > > >
> > > > Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> > > > ioctl. Then no other task can freeze the fs, for as long as the fd is open
> > > > apart from the HSM itself using this fd.
> > > >
> > > > HSM itself can avoid deadlocks if it collaborates the fs freezes with
> > > > making fs modifications from within HSM events.
> > > >
> > > > Do you think that may be an acceptable way out or the corner?
> > >
> > > This is kind of a corner case that I think is acceptable to just leave up to
> > > application developers.  Speaking as a potential consumer of this work we don't
> > > use fsfreeze so aren't concerned wit this in practice, and arguably if you're
> > > using this interface you know what you're doing.  As long as the sharp edge is
> > > well documented I think that's fine for v1.
> > >
> > 
> > I agree that this is good enough for v1.
> > The only question is can we (and should we) do better than good enough for v1.
> > 
> > > Long term I like the EXCLUSIVE_FSFREEZER option, noting Christian's comment
> > > about the xfs scrubbing use case.  We all know that "freeze this file system" is
> > > an operation that is going to take X amount of time, so as long as we provide
> > > the application a way to block fsfreeze to avoid the deadlock then I think
> > > that's a reasonable solution.  Additionally it would allow us an avenue to
> > > gracefully handle errors.  If we race and see that the fs is already frozen well
> > > then we can go back to the HSM with an error saying he's out of luck, and he can
> > > return -EAGAIN or something through fanotify to unwind and try again later.
> > >
> > 
> > Actually, "fs is already frozen" is not a deadlock case.
> > If "fs is already frozen" then fsfreeze was successful and HSM should just
> > wait in line like everyone else until fs is unfrozen.
> > 
> > The deadlock case is "fs is being frozen" (i.e. sb->s_writers.frozen is
> > in state SB_FREEZE_WRITE), which cannot make progress because
> > an existing holder of sb write is blocked on an HSM event, which in turn
> > is trying to start a new sb write.
> 
> Right, and now I'm confused.  You have your patchset to re-order the permission
> checks to before the sb_start_write(), so an HSM watching FAN_OPEN_PERM is no
> longer holding the sb write lock and thus can't deadlock, correct?
> 
> The new things you are proposing (FAN_PRE_ACESS and FAN_PRE_MODIFY) also do not
> happen inside of an sb_start_write(), correct?
> 
> So where is the deadlock you're trying to fix?  The one you describe in this
> thread is what the patchset I reviewed last week was fixing, so in my eyes it
> looks like we're good?  It seems you're worried about the HSM app getting stuck
> on an fsfreeze when it's trying to populate the content, but that's not actually
> deadlocked, it just has to wait for the fs to be unfrozen, the fsfreeze
> operation will be able to complete and then thaw will be able to happen because
> there's no nested sb_write with the new flags, and with your patchset there's no
> sb_write with FAN_OPEN_PERM.
> 
> Sorry I hate it when people come in the middle of a conversation and I have to
> re-explain myself, so feel free to ignore me.  But I've read the whole thread a
> few times and I can't quite figure out what this new deadlock is you're worried
> about.  Thanks,

Actually, I'd appreciate that context as well as I've been looking at
this from the angle of avoiding a deadlock on fsfreeze as well.

