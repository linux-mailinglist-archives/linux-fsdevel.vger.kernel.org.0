Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD5FAA92F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbfIEQiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:38:01 -0400
Received: from verein.lst.de ([213.95.11.211]:50209 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389096AbfIEQiA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:38:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A01468B05; Thu,  5 Sep 2019 18:37:56 +0200 (CEST)
Date:   Thu, 5 Sep 2019 18:37:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, hch@lst.de, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Read page from srcmap if IOMAP_F_COW is
 set
Message-ID: <20190905163756.GA22883@lst.de>
References: <20190905150650.21089-1-rgoldwyn@suse.de> <20190905150650.21089-3-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150650.21089-3-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:06:37AM -0500, Goldwyn Rodrigues wrote:
> -	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> +	} else if (iomap->flags & IOMAP_F_COW) {
> +		if (WARN_ON_ONCE(iomap->flags & IOMAP_F_BUFFER_HEAD)) {
> +			status = -EIO;
> +			goto out_no_page;
> +		}
> +		if (WARN_ON_ONCE(srcmap->type == IOMAP_HOLE &&
> +				 srcmap->addr != IOMAP_NULL_ADDR)) {

Well, we want HOLES to have IOMAP_NULL_ADDR everywhere, so not sure
why the assert is just here.

> +			status = -EIO;
> +			goto out_no_page;
> +		}
> +		status = __iomap_write_begin(inode, pos, len, page, srcmap);
> +	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
>  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
> -	else
> +	} else {
>  		status = __iomap_write_begin(inode, pos, len, page, iomap);
> +	}

Maybe a good way to structure this is:

	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
		if (WARN_ON_ONCE(iomap->flags & IOMAP_F_COW)) {
			status = -EIO;
			goto out_no_page;
		}
		status = __block_write_begin_int(page, pos, len, NULL, iomap);
	} else {
 		status = __iomap_write_begin(inode, pos, len, page,
				(iomap->flags & IOMAP_F_COW) ?  srcmap : iomap);
	}
