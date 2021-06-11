Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711153A4AA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhFKVfX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 17:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhFKVfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623447204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bKo5wtaHM4sVh0ddB6M8mNI7mtuAf3dNvgJlkLWktM=;
        b=HehWaExnBhoV8W5ZFaPmwZ4CRPUjFc0M0HjhilyKrad7Rr1EGbshiFBG+teSMA3MquBk/d
        m2eD6iab+GjiIGhAYB7LNLT1MOsv6c/T9Wsc0zAT837AQ1QmBhBIj/pO9exRJAMapTLfnA
        x1UOOBwRPyfZIZl2u/ZrMBDzWSeHamc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-wDQfoM4SNXmvim3tgUhIgw-1; Fri, 11 Jun 2021 17:33:23 -0400
X-MC-Unique: wDQfoM4SNXmvim3tgUhIgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 242AE1084F43;
        Fri, 11 Jun 2021 21:33:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-174.rdu2.redhat.com [10.10.116.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAA841007606;
        Fri, 11 Jun 2021 21:33:21 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4B55E22054F; Fri, 11 Jun 2021 17:33:21 -0400 (EDT)
Date:   Fri, 11 Jun 2021 17:33:21 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Max Reitz <mreitz@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
Message-ID: <20210611213321.GC767764@redhat.com>
References: <20210609181158.479781-1-amir73il@gmail.com>
 <20210611162603.GA747424@redhat.com>
 <CAOQ4uxjX+EPuScGdL+LY2djaq=4O1dEpg59QyHgP2-eDLs7Y+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjX+EPuScGdL+LY2djaq=4O1dEpg59QyHgP2-eDLs7Y+A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 11, 2021 at 08:44:16PM +0300, Amir Goldstein wrote:
> On Fri, Jun 11, 2021 at 7:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jun 09, 2021 at 09:11:58PM +0300, Amir Goldstein wrote:
> > > Server responds to LOOKUP and other ops (READDIRPLUS/CREATE/MKNOD/...)
> > > with outarg containing nodeid and generation.
> > >
> > > If a fuse inode is found in inode cache with the same nodeid but
> > > different generation, the existing fuse inode should be unhashed and
> > > marked "bad" and a new inode with the new generation should be hashed
> > > instead.
> > >
> > > This can happen, for example, with passhrough fuse filesystem that
> > > returns the real filesystem ino/generation on lookup and where real inode
> > > numbers can get recycled due to real files being unlinked not via the fuse
> > > passthrough filesystem.
> > >
> > > With current code, this situation will not be detected and an old fuse
> > > dentry that used to point to an older generation real inode, can be used
> > > to access a completely new inode, which should be accessed only via the
> > > new dentry.
> >
> > Hi Amir,
> >
> > Curious that how server gets access to new inode on host. If server
> > keeps an fd open to file, then we will continue to refer to old
> > unlinked file. Well in that case inode number can't be recycled to
> > begin with, so this situation does not arise to begin with.
> >
> 
> Therefore, none of the example fs in libfuse exhibit the bug.
> 
> > If server is keeping file handles (like Max's patches) and file gets
> > recycled and inode number recycled, then I am assuming old inode in
> > server can't resolve that file handle because that file is gone
> > and a new file/inode is in place. IOW, I am assuming open_by_handle_at()
> > should fail in this case.
> >
> > IOW, IIUC, even if we refer to old inode, server does not have a
> > way to provide access to new file (with reused inode number). And
> > will be forced to return -ESTALE or something like that?  Did I
> > miss the point completely?
> >
> 
> Yes :-) it is much more simple than that.
> I will explain with an example from the test in link [1]:
> 
> test_syscalls has ~50 test cases.
> Each test case (or some) create a file named testfile.$n
> some test cases truncate the file, some chmod, whatever.
> At the end of each test case the file is closed and unlinked.
> This means that the server if run over ext4/xfs very likely reuses
> the same inode number in many test cases.
> 
> Normally, unlinking the testfile will drop the inode refcount to zero
> and kernel will evict the inode and send FORGER before the server
> creates another file with the same inode number.
> 
> I modified the test to keep an open O_PATH fd of the testfiles
> around until the end of the test.
> This does not keep the file open on the server, so the real inode
> number can and does get reused, but it does keep the inode
> with elevated refcount in the kernel, so there is no final FORGET
> to the server.
> 
> Now the server gets a CREATE for the next testfile and it happens
> to find a file with an inode number that already exists in the server
> with a different generation.
> 
> The server has no problem detecting this situation, but what can the
> server do about it? If server returns success, the existing kernel
> inode will now refer to the new server object.
> If the server returns failure, this is a permanent failure.

Hi Amir,

Thanks for the detailed explanation. I guess I am beginning to understand
it now.

In above example, when CREATE comes along and server detects that
inode it has in cache has same inode number but different generation,
then problem can be solved if it creates a new inode and new node
id) and sends back new inode id instead? But I guess your file
server is using real inode number as inode id and you can't do
that and that's why facing the issue?

> 
> My filesystem used to free the existing inode object and replace it with
> a new one, but the same ino will keep getting FORGET messages from
> the old kernel inode, so needed to remember the old nlookup.
> 
> The server can send an invalidate command for the inode, but that
> won't make the kernel inode go away nor be marked "bad".
> 
> Eventually, at the end of the test_syscalls, my modification iterates
> on all the O_PATH fd's, which correspond to different dentries, most
> of them now pointing at the same inode object and fstat() on most of
> those fd's return the same ino/size/mode, which is not a match to the
> file that O_PATH fd used to refer to. IOW, you got to peek at the
> content of a file that is not yours at all.

Got it. So with your invalidation patch, inode (opened with O_PATH)
will be marked bad and if you do fstat() on this, fuse will return
-EIO, instead of stats of new file which reused inode number, right?

What happens in following scenario.

- You have file open with O_PATH.
- Somebody unlinked the file on server and put a new file which
  reused inode number.
- Now I do fstat(fd). 

I am assuming in this case I will still be able to get stats of new
file? Or your server implementation detects that its not same
file anymore and returns an error instead?

Thanks
Vivek

> 
> > >
> > > Note that because the FORGET message carries the nodeid w/o generation,
> > > the server should wait to get FORGET counts for the nlookup counts of
> > > the old and reused inodes combined, before it can free the resources
> > > associated to that nodeid.
> >
> > This seems like an odd piece. Wondering if it will make sense to enhance
> > FORGET message to also send generation number so that server does not
> > have to keep both the inodes around.
> 
> The server does not keep both inodes.
> The server has a single object which is referenced by ino, because
> all protocol messages identify with only ino.
> 
> When the underlying fs reuses an inode number, the server will reuse the
> inode object as well (freeing all resources that were relevant to the old file),
> but same as the underlying filesystem keeps a generation in the inode object,
> so does the server.
> 
> Regarding nlookup count, I cannot think of a better way to address this
> nor do I see any problem with keeping a balance count of LOOKUP/FORGET
> the balance should work fine per ino, regardless of generation, as long as
> we make sure the fuse kernel driver has a single "live" inode object per ino
> at all times (it can have many "bad" inode objects).
> 
> Not sure if above is clear, but the result is that fuse driver has several inode
> objects, one hashed and some unhashed and when all are finally evicted,
> the server nlookup count per ino will level at 0 and the server can
> free the inode
> object.
> 
> Thanks,
> Amir.
> 

