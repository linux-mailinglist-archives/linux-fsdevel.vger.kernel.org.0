Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0428121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfEWP10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 11:27:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:39808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730972AbfEWP10 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 11:27:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 69AD7ADEA;
        Thu, 23 May 2019 15:27:25 +0000 (UTC)
Date:   Thu, 23 May 2019 10:27:22 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, darrick.wong@oracle.com,
        dsterba@suse.cz, nborisov@suse.com, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 16/18] btrfs: Writeprotect mmap pages on snapshot
Message-ID: <20190523152722.ybo5xuhej3yonvgt@fiona>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-17-rgoldwyn@suse.de>
 <20190523140445.GD2949@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523140445.GD2949@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16:04 23/05, Jan Kara wrote:
> On Mon 29-04-19 12:26:47, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Inorder to make sure mmap'd files don't change after snapshot,
> > writeprotect the mmap pages on snapshot. This is done by performing
> > a data writeback on the pages (which simply mark the pages are
> > wrprotected). This way if the user process tries to access the memory
> > we will get another fault and we can perform a CoW.
> > 
> > In order to accomplish this, we tag all CoW pages as
> > PAGECACHE_TAG_TOWRITE, and add the mmapd inode in delalloc_inodes.
> > During snapshot, it starts writeback of all delalloc'd inodes and
> > here we perform a data writeback. We don't want to keep the inodes
> > in delalloc_inodes until it umount (WARN_ON), so we remove it
> > during inode evictions.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> OK, so here you use PAGECACHE_TAG_TOWRITE. But why is not
> PAGECACHE_TAG_DIRTY enough for you? Also why isn't the same needed also for
> normal non-DAX inodes? There you also need to trigger CoW on mmap write so
> I just don't see the difference...

Because dax_writeback_mapping_range() writebacks pages marked 
PAGECACHE_TAG_TOWRITE and not PAGECACHE_TAG_DIRTY. Should it
writeback pages marked as PAGECACHE_TAG_DIRTY as well?


-- 
Goldwyn
