Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514B2E25E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLXKM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgLXKM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 05:12:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24335C06179C
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Dec 2020 02:12:19 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id n9so1649247ili.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Dec 2020 02:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUwm0gVsWo8y9LHRJ1ZlTosQ/7/vGvlJkzQTsq1DrVw=;
        b=QclUF3QYe73gnRoCxqINjWfoQUHkgLrNtbzwdgVTvQS1HTdSdhgg9omWmcqJee/8ti
         mytXRGRru4eF1vfotk17qt8sUz/wyVYUi2or83agnisc1O8o9dd6D3XcjF+6dR0keaxp
         A1HGM2soCtIdkHc2wKNC7kKfkKtH0ipbo378g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUwm0gVsWo8y9LHRJ1ZlTosQ/7/vGvlJkzQTsq1DrVw=;
        b=Y+bxhGngEfRtYLi9JTBxRWQmzAx5y4xwejsNM1FcWE8mwY28yhLEhpotsP4J1iTRzk
         585Nw+lOdAIY8TOFtYOAej84B/uSmdCcziecwZ9YfDgajB16WsSr0ywa2wVx2BrDxQvD
         oFowYkgT01VeHAoGYaHbnnanuqD6qzNIT/OPRm57s8Ui/RnAVIXvDwl+FAr15B4oq3NK
         LeJq88xubHO8pu5TkK/xoyW/YYZr58OseOdlGPjPMXysgbXcwyhjclHDAvdTokwjn9Dl
         W23KyT5TP/IFOGIAWMkYzTFKcSw8JLIc4A32QMIvtZtg9ZO2j3QOOTq/jkWkejW+49YM
         1cJQ==
X-Gm-Message-State: AOAM530z7Ks/xuNbri+m+SRNnFsukXg5qwlWsg7dcisrmo8ZRmLemUah
        mkU5TxeQwAsnlOEw8tJnEusViw==
X-Google-Smtp-Source: ABdhPJwcGndygZ1/wkF93QPKmbAT9OQw/YNZ4pWoJD+aR1az1TUeg4tLhw4ldj/d1tI5RZ7qoaonVw==
X-Received: by 2002:a92:b6c7:: with SMTP id m68mr28495276ill.95.1608804738213;
        Thu, 24 Dec 2020 02:12:18 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z8sm17968681iod.25.2020.12.24.02.12.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 02:12:17 -0800 (PST)
Date:   Thu, 24 Dec 2020 10:12:16 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201224101215.GA23046@ircssh-2.c.rugged-nimbus-611.internal>
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
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> 
> I guess that Vivek's patch 1/3 from this series [3] is also needed to
> complement the work that should go to stable.
> 
> Vivek, Sargun,
> 
> Do you understand my proposal?
Yes. I agree that Jeff's patch should be added to stable. The fact we don't
bubble up writeback errors turns out to be a real problem that I never knew
was happening, but upon investigating, it looks like a real thing.

I think we can use Jeff's hacky approach in stable, as it's far more minimal, 
and has a much lower chance of causing issues, but if we make further 
improvements, we wont be able to backport them to stable as easily. I have
nothing explicitly against Vivek's approach though.

> Do you agree with it as a way forward to address the various syncfs
> issues for volatile/non-volatile that both of you were trying to address?
Yes. I think Vivek's patchset of introducing a new superblock callback is
the best approach.

> 
> Sargun, I know this all discussion has forked from your volatile re-use
> patch set, but let's not confuse fsdevel forks more than we have to.
> The way forward for volatile re-use from this proposal is straight forward.

I think that Vivek's patchset of adding a new callback, plus Jeff's new flag 
solves detection of errors for normal mounts, volatile mounts, and volatile 
remounts.

I think I responded to Jeff's patch and it looked good, bar one of the loops.
My only suggestion is that someone add the intended behaviour here as comment
to super_ops of the new callback.
> 
> Thanks,
> Amir.
