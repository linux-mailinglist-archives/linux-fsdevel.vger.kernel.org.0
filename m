Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB48543265
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiFHOVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbiFHOVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:21:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CC93C4A4;
        Wed,  8 Jun 2022 07:21:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DF8F11F926;
        Wed,  8 Jun 2022 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654698098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdKortsHM16Ii6T0CbgUf/+Hz9663skh5coLaKDgeig=;
        b=3cupTFPSCVWQobq4I+VAr+myiPGAy+Ro8YUUpDbtD55o8Dc8v8ejrfe5zb7zC6Jpz7YP58
        vrAn3h31h0S69hR2jvlexiqBLGqRq/r40OkJU0fDpnJpZIzoOGD/zlAxTP1bQjStYUKmNv
        O3r04MCjiX4+HRnuUmRMK6dTNQ8lQ3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654698098;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdKortsHM16Ii6T0CbgUf/+Hz9663skh5coLaKDgeig=;
        b=YPRbFwiIODIER4Zf44ekM6nCojD6d7UiB+dh/Jr2W3dL5Z5a/L0OpJLPDgj0goo1/x6MMp
        TJEgzavdZmTb3gBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D02202C141;
        Wed,  8 Jun 2022 14:21:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86940A06E2; Wed,  8 Jun 2022 16:21:38 +0200 (CEST)
Date:   Wed, 8 Jun 2022 16:21:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ext4: Use generic_quota_read()
Message-ID: <20220608142138.7nejka3yobgsdmd7@quack3.lan>
References: <20220605143815.2330891-1-willy@infradead.org>
 <20220605143815.2330891-4-willy@infradead.org>
 <20220606083814.skjv34b2tjn7l7pi@quack3.lan>
 <Yp/+fSoHgPIhiHQR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp/+fSoHgPIhiHQR@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 02:42:21, Matthew Wilcox wrote:
> On Mon, Jun 06, 2022 at 10:38:14AM +0200, Jan Kara wrote:
> > On Sun 05-06-22 15:38:15, Matthew Wilcox (Oracle) wrote:
> > > The comment about the page cache is rather stale; the buffer cache will
> > > read into the page cache if the buffer isn't present, and the page cache
> > > will not take any locks if the page is present.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > This will not work for couple of reasons, see below. BTW, I don't think the
> > comment about page cache was stale (but lacking details I admit ;). As far
> > as I remember (and it was really many years ago - definitely pre-git era)
> > the problem was (mainly on the write side) that before current state of the
> > code we were using calls like vfs_read() / vfs_write() to get quota
> > information and that was indeed prone to deadlocks.
> 
> Ah yes, vfs_write() might indeed be prone to deadlocks.  Particularly
> if we're doing it under the dq_mutex and any memory allocation might
> have recursed into reclaim ;-)
> 
> I actually found the commit in linux-fullhistory.  Changelog for
> context:
> 
> commit b72debd66a6ed
> Author: Jan Kara <jack@suse.cz>
> Date:   Mon Jan 3 04:12:24 2005 -0800
> 
>     [PATCH] Fix of quota deadlock on pagelock: quota core

\o/ to you history searching skills :)

> > > @@ -6924,20 +6882,21 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
> > >  		return -EIO;
> > >  	}
> > >  
> > > -	do {
> > > -		bh = ext4_bread(handle, inode, blk,
> > > -				EXT4_GET_BLOCKS_CREATE |
> > > -				EXT4_GET_BLOCKS_METADATA_NOFAIL);
> > > -	} while (PTR_ERR(bh) == -ENOSPC &&
> > > -		 ext4_should_retry_alloc(inode->i_sb, &retries));
> > > -	if (IS_ERR(bh))
> > > -		return PTR_ERR(bh);
> > > -	if (!bh)
> > > +	folio = read_mapping_folio(inode->i_mapping, off / PAGE_SIZE, NULL);
> > > +	if (IS_ERR(folio))
> > > +		return PTR_ERR(folio);
> > > +	head = folio_buffers(folio);
> > > +	if (!head)
> > > +		head = alloc_page_buffers(&folio->page, sb->s_blocksize, false);
> > > +	if (!head)
> > >  		goto out;
> > > +	bh = head;
> > > +	while ((bh_offset(bh) + sb->s_blocksize) <= (off % PAGE_SIZE))
> > > +		bh = bh->b_this_page;
> > 
> > We miss proper handling of blocks that are currently beyond i_size
> > (we are extending the quota file), plus we also miss any mapping of buffers
> > to appropriate disk blocks here...
> > 
> > It could be all fixed by replicating what we do in ext4_write_begin() but
> > I'm not quite convinced using inode's page cache is really worth it...
> 
> Ah, yes, write_begin.  Of course that's what I should have used.
> 
> I'm looking at this from the point of view of removing buffer_heads
> where possible.  Of course, it's not possible for ext4 while the journal
> relies on buffer_heads, but if we can steer filesystems away from using
> sb_bread() (or equivalents), I think that's a good thing.

Well, ext4 uses sb_bread() (sb_getblk()) for all its metadata so quota
code, which is rather well localized, is the least of your worries I'm
afraid ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
