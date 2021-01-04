Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D92E9938
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 16:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhADPxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 10:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbhADPxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609775510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPenzFaOaNF+XEZpuBxT4mC/+Ndsh8NvggyAPKSYYZY=;
        b=E3OVPrWlnSoMywX9twHp0u5HTx1m9/oJbrdDDmm46ngsgN5xa1zIagDwK4UH1/kyDcuMQO
        qz8FtTxmlpP/ws1pa8hCAEMEsiS5GL+vm6BOM+UGc8Ud102uVes6s07bZvC7vVUyKnoA9C
        DKH66TSQ3vq33tzY9A/5lachdsl5wBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-wfEEz5cnMOyj7-4nYMNi7Q-1; Mon, 04 Jan 2021 10:51:47 -0500
X-MC-Unique: wfEEz5cnMOyj7-4nYMNi7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2535D1927813;
        Mon,  4 Jan 2021 15:51:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A931810016FA;
        Mon,  4 Jan 2021 15:51:41 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3F355220BCF; Mon,  4 Jan 2021 10:51:41 -0500 (EST)
Date:   Mon, 4 Jan 2021 10:51:41 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20210104155141.GB63879@redhat.com>
References: <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20201224121352.GT874@casper.infradead.org>
 <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
 <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
 <CAOQ4uxjbkZ7Qb73fkXkxzmdcnfKt5AqQ3_m6DbqzeWs4tpDx7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjbkZ7Qb73fkXkxzmdcnfKt5AqQ3_m6DbqzeWs4tpDx7w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 28, 2020 at 05:51:06PM +0200, Amir Goldstein wrote:
> On Mon, Dec 28, 2020 at 3:25 PM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > On Fri, 2020-12-25 at 08:50 +0200, Amir Goldstein wrote:
> > > On Thu, Dec 24, 2020 at 2:13 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Thu, Dec 24, 2020 at 11:32:55AM +0200, Amir Goldstein wrote:
> > > > > In current master, syncfs() on any file by any container user will
> > > > > result in full syncfs() of the upperfs, which is very bad for container
> > > > > isolation. This has been partly fixed by Chengguang Xu [1] and I expect
> > > > > his work will be merged soon. Overlayfs still does not do the writeback
> > > > > and syncfs() in overlay still waits for all upper fs writeback to complete,
> > > > > but at least syncfs() in overlay only kicks writeback for upper fs files
> > > > > dirtied by this overlay.
> > > > >
> > > > > [1] https://lore.kernel.org/linux-unionfs/CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com/
> > > > >
> > > > > Sharing the same SEEN flag among thousands of containers is also
> > > > > far from ideal, because effectively this means that any given workload
> > > > > in any single container has very little chance of observing the SEEN flag.
> > > >
> > > > Perhaps you misunderstand how errseq works.  If each container samples
> > > > the errseq at startup, then they will all see any error which occurs
> > > > during their lifespan
> > >
> > > Meant to say "...very little chance of NOT observing the SEEN flag",
> > > but We are not in disagreement.
> > > My argument against sharing the SEEN flag refers to Vivek's patch of
> > > stacked errseq_sample()/errseq_check_and_advance() which does NOT
> > > sample errseq at overlayfs mount time. That is why my next sentence is:
> > > "I do agree with Matthew that overlayfs should sample errseq...".
> > >
> > > > (and possibly an error which occurred before they started up).
> > > >
> > >
> > > Right. And this is where the discussion of splitting the SEEN flag started.
> > > Some of us want to treat overlayfs mount time as a true epoc for errseq.
> > > The new container didn't write any files yet, so it should not care about
> > > writeback errors from the past.
> > >
> > > I agree that it may not be very critical, but as I wrote before, I think we
> > > should do our best to try and isolate container workloads.
> > >
> > > > > To this end, I do agree with Matthew that overlayfs should sample errseq
> > > > > and the best patchset to implement it so far IMO is Jeff's patchset [2].
> > > > > This patch set was written to cater only "volatile" overlayfs mount, but
> > > > > there is no reason not to use the same mechanism for regular overlay
> > > > > mount. The only difference being that "volatile" overlay only checks for
> > > > > error since mount on syncfs() (because "volatile" overlay does NOT
> > > > > syncfs upper fs) and regular overlay checks and advances the overlay's
> > > > > errseq sample on syncfs (and does syncfs upper fs).
> > > > >
> > > > > Matthew, I hope that my explanation of the use case and Jeff's answer
> > > > > is sufficient to understand why the split of the SEEN flag is needed.
> > > > >
> > > > > [2] https://lore.kernel.org/linux-unionfs/20201213132713.66864-1-jlayton@kernel.org/
> > > >
> > > > No, it still feels weird and wrong.
> > > >
> > >
> > > All right. Considering your reservations, I think perhaps the split of the
> > > SEEN flag can wait for a later time after more discussions and maybe
> > > not as suitable for stable as we thought.
> > >
> > > I think that for stable, it would be sufficient to adapt Surgun's original
> > > syncfs for volatile mount patch [1] to cover the non-volatile case:
> > > on mout:
> > > - errseq_sample() upper fs
> > > - on volatile mount, errseq_check() upper fs and fail mount on un-SEEN error
> > > on syncfs:
> > > - errseq_check() for volatile mount
> > > - errseq_check_and_advance() for non-volatile mount
> > > - errseq_set() overlay sb on upper fs error
> > >
> > > Now errseq_set() is not only a hack around __sync_filesystem ignoring
> > > return value of ->sync_fs(). It is really needed for per-overlay SEEN
> > > error isolation in the non-volatile case.
> > >
> > > Unless I am missing something, I think we do not strictly need Vivek's
> > > 1/3 patch [2] for stable, but not sure.
> > >
> > > Sargun,
> > >
> > > Do you agree with the above proposal?
> > > Will you make it into a patch?
> > >
> > > Vivek, Jefff,
> > >
> > > Do you agree that overlay syncfs observing writeback errors that predate
> > > overlay mount time is an issue that can be deferred (maybe forever)?
> > >
> >
> > That's very application dependent.
> >
> > To be clear, the main thing you'll lose with the method above is the
> > ability to see an unseen error on a newly opened fd, if there was an
> > overlayfs mount using the same upper sb before your open occurred.
> >
> > IOW, consider two overlayfs mounts using the same upper layer sb:
> >
> > ovlfs1                          ovlfs2
> > ----------------------------------------------------------------------
> > mount
> > open fd1
> > write to fd1
> > <writeback fails>
> >                                 mount (upper errseq_t SEEN flag marked)
> > open fd2
> > syncfs(fd2)
> > syncfs(fd1)
> >
> >
> > On a "normal" (non-overlay) fs, you'd get an error back on both syncfs
> > calls. The first one has a sample from before the error occurred, and
> > the second one has a sample of 0, due to the fact that the error was
> > unseen at open time.
> >
> > On overlayfs, with the intervening mount of ovlfs2, syncfs(fd1) will
> > return an error and syncfs(fd2) will not. If we split the SEEN flag into
> > two, then we can ensure that they both still get an error in this
> > situation.
> >
> 
> Either I am not following or we are not talking about the same solution.
> IMO it is perfectly fine the ovlfs2 mount consumes the unseen error
> on upper fs, because there is no conceptual difference between an overlay
> mount and any application that does syncfs().

I think currently mount() does not consume writeback errors on upper
filesystem. So if mount() of overlayfs notices an unseen error on
upper, and fails mount (without consuming upper sb error), then it should
be fine. We discussed that in past as well. You proposed it.

This will mean that user will need to call syncfs() on upper to clear
unseen error and then retry overlay mount. And this will not necessarily
need splitting SEEN flag. 

This requires calling syncfs() on upper in case of unseen error. And
Sargun wanted to avoid syncfs() on upper completely.

Vivek

> 
> However, in the situation that you describe, open fd2 is NOT supposed
> to sample upper fs errseq at all, it is supposed to sample ovlfs1's
> sb->s_wb_err.
> 
> syncfs(fd2) reports an error because ovl_check_sync(ofs) sees that
> ofs->upper_errseq sample is older than upper fs errseq.
> 
> If ovlfs1 is volatile, syncfs(fd1), returns an error for the same reason,
> because we never advance ofs->upper_errseq.
> 
> If ovlfs1 is non-volatile, the first syncfs(fd2) calls ovl_check_sync(ofs)
> that observes the upper fs error which is newer than ofs->upper_errseq
> and advances ofs->upper_errseq.
> But it also calls errseq_set(&sb->s_wb_err) (a.k.a. "the hack"),
> This will happen regardless of upper fs SEEN flag set by ovlfs2 mount.
> 
> The second syncfs(fd1) will also return an error because vfs had sampled
> an old errseq value of ovlfs1 sb->s_wb_err, before the call to errseq_set().
> 
> What am I missing?
> 
> Thanks,
> Amir.
> 

