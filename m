Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5414E2EB007
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 17:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbhAEQ2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 11:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725868AbhAEQ2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609864013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LUe4MFNSbFjHcEIv0kK9wumiX0gnLbIWW/ao7PC469E=;
        b=aUZzownA6QKqIQx1xFIU4GG4g1/3hteDsW2Ndc2h8zVX8Ujk8DO+GbOI20P1A8Olm468SL
        1ih6h+mTNyq0YRX647mYoR2KpeXXnedj908pCK1IUvPuC1kfD3/3clzu4bGnsKlKEv2uGK
        LEKMHATTZsJLmyVmd1zhTbhymQPDqFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-cZDdMYFZNfa-fReCkXKBHw-1; Tue, 05 Jan 2021 11:26:51 -0500
X-MC-Unique: cZDdMYFZNfa-fReCkXKBHw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509FE10054FF;
        Tue,  5 Jan 2021 16:26:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-227.rdu2.redhat.com [10.10.117.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA4660BFA;
        Tue,  5 Jan 2021 16:26:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E937F220BCF; Tue,  5 Jan 2021 11:26:46 -0500 (EST)
Date:   Tue, 5 Jan 2021 11:26:46 -0500
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
Message-ID: <20210105162646.GD3200@redhat.com>
References: <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com>
 <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
 <20210104154015.GA73873@redhat.com>
 <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
 <20210104224447.GG63879@redhat.com>
 <CAOQ4uxh07Rqj88PDNVqzq9D28rp+Z2aRtPvNoapeaH5iZWJr4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh07Rqj88PDNVqzq9D28rp+Z2aRtPvNoapeaH5iZWJr4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:11:23AM +0200, Amir Goldstein wrote:
> > >
> > > What I would rather see is:
> > > - Non-volatile: first syncfs in every container gets an error (nice to have)
> >
> > I am not sure why are we making this behavior per container. This should
> > be no different from current semantics we have for syncfs() on regular
> > filesystem. And that will provide what you are looking for. If you
> > want single error to be reported in all ovleray mounts, then make
> > sure you have one fd open in each mount after mount, then call syncfs()
> > on that fd.
> >
> 
> Ok.
> 
> > Not sure why overlayfs behavior/semantics should be any differnt
> > than what regular filessytems like ext4/xfs are offering. Once we
> > get page cache sharing sorted out with xfs reflink, then people
> > will not even need overlayfs and be able to launch containers
> > just using xfs reflink and share base image. In that case also
> > they will need to keep an fd open per container they want to
> > see an error in.
> >
> > So my patches exactly provide that. syncfs() behavior is same with
> > overlayfs as application gets it on other filesystems. And to me
> > its important to keep behavior same.
> >
> > > - Volatile: every syncfs and every fsync in every container gets an error
> > >   (important IMO)
> >
> > For volatile mounts, I agree that we need to fail overlayfs instance
> > as soon as first error is detected since mount. And this applies to
> > not only syncfs()/fsync() but to read/write and other operations too.
> >
> > For that we will need additional patches which are floating around
> > to keep errseq sample in overlay and check for errors in all
> > paths syncfs/fsync/read/write/.... and fail fs.
> 
> > But these patches build on top of my patches.
> 
> Here we disagree.
> 
> I don't see how Jeff's patch is "building on top of your patches"
> seeing that it is perfectly well contained and does not in fact depend
> on your patches.

Jeff's patches are solving problem only for volatile mounts and they
are propagating error to overlayfs sb.

My patches are solving the issue both for volatile mount as well as
non-volatile mounts and solve it using same method so there is no
confusion.

So there are multiple pieces to this puzzle and IMHO, it probably
should be fixed in this order.

A. First fix the syncfs() path to return error both for volatile as
   as well non-volatile mounts.

B. And then add patches to fail filesystem for volatile mount as soon
   as first error is detected (either in syncfs path or in other paths
   like read/write/...). This probably will require to save errseq
   in ovl_fs, and then compare with upper_sb in critical paths and fail
   filesystem as soon as error is detected.

C. Finally fix the issues related to mount/remount error detection which
   Sargun is wanting to fix. This will be largerly solved by B except
   saving errseq on disk.

My patches should fix the first problem. And more patches can be
applied on top to fix issue B and issue C.

Now if we agree with this, in this context I see that fixing problem
B and C is building on top of my patches which fixes problem A.

> 
> And I do insist that the fix for volatile mounts syncfs/fsync error
> reporting should be applied before your patches or at the very least
> not heavily depend on them.

I still don't understand that why volatile syncfs() error reporting
is more important than non-volatile syncfs(). But I will stop harping
on this point now.

My issue with Jeff's patches is that syncfs() error reporting should
be dealt in same way both for volatile and non-volatile mount. That
is compare file->f_sb_err and upper_sb->s_wb_err to figure out if
there is an error to report to user space. Currently this patches
only solve the problem for volatile mounts and use propagation to
overlay sb which is conflicting for non-volatile mounts.

IIUC, your primary concern with volatile mount is that you want to
detect as soon as writeback error happens, and flag it to container
manager so that container manager can stop container, throw away
upper layer and restart from scratch. If yes, what you want can
be solved by solving problem B and backporting it to LTS kernel.
I think patches for that will be well contained within overlayfs
(And no VFS) changes and should be relatively easy to backport.

IOW, backportability to LTS kernel should not be a concern/blocker
for my patch series which fixes syncfs() issue for overlayfs.

Thanks
Vivek

> 
> volatile mount was introduced in fresh new v5.10, which is also an
> LTS kernel. It would be inconsiderate of volatile mount users and developers
> to make backporting that fix to v5.10.y any harder than it should be.

> 
> > My patches don't solve this problem of failing overlay mount for
> > the volatile mount case.
> >
> 
> Here we agree.
> 
> > >
> > > This is why I prefer to sample upper sb error on mount and propagate
> > > new errors to overlayfs sb (Jeff's patch).
> >
> > Ok, I think this is one of the key points of the whole discussion. What
> > mechanism should be used to propagate writeback errors through overlayfs.
> >
> > A. Propagate errors from upper sb to overlay sb.
> > B. Leave overlay sb alone and use upper sb for error checks.
> >
> > We don't have good model to propagate errors between super blocks,
> > so Jeff preferred not to do error propagation between super blocks
> > for regular mounts.
> >
> > https://lore.kernel.org/linux-fsdevel/bff90dfee3a3392d67a4f3516ab28989e87fa25f.camel@kernel.org/
> >
> > If we are not defining new semantics for syncfs() for overlayfs, then
> > I can't see what's the advantage of coming up with new mechanism to
> > propagate errors to overlay sb. Approach B should work just fine and
> > provide the syncfs() semantics we want for overlayfs (Same semantics
> > as other filesystems).
> >
> 
> Ok. I am on board with B.
> 
> Philosophically. overlayfs model is somewhere between "passthrough"
> and "proxy" when handling pure upper files and as overlayfs evolves,
> it steadily moves towards the "proxy" model, with page cache and
> writeback being the largest remaining piece to convert.
> 
> So I concede that as long as overlayfs writeback is mostly passthrough,
> syncfs might as well be passthrough to upper fs as well.
> 
> Thanks,
> Amir.
> 

