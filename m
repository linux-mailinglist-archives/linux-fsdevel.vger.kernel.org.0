Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436AF54F9E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 17:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383055AbiFQPLr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383048AbiFQPLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:11:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E7D40A33;
        Fri, 17 Jun 2022 08:11:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C79DA219B5;
        Fri, 17 Jun 2022 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655478702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isGHlZjzBCS8A0ziLERiN6uU3hp//39N9INjROOZ4Pk=;
        b=29BY2Gsq7RS4PQujaqYg8igo7ncgTQxpgcKj2s8O7+ltIo0STzilq1HanbNbyZjvweqj5/
        WVOgYueUnvwU6xVjKHhQiNBSv8sqZQjnsGMJ8vWSjua1gVci6N/RzHHPjarzoRrvh22w2E
        RrnNnR8+55+SE7GeKML1tLO/J2dRIho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655478702;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isGHlZjzBCS8A0ziLERiN6uU3hp//39N9INjROOZ4Pk=;
        b=RApSRdJ0+bq3YiqbLhOBUHXLYCTMrx3WltsZSs4Q37iZa0+lbuJEcQjxZMQb/L52xvQry+
        /xqh8lNgwvDPmQBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2098D2C141;
        Fri, 17 Jun 2022 15:11:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 428CFA0634; Fri, 17 Jun 2022 17:11:35 +0200 (CEST)
Date:   Fri, 17 Jun 2022 17:11:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>,
        Theodore Tso <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [POC][PATCH] xfs: reduce ilock contention on buffered randrw
 workload
Message-ID: <20220617151135.yc6vytge6hjabsuz@quack3>
References: <20190404165737.30889-1-amir73il@gmail.com>
 <20190404211730.GD26298@dastard>
 <CAOQ4uxjQNmxqmtA_VbYW0Su9rKRk2zobJmahcyeaEVOFKVQ5dw@mail.gmail.com>
 <20190407232728.GF26298@dastard>
 <CAOQ4uxgD4ErSUtbu0xqb5dSm_tM4J92qt6=hGH8GRc5KNGqP9A@mail.gmail.com>
 <20190408141114.GC15023@quack2.suse.cz>
 <CAOQ4uxhxgYASST1k-UaqfbLL9ERquHaKL2jtydB2+iF9aT8SRQ@mail.gmail.com>
 <20190409082605.GA8107@quack2.suse.cz>
 <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgu4uKJp5t+RoumMneR6bw_k0CRhGhU-SLAky4VHSg9MQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-06-22 17:48:08, Amir Goldstein wrote:
> On Tue, Apr 9, 2019 at 11:26 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 08-04-19 20:41:09, Amir Goldstein wrote:
> > > On Mon, Apr 8, 2019 at 5:11 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 08-04-19 12:02:34, Amir Goldstein wrote:
> > > > > On Mon, Apr 8, 2019 at 2:27 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 05, 2019 at 05:02:33PM +0300, Amir Goldstein wrote:
> > > > > > > On Fri, Apr 5, 2019 at 12:17 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Apr 04, 2019 at 07:57:37PM +0300, Amir Goldstein wrote:
> > > > > > > > > This patch improves performance of mixed random rw workload
> > > > > > > > > on xfs without relaxing the atomic buffered read/write guaranty
> > > > > > > > > that xfs has always provided.
> > > > > > > > >
> > > > > > > > > We achieve that by calling generic_file_read_iter() twice.
> > > > > > > > > Once with a discard iterator to warm up page cache before taking
> > > > > > > > > the shared ilock and once again under shared ilock.
> > > > > > > >
> > > > > > > > This will race with thing like truncate, hole punching, etc that
> > > > > > > > serialise IO and invalidate the page cache for data integrity
> > > > > > > > reasons under the IOLOCK. These rely on there being no IO to the
> > > > > > > > inode in progress at all to work correctly, which this patch
> > > > > > > > violates. IOWs, while this is fast, it is not safe and so not a
> > > > > > > > viable approach to solving the problem.
> > > > > > > >
> > > > > > >
> > > > > > > This statement leaves me wondering, if ext4 does not takes
> > > > > > > i_rwsem on generic_file_read_iter(), how does ext4 (or any other
> > > > > > > fs for that matter) guaranty buffered read synchronization with
> > > > > > > truncate, hole punching etc?
> > > > > > > The answer in ext4 case is i_mmap_sem, which is read locked
> > > > > > > in the page fault handler.
> > > > > >
> > > > > > Nope, the  i_mmap_sem is for serialisation of /page faults/ against
> > > > > > truncate, holepunching, etc. Completely irrelevant to the read()
> > > > > > path.
> > > > > >
> > > > >
> > > > > I'm at lost here. Why are page faults completely irrelevant to read()
> > > > > path? Aren't full pages supposed to be faulted in on read() after
> > > > > truncate_pagecache_range()?
> > > >
> > > > During read(2), pages are not "faulted in". Just look at
> > > > what generic_file_buffered_read() does. It uses completely separate code to
> > > > add page to page cache, trigger readahead, and possibly call ->readpage() to
> > > > fill the page with data. "fault" path (handled by filemap_fault()) applies
> > > > only to accesses from userspace to mmaps.
> > > >
> > >
> > > Oh! thanks for fixing my blind spot.
> > > So if you agree with Dave that ext4, and who knows what other fs,
> > > are vulnerable to populating page cache with stale "uptodate" data,
> >
> > Not that many filesystems support punching holes but you're right.
> >
> > > then it seems to me that also xfs is vulnerable via readahead(2) and
> > > posix_fadvise().
> >
> > Yes, this is correct AFAICT.
> >
> > > Mind you, I recently added an fadvise f_op, so it could be used by
> > > xfs to synchronize with IOLOCK.
> >
> > And yes, this should work.
> >
> > > Perhaps a better solution would be for truncate_pagecache_range()
> > > to leave zeroed or Unwritten (i.e. lazy zeroed by read) pages in page
> > > cache. When we have shared pages for files, these pages could be
> > > deduped.
> >
> > No, I wouldn't really mess with sharing pages due to this. It would be hard
> > to make that scale resonably and would be rather complex. We really need a
> > proper and reasonably simple synchronization mechanism between operations
> > removing blocks from inode and operations filling in page cache of the
> > inode. Page lock was supposed to provide this but doesn't quite work
> > because hole punching first remove pagecache pages and then go removing all
> > blocks.
> >
> > So I agree with Dave that going for range lock is really the cleanest way
> > forward here without causing big regressions for mixed rw workloads. I'm
> > just thinking how to best do that without introducing lot of boilerplate
> > code into each filesystem.
> 
> Hi Jan, Dave,
> 
> Trying to circle back to this after 3 years!
> Seeing that there is no progress with range locks and
> that the mixed rw workloads performance issue still very much exists.
> 
> Is the situation now different than 3 years ago with invalidate_lock?

Yes, I've implemented invalidate_lock exactly to fix the issues you've
pointed out without regressing the mixed rw workloads (because
invalidate_lock is taken in shared mode only for reads and usually not at
all for writes).

> Would my approach of pre-warm page cache before taking IOLOCK
> be safe if page cache is pre-warmed with invalidate_lock held?

Why would it be needed? But yes, with invalidate_lock you could presumably
make that idea safe...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
