Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CE38C08A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhEUHSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 03:18:54 -0400
Received: from verein.lst.de ([213.95.11.211]:46775 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhEUHSw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 03:18:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2685767373; Fri, 21 May 2021 09:17:28 +0200 (CEST)
Date:   Fri, 21 May 2021 09:17:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: iomap: writeback ioend/bio allocation deadlock risk
Message-ID: <20210521071727.GA11473@lst.de>
References: <YKcouuVR/y/L4T58@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKcouuVR/y/L4T58@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 11:27:54AM +0800, Ming Lei wrote:
>         if %__gfp_direct_reclaim is set then bio_alloc will always be able to
>         allocate a bio.  this is due to the mempool guarantees.  to make this work,
>         callers must never allocate more than 1 bio at a time from the general pool.
>         callers that need to allocate more than 1 bio must always submit the
>         previously allocated bio for io before attempting to allocate a new one.
>         failure to do so can cause deadlocks under memory pressure.
> 
> 1) more than one ioends can be allocated from 'iomap_ioend_bioset'
> before submitting them all, so mempoll guarantee can't be made, which can
> be observed frequently in writeback over ext4
> 
> 2) more than one chained bio(allocated from fs_bio_set) via iomap_chain_bio,
> which is easy observed when writing big files on XFS:

The comment describing bio_alloc_bioset is actually wrong.  Allocating
more than 1 at a time is perfectly fine, it just can't be more than
the pool_size argument passed to bioset_init.

iomap_ioend_bioset is sized to make sure we can always complete up
to 4 pages, and the list is only used inside a page, so we're fine.

fs_bio_set always has two entries to allow exactly for the common
chain and submit pattern.
