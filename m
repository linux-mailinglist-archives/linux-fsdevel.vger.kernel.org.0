Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2072D3F9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 11:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgLIKLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 05:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbgLIKLN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:11:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC39C0613CF;
        Wed,  9 Dec 2020 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iNVF9+1CEmnQuYVa3mTrTTlxl79IEcI5MQ5t1D/MbMI=; b=eMDgKToNzoSUAXmmfYxnYyXws/
        Yad91sysOoU9rE4b/HDnTKW/aFGVG3/ZfZJL/rtj7MQHFy/uW3WFtvUcJ3feD8TZxEFHLQRWbjqsK
        gp+2f1dtobc+BsteZJ7qh12N6hNWb2Lc/I/fWMjqJKHm0el91kz+eoAo6OKHkjK88ml9dJ2oaXWuw
        tUHg61PGLqYhvra2Tr7oskQg+L7uSI9GEyWBbsTgMF+f2MTeDjYPZLLBB2I7XhGc54e9c9IG2xIO4
        i55/PzTz3Ssb5BsX7sAN8Sr+cQtjR12jk0UIMD1r6wvfp82k1WNPBa2FYEZCAvVDVsPmHcagrfbgo
        PcUwH/yg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmwQY-0003un-EW; Wed, 09 Dec 2020 10:10:30 +0000
Date:   Wed, 9 Dec 2020 10:10:30 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201209101030.GA14302@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201209093138.GA3970@infradead.org>
 <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598A4DA5A6E8F67DFB070859BCC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 09, 2020 at 10:08:53AM +0000, Johannes Thumshirn wrote:
> On 09/12/2020 10:34, Christoph Hellwig wrote:
> > Btw, another thing I noticed:
> > 
> > when using io_uring to submit a write to btrfs that ends up using Zone
> > Append we'll hit the
> > 
> > 	if (WARN_ON_ONCE(is_bvec))
> > 		return -EINVAL;
> > 
> > case in bio_iov_iter_get_pages with the changes in this series.
> 
> Yes this warning is totally bogus. It was in there from the beginning of the
> zone-append series and I have no idea why I didn't kill it.
> 
> IIRC Chaitanya had a patch in his nvmet zoned series removing it.

Yes, but it is wrong.  What we need is a version of
__bio_iov_bvec_add_pages that takes the hardware limits into account.
