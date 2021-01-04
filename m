Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976BB2E983A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 16:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbhADPQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 10:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhADPQE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609773276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJPThqtFDgmgtyz6ou+H0RV68QeyqTC/g/rtEO/kauE=;
        b=cTrwpeaKWVo3zjD1OLzwnjx37NAGXvmjOMIa8z0VhKqcl/4EwWFRABZhbmXIlMXCa39bbh
        wWgv1nqLIGV5Ce6kdRxYxOgwEtg7P27s3gvyICcAPXRuQedPMJIAKjgMGtpy9dPFh8h9gt
        gzc+fIBtLpfb+k7DXcVSC4P8A61WneE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-gHrnaWdNPySuz2vPbPpomw-1; Mon, 04 Jan 2021 10:14:33 -0500
X-MC-Unique: gHrnaWdNPySuz2vPbPpomw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5590E802B4C;
        Mon,  4 Jan 2021 15:14:31 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F03501001281;
        Mon,  4 Jan 2021 15:14:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7146E220BCF; Mon,  4 Jan 2021 10:14:24 -0500 (EST)
Date:   Mon, 4 Jan 2021 10:14:24 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20210104151424.GA63879@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 11:32:55AM +0200, Amir Goldstein wrote:
> On Wed, Dec 23, 2020 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 23, 2020 at 08:21:41PM +0000, Sargun Dhillon wrote:
> > > On Wed, Dec 23, 2020 at 08:07:46PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Dec 23, 2020 at 07:29:41PM +0000, Sargun Dhillon wrote:
> > > > > On Wed, Dec 23, 2020 at 06:50:44PM +0000, Matthew Wilcox wrote:
> > > > > > On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> > > > > > > I fail to see why this is neccessary if you incorporate error reporting into the
> > > > > > > sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> > > > > > > patch that adds the 2nd flag to errseq for "observed", you should be able to
> > > > > > > stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> > > > > > > in there instead instead of adding this new infrastructure.
> > > > > >
> > > > > > You still haven't explained why you want to add the "observed" flag.
> > > > >
> > > > >
> > > > > In the overlayfs model, many users may be using the same filesystem (super block)
> > > > > for their upperdir. Let's say you have something like this:
> > > > >
> > > > > /workdir [Mounted FS]
> > > > > /workdir/upperdir1 [overlayfs upperdir]
> > > > > /workdir/upperdir2 [overlayfs upperdir]
> > > > > /workdir/userscratchspace
> > > > >
> > > > > The user needs to be able to do something like:
> > > > > sync -f ${overlayfs1}/file
> > > > >
> > > > > which in turn will call sync on the the underlying filesystem (the one mounted
> > > > > on /workdir), and can check if the errseq has changed since the overlayfs was
> > > > > mounted, and use that to return an error to the user.
> > > >
> > > > OK, but I don't see why the current scheme doesn't work for this.  If
> > > > (each instance of) overlayfs samples the errseq at mount time and then
> > > > check_and_advances it at sync time, it will see any error that has occurred
> > > > since the mount happened (and possibly also an error which occurred before
> > > > the mount happened, but hadn't been reported to anybody before).
> > > >
> > >
> > > If there is an outstanding error at mount time, and the SEEN flag is unset,
> > > subsequent errors will not increment the counter, until the user calls sync on
> > > the upperdir's filesystem. If overlayfs calls check_and_advance on the upperdir's
> > > super block at any point, it will then set the seen block, and if the user calls
> > > syncfs on the upperdir, it will not return that there is an outstanding error,
> > > since overlayfs just cleared it.
> >
> > Your concern is this case:
> >
> > fs is mounted on /workdir
> > /workdir/A is written to and then closed.
> > writeback happens and -EIO happens, but there's nobody around to care.
> > /workdir/upperdir1 becomes part of an overlayfs mount
> > overlayfs samples the error
> > a user writes to /workdir/B, another -EIO occurs, but nothing happens
> > someone calls syncfs on /workdir/upperdir/A, gets the EIO.
> > a user opens /workdir/B and calls syncfs, but sees no error
> >
> > do i have that right?  or is it something else?
> 
> IMO it is something else. Others may disagree.
> IMO the level of interference between users accessing overlay and users
> accessing upper fs directly is not well defined and it can stay this way.
> 
> Concurrent access to  /workdir/upperdir/A via overlay and underlying fs
> is explicitly warranted against in Documentation/filesystems/overlayfs.rst#
> Changes to underlying filesystems:
> "Changes to the underlying filesystems while part of a mounted overlay
> filesystem are not allowed.  If the underlying filesystem is changed,
> the behavior of the overlay is undefined, though it will not result in
> a crash or deadlock."

I think people use same underlying filesystem both as upper for multiple
overlayfs mounts as well as root filesystem. For example, when you
run podman (or docker), they all share same filesystem for all containers
as well as other non-containered apps use same filesystem.

IIUC, what we meant to say is that lowerdir/workdir/upperdir being
used for overlayfs mount should be left untouched. Right?

What I am trying to say is that while discussing this problem and
solution, we should assume that both a regular application might
be using same upper fs as being used by overlayfs. It seems to
be a very common operating model.

> 
> The question is whether syncfs(open(/workdir/B)) is considered
> "Changes to the underlying filesystems". Regardless of the answer,
> this is not an interesting case IMO.
> 
> The real issue is with interference between overlays that share the
> same upper fs, because this is by far and large the common use case
> that is creating real problems for a lot of container users.
> 
> Workloads running inside containers (with overlayfs storage driver)
> will never be as isolated as workloads running inside VMs, but it
> doesn't mean we cannot try to improve.
> 
> In current master, syncfs() on any file by any container user will
> result in full syncfs() of the upperfs, which is very bad for container
> isolation. This has been partly fixed by Chengguang Xu [1] and I expect
> his work will be merged soon. Overlayfs still does not do the writeback
> and syncfs() in overlay still waits for all upper fs writeback to complete,
> but at least syncfs() in overlay only kicks writeback for upper fs files
> dirtied by this overlay.
> 
> [1] https://lore.kernel.org/linux-unionfs/CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com/
> 
> Sharing the same SEEN flag among thousands of containers is also
> far from ideal, because effectively this means that any given workload
> in any single container has very little chance of observing the SEEN flag.
> 
> To this end, I do agree with Matthew that overlayfs should sample errseq
> and the best patchset to implement it so far IMO is Jeff's patchset [2].
> This patch set was written to cater only "volatile" overlayfs mount, but
> there is no reason not to use the same mechanism for regular overlay
> mount. The only difference being that "volatile" overlay only checks for
> error since mount on syncfs() (because "volatile" overlay does NOT
> syncfs upper fs) and regular overlay checks and advances the overlay's
> errseq sample on syncfs (and does syncfs upper fs).
> 
> Matthew, I hope that my explanation of the use case and Jeff's answer
> is sufficient to understand why the split of the SEEN flag is needed.
> 
> [2] https://lore.kernel.org/linux-unionfs/20201213132713.66864-1-jlayton@kernel.org/
> 
> w.r.t Vivek's patchset (this one), I do not object to it at all, but it fixes
> a problem that Jeff's patch had already solved with an ugly hack:
> 
>   /* Propagate errors from upper to overlayfs */
>   ret = errseq_check(&upper_sb->s_wb_err, ofs->err_mark);
>   errseq_set(&sb->s_wb_err, ret);
> 
> Since Jeff's patch is minimal, I think that it should be the fix applied
> first and proposed for stable (with adaptations for non-volatile overlay).

Does stable fix has to be same as mainline fix. IOW, I think atleast in
mainline we should first fix it the right way and then think how to fix
it for stable. If fixes taken in mainline are not realistic for stable,
can we push a different small fix just for stable?

IOW, because we have to push a fix in stable, should not determine
what should be problem solution for mainline, IMHO.

The porblem I have with Jeff's fix is that its only works for volatile
mounts. While I prefer a solution where syncfs() is fixed both for
volatile as well as non-volatile mount and then there is less confusion.

Thanks
Vivek

> 
> I guess that Vivek's patch 1/3 from this series [3] is also needed to
> complement the work that should go to stable.
> 
> Vivek, Sargun,
> 
> Do you understand my proposal?
> Do you agree with it as a way forward to address the various syncfs
> issues for volatile/non-volatile that both of you were trying to address?
> 
> Sargun, I know this all discussion has forked from your volatile re-use
> patch set, but let's not confuse fsdevel forks more than we have to.
> The way forward for volatile re-use from this proposal is straight forward.
> 
> Thanks,
> Amir.
> 

