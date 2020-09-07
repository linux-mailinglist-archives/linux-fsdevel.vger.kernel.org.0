Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED825F397
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgIGHHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIGHHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:07:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378F7C061573;
        Mon,  7 Sep 2020 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rd5+BO+wcfvR2DH9JGUePavDycNE1Fegbtj9haaWlK8=; b=SFA/iSjWCUlVdK5O159w5509yb
        zfZBUgtaaXJV8db/l4c7rEYPRVV6aDFq6ZH3ycehB74S7efqOeXM7svGVnwWSxWZPX48LHIBjYtg6
        5UH0ePFHEKrdFfLrlCV85rakArCUCcC6M6cxwQsIFTiQBwKEEREaaqhENLGAZwxJcqaXUj3OgnbPr
        Jp4fEjLAmS2bCuzJUYOFYx/acz69sIkgUdQhazDxp5xetBKYRECY8/J2Xq6awZc7K6WJQOcK91Cm/
        E9hMxkdNzTXysqw2YnKVBkHAtLWRLUUw7Cuj3d6+DlsGk12SkO3VS5dfXguTOvhgAR+6jYsM7GCVF
        3BtbueOg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFBEz-00073a-HM; Mon, 07 Sep 2020 07:07:01 +0000
Date:   Mon, 7 Sep 2020 08:07:01 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [PATCH] iomap: Fix direct I/O write consistency check
Message-ID: <20200907070701.GA27019@infradead.org>
References: <20200903165632.1338996-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903165632.1338996-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 03, 2020 at 06:56:32PM +0200, Andreas Gruenbacher wrote:
> When a direct I/O write falls back to buffered I/O entirely, dio->size
> will be 0 in iomap_dio_complete.  Function invalidate_inode_pages2_range
> will try to invalidate the rest of the address space.  If there are any
> dirty pages in that range, the write will fail and a "Page cache
> invalidation failure on direct I/O" error will be logged.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
