Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2186E3975CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhFAOvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 10:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234066AbhFAOvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622558967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHVwFjE9EzHlAoKDHIhZ/cN4fpw36nakAmhnAU7TLrw=;
        b=IPzi+1MysHxGjPc+8Q+3WmBhmvObBxpauX0n1VdaooxqMTVsJTaUykvzBS2qk+8lSmwrpu
        sVuK1RWh3RfrfESxHRhom0EPQXC2WCD2ExpMu7N68vln3iXxyK/5vZAdWcSQ879gSQLmMT
        b63Z87q6Q2ln0ucBx2KpM54QB7gZNZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408--yWoyI9KPiGk3vZpMfzsog-1; Tue, 01 Jun 2021 10:49:24 -0400
X-MC-Unique: -yWoyI9KPiGk3vZpMfzsog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21D3B107464B;
        Tue,  1 Jun 2021 14:49:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-84.rdu2.redhat.com [10.10.115.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCDC460C0F;
        Tue,  1 Jun 2021 14:49:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 667FF22054F; Tue,  1 Jun 2021 10:49:09 -0400 (EDT)
Date:   Tue, 1 Jun 2021 10:49:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Max Reitz <mreitz@redhat.com>
Subject: Re: virtiofs uuid and file handles
Message-ID: <20210601144909.GC24846@redhat.com>
References: <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com>
 <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxgKr75J1YcuYAqRGC_C5H_mpCt01p5T9fHSuao_JnxcJA@mail.gmail.com>
 <CAJfpegviT38gja+-pE+5DCG0y9n3GUv4wWG_r3XmSWW6me88Cw@mail.gmail.com>
 <CAOQ4uxjNcWCfKLvdq2=TM5fE5RaBf+XvnsP6v_Q6u3b1_mxazw@mail.gmail.com>
 <CAJfpeguOLLV94Bzs7_JNOdZZ+6p-tcP7b1PXrQY4qWPxXKosnA@mail.gmail.com>
 <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiJRii2FQrX51ZDmw_kGWTNvL21J7=Ow_z6Th_O-aruDA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 31, 2021 at 09:12:59PM +0300, Amir Goldstein wrote:
> On Mon, May 31, 2021 at 5:11 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sat, 29 May 2021 at 18:05, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 2:12 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Wed, Sep 23, 2020 at 11:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > >
> > > > > > On Wed, Sep 23, 2020 at 4:49 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > > I think that the proper was to implement reliable persistent file
> > > > > > > handles in fuse/virtiofs would be to add ENCODE/DECODE to
> > > > > > > FUSE protocol and allow the server to handle this.
> > > > > >
> > > > > > Max Reitz (Cc-d) is currently looking into this.
> > > > > >
> > > > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > > > normally for all other operations.
> > > > > >
> > >
> > > Miklos, Max,
> > >
> > > Any updates on LOOKUP_HANDLE work?
> > >
> > > > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > > > based fs) would be that userspace need not keep a refcounted object
> > > > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > > > based cache at any time.   If that happens and a request from the
> > > > > > client (kernel) comes in with a stale node ID, the server will return
> > > > > > -ESTALE and the client can ask for a new node ID with a special
> > > > > > lookup_handle(fh, NULL).
> > > > > >
> > > > > > Disadvantages being:
> > > > > >
> > > > > >  - cost of generating a file handle on all lookups
> > > > >
> > > > > I never ran into a local fs implementation where this was expensive.
> > > > >
> > > > > >  - cost of storing file handle in kernel icache
> > > > > >
> > > > > > I don't think either of those are problematic in the virtiofs case.
> > > > > > The cost of having to keep fds open while the client has them in its
> > > > > > cache is much higher.
> > > > > >
> > > > >
> > > > > Sounds good.
> > > > > I suppose flock() does need to keep the open fd on server.
> > > >
> > > > Open files are a separate issue and do need an active object in the server.
> > > >
> > > > The issue this solves  is synchronizing "released" and "evicted"
> > > > states of objects between  server and client.  I.e. when a file is
> > > > closed (and no more open files exist referencing the same object) the
> > > > dentry refcount goes to zero but it remains in the cache.   In this
> > > > state the server could really evict it's own cached object, but can't
> > > > because the client can gain an active reference at any time  via
> > > > cached path lookup.
> > > >
> > > > One other solution would be for the server to send a notification
> > > > (NOTIFY_EVICT) that would try to clean out the object from the server
> > > > cache and respond with a FORGET if successful.   But I sort of like
> > > > the file handle one better, since it solves multiple problems.
> > > >
> > >
> > > Even with LOOKUP_HANDLE, I am struggling to understand how we
> > > intend to invalidate all fuse dentries referring to ino X in case the server
> > > replies with reused ino X with a different generation that the one stored
> > > in fuse inode cache.
> > >
> > > This is an issue that I encountered when running the passthrough_hp test,
> > > on my filesystem. In tst_readdir_big() for example, underlying files are being
> > > unlinked and new files created reusing the old inode numbers.
> > >
> > > This creates a situation where server gets a lookup request
> > > for file B that uses the reused inode number X, while old file A is
> > > still in fuse dentry cache using the older generation of real inode
> > > number X which is still in fuse inode cache.
> > >
> > > Now the server knows that the real inode has been rused, because
> > > the server caches the old generation value, but it cannot reply to
> > > the lookup request before the old fuse inode has been invalidated.
> > > IIUC, fuse_lowlevel_notify_inval_inode() is not enough(?).
> > > We would also need to change fuse_dentry_revalidate() to
> > > detect the case of reused/invalidated inode.
> > >
> > > The straightforward way I can think of is to store inode generation
> > > in fuse_dentry. It won't even grow the size of the struct.
> > >
> > > Am I over complicating this?
> >
> > In this scheme the generation number is already embedded in the file
> > handle.  If LOOKUP_HANDLE returns a nodeid that can be found in the
> > icache, but which doesn't match the new file handle, then the old
> > inode will be marked bad and a new one allocated.
> >
> > Does that answer your worries?  Or am I missing something?
> 
> It affirms my understanding of the future implementation, but
> does not help my implementation without protocol changes.
> I thought I could get away without LOOKUP_HANDLE for
> underlying fs that is able to resolve by ino, but seems that I still have an
> unhandled corner case, so will need to add some kernel patch.
> Unless there is already a way to signal from server to make the
> inode bad in a synchronous manner (I did not find any) before
> replying to LOOKUP with a new generation of the same ino.
> 
> Any idea about the timeline for LOOKUP_HANDLE?
> I may be able to pick this up myself if there is no one actively
> working on it or plans for anyone to make this happen.

AFAIK, right now max is not actively looking into LOOKUP_HANDLE.

To solve the issue of virtiofs server having too many fds open, he
is now planning to store corresonding file handle in server and use
that to open fd later.

But this does not help with persistent file handle issue for fuse
client.

BTW, one concern with file handles coming from guest kernel was that
how to trust those handles. Guest can create anything and use
file server to open the files on same filesystem (but not shared
with guest). 

I am assuming same concern should be there with non-virtiofs use
cases. Regular fuse client must be sending a file handle and
file server is running with CAP_DAC_READ_SEARCH. How will it make
sure that client is not able to access files not exported through
shared directory but are present on same filesystem.

Thanks
Vivek

