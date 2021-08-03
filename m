Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A233DE9F1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 11:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhHCJqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 05:46:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235133AbhHCJqs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:46:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33EC360F92;
        Tue,  3 Aug 2021 09:46:33 +0000 (UTC)
Date:   Tue, 3 Aug 2021 11:46:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210803094631.7c6vuvozhkckymr6@wittgenstein>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz>
 <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
 <20210802123428.GB28745@quack2.suse.cz>
 <CAOQ4uxhk-vTOFvpuh81A2V5H0nfAJW6y3qBi9TgnZxAkRDSeKQ@mail.gmail.com>
 <20210802201002.GF28745@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210802201002.GF28745@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:10:02PM +0200, Jan Kara wrote:
> On Mon 02-08-21 17:38:20, Amir Goldstein wrote:
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
> 
> I agree. So do we store thread group leader PID in fanotify group? What if
> thread group leader changes? I guess I have to do some reading as I don't

I've touched on this in my answer to Amir.
In my other answer I pointed out that storing a
non-thread-group leader struct pid has consequences because of how
de_thread() works. This might lead to a slight inconsistency in api
behavior if a non-thread group leader execs in a non-empty thread-group
that created the fanotify instance. But if you store a thread-group
leader struct pid the api would be consistent even with de_thread() in
the picture unless I forgot some other nasty detail in my other mail.

> know how all these details work internally.
> 
> > > Also pids can be recycled so they are probably not completely reliable
> > > identifiers?
> > 
> > Not sure I follow. The group hold a refcount on struct pid of the process that
> > called fanotify_init() - I think that can used to check if reader process is
> > the same process, but not sure. Maybe there is another way (Christian?).
> 
> Yes, if we hold refcount on struct pid, it should be safe against recycling.
> But cannot someone (even unpriviledged process in this case) mount some
> attack by creating a process which creates fanotify group, passes fanotify fd,
> and dies but pid would be still blocked because fanotify holds reference to
> it? I guess this is not practical as the number of fanotify groups is limited
> as well as number of fds.

If this were a serious problem it would already be a problem today. But
yes, it is limited by the number of fds. Note that struct pid was (among
other reasons) created in order to prevent having to hold references to
struct task_struct because of the amount of memory that would be wasted.
