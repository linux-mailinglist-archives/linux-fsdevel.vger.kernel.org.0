Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED8F74EB15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGKJtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGKJtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:49:19 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44591;
        Tue, 11 Jul 2023 02:49:17 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-78caeb69125so1949550241.3;
        Tue, 11 Jul 2023 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689068956; x=1691660956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgTQWK83Q6lSONgCo8OzSJU3WKSIiULajv7A0glKus8=;
        b=SKiWdbryeyTtX1nzsOkUQ3ulE0JKKwe1cRwSAp+Z75vs3LMIdpm+2BSaoraEk/cBs+
         2fcdpFxelIs5hSAnKrIWjQKhkC+5b6TRvDQE96zdN7qE2AmwvnU8yPNAhj9ZFySIQB/A
         vbuqpCLHXCZ1psfpPlT7fixcRkg+KYIkJsH75WzfyMbLwgKkFXt3vnXafDTyrDutEEsa
         oU7L7ltPua2vUjRTGrEljK2oU26wUXuZBVOJpXnfazMcx1pfDA3ZZ+eYDCbMb7UjCiB5
         Q5s2Sx9evpa67plRQVvfXtpyOTlycAycxbHoL+H+JalSgihYx4Q6pghUuINvkapK/uEq
         Cv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689068956; x=1691660956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgTQWK83Q6lSONgCo8OzSJU3WKSIiULajv7A0glKus8=;
        b=D9d6q5BxcUbsYoZTVARUsHgaGB4QhkQo1WRRnh1wwVvL0cInzgroYI+hD/9lcU68zR
         +wJoOjH58e/WjmwAgUeokuoqXVgQyA0WDjWI16oFWkyqLb9gNLAbRMQBdzKV9wis825k
         3YwhBeTs5McxTnCXqAhGfKYRLS5DCjWpp+iZ3JjMWB22SBZJ4d5PKLklyK+S1XptVlll
         h09DI1HvK9HuwsCVN7kUNK/yYcG4v9GYXnuVV1K0xOWTMMtBtB8LfErdA09JUFX0M4Jv
         Bqwz6uEhqHSg2WFIEovcd2XH0dkd5vw91Q15rR8OZOAna1N6XEHz6U8WMT+yaIGEaiJ8
         +ucw==
X-Gm-Message-State: ABy/qLYL6mjU2o9tIRgjNKwdug/eInZ993emnAPVvlHqA2NsViNswyYl
        NGAYSsqNgDVFaJzsQ2/rpKqMNhTkAl0iZ3SOPQw=
X-Google-Smtp-Source: APBJJlFElt/mewgggUaWv+mWuHddxobQX6Zbn+xh+SVRMcR+13/oYImdOysOkzAuoDZf01XJU0PKOjHHSAKScwaZEKs=
X-Received: by 2002:a67:b646:0:b0:443:687a:e518 with SMTP id
 e6-20020a67b646000000b00443687ae518mr5891068vsm.35.1689068956447; Tue, 11 Jul
 2023 02:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
In-Reply-To: <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 11 Jul 2023 12:49:05 +0300
Message-ID: <CAOQ4uxiFhkSM2pSNLCE6cLz6mhYOvk5D7vDsghVTqy9cDqeqew@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Ivan Babrou <ivan@cloudflare.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 12:21=E2=80=AFAM Ivan Babrou <ivan@cloudflare.com> =
wrote:
>
> On Mon, Jul 10, 2023 at 12:40=E2=80=AFPM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jul 10, 2023 at 11:33:38AM -0700, Ivan Babrou wrote:
> > > The following two commits added the same thing for tmpfs:
> > >
> > > * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> > > * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with f=
ile handles on tmpfs")
> > >
> > > Having fsid allows using fanotify, which is especially handy for cgro=
ups,
> > > where one might be interested in knowing when they are created or rem=
oved.
> > >
> > > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > > ---
> > >  fs/kernfs/mount.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > > index d49606accb07..930026842359 100644
> > > --- a/fs/kernfs/mount.c
> > > +++ b/fs/kernfs/mount.c
> > > @@ -16,6 +16,8 @@
> > >  #include <linux/namei.h>
> > >  #include <linux/seq_file.h>
> > >  #include <linux/exportfs.h>
> > > +#include <linux/uuid.h>
> > > +#include <linux/statfs.h>
> > >
> > >  #include "kernfs-internal.h"
> > >
> > > @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *s=
f, struct dentry *dentry)
> > >       return 0;
> > >  }
> > >
> > > +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > > +{
> > > +     simple_statfs(dentry, buf);
> > > +     buf->f_fsid =3D uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > > +     return 0;
> > > +}
> > > +
> > >  const struct super_operations kernfs_sops =3D {
> > > -     .statfs         =3D simple_statfs,
> > > +     .statfs         =3D kernfs_statfs,
> > >       .drop_inode     =3D generic_delete_inode,
> > >       .evict_inode    =3D kernfs_evict_inode,
> > >
> > > @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
> > >               }
> > >               sb->s_flags |=3D SB_ACTIVE;
> > >
> > > +             uuid_gen(&sb->s_uuid);
> >
> > Since kernfs has as lot of nodes (like hundreds of thousands if not mor=
e
> > at times, being created at boot time), did you just slow down creating
> > them all, and increase the memory usage in a measurable way?
>
> This is just for the superblock, not every inode. The memory increase
> is one UUID per kernfs instance (there are maybe 10 of them on a basic
> system), which is trivial. Same goes for CPU usage.
>
> > We were trying to slim things down, what userspace tools need this
> > change?  Who is going to use it, and what for?
>
> The one concrete thing is ebpf_exporter:
>
> * https://github.com/cloudflare/ebpf_exporter
>
> I want to monitor cgroup changes, so that I can have an up to date map
> of inode -> cgroup path, so that I can resolve the value returned from
> bpf_get_current_cgroup_id() into something that a human can easily
> grasp (think system.slice/nginx.service). Currently I do a full sweep
> to build a map, which doesn't work if a cgroup is short lived, as it
> just disappears before I can resolve it. Unfortunately, systemd
> recycles cgroups on restart, changing inode number, so this is a very
> real issue.
>
> There's also this old wiki page from systemd:
>
> * https://freedesktop.org/wiki/Software/systemd/Optimizations
>
> Quoting from there:
>
> > Get rid of systemd-cgroups-agent. Currently, whenever a systemd cgroup =
runs empty a tool "systemd-cgroups-agent" is invoked by the kernel which th=
en notifies systemd about it. The need for this tool should really go away,=
 which will save a number of forked processes at boot, and should make thin=
gs faster (especially shutdown). This requires introduction of a new kernel=
 interface to get notifications for cgroups running empty, for example via =
fanotify() on cgroupfs.
>
> So a similar need to mine, but for different systemd-related needs.
>
> Initially I tried adding this for cgroup fs only, but the problem felt
> very generic, so I pivoted to having it in kernfs instead, so that any
> kernfs based filesystem would benefit.
>
> Given pretty much non-existing overhead and simplicity of this, I
> think it's a change worth doing, unless there's a good reason to not
> do it. I cc'd plenty of people to make sure it's not a bad decision.
>

I agree. I think it was a good decision.
I have some followup questions though.

I guess your use case cares about the creation of cgroups?
as long as the only way to create a cgroup is via vfs
vfs_mkdir() -> ... cgroup_mkdir()
fsnotify_mkdir() will be called.
Is that a correct statement?
Because if not, then explicit fsnotify_mkdir() calls may be needed
similar to tracefs/debugfs.

I don't think that the statement holds for dieing cgroups,
so explicit fsnotify_rmdir() are almost certainly needed to make
inotify/fanotify monitoring on cgroups complete.

I am on the fence w.r.t making the above a prerequisite to merging
your patch.

One the one hand, inotify monitoring of cgroups directory was already
possible (I think?) with the mentioned shortcomings for a long time.

On the other hand, we have an opportunity to add support to fanotify
monitoring of cgroups directory only after the missing fsnotify hooks
are added, making fanotify API a much more reliable option for
monitoring cgroups.

So I am leaning towards requiring the missing fsnotify hooks before
attaching a unique fsid to cgroups/kernfs.

In any case, either with or without the missing hooks, I would not
want this patch merged until Jan had a chance to look at the
implications and weigh in on the missing hooks question.
Jan is on vacation for three weeks, so in the meanwhile, feel free
to implement and test the missing hooks or wait for his judgement.

On an unrelated side topic,
I would like to point your attention to this comment in the patch that
was just merged to v6.5-rc1:

69562eb0bd3e ("fanotify: disallow mount/sb marks on kernel internal pseudo =
fs")

        /*
         * mount and sb marks are not allowed on kernel internal pseudo fs,
         * like pipe_mnt, because that would subscribe to events on all the
         * anonynous pipes in the system.
         *
         * SB_NOUSER covers all of the internal pseudo fs whose objects are=
 not
         * exposed to user's mount namespace, but there are other SB_KERNMO=
UNT
         * fs, like nsfs, debugfs, for which the value of allowing sb and m=
ount
         * mark is questionable. For now we leave them alone.
         */

My question to you, as the only user I know of for fanotify FAN_REPORT_FID
on SB_KERNMOUNT, do you have plans to use a mount or filesystem mark
to monitor cgroups? or only inotify-like directory watches?

Thanks,
Amir.
