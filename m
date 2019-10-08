Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1ACF777
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 12:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbfJHKwK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 06:52:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:48054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbfJHKwK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:52:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3EFD1B0F2;
        Tue,  8 Oct 2019 10:52:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B1B391E4827; Tue,  8 Oct 2019 12:52:07 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:52:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 4/8] ext4: introduce direct I/O read path using iomap
 infrastructure
Message-ID: <20191008105207.GG5078@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-10-19 21:34:00, Matthew Bobrowski wrote:
> This patch introduces a new direct I/O read path that makes use of the
> iomap infrastructure.
> 
> The new function ext4_dio_read_iter() is responsible for calling into
> the iomap infrastructure via iomap_dio_rw(). If the read operation
> being performed on the inode does not pass the preliminary checks
> performed within ext4_dio_supported(), then we simply fallback to
> buffered I/O in order to fulfil the request.
> 
> Existing direct I/O read buffer_head code has been removed as it's now
> redundant.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

The patch looks good to me. Just one small nit below. With that fixed, you
can add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +	/*
> +	 * Get exclusion from truncate and other inode operations.
> +	 */
> +	if (!inode_trylock_shared(inode)) {
> +		if (iocb->ki_flags & IOCB_NOWAIT)
> +			return -EAGAIN;
> +		inode_lock_shared(inode);
> +	}

I've noticed here you actually introduce new trylock pattern - previously
we had unconditional inode_lock_shared() in ext4_direct_IO_read(). So the
cleanest would be to just use unconditional inode_lock_shared() here and
then fixup IOCB_NOWAIT handling (I agree that was missing in the original
code) in a separate patch. And the pattern should rather look like:

	if (iocb->ki_flags & IOCB_NOWAIT) {
		if (!inode_trylock_shared(inode))
			return -EAGAIN;
	} else {
		inode_lock_shared(inode);
	}

to avoid two atomical operations instead of one in the fast path. No need
to repeat old mistakes when we know better :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
