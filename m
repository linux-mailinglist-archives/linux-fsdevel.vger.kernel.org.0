Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649D53A4B15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jun 2021 01:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFKXQp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 19:16:45 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:40835 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhFKXQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:16:44 -0400
Received: by mail-io1-f49.google.com with SMTP id l64so11227184ioa.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vR/Fdv4On9WhCcoViIG6nshfsqTOHsMhyO/511n7FTE=;
        b=sO9u8WRLtrcHBsPKEgdu9bKvOYc10XSisKbHdkM1Qs8XYo962ynSJKWRwPA8YwLJUb
         RqedraNt6bJ+nw6ovQ5nVh7p6DMygmM87jpFmhRAzqS7J1peo/v5fuYj0LcSxSFiWxeW
         4AIhInWEfrZNUlQUBLpbIHuyV+XBBA/TmdiCn4sOOzmfU1uU/DEnEsTKy7ZWeDY5ERY4
         Z1L04cmwcweGWJFagP88NWW+/UY2vEh/CyjN0UAV93pWS9rxZrv2WnR3GkvVoZKNG9Nr
         EDk4eiR71rDmwKMcep4sx6hE5ljfENtvf5q/BFWoiO5saZyVdtfCkkZjObqETm7T5mwy
         yHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vR/Fdv4On9WhCcoViIG6nshfsqTOHsMhyO/511n7FTE=;
        b=CiBjbtbicelNHsFlMM5lN/9x+ND6SqG40R2FOUuVBz6Ou+GW6j6CrUlbQUJIpiJecP
         /qPa5c7QObSzq0pBdu2MBpUMQ5pGOw9D94HYRIVWsP7DfBqI7mKyMI9EXdnR4KAK+ckh
         gaqvfbzlrBvdNERLl6FVky78PaKBWkB8ZsTc6g5Sjd1jCHWURfztK5Y5QdnL40ekHyZy
         8KIcD3TbXTowj7jNGBAvCkIWgJDjS+yfe5+EKUccA05gcclBWIdonuXoKUnbJbIziaRU
         yUZIYa+dDGAvlgfSeg3bAiMXb1I6XXQiVRtbUMT9Aj76trqzGlknfKSRFS2KVdZevqLX
         W3Jw==
X-Gm-Message-State: AOAM533TITb6fAH18BDeshuN29RU3brD5MLzmPz7gQ7bJbrF0yZ3tG/W
        O32l7BMNfz0s/1vTUHf7nHgkvnn/sVtOGHXzaxHew48X
X-Google-Smtp-Source: ABdhPJwupHK1qTUVyaTZ0M7MISTo8xTdkVn4WKwZ/DVYaEgEYFkaOF1t+aJY2e+8CBrkZGiLAa6rUk/4OIgPDZggr3E=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr4815773ioa.64.1623453225741;
 Fri, 11 Jun 2021 16:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com> <20210611162603.GA747424@redhat.com>
 <CAOQ4uxjX+EPuScGdL+LY2djaq=4O1dEpg59QyHgP2-eDLs7Y+A@mail.gmail.com> <20210611213321.GC767764@redhat.com>
In-Reply-To: <20210611213321.GC767764@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Jun 2021 02:13:34 +0300
Message-ID: <CAOQ4uxh+qQ88utcgVicKWu28sa5xLv5GEKN+Z_Fc+1epNu-STA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 12, 2021 at 12:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Jun 11, 2021 at 08:44:16PM +0300, Amir Goldstein wrote:
> > On Fri, Jun 11, 2021 at 7:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Jun 09, 2021 at 09:11:58PM +0300, Amir Goldstein wrote:
> > > > Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> > > > with outarg containing nodeid and generation.
> > > >
> > > > If a fuse inode is found in inode cache with the same nodeid but
> > > > different generation, the existing fuse inode should be unhashed and
> > > > marked "bad" and a new inode with the new generation should be hashed
> > > > instead.
> > > >
> > > > This can happen, for example, with passhrough fuse filesystem that
> > > > returns the real filesystem ino/generation on lookup and where real inode
> > > > numbers can get recycled due to real files being unlinked not via the fuse
> > > > passthrough filesystem.
> > > >
> > > > With current code, this situation will not be detected and an old fuse
> > > > dentry that used to point to an older generation real inode, can be used
> > > > to access a completely new inode, which should be accessed only via the
> > > > new dentry.
> > >
> > > Hi Amir,
> > >
> > > Curious that how server gets access to new inode on host. If server
> > > keeps an fd open to file, then we will continue to refer to old
> > > unlinked file. Well in that case inode number can't be recycled to
> > > begin with, so this situation does not arise to begin with.
> > >
> >
> > Therefore, none of the example fs in libfuse exhibit the bug.
> >
> > > If server is keeping file handles (like Max's patches) and file gets
> > > recycled and inode number recycled, then I am assuming old inode in
> > > server can't resolve that file handle because that file is gone
> > > and a new file/inode is in place. IOW, I am assuming open_by_handle_at()
> > > should fail in this case.
> > >
> > > IOW, IIUC, even if we refer to old inode, server does not have a
> > > way to provide access to new file (with reused inode number). And
> > > will be forced to return -ESTALE or something like that?  Did I
> > > miss the point completely?
> > >
> >
> > Yes :-) it is much more simple than that.
> > I will explain with an example from the test in link [1]:
> >
> > test_syscalls has ~50 test cases.
> > Each test case (or some) create a file named testfile.$n
> > some test cases truncate the file, some chmod, whatever.
> > At the end of each test case the file is closed and unlinked.
> > This means that the server if run over ext4/xfs very likely reuses
> > the same inode number in many test cases.
> >
> > Normally, unlinking the testfile will drop the inode refcount to zero
> > and kernel will evict the inode and send FORGER before the server
> > creates another file with the same inode number.
> >
> > I modified the test to keep an open O_PATH fd of the testfiles
> > around until the end of the test.
> > This does not keep the file open on the server, so the real inode
> > number can and does get reused, but it does keep the inode
> > with elevated refcount in the kernel, so there is no final FORGET
> > to the server.
> >
> > Now the server gets a CREATE for the next testfile and it happens
> > to find a file with an inode number that already exists in the server
> > with a different generation.
> >
> > The server has no problem detecting this situation, but what can the
> > server do about it? If server returns success, the existing kernel
> > inode will now refer to the new server object.
> > If the server returns failure, this is a permanent failure.
>
> Hi Amir,
>
> Thanks for the detailed explanation. I guess I am beginning to understand
> it now.
>
> In above example, when CREATE comes along and server detects that
> inode it has in cache has same inode number but different generation,
> then problem can be solved if it creates a new inode and new node
> id) and sends back new inode id instead? But I guess your file
> server is using real inode number as inode id and you can't do
> that and that's why facing the issue?
>

That is correct.
For fs with 32bit ino (ext4) I encode nodeid from ino+generation
so there is no nodeid reuse issue.
Since I need persistent inode numbers it would be impractical to
keep a persistent mapping of real ino to nodeid in a db.
And besides, FUSE protocol returns generation in LOOKUP
response for a reason - this result must not be linked to an existing
inode with previous generation in the FUSE inode cache.

> >
> > My filesystem used to free the existing inode object and replace it with
> > a new one, but the same ino will keep getting FORGET messages from
> > the old kernel inode, so needed to remember the old nlookup.
> >
> > The server can send an invalidate command for the inode, but that
> > won't make the kernel inode go away nor be marked "bad".
> >
> > Eventually, at the end of the test_syscalls, my modification iterates
> > on all the O_PATH fd's, which correspond to different dentries, most
> > of them now pointing at the same inode object and fstat() on most of
> > those fd's return the same ino/size/mode, which is not a match to the
> > file that O_PATH fd used to refer to. IOW, you got to peek at the
> > content of a file that is not yours at all.
>
> Got it. So with your invalidation patch, inode (opened with O_PATH)
> will be marked bad and if you do fstat() on this, fuse will return
> -EIO, instead of stats of new file which reused inode number, right?
>

Yes.

> What happens in following scenario.
>
> - You have file open with O_PATH.
> - Somebody unlinked the file on server and put a new file which
>   reused inode number.
> - Now I do fstat(fd).
>
> I am assuming in this case I will still be able to get stats of new
> file? Or your server implementation detects that its not same
> file anymore and returns an error instead?
>

Yes, in that case, the server doesn't know about the reuse yet,
but when a request comes in with that ino, the server will find
the Inode object, use the stored file handle to try and get an
fd on the real file and will not be able to, because it's a stale file
handle.

The stale Inode object will linger in the server until either:
- O_PATH fd is closed and kernel inode is evicted OR
- The location of the reused inode is found by another LOOKUP
that will reuse the server Inode object with a new file handle

Thanks,
Amir.
