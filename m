Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7711B280EB8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJBI1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 04:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:48806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBI1V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:27:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAC1DAC82;
        Fri,  2 Oct 2020 08:27:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7C8DB1E12EF; Fri,  2 Oct 2020 10:27:19 +0200 (CEST)
Date:   Fri, 2 Oct 2020 10:27:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: FAN_UNPRIVILEGED
Message-ID: <20201002082719.GA17963@quack2.suse.cz>
References: <20200914172737.GA5011@192.168.3.9>
 <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
 <20201001110058.GG17860@quack2.suse.cz>
 <CAOQ4uxh3cgzEZJhYVMqtVB5kig1O57WaUkxPnxnpQHm5TGjmfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh3cgzEZJhYVMqtVB5kig1O57WaUkxPnxnpQHm5TGjmfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-10-20 16:08:50, Amir Goldstein wrote:
> On Thu, Oct 1, 2020 at 2:00 PM Jan Kara <jack@suse.cz> wrote:
> >
> > I'm sorry for late reply on this one...
> >
> > On Tue 15-09-20 11:33:41, Amir Goldstein wrote:
> > > On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > > > Now the IN_OPEN event can report all open events for a file, but it can
> > > > > not distinguish if the file was opened for execute or read/write.
> > > > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > > > want to monitor a file was opened for execute, they can pass a more
> > > > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > > > >
> > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > >
> > > > Thanks for the patch but what I'm missing is a justification for it. Is
> > > > there any application that cannot use fanotify that needs to distinguish
> > > > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > > > specialized purposes (e.g. audit) which are generally priviledged and need
> > > > to use fanotify anyway so I don't see this as an interesting feature for
> > > > inotify...
> > >
> > > That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> > > Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> > > feature parity with inotify, but now it mostly does, short of (AFAIK):
> > > 1. Rename cookie (*)
> > > 2. System tunables for limits
> > >
> > > The question is - should I pursue it?
> >
> > So I think that at this point some form less priviledged fanotify use
> > starts to make sense. So let's discuss how it would look like... What comes
> > to my mind:
> >
> > 1) We'd need to make max_user_instances, max_user_watches, and
> > max_queued_events configurable similarly as for inotify. The first two
> > using ucounts so that the configuration is actually per-namespace as for
> > inotify.
> >
> > 2) I don't quite like the FAN_UNPRIVILEDGED flag. I'd rather see the checks
> > being done based on functionality requested in fanotify_init() /
> > fanotify_mark(). E.g. FAN_UNLIMITED_QUEUE or permission events will require
> > CAP_SYS_ADMIN, mount/sb marks will require CAP_DAC_READ_SEARCH, etc.
> > We should also consider which capability checks should be system-global and
> > which can be just user-namespace ones...
> 
> OK. That is not a problem to do.
> But FAN_UNPRIVILEDGED flag also impacts:
> 
>     An unprivileged event listener does not get an open file descriptor in
>     the event nor the process pid of another process.

Well, are these really sensitive that they should be forbidden? If we allow
only inode marks and given inode is opened in the context of process
reading the event, I don't see how fd would be any sensitive? And similarly
for pid I'd say...

> Obviously, I can check CAP_SYS_ADMIN on fanotify_init() and set the
> FAN_UNPRIVILEDGED flag as an internal flag.
> 
> The advantage of explicit FAN_UNPRIVILEDGED flag is that a privileged process
> can create an unprivileged listener and pass the fd to another process.
> Not a critical functionality at this point.

I'd prefer to keep the flag internal if you're convinced we need one - but
I'm not yet convinced we need even internal FAN_UNPRIVILEDGED flag because
I don't think this will end up being a yes/no thing. I imagine that
depending on exact process capabilities, different kinds of fanotify
functionality will be allowed as I outlined in 2). So we'll be checking
against current process capabilities at the time of action and not against
some internal fanotify flag...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
