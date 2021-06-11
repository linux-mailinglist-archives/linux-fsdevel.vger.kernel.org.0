Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D013A480C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFKRqj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhFKRqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 13:46:38 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E37C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 10:44:29 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d9so32025539ioo.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gyvi9ax5YOkpZmT5FQXNADkJojKsi7r2BSMqQ4loi/c=;
        b=LB8yDiEx4eWXDsVGEeyP+eSR9Ovr8CxmLbiGNzKUibooxwyAS/g0r1qnZS/0SilBWE
         0t2upirD/lcXhWcejxhs09QNrq2QSVh6/4m6smcRMqGwJZkKXo86E7Rti8ZwAqFG/SKL
         y/gBKvQLncIpUQ/qg185uergLSj9vz9ZF8YAKyYdGf7BU6h0d8PeMYb6quu4QZJxZsBK
         upZg4BobpK2BXsBSt7t/vOjx6GW20U52RCmEltJS+i6fkiqGIc8elCPGRaf0x9ME2T28
         UEcORSLhrysUzQR/5FfB1uCwHMKmNTVx2oSMwAZ2iaVeuJx40lR9zI2l4ooCHuubACe2
         fyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gyvi9ax5YOkpZmT5FQXNADkJojKsi7r2BSMqQ4loi/c=;
        b=J6jsokyzP6e94rBIZ72JiuLnLan1KByQ+TI1iEdaZDaemZAQ0fsxAM+mS189DWRFyK
         BT51+hUrMbKnDEcA0Ns8M7f0a2LmFMZpGaHaoL022ox8ml9JGtk39TTQ46t+fAeRZCJG
         FAjL9UjvQkY0mV6xUk/QkqpQZyg8sKRwwEwamnwoCXgQphDIUJHeCDL2DNQZEt61ifOU
         KZwefD5S10pkx/dLivWV6PUmysRQfp0izfmcvyW0g3wFjmkzujMzFbvDMMVFXmqlWhug
         lm2yAMchuP+rRiQtKv+4NCvZZSUSldLJDWxYkbhJisEgkIQj9GUJ73mS+tB7bZMxbhku
         VNvw==
X-Gm-Message-State: AOAM530ESiRzg7WBHNsFpnIpfjEfd1gK7fvy2/k/o8f6rgHyAfdYtUcT
        37M3JAezz+VK+GRrwkVehsH72h6EYiLJ4CoXxqs=
X-Google-Smtp-Source: ABdhPJz/ycVXicd7F4pcJp+5xbm1KUpCr3pOIjxzzp4t6KgfoOrPRNkcQfRWawaBIE8TfBqVwFGi9dgt/TB/ZJzSEk0=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr4033881ion.203.1623433468936;
 Fri, 11 Jun 2021 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com> <20210611162603.GA747424@redhat.com>
In-Reply-To: <20210611162603.GA747424@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Jun 2021 20:44:16 +0300
Message-ID: <CAOQ4uxjX+EPuScGdL+LY2djaq=4O1dEpg59QyHgP2-eDLs7Y+A@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 11, 2021 at 7:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jun 09, 2021 at 09:11:58PM +0300, Amir Goldstein wrote:
> > Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> > with outarg containing nodeid and generation.
> >
> > If a fuse inode is found in inode cache with the same nodeid but
> > different generation, the existing fuse inode should be unhashed and
> > marked "bad" and a new inode with the new generation should be hashed
> > instead.
> >
> > This can happen, for example, with passhrough fuse filesystem that
> > returns the real filesystem ino/generation on lookup and where real inode
> > numbers can get recycled due to real files being unlinked not via the fuse
> > passthrough filesystem.
> >
> > With current code, this situation will not be detected and an old fuse
> > dentry that used to point to an older generation real inode, can be used
> > to access a completely new inode, which should be accessed only via the
> > new dentry.
>
> Hi Amir,
>
> Curious that how server gets access to new inode on host. If server
> keeps an fd open to file, then we will continue to refer to old
> unlinked file. Well in that case inode number can't be recycled to
> begin with, so this situation does not arise to begin with.
>

Therefore, none of the example fs in libfuse exhibit the bug.

> If server is keeping file handles (like Max's patches) and file gets
> recycled and inode number recycled, then I am assuming old inode in
> server can't resolve that file handle because that file is gone
> and a new file/inode is in place. IOW, I am assuming open_by_handle_at()
> should fail in this case.
>
> IOW, IIUC, even if we refer to old inode, server does not have a
> way to provide access to new file (with reused inode number). And
> will be forced to return -ESTALE or something like that?  Did I
> miss the point completely?
>

Yes :-) it is much more simple than that.
I will explain with an example from the test in link [1]:

test_syscalls has ~50 test cases.
Each test case (or some) create a file named testfile.$n
some test cases truncate the file, some chmod, whatever.
At the end of each test case the file is closed and unlinked.
This means that the server if run over ext4/xfs very likely reuses
the same inode number in many test cases.

Normally, unlinking the testfile will drop the inode refcount to zero
and kernel will evict the inode and send FORGER before the server
creates another file with the same inode number.

I modified the test to keep an open O_PATH fd of the testfiles
around until the end of the test.
This does not keep the file open on the server, so the real inode
number can and does get reused, but it does keep the inode
with elevated refcount in the kernel, so there is no final FORGET
to the server.

Now the server gets a CREATE for the next testfile and it happens
to find a file with an inode number that already exists in the server
with a different generation.

The server has no problem detecting this situation, but what can the
server do about it? If server returns success, the existing kernel
inode will now refer to the new server object.
If the server returns failure, this is a permanent failure.

My filesystem used to free the existing inode object and replace it with
a new one, but the same ino will keep getting FORGET messages from
the old kernel inode, so needed to remember the old nlookup.

The server can send an invalidate command for the inode, but that
won't make the kernel inode go away nor be marked "bad".

Eventually, at the end of the test_syscalls, my modification iterates
on all the O_PATH fd's, which correspond to different dentries, most
of them now pointing at the same inode object and fstat() on most of
those fd's return the same ino/size/mode, which is not a match to the
file that O_PATH fd used to refer to. IOW, you got to peek at the
content of a file that is not yours at all.

> >
> > Note that because the FORGET message carries the nodeid w/o generation,
> > the server should wait to get FORGET counts for the nlookup counts of
> > the old and reused inodes combined, before it can free the resources
> > associated to that nodeid.
>
> This seems like an odd piece. Wondering if it will make sense to enhance
> FORGET message to also send generation number so that server does not
> have to keep both the inodes around.

The server does not keep both inodes.
The server has a single object which is referenced by ino, because
all protocol messages identify with only ino.

When the underlying fs reuses an inode number, the server will reuse the
inode object as well (freeing all resources that were relevant to the old file),
but same as the underlying filesystem keeps a generation in the inode object,
so does the server.

Regarding nlookup count, I cannot think of a better way to address this
nor do I see any problem with keeping a balance count of LOOKUP/FORGET
the balance should work fine per ino, regardless of generation, as long as
we make sure the fuse kernel driver has a single "live" inode object per ino
at all times (it can have many "bad" inode objects).

Not sure if above is clear, but the result is that fuse driver has several inode
objects, one hashed and some unhashed and when all are finally evicted,
the server nlookup count per ino will level at 0 and the server can
free the inode
object.

Thanks,
Amir.
