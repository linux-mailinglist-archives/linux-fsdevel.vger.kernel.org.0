Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C3216D08
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 14:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGMnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 08:43:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgGGMnu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85558AAC5;
        Tue,  7 Jul 2020 12:43:49 +0000 (UTC)
Date:   Tue, 7 Jul 2020 07:43:46 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, david@fromorbit.com,
        darrick.wong@oracle.com, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200707124346.xnr5gtcysuzehejq@fiona>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701075310.GB29884@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On  9:53 01/07, Christoph Hellwig wrote:
> On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> > that if the page invalidation fails, return back control to the
> > filesystem so it may fallback to buffered mode.
> > 
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> I'd like to start a discussion of this shouldn't really be the
> default behavior.  If we have page cache that can't be invalidated it
> actually makes a whole lot of sense to not do direct I/O, avoid the
> warnings, etc.
> 
> Adding all the relevant lists.

Since no one responded so far, let me see if I can stir the cauldron :)

What error should be returned in case of such an error? I think the
userspace process must be immediately informed if it in unable to
invalidate the page cache and complete the direct I/O. Currently, the
iomap code treats this as a writeback error and continues with the
direct I/O and the userspace process comes to know only during file
closure.

If such a change is incorporated, are the current userspace applications
prepared for it?


-- 
Goldwyn
