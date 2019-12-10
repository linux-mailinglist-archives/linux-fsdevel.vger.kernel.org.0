Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C87118E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfLJQzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 11:55:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:35246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727541AbfLJQzl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:55:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2D617ADC8;
        Tue, 10 Dec 2019 16:55:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CFCB61E0B23; Tue, 10 Dec 2019 17:55:38 +0100 (CET)
Date:   Tue, 10 Dec 2019 17:55:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mo Re Ra <more7.rev@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20191210165538.GK1551@quack2.suse.cz>
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz>
 <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Mohammad!

On Sat 07-12-19 16:06:41, Mo Re Ra wrote:
> On Wed, Dec 4, 2019 at 9:04 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Mohammad,
> >
> > On Wed 04-12-19 17:54:48, Mo Re Ra wrote:
> > > On Wed, Dec 4, 2019 at 4:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Wed, Dec 4, 2019 at 12:03 PM Mo Re Ra <more7.rev@gmail.com> wrote:
> > > > > I don`t know if this is the correct place to express my issue or not.
> > > > > I have a big problem. For my project, a Directory Monitor, I`ve
> > > > > researched about dnotify, inotify and fanotify.
> > > > > dnotify is the worst choice.
> > > > > inotify is a good choice but has a problem. It does not work
> > > > > recursively. When you implement this feature by inotify, you would
> > > > > miss immediately events after subdir creation.
> > > > > fanotify is the last choice. It has a big change since Kernel 5.1. But
> > > > > It does not meet my requirement.
> > > > >
> > > > > I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
> > > > > and CLOSE_WRITE events would be happened in its subdirectories.
> > > > > Filename of the events happened on that (without any miss) is
> > > > > mandatory for me.
> > > > >
> > > > > I`ve searched and found a contribution from @amiril73 which
> > > > > unfortunately has not been merged. Here is the link:
> > > > > https://github.com/amir73il/fsnotify-utils/issues/1
> > > > >
> > > > > I`d really appreciate it If you could resolve this issue.
> > > > >
> > > >
> > > > Hi Mohammad,
> > > >
> > > > Thanks for taking an interest in fanotify.
> > > >
> > > > Can you please elaborate about why filename in events are mandatory
> > > > for your application.
> > > >
> > > > Could your application use the FID in FAN_DELETE_SELF and
> > > > FAN_MOVE_SELF events to act on file deletion/rename instead of filename
> > > > information in FAN_DELETE/FAN_MOVED_xxx events?
> > > >
> > > > Will it help if you could get a FAN_CREATE_SELF event with FID information
> > > > of created file?
> > > >
> > > > Note that it is NOT guarantied that your application will be able to resolve
> > > > those FID to file path, for example if file was already deleted and no open
> > > > handles for this file exist or if file has a hardlink, you may resolve the path
> > > > of that hardlink instead.
> > > >
> > > > Jan,
> > > >
> > > > I remember we discussed the optional FAN_REPORT_FILENAME [1] and
> > > > you had some reservations, but I am not sure how strong they were.
> > > > Please refresh my memory.
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://github.com/amir73il/linux/commit/d3e2fec74f6814cecb91148e6b9984a56132590f
> > >
> >
> > > Fanotify project had a big change since Kernel 5.1 but did not meet
> > > some primiry needs.
> > > For example in my application, I`m watching on a specific directory to
> > > sync it (through a socket connection and considering some policies)
> > > with a directory in a remote system which a user working on that. Some
> > > subdirectoires may contain two milions of files or more. I need these
> > > two directoires be synced completely as soon as possible without any
> > > missed notification.
> > > So, I need a syscall with complete set of flags to help to watch on a
> > > directory and all of its subdirectories recuresively without any
> > > missed notification.
> > >
> > > Unfortuantely, in current version of Fanotify, the notification just
> > > expresses a change has been occured in a directory but dot not
> > > specifiy which file! I could not iterate over millions of file to
> > > determine which file was that. That would not be helpful.
> >
> > The problem is there's no better reliable way. For example even if fanotify
> > event provided a name as in the Amir's commit you reference, this name is
> > not very useful. Because by the time your application gets to processing
> > that fanotify event, the file under that name need not exist anymore, or
> > there may be a different file under that name already. That is my main
> > objection to providing file names with fanotify events - they are not
> > reliable but they are reliable enough that application developers will use
> > them as a reliable thing which then leads to hard to debug bugs. Also
> > fanotify was never designed to guarantee event ordering so it is impossible
> > to reconstruct exact state of a directory in userspace just by knowing some
> > past directory state and then "replaying" changes as reported by fanotify.
> >
> > I could imagine fanotify events would provide FID information of the target
> > file e.g. on create so you could then use that with open_by_handle() to
> > open the file and get reliable access to file data (provided the file still
> > exists). However there still remains the problem that you don't know the
> > file name and the problem that directory changes while you are looking...
> >
> > So changing fanotify to suit your usecase requires more than a small tweak.
> >
> > For what you want, it seems e.g. btrfs send-receive functionality will
> > provide what you need but then that's bound to a particular filesystem.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> I understand your concerns about reliablity. But I think functionality
> and reliablity are two different things in this case. We`d better
> entrust the reliability to the user.
> Consider a user just want monitor all of filesystem changes but does
> not intend to do anything according the received notifications.
> I think we do not make decision for users by restricting them and
> ignoring their necessary demands. We shuold introduce the best
> available tools with all of concerns about them (which are
> documented). So, we would put the user in charge of organizing his
> projects. The user may care or not according his demands.

I disgree. This is not how API design works in the Linux kernel. First, you
have to have a good and sound use case for the functionality (and I
understand and acknowledge your need to monitor a large directory and
reliably synchronize changes to another place) and then we try to implement
API that would fulfil the needs of the usecase. For you, extending fanotify
with file names will *not* fulfil the needs of your use case. The mechanism
will be as racy as with inotify, just with somewhat smaller set of races.
I'm not willing to introduce another file change notification API to the
kernel that works with 99% reliability. We've been through that with
inotify and it just adds maintenance burden and shifts the problem couple
years down the road before people start hitting the races with the new API.

And we don't add new APIs to the kernel just because someone could find
some use for them. Because APIs in the kernel are really costly in terms of
maintenance. Once you introduce userspace facing API, you have to maintain
it basically forever which constrains future development and adds needs for
compatibility layers etc.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
