Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AB4CC01F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbiCCOj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 09:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCCOjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:39:55 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AA15DDDC;
        Thu,  3 Mar 2022 06:39:10 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223Ecl7p029131
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 09:38:48 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6472A15C0038; Thu,  3 Mar 2022 09:38:47 -0500 (EST)
Date:   Thu, 3 Mar 2022 09:38:47 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
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
Subject: Re: [PATCH -v5] ext4: don't BUG if someone dirty pages without
 asking ext4 first
Message-ID: <YiDS9wVfq4mM2jGK@mit.edu>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yhks88tO3Em/G370@mit.edu>
 <YhlBUCi9O30szf6l@sol.localdomain>
 <YhlFRoJ3OdYMIh44@mit.edu>
 <YhlIvw00Y4MkAgxX@mit.edu>
 <YiBDf7XLnTe4Gwis@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiBDf7XLnTe4Gwis@mit.edu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[un]pin_user_pages_remote is dirtying pages without properly warning
the file system in advance.  A related race was noted by Jan Kara in
2018[1]; however, more recently instead of it being a very hard-to-hit
race, it could be reliably triggered by process_vm_writev(2) which was
discovered by Syzbot[2].

This is technically a bug in mm/gup.c, but arguably ext4 is fragile in
that if some other kernel subsystem dirty pages without properly
notifying the file system using page_mkwrite(), ext4 will BUG, while
other file systems will not BUG (although data will still be lost).

So instead of crashing with a BUG, issue a warning (since there may be
potential data loss) and just mark the page as clean to avoid
unprivileged denial of service attacks until the problem can be
properly fixed.  More discussion and background can be found in the
thread starting at [2].

[1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
[2] https://lore.kernel.org/r/Yg0m6IjcNmfaSokM@google.com

Reported-by: syzbot+d59332e2db681cf18f0318a06e994ebbb529a8db@syzkaller.appspotmail.com
Reported-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

 -v5 Argh, sent the wrong version of this patch for V4.  (Which, if you tried
     testing it, would cause generic/013 on ext4/4k to die horribly. :-)  This
     is the correct final version.....

 fs/ext4/inode.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01c9e4f743ba..531a94f48637 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1993,6 +1993,15 @@ static int ext4_writepage(struct page *page,
 	else
 		len = PAGE_SIZE;
 
+	/* Should never happen but for bugs in other kernel subsystems */
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
@@ -2594,6 +2603,22 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			wait_on_page_writeback(page);
 			BUG_ON(PageWriteback(page));
 
+			/*
+			 * Should never happen but for buggy code in
+			 * other subsystems that call
+			 * set_page_dirty() without properly warning
+			 * the file system first.  See [1] for more
+			 * information.
+			 *
+			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
+			 */
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
-- 
2.31.0

