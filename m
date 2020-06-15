Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C33A1F9116
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFOIMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 04:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:55830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgFOIMG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:12:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33E34AA7C;
        Mon, 15 Jun 2020 08:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCD021E1289; Mon, 15 Jun 2020 10:12:02 +0200 (CEST)
Date:   Mon, 15 Jun 2020 10:12:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200615081202.GE9449@quack2.suse.cz>
References: <20200612092603.GB3183@techsingularity.net>
 <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
 <20200612131854.GD3183@techsingularity.net>
 <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
 <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-06-20 23:34:16, Amir Goldstein wrote:
> > > > So maybe it would be better to list all users of alloc_file_pseudo()
> > > > and say that they all should be opted out of fsnotify, without mentioning
> > > > "internal mount"?
> > > >
> > >
> > > The users are DMA buffers, CXL, aio, anon inodes, hugetlbfs, anonymous
> > > pipes, shmem and sockets although not all of them necessary end up using
> > > a VFS operation that triggers fsnotify.  Either way, I don't think it
> > > makes sense (or even possible) to watch any of those with fanotify so
> > > setting the flag seems reasonable.
> > >
> >
> > I also think this seems reasonable, but the more accurate reason IMO
> > is found in the comment for d_alloc_pseudo():
> > "allocate a dentry (for lookup-less filesystems)..."
> >
> > > I updated the changelog and maybe this is clearer.
> >
> > I still find the use of "internal mount" terminology too vague.
> > "lookup-less filesystems" would have been more accurate,
> 
> Only it is not really accurate for shmfs anf hugetlbfs, which are
> not lookup-less, they just hand out un-lookable inodes.

OK, but I still think we are safe setting FMODE_NONOTIFY in
alloc_file_pseudo() and that covers all the cases we care about. Or did I
misunderstand something in the discussion? I can see e.g.
__shmem_file_setup() uses alloc_file_pseudo() but again that seems to be
used only for inodes without a path and the comment before d_alloc_pseudo()
pretty clearly states this should be the case.

So is the dispute here really only about how to call files using
d_alloc_pseudo()?

> > because as you correctly point out, the user API to set a watch
> > requires that the marked object is looked up in the filesystem.
> >
> > There are also some kernel internal users that set watches
> > like audit and nfsd, but I think they are also only interested in
> > inodes that have a path at the time that the mark is setup.
> >
> 
> FWIW I verified that watches can be set on anonymous pipes
> via /proc/XX/fd, so if we are going to apply this patch, I think it
> should be accompanied with a complimentary patch that forbids
> setting up a mark on these sort of inodes. If someone out there
> is doing this, at least they would get a loud message that something
> has changed instead of silently dropping fsnotify events.
> 
> So now the question is how do we identify/classify "these sort of
> inodes"? If they are no common well defining characteristics, we
> may need to blacklist pipes sockets and anon inodes explicitly
> with S_NONOTIFY.

We already do have FS_DISALLOW_NOTIFY_PERM in file_system_type->fs_flags so
adding FS_DISALLOW_NOTIFY would be natural if there is a need for this.

I don't think using fsnotify on pipe inodes is sane in any way. You'd
possibly only get the MODIFY or ACCESS events and even those would not be
quite reliable because with pipes stuff like splicing etc. is much more
common and that currently completely bypasses fsnotify subsystem. So
overall I'm fine with completely ignoring fsnotify on such inodes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
