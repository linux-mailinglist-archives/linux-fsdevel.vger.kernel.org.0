Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC9374FA99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGKWE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 18:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGKWEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:04:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5D41FD7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 15:04:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so64785405e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 15:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689113068; x=1691705068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnXz+JH4HK6shxsT6hMXF22vBPnGJrvowAA0vrPIvAk=;
        b=jpwjk9ihfrcHlWGR7TB9P422O2z1rrnKg8KGhTfka9gqBGAvETQlYnuhgpxW/cuG3I
         ABkkLdN/e5cg4s3cFbY5GI5nrEiNDtT6gKhN97MQBqAz0ghLvwxE3L+6J22RzWKavh69
         ZWk9DztJZ2z5PzZRgIQ2rRNKXF2FY4ipnPxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113068; x=1691705068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnXz+JH4HK6shxsT6hMXF22vBPnGJrvowAA0vrPIvAk=;
        b=D+J+x5XcHgQMLjblx0PEwpR7rf5TOwYrwbmv0scbXXzPq3mShZQ3rCVE4lxRKEZZxs
         pI7nRHJ5j4g0qrJ3ofkdZsUZUDWyXAbQwM7p+eIymUN15dOXEmPGCnRsGzsPO7Nh3nQ2
         AXDO+VvTq4GijG64EAW+n7egU1ljwtb3IeLJ/94l7JpD8lYJaiBSD7XtODPjAnr9HVy0
         s7BwXXkHTAPVIXFGughNgbtYyxhO4OuhzXOBE/sOW50cmAb0aPUHPI6mun50l5WFkg2t
         BdPP4IE5w91B5aEQ8I7IT87/zJYBsA1Zjyj9TAvCb4bRMXJp+anKJWIGyN/1nhj9LKuR
         nT4A==
X-Gm-Message-State: ABy/qLYhKvULG6/3UlHkWJDOwy+38ucHFSzYJTe7YoAb5JAWK7LSw3U+
        WCIzAdntGYs43SszM7OtjL/WMJGXJlh+ow5JKFzrCQ==
X-Google-Smtp-Source: APBJJlGCcJf6koHlqM4GjBxclHhjzIX0zI3dWrWgggzlqpx4CZDs/jOa+PqasTPdmrOf9r5UZQZ8ZXFWTHww7Ukd0O8=
X-Received: by 2002:a7b:c451:0:b0:3fb:b4fc:be62 with SMTP id
 l17-20020a7bc451000000b003fbb4fcbe62mr15244749wmi.17.1689113068175; Tue, 11
 Jul 2023 15:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com> <CAOQ4uxiFhkSM2pSNLCE6cLz6mhYOvk5D7vDsghVTqy9cDqeqew@mail.gmail.com>
In-Reply-To: <CAOQ4uxiFhkSM2pSNLCE6cLz6mhYOvk5D7vDsghVTqy9cDqeqew@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 11 Jul 2023 15:04:17 -0700
Message-ID: <CABWYdi26iboFTFz+Vex3VO0fzmFzyfOxgr-qc964mLiC3En7=A@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 2:49=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Jul 11, 2023 at 12:21=E2=80=AFAM Ivan Babrou <ivan@cloudflare.com=
> wrote:
> >
> > On Mon, Jul 10, 2023 at 12:40=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jul 10, 2023 at 11:33:38AM -0700, Ivan Babrou wrote:
> > > > The following two commits added the same thing for tmpfs:
> > > >
> > > > * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> > > > * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with=
 file handles on tmpfs")
> > > >
> > > > Having fsid allows using fanotify, which is especially handy for cg=
roups,
> > > > where one might be interested in knowing when they are created or r=
emoved.
> > > >
> > > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > > ---
> > > >  fs/kernfs/mount.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > > > index d49606accb07..930026842359 100644
> > > > --- a/fs/kernfs/mount.c
> > > > +++ b/fs/kernfs/mount.c
> > > > @@ -16,6 +16,8 @@
> > > >  #include <linux/namei.h>
> > > >  #include <linux/seq_file.h>
> > > >  #include <linux/exportfs.h>
> > > > +#include <linux/uuid.h>
> > > > +#include <linux/statfs.h>
> > > >
> > > >  #include "kernfs-internal.h"
> > > >
> > > > @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file =
*sf, struct dentry *dentry)
> > > >       return 0;
> > > >  }
> > > >
> > > > +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > > > +{
> > > > +     simple_statfs(dentry, buf);
> > > > +     buf->f_fsid =3D uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > > > +     return 0;
> > > > +}
> > > > +
> > > >  const struct super_operations kernfs_sops =3D {
> > > > -     .statfs         =3D simple_statfs,
> > > > +     .statfs         =3D kernfs_statfs,
> > > >       .drop_inode     =3D generic_delete_inode,
> > > >       .evict_inode    =3D kernfs_evict_inode,
> > > >
> > > > @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
> > > >               }
> > > >               sb->s_flags |=3D SB_ACTIVE;
> > > >
> > > > +             uuid_gen(&sb->s_uuid);
> > >
> > > Since kernfs has as lot of nodes (like hundreds of thousands if not m=
ore
> > > at times, being created at boot time), did you just slow down creatin=
g
> > > them all, and increase the memory usage in a measurable way?
> >
> > This is just for the superblock, not every inode. The memory increase
> > is one UUID per kernfs instance (there are maybe 10 of them on a basic
> > system), which is trivial. Same goes for CPU usage.
> >
> > > We were trying to slim things down, what userspace tools need this
> > > change?  Who is going to use it, and what for?
> >
> > The one concrete thing is ebpf_exporter:
> >
> > * https://github.com/cloudflare/ebpf_exporter
> >
> > I want to monitor cgroup changes, so that I can have an up to date map
> > of inode -> cgroup path, so that I can resolve the value returned from
> > bpf_get_current_cgroup_id() into something that a human can easily
> > grasp (think system.slice/nginx.service). Currently I do a full sweep
> > to build a map, which doesn't work if a cgroup is short lived, as it
> > just disappears before I can resolve it. Unfortunately, systemd
> > recycles cgroups on restart, changing inode number, so this is a very
> > real issue.
> >
> > There's also this old wiki page from systemd:
> >
> > * https://freedesktop.org/wiki/Software/systemd/Optimizations
> >
> > Quoting from there:
> >
> > > Get rid of systemd-cgroups-agent. Currently, whenever a systemd cgrou=
p runs empty a tool "systemd-cgroups-agent" is invoked by the kernel which =
then notifies systemd about it. The need for this tool should really go awa=
y, which will save a number of forked processes at boot, and should make th=
ings faster (especially shutdown). This requires introduction of a new kern=
el interface to get notifications for cgroups running empty, for example vi=
a fanotify() on cgroupfs.
> >
> > So a similar need to mine, but for different systemd-related needs.
> >
> > Initially I tried adding this for cgroup fs only, but the problem felt
> > very generic, so I pivoted to having it in kernfs instead, so that any
> > kernfs based filesystem would benefit.
> >
> > Given pretty much non-existing overhead and simplicity of this, I
> > think it's a change worth doing, unless there's a good reason to not
> > do it. I cc'd plenty of people to make sure it's not a bad decision.
> >
>
> I agree. I think it was a good decision.
> I have some followup questions though.
>
> I guess your use case cares about the creation of cgroups?
> as long as the only way to create a cgroup is via vfs
> vfs_mkdir() -> ... cgroup_mkdir()
> fsnotify_mkdir() will be called.
> Is that a correct statement?

As far as I'm aware, this is the only way. We have the cgroups mailing
list CC'd to confirm.

I checked systemd and docker as real world consumers and both use
mkdir and are visible in fanotify with this patch applied.

> Because if not, then explicit fsnotify_mkdir() calls may be needed
> similar to tracefs/debugfs.
>
> I don't think that the statement holds for dieing cgroups,
> so explicit fsnotify_rmdir() are almost certainly needed to make
> inotify/fanotify monitoring on cgroups complete.
>
> I am on the fence w.r.t making the above a prerequisite to merging
> your patch.
>
> One the one hand, inotify monitoring of cgroups directory was already
> possible (I think?) with the mentioned shortcomings for a long time.
>
> On the other hand, we have an opportunity to add support to fanotify
> monitoring of cgroups directory only after the missing fsnotify hooks
> are added, making fanotify API a much more reliable option for
> monitoring cgroups.
>
> So I am leaning towards requiring the missing fsnotify hooks before
> attaching a unique fsid to cgroups/kernfs.

Unless somebody responsible for cgroups says there's a different way
to create cgroups, I think this requirement doesn't apply.

> In any case, either with or without the missing hooks, I would not
> want this patch merged until Jan had a chance to look at the
> implications and weigh in on the missing hooks question.
> Jan is on vacation for three weeks, so in the meanwhile, feel free
> to implement and test the missing hooks or wait for his judgement.

Sure, I can definitely wait.

> On an unrelated side topic,
> I would like to point your attention to this comment in the patch that
> was just merged to v6.5-rc1:
>
> 69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel internal pseud=
o fs")
>
>         /*
>          * mount and sb marks are not allowed on kernel internal pseudo f=
s,
>          * like pipe_mnt, because that would subscribe to events on all t=
he
>          * anonynous pipes in the system.
>          *
>          * SB_NOUSER covers all of the internal pseudo fs whose objects a=
re not
>          * exposed to user's mount namespace, but there are other SB_KERN=
MOUNT
>          * fs, like nsfs, debugfs, for which the value of allowing sb and=
 mount
>          * mark is questionable. For now we leave them alone.
>          */
>
> My question to you, as the only user I know of for fanotify FAN_REPORT_FI=
D
> on SB_KERNMOUNT, do you have plans to use a mount or filesystem mark
> to monitor cgroups? or only inotify-like directory watches?

My plan is to use FAN_MARK_FILESYSTEM for the whole cgroup mount,
since that is what I was able to make work with my limited
understanding of the whole fanotify thing. I started with
fanotify_fid.c example from here:

* https://man7.org/linux/man-pages/man7/fanotify.7.html

My existing code does the mark this way (on v6.5-rc1 with my patch applied)=
:

ret =3D fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_ONLYDIR |
FAN_MARK_FILESYSTEM, FAN_CREATE | FAN_DELETE | FAN_ONDIR, AT_FDCWD,
argv[1]);

My goal is to set a watch for all cgroups and drop capabilities, so
that I can keep monitoring for events while being unprivileged. As far
as I'm aware, this sort of recursive monitoring without races isn't
possible with inode level monitoring (I might be wrong here).

I do get -EINVAL for FAN_MARK_MOUNT instead of FAN_MARK_FILESYSTEM.
