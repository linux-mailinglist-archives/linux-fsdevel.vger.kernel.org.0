Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FE3792B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhEJPaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 11:30:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbhEJP3F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 11:29:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0200FAD06;
        Mon, 10 May 2021 15:27:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CC7941F2C5D; Mon, 10 May 2021 17:27:58 +0200 (CEST)
Date:   Mon, 10 May 2021 17:27:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
Message-ID: <20210510152758.GC24154@quack2.suse.cz>
References: <20201126111725.GD422@quack2.suse.cz>
 <CAOQ4uxgt1Cx5jx3L6iaDvbzCWPv=fcMgLaa9ODkiu9h718MkwQ@mail.gmail.com>
 <20210503165315.GE2994@quack2.suse.cz>
 <CAOQ4uxgy0DUEUo810m=bnLuHNbs60FLFPUUw8PLq9jJ8VTFD8g@mail.gmail.com>
 <20210505122815.GD29867@quack2.suse.cz>
 <20210505142405.vx2wbtadozlrg25b@wittgenstein>
 <20210510101305.GC11100@quack2.suse.cz>
 <CAOQ4uxjqjB2pCoyLzreMziJcE5nYjgdhcAsDWDmu_5-g5AKM3w@mail.gmail.com>
 <20210510142107.GA24154@quack2.suse.cz>
 <CAOQ4uxhKk3oJdWF8YxYRPyomimg9xQaHnMo3ggALOhTuwWxYBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhKk3oJdWF8YxYRPyomimg9xQaHnMo3ggALOhTuwWxYBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 10-05-21 18:08:31, Amir Goldstein wrote:
> > > > OK, so this feature would effectively allow sb-wide watching of events that
> > > > are generated from within the container (or its descendants). That sounds
> > > > useful. Just one question: If there's some part of a filesystem, that is
> > > > accesible by multiple containers (and thus multiple namespaces), or if
> > > > there's some change done to the filesystem say by container management SW,
> > > > then event for this change won't be visible inside the container (despite
> > > > that the fs change itself will be visible).
> > >
> > > That is correct.
> > > FYI, a privileged user can already mount an overlayfs in order to indirectly
> > > open and write to a file.
> > >
> > > Because overlayfs opens the underlying file FMODE_NONOTIFY this will
> > > hide OPEN/ACCESS/MODIFY/CLOSE events also for inode/sb marks.
> > > Since 459c7c565ac3 ("ovl: unprivieged mounts"), so can unprivileged users.
> > >
> > > I wonder if that is a problem that we need to fix...
> >
> > I assume you are speaking of the filesystem that is absorbing the changes?
> > AFAIU usually you are not supposed to access that filesystem alone but
> > always access it only through overlayfs and in that case you won't see the
> > problem?
> >
> 
> Yes I am talking about the "backend" store for overlayfs.
> Normally, that would be a subtree where changes are not expected
> except through overlayfs and indeed it is documented that:
> "If the underlying filesystem is changed, the behavior of the overlay
>  is undefined, though it will not result in a crash or deadlock."
> Not reporting events falls well under "undefined".
> 
> But that is not the problem.
> The problem is that if user A is watching a directory D for changes, then
> an adversary user B which has read/write access to D can:
> - Clone a userns wherein user B id is 0
> - Mount a private overlayfs instance using D as upperdir
> - Open file in D indirectly via private overlayfs and edit it
> 
> So it does not require any special privileges to circumvent generating
> events. Unless I am missing something.

I see, right. I agree that is unfortunate especially for stuff like audit
or fanotify permission events so we should fix that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
