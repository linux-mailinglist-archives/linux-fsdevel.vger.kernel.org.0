Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10C2B5371
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 22:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgKPVJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 16:09:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgKPVJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605560995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGRXSv16MAi4QhjuwiyqRzkBSvMLZCr6IKlof1IafIk=;
        b=RCMRkdRbUjGMb4qk8U7In97Tloz1qQu8zbmd7LlCQf/YUm2jwou1AtwCWhfEbuEs9uaDld
        anax/c3xdPrPmaJcXvd3YGV1TCvqW3Iabybqx1+GUVUaSRUJtzT3ezhHipT3hkKYOXlUGU
        2xobNUVqR+UdGhwi6jPgz5r1rq4jtfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-B61KbNt0OAeau98r86XQLg-1; Mon, 16 Nov 2020 16:09:53 -0500
X-MC-Unique: B61KbNt0OAeau98r86XQLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB8556BE4;
        Mon, 16 Nov 2020 21:09:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-201.rdu2.redhat.com [10.10.114.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CEB60F96;
        Mon, 16 Nov 2020 21:09:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 768D4220BCF; Mon, 16 Nov 2020 16:09:50 -0500 (EST)
Date:   Mon, 16 Nov 2020 16:09:50 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
Message-ID: <20201116210950.GD9190@redhat.com>
References: <20201116045758.21774-1-sargun@sargun.me>
 <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
 <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com>
 <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:18:03PM +0200, Amir Goldstein wrote:
> On Mon, Nov 16, 2020 at 6:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, Nov 16, 2020 at 05:20:04PM +0200, Amir Goldstein wrote:
> > > On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > > > > Overlayfs added the ability to setup mounts where all syncs could be
> > > > > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > > > >
> > > > > A user might want to remount this fs, but we do not let the user because
> > > > > of the "incompat" detection feature. In the case of volatile, it is safe
> > > > > to do something like[1]:
> > > > >
> > > > > $ sync -f /root/upperdir
> > > > > $ rm -rf /root/workdir/incompat/volatile
> > > > >
> > > > > There are two ways to go about this. You can call sync on the underlying
> > > > > filesystem, check the error code, and delete the dirty file if everything
> > > > > is clean. If you're running lots of containers on the same filesystem, or
> > > > > you want to avoid all unnecessary I/O, this may be suboptimal.
> > > > >
> > > >
> > > > Hi Sargun,
> > > >
> > > > I had asked bunch of questions in previous mail thread to be more
> > > > clear on your requirements but never got any response. It would
> > > > have helped understanding your requirements better.
> > > >
> > > > How about following patch set which seems to sync only dirty inodes of
> > > > upper belonging to a particular overlayfs instance.
> > > >
> > > > https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> > > >
> > > > So if could implement a mount option which ignores fsync but upon
> > > > syncfs, only syncs dirty inodes of that overlayfs instance, it will
> > > > make sure we are not syncing whole of the upper fs. And we could
> > > > do this syncing on unmount of overlayfs and remove dirty file upon
> > > > successful sync.
> > > >
> > > > Looks like this will be much simpler method and should be able to
> > > > meet your requirements (As long as you are fine with syncing dirty
> > > > upper inodes of this overlay instance on unmount).
> > > >
> > >
> > > Do note that the latest patch set by Chengguang not only syncs dirty
> > > inodes of this overlay instance, but also waits for in-flight writeback on
> > > all the upper fs inodes and I think that with !ovl_should_sync(ofs)
> > > we will not re-dirty the ovl inodes and lose track of the list of dirty
> > > inodes - maybe that can be fixed.
> > >
> > > Also, I am not sure anymore that we can safely remove the dirty file after
> > > sync dirty inodes sync_fs and umount. If someone did sync_fs before us
> > > and consumed the error, we may have a copied up file in upper whose
> > > data is not on disk, but when we sync_fs on unmount we won't get an
> > > error? not sure.
> >
> > May be we can save errseq_t when mounting overlay and compare with
> > errseq_t stored in upper sb after unmount. That will tell us whether
> > error has happened since we mounted overlay. (Similar to what Sargun
> > is doing).
> >
> 
> I suppose so.
> 
> > In fact, if this is a concern, we have this issue with user space
> > "sync <upper>" too? Other sync might fail and this one succeeds
> > and we will think upper is just fine. May be container tools can
> > keep a file/dir open at the time of mount and call syncfs using
> > that fd instead. (And that should catch errors since that fd
> > was opened, I am assuming).
> >
> 
> Did not understand the problem with userspace sync.

Say volatile container A is using upper/ which is on xfs. Assume, container A
does following.

1. Container A writes some data/copies up some files.
2. sync -f upper/
3. Remove incompat dir.
4. Remount overlay and restart container A.

Now normally if some error happend in writeback on upper/, then "sync -f"
should catch that and return an error. In that case container manager can
throw away the container.

What if another container B was doing same thing and issues ssues
"sync -f upper/" and that sync reports errors. Now container A issues
sync and IIUC, we will not see error on super block because it has
already been seen by container B.

And container A will assume that all data written by it safely made
it to disk and it is safe to remove incompat/volatile/ dir. 

If container manager keeps a file descriptor open to one of the files
in upper/, and uses that for sync, then it will still catch the
error because file->f_sb_err should be previous to error happened
and we will get any error since then.

> 
> > >
> > > I am less concerned about ways to allow re-mount of volatile
> > > overlayfs than I am about turning volatile overlayfs into non-volatile.
> >
> > If we are not interested in converting volatile containers into
> > non-volatile, then whole point of these patch series is to detect
> > if any writeback error has happened or not. If writeback error has
> > happened, then we detect that at remount and possibly throw away
> > container.
> >
> > What happens today if writeback error has happened. Is that page thrown
> > away from page cache and read back from disk? IOW, will user lose
> > the data it had written in page cache because writeback failed. I am
> > assuming we can't keep the dirty page around for very long otherwise
> > it has potential to fill up all the available ram with dirty pages which
> > can't be written back.
> >
> 
> Right. the resulting data is undefined after error.

So application will not come to know of error until and unless it does
an fsync()? IOW, if I write to a file and read back same pages after
a while, I might not get back what I had written. So application 
should first write data, fsync it and upon successful fsync, consume
back the data written?

If yes, this is a problem for volatile containers. If somebody is
using these to build images, there is a possibility that image
is corrupted (because writeback error led to data loss). If yes,
then safe way to generate image with volatile containers
will be to first sync upper (or sync on umount somehow) and if
no errors are reported, then it is safe to read back that data
and pack into image.

> 
> > Why is it important to detect writeback error only during remount. What
> > happens if container overlay instance is already mounted and writeback
> > error happens. We will not detct that, right?
> >
> > IOW, if capturing writeback error is important for volatile containers,
> > then capturing it only during remount time is not enough. Normally
> > fsync/syncfs should catch it and now we have skipped those, so in
> > the process we lost mechanism to detect writeback errrors for
> > volatile containers?
> >
> 
> Yes, you are right.
> It's an issue with volatile that we should probably document.
> 
> I think upper files data can "evaporate" even as the overlay is still mounted.

How do we reliably consume that data back (if it can evaporate). That
means, syncing whole fs (syncfs) is a requirement for volatile containers
before data written is read back. Otherwise we don't know if we are
reading back correct data or corrupted data.

Thanks
Vivek

