Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBE2B6B11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 18:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKQRGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 12:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbgKQRGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605632766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2gZvSGRfLDNPoEBqkj+UpukogkrZwL8ungrHwJ7UcCo=;
        b=hmxPIh18ka4I8rVfwA1bPiWTGlqhe0zvNZylHv84oE3V9EsmEnP4E7Xk3DQw0n52IzZQNe
        TaW60KnUTAKksQNY7oWiQMwzASwUya+qqng+vtXr+zzwUNk1j7EvR6srrXoFdxWkmCCXP+
        oAl7HKzGfR5nGSgC4xFJt4IWqHYi0iE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-MSvEVpswMjW-BJk9qwBDBQ-1; Tue, 17 Nov 2020 12:05:58 -0500
X-MC-Unique: MSvEVpswMjW-BJk9qwBDBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02EDE80364C;
        Tue, 17 Nov 2020 17:05:56 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-186.rdu2.redhat.com [10.10.116.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A7166EF58;
        Tue, 17 Nov 2020 17:05:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A0C5F220BCF; Tue, 17 Nov 2020 12:05:53 -0500 (EST)
Date:   Tue, 17 Nov 2020 12:05:53 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20201117170553.GD78221@redhat.com>
References: <20201116045758.21774-1-sargun@sargun.me>
 <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
 <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com>
 <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116212644.GE9190@redhat.com>
 <20201116221401.GA21744@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116221401.GA21744@ircssh-2.c.rugged-nimbus-611.internal>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:14:02PM +0000, Sargun Dhillon wrote:
> On Mon, Nov 16, 2020 at 04:26:44PM -0500, Vivek Goyal wrote:
> > On Mon, Nov 16, 2020 at 10:18:03PM +0200, Amir Goldstein wrote:
> > > On Mon, Nov 16, 2020 at 6:36 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 16, 2020 at 05:20:04PM +0200, Amir Goldstein wrote:
> > > > > On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > >
> > > > > > On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > > > > > > Overlayfs added the ability to setup mounts where all syncs could be
> > > > > > > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > > > > > >
> > > > > > > A user might want to remount this fs, but we do not let the user because
> > > > > > > of the "incompat" detection feature. In the case of volatile, it is safe
> > > > > > > to do something like[1]:
> > > > > > >
> > > > > > > $ sync -f /root/upperdir
> > > > > > > $ rm -rf /root/workdir/incompat/volatile
> > > > > > >
> > > > > > > There are two ways to go about this. You can call sync on the underlying
> > > > > > > filesystem, check the error code, and delete the dirty file if everything
> > > > > > > is clean. If you're running lots of containers on the same filesystem, or
> > > > > > > you want to avoid all unnecessary I/O, this may be suboptimal.
> > > > > > >
> > > > > >
> > > > > > Hi Sargun,
> > > > > >
> > > > > > I had asked bunch of questions in previous mail thread to be more
> > > > > > clear on your requirements but never got any response. It would
> > > > > > have helped understanding your requirements better.
> > > > > >
> > > > > > How about following patch set which seems to sync only dirty inodes of
> > > > > > upper belonging to a particular overlayfs instance.
> > > > > >
> > > > > > https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> > > > > >
> > > > > > So if could implement a mount option which ignores fsync but upon
> > > > > > syncfs, only syncs dirty inodes of that overlayfs instance, it will
> > > > > > make sure we are not syncing whole of the upper fs. And we could
> > > > > > do this syncing on unmount of overlayfs and remove dirty file upon
> > > > > > successful sync.
> > > > > >
> > > > > > Looks like this will be much simpler method and should be able to
> > > > > > meet your requirements (As long as you are fine with syncing dirty
> > > > > > upper inodes of this overlay instance on unmount).
> > > > > >
> > > > >
> > > > > Do note that the latest patch set by Chengguang not only syncs dirty
> > > > > inodes of this overlay instance, but also waits for in-flight writeback on
> > > > > all the upper fs inodes and I think that with !ovl_should_sync(ofs)
> > > > > we will not re-dirty the ovl inodes and lose track of the list of dirty
> > > > > inodes - maybe that can be fixed.
> > > > >
> > > > > Also, I am not sure anymore that we can safely remove the dirty file after
> > > > > sync dirty inodes sync_fs and umount. If someone did sync_fs before us
> > > > > and consumed the error, we may have a copied up file in upper whose
> > > > > data is not on disk, but when we sync_fs on unmount we won't get an
> > > > > error? not sure.
> > > >
> > > > May be we can save errseq_t when mounting overlay and compare with
> > > > errseq_t stored in upper sb after unmount. That will tell us whether
> > > > error has happened since we mounted overlay. (Similar to what Sargun
> > > > is doing).
> > > >
> > > 
> > > I suppose so.
> > > 
> > > > In fact, if this is a concern, we have this issue with user space
> > > > "sync <upper>" too? Other sync might fail and this one succeeds
> > > > and we will think upper is just fine. May be container tools can
> > > > keep a file/dir open at the time of mount and call syncfs using
> > > > that fd instead. (And that should catch errors since that fd
> > > > was opened, I am assuming).
> > > >
> > > 
> > > Did not understand the problem with userspace sync.
> > > 
> > > > >
> > > > > I am less concerned about ways to allow re-mount of volatile
> > > > > overlayfs than I am about turning volatile overlayfs into non-volatile.
> > > >
> > > > If we are not interested in converting volatile containers into
> > > > non-volatile, then whole point of these patch series is to detect
> > > > if any writeback error has happened or not. If writeback error has
> > > > happened, then we detect that at remount and possibly throw away
> > > > container.
> > > >
> > > > What happens today if writeback error has happened. Is that page thrown
> > > > away from page cache and read back from disk? IOW, will user lose
> > > > the data it had written in page cache because writeback failed. I am
> > > > assuming we can't keep the dirty page around for very long otherwise
> > > > it has potential to fill up all the available ram with dirty pages which
> > > > can't be written back.
> > > >
> > > 
> > > Right. the resulting data is undefined after error.
> > > 
> > > > Why is it important to detect writeback error only during remount. What
> > > > happens if container overlay instance is already mounted and writeback
> > > > error happens. We will not detct that, right?
> > > >
> > > > IOW, if capturing writeback error is important for volatile containers,
> > > > then capturing it only during remount time is not enough. Normally
> > > > fsync/syncfs should catch it and now we have skipped those, so in
> > > > the process we lost mechanism to detect writeback errrors for
> > > > volatile containers?
> > > >
> > > 
> > > Yes, you are right.
> > > It's an issue with volatile that we should probably document.
> > > 
> > > I think upper files data can "evaporate" even as the overlay is still mounted.
> > 
> > I think assumption of volatile containers was that data will remain
> > valid as long as machine does not crash/shutdown. We missed the case
> > of possibility of writeback errors during those discussions. 
> > 
> > And if data can evaporate without anyway to know that somehthing
> > is gone wrong, I don't know how that's useful for applications.
> > 
> > Also, first we need to fix the case of writeback error handling
> > for volatile containers while it is mounted before one tries to fix it
> > for writeback error detection during remount, IMHO.
> > 
> > Thanks
> > Vivek
> > 
> 
> I feel like this is an infamous Linux problem, and lots[1][2][3][4] has been said
> on the topic, and there's not really a general purpose solution to it. I think that
> most filesystems offer a choice of "continue" or "fail-stop" (readonly), and if
> the upperdir lives on that filesystem, we will get the feedback from it.

In case of fsync/writeback data failures, we will not hear anything back.
Only mechanism to know about failure seems to be fsync()/syncfs() and
we disable both in overlayfs. So that alone is not enough. For overlay
volatile mode, we need another way to deal with writeback failures
in upper/, IIUC.

> 
> I can respin my patch with just the "boot id" and superblock ID check if folks
> are fine with that, and we can figure out how to resolve the writeback issues
> later.

Keeping track of "boot id" and removing incompat/volatile automatically
if boot id is same, just moves processing from user space to kernel
space. But user space tools can do the same thing as well. So I am
not sure why not teach user space tools to manage incompat/volatile
directory.

Havind said that, I am not opposed to the idea of keeping track of "boot id"
in kernel removing incomapt/volatile automatically on next mount if
boot id is same. 

Thanks
Vivek


> 
> [1]: https://lwn.net/Articles/752063/
> [2]: https://lwn.net/Articles/724307/
> [3]: https://www.usenix.org/system/files/atc20-rebello.pdf
> [4]: https://www.postgresql.org/message-id/flat/CAMsr%2BYHh%2B5Oq4xziwwoEfhoTZgr07vdGG%2Bhu%3D1adXx59aTeaoQ%40mail.gmail.com
> 

