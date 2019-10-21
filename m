Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F6DED87
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfJUN2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:28:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:49826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727322AbfJUN2V (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:28:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50A5FB70B;
        Mon, 21 Oct 2019 13:28:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BCD441E4AA0; Mon, 21 Oct 2019 15:28:18 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:28:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 02/12] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191021132818.GB25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:17:46, Matthew Bobrowski wrote:
> This patch is effectively addressed what Dave Chinner had found and
> fixed within this commit: 8a23414ee345. Justification for needing this
> modification has been provided below:
> 
> When doing a direct IO that spans the current EOF, and there are
> written blocks beyond EOF that extend beyond the current write, the
> only metadata update that needs to be done is a file size extension.
> 
> However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> there is IO completion metadata updates required, and hence we may
> fail to correctly sync file size extensions made in IO completion when
> O_DSYNC writes are being used and the hardware supports FUA.
> 
> Hence when setting IOMAP_F_DIRTY, we need to also take into account
> whether the iomap spans the current EOF. If it does, then we need to
> mark it dirty so that IO completion will call generic_write_sync() to
> flush the inode size update to stable storage correctly.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

Looks good to me. You could possibly also comment in the changelog that
currently, this change doesn't have user visible impact for ext4 as none of
current users of ext4_iomap_begin() that extend files depend of
IOMAP_F_DIRTY.

Also this patch would make slightly more sense to be before 1/12 so that
you don't have there those two strange unused arguments. But these are just
small nits.

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/ext4/inode.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 158eea9a1944..0dd29ae5cc8c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3412,8 +3412,14 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>  {
>  	u8 blkbits = inode->i_blkbits;
>  
> +	/*
> +	 * Writes that span EOF might trigger an I/O size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC, even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
>  	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
>  		iomap->flags |= IOMAP_F_DIRTY;
>  
>  	if (map->m_flags & EXT4_MAP_NEW)
> -- 
> 2.20.1
> 
> --<M>--
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
