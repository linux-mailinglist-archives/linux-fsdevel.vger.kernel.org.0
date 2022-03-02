Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6B4CA575
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiCBNEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242022AbiCBNEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2B74C248E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 05:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646226226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4jUwD5CmiGcFMIQc1HZrTQmpgea2cy6d4c1OFQ/588=;
        b=UBMxlAaL26dBLO8lSDHO1ns4lE3bVw3fpK5pnVbujpxidSY5I54oSVSW35BpfCSy0An6Ix
        qnCgii2XQZ6/h4zFWb9KrquRguBerFrhm0+rHanIFq9IbekVPZH+Rrh569kguySEpUffxS
        1ZEMXgLHPKXRgDO9HlPRdYAAkUkmnIc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-We428ybfP1KRjYQXrMz4Ng-1; Wed, 02 Mar 2022 08:03:43 -0500
X-MC-Unique: We428ybfP1KRjYQXrMz4Ng-1
Received: by mail-wr1-f72.google.com with SMTP id x15-20020a5d6b4f000000b001ee6c0aa287so619455wrw.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 05:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4jUwD5CmiGcFMIQc1HZrTQmpgea2cy6d4c1OFQ/588=;
        b=qdEWc016tMAb52oQ2WqHkJ1NKi2lEWDel7phkqai++08LYnotNp2pC0c4cAXns9mOD
         tL5eTAqK7cQVdDNDWDsvEKHOIQqhoOTysUjENC9W0mvyG+Fbxu8HeWXMucc7Fi5D2NfN
         EJH1+dL8Tiww3RKQmFMt4VAc6iBqz1fPoMZjSblYugYYuplrH5tLrAqFdSgjUYdPYR1G
         wSX55VsQqNWNJKNqJq08Ja5tI12ViPE7h2epfDrpcQMblP8eqr+7dfmkGjctQZOxdz6L
         7eFMQ34JehLRN1q1xUhiMuQ8pV0+J0nDC0xBPQQfKJAaLA2gdjse89X/r1nrrKLJD1Bx
         tgXg==
X-Gm-Message-State: AOAM531U93nYFUskB6r68j7xWdriOQMruBPNBIx4nJI3Kjklyl37aDZK
        ztNCfwqMStIOAY8PO5kza6VNbIKD1gr29tqFQ4rr+nRsRmkUp54ez9mt032vXSNQNW3oL1CxVyw
        UDFm/xvu8Ztj8I8cx198BzzCqn1RAwyuAarABfk80bA==
X-Received: by 2002:a5d:67ca:0:b0:1ed:d1e4:bce2 with SMTP id n10-20020a5d67ca000000b001edd1e4bce2mr22717389wrw.493.1646226220746;
        Wed, 02 Mar 2022 05:03:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+XpscBL2wfHTCik1tahwWVcz07rxvA/g/MFJrdyIBGmujyMJrPuE1lOaVi7g2ksDDmpxvaW5sb3t7HnD1jk8=
X-Received: by 2002:a5d:67ca:0:b0:1ed:d1e4:bce2 with SMTP id
 n10-20020a5d67ca000000b001edd1e4bce2mr22717362wrw.493.1646226220444; Wed, 02
 Mar 2022 05:03:40 -0800 (PST)
MIME-Version: 1.0
References: <1f34c8435fed21e9583492661ceb20d642a75699.1646058596.git.fdmanana@suse.com>
 <20220228223830.GR59715@dread.disaster.area> <Yh9EHfl3sYJHeo3T@debian9.Home>
In-Reply-To: <Yh9EHfl3sYJHeo3T@debian9.Home>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 2 Mar 2022 14:03:28 +0100
Message-ID: <CAHc6FU7jBeUEAaB0BupypG1zdxf4shF5T56cHZCD_xXi-jeB+Q@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix incomplete async dio reads when using IOMAP_DIO_PARTIAL
To:     Filipe Manana <fdmanana@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michael Kerrisk <mtk@man7.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 2, 2022 at 11:17 AM Filipe Manana <fdmanana@kernel.org> wrote:
> On Tue, Mar 01, 2022 at 09:38:30AM +1100, Dave Chinner wrote:
> > On Mon, Feb 28, 2022 at 02:32:03PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Some users recently reported that MariaDB was getting a read corruption
> > > when using io_uring on top of btrfs. This started to happen in 5.16,
> > > after commit 51bd9563b6783d ("btrfs: fix deadlock due to page faults
> > > during direct IO reads and writes"). That changed btrfs to use the new
> > > iomap flag IOMAP_DIO_PARTIAL and to disable page faults before calling
> > > iomap_dio_rw(). This was necessary to fix deadlocks when the iovector
> > > corresponds to a memory mapped file region. That type of scenario is
> > > exercised by test case generic/647 from fstests, and it also affected
> > > gfs2, which, besides btrfs, is the only user of IOMAP_DIO_PARTIAL.
> > >
> > > For this MariaDB scenario, we attempt to read 16K from file offset X
> > > using IOCB_NOWAIT and io_uring. In that range we have 4 extents, each
> > > with a size of 4K, and what happens is the following:
> > >
> > > 1) btrfs_direct_read() disables page faults and calls iomap_dio_rw();
> > >
> > > 2) iomap creates a struct iomap_dio object, its reference count is
> > >    initialized to 1 and its ->size field is initialized to 0;
> > >
> > > 3) iomap calls btrfs_iomap_begin() with file offset X, which finds the
> >
> > You mean btrfs_dio_iomap_begin()?
>
> Yes, correct.
>
> >
> > >    first 4K extent, and setups an iomap for this extent consisting of
> > >    a single page;
> >
> > So we have IOCB_NOWAIT, which means btrfs_dio_iomap_begin() is being
> > passed IOMAP_NOWAIT and so knows it is being asked
> > to map an extent for an IO that is on a non-blocking path.
> >
> > btrfs_dio_iomap_begin() doesn't appear to support NOWAIT semantics
> > at all - it will block doing writeback IO, memory allocation, extent
> > locking, transaction reservations, extent allocation, etc....
>
> We do have some checks for NOWAIT before getting into btrfs_dio_iomap_begin(),
> but they are only for the write path, and they are incomplete. Some are a bit
> tricky to deal with, but yes, there's several cases that are either missing
> or need to be improved.
>
> >
> > That, to me, looks like the root cause of the problem here -
> > btrfs_dio_iomap_begin() is not guaranteeing non-blocking atomic IO
> > semantics for IOCB_NOWAIT IO.
> >
> > In the case above, given that the extent lookup only found a 4kB
> > extent, we know that it doesn't span the entire requested IO range.
> > We also known that we cannot tell if we'll block on subsequent
> > mappings of the IO range, and hence no guarantee can be given that
> > IOCB_NOWAIT IO will not block when it is too late to back out with a
> > -EAGAIN error.
> >
> > Hence this whole set of problems could be avoided if
> > btrfs_dio_iomap_begin() returns -EAGAIN if it can't map the entire
> > IO into a single extent without blocking when IOMAP_NOWAIT is set?
> > That's exactly what XFS does in xfs_direct_iomap_write_begin():
> >
> >         /*
> >          * NOWAIT and OVERWRITE I/O needs to span the entire requested I/O with
> >          * a single map so that we avoid partial IO failures due to the rest of
> >          * the I/O range not covered by this map triggering an EAGAIN condition
> >          * when it is subsequently mapped and aborting the I/O.
> >          */
> >         if (flags & (IOMAP_NOWAIT | IOMAP_OVERWRITE_ONLY)) {
> >                 error = -EAGAIN;
> >                 if (!imap_spans_range(&imap, offset_fsb, end_fsb))
> >                         goto out_unlock;
> >         }
> >
> > Basically, I'm thinking that IOMAP_NOWAIT and IOMAP_DIO_PARTIAL
> > should be exclusive functionality - if you are doing IOMAP_NOWAIT
> > then the entire IO must succeed without blocking, and if it doesn't
> > then we return -EAGAIN and the caller retries without IOCB_NOWAIT
> > set and so then we run with IOMAP_DIO_PARTIAL semantics in a thread
> > that can actually block....
>
> Indeed, I had not considered that, that is simple and effective, plus
> it can be done exclusively in btrfs code, no need to change iomap.

This will work for btrfs, but short buffered reads can still occur on
gfs2 due to the following conflicting requirements:

* On the one hand, buffered reads and writes are expected to be atomic
with respect to each other [*].

* On the other hand, to prevent deadlocks, we must allow the
cluster-wide inode lock to be stolen while faulting in pages. That's
the lock that provides the atomicity, however.

Direct I/O isn't affected because it doesn't have this atomicity requirement.

A non-solution to this dilemma is to lock the entire buffer into
memory: those buffers can be extremely large, so we would eventually
run out of memory.

So we return short reads instead. This only happens rarely, which
doesn't make debugging any easier. It also doesn't help that the
read(2) and write(2) manual pages don't document that short reads as
well as writes must be expected. (The atomicity requirement [*] also
isn't actually documented there.)

[*] https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html#tag_15_09_07

> >
> > .....
> >
> > > 11) At iomap_dio_complete() we adjust the iocb->ki_pos from X to X + 4K
> > >     and return 4K (the amount of io done) to iomap_dio_complete_work();
> > >
> > > 12) iomap_dio_complete_work() calls the iocb completion callback,
> > >     iocb->ki_complete() with a second argument value of 4K (total io
> > >     done) and the iocb with the adjust ki_pos of X + 4K. This results
> > >     in completing the read request for io_uring, leaving it with a
> > >     result of 4K bytes read, and only the first page of the buffer
> > >     filled in, while the remaining 3 pages, corresponding to the other
> > >     3 extents, were not filled;
> > >
> > > 13) For the application, the result is unexpected because if we ask
> > >     to read N bytes, it expects to get N bytes read as long as those
> > >     N bytes don't cross the EOF (i_size).
> >
> > Yeah, that's exactly the sort of problem we were having with XFS
> > with partial DIO completions due to needing multiple iomap iteration
> > loops to complete a single IO. Hence IOMAP_NOWAIT now triggers the
> > above range check and aborts before we start...
>
> Interesting.

Dave, this seems to affect all users of iomap_dio_rw in the same way,
so would it make sense to move this check there?

Thanks,
Andreas

> > > So fix this by making __iomap_dio_rw() assign true to the boolean variable
> > > 'wait_for_completion' when we have IOMAP_DIO_PARTIAL set, we did some
> > > progress for a read and we have not crossed the EOF boundary. Do this even
> > > if the read has IOCB_NOWAIT set, as it's the only way to avoid providing
> > > an unexpected result to an application.
> >
> > That's highly specific and ultimately will be fragile, IMO. I'd much
> > prefer that *_iomap_begin_write() implementations simply follow
> > IOMAP_NOWAIT requirements to ensure that any DIO that needs multiple
> > mappings if punted to a context that can block...
>
> Yes, agreed.
>
> Thanks for your feedback Dave, it provided a really good insight into this
> problem (and others).
>
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
>

