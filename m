Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3A73DEF2E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbhHCNjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 09:39:32 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43504 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhHCNjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:39:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0160C20039;
        Tue,  3 Aug 2021 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627997960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfHbWAIN5SGpqAZt/tQ+zSq8TJoObW7WklX/DFpztng=;
        b=mSq+gMlLkqYpQ6Tksw+nnJ7pgEs9mHV7PUj2ai42fJnZhNJZRWjSxc3hUa0krXCfm2DNGq
        dvxdi1FaAAf7DPmk1v5nElG71Upqog+fqSMu5oNW3CJ6wnDgApeqmW3qbTExLRausdAFAM
        RQ9KUc5RP1qFdY6Y+MbrK5vwUqhXtdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627997960;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfHbWAIN5SGpqAZt/tQ+zSq8TJoObW7WklX/DFpztng=;
        b=B/rfpdGjEOZagZ5Rf+Eo9y+6zg4HYhhwPLGcW3Pm8bS0BFnXAW7PmdxaFn+FJccPPxJR4S
        lp38zqC7Jidw+fCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DC51BA3BD3;
        Tue,  3 Aug 2021 13:39:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A927C1E62D6; Tue,  3 Aug 2021 15:39:19 +0200 (CEST)
Date:   Tue, 3 Aug 2021 15:39:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210803133919.GD10621@quack2.suse.cz>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz>
 <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
 <20210802123428.GB28745@quack2.suse.cz>
 <CAOQ4uxhk-vTOFvpuh81A2V5H0nfAJW6y3qBi9TgnZxAkRDSeKQ@mail.gmail.com>
 <20210803093753.mxcn6nzgj55erpuw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803093753.mxcn6nzgj55erpuw@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-08-21 11:37:53, Christian Brauner wrote:
> On Mon, Aug 02, 2021 at 05:38:20PM +0300, Amir Goldstein wrote:
> > On Mon, Aug 2, 2021 at 3:34 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 30-07-21 08:03:01, Amir Goldstein wrote:
> > > > On Thu, Jul 29, 2021 at 6:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> > > > > > same process while you read various data from it. And you cannot achieve
> > > > > > that with pid+generation thing you've suggested. Plus the additional
> > > > > > concept and its complexity is non-trivial So I tend to agree with
> > > > > > Christian that we really want to return pidfd.
> > > > > >
> > > > > > Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> > > > > > whether it is worth the trouble to come up with some other mechanism how to
> > > > > > return pidfd with the event. We could return some cookie which could be
> > > > > > then (by some ioctl or so) either transformed into real pidfd or released
> > > > > > (so that we can release pid handle in the kernel) but it looks ugly and
> > > > > > complicates things for everybody without bringing significant security
> > > > > > improvement (we already can pass fd with the event). So I'm pondering
> > > > > > whether there's some other way how we could make the interface safer - e.g.
> > > > > > so that the process receiving the event (not the one creating the group)
> > > > > > would also need to opt in for getting fds created in its file table.
> > > > > >
> > > > > > But so far nothing bright has come to my mind. :-|
> > > > > >
> > > > >
> > > > > There is a way, it is not bright, but it is pretty simple -
> > > > > store an optional pid in group->fanotify_data.fd_reader.
> > > > >
> > > > > With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
> > > > > will be disabled to any process other than fd_reader.
> > > > > Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
> > > > > if fd_reaader is set to a process other than the reader.
> > > > >
> > > > > A process can call ioctl START_FD_READER to set fd_reader to itself.
> > > > > With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
> > > > > process has CAP_SYS_ADMIN, read() sets fd_reader to itself.
> > > > >
> > > > > Permission wise, START_FD_READER is allowed with
> > > > > CAP_SYS_ADMIN or if fd_reader is not owned by another process.
> > > > > We may consider YIELD_FD_READER ioctl if needed.
> > > > >
> > > > > I think that this is a pretty cheap price for implementation
> > > > > and maybe acceptable overhead for complicating the API?
> > > > > Note that without passing fd, there is no need for any ioctl.
> > > > >
> > > > > An added security benefit is that the ioctl adds is a way for the
> > > > > caller of fanotify_init() to make sure that even if the fanotify_fd is
> > > > > leaked, that event->fd will not be leaked, regardless of flag
> > > > > FAN_REPORT_PIDFD.
> > > > >
> > > > > So the START_FD_READER ioctl feature could be implemented
> > > > > and documented first.
> > > > > And then FAN_REPORT_PIDFD could use the feature with a
> > > > > very minor API difference:
> > > > > - Without the flag, other processes can read fds by default and
> > > > >   group initiator can opt-out
> > > > > - With the flag, other processes cannot read fds by default and
> > > > >   need to opt-in
> > > >
> > > > Or maybe something even simpler... fanotify_init() flag
> > > > FAN_PRIVATE (or FAN_PROTECTED) that limits event reading
> > > > to the initiator process (not only fd reading).
> > > >
> > > > FAN_REPORT_PIDFD requires FAN_PRIVATE.
> > > > If we do not know there is a use case for passing fanotify_fd
> > > > that reports pidfds to another process why implement the ioctl.
> > > > We can always implement it later if the need arises.
> > > > If we contemplate this future change, though, maybe the name
> > > > FAN_PROTECTED is better to start with.
> > >
> > > Good ideas. I think we are fine with returning pidfd only to the process
> > > creating the fanotify group. Later we can add an ioctl which would indicate
> > > that the process is also prepared to have fds created in its file table.
> > > But I have still some open questions:
> > > Do we want threads of the same process to still be able to receive fds?
> > 
> > I don't see why not.
> > They will be bloating the same fd table as the thread that called
> > fanotify_init().
> > 
> > > Also pids can be recycled so they are probably not completely reliable
> > > identifiers?
> > 
> > Not sure I follow. The group hold a refcount on struct pid of the process that
> > called fanotify_init() - I think that can used to check if reader process is
> > the same process, but not sure. Maybe there is another way (Christian?).
> 
> If the fanotify group hold's a reference to struct pid it won't get
> recycled. And it can be used to check if the reader thread is the same
> thread with some care. You also have to be specific what exactly you
> want to know.  If you're asking if the reading process is the same as
> the fanotify_init() process you can be asking one of two things.
> 
> You can be asking if the reader is a thread in the same thread-group as
> the thread that called fanotify_init(). In that case you might need to
> do something like
> 
> rcu_read_lock();
> struct task_struct *fanotify_init_task_struct = pid_task(stashed_struct_pid, PIDTYPE_PID);
> if (!fanotify_init_task_struct) {
> 	/* The thread which called fanotify_init() has died already. */ 
> 	return -ESRCH;
> }
> if (same_thread_group(fanotify_init_task_struct, current))
> rcu_read_unlock();
> 
> though thinking about it makes me realise that there's a corner case. If
> the thread that called fanotify_init() is a thread in a non-empty
> thread-group it can already have died and been reaped. This would mean,
> pid_task(..., PIDTYPE_PID) will return NULL but there are still other
> threads alive in the thread-group. Handling that case might be a bit
> complicated.
> 
> If you're asking whether the reading thread is really the same as the
> thread that created the fanotify instance then you might need to do sm
> like
> 
> rcu_read_lock();
> if (pid_task(stashed_struct_pid, PIDTYPE_PID) == current)
> rcu_read_unlock();
> 
> Just for completeness if I remember all of this right: there's a corner
> case because of how de_thread() works.
> During exec the thread that is execing will assume the struct pid of the
> old thread-group leader. (All other threads in the same thread-group
> will get killed.)
> Assume the thread that created the fanotify instance is not the
> thread-group leader in its non-empty thread-group. And further assume it
> exec's. Then it will assume the struct pid of the old thread-group
> leader during de_thread().
> Assume the thread inherits the fanotify fd across the exec. Now, when it
> tries to read a new event after the exec then pid_task() will return
> NULL.
> However, if the thread was already the thread-group leader before the
> exec then pid_task() will return the same task struct as before after
> the exec (because no struct pid swapping needed to take place).
> 
> I hope this causes more clarity then confusion. :)

Thanks for the details Christian! After some more reading and your comments
I think the situation is relatively clear. What we could do is:

On fanotify_init(2) do get_task_pid(current, PIDTYPE_TGID) and stash it. On
read from fanotify fd do
	rcu_read_lock();
	if (rcu_dereference(*task_pid_ptr(current, PIDTYPE_TGID)) !=
								stashed_pid) {
		rcu_read_unlock();
		return -EPERM;
	}
	rcu_read_unlock();

This should avoid all the nasty cornercases. So it can be done but I have
more and more doubts whether it is all worth it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
