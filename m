Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B4A5B6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfIBQb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 12:31:28 -0400
Received: from verein.lst.de ([213.95.11.211]:51524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfIBQb2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 12:31:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8B101227A8A; Mon,  2 Sep 2019 18:31:24 +0200 (CEST)
Date:   Mon, 2 Sep 2019 18:31:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, david@fromorbit.com,
        riteshh@linux.ibm.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/15] iomap: Read page from srcmap for IOMAP_COW
Message-ID: <20190902163124.GC6263@lst.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de> <20190901200836.14959-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901200836.14959-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 03:08:24PM -0500, Goldwyn Rodrigues wrote:

> +		iomap_assert(!(iomap->flags & IOMAP_F_BUFFER_HEAD));
> +		iomap_assert(srcmap->type == IOMAP_HOLE || srcmap->addr > 0);

0 can be a valid address in various file systems, so I don't think we
can just exclude it.  Then again COWing from a hole seems pointless,
doesn't it?

So just check for addr != IOMAP_NULL_ADDR here?

>  
> @@ -961,7 +966,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
>  		if (IS_DAX(inode))
>  			status = iomap_dax_zero(pos, offset, bytes, iomap);
>  		else
> -			status = iomap_zero(inode, pos, offset, bytes, iomap);
> +			status = iomap_zero(inode, pos, offset, bytes, iomap, srcmap);

This introduces an > 80 character line.
