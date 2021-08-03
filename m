Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2C3DEFA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 16:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhHCOEg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 10:04:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbhHCOEf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:04:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C4700200D0;
        Tue,  3 Aug 2021 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627999463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ouKVLmkiteY68R/zynjh6KepxiHsDjIoMNZZTeGuY5U=;
        b=tjtea3Rx6ytI78BvUZo7csPrrPKe966cgHVR5uDRG9X8hiDFmb3zp+VTDn5iPIyujSMODC
        R6m86ik94oezjNLWtotH/EHjYBcIUqrDQm8nFBzn3ZpJqDRkkCqaiLQkDCEemInd9VOk1s
        FjyhdgubPi/9fKEg3U5hk1Ck5n412vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627999463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ouKVLmkiteY68R/zynjh6KepxiHsDjIoMNZZTeGuY5U=;
        b=fyRdVF7dmtn/7NX4nKORIylX3CowC2fQXU1fFRAC+td8hqUuoPQ7yZpnbN+WCYCAJKqvKd
        nJ5KuH4jZrZD7cAw==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id AD495A3BD5;
        Tue,  3 Aug 2021 14:04:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1A9F81E62D6; Tue,  3 Aug 2021 16:04:21 +0200 (CEST)
Date:   Tue, 3 Aug 2021 16:04:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210803140421.GE10621@quack2.suse.cz>
References: <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz>
 <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
 <20210802123428.GB28745@quack2.suse.cz>
 <CAOQ4uxhk-vTOFvpuh81A2V5H0nfAJW6y3qBi9TgnZxAkRDSeKQ@mail.gmail.com>
 <20210803093753.mxcn6nzgj55erpuw@wittgenstein>
 <CAOQ4uxgKuS8SJjz2AJQAB=3d3Yw5EeJxZ28L-u4Z0Wd35ZZFHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgKuS8SJjz2AJQAB=3d3Yw5EeJxZ28L-u4Z0Wd35ZZFHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-08-21 13:07:57, Amir Goldstein wrote:
> On Tue, Aug 3, 2021 at 12:37 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Mon, Aug 02, 2021 at 05:38:20PM +0300, Amir Goldstein wrote:
> > > On Mon, Aug 2, 2021 at 3:34 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Fri 30-07-21 08:03:01, Amir Goldstein wrote:
> > > > > On Thu, Jul 29, 2021 at 6:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> > > > > > > same process while you read various data from it. And you cannot achieve
> > > > > > > that with pid+generation thing you've suggested. Plus the additional
> > > > > > > concept and its complexity is non-trivial So I tend to agree with
> > > > > > > Christian that we really want to return pidfd.
> > > > > > >
> > > > > > > Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> > > > > > > whether it is worth the trouble to come up with some other mechanism how to
> > > > > > > return pidfd with the event. We could return some cookie which could be
> > > > > > > then (by some ioctl or so) either transformed into real pidfd or released
> > > > > > > (so that we can release pid handle in the kernel) but it looks ugly and
> > > > > > > complicates things for everybody without bringing significant security
> > > > > > > improvement (we already can pass fd with the event). So I'm pondering
> > > > > > > whether there's some other way how we could make the interface safer - e.g.
> > > > > > > so that the process receiving the event (not the one creating the group)
> > > > > > > would also need to opt in for getting fds created in its file table.
> > > > > > >
> > > > > > > But so far nothing bright has come to my mind. :-|
> > > > > > >
> > > > > >
> > > > > > There is a way, it is not bright, but it is pretty simple -
> > > > > > store an optional pid in group->fanotify_data.fd_reader.
> > > > > >
> > > > > > With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
> > > > > > will be disabled to any process other than fd_reader.
> > > > > > Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
> > > > > > if fd_reaader is set to a process other than the reader.
> > > > > >
> > > > > > A process can call ioctl START_FD_READER to set fd_reader to itself.
> > > > > > With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
> > > > > > process has CAP_SYS_ADMIN, read() sets fd_reader to itself.
> > > > > >
> > > > > > Permission wise, START_FD_READER is allowed with
> > > > > > CAP_SYS_ADMIN or if fd_reader is not owned by another process.
> > > > > > We may consider YIELD_FD_READER ioctl if needed.
> > > > > >
> > > > > > I think that this is a pretty cheap price for implementation
> > > > > > and maybe acceptable overhead for complicating the API?
> > > > > > Note that without passing fd, there is no need for any ioctl.
> > > > > >
> > > > > > An added security benefit is that the ioctl adds is a way for the
> > > > > > caller of fanotify_init() to make sure that even if the fanotify_fd is
> > > > > > leaked, that event->fd will not be leaked, regardless of flag
> > > > > > FAN_REPORT_PIDFD.
> > > > > >
> > > > > > So the START_FD_READER ioctl feature could be implemented
> > > > > > and documented first.
> > > > > > And then FAN_REPORT_PIDFD could use the feature with a
> > > > > > very minor API difference:
> > > > > > - Without the flag, other processes can read fds by default and
> > > > > >   group initiator can opt-out
> > > > > > - With the flag, other processes cannot read fds by default and
> > > > > >   need to opt-in
> > > > >
> > > > > Or maybe something even simpler... fanotify_init() flag
> > > > > FAN_PRIVATE (or FAN_PROTECTED) that limits event reading
> > > > > to the initiator process (not only fd reading).
> > > > >
> > > > > FAN_REPORT_PIDFD requires FAN_PRIVATE.
> > > > > If we do not know there is a use case for passing fanotify_fd
> > > > > that reports pidfds to another process why implement the ioctl.
> > > > > We can always implement it later if the need arises.
> > > > > If we contemplate this future change, though, maybe the name
> > > > > FAN_PROTECTED is better to start with.
> > > >
> > > > Good ideas. I think we are fine with returning pidfd only to the process
> > > > creating the fanotify group. Later we can add an ioctl which would indicate
> > > > that the process is also prepared to have fds created in its file table.
> > > > But I have still some open questions:
> > > > Do we want threads of the same process to still be able to receive fds?
> > >
> > > I don't see why not.
> > > They will be bloating the same fd table as the thread that called
> > > fanotify_init().
> > >
> > > > Also pids can be recycled so they are probably not completely reliable
> > > > identifiers?
> > >
> > > Not sure I follow. The group hold a refcount on struct pid of the process that
> > > called fanotify_init() - I think that can used to check if reader process is
> > > the same process, but not sure. Maybe there is another way (Christian?).
> >
> > If the fanotify group hold's a reference to struct pid it won't get
> > recycled. And it can be used to check if the reader thread is the same
> > thread with some care. You also have to be specific what exactly you
> > want to know.  If you're asking if the reading process is the same as
> > the fanotify_init() process you can be asking one of two things.
> >
> > You can be asking if the reader is a thread in the same thread-group as
> > the thread that called fanotify_init(). In that case you might need to
> > do something like
> >
> > rcu_read_lock();
> > struct task_struct *fanotify_init_task_struct = pid_task(stashed_struct_pid, PIDTYPE_PID);
> > if (!fanotify_init_task_struct) {
> >         /* The thread which called fanotify_init() has died already. */
> >         return -ESRCH;
> > }
> > if (same_thread_group(fanotify_init_task_struct, current))
> > rcu_read_unlock();
> >
> > though thinking about it makes me realise that there's a corner case. If
> > the thread that called fanotify_init() is a thread in a non-empty
> > thread-group it can already have died and been reaped. This would mean,
> > pid_task(..., PIDTYPE_PID) will return NULL but there are still other
> > threads alive in the thread-group. Handling that case might be a bit
> > complicated.
> >
> > If you're asking whether the reading thread is really the same as the
> > thread that created the fanotify instance then you might need to do sm
> > like
> >
> > rcu_read_lock();
> > if (pid_task(stashed_struct_pid, PIDTYPE_PID) == current)
> > rcu_read_unlock();
> >
> > Just for completeness if I remember all of this right: there's a corner
> > case because of how de_thread() works.
> > During exec the thread that is execing will assume the struct pid of the
> > old thread-group leader. (All other threads in the same thread-group
> > will get killed.)
> > Assume the thread that created the fanotify instance is not the
> > thread-group leader in its non-empty thread-group. And further assume it
> > exec's. Then it will assume the struct pid of the old thread-group
> > leader during de_thread().
> > Assume the thread inherits the fanotify fd across the exec. Now, when it
> > tries to read a new event after the exec then pid_task() will return
> > NULL.
> > However, if the thread was already the thread-group leader before the
> > exec then pid_task() will return the same task struct as before after
> > the exec (because no struct pid swapping needed to take place).
> >
> > I hope this causes more clarity ?then confusion. :)
> 
> I'm afraid it's the latter :D
> 
> Sigh! We must simplify.
> 
> Thinking out loud, instead of sealing the possibility of another
> process reading pidfd, maybe just avoid the most obvious unintentional
> leak of fanotify_fd to another process by mandating  FAN_CLOEXEC?

Well, I don't think we need any protection from leaking fanotify_fd. It is
special fd with special priviledges as any other. If you leak it, well, bad
luck but that's how Unix priviledge model works.

The threat IMO is that you have a process X, that process expects to
receive fd to work with from process Y. Now process Y is malicious (or
taken over by an attacker) and passes to X fanotify_fd. X reads from
fanotify_fd to get data to process, it performs all kinds of validity
checks on untrusted input but it does not expect that the read has side
effects on X's file_table and in the worst case can lead to some compromise
of X or easily to DoS on X by exhausting its file_table space.

Currently this attack vector is moot because you have to have CAP_SYS_ADMIN
to get to fanotify_fd and then you can certainly do worse things. But OTOH
I can see why Jann was uneasy about this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
