Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6075579C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 21:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfFYTOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 15:14:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730939AbfFYTOp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:14:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F3A1ABD7;
        Tue, 25 Jun 2019 19:14:44 +0000 (UTC)
Date:   Tue, 25 Jun 2019 14:14:42 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, david@fromorbit.com
Subject: Re: [PATCH 1/6] iomap: Use a IOMAP_COW/srcmap for a
 read-modify-write I/O
Message-ID: <20190625191442.m27cwx5o6jtu2qch@fiona>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
 <20190621192828.28900-2-rgoldwyn@suse.de>
 <20190624070734.GB3675@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624070734.GB3675@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:07 24/06, Christoph Hellwig wrote:
> xfs will need to be updated to fill in the additional iomap for the
> COW case.  Has this series been tested on xfs?
> 

No, I have not tested this, or make xfs set IOMAP_COW. I will try to do
it in the next iteration.

> I can't say I'm a huge fan of this two iomaps in one method call
> approach.  I always though two separate iomap iterations would be nicer,
> but compared to that even the older hack with just the additional
> src_addr seems a little better.

I am just expanding on your idea of using multiple iterations for the Cow case
in the hope we can come out of a good design:

1. iomap_file_buffered_write calls iomap_apply with IOMAP_WRITE flag.
   which calls iomap_begin() for the respective filesystem.
2. btrfs_iomap_begin() sets up iomap->type as IOMAP_COW and fills iomap
   struct with read addr information.
3. iomap_apply() conditionally for IOMAP_COW calls do_cow(new function)
   and calls ops->iomap_begin() with flag IOMAP_COW_READ_DONE(new flag).
4. btrfs_iomap_begin() fills up iomap structure with write information.

Step 3 seems out of place because iomap_apply should be iomap.type agnostic.
Right?
Should we be adding another flag IOMAP_COW_DONE, just to figure out that
this is the "real" write for iomap_begin to fill iomap?

If this is not how you imagined, could you elaborate on the dual iteration
sequence?


-- 
Goldwyn
