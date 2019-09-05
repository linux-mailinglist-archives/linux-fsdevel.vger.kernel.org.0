Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33181AACFB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbfIEU2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 16:28:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:54042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731823AbfIEU2J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 16:28:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF16FAC64;
        Thu,  5 Sep 2019 20:28:07 +0000 (UTC)
Date:   Thu, 5 Sep 2019 15:28:05 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/15] iomap: Read page from srcmap if IOMAP_F_COW is set
Message-ID: <20190905202805.nhhmsyiicnyeaeuy@fiona>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
 <20190905150650.21089-3-rgoldwyn@suse.de>
 <20190905163756.GA22883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905163756.GA22883@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18:37 05/09, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 10:06:37AM -0500, Goldwyn Rodrigues wrote:
> > -	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
> > +	} else if (iomap->flags & IOMAP_F_COW) {
> > +		if (WARN_ON_ONCE(iomap->flags & IOMAP_F_BUFFER_HEAD)) {
> > +			status = -EIO;
> > +			goto out_no_page;
> > +		}
> > +		if (WARN_ON_ONCE(srcmap->type == IOMAP_HOLE &&
> > +				 srcmap->addr != IOMAP_NULL_ADDR)) {
> 
> Well, we want HOLES to have IOMAP_NULL_ADDR everywhere, so not sure
> why the assert is just here.

This came up as one of the review comments for checking srcmap.
This does look ugly after taking out iomap_assert(). Removing.

> 
> > +			status = -EIO;
> > +			goto out_no_page;
> > +		}
> > +		status = __iomap_write_begin(inode, pos, len, page, srcmap);
> > +	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> >  		status = __block_write_begin_int(page, pos, len, NULL, iomap);
> > -	else
> > +	} else {
> >  		status = __iomap_write_begin(inode, pos, len, page, iomap);
> > +	}
> 
> Maybe a good way to structure this is:
> 
> 	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
> 		if (WARN_ON_ONCE(iomap->flags & IOMAP_F_COW)) {
> 			status = -EIO;
> 			goto out_no_page;
> 		}
> 		status = __block_write_begin_int(page, pos, len, NULL, iomap);
> 	} else {
>  		status = __iomap_write_begin(inode, pos, len, page,
> 				(iomap->flags & IOMAP_F_COW) ?  srcmap : iomap);
> 	}

Yes, this looks much better. Will incorporate.

-- 
Goldwyn
