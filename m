Return-Path: <linux-fsdevel+bounces-3204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FD7F1542
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB1282618
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 14:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3A41C281;
	Mon, 20 Nov 2023 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VSvFexU5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WE+e9/pI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34AD61
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 06:06:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A05F1F85D;
	Mon, 20 Nov 2023 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700489166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z9DpAblfoJNWY4kJDqfJhPE9pwsNT7GdyUQj4JSWT4=;
	b=VSvFexU5EMM07BPspQhf2FJfux18juA9d+DhiAuTJ+iFgYGPMyhIPJnQ1IWoylejB830+t
	7B5WSzRZAceuif+RsCKDJxP74ESN//fs/S1OClOwRVIAw3D0NaK7ehEqF9HyI2PlVb4mHX
	NeLy5EXgGPEIYv2+Fge2zqPN1ohykFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700489166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z9DpAblfoJNWY4kJDqfJhPE9pwsNT7GdyUQj4JSWT4=;
	b=WE+e9/pIwVpD0Dhxy/Vlwx9STjmtRx5FMESPA2nszFfSqdEm1UnzrMvLGHHBECGlB6muQP
	ifzDU6VKd0au7+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5313513499;
	Mon, 20 Nov 2023 14:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eOlBFM5nW2XZFAAAMHmgww
	(envelope-from <jack@suse.cz>); Mon, 20 Nov 2023 14:06:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 07575A07BE; Mon, 20 Nov 2023 15:06:06 +0100 (CET)
Date: Mon, 20 Nov 2023 15:06:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify HSM open issues
Message-ID: <20231120140605.6yx3jryuylgcphhr@quack3>
References: <CAOQ4uxiS6R9hGFmputP6uRHGKywaCca0Ug53ihGcrgxkvMHomg@mail.gmail.com>
 <CAOQ4uxhk_rydFejNqsmn4AydZfuknp=vPunNODNcZ_8qW-AykQ@mail.gmail.com>
 <20230816094702.zztx3dctxvnfeh6o@quack3>
 <CAOQ4uxhp6o40gZKnyAcjB2vkmNF0WOD9V9p2i+eHXXjSf=YFtQ@mail.gmail.com>
 <CAOQ4uxixuw9d1TGNpzc7cSPyzRN6spu48Y+4QPqFBsvOYS89kQ@mail.gmail.com>
 <20230817182220.vzzklvr7ejqlfnju@quack3>
 <CAOQ4uxhRwq7MpN4rx1NbVccbPsW7Bkh9YdzrWYjZYFP8EAMR7g@mail.gmail.com>
 <20230823143708.nry64nytwbeijtsq@quack3>
 <CAOQ4uxh87hQUVrVYOkq+5pndVnMYhgHS0rBzXXjZe5ji7L-uTg@mail.gmail.com>
 <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjMjGgeCJ+pGJAiTYUxfHXABmbbe8_L6S3QAE_uMv5E6A@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spamd-Result: default: False [-3.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-0.99)[-0.992];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_ALL(0.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Hi Amir,

sorry for a bit delayed reply, I did not get to "swapping in" HSM
discussion during the Plumbers conference :)

On Mon 13-11-23 13:50:03, Amir Goldstein wrote:
> On Wed, Aug 23, 2023 at 7:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Aug 23, 2023 at 5:37 PM Jan Kara <jack@suse.cz> wrote:
> > > > Recap for new people joining this thread.
> > > >
> > > > The following deadlock is possible in upstream kernel
> > > > if fanotify permission event handler tries to make
> > > > modifications to the filesystem it is watching in the context
> > > > of FAN_ACCESS_PERM handling in some cases:
> > > >
> > > > P1                             P2                      P3
> > > > -----------                    ------------            ------------
> > > > do_sendfile(fs1.out_fd, fs1.in_fd)
> > > > -> sb_start_write(fs1.sb)
> > > >   -> do_splice_direct()                         freeze_super(fs1.sb)
> > > >     -> rw_verify_area()                         -> sb_wait_write(fs1.sb) ......
> > > >       -> security_file_permission()
> > > >         -> fsnotify_perm() --> FAN_ACCESS_PERM
> > > >                                  -> do_unlinkat(fs1.dfd, ...)
> > > >                                    -> sb_start_write(fs1.sb) ......
> > > >
> > > > start-write-safe patches [1] (not posted) are trying to solve this
> > > > deadlock and prepare the ground for a new set of permission events
> > > > with cleaner/safer semantics.
> > > >
> > > > The cases described above of sendfile from a file in loop mounted
> > > > image over fs1 or overlayfs over fs1 into a file in fs1 can still
> > > > deadlock despite the start-write-safe patches [1].
> > >
> > > Yep, nice summary.
...
> > > > > As I wrote above I don't like the abuse of FMODE_NONOTIFY much.
> > > > > FMODE_NONOTIFY means we shouldn't generate new fanotify events when using
> > > > > this fd. It says nothing about freeze handling or so. Furthermore as you
> > > > > observe FMODE_NONOTIFY cannot be set by userspace but practically all
> > > > > current fanotify users need to also do IO on other files in order to handle
> > > > > fanotify event. So ideally we'd have a way to do IO to other files in a
> > > > > manner safe wrt freezing. We could just update handling of RWF_NOWAIT flag
> > > > > to only trylock freeze protection - that actually makes a lot of sense to
> > > > > me. The question is whether this is enough or not.
> > > > >
> > > >
> > > > Maybe, but RWF_NOWAIT doesn't take us far enough, because writing
> > > > to a file is not the only thing that HSM needs to do.
> > > > Eventually, event handler for lookup permission events should be
> > > > able to also create files without blocking on vfs level freeze protection.
> > >
> > > So this is what I wanted to clarify. The lookup permission event never gets
> > > called under a freeze protection so the deadlock doesn't exist there. In
> > > principle the problem exists only for access and modify events where we'd
> > > be filling in file data and thus RWF_NOWAIT could be enough.
> >
> > Yes, you are right.
> > It is possible that RWF_NOWAIT could be enough.
> >
> > But the discovery of the loop/ovl corner cases has shaken my
> > confidence is the ability to guarantee that freeze protection is not
> > held somehow indirectly.
> >
> > If I am not mistaken, FAN_OPEN_PERM suffers from the exact
> > same ovl corner case, because with splice from ovl1 to fs1,
> > fs1 freeze protection is held and:
> >   ovl_splice_read(ovl1.file)
> >     ovl_real_fdget()
> >       ovl_open_realfile(fs1.file)
> >          ... security_file_open(fs1.file)
> >
> > > That being
> > > said I understand this may be assuming too much about the implementations
> > > of HSM daemons and as you write, we might want to provide a way to do IO
> > > not blocking on freeze protection from any hook. But I wanted to point this
> > > out explicitly so that it's a conscious decision.
> > >
> 
> I agree and I'd like to explain using an example, why RWF_NOWAIT is
> not enough for HSM needs.
> 
> The reason is that often, when HSM needs to handle filling content
> in FAN_PRE_ACCESS, it is not just about writing to the accessed file.
> HSM needs to be able to avoid blocking on freeze protection
> for any operations on the filesystem, not just pwrite().
> 
> For example, the POC HSM code [1], stores the DATA_DIR_fd
> from the lookup event and uses it in the handling of access events to
> update the metadata files that store which parts of the file were already
> filled (relying of fiemap is not always a valid option).
> 
> That is the reason that in the POC patches [2], FMODE_NONOTIFY
> is propagated from dirfd to an fd opened with openat(dirfd, ...), so
> HSM has an indirect way to get a FMODE_NONOTIFY fd on any file.
> 
> Another use case is that HSM may want to download content to a
> temp file on the same filesystem, verify the downloaded content and
> then clone the data into the accessed file range.
> 
> I think that a PF_ flag (see below) would work best for all those cases.

Ok, I agree that just using RWF_NOWAIT from the HSM daemon need not be
enough for all sensible usecases to avoid deadlocks with freezing. However
note that if we want to really properly handle all possible operations, we
need to start handling error from all sb_start_write() and
file_start_write() calls and there are quite a few of those.

> > > > In theory, I am not saying we should do it, but as a thought experiment:
> > > > if the requirement from permission event handler is that is must use a
> > > > O_PATH | FMODE_NONOTIFY event->fd provided in the event to make
> > > > any filesystem modifications, then instead of aiming for NOWAIT
> > > > semantics using sb_start_write_trylock(), we could use a freeze level
> > > > SB_FREEZE_FSNOTIFY between
> > > > SB_FREEZE_WRITE and SB_FREEZE_PAGEFAULT.
> > > >
> > > > As a matter of fact, HSM is kind of a "VFS FAULT", so as long as we
> > > > make it clear how userspace should avoid nesting "VFS faults" there is
> > > > a model that can solve the deadlock correctly.
> > >
> > > OK, yes, in principle another freeze level which could be used by handlers
> > > of fanotify permission events would solve the deadlock as well. Just you
> > > seem to like to tie this functionality to the particular fd returned from
> > > fanotify and I'm not convinced that is a good idea. What if the application
> > > needs to do write to some other location besides the one fd it got passed
> > > from fanotify event? E.g. imagine it wants to fetch a whole subtree on
> > > first access to any file in a subtree. Or maybe it wants to write to some
> > > DB file containing current state or something like that.
> > >
> > > One solution I can imagine is to create an open flag that can be specified
> > > on open which would result in the special behavior wrt fs freezing. If the
> > > special behavior would be just trylocking the freeze protection then it
> > > would be really easy. If the behaviour would be another freeze protection
> > > level, then we'd need to make sure we don't generate another fanotify
> > > permission event with such fd - autorejecting any such access is an obvious
> > > solution but I'm not sure if practical for applications.
> > >
> >
> > I had also considered marking the listener process with the FSNOTIFY
> > context and enforcing this context on fanotify_read().
> > In a way, this is similar to the NOIO and NOFS process context.
> > It could be used to both act as a stronger form of FMODE_NONOTIFY
> > and to activate the desired freeze protection behavior
> > (whether trylock or SB_FREEZE_FSNOTIFY level).
> >
> 
> My feeling is that the best approach would be a PF_NOWAIT task flag:
> 
> - PF_NOWAIT will prevent blocking on freeze protection
> - PF_NOWAIT + FMODE_NOWAIT would imply RWF_NOWAIT
> - PF_NOWAIT could be auto-set on the reader of a permission event
> - PF_NOWAIT could be set on init of group FAN_CLASS_PRE_PATH
> - We could add user API to set this personality explicitly to any task
> - PF_NOWAIT without FMODE_NONOTIFY denies permission events
> 
> Please let me know if you agree with this design and if so,
> which of the methods to set PF_NOWAIT are a must for the first version
> in your opinion?

Yeah, the PF flag could work. It can be set for the process(es) responsible
for processing the fanotify events and filling in filesystem contents. I
don't think automatic setting of this flag is desirable though as it has
quite wide impact and some of the consequences could be surprising.  I
rather think it should be a conscious decision when setting up the process
processing the events. So I think API to explicitly set / clear the flag
would be the best. Also I think it would be better to capture in the name
that this is really about fs freezing. So maybe PF_NOWAIT_FREEZE or
something like that?

Also we were thinking about having an open(2) flag for this (instead of PF
flag) in the past. That would allow finer granularity control of the
behavior but I guess you are worried that it would not cover all the needed
operations?

> Do you think we should use this method to fix the existing deadlocks
> with FAN_OPEN_PERM and FAN_ACCESS_PERM? without opt-in?

No, I think if someone cares about these, they should explicitly set the
PF flag in their task processing the events.

> > > > OK. ATM, the only solution I can think of that is both maintainable
> > > > and lets HSM live in complete harmony with fsfreeze is adding the
> > > > extra SB_FREEZE_FSNOTIFY level.
> > >
> > > To make things clear: if the only problems would be with those sendfile(2)
> > > rare corner-cases, then I guess we can live with that and implement retry
> > > in the kernel if userspace ever complains about unexpected short copy or
> > > EAGAIN...  The problem I see is that if we advise that all IO from the
> > > fanotify event handler should happen in the freeze-safe manner, then with
> > > the non-blocking solution all HSM IO suddently starts failing as soon as
> > > the filesystem is frozen. And that is IMHO not nice.
> >
> > I see what you mean. The SB_FREEZE_FSNOTIFY design is much more
> > clear in that respect.
> >
> > > > I am not sure how big of an overhead that would be?
> > > > I imagine that sb_writers is large enough as it is w.r.t fitting into
> > > > cache lines?
> > > > I don't think that it adds much complexity or maintenance burden
> > > > to vfs?? I'm really not sure.
> > >
> > > Well, the overhead is effectively one percpu counter per superblock.
> > > Negligible in terms of CPU time, somewhat annoying in terms of memory but
> > > bearable. So this may be a way forward.
> 
> My feeling is that because we only need this to handle very obscure
> corner cases, that adding an extra freeze level is an overkill that
> cannot be justified, even if the actual impact on cpu and memory are
> rather low.
> 
> The HSM API documentation will clearly state that EAGAIN may be
> expected when writing to the filesystem.
> 
> IMO, for all practical matters, it is perfectly fine if HSM just denies
> access in those corner cases, but even a simple solution of triggering
> async download of file's content and returning a temporary to user
> is a decent solution for the rare corner cases.

Yeah, I guess returning EAGAIN to userspace in these corner cases might be
acceptable. It won't be 100% compatible with current filesystem behavior in
case the fs is frozen but close enough.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

