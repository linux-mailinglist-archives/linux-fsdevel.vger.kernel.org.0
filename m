Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED744C1FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 00:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbiBWXc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Feb 2022 18:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiBWXc1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:32:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7E3616F;
        Wed, 23 Feb 2022 15:31:57 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21NNVXAJ022888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 18:31:34 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F40815C0036; Wed, 23 Feb 2022 18:31:33 -0500 (EST)
Date:   Wed, 23 Feb 2022 18:31:33 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
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
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <YhbD1T7qhgnz4myM@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
 <7bd88058-2a9a-92a6-2280-43c805b516c3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd88058-2a9a-92a6-2280-43c805b516c3@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:33:34PM -0800, John Hubbard wrote:
> 
> Just a small thing I'll say once, to get it out of my system. No action
> required here, I just want it understood:
> 
> Before commit 803e4572d7c5 ("mm/process_vm_access: set FOLL_PIN via
> pin_user_pages_remote()"), you would have written that like this:
> 
> "process_vm_writev() is dirtying pages without properly warning the file
> system in advance..."
> 
> Because, there were many callers that were doing this:
> 
>     get_user_pages*()
>     ...use the pages...
> 
>     for_each_page() {
>             set_page_dirty*()
>             put_page()
>     }

Sure, but that's not sufficient when modifying file-backed pages.
Previously, there was only two ways of modifying file-backed pages in
the page cache --- either using the write(2) system call, or when a
mmaped page is modified by the userspace.

In the case of write(2), the file system gets notified before the page
cache is modified by a call to the address operation's write_begin()
call, and after the page cache is modified, the address operation's
write_end() call lets the file system know that the modification is
done.  After the write is done, the 30 second writeback timer is
triggered, and in the case of ext4's data=journalling mode, we close
the ext4 micro-transation (and therefore the time between write_begin
and write_end calls needs to be minimal); otherwise this can block
ext4 transactions.

In the case of a user page fault, the address operation's
page_mkwrite() is called, and at that point we will allocate any
blocks needed to back memory if necessary (in the case of delayed
allocation, file system space has to get reserved).  The problem here
for remote access is that page_mkwrite() can block, and it can
potentially fail (e.g., with ENOSPC or ENOMEM).  This is also why we
can't just add the page buffers and do the file system allocation in
set_page_dirty(), since set_page_dirty() isn't allowed to block.

One approach might be to make all of the pages writeable when
pin_user_pages_remote() is called.  That that would mean that in the
case of remote access via process_vm_writev or RDMA, all of the blocks
will be allocated early.  But that's probably better since at that
point the userspace code is in a position to receive the error when
setting up the RDMA memory, and we don't want to be asking the file
system to do block allocation when incoming data is coming in from
Infiniband or iWARP.

> I see that ext4_warning_inode() has rate limiting, but it doesn't look
> like it's really intended for a per-page rate. It looks like it is
> per-superblock (yes?), so I suspect one instance of this problem, with
> many pages involved, could hit the limit.
> 
> Often, WARN_ON_ONCE() is used with per-page assertions. That's not great
> either, but it might be better here. OTOH, I have minimal experience
> with ext4_warning_inode() and maybe it really is just fine with per-page
> failure rates.

With the syzbot reproducer, we're not actually triggering the rate
limiter, since the ext4 warning is only getting hit a bit more than
once every 4 seconds.  And I'm guessing that in the real world, people
aren't actually trying to do remote direct access to file-backed
memory, at least not using ext4, since that's an invitation to a
kernel crash, and we would have gotten user complaints.  If some user
actually tries to use process_vm_writev for realsies, as opposed to a
random fuzzer or from a malicious program , we do want to warn them
about the potential data loss, so I'd prefer to warn once for each
inode --- but I'm not convinced that it's worth the effort.

Cheers,

						- Ted
