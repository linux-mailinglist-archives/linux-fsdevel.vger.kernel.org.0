Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169902CF048
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 16:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgLDPCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 10:02:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25930 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729365AbgLDPCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607094057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mmx0JZlb2QL53Mp4XiOSbQWnD7bPOInKrGV4IWIsaSI=;
        b=BLzqPlOCvQySXg7mozRDn3sXVymromTlQSMezyp8629B4SzSFs75vOeGxyq94vVdTsuxHA
        pJC1oBA5Jiy+/8QWt1PxDH527Kf22AEAMBNw05BABkNB4g648Jv7QhXvzICUmnYc5uVPe8
        0BGCRAw8GzesJ/gh3PB7GSmNbfEtmSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-Y8nHkq6qOAinzwkcclCk-g-1; Fri, 04 Dec 2020 10:00:55 -0500
X-MC-Unique: Y8nHkq6qOAinzwkcclCk-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC73D100C607;
        Fri,  4 Dec 2020 15:00:53 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-112.rdu2.redhat.com [10.10.113.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E9EF1A839;
        Fri,  4 Dec 2020 15:00:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 22E71220BCF; Fri,  4 Dec 2020 10:00:51 -0500 (EST)
Date:   Fri, 4 Dec 2020 10:00:51 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error
 behaviour
Message-ID: <20201204150051.GC3328@redhat.com>
References: <20201203104225.GA30173@ircssh-2.c.rugged-nimbus-611.internal>
 <20201203142712.GA3266@redhat.com>
 <93894cddefff0118d8b1f5f69816da519cb0a735.camel@redhat.com>
 <CAMp4zn_Mn8khp43XvNbAPg5qzriRY6ozdB2enMOTYRLwcBf_Cw@mail.gmail.com>
 <e5534c44661a503102cd23965a85291f0dec907a.camel@redhat.com>
 <20201203204356.GF3266@redhat.com>
 <b38de55c91ecd7b1102c62cb36e81bb156748d1c.camel@redhat.com>
 <20201203222457.GB12683@redhat.com>
 <742b7c180d4fe18ddbf28fea6505b08475c4aace.camel@redhat.com>
 <CAOQ4uxgjrL3aCK+aO1Wrs7qaKWNmKnAWBQaDXO-hzCR4eBmdMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgjrL3aCK+aO1Wrs7qaKWNmKnAWBQaDXO-hzCR4eBmdMg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 04, 2020 at 08:45:16AM +0200, Amir Goldstein wrote:
> > > Here is the background.
> > >
> > > We introduced a new option "-o volatile" for overlayfs. What this option
> > > does is that it disables all calls to sync/syncfs/fsync and returns
> > > success.
> > >
> > > https://www.kernel.org/doc/html/latest/filesystems/overlayfs.html?highlight=overlayfs#volatile-mount
> > >
> > > Now one problem with this we realized is that what happens if there is
> > > a writeback error on upper filesystem. Previously fsync will catch
> > > that error and return to user space. Now we are not doing any actual
> > > sync for volatile mount, so we don't have a way to detect if any
> > > writeback error happened on upper filesystem.
> > >
> > > So it is possible that an application writes something to overlay
> > > volatile mount and gets back corrupted/old data.
> > >
> > > - App writes something.
> > > - Writeback of that page fails
> > > - app does fsync, which succeds without doing any sync.
> > > - app reads back page and can get old data if page has been evicted out
> > >   of cache.
> > >
> > > So we lost capability to return writeback errors to user space with
> > > volatile mounts. So Amir/Sargun proposed that lets take snapshot
> > > of upper ->s_wb_err when volatile overlay is being mounted. And
> > > on every sync/fsync call check if any error has happened on upper
> > > since volatile overlay has been mounted. If yes, return error to
> > > user space.
> > >
> > > In fact, Idea is that once an error has been detected, volatile
> > > overlay should effectively return -EIO for all the operations. IOW,
> > > one should now unmount it, throw away upper and restart again.
> > >
> > >
> > > > If it turns out that you just want to see if it ever had an error, you
> > > > can always use errseq_check with 0 as the "since" value and that will
> > > > tell you without marking or advancing anything. It's not clear to me
> > > > what the value of that is here though.
> > >
> > > I think "since == 0" will not work. Say upper already has an error
> > > (seen/unseen), then errseq_check() will always return error. We
> > > don't want that. We don't care if upper has an seen/unseen error
> > > at the time when we sample it. What we care about is that if
> > > there is an error after we sampled, we can detect that and make
> > > whole volatile mount bad.
> > >
> > > >
> > > > > So key requirement here seems to be being able to detect error
> > > > > on underlying superblock without consuming the unseen error.
> > > > >
> > > >
> > > > I think for overlayfs what you really want to do is basically "proxy"
> > > > fsync and syncfs calls to the upper layer. Then you should just be able
> > > > to use the upper layer's "realfile" when doing fsync/syncfs. You won't
> > > > need to sample anything at mount time that way as it should just happen
> > > > naturally when you open files on overlayfs.
> > >
> > > Which we already do, right? ovl_fsync()/ovl_sync() result in a
> > > call on upper. This probably can be improve futher.
> > >
> > > >
> > > > That does mean you may need to rework how the syncfs syscall dispatches
> > > > to the filesystem, but that's not too difficult in principle.
> > >
> > > I think we are looking at two overlay cases here. One is regular
> > > overlayfs where syncfs() needs to be reworked to propagate errors
> > > from upper/ to all the way to application. Right now VFS ignores
> > > error returned from ->sync_fs.
> > >
> > > The other case we are trying to solve right now is volatile mount.
> > > Where we will not actually call fsync/sync_filesystem() on upper
> > > but still want to detect if any error happened since we mounted
> > > this volatile mount.
> > >
> > > And that's why all this discussion of being able to detect an
> > > error on super block without actually consuming the error. Once
> > > we detect that some error has happened on upper since we mounted,
> > > we can start returning errors for all I/O operations to user and
> > > user is supposed to unmount and throw away upper dir and restart.
> > >
> >
> >
> > The problem here is that you want to be able to sample the thing in two
> > different ways such that you potentially get two different results
> > afterward:
> >
> > 1) the current syncfs/fsync case where we don't expect later openers to
> > be able to see the error after you take it.
> >
> > 2) the situation you want where you want to sample the errseq_t but
> > don't want to cloak an fsync on a subsequent open from seeing it
> >
> > That's fundamentally not going to work with the single SEEN flag we're
> > using now. I wonder if you could get you the semantics you want with 2
> > flags instead of 1. Basically, split the SEEN bit into two:
> >
> > 1) a bit to indicate that the counter doesn't need to be incremented the
> > next time an error is recorded (SKIP_INC)
> >
> > 2) a bit to indicate that the error has been reported in a way that was
> > returned to userland, such that later openers won't see it (SEEN)
> >
> > Then you could just add two different sorts of sampling functions. One
> > would set both bits when sampling (or advancing) and the other would
> > just set one of them.
> >
> > It's a bit more complicated than what we're doing now though and you'd
> > need to work through the logic of how the API would interact with both
> > flags.
> >
> 
> This discussion is a very good exercise for my brain ;-)
> but I think we are really over complicating the requirements of volatile.
> 
> My suggestion to sample sb error on mount was over-interpreted that
> we MUST disregard writeback errors that happened before the mount.
> I don't think this is a requirement. If anything, this is a non-requirement.
> Why? because what happens if someone unpacks the layers onto
> underlying fs (as docker most surely does) and then mounts the volatile
> overlay. The files data could have been lost in the time that passed between
> unpack of layer and overlay mount.

I think for unpacking layers one should not use volatile mounts. overlay
assumes lower layers are stable and do not have writeback errors. If
we use volatile mounts for unpacking layers, then unpacked layer (lower)
might have writeback errors and overlay will not detect it.

> 
> Of course overlayfs can not be held responsible for the integrity of the
> layers it was handed, but why work so hard to deprive users of something
> that can benefit the integrity of their system?
> 
> So I think we may be prudent and say that if there is an unseen error we
> should fail the volatile mount (say ESTALE).
> 
> This way userland has the fast path of mounting without syncfs in the
> common case and the fallback to slow path:
> - syncfs (consume the error)
> - unpack layers
> - volatile mount

That sounds reasonable too.
> 
> Doesn't this make sense *and* make life simpler?
> 
> 1. On volatile mount sample sb_err and make sure no unseen error
> 2. On fsync/syncfs verify no sb_err since mount

Thinking little bit more about why we are trying to determine sb_err
since mount. Why not detect error since realfile->f_sb_err instead
(As Jeff Layton suggested). I think this will allow more fine grained
error handling for volatile mounts. If fsync() returns error, then
one can get rid of that file and create new file without getting rid
of whole upper layer?

I think fsync() path probably is easy case where overlay could skip
actual fsync call but determine if there has been a writeback error on
file since realfile->f_sb_err and return error.

Given we actually don't do fsync(), we probably will have to do
error checks on other overlay paths like ovl_read_iter() to make
sure there have not been writeback errors on file otherwise
return -EIO instead.

->sync_fs is little tricky because first of all we don't pass
"struct file" and then we ignore return code from ->sync_fs. So
if we somehow fix all that than syncfs path could also be made
to check error on realfile->f_sb_err instead.

But problem with this is that it is complicated. And its not clear
how much are the gains due to this added complexity.

So probably for now it is better to stick to simpler idea of just fail
volatile mount on unseen errors and determine errors w.r.t ofs->s_wb_err
saved at mount time.

Thanks
Vivek

