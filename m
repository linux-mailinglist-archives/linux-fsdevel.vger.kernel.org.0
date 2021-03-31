Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8D3500BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhCaMyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 08:54:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235414AbhCaMyP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF4E8B1F3;
        Wed, 31 Mar 2021 12:54:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3FC2C1E4415; Wed, 31 Mar 2021 14:54:12 +0200 (CEST)
Date:   Wed, 31 Mar 2021 14:54:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210331125412.GI30749@quack2.suse.cz>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
 <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-03-21 14:29:04, Amir Goldstein wrote:
> On Wed, Mar 31, 2021 at 12:46 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Tue, Mar 30, 2021 at 05:56:25PM +0300, Amir Goldstein wrote:
> > > > > > My example probably would be something like:
> > > > > >
> > > > > > mount -t ext4 /dev/sdb /A
> > > > > >
> > > > > > 1. FAN_MARK_MOUNT(/A)
> > > > > >
> > > > > > mount --bind /A /B
> > > > > >
> > > > > > 2. FAN_MARK_MOUNT(/B)
> > > > > >
> > > > > > mount -t ecryptfs /B /C
> > > > > >
> > > > > > 3. FAN_MARK_MOUNT(/C)
> > > > > >
> > > > > > let's say I now do
> > > > > >
> > > > > > touch /C/bla
> > > > > >
> > > > > > I may be way off here but intuitively it seems both 1. and 2. should get
> > > > > > a creation event but not 3., right?
> > > > > >
> > > > >
> > > > > Why not 3?
> > > > > You explicitly set a mark on /C requesting to be notified when
> > > > > objects are created via /C.
> > > >
> > > > Sorry, that was a typo. I meant to write, both 2. and 3. should get a
> > > > creation event but not 1.
> > > >
> > > > >
> > > > > > But with your proposal would both 1. and 2. still get a creation event?
> > > > > >
> > > >
> > > > Same obvious typo. The correct question would be: with your proposal do
> > > > 2. and 3. both get an event?
> > > >
> > > > Because it feels like they both should since /C is mounted on top of /B
> > > > and ecryptfs acts as a shim. Both FAN_MARK_MOUNT(/B) and
> > > > FAN_MARK_MOUNT(/C) should get a creation event after all both will have
> > > > mnt->mnt_fsnotify_marks set.
> > > >
> > >
> > > Right.
> > >
> > > There are two ways to address this inconsistency:
> > > 1. Change internal callers of vfs_ helpers to use a private mount,
> > >     as you yourself suggested for ecryptfs and cachefiles
> >
> > I feel like this is he correct thing to do independently of the fanotify
> > considerations. I think I'll send an RFC for this today or later this
> > week.
> >
> > > 2. Add fsnotify_path_ hooks at caller site - that would be the
> > >     correct thing to do for nfsd IMO
> >
> > I do not have an informed opinion yet on nfsd so I simply need to trust
> > you here. :)
> >
> 
> As long as "exp_export: export of idmapped mounts not yet supported.\n"
> I don't think it matters much.
> It feels like adding idmapped mounts to nfsd is on your roadmap.
> When you get to that we can discuss adding fsnotify path hooks to nfsd
> if Jan agrees to the fsnotify path hooks concept.

I was looking at the patch and thinking about it for a few days already. I
think that generating fsnotify event later (higher up the stack where we
have mount information) is fine and a neat idea. I just dislike the hackery
with dentry flags. Also I'm somewhat uneasy that it is random (from
userspace POV) when path event is generated and when not (at least that's
my impression from the patch - maybe I'm wrong). How difficult would it be
to get rid of it? I mean what if we just moved say fsnotify_create() call
wholly up the stack? It would mean more explicit calls to fsnotify_create()
from filesystems - as far as I'm looking nfsd, overlayfs, cachefiles,
ecryptfs. But that would seem to be manageable.  Also, to maintain sanity,
we would probably have to lift generation of all directory events like
that. That would be already notable churn but maybe doable... I know you've
been looking at similar things in the past so if you are aware why this
won't fly, please tell me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
