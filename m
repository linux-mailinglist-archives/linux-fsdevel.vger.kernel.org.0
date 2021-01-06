Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5582EBB42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 09:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbhAFIrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 03:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726725AbhAFIrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609922765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h4B8kH6ze+E5PoMixXcia7NZlNRqi70d7MWvzMT8C7I=;
        b=DCDRl7sprFToBSLhVrYTmPmPiW3nRoRcJJ+hvsW/oGbDihguliEmcPS5ESYJKGFpSN9X55
        n7u+cYEpvYy3xCtdvkV/Rvs2KXHeLOOiGfrc0x8gluvAjyzK5RKpSabxhTi/oPq7h/erU1
        wANjCkvOjDockaImgfTVfg7slbExZpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-S-sSwl_sMvybwBrg6vzwUQ-1; Wed, 06 Jan 2021 03:46:04 -0500
X-MC-Unique: S-sSwl_sMvybwBrg6vzwUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E6D10054FF;
        Wed,  6 Jan 2021 08:46:02 +0000 (UTC)
Received: from T590 (ovpn-12-163.pek2.redhat.com [10.72.12.163])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8022D6A8FB;
        Wed,  6 Jan 2021 08:45:53 +0000 (UTC)
Date:   Wed, 6 Jan 2021 16:45:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving
 writeback bvecs allocation
Message-ID: <20210106084548.GA3845805@T590>
References: <20210105132647.3818503-1-ming.lei@redhat.com>
 <20210105183938.GA3878@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105183938.GA3878@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:39:38PM +0100, Christoph Hellwig wrote:
> At least for iomap I think this is the wrong approach.  Between the
> iomap and writeback_control we know the maximum size of the writeback
> request and can just use that.

I think writeback_control can tell us nothing about max pages in single
bio:

- wbc->nr_to_write controls how many pages to writeback, this pages
  usually don't belong to same bio. Also this number is often much
  bigger than BIO_MAX_PAGES.

- wbc->range_start/range_end is similar too, which is often much more
  bigger than BIO_MAX_PAGES.

Also page/blocks_in_page can be mapped to different extent too, which is
only available when wpc->ops->map_blocks() is returned, which looks not
different with mpage_writepages(), in which bio is allocated with
BIO_MAX_PAGES vecs too.

Or you mean we can use iomap->length for this purpose? But iomap->length
still is still too big in case of xfs.

-- 
Ming

