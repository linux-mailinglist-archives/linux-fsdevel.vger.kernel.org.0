Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308451F78A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLNS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 09:18:58 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:39751 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgFLNS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:18:58 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 2AF1E1C3949
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 14:18:56 +0100 (IST)
Received: (qmail 11198 invoked from network); 12 Jun 2020 13:18:56 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jun 2020 13:18:55 -0000
Date:   Fri, 12 Jun 2020 14:18:54 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: Do not check if there is a fsnotify watcher on
 pseudo inodes
Message-ID: <20200612131854.GD3183@techsingularity.net>
References: <20200612092603.GB3183@techsingularity.net>
 <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxikbJ19npQFWzGm6xnqXm0W8pV3NOWE0ZxS9p_G2A39Aw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:52:28PM +0300, Amir Goldstein wrote:
> On Fri, Jun 12, 2020 at 12:26 PM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > The kernel uses internal mounts for a number of purposes including pipes.
> > On every vfs_write regardless of filesystem, fsnotify_modify() is called
> > to notify of any changes which incurs a small amount of overhead in fsnotify
> > even when there are no watchers.
> >
> > A patch is pending that reduces, but does not eliminte, the overhead
> > of fsnotify but for the internal mounts, even the small overhead is
> > unnecessary. The user API is based on the pathname and a dirfd and proc
> > is the only visible path for inodes on an internal mount. Proc does not
> > have the same pathname as the internal entry so even if fatrace is used
> > on /proc, no events trigger for the /proc/X/fd/ files.
> >
> 
> This looks like a good direction and I was going to suggest that as well.
> However, I am confused by the use of terminology "internal mount".
> The patch does not do anything dealing with "internal mount".

I was referring to users of kern_mount.

> If alloc_file_pseudo() is only called for filesystems mounted as
> internal mounts,

I believe this is the case and I did not find a counter-example.  The
changelog that introduced the helper is not explicit but it was created
in the context of converting a number of internal mounts like pipes,
anon inodes to a common helper. If I'm wrong, Al will likely point it out.

> please include this analysis in commit message.
> In any case, not every file of internal mount is allocated with
> alloc_file_pseudo(),
> right?

Correct. It is not required and there is at least one counter example
in arch/ia64/kernel/perfmon.c but I don't think that is particularly
important, I don't think anyone is kept awake at night worrying about
small performance overhead on Itanium.

> So maybe it would be better to list all users of alloc_file_pseudo()
> and say that they all should be opted out of fsnotify, without mentioning
> "internal mount"?
> 

The users are DMA buffers, CXL, aio, anon inodes, hugetlbfs, anonymous
pipes, shmem and sockets although not all of them necessary end up using
a VFS operation that triggers fsnotify.  Either way, I don't think it
makes sense (or even possible) to watch any of those with fanotify so
setting the flag seems reasonable.

I updated the changelog and maybe this is clearer.

---8<---
fs: Do not check if there is a fsnotify watcher on pseudo inodes

The kernel can create invisible internal mounts for a number of purposes
including pipes via kern_mount. For pipes, every vfs_write regardless of
filesystem, fsnotify_modify() is called to notify of any changes which
incurs a small amount of overhead in fsnotify even when there are no
watchers. It can also trigger for reads and readv and writev, it was
simply vfs_write() that was noticed first.

A patch is pending that reduces, but does not eliminte, the overhead
of fsnotify but for the internal mounts, even the small overhead is
unnecessary. The user API for fanotify is based on the pathname and a dirfd
and proc are the only visible representation of an internal mount. Proc
does not have the same pathname as the internal entry and the proc inode
is not the same as the internal inode so even if fatrace is used on /proc,
no events trigger for the /proc/X/fd/ files.

This patch changes alloc_file_pseudo() automatically opts out of fsnotify
by setting FMODE_NONOTIFY flag so that no check is made for fsnotify
watchers on internal mounts. It is not mandated that mounts created
with kern_mount use alloc_file_pseudo but a number of important ones
do including aio, anon inodes, hugetlbfs, anonymous pipes, shmem and
sockets. There does not appear to be any way to register watchers on such
inodes or a case where it would even make sense so opting out by default
seems reasonable.

The test motivating this was "perf bench sched messaging --pipe". On
a single-socket machine using threads the difference of the patch was
as follows.

                              5.7.0                  5.7.0
                            vanilla        nofsnotify-v1r1
Amean     1       1.3837 (   0.00%)      1.3547 (   2.10%)
Amean     3       3.7360 (   0.00%)      3.6543 (   2.19%)
Amean     5       5.8130 (   0.00%)      5.7233 *   1.54%*
Amean     7       8.1490 (   0.00%)      7.9730 *   2.16%*
Amean     12     14.6843 (   0.00%)     14.1820 (   3.42%)
Amean     18     21.8840 (   0.00%)     21.7460 (   0.63%)
Amean     24     28.8697 (   0.00%)     29.1680 (  -1.03%)
Amean     30     36.0787 (   0.00%)     35.2640 *   2.26%*
Amean     32     38.0527 (   0.00%)     38.1223 (  -0.18%)

The difference is small but in some cases it's outside the noise so
while marginal, there is still some small benefit to ignoring fsnotify
for internal mounts in some cases.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
