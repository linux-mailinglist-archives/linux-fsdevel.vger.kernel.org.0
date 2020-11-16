Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531512B4B5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbgKPQgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 11:36:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732174AbgKPQgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605544582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AnF19h0/Bg3ioIc8KfGyvnnvyTd5SmkkV6gQbOD3kng=;
        b=P+HDnTjLpx46wKxKd52GsTyD/RGY1sUv6VCP1EevztTCbC+5D3uV0x47k3NatAhR1GbP6u
        hPD6Gnyns20vBS1mGKKacY8SZZFSS6RmMS9u6WC9I1m6Bi4jar0N22etyxavqBBZ+GkP7g
        fNBWUGA+G/hyvOb9NBW+SPehFlCBHfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-rrYFtC1KOvGyvkiXIReTeQ-1; Mon, 16 Nov 2020 11:36:18 -0500
X-MC-Unique: rrYFtC1KOvGyvkiXIReTeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B78F91084C8A;
        Mon, 16 Nov 2020 16:36:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-201.rdu2.redhat.com [10.10.114.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27A2560BF1;
        Mon, 16 Nov 2020 16:36:16 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id B1C46220BCF; Mon, 16 Nov 2020 11:36:15 -0500 (EST)
Date:   Mon, 16 Nov 2020 11:36:15 -0500
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
Message-ID: <20201116163615.GA17680@redhat.com>
References: <20201116045758.21774-1-sargun@sargun.me>
 <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com>
 <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:20:04PM +0200, Amir Goldstein wrote:
> On Mon, Nov 16, 2020 at 4:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Sun, Nov 15, 2020 at 08:57:58PM -0800, Sargun Dhillon wrote:
> > > Overlayfs added the ability to setup mounts where all syncs could be
> > > short-circuted in (2a99ddacee43: ovl: provide a mount option "volatile").
> > >
> > > A user might want to remount this fs, but we do not let the user because
> > > of the "incompat" detection feature. In the case of volatile, it is safe
> > > to do something like[1]:
> > >
> > > $ sync -f /root/upperdir
> > > $ rm -rf /root/workdir/incompat/volatile
> > >
> > > There are two ways to go about this. You can call sync on the underlying
> > > filesystem, check the error code, and delete the dirty file if everything
> > > is clean. If you're running lots of containers on the same filesystem, or
> > > you want to avoid all unnecessary I/O, this may be suboptimal.
> > >
> >
> > Hi Sargun,
> >
> > I had asked bunch of questions in previous mail thread to be more
> > clear on your requirements but never got any response. It would
> > have helped understanding your requirements better.
> >
> > How about following patch set which seems to sync only dirty inodes of
> > upper belonging to a particular overlayfs instance.
> >
> > https://lore.kernel.org/linux-unionfs/20201113065555.147276-1-cgxu519@mykernel.net/
> >
> > So if could implement a mount option which ignores fsync but upon
> > syncfs, only syncs dirty inodes of that overlayfs instance, it will
> > make sure we are not syncing whole of the upper fs. And we could
> > do this syncing on unmount of overlayfs and remove dirty file upon
> > successful sync.
> >
> > Looks like this will be much simpler method and should be able to
> > meet your requirements (As long as you are fine with syncing dirty
> > upper inodes of this overlay instance on unmount).
> >
> 
> Do note that the latest patch set by Chengguang not only syncs dirty
> inodes of this overlay instance, but also waits for in-flight writeback on
> all the upper fs inodes and I think that with !ovl_should_sync(ofs)
> we will not re-dirty the ovl inodes and lose track of the list of dirty
> inodes - maybe that can be fixed.
> 
> Also, I am not sure anymore that we can safely remove the dirty file after
> sync dirty inodes sync_fs and umount. If someone did sync_fs before us
> and consumed the error, we may have a copied up file in upper whose
> data is not on disk, but when we sync_fs on unmount we won't get an
> error? not sure.

May be we can save errseq_t when mounting overlay and compare with
errseq_t stored in upper sb after unmount. That will tell us whether
error has happened since we mounted overlay. (Similar to what Sargun
is doing).

In fact, if this is a concern, we have this issue with user space
"sync <upper>" too? Other sync might fail and this one succeeds
and we will think upper is just fine. May be container tools can
keep a file/dir open at the time of mount and call syncfs using
that fd instead. (And that should catch errors since that fd
was opened, I am assuming).

> 
> I am less concerned about ways to allow re-mount of volatile
> overlayfs than I am about turning volatile overlayfs into non-volatile.

If we are not interested in converting volatile containers into
non-volatile, then whole point of these patch series is to detect
if any writeback error has happened or not. If writeback error has
happened, then we detect that at remount and possibly throw away
container.

What happens today if writeback error has happened. Is that page thrown
away from page cache and read back from disk? IOW, will user lose
the data it had written in page cache because writeback failed. I am
assuming we can't keep the dirty page around for very long otherwise
it has potential to fill up all the available ram with dirty pages which
can't be written back.

Why is it important to detect writeback error only during remount. What
happens if container overlay instance is already mounted and writeback
error happens. We will not detct that, right?

IOW, if capturing writeback error is important for volatile containers,
then capturing it only during remount time is not enough. Normally
fsync/syncfs should catch it and now we have skipped those, so in
the process we lost mechanism to detect writeback errrors for
volatile containers?

Thanks
Vivek

