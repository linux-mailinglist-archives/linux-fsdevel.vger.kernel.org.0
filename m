Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5E70F7A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjEXNdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjEXNdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 09:33:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47999A7;
        Wed, 24 May 2023 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PlI3NINuTp5y2t5Z+4wg7vfiTt8lvB4SyLbHC5tKASU=; b=eq1oO18nKmxdfx79+rZ3TTo5Q2
        2/F3VHC9ngHsBakNRFv680ymTTyCK9hQMC/hF/6ByoTd1QX5Huc2qSnkfOtIpqNxg3U3KILlEnohH
        tk1m/vJLtoK5KkcBjlU2kaBM3cLYnmqGoN2Zya9Htl2CZTaH4W94BgkzuYeaOzmShvPd+qb3ym5EL
        yonGPZiSfd3yzH3hEQFRUsVsx849CuZTYjYDAClbFB7R6Y5PcboAB1JCCXjmLj8dakGubsyS8QwrS
        jjlaR0JAq6BqcKNmdvnkHdN+wsZcZz5xjzhHDugGtoEqqn7cXDiJJ1Gi7vDVBHa/uqXa8DUbUI1v1
        peQuoiEw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1oc5-00BF3M-Tz; Wed, 24 May 2023 13:33:13 +0000
Date:   Wed, 24 May 2023 14:33:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/17] block: use iomap for writes to block devices
Message-ID: <ZG4SGYOogQtEZrll@casper.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-17-hch@lst.de>
 <b96b397e-2f5e-7910-3bb3-7405d0e293a7@suse.de>
 <ZG09wR4WOI8zDxJK@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG09wR4WOI8zDxJK@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 08:27:13AM +1000, Dave Chinner wrote:
> On Fri, May 19, 2023 at 04:22:01PM +0200, Hannes Reinecke wrote:
> > I'm hitting this during booting:
> > [    5.016324]  <TASK>
> > [    5.030256]  iomap_iter+0x11a/0x350
> > [    5.030264]  iomap_readahead+0x1eb/0x2c0
> > [    5.030272]  read_pages+0x5d/0x220
> > [    5.030279]  page_cache_ra_unbounded+0x131/0x180
> > [    5.030284]  filemap_get_pages+0xff/0x5a0
> 
> Why is filemap_get_pages() using unbounded readahead? Surely
> readahead should be limited to reading within EOF....

It isn't using unbounded readahead; that's an artifact of this
incomplete stack trace.  Actual call stack:

page_cache_ra_unbounded
do_page_cache_ra
ondemand_readahead
page_cache_sync_ra
page_cache_sync_readahead
filemap_get_pages

As you can see, do_page_cache_ra() does limit readahead to i_size.
Is ractl->mapping->host the correct way to find the inode?  I always
get confused.

> I think Christoph's code is correct. IMO, any attempt to read beyond
> the end of the device should throw out a warning and return an
> error, not silently return zeros.
> 
> If readahead is trying to read beyond the end of the device, then it
> really seems to me like the problem here is readahead, not the iomap
> code detecting the OOB read request....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
