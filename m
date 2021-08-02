Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC9C3DD5B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbhHBMel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 08:34:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhHBMek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:34:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6674421DAF;
        Mon,  2 Aug 2021 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627907670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JwBpQrhWZhrIjYV1ocSnEmpFvTTOsNISW+USXEtBBw=;
        b=K3CYFbEgNe5AtnzuNr99KwUt23FUdVOSSRhXiF5TEYfwCsdmWCnDTeRGE67VjjrRYANCEi
        cYGkfhUV7wko5xq7cP6qVbRQQFletnbaJC5+hkTDZXKmd8UyeVqzhboTyU8siZ9EaY9Tsz
        a/2Ko1//tPKNpxMn6Ls0+3PGYIOGxBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627907670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1JwBpQrhWZhrIjYV1ocSnEmpFvTTOsNISW+USXEtBBw=;
        b=VWW3ePffNfi3S1WE3qT81DRkafm3yZ0ii2iV3TRux/fzWSbHrLW6MKZ2vbr5j+rX8z5abZ
        rP/AmP0SjFw4wpAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 5614CA3BB5;
        Mon,  2 Aug 2021 12:34:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2DAED1E0BBB; Mon,  2 Aug 2021 14:34:28 +0200 (CEST)
Date:   Mon, 2 Aug 2021 14:34:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
Message-ID: <20210802123428.GB28745@quack2.suse.cz>
References: <cover.1626845287.git.repnop@google.com>
 <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com>
 <20210729133953.GL29619@quack2.suse.cz>
 <CAOQ4uxi70KXGwpcBnRiyPXZCjFQfifaWaYVSDK2chaaZSyXXhQ@mail.gmail.com>
 <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgFLqO5_vPTb5hkfO1Fb27H-h0TqHsB6owZxrZw4YLoEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 30-07-21 08:03:01, Amir Goldstein wrote:
> On Thu, Jul 29, 2021 at 6:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Thu, Jul 29, 2021 at 4:39 PM Jan Kara <jack@suse.cz> wrote:
> > > Well, but pidfd also makes sure that /proc/<pid>/ keeps belonging to the
> > > same process while you read various data from it. And you cannot achieve
> > > that with pid+generation thing you've suggested. Plus the additional
> > > concept and its complexity is non-trivial So I tend to agree with
> > > Christian that we really want to return pidfd.
> > >
> > > Given returning pidfd is CAP_SYS_ADMIN priviledged operation I'm undecided
> > > whether it is worth the trouble to come up with some other mechanism how to
> > > return pidfd with the event. We could return some cookie which could be
> > > then (by some ioctl or so) either transformed into real pidfd or released
> > > (so that we can release pid handle in the kernel) but it looks ugly and
> > > complicates things for everybody without bringing significant security
> > > improvement (we already can pass fd with the event). So I'm pondering
> > > whether there's some other way how we could make the interface safer - e.g.
> > > so that the process receiving the event (not the one creating the group)
> > > would also need to opt in for getting fds created in its file table.
> > >
> > > But so far nothing bright has come to my mind. :-|
> > >
> >
> > There is a way, it is not bright, but it is pretty simple -
> > store an optional pid in group->fanotify_data.fd_reader.
> >
> > With flag FAN_REPORT_PIDFD, both pidfd and event->fd reporting
> > will be disabled to any process other than fd_reader.
> > Without FAN_REPORT_PIDFD, event->fd reporting will be disabled
> > if fd_reaader is set to a process other than the reader.
> >
> > A process can call ioctl START_FD_READER to set fd_reader to itself.
> > With FAN_REPORT_PIDFD, if reaader_fd is NULL and the reader
> > process has CAP_SYS_ADMIN, read() sets fd_reader to itself.
> >
> > Permission wise, START_FD_READER is allowed with
> > CAP_SYS_ADMIN or if fd_reader is not owned by another process.
> > We may consider YIELD_FD_READER ioctl if needed.
> >
> > I think that this is a pretty cheap price for implementation
> > and maybe acceptable overhead for complicating the API?
> > Note that without passing fd, there is no need for any ioctl.
> >
> > An added security benefit is that the ioctl adds is a way for the
> > caller of fanotify_init() to make sure that even if the fanotify_fd is
> > leaked, that event->fd will not be leaked, regardless of flag
> > FAN_REPORT_PIDFD.
> >
> > So the START_FD_READER ioctl feature could be implemented
> > and documented first.
> > And then FAN_REPORT_PIDFD could use the feature with a
> > very minor API difference:
> > - Without the flag, other processes can read fds by default and
> >   group initiator can opt-out
> > - With the flag, other processes cannot read fds by default and
> >   need to opt-in
> 
> Or maybe something even simpler... fanotify_init() flag
> FAN_PRIVATE (or FAN_PROTECTED) that limits event reading
> to the initiator process (not only fd reading).
> 
> FAN_REPORT_PIDFD requires FAN_PRIVATE.
> If we do not know there is a use case for passing fanotify_fd
> that reports pidfds to another process why implement the ioctl.
> We can always implement it later if the need arises.
> If we contemplate this future change, though, maybe the name
> FAN_PROTECTED is better to start with.

Good ideas. I think we are fine with returning pidfd only to the process
creating the fanotify group. Later we can add an ioctl which would indicate
that the process is also prepared to have fds created in its file table.
But I have still some open questions:
Do we want threads of the same process to still be able to receive fds?
Also pids can be recycled so they are probably not completely reliable
identifiers? What if someone wants to process events from fanotify group by
multiple processes / threads (fd can be inherited also through fork(2)...)?

I'm currently undecided whether explicit FAN_PROTECTED flag (and impact on
receiving / not receiving whole event) makes this better.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
