Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8B4C8874
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiCAJr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiCAJrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:47:25 -0500
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE8FD60D9C;
        Tue,  1 Mar 2022 01:46:44 -0800 (PST)
Received: from dread.disaster.area (pa49-186-17-0.pa.vic.optusnet.com.au [49.186.17.0])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D359B10E1570;
        Tue,  1 Mar 2022 20:46:41 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nOz5c-000Bhm-DQ; Tue, 01 Mar 2022 20:46:40 +1100
Date:   Tue, 1 Mar 2022 20:46:40 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        containers@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] fs: report per-mount io stats
Message-ID: <20220301094640.GD3927073@dread.disaster.area>
References: <20220228113910.1727819-1-amir73il@gmail.com>
 <20220228113910.1727819-5-amir73il@gmail.com>
 <20220228211113.GB3927073@dread.disaster.area>
 <CAOQ4uxjPHxO+S3tOarO5w_rBwyFTgd7oMcC4f5xW7opCWb4LVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjPHxO+S3tOarO5w_rBwyFTgd7oMcC4f5xW7opCWb4LVQ@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=621deb83
        a=+dVDrTVfsjPpH/ci3UuFng==:117 a=+dVDrTVfsjPpH/ci3UuFng==:17
        a=kj9zAlcOel0A:10 a=o8Y5sQTvuykA:10 a=7-415B0cAAAA:8 a=pGLkceISAAAA:8
        a=gsa_uG_OR_wHGMIp19MA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:57:19PM +0200, Amir Goldstein wrote:
> On Mon, Feb 28, 2022 at 11:11 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 01:39:08PM +0200, Amir Goldstein wrote:
> > > Show optional collected per-mount io stats in /proc/<pid>/mountstats
> > > for filesystems that do not implement their own show_stats() method
> > > and opted-in to generic per-mount stats with FS_MOUNT_STATS flag.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >  fs/mount.h          |  1 +
> > >  fs/namespace.c      |  2 ++
> > >  fs/proc_namespace.c | 13 +++++++++++++
> > >  3 files changed, 16 insertions(+)
> > >
> > > diff --git a/fs/mount.h b/fs/mount.h
> > > index f98bf4cd5b1a..2ab6308af78b 100644
> > > --- a/fs/mount.h
> > > +++ b/fs/mount.h
> > > @@ -91,6 +91,7 @@ struct mount {
> > >       int mnt_id;                     /* mount identifier */
> > >       int mnt_group_id;               /* peer group identifier */
> > >       int mnt_expiry_mark;            /* true if marked for expiry */
> > > +     time64_t mnt_time;              /* time of mount */
> > >       struct hlist_head mnt_pins;
> > >       struct hlist_head mnt_stuck_children;
> > >  } __randomize_layout;
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index 3fb8f11a42a1..546f07ed44c5 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -220,6 +220,8 @@ static struct mount *alloc_vfsmnt(const char *name)
> > >               mnt->mnt_count = 1;
> > >               mnt->mnt_writers = 0;
> > >  #endif
> > > +             /* For proc/<pid>/mountstats */
> > > +             mnt->mnt_time = ktime_get_seconds();
> > >
> > >               INIT_HLIST_NODE(&mnt->mnt_hash);
> > >               INIT_LIST_HEAD(&mnt->mnt_child);
> > > diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
> > > index 49650e54d2f8..d744fb8543f5 100644
> > > --- a/fs/proc_namespace.c
> > > +++ b/fs/proc_namespace.c
> > > @@ -232,6 +232,19 @@ static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
> > >       if (sb->s_op->show_stats) {
> > >               seq_putc(m, ' ');
> > >               err = sb->s_op->show_stats(m, mnt_path.dentry);
> > > +     } else if (mnt_has_stats(mnt)) {
> > > +             /* Similar to /proc/<pid>/io */
> > > +             seq_printf(m, "\n"
> > > +                        "\ttimes: %lld %lld\n"
> > > +                        "\trchar: %lld\n"
> > > +                        "\twchar: %lld\n"
> > > +                        "\tsyscr: %lld\n"
> > > +                        "\tsyscw: %lld\n",
> > > +                        r->mnt_time, ktime_get_seconds(),
> > > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_RD),
> > > +                        mnt_iostats_counter_read(r, MNTIOS_CHARS_WR),
> > > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_RD),
> > > +                        mnt_iostats_counter_read(r, MNTIOS_SYSCALLS_WR));
> >
> > This doesn't scale as {cpus, mounts, counters, read frequency}
> > matrix explodes.  Please iterate the per-mount per cpu counters
> > once, adding up all counters in one pass to an array on stack, then
> > print them all from the array.
> 
> I am planning to move to per-sb iostats and was thinking of using
> an array of 4 struct percpu_counter. That will make this sort of iteration
> more challenging.

No, it would get rid of it entirely. percpu_counter_read_positive()
does not require any summing at all - that's a much better solution
than a hand rolled set of percpu counters. Please do this.

> Do you really think the read frequency of /proc/self/mountstats
> warrants such performance optimization?

We get bug reports every so often about the overhead of frequently
summing per-cpu stats on large systems. Nothing ratelimits or
restricts access to /proc/self/mountstats, so when you have a
thousand CPUs and a million monkeys...

Rule of thumb: don't do computationally expensive things to generate
data for globally accessible sysfs files.

> It's not like the case of the mighty struct xfsstats.
> It is only going to fold 4 per cpu iterations into 1.
> This doesn't look like a game changer to me.
> Am I missing something?

I'm just pointing out something we've had problems with in
the past and are trying to help you avoid making the same mistakes.
That's what reviewers are supposed to do, yes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
