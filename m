Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2182E65BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Dec 2020 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgL1N0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Dec 2020 08:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389499AbgL1N0d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:26:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 735BF2076D;
        Mon, 28 Dec 2020 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609161952;
        bh=+pGRaTYXGuT+i7lKG+XzG1sOtgcBMLjdE3eIEPblyw0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kWUxCMp1l/IksMCOI96IbM7QfatkfbLqK4pbz4y0LDIZ7OPq7jPGKkRLuRkoS7P91
         kmY1/Gvq3pnpVzx0p+jx0fYlSVVmQ2VE6zTh7HQTzWeBw2VSfSCUL+2x3iTZXRYX5m
         F3JOwh5LhkjJdqc/xnCNkTW09vbcPKTcybcQiCVjufVG2HAe3nb2wshNkU1EGr460D
         GpPR582rQAepjHgiuPl5l0b0x/7QZQv1p8EkTIDwFoaIQ1OWiPEAOfAbXZ1Jo+1cV8
         YxaLooruYu1/ASGuZnSPIhV89h9rFAPyBYwT4zOG3ZX7A2/bkSeZk00eyAwclddB0W
         kOPKvj15HDRsQ==
Message-ID: <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Date:   Mon, 28 Dec 2020 08:25:50 -0500
In-Reply-To: <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
         <20201221195055.35295-4-vgoyal@redhat.com>
         <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223185044.GQ874@casper.infradead.org>
         <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223200746.GR874@casper.infradead.org>
         <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223204428.GS874@casper.infradead.org>
         <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
         <20201224121352.GT874@casper.infradead.org>
         <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-25 at 08:50 +0200, Amir Goldstein wrote:
> On Thu, Dec 24, 2020 at 2:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > On Thu, Dec 24, 2020 at 11:32:55AM +0200, Amir Goldstein wrote:
> > > In current master, syncfs() on any file by any container user will
> > > result in full syncfs() of the upperfs, which is very bad for container
> > > isolation. This has been partly fixed by Chengguang Xu [1] and I expect
> > > his work will be merged soon. Overlayfs still does not do the writeback
> > > and syncfs() in overlay still waits for all upper fs writeback to complete,
> > > but at least syncfs() in overlay only kicks writeback for upper fs files
> > > dirtied by this overlay.
> > > 
> > > [1] https://lore.kernel.org/linux-unionfs/CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com/
> > > 
> > > Sharing the same SEEN flag among thousands of containers is also
> > > far from ideal, because effectively this means that any given workload
> > > in any single container has very little chance of observing the SEEN flag.
> > 
> > Perhaps you misunderstand how errseq works.  If each container samples
> > the errseq at startup, then they will all see any error which occurs
> > during their lifespan
> 
> Meant to say "...very little chance of NOT observing the SEEN flag",
> but We are not in disagreement.
> My argument against sharing the SEEN flag refers to Vivek's patch of
> stacked errseq_sample()/errseq_check_and_advance() which does NOT
> sample errseq at overlayfs mount time. That is why my next sentence is:
> "I do agree with Matthew that overlayfs should sample errseq...".
> 
> > (and possibly an error which occurred before they started up).
> > 
> 
> Right. And this is where the discussion of splitting the SEEN flag started.
> Some of us want to treat overlayfs mount time as a true epoc for errseq.
> The new container didn't write any files yet, so it should not care about
> writeback errors from the past.
> 
> I agree that it may not be very critical, but as I wrote before, I think we
> should do our best to try and isolate container workloads.
> 
> > > To this end, I do agree with Matthew that overlayfs should sample errseq
> > > and the best patchset to implement it so far IMO is Jeff's patchset [2].
> > > This patch set was written to cater only "volatile" overlayfs mount, but
> > > there is no reason not to use the same mechanism for regular overlay
> > > mount. The only difference being that "volatile" overlay only checks for
> > > error since mount on syncfs() (because "volatile" overlay does NOT
> > > syncfs upper fs) and regular overlay checks and advances the overlay's
> > > errseq sample on syncfs (and does syncfs upper fs).
> > > 
> > > Matthew, I hope that my explanation of the use case and Jeff's answer
> > > is sufficient to understand why the split of the SEEN flag is needed.
> > > 
> > > [2] https://lore.kernel.org/linux-unionfs/20201213132713.66864-1-jlayton@kernel.org/
> > 
> > No, it still feels weird and wrong.
> > 
> 
> All right. Considering your reservations, I think perhaps the split of the
> SEEN flag can wait for a later time after more discussions and maybe
> not as suitable for stable as we thought.
> 
> I think that for stable, it would be sufficient to adapt Surgun's original
> syncfs for volatile mount patch [1] to cover the non-volatile case:
> on mout:
> - errseq_sample() upper fs
> - on volatile mount, errseq_check() upper fs and fail mount on un-SEEN error
> on syncfs:
> - errseq_check() for volatile mount
> - errseq_check_and_advance() for non-volatile mount
> - errseq_set() overlay sb on upper fs error
> 
> Now errseq_set() is not only a hack around __sync_filesystem ignoring
> return value of ->sync_fs(). It is really needed for per-overlay SEEN
> error isolation in the non-volatile case.
> 
> Unless I am missing something, I think we do not strictly need Vivek's
> 1/3 patch [2] for stable, but not sure.
> 
> Sargun,
> 
> Do you agree with the above proposal?
> Will you make it into a patch?
> 
> Vivek, Jefff,
> 
> Do you agree that overlay syncfs observing writeback errors that predate
> overlay mount time is an issue that can be deferred (maybe forever)?
> 

That's very application dependent.

To be clear, the main thing you'll lose with the method above is the
ability to see an unseen error on a newly opened fd, if there was an
overlayfs mount using the same upper sb before your open occurred.

IOW, consider two overlayfs mounts using the same upper layer sb:

ovlfs1				ovlfs2
----------------------------------------------------------------------
mount
open fd1
write to fd1
<writeback fails>
				mount (upper errseq_t SEEN flag marked)
open fd2
syncfs(fd2)
syncfs(fd1)


On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
calls. The first one has a sample from before the error occurred, and
the second one has a sample of 0, due to the fact that the error was
unseen at open time.

On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
return an error and syncfs(fd2) will not. If we split the SEEN flag into
two, then we can ensure that they both still get an error in this
situation.

> BTW, in all the discussions we always assumed that stacked fsync() is correct
> WRT errseq, but in fact, fsync() can also observe an unseen error that predates
> overlay mount.
> In order to fix that, we will probably need to split the SEEN flag and some
> more errseq acrobatics, but again, not sure it is worth the effort.
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-unionfs/20201202092720.41522-1-sargun@sargun.me/
> [2] https://lore.kernel.org/linux-unionfs/20201222151752.GA3248@redhat.com/

-- 
Jeff Layton <jlayton@kernel.org>

