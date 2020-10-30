Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075622A0338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 11:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgJ3Ks0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 06:48:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:45280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJ3Ks0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:48:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 25273AB0E;
        Fri, 30 Oct 2020 10:48:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B55571E12D9; Fri, 30 Oct 2020 11:48:23 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:48:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Waiman Long <longman@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Subject: Re: [PATCH v2] inotify: Increase default inotify.max_user_watches
 limit to 1048576
Message-ID: <20201030104823.GA19757@quack2.suse.cz>
References: <20201029154535.2074-1-longman@redhat.com>
 <CAOQ4uxjT8rWLr1yCBPGkhJ7Rr6n3+FA7a0GmZaMBHMzk9t1Sag@mail.gmail.com>
 <ccec54cd-cbb5-2808-3800-890cda208967@redhat.com>
 <CAOQ4uximGK1DnM7fYabChp-8pNqt3cSHeDWZYNKSwr6qSnxpug@mail.gmail.com>
 <4695fee5-3446-7f5b-ae89-dc48d431a8fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4695fee5-3446-7f5b-ae89-dc48d431a8fe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-10-20 15:04:56, Waiman Long wrote:
> On 10/29/20 2:46 PM, Amir Goldstein wrote:
> > On Thu, Oct 29, 2020 at 8:05 PM Waiman Long <longman@redhat.com> wrote:
> > > On 10/29/20 1:27 PM, Amir Goldstein wrote:
> > > > On Thu, Oct 29, 2020 at 5:46 PM Waiman Long <longman@redhat.com> wrote:
> > > > > The default value of inotify.max_user_watches sysctl parameter was set
> > > > > to 8192 since the introduction of the inotify feature in 2005 by
> > > > > commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> > > > > small for many modern usage. As a result, users have to explicitly set
> > > > > it to a larger value to make it work.
> > > > > 
> > > > > After some searching around the web, these are the
> > > > > inotify.max_user_watches values used by some projects:
> > > > >    - vscode:  524288
> > > > >    - dropbox support: 100000
> > > > >    - users on stackexchange: 12228
> > > > >    - lsyncd user: 2000000
> > > > >    - code42 support: 1048576
> > > > >    - monodevelop: 16384
> > > > >    - tectonic: 524288
> > > > >    - openshift origin: 65536
> > > > > 
> > > > > Each watch point adds an inotify_inode_mark structure to an inode to
> > > > > be watched. It also pins the watched inode as well as an inotify fdinfo
> > > > > procfs file.
> > > > > 
> > > > > Modeled after the epoll.max_user_watches behavior to adjust the default
> > > > > value according to the amount of addressable memory available, make
> > > > > inotify.max_user_watches behave in a similar way to make it use no more
> > > > > than 1% of addressable memory within the range [8192, 1048576].
> > > > > 
> > > > > For 64-bit archs, inotify_inode_mark plus 2 inode have a size close
> > > > > to 2 kbytes. That means a system with 196GB or more memory should have
> > > > > the maximum value of 1048576 for inotify.max_user_watches. This default
> > > > > should be big enough for most use cases.
> > > > > 
> > > > > With my x86-64 config, the size of xfs_inode, proc_inode and
> > > > > inotify_inode_mark is 1680 bytes. The estimated INOTIFY_WATCH_COST is
> > > > > 1760 bytes.
> > > > > 
> > > > > [v2: increase inotify watch cost as suggested by Amir and Honza]
> > > > > 
> > > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > > ---
> > > > >    fs/notify/inotify/inotify_user.c | 24 +++++++++++++++++++++++-
> > > > >    1 file changed, 23 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > > > > index 186722ba3894..37d9f09c226f 100644
> > > > > --- a/fs/notify/inotify/inotify_user.c
> > > > > +++ b/fs/notify/inotify/inotify_user.c
> > > > > @@ -37,6 +37,16 @@
> > > > > 
> > > > >    #include <asm/ioctls.h>
> > > > > 
> > > > > +/*
> > > > > + * An inotify watch requires allocating an inotify_inode_mark structure as
> > > > > + * well as pinning the watched inode and adding inotify fdinfo procfs file.
> > > > Maybe you misunderstood me.
> > > > There is no procfs file per watch.
> > > > There is a procfs file per inotify_init() fd.
> > > > The fdinfo of that procfile lists all the watches of that inotify instance.
> > > Thanks for the clarification. Yes, I probably had misunderstood you
> > > because of the 2 * sizeof(inode) figure you provided.
> > > > > + * The increase in size of a filesystem inode versus a VFS inode varies
> > > > > + * depending on the filesystem. An extra 512 bytes is added as rough
> > > > > + * estimate of the additional filesystem inode cost.
> > > > > + */
> > > > > +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> > > > > +                                2 * sizeof(struct inode) + 512)
> > > > > +
> > > > I would consider going with double the sizeof inode as rough approximation for
> > > > filesystem inode size.
> > > > 
> > > > It is a bit less arbitrary than 512 and it has some rationale behind it -
> > > > Some kernel config options will grow struct inode (debug, smp)
> > > > The same config options may also grow the filesystem part of the inode.
> > > > 
> > > > And this approximation can be pretty accurate at times.
> > > > For example, on Ubuntu 18.04 kernel 5.4.0:
> > > > inode_cache        608
> > > > nfs_inode_cache      1088
> > > > btrfs_inode            1168
> > > > xfs_inode              1024
> > > > ext4_inode_cache   1096
> > > Just to clarify, is your original 2 * sizeof(struct inode) figure
> > > include the filesystem inode overhead or there is an additional inode
> > > somewhere that I needs to go to 4 * sizeof(struct inode)?
> > No additional inode.
> > 
> > #define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> >                                                        2 * sizeof(struct inode))
> > 
> > Not sure if the inotify_inode_mark part matters, but it doesn't hurt.
> > Do note that Jan had a different proposal for fs inode size estimation (1K).
> > I have no objection to this estimation if Jan insists.
> > 
> > Thanks,
> > Amir.
> > 
> Thanks for the confirmation. 2*sizeof(struct inode) is more than 1k. Besides
> with debugging turned on, the size will increase more. So that figure is
> good enough.

Yeah, the 2*sizeof(struct inode) is fine by me as well. Please don't forget
to update the comment explaining INOTIFY_WATCH_COST. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
