Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3031D354EBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 10:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhDFIgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 04:36:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhDFIgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45AC4B0C6;
        Tue,  6 Apr 2021 08:35:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F21341F2B70; Tue,  6 Apr 2021 10:35:56 +0200 (CEST)
Date:   Tue, 6 Apr 2021 10:35:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <20210406083556.GA19407@quack2.suse.cz>
References: <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-04-21 17:18:05, Amir Goldstein wrote:
> > > > > Also I'm somewhat uneasy that it is random (from
> > > > > userspace POV) when path event is generated and when not (at least that's
> > > > > my impression from the patch - maybe I'm wrong). How difficult would it be
> > > > > to get rid of it? I mean what if we just moved say fsnotify_create() call
> > > > > wholly up the stack? It would mean more explicit calls to fsnotify_create()
> > > > > from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
> > > > > ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,
> > > >
> > > > 1. I don't think we can do that for all the fsnotify_create() hooks, such as
> > > >     debugfs for example
> > > > 2. It is useless to pass the mount from overlayfs to fsnotify, its a private
> > > >     mount that users cannot set a mark on anyway and Christian has
> > > >     promised to propose the same change for cachefiles and ecryptfs,
> > > >     so I think it's not worth the churn in those call sites
> > > > 3. I am uneasy with removing the fsnotify hooks from vfs helpers and
> > > >     trusting that new callers of vfs_create() will remember to add the high
> > > >     level hooks, so I prefer the existing behavior remains for such callers
> > > >
> > >
> > > So I read your proposal the wrong way.
> > > You meant move fsnotify_create() up *without* passing mount context
> > > from overlayfs and friends.
> >
> > Well, I was thinking that we could find appropriate mount context for
> > overlayfs or ecryptfs (which just shows how little I know about these
> > filesystems ;) I didn't think of e.g. debugfs. Anyway, if we can make
> > mountpoint marks work for directory events at least for most filesystems, I
> > think that is OK as well. However it would be then needed to detect whether
> > a given filesystem actually supports mount marks for dir events and if not,
> > report error from fanotify_mark() instead of silently not generating
> > events.
> >
> 
> It's not about "filesystems that support mount marks".
> mount marks will work perfectly well on overlayfs.
> 
> The thing is if you place a mount mark on the underlying store of
> overlayfs (say xfs) and then files are created/deleted by the
> overlayfs driver (in xfs) you wont get any events, because
> overlayfs uses a private mount clone to perform underlying operations.

OK, understood.

> So while we CAN get the overlayfs underlying layer mount context
> it is irrelevant because no user can setup a mount mark on that
> private mount, so no need to bother calling the path hooks.
> 
> This is not the case with nfsd IMO.
> With nfsd, when "exporting" a path to clients, nfsd is really exporting
> a specific mount (and keeping that mount busy too).
> It can even export whole mount topologies.
> 
> But then again, getting the mount context in every nfsd operation
> is easy, there is an export context to client requests and the export
> context has the exported path.
> 
> Therefore, nfsd is my only user using the vfs helpers that is expected
> to call the fsnotify path hooks (other than syscalls).

I agree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
