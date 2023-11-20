Return-Path: <linux-fsdevel+bounces-3222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7397F1937
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0EB1C20BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52A1F924;
	Mon, 20 Nov 2023 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ81Kv2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA694BE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:00:00 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-779fb118fe4so302524685a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 09:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700499600; x=1701104400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDBx1Npc5A8S42kkP3HYdkEWJmRvQ4aqx7y6loDqgpM=;
        b=RJ81Kv2k3IA2driLDnjeGvaoEDh0L90E/yjM9U25/x+ZNCeWhn8Rclws1Kxfx1M895
         f6429MsaECbkehMJtgzxYrA2s1K1I5TwEei2Rw8SV10VgdozDMwT0zvzaBygh9OkwHZj
         rh9uRVkU+l6kHAp1a3JlUb1XJIzNYoJabLE6AxC6Gehuon/TG9Q9H0lGrSPY+Wh/y5Tv
         l1S47LPDYbmVVPpbpjv05tPZFN6jJRGQ5UjjqAyV/1fSrdX4HHsPzKE6Na0KLszMIstz
         PRqvRo/JD+NyZteBfiI5ERS9ndu3aP+CE1X7QWzZIwZtJiFHFfx3cUPMW2jLj7Xb5TQE
         nLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499600; x=1701104400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDBx1Npc5A8S42kkP3HYdkEWJmRvQ4aqx7y6loDqgpM=;
        b=FeMF5BOrjn4xyrbu5CYldNBFOjQwxFhM0JntbX1zFrn+aAFKwwgWHH1J7in5CfhkcL
         LME2SxXKJtRiX7AM+PD+UcveoIFkQzL14KHiEGwZJOsi+FtuMoMgHKxGRQiUK+URStXx
         SzmaTXFJtHREkt8jx+mYaoBYR0Aqg2fW84DPAlsySLP8qWRJ0z54Pf4H+rTgETb/aNjy
         e22Uz2YgNh5kP13b1941rwU2n318OY15uajdAIr25Ob8enn3XEXBAUksv3QMbJ0O1J7M
         j7rXeN9UZlRDo818RxTS/dscViIA9t+QtCM5bJxUkNl0x/Hf53a2DZlfM+4HCvLj1xWa
         BrTQ==
X-Gm-Message-State: AOJu0YxOd0l99rOXKc1xaA98w6UT/OvitItdTXTWbPx3VjigHn+21dAN
	d63OAJ56Ixde54uAVbsQHcnwO0zQI+YFIBhVssq3aYwO5OM=
X-Google-Smtp-Source: AGHT+IFfez/ruQOPMBy+KW2YuKkMSeSTbYuOMDNkQ/wNPhgOvFXMrmR2uIPdru2RWrIcD3vXsodngjZrRJfOtkpcoLU=
X-Received: by 2002:ad4:5f4a:0:b0:679:e743:6ebc with SMTP id
 p10-20020ad45f4a000000b00679e7436ebcmr1162232qvg.4.1700499599656; Mon, 20 Nov
 2023 08:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxiS6R9hGFmputP6uRHGKywaCca0Ug53ihGcrgxkvMHomg@mail.gmail.com>
 <CAOQ4uxhk_rydFejNqsmn4AydZfuknp=vPunNODNcZ_8qW-AykQ@mail.gmail.com>
 <20230816094702.zztx3dctxvnfeh6o@quack3> <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3> <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3> <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com> <20231120140605.6yx3jryuylgcphhr@quack3>
In-Reply-To: <20231120140605.6yx3jryuylgcphhr@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Nov 2023 18:59:47 +0200
Message-ID: <CAOQ4uxg_U5v9TuEeagb6ybPobG-jJkP+sFcf+-yYoWr07wswSQ@mail.gmail.com>
Subject: Re: fanotify HSM open issues
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 4:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir,
>
> sorry for a bit delayed reply, I did not get to "swapping in" HSM
> discussion during the Plumbers conference :)
>
> On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> > On Wed, Aug 23, 2023 at 7:31=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > > On Wed, Aug 23, 2023 at 5:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote=
:
> > > > > Recap for new people joining this thread.
> > > > >
> > > > > The following deadlock is possible in upstream kernel
> > > > > if fanotify permission event handler tries to make
> > > > > modifications to the filesystem it is watching in the context
> > > > > of FAN_ACCESS_PERM handling in some cases:
> > > > >
> > > > > P1                             P2                      P3
> > > > > -----------                    ------------            ----------=
--
> > > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > > -> sb_start_write(fs1.sb)
> > > > >   -> do_splice_direct()                         freeze_super(fs1.=
sb)
> > > > >     -> rw_verify_area()                         -> sb_wait_write(=
fs1.sb) ......
> > > > >       -> security_file_permission()
> > > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > > >                                    -> sb_start_write(fs1.sb) ....=
..
> > > > >
> > > > > start-write-safe patches [1] (not posted) are trying to solve thi=
s
> > > > > deadlock and prepare the ground for a new set of permission event=
s
> > > > > with cleaner/safer semantics.
> > > > >
> > > > > The cases described above of sendfile from a file in loop mounted
> > > > > image over fs1 or overlayfs over fs1 into a file in fs1 can still
> > > > > deadlock despite the start-write-safe patches [1].
> > > >
> > > > Yep, nice summary.
> ...
> > > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events =
when using
> > > > > > this fd. It says nothing about freeze handling or so. Furthermo=
re as you
> > > > > > observe FMODE_NONOTIFY cannot be set by userspace but practical=
ly all
> > > > > > current fanotify users need to also do IO on other files in ord=
er to handle
> > > > > > fanotify event. So ideally we'd have a way to do IO to other fi=
les in a
> > > > > > manner safe wrt freezing. We could just update handling of RWF_=
NOWAIT flag
> > > > > > to only trylock freeze protection - that actually makes a lot o=
f sense to
> > > > > > me. The question is whether this is enough or not.
> > > > > >
> > > > >
> > > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > > > to a file is not the only thing that HSM needs to do.
> > > > > Eventually, event handler for lookup permission events should be
> > > > > able to also create files without blocking on vfs level freeze pr=
otection.
> > > >
> > > > So this is what I wanted to clarify. The lookup permission event ne=
ver gets
> > > > called under a freeze protection so the deadlock doesn't exist ther=
e. In
> > > > principle the problem exists only for access and modify events wher=
e we'd
> > > > be filling in file data and thus RWF_NOWAIT could be enough.
> > >
> > > Yes, you are right.
> > > It is possible that RWF_NOWAIT could be enough.
> > >
> > > But the discovery of the loop/ovl corner cases has shaken my
> > > confidence is the ability to guarantee that freeze protection is not
> > > held somehow indirectly.
> > >
> > > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > > same ovl corner case, because with splice from ovl1 to fs1,
> > > fs1 freeze protection is held and:
> > >   ovl_splice_read(ovl1.file)
> > >     ovl_real_fdget()
> > >       ovl_open_realfile(fs1.file)
> > >          ... security_file_open(fs1.file)
> > >
> > > > That being
> > > > said I understand this may be assuming too much about the implement=
ations
> > > > of HSM daemons and as you write, we might want to provide a way to =
do IO
> > > > not blocking on freeze protection from any hook. But I wanted to po=
int this
> > > > out explicitly so that it's a conscious decision.
> > > >
> >
> > I agree and I'd like to explain using an example, why RWF_NOWAIT is
> > not enough for HSM needs.
> >
> > The reason is that often, when HSM needs to handle filling content
> > in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
> > HSM needs to be able to avoid blocking on freeze protection
> > for any operations on the filesystem, not just pwrite().
> >
> > For example, the POC HSM code [1], stores the DATA_DIR_fd
> > from the lookup event and uses it in the handling of access events to
> > update the metadata files that store which parts of the file were alrea=
dy
> > filled (relying of fiemap is not always a valid option).
> >
> > That is the reason that in the POC patches [2], FMODE_NONOTIFY
> > is propagated from dirfd to an fd opened with openat(dirfd, ...), so
> > HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> >
> > Another use case is that HSM may want to download content to a
> > temp file on the same filesystem, verify the downloaded content and
> > then clone the data into the accessed file range.
> >
> > I think that a PF_ flag (see below) would work best for all those cases=
.
>
> Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not be
> enough for all sensible usecases to avoid deadlocks with freezing. Howeve=
r
> note that if we want to really properly handle all possible operations, w=
e
> need to start handling error from all sb_start_write() and
> file_start_write() calls and there are quite a few of those.
>

Darn, forgot about those.
I am starting to reconsider adding a freeze level.
I cannot shake the feeling that there is a simpler solution that escapes us=
...
Maybe fs anti-freeze (see blow).

> > > > > In theory, I am not saying we should do it, but as a thought expe=
riment:
> > > > > if the requirement from permission event handler is that is must =
use a
> > > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > > > any filesystem modifications, then instead of aiming for NOWAIT
> > > > > semantics using sb_start_write_trylock(), we could use a freeze l=
evel
> > > > > SB_FREEZE_FSNOTIFY between
> > > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > > >
> > > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as =
we
> > > > > make it clear how userspace should avoid nesting "VFS faults" the=
re is
> > > > > a model that can solve the deadlock correctly.
> > > >
> > > > OK, yes, in principle another freeze level which could be used by h=
andlers
> > > > of fanotify permission events would solve the deadlock as well. Jus=
t you
> > > > seem to like to tie this functionality to the particular fd returne=
d from
> > > > fanotify and I'm not convinced that is a good idea. What if the app=
lication
> > > > needs to do write to some other location besides the one fd it got =
passed
> > > > from fanotify event? E.g. imagine it wants to fetch a whole subtree=
 on
> > > > first access to any file in a subtree. Or maybe it wants to write t=
o some
> > > > DB file containing current state or something like that.
> > > >
> > > > One solution I can imagine is to create an open flag that can be sp=
ecified
> > > > on open which would result in the special behavior wrt fs freezing.=
 If the
> > > > special behavior would be just trylocking the freeze protection the=
n it
> > > > would be really easy. If the behaviour would be another freeze prot=
ection
> > > > level, then we'd need to make sure we don't generate another fanoti=
fy
> > > > permission event with such fd - autorejecting any such access is an=
 obvious
> > > > solution but I'm not sure if practical for applications.
> > > >
> > >
> > > I had also considered marking the listener process with the FSNOTIFY
> > > context and enforcing this context on fanotify_read().
> > > In a way, this is similar to the NOIO and NOFS process context.
> > > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > > and to activate the desired freeze protection behavior
> > > (whether trylock or SB_FREEZE_FSNOTIFY level).
> > >
> >
> > My feeling is that the best approach would be a PF_NOWAIT task flag:
> >
> > - PF_NOWAIT will prevent blocking on freeze protection
> > - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> > - PF_NOWAIT could be auto-set on the reader of a permission event
> > - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> > - We could add user API to set this personality explicitly to any task
> > - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> >
> > Please let me know if you agree with this design and if so,
> > which of the methods to set PF_NOWAIT are a must for the first version
> > in your opinion?
>
> Yeah, the PF flag could work. It can be set for the process(es) responsib=
le
> for processing the fanotify events and filling in filesystem contents. I
> don't think automatic setting of this flag is desirable though as it has
> quite wide impact and some of the consequences could be surprising.  I
> rather think it should be a conscious decision when setting up the proces=
s
> processing the events. So I think API to explicitly set / clear the flag
> would be the best. Also I think it would be better to capture in the name
> that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
> something like that?
>

Sure.

> Also we were thinking about having an open(2) flag for this (instead of P=
F
> flag) in the past. That would allow finer granularity control of the
> behavior but I guess you are worried that it would not cover all the need=
ed
> operations?
>

Yeh, it seems like an API that is going to be harder to write safe HSM
programs with.

> > Do you think we should use this method to fix the existing deadlocks
> > with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?
>
> No, I think if someone cares about these, they should explicitly set the
> PF flag in their task processing the events.
>

OK.

I see an exit hatch in this statement -
If we are going leave the responsibility to avoid deadlock in corner
cases completely in the hands of the application, then I do not feel
morally obligated to create the PF_NOWAIT_FREEZE API *before*
providing the first HSM API.

If the HSM application is running in a controlled system, on a filesystem
where fsfreeze is not expected or not needed, then a fully functional and
safe HSM does not require PF_NOWAIT_FREEZE API.

Perhaps an API to make an fs unfreezable is just as practical and a much
easier option for the first version of HSM API?

Imagine that HSM opens an fd and sends an EXCLUSIVE_FSFREEZER
ioctl. Then no other task can freeze the fs, for as long as the fd is open
apart from the HSM itself using this fd.

HSM itself can avoid deadlocks if it collaborates the fs freezes with
making fs modifications from within HSM events.

Do you think that may be an acceptable way out or the corner?

Thanks,
Amir.

