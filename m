Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9174E025
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 23:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGJVVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 17:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGJVVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:21:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26661BC
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 14:21:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso5160706f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689024081; x=1691616081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQ7g7+AcxoxnsFU8bE87IhRqS4UGLwwarsf5ft7ebmA=;
        b=yCwPFgvX0n9bam2XVB10ULgOSxhmv+g7JycHWNA8yMYhmn0ps8ge9NQ3tNCS7CESD5
         irL3pz5232n9hIz55m4ilJIzivoeRqjJ+4JSe2LSdQGjuVweKFAHwHvWrjPyPt4br3pj
         er+R1xwuKZOE4MJ9o8230qKevoysi5u/1GFoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689024081; x=1691616081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ7g7+AcxoxnsFU8bE87IhRqS4UGLwwarsf5ft7ebmA=;
        b=e5ELX186OAXcN0NuIWZ/UMkweukcrh4knI2MFcCt37B3qR2QcnA9KMF2W7Qwub02Z7
         OmDa0u6YI/6A09sealyFQBZQ9vDe4vJShozMYCUOvqIt4maUA4K7iT6Y8ysZ7zKIsbN/
         G0tORB2gI97wOKoVJSn+VV3Q9rthGWuj1j53vERvlNKZzByrHmg+2njoBjy3cx8kTKcy
         Tf4BpDG3iKWgU85SlY/4X8EpgVk1aNSrXxeLg7G50jVFnQFU62tO5OMe6uCsdUOnGBHc
         2lpMSEyxdlvOwQK7FSUd/xBBom8twXTtRj7yBtuqvBgLcU02/fycSdyB6jmDsogRvZW0
         +Cfg==
X-Gm-Message-State: ABy/qLY1Go+AsJw+7NuMshl9JGd3WqR8W53Gb1SyuPV3SYm+sU5hvArY
        Il9jCMyPt4iFPswXDU12Fjq5BPLn533QHeqMe5qc6Q==
X-Google-Smtp-Source: APBJJlH3SN2nYNIgBk+dLUzclEwhTNb+zVtBu430OguEMqwabY7Bek0J/Qh7N2bFBtm2SH0kohTsHRzGvRWA8Hi9jXs=
X-Received: by 2002:a5d:6047:0:b0:313:e8f9:803 with SMTP id
 j7-20020a5d6047000000b00313e8f90803mr12736503wrt.3.1689024081594; Mon, 10 Jul
 2023 14:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
In-Reply-To: <2023071039-negate-stalemate-6987@gregkh>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 10 Jul 2023 14:21:10 -0700
Message-ID: <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 10, 2023 at 11:33:38AM -0700, Ivan Babrou wrote:
> > The following two commits added the same thing for tmpfs:
> >
> > * commit 2b4db79618ad ("tmpfs: generate random sb->s_uuid")
> > * commit 59cda49ecf6c ("shmem: allow reporting fanotify events with fil=
e handles on tmpfs")
> >
> > Having fsid allows using fanotify, which is especially handy for cgroup=
s,
> > where one might be interested in knowing when they are created or remov=
ed.
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > ---
> >  fs/kernfs/mount.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> > index d49606accb07..930026842359 100644
> > --- a/fs/kernfs/mount.c
> > +++ b/fs/kernfs/mount.c
> > @@ -16,6 +16,8 @@
> >  #include <linux/namei.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/exportfs.h>
> > +#include <linux/uuid.h>
> > +#include <linux/statfs.h>
> >
> >  #include "kernfs-internal.h"
> >
> > @@ -45,8 +47,15 @@ static int kernfs_sop_show_path(struct seq_file *sf,=
 struct dentry *dentry)
> >       return 0;
> >  }
> >
> > +int kernfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> > +{
> > +     simple_statfs(dentry, buf);
> > +     buf->f_fsid =3D uuid_to_fsid(dentry->d_sb->s_uuid.b);
> > +     return 0;
> > +}
> > +
> >  const struct super_operations kernfs_sops =3D {
> > -     .statfs         =3D simple_statfs,
> > +     .statfs         =3D kernfs_statfs,
> >       .drop_inode     =3D generic_delete_inode,
> >       .evict_inode    =3D kernfs_evict_inode,
> >
> > @@ -351,6 +360,8 @@ int kernfs_get_tree(struct fs_context *fc)
> >               }
> >               sb->s_flags |=3D SB_ACTIVE;
> >
> > +             uuid_gen(&sb->s_uuid);
>
> Since kernfs has as lot of nodes (like hundreds of thousands if not more
> at times, being created at boot time), did you just slow down creating
> them all, and increase the memory usage in a measurable way?

This is just for the superblock, not every inode. The memory increase
is one UUID per kernfs instance (there are maybe 10 of them on a basic
system), which is trivial. Same goes for CPU usage.

> We were trying to slim things down, what userspace tools need this
> change?  Who is going to use it, and what for?

The one concrete thing is ebpf_exporter:

* https://github.com/cloudflare/ebpf_exporter

I want to monitor cgroup changes, so that I can have an up to date map
of inode -> cgroup path, so that I can resolve the value returned from
bpf_get_current_cgroup_id() into something that a human can easily
grasp (think system.slice/nginx.service). Currently I do a full sweep
to build a map, which doesn't work if a cgroup is short lived, as it
just disappears before I can resolve it. Unfortunately, systemd
recycles cgroups on restart, changing inode number, so this is a very
real issue.

There's also this old wiki page from systemd:

* https://freedesktop.org/wiki/Software/systemd/Optimizations

Quoting from there:

> Get rid of systemd-cgroups-agent. Currently, whenever a systemd cgroup ru=
ns empty a tool "systemd-cgroups-agent" is invoked by the kernel which then=
 notifies systemd about it. The need for this tool should really go away, w=
hich will save a number of forked processes at boot, and should make things=
 faster (especially shutdown). This requires introduction of a new kernel i=
nterface to get notifications for cgroups running empty, for example via fa=
notify() on cgroupfs.

So a similar need to mine, but for different systemd-related needs.

Initially I tried adding this for cgroup fs only, but the problem felt
very generic, so I pivoted to having it in kernfs instead, so that any
kernfs based filesystem would benefit.

Given pretty much non-existing overhead and simplicity of this, I
think it's a change worth doing, unless there's a good reason to not
do it. I cc'd plenty of people to make sure it's not a bad decision.

> There were some benchmarks people were doing with booting large memory
> systems that you might want to reproduce here to verify that nothing is
> going to be harmed.

Skipping this given that overhead is per superblock and trivial.
