Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E622EA025
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 23:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhADWqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 17:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbhADWqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609800295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/DWUYY4paJGpoEUp4OUeGMhlHKwV3cu6CkyK0l0C8TE=;
        b=MELGGdgT2k3q8R7qvmWPW9SnIpIo/8ryNwn+IwihTSrXbIb3UCe8aRkewEh+4u7pfvOfOm
        TclC5g591XQmv7y2gdda9xW5fmupFqIyVRZZvaAlfo4TQhVgswQGRAer12hyYuDyaUPR/d
        D2uqgRngc7z5753OoFKm9Y9j91fjWFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-pWvSCnITP3WxgW-snT8KDQ-1; Mon, 04 Jan 2021 17:44:51 -0500
X-MC-Unique: pWvSCnITP3WxgW-snT8KDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D6610054FF;
        Mon,  4 Jan 2021 22:44:48 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E792710023B2;
        Mon,  4 Jan 2021 22:44:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7246C220BCF; Mon,  4 Jan 2021 17:44:47 -0500 (EST)
Date:   Mon, 4 Jan 2021 17:44:47 -0500
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
Message-ID: <20210104224447.GG63879@redhat.com>
References: <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com>
 <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
 <20210104154015.GA73873@redhat.com>
 <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhYXeUt2iggM3oubdgr91QPNhUg2PdN128gRvR3rQoy1Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 11:42:51PM +0200, Amir Goldstein wrote:
> On Mon, Jan 4, 2021 at 5:40 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Mon, Jan 04, 2021 at 05:22:07PM +0200, Amir Goldstein wrote:
> > > > > Since Jeff's patch is minimal, I think that it should be the fix applied
> > > > > first and proposed for stable (with adaptations for non-volatile overlay).
> > > >
> > > > Does stable fix has to be same as mainline fix. IOW, I think atleast in
> > > > mainline we should first fix it the right way and then think how to fix
> > > > it for stable. If fixes taken in mainline are not realistic for stable,
> > > > can we push a different small fix just for stable?
> > >
> > > We can do a lot of things.
> > > But if we are able to create a series with minimal (and most critical) fixes
> > > followed by other fixes, it would be easier for everyone involved.
> >
> > I am not sure this is really critical. writeback error reporting for
> > overlayfs are broken since the beginning for regular mounts. There is no
> > notion of these errors being reported to user space. If that did not
> > create a major issue, then why suddenly volatile mounts make it
> > a critical issue.
> >
> 
> Volatile mounts didn't make this a critical issue.
> But this discussion made us notice a mildly serious issue.
> It is not surprising to me that users did not report this issue.
> Do you know what it takes for a user to notice that writeback had failed,
> but an application did fsync and error did not get reported?
> Filesystem durability guaranties are hard to prove especially with so
> many subsystem layers and with fsync that does return an error correctly.
> I once found a durability bug in fsync of xfs that existed for 12 years.
> That fact does not at all make it any less critical.
> 
> > To me we should fix the issue properly which is easy to maintain
> > down the line and then worry about doing a stable fix if need be.
> >
> > >
> > > >
> > > > IOW, because we have to push a fix in stable, should not determine
> > > > what should be problem solution for mainline, IMHO.
> > > >
> > >
> > > I find in this case there is a correlation between the simplest fix and the
> > > most relevant fix for stable.
> > >
> > > > The porblem I have with Jeff's fix is that its only works for volatile
> > > > mounts. While I prefer a solution where syncfs() is fixed both for
> > > > volatile as well as non-volatile mount and then there is less confusion.
> > > >
> > >
> > > I proposed a variation on Jeff's patch that covers both cases.
> > > Sargun is going to work on it.
> >
> > What's the problem with my patches which fixes syncfs() error reporting
> > for overlayfs both for volatile and non-volatile mount?
> >
> 
> - mount 1000 overlays
> - 1 writeback error recorded in upper sb
> - syncfs (new fd) inside each of the 1000 containers
> 
> With your patch 3/3 only one syncfs will report an error for
> both volatile and non-volatile cases. Right?

Right. If you don't have an old fd open in each container, then only
one container will see the error. If you want to see error in each
container, then one fd needs to be kept opened in each container
before error hapens and call syncfs() on that fd, and then each
container should see the error.

> 
> What I would rather see is:
> - Non-volatile: first syncfs in every container gets an error (nice to have)

I am not sure why are we making this behavior per container. This should
be no different from current semantics we have for syncfs() on regular
filesystem. And that will provide what you are looking for. If you
want single error to be reported in all ovleray mounts, then make
sure you have one fd open in each mount after mount, then call syncfs()
on that fd.

Not sure why overlayfs behavior/semantics should be any differnt
than what regular filessytems like ext4/xfs are offering. Once we
get page cache sharing sorted out with xfs reflink, then people
will not even need overlayfs and be able to launch containers
just using xfs reflink and share base image. In that case also
they will need to keep an fd open per container they want to
see an error in.

So my patches exactly provide that. syncfs() behavior is same with
overlayfs as application gets it on other filesystems. And to me
its important to keep behavior same.

> - Volatile: every syncfs and every fsync in every container gets an error
>   (important IMO)

For volatile mounts, I agree that we need to fail overlayfs instance
as soon as first error is detected since mount. And this applies to
not only syncfs()/fsync() but to read/write and other operations too.

For that we will need additional patches which are floating around
to keep errseq sample in overlay and check for errors in all
paths syncfs/fsync/read/write/.... and fail fs. But these patches
build on top of my patches. My patches don't solve this problem of
failing overlay mount for the volatile mount case.

> 
> This is why I prefer to sample upper sb error on mount and propagate
> new errors to overlayfs sb (Jeff's patch).

Ok, I think this is one of the key points of the whole discussion. What
mechanism should be used to propagate writeback errors through overlayfs.

A. Propagate errors from upper sb to overlay sb.
B. Leave overlay sb alone and use upper sb for error checks.

We don't have good model to propagate errors between super blocks,
so Jeff preferred not to do error propagation between super blocks
for regular mounts.

https://lore.kernel.org/linux-fsdevel/bff90dfee3a3392d67a4f3516ab28989e87fa25f.camel@kernel.org/

If we are not defining new semantics for syncfs() for overlayfs, then
I can't see what's the advantage of coming up with new mechanism to
propagate errors to overlay sb. Approach B should work just fine and
provide the syncfs() semantics we want for overlayfs (Same semantics
as other filesystems).

Having said that, I am open to the idea of propagating errors if that
makes implementation better. Its just an implementation detail to
me and user visible behavior should remain same.

> 
> I am very much in favor of your patch 1/3 and I am not against the concept
> of patches 2-3/3. Just think that ovl_errseq_check_advance() is not the
> implementation that gives the most desirable result.

I think this is the key point of contention. You seem to expecting
a different syncfs() behavior only for overlayfs and tying it to 
the notion of container. And I am wondering why it should be any
different from any other filesystem. And those who want to see
upper_sb error in each mounted overlay instance, they should keep
one fd open in overlay after mount.

So lets sort that out this syncfs() behavior part first before we
get to implementation details.

Thanks
Vivek

> 
> If people do accept my point of view that proxying the stacked error check
> is preferred over "passthrough" to upper sb error check, then as a by-product,
> the new ->check_error() method is not going to make much of a difference for
> overlayfs. Maybe it can be used to fine tune some corner cases.
> I am not sure.
> If we do agree on the propagate error concept then IMO all other use
> cases for not consuming the unseen error from upper fs are nice-to-have.
> 
> Before we continue to debate on the implementation, let's first try
> to agree on the desired behavior, what is a must vs. what is nice to have.
> Without consensus on this, it will be quite hard to converge.
> 
> Another thing, to help everyone, I think it is best that any patch on ovl_syncfs
> "solutions" will include detailed description of the use cases it solves and
> the use cases that it leaves unsolved.
> 
> Thanks,
> Amir.
> 

