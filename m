Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15E94BB087
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 05:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiBREJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 23:09:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiBREJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:09:16 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C69136EC9;
        Thu, 17 Feb 2022 20:09:00 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 21I48c9R019411
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 23:08:39 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4C4115C34C8; Thu, 17 Feb 2022 23:08:38 -0500 (EST)
Date:   Thu, 17 Feb 2022 23:08:38 -0500
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
Message-ID: <Yg8bxiz02WBGf6qO@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 05:06:45PM -0800, John Hubbard wrote:
> Yes. And looking at the pair of backtraces below, this looks very much
> like another aspect of the "get_user_pages problem" [1], originally
> described in Jan Kara's 2018 email [2].

Hmm... I just posted my analysis, which tracks with yours; but I had
forgotten about Jan's 2018 e-mail on the matter.

> I'm getting close to posting an RFC for the direct IO conversion to
> FOLL_PIN, but even after that, various parts of the kernel (reclaim,
> filesystems/block layer) still need to be changed so as to use
> page_maybe_dma_pinned() to help avoid this problem. There's a bit
> more than that, actually.

The challenge is that fixing this "the right away" is probably not
something we can backport into an LTS kernel, whether it's 5.15 or
5.10... or 4.19.

The only thing which can probably survive getting backported is
something like this.  It won't make the right thing happen if someone
is trying to RDMA or call process_vm_writev() into a file-backed
memory region --- but I'm not sure I care.  Certainly if the goal is
to make Android kernels, I'm pretty sure they are't either using RDMA,
and I suspect they are probably masking out the process_vm_writev(2)
system call (at least, for Android O and newer).  So if the goal is to
just to close some Syzbot bugs, what do folks think about this?

     	      	   	  	     	- Ted

commit 7711b1fda6f7f04274fa1cba6f092410262b0296
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Feb 17 22:54:03 2022 -0500

    ext4: work around bugs in mm/gup.c that can cause ext4 to BUG()
    
    [un]pin_user_pages_remote is dirtying pages without properly warning
    the file system in advance (or faulting in the file data if the page
    is not yet in the page cache).  This was noted by Jan Kara in 2018[1]
    and more recently has resulted in bug reports by Syzbot in various
    Android kernels[2].
    
    Fixing this for real is non-trivial, and will never be backportable
    into stable kernels.  So this is a simple workaround that stops the
    kernel from BUG()'ing.  The changed pages will not be properly written
    back, but given that the current gup code is missing the "read" in
    "read-modify-write", the dirty page in the page cache might contain
    corrupted data anyway.
    
    [1] https://www.spinics.net/lists/linux-mm/msg142700.html
    [2] https://lore.kernel.org/r/Yg0m6IjcNmfaSokM@google.com
    
    Reported-by: syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com
    Reported-by: Lee Jones <lee.jones@linaro.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..3b2f336a90d1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1993,6 +1993,15 @@ static int ext4_writepage(struct page *page,
 	else
 		len = PAGE_SIZE;
 
+	/* Should never happen but for buggy gup code */
+	if (!page_has_buffers(page)) {
+		ext4_warning_inode(inode,
+		   "page %lu does not have buffers attached", page->index);
+		ClearPageDirty(page);
+		unlock_page(page);
+		return 0;
+	}
+
 	page_bufs = page_buffers(page);
 	/*
 	 * We cannot do block allocation or other extent handling in this
@@ -2594,6 +2603,14 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			wait_on_page_writeback(page);
 			BUG_ON(PageWriteback(page));
 
+			/* Should never happen but for buggy gup code */
+			if (!page_has_buffers(page)) {
+				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
+				ClearPageDirty(page);
+				unlock_page(page);
+				continue;
+			}
+
 			if (mpd->map.m_len == 0)
 				mpd->first_page = page->index;
 			mpd->next_page = page->index + 1;
