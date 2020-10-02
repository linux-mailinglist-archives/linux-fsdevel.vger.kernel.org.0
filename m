Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB128101E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 11:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgJBJvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 05:51:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56652 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgJBJvO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:51:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15201B28F;
        Fri,  2 Oct 2020 09:51:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A77711E12EF; Fri,  2 Oct 2020 11:51:12 +0200 (CEST)
Date:   Fri, 2 Oct 2020 11:51:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: FAN_UNPRIVILEGED
Message-ID: <20201002095112.GC17963@quack2.suse.cz>
References: <20200914172737.GA5011@192.168.3.9>
 <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
 <20201001110058.GG17860@quack2.suse.cz>
 <CAOQ4uxh3cgzEZJhYVMqtVB5kig1O57WaUkxPnxnpQHm5TGjmfg@mail.gmail.com>
 <20201002082719.GA17963@quack2.suse.cz>
 <CAOQ4uxiUS7PCpwMHYGYZM=3-R=4VMQMww=F=BL+fw+JTE=8zEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiUS7PCpwMHYGYZM=3-R=4VMQMww=F=BL+fw+JTE=8zEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 02-10-20 12:06:48, Amir Goldstein wrote:
> On Fri, Oct 2, 2020 at 11:27 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 01-10-20 16:08:50, Amir Goldstein wrote:
> > > On Thu, Oct 1, 2020 at 2:00 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > I'm sorry for late reply on this one...
> > > >
> > > > On Tue 15-09-20 11:33:41, Amir Goldstein wrote:
> > > > > On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > > > > > Now the IN_OPEN event can report all open events for a file, but it can
> > > > > > > not distinguish if the file was opened for execute or read/write.
> > > > > > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > > > > > want to monitor a file was opened for execute, they can pass a more
> > > > > > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > > > > > >
> > > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > > >
> > > > > > Thanks for the patch but what I'm missing is a justification for it. Is
> > > > > > there any application that cannot use fanotify that needs to distinguish
> > > > > > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > > > > > specialized purposes (e.g. audit) which are generally priviledged and need
> > > > > > to use fanotify anyway so I don't see this as an interesting feature for
> > > > > > inotify...
> > > > >
> > > > > That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> > > > > Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> > > > > feature parity with inotify, but now it mostly does, short of (AFAIK):
> > > > > 1. Rename cookie (*)
> > > > > 2. System tunables for limits
> > > > >
> > > > > The question is - should I pursue it?
> > > >
> > > > So I think that at this point some form less priviledged fanotify use
> > > > starts to make sense. So let's discuss how it would look like... What comes
> > > > to my mind:
> > > >
> > > > 1) We'd need to make max_user_instances, max_user_watches, and
> > > > max_queued_events configurable similarly as for inotify. The first two
> > > > using ucounts so that the configuration is actually per-namespace as for
> > > > inotify.
> > > >
> > > > 2) I don't quite like the FAN_UNPRIVILEDGED flag. I'd rather see the checks
> > > > being done based on functionality requested in fanotify_init() /
> > > > fanotify_mark(). E.g. FAN_UNLIMITED_QUEUE or permission events will require
> > > > CAP_SYS_ADMIN, mount/sb marks will require CAP_DAC_READ_SEARCH, etc.
> > > > We should also consider which capability checks should be system-global and
> > > > which can be just user-namespace ones...
> > >
> > > OK. That is not a problem to do.
> > > But FAN_UNPRIVILEDGED flag also impacts:
> > >
> > >     An unprivileged event listener does not get an open file descriptor in
> > >     the event nor the process pid of another process.
> >
> > Well, are these really sensitive that they should be forbidden? If we allow
> > only inode marks and given inode is opened in the context of process
> > reading the event, I don't see how fd would be any sensitive? And similarly
> > for pid I'd say...
> >
> 
> Because I was under the impression that we are going to allow a dir watch
> on children, just like inotify and process may have permission to access dir,
> but no permission to open a child.

Right, I agree FAN_EVENT_ON_CHILD should be allowed with less priviledge as
well. But can't we just check for 'x' permission on parent dir when
generating event to task that does not have CAP_DAC_READ_SEARCH and
may_open() after that? We have all info available when handling
FAN_EVENT_ON_CHILD events AFAICT...

> That said, it's true that we can decide whether or not to export a RDONLY
> open fd based on CAP_DAC_READ_SEARCH of the reader process.

Or that but I guess may_open() check may be still needed...

> Regarding exposing pid, I am not familiar with the capabilities required to
> "spy" on another process' actions using other facilities, so I thought we
> should take a conservative approach and require at least CAP_SYS_PTRACE
> to expose information about the process generating the event.

Anybody can learn PID of a process in his own namespace. So PID itself is
not secret. The fact that someone accessed a file is no secret either (you
can poll atime / mtime). The fact that a particular process accessed a
particular file - well, that's revealing something. Not sure whether it is
relevant but I guess let's be cautious, we can always relax this later.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
