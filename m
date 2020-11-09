Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466C22AB588
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 11:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgKIKyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 05:54:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:45798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgKIKyd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:54:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56D18AD77;
        Mon,  9 Nov 2020 10:54:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D1E9D1E1311; Mon,  9 Nov 2020 11:54:30 +0100 (CET)
Date:   Mon, 9 Nov 2020 11:54:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Subject: Re: [PATCH v4] inotify: Increase default inotify.max_user_watches
 limit to 1048576
Message-ID: <20201109105430.GC21934@quack2.suse.cz>
References: <20201109035931.4740-1-longman@redhat.com>
 <CAOQ4uxj26Pb_zyErgnpmKeMThrxnRuO5PAF=igt9mvr_80BkCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj26Pb_zyErgnpmKeMThrxnRuO5PAF=igt9mvr_80BkCQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-11-20 06:58:52, Amir Goldstein wrote:
> On Mon, Nov 9, 2020 at 6:00 AM Waiman Long <longman@redhat.com> wrote:
> >
> > The default value of inotify.max_user_watches sysctl parameter was set
> > to 8192 since the introduction of the inotify feature in 2005 by
> > commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> > small for many modern usage. As a result, users have to explicitly set
> > it to a larger value to make it work.
> >
> > After some searching around the web, these are the
> > inotify.max_user_watches values used by some projects:
> >  - vscode:  524288
> >  - dropbox support: 100000
> >  - users on stackexchange: 12228
> >  - lsyncd user: 2000000
> >  - code42 support: 1048576
> >  - monodevelop: 16384
> >  - tectonic: 524288
> >  - openshift origin: 65536
> >
> > Each watch point adds an inotify_inode_mark structure to an inode to
> > be watched. It also pins the watched inode.
> >
> > Modeled after the epoll.max_user_watches behavior to adjust the default
> > value according to the amount of addressable memory available, make
> > inotify.max_user_watches behave in a similar way to make it use no more
> > than 1% of addressable memory within the range [8192, 1048576].
> >
> > For 64-bit archs, inotify_inode_mark plus 2 vfs inode have a size that
> > is a bit over 1 kbytes (1284 bytes with my x86-64 config).
> 
> The sentence above seems out of context (where did the 2 vfs inodes
> come from?). Perhaps the comment in the patch should go here above.
> 
> > That means
> > a system with 128GB or more memory will likely have the maximum value
> > of 1048576 for inotify.max_user_watches. This default should be big
> > enough for most use cases.
> >
> > [v3: increase inotify watch cost as suggested by Amir and Honza]
> 
> That patch change log usually doesn't belong in the git commit
> because it adds little value in git log perspective.
> 
> If you think that the development process is relevant to understanding
> the patch (like the discussion leading to the formula of the cost)
> then a Link: to the discussion on lore.kernel.org would serve the
> commit better.
> 
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> Apart from this minor nits,
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks for review Amir! I'll fix these nits up and apply the patch to my
tree.

								Honza

> >  fs/notify/inotify/inotify_user.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index 186722ba3894..24d17028375e 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -37,6 +37,15 @@
> >
> >  #include <asm/ioctls.h>
> >
> > +/*
> > + * An inotify watch requires allocating an inotify_inode_mark structure as
> > + * well as pinning the watched inode. Doubling the size of a VFS inode
> > + * should be more than enough to cover the additional filesystem inode
> > + * size increase.
> > + */
> > +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> > +                                2 * sizeof(struct inode))
> > +
> >  /* configurable via /proc/sys/fs/inotify/ */
> >  static int inotify_max_queued_events __read_mostly;
> >
> > @@ -801,6 +810,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
> >   */
> >  static int __init inotify_user_setup(void)
> >  {
> > +       unsigned long watches_max;
> > +       struct sysinfo si;
> > +
> > +       si_meminfo(&si);
> > +       /*
> > +        * Allow up to 1% of addressable memory to be allocated for inotify
> > +        * watches (per user) limited to the range [8192, 1048576].
> > +        */
> > +       watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
> > +                       INOTIFY_WATCH_COST;
> > +       watches_max = clamp(watches_max, 8192UL, 1048576UL);
> > +
> >         BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
> >         BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
> >         BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
> > @@ -827,7 +848,7 @@ static int __init inotify_user_setup(void)
> >
> >         inotify_max_queued_events = 16384;
> >         init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
> > -       init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
> > +       init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
> >
> >         return 0;
> >  }
> > --
> > 2.18.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
