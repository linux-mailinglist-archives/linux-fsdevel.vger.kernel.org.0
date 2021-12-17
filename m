Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FE7478973
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhLQLHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 06:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhLQLHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:07:09 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A5C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 03:07:09 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y68so5386664ybe.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Dec 2021 03:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pGxFunjSSbQIX4n2VPQoV9S4bG7+Tn9hFYOqtNEG5WA=;
        b=bNYCiYPbg86x7QnuM6VklnGCmMy0QpEx5drJvu3AJUxrSVvXYvqPRdX8YipB3vyCBz
         PUoQ5pddH9CvZ8vvCGBp3RAOoNBqzhP839VHogHJl+v9myFV7+MBZm7lFh+u1Be9D6Hj
         IdbAcPtbjBSNbKU8n2XGf0oMv4hIh9LoHB8pYBqPERluP+S8fAmkRoqb0fsfkDtiJrCS
         bsnCCamk25oW+jw0t1qOgiVBPhSI8gaCe5o0ehr6NwLYu8ixrMdV57BrSCcYiB9HVqMi
         c7kZYi66o/4msJG721Lsw0oqmjFbqb/IillkxdNn1JvRvyFdnh376htNB92emeFlvPmf
         BgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pGxFunjSSbQIX4n2VPQoV9S4bG7+Tn9hFYOqtNEG5WA=;
        b=C5OOmHBmqJpXMZd0/925lTq9ldixmJFZ9QePQFaKslqSklfUqA9fqWXLegyrlSq5dN
         P7RSRwd9TCaYUxA9BRR2iCkZeHRIu4sB2R3OO7xkqaW+xowmOavFD3QXHDWt4D94zO7x
         diqXr4vbuui0r6WDQgJen3542vMm+NLF9MBYG5HQOg0dF/IaHipAc4ybpMq46JHDh9PL
         siLTzCFwwFVLaa8DYpbO4dBcItYSG27oPwYCA7EITW5+0eI3w+MQJo4e8U1J2cbkCAhJ
         Hdgk+nDy0RwuuQ/Q/1P1vEZVAkgSFyiUDOJSVGGlurHS49ppV+ux7cVjFelPdLrbbxiU
         8aug==
X-Gm-Message-State: AOAM532xonXrvoa4BPzG0eI9IuVwslpy02ZCXObu0O71oZp48ErlhPee
        neIsVPN9ouYhD85Qqjq1/p4tKTfQ5nq2XmdgXUnXNA==
X-Google-Smtp-Source: ABdhPJx4NTGZvUe8hWX+aN+Lq7IRgZQGjfVd0FXNcWb7Bxg+vtPEn188Ah/ydVdqscyiGZuM2o2I6WG3mo7i+XWp1Dg=
X-Received: by 2002:a25:aa51:: with SMTP id s75mr3495196ybi.485.1639739228287;
 Fri, 17 Dec 2021 03:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-1-songmuchun@bytedance.com> <745ddcd6-77e3-22e0-1f8e-e6b05c644eb4@gmail.com>
In-Reply-To: <745ddcd6-77e3-22e0-1f8e-e6b05c644eb4@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 17 Dec 2021 19:06:31 +0800
Message-ID: <CAMZfGtUq846PFom0CK9Ybxgorv8hfV+wj6FD-wxbBKFDVoxHtg@mail.gmail.com>
Subject: Re: [PATCH v4 00/17] Optimize list lru memory consumption
To:     xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 17, 2021 at 6:05 PM xiaoqiang zhao
<zhaoxiaoqiang007@gmail.com> wrote:
>
>
>
> =E5=9C=A8 2021/12/14 0:53, Muchun Song =E5=86=99=E9=81=93:
> > This series is based on Linux 5.16-rc3.
> >
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than 2=
GB
> > memory.
> >
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
>
> IIUC, you mean: "the memory consumption of kmalloc-32 slab cache is
> caused by list_lru_one allocation"

Right.

>
> >
> >   crash> p memcg_nr_cache_ids
> >   memcg_nr_cache_ids =3D $2 =3D 24574
> >
> > memcg_nr_cache_ids is very large and memory consumption of each list_lr=
u
> > can be calculated with the following formula.
> >
> >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> >
> > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> >
> >   crash> list super_blocks | wc -l
> >   952
> >
> > Every mount will register 2 list lrus, one is for inode, another is for
> > dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> > MB (~5.6GB). But now the number of memory cgroups is less than 500. So =
I
> > guess more than 12286 memory cgroups have been created on this machine =
(I
> > do not know why there are so many cgroups, it may be a user's bug or
> > the user really want to do that). Because memcg_nr_cache_ids has not be=
en
> > reduced to a suitable value. It leads to waste a lot of memory. If we w=
ant
> > to reduce memcg_nr_cache_ids, we have to *reboot* the server. This is n=
ot
> > what we want.
> >
> > In order to reduce memcg_nr_cache_ids, I had posted a patchset [1] to d=
o
> > this. But this did not fundamentally solve the problem.
> >
> > We currently allocate scope for every memcg to be able to tracked on ev=
ery
> > superblock instantiated in the system, regardless of whether that super=
block
> > is even accessible to that memcg.
> >
> > These huge memcg counts come from container hosts where memcgs are conf=
ined
> > to just a small subset of the total number of superblocks that instanti=
ated
> > at any given point in time.
> >
> > For these systems with huge container counts, list_lru does not need th=
e
> > capability of tracking every memcg on every superblock.
> >
> > What it comes down to is that the list_lru is only needed for a given m=
emcg
> > if that memcg is instatiating and freeing objects on a given list_lru.
> >
> > As Dave said, "Which makes me think we should be moving more towards 'a=
dd the
> > memcg to the list_lru at the first insert' model rather than 'instantia=
te
> > all at memcg init time just in case'."
> >
> > This patchset aims to optimize the list lru memory consumption from dif=
ferent
> > aspects.
> >
> > I had done a easy test to show the optimization. I create 10k memory cg=
roups
> > and mount 10k filesystems in the systems. We use free command to show h=
ow many
> > memory does the systems comsumes after this operation (There are 2 numa=
 nodes
> > in the system).
> >
> >         +-----------------------+------------------------+
> >         |      condition        |   memory consumption   |
> >         +-----------------------+------------------------+
> >         | without this patchset |        24464 MB        |
> >         +-----------------------+------------------------+
> >         |     after patch 1     |        21957 MB        | <--------+
> >         +-----------------------+------------------------+          |
> >         |     after patch 11    |         6895 MB        |          |
> >         +-----------------------+------------------------+          |
> >         |     after patch 13    |         4367 MB        |          |
> >         +-----------------------+------------------------+          |
> >                                                                     |
> >         The more the number of nodes, the more obvious the effect---+
> >
> > BTW, there was a recent discussion [2] on the same issue.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20210428094949.43579-1-songmu=
chun@bytedance.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20210405054848.GA1077931@in.i=
bm.com/
> >
> > This series not only optimizes the memory usage of list_lru but also
> > simplifies the code.
> >
> > Changelog in v4:
> >   - Remove some code cleanup patches since they are already merged.
> >   - Collect Acked-by from Theodore.
> >   - Fix ntfs3 (Thanks Argillander).
> >
> > Changelog in v3:
> >   - Fix mixing advanced and normal XArray concepts (Thanks to Matthew).
> >   - Split one patch into per-filesystem patches.
> >
> > Changelog in v2:
> >   - Update Documentation/filesystems/porting.rst suggested by Dave.
> >   - Add a comment above alloc_inode_sb() suggested by Dave.
> >   - Rework some patch's commit log.
> >   - Add patch 18-21.
> >
> >   Thanks Dave.
> >
> > Muchun Song (17):
> >   mm: list_lru: optimize memory consumption of arrays of per cgroup
> >     lists
> >   mm: introduce kmem_cache_alloc_lru
> >   fs: introduce alloc_inode_sb() to allocate filesystems specific inode
> >   fs: allocate inode by using alloc_inode_sb()
> >   f2fs: allocate inode by using alloc_inode_sb()
> >   nfs42: use a specific kmem_cache to allocate nfs4_xattr_entry
> >   mm: dcache: use kmem_cache_alloc_lru() to allocate dentry
> >   xarray: use kmem_cache_alloc_lru to allocate xa_node
> >   mm: workingset: use xas_set_lru() to pass shadow_nodes
> >   mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
> >   mm: list_lru: allocate list_lru_one only when needed
> >   mm: list_lru: rename memcg_drain_all_list_lrus to
> >     memcg_reparent_list_lrus
> >   mm: list_lru: replace linear array with xarray
> >   mm: memcontrol: reuse memory cgroup ID for kmem ID
> >   mm: memcontrol: fix cannot alloc the maximum memcg ID
> >   mm: list_lru: rename list_lru_per_memcg to list_lru_memcg
> >   mm: memcontrol: rename memcg_cache_id to memcg_kmem_id
> >
> >  Documentation/filesystems/porting.rst |   5 +
> >  block/bdev.c                          |   2 +-
> >  drivers/dax/super.c                   |   2 +-
> >  fs/9p/vfs_inode.c                     |   2 +-
> >  fs/adfs/super.c                       |   2 +-
> >  fs/affs/super.c                       |   2 +-
> >  fs/afs/super.c                        |   2 +-
> >  fs/befs/linuxvfs.c                    |   2 +-
> >  fs/bfs/inode.c                        |   2 +-
> >  fs/btrfs/inode.c                      |   2 +-
> >  fs/ceph/inode.c                       |   2 +-
> >  fs/cifs/cifsfs.c                      |   2 +-
> >  fs/coda/inode.c                       |   2 +-
> >  fs/dcache.c                           |   3 +-
> >  fs/ecryptfs/super.c                   |   2 +-
> >  fs/efs/super.c                        |   2 +-
> >  fs/erofs/super.c                      |   2 +-
> >  fs/exfat/super.c                      |   2 +-
> >  fs/ext2/super.c                       |   2 +-
> >  fs/ext4/super.c                       |   2 +-
> >  fs/f2fs/super.c                       |   8 +-
> >  fs/fat/inode.c                        |   2 +-
> >  fs/freevxfs/vxfs_super.c              |   2 +-
> >  fs/fuse/inode.c                       |   2 +-
> >  fs/gfs2/super.c                       |   2 +-
> >  fs/hfs/super.c                        |   2 +-
> >  fs/hfsplus/super.c                    |   2 +-
> >  fs/hostfs/hostfs_kern.c               |   2 +-
> >  fs/hpfs/super.c                       |   2 +-
> >  fs/hugetlbfs/inode.c                  |   2 +-
> >  fs/inode.c                            |   2 +-
> >  fs/isofs/inode.c                      |   2 +-
> >  fs/jffs2/super.c                      |   2 +-
> >  fs/jfs/super.c                        |   2 +-
> >  fs/minix/inode.c                      |   2 +-
> >  fs/nfs/inode.c                        |   2 +-
> >  fs/nfs/nfs42xattr.c                   |  95 ++++----
> >  fs/nilfs2/super.c                     |   2 +-
> >  fs/ntfs/inode.c                       |   2 +-
> >  fs/ntfs3/super.c                      |   2 +-
> >  fs/ocfs2/dlmfs/dlmfs.c                |   2 +-
> >  fs/ocfs2/super.c                      |   2 +-
> >  fs/openpromfs/inode.c                 |   2 +-
> >  fs/orangefs/super.c                   |   2 +-
> >  fs/overlayfs/super.c                  |   2 +-
> >  fs/proc/inode.c                       |   2 +-
> >  fs/qnx4/inode.c                       |   2 +-
> >  fs/qnx6/inode.c                       |   2 +-
> >  fs/reiserfs/super.c                   |   2 +-
> >  fs/romfs/super.c                      |   2 +-
> >  fs/squashfs/super.c                   |   2 +-
> >  fs/sysv/inode.c                       |   2 +-
> >  fs/ubifs/super.c                      |   2 +-
> >  fs/udf/super.c                        |   2 +-
> >  fs/ufs/super.c                        |   2 +-
> >  fs/vboxsf/super.c                     |   2 +-
> >  fs/xfs/xfs_icache.c                   |   2 +-
> >  fs/zonefs/super.c                     |   2 +-
> >  include/linux/fs.h                    |  11 +
> >  include/linux/list_lru.h              |  17 +-
> >  include/linux/memcontrol.h            |  42 ++--
> >  include/linux/slab.h                  |   3 +
> >  include/linux/swap.h                  |   5 +-
> >  include/linux/xarray.h                |   9 +-
> >  ipc/mqueue.c                          |   2 +-
> >  lib/xarray.c                          |  10 +-
> >  mm/list_lru.c                         | 423 ++++++++++++++++----------=
--------
> >  mm/memcontrol.c                       | 164 +++----------
> >  mm/shmem.c                            |   2 +-
> >  mm/slab.c                             |  39 +++-
> >  mm/slab.h                             |  25 +-
> >  mm/slob.c                             |   6 +
> >  mm/slub.c                             |  42 ++--
> >  mm/workingset.c                       |   2 +-
> >  net/socket.c                          |   2 +-
> >  net/sunrpc/rpc_pipe.c                 |   2 +-
> >  76 files changed, 486 insertions(+), 539 deletions(-)
> >
