Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06DCDFFFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 10:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfJVIuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 04:50:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387479AbfJVIuZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:50:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5273B5BF;
        Tue, 22 Oct 2019 08:50:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 107F61E4AA2; Tue, 22 Oct 2019 09:55:48 +0200 (CEST)
Date:   Tue, 22 Oct 2019 09:55:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 12/12] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191022075548.GB2436@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <c3438dad66a34a7d4e7509a5dd64c2326340a52a.1571647180.git.mbobrowski@mbobrowski.org>
 <20191021161848.GI25184@quack2.suse.cz>
 <20191022030235.GG5092@athena.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022030235.GG5092@athena.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 22-10-19 14:02:35, Matthew Bobrowski wrote:
> On Mon, Oct 21, 2019 at 06:18:48PM +0200, Jan Kara wrote:
> > > +	if (extend) {
> > > +		ret = ext4_handle_inode_extension(inode, ret, offset, count);
> > > +
> > > +		/*
> > > +		 * We may have failed to remove the inode from the orphan list
> > > +		 * in the case that the i_disksize got update due to delalloc
> > > +		 * writeback while the direct I/O was running. We need to make
> > > +		 * sure we remove it from the orphan list as if we've
> > > +		 * prematurely popped it onto the list.
> > > +		 */
> > > +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> > > +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > > +			if (IS_ERR(handle)) {
> > > +				ret = PTR_ERR(handle);
> > > +				if (inode->i_nlink)
> > > +					ext4_orphan_del(NULL, inode);
> > > +				goto out;
> > > +			}
> > > +
> > > +			if (inode->i_nlink)
> > 
> > This check can be joined with the list_empty() check above to save us from
> > unnecessarily starting a transaction.
> 
> Yes, easy done.
> 
> > Also I was wondering whether it would not make more sense have this
> > orphan handling bit also in
> > ext4_handle_inode_extension(). ext4_dax_write_iter() doesn't
> > strictly need it (as for DAX i_disksize cannot currently change
> > while ext4_dax_write_iter() is running) but it would look more
> > robust to me for the future users and it certainly doesn't hurt
> > ext4_dax_write_iter() case.
> 
> I was thinking the same, but to be honest I wasn't entirely sure how
> it would pan out for the DAX code path. However, seeing as though you
> don't forsee there being any problems, then I can't really think of a
> reason not to roll this up into ext4_handle_inode_extension().
> 
> So, in ext4_handle_inode_extension() for the initial check against
> i_disksize, rather than returning 'written' and then having
> ext4_dio_write_iter() perform the cleanup, we could simply jump to a
> chunk of code in ext4_handle_inode_extension() and deal with it there,
> or quite literally just cleanup if that branch is taken there and then
> seeing as though it's not really needed in any other case? What do you
> think?

Yeah, the last option makes the most sense to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
