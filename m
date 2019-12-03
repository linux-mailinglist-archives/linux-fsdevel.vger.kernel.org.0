Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383D210FF13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCNsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 08:48:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59922 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbfLCNsG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A05F0ADB5;
        Tue,  3 Dec 2019 13:48:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 334C81E0B7B; Tue,  3 Dec 2019 14:48:04 +0100 (CET)
Date:   Tue, 3 Dec 2019 14:48:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFCv3 4/4] ext4: Move to shared iolock even without
 dioread_nolock mount opt
Message-ID: <20191203134804.GF8206@quack2.suse.cz>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
 <20191120050024.11161-5-riteshh@linux.ibm.com>
 <20191120143257.GE9509@quack2.suse.cz>
 <20191126105122.75EC6A4060@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20191129171836.GB27588@quack2.suse.cz>
 <20191203115445.6F802AE059@d06av26.portsmouth.uk.ibm.com>
 <20191203123929.GE8206@quack2.suse.cz>
 <20191203131048.A4559A4051@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203131048.A4559A4051@d06av23.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 03-12-19 18:40:47, Ritesh Harjani wrote:
> On 12/3/19 6:09 PM, Jan Kara wrote:
> > 
> > Hello Ritesh!
> > 
> > On Tue 03-12-19 17:24:44, Ritesh Harjani wrote:
> > > On 11/29/19 10:48 PM, Jan Kara wrote:
> > > > > Also, I wanted to have some more discussions on this race before
> > > > > making the changes.
> > > > > But nevertheless, it's the right time to discuss those changes here.
> > > > > 
> > > > > > mmap write instantiating dirty page and then someone starting writeback
> > > > > > against that page while DIO read is running still theoretically leading to
> > > > > > stale data exposure. Now this patch does not have influence on that race
> > > > > > but:
> > > > > 
> > > > > Yes, agreed.
> > > > > 
> > > > > > 
> > > > > > 1) We need to close the race mentioned above. Maybe we could do that by
> > > > > > proactively allocating unwritten blocks for a page being faulted when there
> > > > > > is direct IO running against the file - the one who fills holes through
> > > > > > mmap write while direct IO is running on the file deserves to suffer the
> > > > > > performance penalty...
> > > > > 
> > > > > I was giving this a thought. So even if we try to penalize mmap
> > > > > write as you mentioned above, what I am not sure about it, is that, how can
> > > > > we reliably detect that the DIO is in progress?
> > > > > 
> > > > > Say even if we try to check for atomic_read(&inode->i_dio_count) in mmap
> > > > > ext4_page_mkwrite path, it cannot be reliable unless there is some sort of a
> > > > > lock protection, no?
> > > > > Because after the check the DIO can still snoop in, right?
> > > > 
> > > > Yes, doing this reliably will need some code tweaking. Also thinking about
> > > > this in detail, doing a reliable check in ext4_page_mkwrite() is
> > > > somewhat difficult so it will be probably less error-prone to deal with the
> > > > race in the writeback path.
> > > 
> > > hmm. But if we don't do in ext4_page_mkwrite, then I am afraid on
> > > how to handle nodelalloc scenario. Where we will directly go and
> > > allocate block via ext4_get_block() in ext4_page_mkwrite(),
> > > as explained below.
> > > I guess we may need some tweaking at both places.
> > 
> > Ok, I forgot to mention that. Yes, the nodelalloc case in
> > ext4_page_mkwrite() still needs tweaking. But that is not performance
> > sensitive path at all. So we can just have there:
> 
> hmm. I was of the opinion that why use unwritten blocks or move
> from written to unwritten method while we can still avoid it.
> 
> > 
> > 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> > 		get_block = ext4_get_block_unwritten;
> > 	else
> > 		get_block = ext4_get_block;
> > 
> 
> Although adding a function ext4_dio_check_get_block() as described in
> previous email is also trivial, which could avoid using unwritten
> blocks here when DIO is not in progress.
> But if you think it's not worth it, then I will go with your suggestion
> here.

Yeah, I would prefer to keep it simple. Otherwise you would have a rare
subcase of a rare case meaning that code path will hardly ever get tested
and that's not good for maintainability... Also note that check is not 100%
reliable. There's still a race like:

ext4_page_mkwrite()
  block_page_mkwrite()
    lock_page(page);
    ...
    -> get_block()
      if (inode_dio_count(inode) > 0)
      -> false - use ext4_get_block()
					iomap_dio_rw()
					  inode_dio_begin()
					  filemap_write_and_wait()
					    -> no dirty page yet -> bails
					  invalidate_mapping_pages2()
    set_page_dirty(page);
  unlock_page(page);
 					    -> bails with error because the
					    page is dirty. Warning is
					    issued but stale data is still
					    exposed.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
