Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1102BD3D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJKK3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 06:29:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKK3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e1pm+ppP9G4mHDBKdEbkEk2PRM64wxaYR3oENCPUTyE=; b=XNSydHb/lAKCbNx3AoKyl0g0U
        7pawQHMvph4xbyMr8SSWuHcJzqPV+8DuDsGMavK9zRnTJfZAIYoOxsqaLbZkuTUOL1s3wQSwOz8Ci
        ichiGpR8wklf2HXPOxxUbmP5H8GZ/V5Sl1s+Gc6KFSaF/aVC/Q42U37ElDZHIQpUzQw2iyOtLqxZt
        IqBuG3IneLuM/c7skIUWWMLiaVwgn4Y0eT5q5rbwEZ7DmLTHrKfmHU/UEuRwdplxF7GbqAmC62gSn
        EO8O8NI5KiHN+JsWR49YjLTFbIMxH5SywDjmFFnQ1GoYyYqR7hzYb8ckBiGr+0mxW6jn2ej79PEgH
        Lnk9cY63A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsB1-0007We-EX; Fri, 11 Oct 2019 10:29:39 +0000
Date:   Fri, 11 Oct 2019 03:29:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20191011102939.GA12811@infradead.org>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-19-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009032124.10541-19-david@fromorbit.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 02:21:16PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When doing async node reclaiming, we grab a batch of inodes that we
> are likely able to reclaim and ignore those that are already
> flushing. However, when we actually go to reclaim them, the first
> thing we do is lock the inode. If we are racing with something
> else reclaiming the inode or flushing it because it is dirty,
> we block on the inode lock. Hence we can still block kswapd here.
> 
> Further, if we flush an inode, we also cluster all the other dirty
> inodes in that cluster into the same IO, flush locking them all.
> However, if the workload is operating on sequential inodes (e.g.
> created by a tarball extraction) most of these inodes will be
> sequntial in the cache and so in the same batch
> we've already grabbed for reclaim scanning.
> 
> As a result, it is common for all the inodes in the batch to be
> dirty and it is common for the first inode flushed to also flush all
> the inodes in the reclaim batch. In which case, they are now all
> going to be flush locked and we do not want to block on them.
> 
> Hence, for async reclaim (SYNC_TRYLOCK) make sure we always use
> trylock semantics and abort reclaim of an inode as quickly as we can
> without blocking kswapd. This will be necessary for the upcoming
> conversion to LRU lists for inode reclaim tracking.
> 
> Found via tracing and finding big batches of repeated lock/unlock
> runs on inodes that we just flushed by write clustering during
> reclaim.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
