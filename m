Return-Path: <linux-fsdevel+bounces-3993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 591527FA9F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70013B2128A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 19:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7633E489;
	Mon, 27 Nov 2023 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="FnBFdYyE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4970BD5D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:11:55 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5cc86fcea4fso36652607b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701112314; x=1701717114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oiUt89ZRW/Kms6/0v1Pd6nwwlyqMaiMv9zNU4UpwKA4=;
        b=FnBFdYyE2BclJCBAbtre+1PLIVPFKjhuhdwPRvv7LwQn8T1G0A1jev90MZJoJyAVfl
         DXrxY8E0+oTsevp91G1V/XQrCWx/tXD1vnlSZGLy+ddeBnpa52ntTYLPD4yoMFl2Olcw
         idO22/aWDzbI+vwOcJzpJapHtB9SVqoFQo8MBK1aNh0UT78vo0eiVg5kk3pOJDGjO2hT
         J34dawNs9ScRGa9C/0UDJO02d7tf+Rx0XSTibGwC91h4Pgx8Eg8Yb8VKkVc0FiwzWbbv
         7c/Ibr9OoMwNldZwom1rXwVoSBBAM65QxlDiYBo1oKWb/q0+Df3S3aMgTpM8GrQh2L7A
         S/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701112314; x=1701717114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiUt89ZRW/Kms6/0v1Pd6nwwlyqMaiMv9zNU4UpwKA4=;
        b=AEo0OyY8XDq1Q8JvGOduMWpTL9BN4uyZVeBA9kEckbzoGIWyUD5fVK1aH5IruNgaPa
         eyAHbZpneEr2RRm83G6Sviqoq5aHKt8qYoJ7XfmRVPozqCRes90ehXXJsMEcxxqbZUzu
         JV+EDW3IMNiEK2KTBPL34VKh/YFR19GABIepsZEccnLu0gvwxiHgfw4vBVoDcKHANzmE
         hkf02tVhd2qyVwcT24pGJDjVHm7br6zOrwxH9dojIcz7fO125afelpy85sSnCxPTrvr5
         4+AhdMRp2tHyJ6AB8+wdIMqYXfXlArcWZcGBVrqQttay7qTWR6/9oQWNP3o3+gy5D8MJ
         O1Jw==
X-Gm-Message-State: AOJu0Ywtj9dRcg6qQyF9WpW3rr/CBJsTM1VARrFDLS6zxZsqVU+B0Ptx
	4edNSz0+GgsM3aUjKTmgRyqg/Q==
X-Google-Smtp-Source: AGHT+IG2woASPCjtOlDQ7qq8CZz68qKqXdAkA+u1pOzOsywriJKyc18Ni1aZOITwqlCP4+D7f+ZSHQ==
X-Received: by 2002:a0d:d40f:0:b0:5cb:accf:ff1d with SMTP id w15-20020a0dd40f000000b005cbaccfff1dmr11076472ywd.25.1701112314323;
        Mon, 27 Nov 2023 11:11:54 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v19-20020a814813000000b005cb331f463esm3485725ywa.8.2023.11.27.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:11:53 -0800 (PST)
Date: Mon, 27 Nov 2023 14:11:53 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify HSM open issues
Message-ID: <20231127191153.GH2366036@perftesting>
References: <20230816094702.zztx3dctxvnfeh6o@quack3>
 <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3>
 <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3>
 <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
 <20231120140605.6yx3jryuylgcphhr@quack3>
 <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>

On Mon, Nov 20, 2023 at 06:59:47PM +0200, Amir Goldstein wrote:
> On Mon, Nov 20, 2023 at 4:06 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir,
> >
> > sorry for a bit delayed reply, I did not get to "swapping in" HSM
> > discussion during the Plumbers conference :)
> >
> > On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > > On Wed, Aug 23, 2023 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Aug 23, 2023 at 5:37 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > Recap for new people joining this thread.
> > > > > >
> > > > > > The following deadlock is possible in upstream kernel
> > > > > > if fanotify permission event handler tries to make
> > > > > > modifications to the filesystem it is watching in the context
> > > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > > >
> > > > > > P1                             P2                      P3
> > > > > > -----------                    ------------            ------------
> > > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > > -> sb_start_write(fs1.sb)
> > > > > >   -> do_splice_direct()                         freeze_super(fs1.sb)
> > > > > >     -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ......
> > > > > >       -> security_file_permission()
> > > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > > > >                                    -> sb_start_write(fs1.sb) ......
> > > > > >
> > > > > > start-write-safe patches [1] (not posted) are trying to solve this
> > > > > > deadlock and prepare the ground for a new set of permission events
> > > > > > with cleaner/safer semantics.
> > > > > >
> > > > > > The cases described above of sendfile from a file in loop mounted
> > > > > > image over fs1 or overlayfs over fs1 into a file in fs1 can still
> > > > > > deadlock despite the start-write-safe patches [1].
> > > > >
> > > > > Yep, nice summary.
> > ...
> > > > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> > > > > > > this fd. It says nothing about freeze handling or so. Furthermore as you
> > > > > > > observe FMODE_NONOTIFY cannot be set by userspace but practically all
> > > > > > > current fanotify users need to also do IO on other files in order to handle
> > > > > > > fanotify event. So ideally we'd have a way to do IO to other files in a
> > > > > > > manner safe wrt freezing. We could just update handling of RWF_NOWAIT flag
> > > > > > > to only trylock freeze protection - that actually makes a lot of sense to
> > > > > > > me. The question is whether this is enough or not.
> > > > > > >
> > > > > >
> > > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > > > > to a file is not the only thing that HSM needs to do.
> > > > > > Eventually, event handler for lookup permission events should be
> > > > > > able to also create files without blocking on vfs level freeze protection.
> > > > >
> > > > > So this is what I wanted to clarify. The lookup permission event never gets
> > > > > called under a freeze protection so the deadlock doesn't exist there. In
> > > > > principle the problem exists only for access and modify events where we'd
> > > > > be filling in file data and thus RWF_NOWAIT could be enough.
> > > >
> > > > Yes, you are right.
> > > > It is possible that RWF_NOWAIT could be enough.
> > > >
> > > > But the discovery of the loop/ovl corner cases has shaken my
> > > > confidence is the ability to guarantee that freeze protection is not
> > > > held somehow indirectly.
> > > >
> > > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > > same ovl corner case, because with splice from ovl1 to fs1,
> > > > fs1 freeze protection is held and:
> > > >   ovl_splice_read(ovl1.file)
> > > >     ovl_real_fdget()
> > > >       ovl_open_realfile(fs1.file)
> > > >          ... security_file_open(fs1.file)
> > > >
> > > > > That being
> > > > > said I understand this may be assuming too much about the implementations
> > > > > of HSM daemons and as you write, we might want to provide a way to do IO
> > > > > not blocking on freeze protection from any hook. But I wanted to point this
> > > > > out explicitly so that it's a conscious decision.
> > > > >
> > >
> > > I agree and I'd like to explain using an example, why RWF_NOWAIT is
> > > not enough for HSM needs.
> > >
> > > The reason is that often, when HSM needs to handle filling content
> > > in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
> > > HSM needs to be able to avoid blocking on freeze protection
> > > for any operations on the filesystem, not just pwrite().
> > >
> > > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > > from the lookup event and uses it in the handling of access events to
> > > update the metadata files that store which parts of the file were already
> > > filled (relying of fiemap is not always a valid option).
> > >
> > > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > > is propagated from dirfd to an fd opened with openat(dirfd, ...), so
> > > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> > >
> > > Another use case is that HSM may want to download content to a
> > > temp file on the same filesystem, verify the downloaded content and
> > > then clone the data into the accessed file range.
> > >
> > > I think that a PF_ flag (see below) would work best for all those cases.
> >
> > Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not be
> > enough for all sensible usecases to avoid deadlocks with freezing. However
> > note that if we want to really properly handle all possible operations, we
> > need to start handling error from all sb_start_write() and
> > file_start_write() calls and there are quite a few of those.
> >
> 
> Darn, forgot about those.
> I am starting to reconsider adding a freeze level.
> I cannot shake the feeling that there is a simpler solution that escapes us...
> Maybe fs anti-freeze (see blow).
> 
> > > > > > In theory, I am not saying we should do it, but as a thought experiment:
> > > > > > if the requirement from permission event handler is that is must use a
> > > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > > > > any filesystem modifications, then instead of aiming for NOWAIT
> > > > > > semantics using sb_start_write_trylock(), we could use a freeze level
> > > > > > SB_FREEZE_FSNOTIFY between
> > > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > > >
> > > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> > > > > > make it clear how userspace should avoid nesting "VFS faults" there is
> > > > > > a model that can solve the deadlock correctly.
> > > > >
> > > > > OK, yes, in principle another freeze level which could be used by handlers
> > > > > of fanotify permission events would solve the deadlock as well. Just you
> > > > > seem to like to tie this functionality to the particular fd returned from
> > > > > fanotify and I'm not convinced that is a good idea. What if the application
> > > > > needs to do write to some other location besides the one fd it got passed
> > > > > from fanotify event? E.g. imagine it wants to fetch a whole subtree on
> > > > > first access to any file in a subtree. Or maybe it wants to write to some
> > > > > DB file containing current state or something like that.
> > > > >
> > > > > One solution I can imagine is to create an open flag that can be specified
> > > > > on open which would result in the special behavior wrt fs freezing. If the
> > > > > special behavior would be just trylocking the freeze protection then it
> > > > > would be really easy. If the behaviour would be another freeze protection
> > > > > level, then we'd need to make sure we don't generate another fanotify
> > > > > permission event with such fd - autorejecting any such access is an obvious
> > > > > solution but I'm not sure if practical for applications.
> > > > >
> > > >
> > > > I had also considered marking the listener process with the FSNOTIFY
> > > > context and enforcing this context on fanotify_read().
> > > > In a way, this is similar to the NOIO and NOFS process context.
> > > > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > > > and to activate the desired freeze protection behavior
> > > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > > >
> > >
> > > My feeling is that the best approach would be a PF_NOWAIT task flag:
> > >
> > > - PF_NOWAIT will prevent blocking on freeze protection
> > > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > > - PF_NOWAIT could be auto-set on the reader of a permission event
> > > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > > - We could add user API to set this personality explicitly to any task
> > > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> > >
> > > Please let me know if you agree with this design and if so,
> > > which of the methods to set PF_NOWAIT are a must for the first version
> > > in your opinion?
> >
> > Yeah, the PF flag could work. It can be set for the process(es) responsible
> > for processing the fanotify events and filling in filesystem contents. I
> > don't think automatic setting of this flag is desirable though as it has
> > quite wide impact and some of the consequences could be surprising.  I
> > rather think it should be a conscious decision when setting up the process
> > processing the events. So I think API to explicitly set / clear the flag
> > would be the best. Also I think it would be better to capture in the name
> > that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
> > something like that?
> >
> 
> Sure.
> 
> > Also we were thinking about having an open(2) flag for this (instead of PF
> > flag) in the past. That would allow finer granularity control of the
> > behavior but I guess you are worried that it would not cover all the needed
> > operations?
> >
> 
> Yeh, it seems like an API that is going to be harder to write safe HSM
> programs with.
> 
> > > Do you think we should use this method to fix the existing deadlocks
> > > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
> >
> > No, I think if someone cares about these, they should explicitly set the
> > PF flag in their task processing the events.
> >
> 
> OK.
> 
> I see an exit hatch in this statement -
> If we are going leave the responsibility to avoid deadlock in corner
> cases completely in the hands of the application, then I do not feel
> morally obligated to create the PF_NOWAIT_FREEZE API *before*
> providing the first HSM API.
> 
> If the HSM application is running in a controlled system, on a filesystem
> where fsfreeze is not expected or not needed, then a fully functional and
> safe HSM does not require PF_NOWAIT_FREEZE API.
> 
> Perhaps an API to make an fs unfreezable is just as practical and a much
> easier option for the first version of HSM API?
> 
> Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
> ioctl. Then no other task can freeze the fs, for as long as the fd is open
> apart from the HSM itself using this fd.
> 
> HSM itself can avoid deadlocks if it collaborates the fs freezes with
> making fs modifications from within HSM events.
> 
> Do you think that may be an acceptable way out or the corner?

This is kind of a corner case that I think is acceptable to just leave up to
application developers.  Speaking as a potential consumer of this work we don't
use fsfreeze so aren't concerned wit this in practice, and arguably if you're
using this interface you know what you're doing.  As long as the sharp edge is
well documented I think that's fine for v1.

Long term I like the EXCLUSIVE_FSFREEZER option, noting Christian's comment
about the xfs scrubbing use case.  We all know that "freeze this file system" is
an operation that is going to take X amount of time, so as long as we provide
the application a way to block fsfreeze to avoid the deadlock then I think
that's a reasonable solution.  Additionally it would allow us an avenue to
gracefully handle errors.  If we race and see that the fs is already frozen well
then we can go back to the HSM with an error saying he's out of luck, and he can
return -EAGAIN or something through fanotify to unwind and try again later.

But this is a pretty narrow corner case, you've done the due diligence to avoid
the other deadlocks, I don't feel that coming up with a solution to this is a
necessary pre-requisite to the actual feature.  Documenting it clearly is the
only thing I would ask.  Thanks,

Josef

