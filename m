Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4554255D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiFHEUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiFHEUA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:20:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D430A465;
        Tue,  7 Jun 2022 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oj6iBHbhY6wXvQP55JwyIS4V24gHjxSYo9c883R7TUw=; b=UfcjCcAZzQcl+QqNdFDayL0DrM
        rVsFMvfFUXJ+7oDg0pQnlpqu8q9pinredTIeMnZWJx7xr81EuHQZejrMDcKM5oM6LxeQPUOp4s5iX
        ZSlisTnw/St+HpFk9wwmSqM+LHciBRgwgWakpdRGd3adD7O0iYUtaFaX5R63bQzoG7LRFpPJ4R+6o
        QTbenogFjZKniIch80zZmMTGAqhansPk4Fgz2CPBlusie4PkzHtBvzj0pHemLIlcBqz4I7YWekTUf
        ODqwv9lHI37DiFMD5p4KndP3XL35ySlCLg7fIX147nJVyBtb79ZnjXvTWY+K0vIvQUROpSy8Axhht
        24wQ41bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nykiD-00CCvI-Vy; Wed, 08 Jun 2022 01:42:22 +0000
Date:   Wed, 8 Jun 2022 02:42:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Use generic_quota_read()
Message-ID: <Yp/+fSoHgPIhiHQR@casper.infradead.org>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-4-willy@infradead.org>
 <20220606083814.skjv34b2tjn7l7pi@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606083814.skjv34b2tjn7l7pi@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 10:38:14AM +0200, Jan Kara wrote:
> On Sun 05-06-22 15:38:15, Matthew Wilcox (Oracle) wrote:
> > The comment about the page cache is rather stale; the buffer cache will
> > read into the page cache if the buffer isn't present, and the page cache
> > will not take any locks if the page is present.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> This will not work for couple of reasons, see below. BTW, I don't think the
> comment about page cache was stale (but lacking details I admit ;). As far
> as I remember (and it was really many years ago - definitely pre-git era)
> the problem was (mainly on the write side) that before current state of the
> code we were using calls like vfs_read() / vfs_write() to get quota
> information and that was indeed prone to deadlocks.

Ah yes, vfs_write() might indeed be prone to deadlocks.  Particularly
if we're doing it under the dq_mutex and any memory allocation might
have recursed into reclaim ;-)

I actually found the commit in linux-fullhistory.  Changelog for
context:

commit b72debd66a6ed
Author: Jan Kara <jack@suse.cz>
Date:   Mon Jan 3 04:12:24 2005 -0800

    [PATCH] Fix of quota deadlock on pagelock: quota core

    The four patches in this series fix deadlocks with quotas of pagelock (the
    problem was lock inversion on PageLock and transaction start - quota code
    needed to first start a transaction and then write the data which subsequent
ly
    needed acquisition of PageLock while the standard ordering - PageLock first
    and transaction start later - was used e.g.  by pdflush).  They implement a
    new way of quota access to disk: Every filesystem that would like to impleme
nt
    quotas now has to provide quota_read() and quota_write() functions.  These
    functions must obey quota lock ordering (in particular they should not take
    PageLock inside a transaction).

    The first patch implements the changes in the quota core, the other three
    patches implement needed functions in ext2, ext3 and reiserfs.  The patch for
    reiserfs also fixes several other lock inversion problems (similar as ext3
    had) and implements the journaled quota functionality (which comes almost for
    free after the locking fixes...).
    
    The quota core patch makes quota support in other filesystems (except XFS
    which implements everything on its own ;)) unfunctional (quotaon() will refuse
    to turn on quotas on them).  When the patches get reasonable wide testing and
    it will seem that no major changes will be needed I can make fixes also for
    the other filesystems (JFS, UDF, UFS).
    
    This patch:
    
    The patch implements the new way of quota io in the quota core.  Every
    filesystem wanting to support quotas has to provide functions quota_read()
    and quota_write() obeying quota locking rules.  As the writes and reads
    bypass the pagecache there is some ugly stuff ensuring that userspace can
    see all the data after quotaoff() (or Q_SYNC quotactl).  In future I plan
    to make quota files inaccessible from userspace (with the exception of
    quotacheck(8) which will take care about the cache flushing and such stuff
    itself) so that this synchronization stuff can be removed...
    
    The rewrite of the quota core. Quota uses the filesystem read() and write()
    functions no more to avoid possible deadlocks on PageLock. From now on every
    filesystem supporting quotas must provide functions quota_read() and
    quota_write() which obey the quota locking rules (e.g. they cannot acquire the
    PageLock).
    
    Signed-off-by: Jan Kara <jack@suse.cz>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

> > @@ -6924,20 +6882,21 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
> >  		return -EIO;
> >  	}
> >  
> > -	do {
> > -		bh = ext4_bread(handle, inode, blk,
> > -				EXT4_GET_BLOCKS_CREATE |
> > -				EXT4_GET_BLOCKS_METADATA_NOFAIL);
> > -	} while (PTR_ERR(bh) == -ENOSPC &&
> > -		 ext4_should_retry_alloc(inode->i_sb, &retries));
> > -	if (IS_ERR(bh))
> > -		return PTR_ERR(bh);
> > -	if (!bh)
> > +	folio = read_mapping_folio(inode->i_mapping, off / PAGE_SIZE, NULL);
> > +	if (IS_ERR(folio))
> > +		return PTR_ERR(folio);
> > +	head = folio_buffers(folio);
> > +	if (!head)
> > +		head = alloc_page_buffers(&folio->page, sb->s_blocksize, false);
> > +	if (!head)
> >  		goto out;
> > +	bh = head;
> > +	while ((bh_offset(bh) + sb->s_blocksize) <= (off % PAGE_SIZE))
> > +		bh = bh->b_this_page;
> 
> We miss proper handling of blocks that are currently beyond i_size
> (we are extending the quota file), plus we also miss any mapping of buffers
> to appropriate disk blocks here...
> 
> It could be all fixed by replicating what we do in ext4_write_begin() but
> I'm not quite convinced using inode's page cache is really worth it...

Ah, yes, write_begin.  Of course that's what I should have used.

I'm looking at this from the point of view of removing buffer_heads
where possible.  Of course, it's not possible for ext4 while the journal
relies on buffer_heads, but if we can steer filesystems away from using
sb_bread() (or equivalents), I think that's a good thing.
