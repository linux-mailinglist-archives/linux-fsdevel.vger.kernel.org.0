Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5387554798
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbiFVJeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 05:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFVJeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:34:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479E113EBF;
        Wed, 22 Jun 2022 02:34:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 06D9321C60;
        Wed, 22 Jun 2022 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655890444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqg1G+JGmfwQn3A7mDV06jnT7fZUvd+1ZQPzVXGxm5E=;
        b=nOtAyC0u83M4uqNUmcX3YeY1xVmCtwJHnhyMMRXPgu292R8APT09kx3X+HDu0KK6v8yqx/
        Tv0+JhkuyQ3qxVRZHEIMo3muXnZElDPBA2kQTwfIi97ibcMulYJznd4I3dPe7lgEXTzGXo
        PlEw12la8zKzariyLdDZ3NcsNgRUINA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655890444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqg1G+JGmfwQn3A7mDV06jnT7fZUvd+1ZQPzVXGxm5E=;
        b=i3z1/WKnFKwlXdpU5GcQk/tS2QmPvxCR5uJsVP1d2k6i0yiZ9VzbS5kg3vEzB3r+4dIkDp
        kprtyvNnI1Eu6wAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E07542C141;
        Wed, 22 Jun 2022 09:34:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 918DCA062B; Wed, 22 Jun 2022 11:34:03 +0200 (CEST)
Date:   Wed, 22 Jun 2022 11:34:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20220622093403.hvsk2zmlw7o37phe@quack3.lan>
References: <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
 <20220620091136.4uosazpwkmt65a5d@quack3.lan>
 <CAOQ4uxg+uY5PdcU1=RyDWCxbP4gJB3jH1zkAj=RpfndH9czXbg@mail.gmail.com>
 <20220621085956.y5wyopfgzmqkaeiw@quack3.lan>
 <CAOQ4uxheatf+GCHxbUDQ4s4YSQib3qeYVeXZwEicR9fURrEFBA@mail.gmail.com>
 <YrKLG6YhMS+qLl8B@casper.infradead.org>
 <CAOQ4uxgYbVOSDwufPFvbNwsxnzzseNH9guwxZvP43vMmOFqq+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgYbVOSDwufPFvbNwsxnzzseNH9guwxZvP43vMmOFqq+Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-06-22 12:00:35, Amir Goldstein wrote:
> On Wed, Jun 22, 2022 at 6:23 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jun 21, 2022 at 03:53:33PM +0300, Amir Goldstein wrote:
> > > On Tue, Jun 21, 2022 at 11:59 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Tue 21-06-22 10:49:48, Amir Goldstein wrote:
> > > > > > How exactly do you imagine the synchronization of buffered read against
> > > > > > buffered write would work? Lock all pages for the read range in the page
> > > > > > cache? You'd need to be careful to not bring the machine OOM when someone
> > > > > > asks to read a huge range...
> > > > >
> > > > > I imagine that the atomic r/w synchronisation will remain *exactly* as it is
> > > > > today by taking XFS_IOLOCK_SHARED around generic_file_read_iter(),
> > > > > when reading data into user buffer, but before that, I would like to issue
> > > > > and wait for read of the pages in the range to reduce the probability
> > > > > of doing the read I/O under XFS_IOLOCK_SHARED.
> > > > >
> > > > > The pre-warm of page cache does not need to abide to the atomic read
> > > > > semantics and it is also tolerable if some pages are evicted in between
> > > > > pre-warn and read to user buffer - in the worst case this will result in
> > > > > I/O amplification, but for the common case, it will be a big win for the
> > > > > mixed random r/w performance on xfs.
> > > > >
> > > > > To reduce risk of page cache thrashing we can limit this optimization
> > > > > to a maximum number of page cache pre-warm.
> > > > >
> > > > > The questions are:
> > > > > 1. Does this plan sound reasonable?
> > > >
> > > > Ah, I see now. So essentially the idea is to pull the readahead (which is
> > > > currently happening from filemap_read() -> filemap_get_pages()) out from under
> > > > the i_rwsem. It looks like a fine idea to me.
> > >
> > > Great!
> > > Anyone doesn't like the idea or has another suggestion?
> >
> > I guess I'm still confused.
> >
> > The problem was the the XFS IOLOCK was being held while we waited for
> > readahead to complete.  To fix this, you're planning on waiting for
> > readahead to complete with the invalidate lock held?  I don't see the
> > benefit.
> >
> > I see the invalidate_lock as being roughly equivalent to the IOLOCK,
> > just pulled up to the VFS.  Is that incorrect?
> >
> 
> This question coming from you really shakes my confidence.
> 
> This entire story started from the observation that xfs performance
> of concurrent mixed rw workload is two orders of magnitude worse
> than ext4 on slow disk.
> 
> The reason for the difference was that xfs was taking the IOLOCK
> shared on reads and ext4 did not.
> 
> That had two very different reasons:
> 1. POSIX atomic read/write semantics unique to xfs
> 2. Correctness w.r.t. races with punch hole etc, which lead to the
>     conclusion that all non-xfs filesystems are buggy in that respect
> 
> The solution of pulling IOLOCK to vfs would have solved the bug
> but at the cost of severely regressing the mix rw workload on all fs.
> 
> The point of Jan's work on invalidate_lock was to fix the bug and
> avoid the regression. I hope that worked out, but I did not test
> the mixed rw workload on ext4 after invalidate_lock.

Yes, it did work out :)

> IIUC, ideally, invalidate_lock was supposed to be taken only for
> adding pages to page cache and locking them, but not during IO
> in order to synchronize against truncating pages (punch hole).
> But from this comment in filemap_create_folio() I just learned
> that that is not exactly the case:
> "...Note that we could release invalidate_lock after inserting the
>  folio into the page cache as the locked folio would then be enough
>  to synchronize with hole punching. But..."
> 
> Even so, because invalidate_lock is not taken by writers and reader
> that work on existing pages and because invalidate_lock is not held
> for the entire read/write operation, statistically it should be less
> contended than IOLOCK for some workloads, but I am afraid that
> for the workload I tested (bs=8K and mostly cold page cache) it will
> be contended with current vfs code.

Well, the rules are: When you are adding pages to the page cache you need
to either hold i_rwsem or invalidate_lock at least in shared mode. Places
removing underlying storage from the page cache pages are responsible for
holding both i_rwsem and invalidate_lock in exclusive mode. Writes
generally hold i_rwsem exclusive (or shared for overwriting direct IO),
reads hold invalidate_lock shared. So there will not be contention on
invalidate_lock as such for a mixed rw workload, except for the internal
contention of the shared invalidate_lock holders on the cacheline holding
the invalidate_lock (which is non-negligible as well in heavily parallel
loads but that's a separate story).

> I am going to go find a machine with slow disk to test the random rw
> workload again on both xfs and ext4 pre and post invalidate_lock and
> to try out the pre-warm page cache solution.
> 
> The results could be:
> a) ext4 random rw performance has been degraded by invalidate_lock
> b) pre-warm page cache before taking IOLOCK is going to improve
>     xfs random rw performance
> c) A little bit of both

Well, numbers always beat the theory so I'm all for measuring it but let me
say our kernel performance testing within SUSE didn't show significant hit
being introduced by invalidate_lock for any major filesystem.

I hope this clears out things a bit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
