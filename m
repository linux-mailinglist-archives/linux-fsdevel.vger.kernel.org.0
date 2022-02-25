Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1084C5208
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 00:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbiBYXYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 18:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:24:19 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F81BF511;
        Fri, 25 Feb 2022 15:23:45 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21PNLLWc016897
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 18:21:22 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6F72115C0038; Fri, 25 Feb 2022 18:21:21 -0500 (EST)
Date:   Fri, 25 Feb 2022 18:21:21 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v3] ext4: don't BUG if kernel subsystems dirty pages
 without asking ext4 first
Message-ID: <YhlkcYjozFmt3Kl4@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yhks88tO3Em/G370@mit.edu>
 <YhlBUCi9O30szf6l@sol.localdomain>
 <YhlFRoJ3OdYMIh44@mit.edu>
 <YhlIvw00Y4MkAgxX@mit.edu>
 <2f9933b3-a574-23e1-e632-72fc29e582cf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f9933b3-a574-23e1-e632-72fc29e582cf@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:33:33PM -0800, John Hubbard wrote:
> On 2/25/22 13:23, Theodore Ts'o wrote:
> > [un]pin_user_pages_remote is dirtying pages without properly warning
> > the file system in advance.  This was noted by Jan Kara in 2018[1] and
> 
> In 2018, [un]pin_user_pages_remote did not exist. And so what Jan reported
> was actually that dio_bio_complete() was calling set_page_dirty_lock()
> on pages that were not (any longer) set up for that.

Fair enough, there are two problems that are getting conflated here,
and that's my bad.  The problem which Jan pointed out is one where the
Direct I/O read path triggered a page fault, so page_mkwrite() was
actually called.  So in this case, the file system was actually
notified, and the page was marked dirty after the file system was
notified.  But then the DIO read was racing with the page cleaner,
which would call writepage(), and then clear the page, and then remove
the buffer_heads.  Then dio_bio_complete() would call set_page_dirty()
a second time, and that's what would trigger the BUG.

But in the syzbot reproducer, it's a different problem.  In this case,
process_vm_writev() calling [un]pin_user_pages_remote(), and
page_mkwrite() is never getting called.  So there is no need to race
with the page cleaner, and so the BUG triggers much more reliably.

> > more recently has resulted in bug reports by Syzbot in various Android
> > kernels[2].
> > 
> > This is technically a bug in mm/gup.c, but arguably ext4 is fragile in
> 
> Is it, really? unpin_user_pages_dirty_lock() moved the set_page_dirty_lock()
> call into mm/gup.c, but that merely refactored things. The callers are
> all over the kernel, and those callers are what need changing in order
> to fix this.

From my perspective, the bug is calling set_page_dirty() without first
calling the file system's page_mkwrite().  This is necessary since the
file system needs to allocate file system data blocks in preparation
for a future writeback.

Now, calling page_mkwrite() by itself is not enough, since the moment
you make the page dirty, the page cleaner could go ahead and call
writepage() behind your back and clean it.  In actual practice, with a
Direct I/O read request racing with writeback, this is race was quite
hard to hit, because the that would imply that the background
writepage() call would have to complete ahead of the synchronous read
request, and the block layer generally prioritizes synchronous reads
ahead of background write requests.  So in practice, this race was
***very*** hard to hit.  Jan may have reported it in 2018, but I don't
think I've ever seen it happen myself.

For process_vm_writev() this is a case where user pages are pinned and
then released in short order, so I suspect that race with the page
cleaner would also be very hard to hit.  But we could completely
remove the potential for the race, and also make things kinder for
f2fs and btrfs's compressed file write support, by making things work
much like the write(2) system call.  Imagine if we had a
"pin_user_pages_local()" which calls write_begin(), and a
"unpin_user_pages_local()" which calls write_end(), and the
presumption with the "[un]pin_user_pages_local" API is that you don't
hold the pinned pages for very long --- say, not across a system call
boundary, and then it would work the same way the write(2) system call
works does except that in the case of process_vm_writev(2) the pages
are identified by another process's address space where they happen to
be mapped.

This obviously doesn't work when pinning pages for remote DMA, because
in that case the time between pin_user_pages_remote() and
unpin_user_pages_remote() could be a long, long time, so that means we
can't use using write_begin/write_end; we'd need to call page_mkwrite()
when the pages are first pinned and then somehow prevent the page
cleaner from touching a dirty page which is pinned for use by the
remote DMA.

Does that make sense?

							- Ted
