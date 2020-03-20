Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1384118D15E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Mar 2020 15:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCTOoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 10:44:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCTOoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Ot4T7DiOWzDUGrL0YNjyFXeX31tW8Y03XvdRorx/wA=; b=YLzYrhrBao3AE/g/sdr1uSRmRK
        H3HfYosqAoMLOxC32p2SDMHfm6S4CJUXC3xHijxqWcymgVaBKYyjun7eAoujP43I75y7q5YjalLw0
        QV0oMEse+mqWa3um7J1cQXeIVP2sUuhEhLNyWMYRk35EAtEMyNee/J6yE4moXzxU73sNIXrugOA00
        01ljJ3J5Jy4M64pXrqxAJqhQYDB3FMAfXEIYjdnumDO8YguyPppxN8wRBunxr5z3dVZ721tG+znC5
        QiiFk0/QKF7RHNsaK7vGGb+vn9u4IahJSDFUCgRp3k2cw49Gq1nOWaoUhyMJQjyE6g1Rv3jWrJndQ
        gzVjpuHw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFItK-0002CN-Qf; Fri, 20 Mar 2020 14:44:54 +0000
Date:   Fri, 20 Mar 2020 07:44:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit the BIO at the end of each extent
Message-ID: <20200320144454.GA32039@infradead.org>
References: <20200320144014.3276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320144014.3276-1-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 20, 2020 at 07:40:14AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By definition, an extent covers a range of consecutive blocks, so
> it would be quite rare to be able to just add pages to the BIO from
> a previous range.  The only case we can think of is a mapped extent
> followed by a hole extent, followed by another mapped extent which has
> been allocated immediately after the first extent.  We believe this to
> be an unlikely layout for a filesystem to choose and, since the queue
> is plugged, those two BIOs would be merged by the block layer.
> 
> The reason we care is that ext2/ext4 choose to lay out blocks 0-11
> consecutively, followed by the indirect block, and we want to merge those
> two BIOs.  If we don't submit the data BIO before asking the filesystem
> for the next extent, then the indirect BIO will be submitted first,
> and waited for, leading to inefficient I/O patterns.  Buffer heads solve
> this with the BH_boundary flag, but iomap doesn't need that as long as
> we submit the bio here.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
