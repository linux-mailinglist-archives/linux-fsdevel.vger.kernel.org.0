Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9DD5513C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239848AbiFTJLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbiFTJLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:11:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4624AA184;
        Mon, 20 Jun 2022 02:11:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 02C6521B14;
        Mon, 20 Jun 2022 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655716297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Y9UgQIl99q9YK+2dT9Hm+SOlfH60jeFZMfuMSJxfGo=;
        b=JzfFMU60BubfiuXbIA1ecj8A5GpVSS4ylBNdXrZCXt5GHgTdoqrV65qSJsKBv9bhRXHB2R
        rQx8X2s4kCvywd0yU05I/mRmoPgS20R/oonOZ/NkyPtn4wD9P9tCc4X9eSKy82bLQ1jMuX
        kCaRL0DcwGpq4j1bCK93EEBhVtvgODk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655716297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Y9UgQIl99q9YK+2dT9Hm+SOlfH60jeFZMfuMSJxfGo=;
        b=PSvvKxlz3O1JNlerRKieVMdOr2QCNJweQkGbn/QDN6j4Qgle95fx2JBnJL4erfMsnwuSOh
        YXBXsCKV3rJ2CUCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CEF632C141;
        Mon, 20 Jun 2022 09:11:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19DB8A0636; Mon, 20 Jun 2022 11:11:36 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:11:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20220620091136.4uosazpwkmt65a5d@quack3.lan>
References: <20190404211730.GD26298@dastard>
 <CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com>
 <20190407232728.GF26298@dastard>
 <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz>
 <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
 <20220617151135.yc6vytge6hjabsuz@quack3>
 <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjvx33KRSm-HX2AjL=aB5yO=FeWokZ1usDKW7+R4Ednhg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 18-06-22 11:38:30, Amir Goldstein wrote:
> On Fri, Jun 17, 2022 at 6:11 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 17-06-22 17:48:08, Amir Goldstein wrote:
> > > On Tue, Apr 9, 2019 at 11:26 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 08-04-19 20:41:09, Amir Goldstein wrote:
> > > > > On Mon, Apr 8, 2019 at 5:11 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Mon 08-04-19 12:02:34, Amir Goldstein wrote:
> > > > > > > On Mon, Apr 8, 2019 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Apr 05, 2019 at 05:02:33PM +0300, Amir Goldstein wrote:
> > > > > > > > > On Fri, Apr 5, 2019 at 12:17 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Apr 04, 2019 at 07:57:37PM +0300, Amir Goldstein wrote:
> > > > > > > > > > > This patch improves performance of mixed random rw workload
> > > > > > > > > > > on xfs without relaxing the atomic buffered read/write guaranty
> > > > > > > > > > > that xfs has always provided.
> > > > > > > > > > >
> > > > > > > > > > > We achieve that by calling generic_file_read_iter() twice.
> > > > > > > > > > > Once with a discard iterator to warm up page cache before taking
> > > > > > > > > > > the shared ilock and once again under shared ilock.
> > > > > > > > > >
> > > > > > > > > > This will race with thing like truncate, hole punching, etc that
> > > > > > > > > > serialise IO and invalidate the page cache for data integrity
> > > > > > > > > > reasons under the IOLOCK. These rely on there being no IO to the
> > > > > > > > > > inode in progress at all to work correctly, which this patch
> > > > > > > > > > violates. IOWs, while this is fast, it is not safe and so not a
> > > > > > > > > > viable approach to solving the problem.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > This statement leaves me wondering, if ext4 does not takes
> > > > > > > > > i_rwsem on generic_file_read_iter(), how does ext4 (or any other
> > > > > > > > > fs for that matter) guaranty buffered read synchronization with
> > > > > > > > > truncate, hole punching etc?
> > > > > > > > > The answer in ext4 case is i_mmap_sem, which is read locked
> > > > > > > > > in the page fault handler.
> > > > > > > >
> > > > > > > > Nope, the  i_mmap_sem is for serialisation of /page faults/ against
> > > > > > > > truncate, holepunching, etc. Completely irrelevant to the read()
> > > > > > > > path.
> > > > > > > >
> > > > > > >
> > > > > > > I'm at lost here. Why are page faults completely irrelevant to read()
> > > > > > > path? Aren't full pages supposed to be faulted in on read() after
> > > > > > > truncate_pagecache_range()?
> > > > > >
> > > > > > During read(2), pages are not "faulted in". Just look at
> > > > > > what generic_file_buffered_read() does. It uses completely separate code to
> > > > > > add page to page cache, trigger readahead, and possibly call ->readpage() to
> > > > > > fill the page with data. "fault" path (handled by filemap_fault()) applies
> > > > > > only to accesses from userspace to mmaps.
> > > > > >
> > > > >
> > > > > Oh! thanks for fixing my blind spot.
> > > > > So if you agree with Dave that ext4, and who knows what other fs,
> > > > > are vulnerable to populating page cache with stale "uptodate" data,
> > > >
> > > > Not that many filesystems support punching holes but you're right.
> > > >
> > > > > then it seems to me that also xfs is vulnerable via readahead(2) and
> > > > > posix_fadvise().
> > > >
> > > > Yes, this is correct AFAICT.
> > > >
> > > > > Mind you, I recently added an fadvise f_op, so it could be used by
> > > > > xfs to synchronize with IOLOCK.
> > > >
> > > > And yes, this should work.
> > > >
> > > > > Perhaps a better solution would be for truncate_pagecache_range()
> > > > > to leave zeroed or Unwritten (i.e. lazy zeroed by read) pages in page
> > > > > cache. When we have shared pages for files, these pages could be
> > > > > deduped.
> > > >
> > > > No, I wouldn't really mess with sharing pages due to this. It would be hard
> > > > to make that scale resonably and would be rather complex. We really need a
> > > > proper and reasonably simple synchronization mechanism between operations
> > > > removing blocks from inode and operations filling in page cache of the
> > > > inode. Page lock was supposed to provide this but doesn't quite work
> > > > because hole punching first remove pagecache pages and then go removing all
> > > > blocks.
> > > >
> > > > So I agree with Dave that going for range lock is really the cleanest way
> > > > forward here without causing big regressions for mixed rw workloads. I'm
> > > > just thinking how to best do that without introducing lot of boilerplate
> > > > code into each filesystem.
> > >
> > > Hi Jan, Dave,
> > >
> > > Trying to circle back to this after 3 years!
> > > Seeing that there is no progress with range locks and
> > > that the mixed rw workloads performance issue still very much exists.
> > >
> > > Is the situation now different than 3 years ago with invalidate_lock?
> >
> > Yes, I've implemented invalidate_lock exactly to fix the issues you've
> > pointed out without regressing the mixed rw workloads (because
> > invalidate_lock is taken in shared mode only for reads and usually not at
> > all for writes).
> >
> > > Would my approach of pre-warm page cache before taking IOLOCK
> > > be safe if page cache is pre-warmed with invalidate_lock held?
> >
> > Why would it be needed? But yes, with invalidate_lock you could presumably
> > make that idea safe...
> 
> To remind you, the context in which I pointed you to the punch hole race
> issue in "other file systems" was a discussion about trying to relax the
> "atomic write" POSIX semantics [1] of xfs.

Ah, I see. Sorry, I already forgot :-|

> There was a lot of discussions around range locks and changing the
> fairness of rwsem readers and writer, but none of this changes the fact
> that as long as the lock is file wide (and it does not look like that is
> going to change in the near future), it is better for lock contention to
> perform the serialization on page cache read/write and not on disk
> read/write.
> 
> Therefore, *if* it is acceptable to pre-warn page cache for buffered read
> under invalidate_lock, that is a simple way to bring the xfs performance with
> random rw mix workload on par with ext4 performance without losing the
> atomic write POSIX semantics. So everyone can be happy?

So to spell out your proposal so that we are on the same page: you want to
use invalidate_lock + page locks to achieve "writes are atomic wrt reads"
property XFS currently has without holding i_rwsem in shared mode during
reads. Am I getting it correct?

How exactly do you imagine the synchronization of buffered read against
buffered write would work? Lock all pages for the read range in the page
cache? You'd need to be careful to not bring the machine OOM when someone
asks to read a huge range...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
