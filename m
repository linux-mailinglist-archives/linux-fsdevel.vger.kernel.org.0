Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B10FE399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKORG4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 12:06:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfKORG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f8HNa2valw1yYBrwr8H4tMZN7Z5zFl6VxQPbzQGob7c=; b=OIdurCm9mO9vFjQkzXWDZymiC
        S0fX5VSvly+H/pdrZjQPvA/zvgGqUN2/uWh9NQq66AF7HzIX5f3bwv9mCzPuMnv6GG6gd2I6Rl18e
        2RUpqaENBus2ScmTC5GiV7H/sDxMiQFiNF87qmxdIV2Nc3ND3Au6VWCMJ1thjkkU6zhf2pgdmpkdN
        HWqzTHpx4E51mnL5gn3x0zOzD6/vOKNb0C5V7STX5zegOIfVrBGeq+UwcTPd3/HzWh15sxrwNbZ45
        zhyGJBBfUHZKxfo5uiUsW2YYsCqqQV+yPHAdAMhWb0koQoMN+heQhclzAwsWOSxrq77gCOfeBgiaK
        4RTxEuEqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVf3f-0007Z4-9r; Fri, 15 Nov 2019 17:06:55 +0000
Date:   Fri, 15 Nov 2019 09:06:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/7] btrfs: Use iomap_dio_rw() for direct I/O
Message-ID: <20191115170655.GF26016@infradead.org>
References: <20191115161700.12305-1-rgoldwyn@suse.de>
 <20191115161700.12305-5-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115161700.12305-5-rgoldwyn@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 10:16:57AM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> This is the main patch to switch call from
> __blockdev_direct_IO() to iomap_dio_rw(). In this patch:
> 
> Removed buffer_head references
> Removed inode_dio_begin() and inode_dio_end() functions since
> they are called in iomap_dio_rw().
> Renamed btrfs_get_blocks_direct() to direct_iomap_begin() and
> used it as iomap_begin()
> address_space.direct_IO now is a noop since direct_IO is called
> from __btrfs_write_direct().
> 
> Removed flags parameter used for __blockdev_direct_IO(). iomap is
> capable of direct I/O reads from a hole, so we don't need to
> return -ENOENT.

There isn't really any need to describe the low-level changes,
but more what this changes at a high level, and more importantly
the reasons for that.

>  static int btrfs_get_blocks_direct_write(struct extent_map **map,
> -					 struct buffer_head *bh_result,
>  					 struct inode *inode,
>  					 struct btrfs_dio_data *dio_data,
>  					 u64 start, u64 len)

Should this function be renamed as well? btrfs_iomap_begin_write?

> +static int direct_iomap_begin(struct inode *inode, loff_t start,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)

This needs a btrfs_ prefix.

> +	if ((em->block_start == EXTENT_MAP_HOLE) ||

No need for the inner braces.

> -	dio_end_io(dio_bio);

You removed the only users of dio_end_io and the submit hook in the
old dio code.  Please add a patch to remove those at the end of the
series.

> -				   btrfs_submit_direct, flags);
> +	ret = iomap_dio_rw(iocb, iter, &dio_iomap_ops, NULL, is_sync_kiocb(iocb));

This adds a line > 80 chars.

