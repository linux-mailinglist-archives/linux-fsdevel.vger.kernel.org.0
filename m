Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71FCF809
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 13:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfJHLZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 07:25:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:36400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730316AbfJHLZO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 07:25:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3142B192;
        Tue,  8 Oct 2019 11:25:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25A111E4827; Tue,  8 Oct 2019 13:25:12 +0200 (CEST)
Date:   Tue, 8 Oct 2019 13:25:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <20191008112512.GH5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:34:18, Matthew Bobrowski wrote:
> In preparation for implementing the iomap direct I/O write path
> modifications, the inode extension/truncate code needs to be moved out
> from ext4_iomap_end(). For direct I/O, if the current code remained
> within ext4_iomap_end() it would behave incorrectly. Updating the
> inode size prior to converting unwritten extents to written extents
> will potentially allow a racing direct I/O read operation to find
> unwritten extents before they've been correctly converted.
> 
> The inode extension/truncate code has been moved out into a new helper
> ext4_handle_inode_extension(). This function has been designed so that
> it can be used by both DAX and direct I/O paths.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me. Fell free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just small nits below:

> +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> +				       ssize_t written, size_t count)
> +{
> +	int ret = 0;

I think both the function and callsites may be slightly simpler if you let
the function return 'written' or error (not 0 or error). But I'll leave
that decision upto you.

> +	handle_t *handle;
> +	bool truncate = false;
> +	u8 blkbits = inode->i_blkbits;
> +	ext4_lblk_t written_blk, end_blk;
> +
> +	/*
> +         * Note that EXT4_I(inode)->i_disksize can get extended up to
> +         * inode->i_size while the IO was running due to writeback of
> +         * delalloc blocks. But the code in ext4_iomap_alloc() is careful
> +         * to use zeroed / unwritten extents if this is possible and thus
> +         * we won't leave uninitialized blocks in a file even if we didn't
> +         * succeed in writing as much as we planned.
> +         */

Whitespace damaged here...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
