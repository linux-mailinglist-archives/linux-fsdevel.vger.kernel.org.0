Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4751F95F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgFOMCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:02:18 -0400
Received: from outbound-smtp57.blacknight.com ([46.22.136.241]:34449 "EHLO
        outbound-smtp57.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729653AbgFOMCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:02:18 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id B2D75FAA0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 13:02:15 +0100 (IST)
Received: (qmail 4823 invoked from network); 15 Jun 2020 12:02:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Jun 2020 12:02:15 -0000
Date:   Mon, 15 Jun 2020 13:02:14 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200615120214.GE3183@techsingularity.net>
References: <20200612092603.GB3183@techsingularity.net>
 <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
 <20200612131854.GD3183@techsingularity.net>
 <CAOQ4uxghy5zOT6i=shZfFHsXOgPrd7-4iPkJBDcsHU6bUSFUFg@mail.gmail.com>
 <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhm+afWpnb4RFw8LkZ+ZJtnFxqR5HB8Uyj-c44CU9SSJg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 11:34:16PM +0300, Amir Goldstein wrote:
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
> 

Yes.

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

I'm not entirely convinced that an error should be forced. I accept that
you can set a watcher on /proc/XX/fd but do you actually receive any
notifications of activity on those inodes? When I tested, I found that any
watchers a pipe for example were not notified. This didn't surprise me as
such given that the path and inode itself were just a representation of
the underlying "real" inode and that the notifications did not propogate
from a pipe fd to the proc fd. However, I could have made a mistake in
my test case. Maybe they *could* be propagated but it does not appear
that anyone cares.

> So now the question is how do we identify/classify "these sort of
> inodes"? If they are no common well defining characteristics, we
> may need to blacklist pipes sockets and anon inodes explicitly
> with S_NONOTIFY.
> 

I'm not sure we need to go that far either. It appears that some proc
files can receive notifications that may or may not have a useful meaning
to userspace so blocking them all may be problematic. If I'm right in that
fd inodes already have no meaningful notifications, it does not hurt to
ignore fsnotify for pseudo inodes as userspace cannot tell the difference.

-- 
Mel Gorman
SUSE Labs
