Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57B37BE4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhELNfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 09:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:38918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhELNfY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 09:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B05AFAE27;
        Wed, 12 May 2021 13:34:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B9D91E0A4C; Wed, 12 May 2021 15:34:15 +0200 (CEST)
Date:   Wed, 12 May 2021 15:34:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210512133415.GC2734@quack2.suse.cz>
References: <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210510142107.GA24154@quack2.suse.cz>
 <CAOQ4uxhKk3oJdWF8YxYRPyomimg9xQaHnMo3ggALOhTuwWxYBw@mail.gmail.com>
 <20210512130705.cywde7v4z7ywjrag@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512130705.cywde7v4z7ywjrag@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 12-05-21 15:07:05, Christian Brauner wrote:
> On Mon, May 10, 2021 at 06:08:31PM +0300, Amir Goldstein wrote:
> > > > > OK, so this feature would effectively allow sb-wide watching of events that
> > > > > are generated from within the container (or its descendants). That sounds
> > > > > useful. Just one question: If there's some part of a filesystem, that is
> > > > > accesible by multiple containers (and thus multiple namespaces), or if
> > > > > there's some change done to the filesystem say by container management SW,
> > > > > then event for this change won't be visible inside the container (despite
> > > > > that the fs change itself will be visible).
> > > >
> > > > That is correct.
> > > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > > open and write to a file.
> > > >
> > > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > > >
> > > > I wonder if that is a problem that we need to fix...
> > >
> > > I assume you are speaking of the filesystem that is absorbing the changes?
> > > AFAIU usually you are not supposed to access that filesystem alone but
> > > always access it only through overlayfs and in that case you won't see the
> > > problem?
> > >
> > 
> > Yes I am talking about the "backend" store for overlayfs.
> > Normally, that would be a subtree where changes are not expected
> > except through overlayfs and indeed it is documented that:
> > "If the underlying filesystem is changed, the behavior of the overlay
> >  is undefined, though it will not result in a crash or deadlock."
> > Not reporting events falls well under "undefined".
> > 
> > But that is not the problem.
> > The problem is that if user A is watching a directory D for changes, then
> > an adversary user B which has read/write access to D can:
> > - Clone a userns wherein user B id is 0
> > - Mount a private overlayfs instance using D as upperdir
> > - Open file in D indirectly via private overlayfs and edit it
> > 
> > So it does not require any special privileges to circumvent generating
> > events. Unless I am missing something.
> 
> No, I think you're right. That should work. I don't think that's
> necessarily a problem though. It's a bit unexpected and slightly
> unpleasant but it's documented already and it's not a security issue
> afaict.

fanotify(7) is used in applications (such as virus scanners or anti-malware
products) where they expect to see all filesystem changes. There are
products which implement access mediation policy based on fanotify
permission events. So a way for unpriviledged application to escape
notification is a "security" issue (not a kernel one but it defeats
protections userspace implements).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
