Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5B76C54D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 08:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHBGbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHBGbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:31:39 -0400
Received: from out-97.mta0.migadu.com (out-97.mta0.migadu.com [IPv6:2001:41d0:1004:224b::61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F642706
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 23:31:36 -0700 (PDT)
Date:   Wed, 2 Aug 2023 02:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690957893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IK3aEBELlq1x3phTcf/ZsaDVc7hT1k6rf0vBkIgEPXc=;
        b=Pr473z+oXbzMZnI8H/I7LVvXQV9wG8U4dZbKBe3GO0clA6n4ufvTxLMl7tbSVxVExQcRo8
        E2SQPidb8c3SQ9nSKJk5xAX3p5AwQD8J2yu+jrf6U177qpC8Zvi0ZKsaUnioprO3HsnSoR
        XqACV00ARwzJ1G94/gTOP41ZZ9rVOVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230802063124.4652m3gfbhdmghlt@moria.home.lan>
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
 <20230720075050.GB5042@lst.de>
 <20230801130702.2taecrgn4v66ehtx@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801130702.2taecrgn4v66ehtx@green245>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 06:37:02PM +0530, Nitesh Shetty wrote:
> On 23/07/20 09:50AM, Christoph Hellwig wrote:
> > > +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
> > > +		gfp_t gfp_mask)
> > > +{
> > > +	int min_size = PAGE_SIZE;
> > > +	void *buf;
> > > +
> > > +	while (req_size >= min_size) {
> > > +		buf = kvmalloc(req_size, gfp_mask);
> > > +		if (buf) {
> > > +			*alloc_size = req_size;
> > > +			return buf;
> > > +		}
> > > +		/* retry half the requested size */
> > > +		req_size >>= 1;
> > > +	}
> > > +
> > > +	return NULL;
> > 
> > Is there any good reason for using vmalloc instead of a bunch
> > of distcontiguous pages?
> > 
> 
> kvmalloc seemed convenient for the purpose. We will need to call alloc_page
> in a loop to guarantee discontigous pages. Do you prefer that over kvmalloc?

No, kvmalloc should be the preferred approach here now: with large
folios, we're now getting better about doing more large memory
allocations and avoiding fragmentation, so in practice this won't be a
vmalloc allocation except in exceptional circumstances, and performance
will be better and the code will be simpler doing a single large
allocation.
