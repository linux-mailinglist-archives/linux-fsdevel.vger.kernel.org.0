Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A74B735CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 19:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjFSRKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjFSRJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:09:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463C5199;
        Mon, 19 Jun 2023 10:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RxTEmflNGaLwRZb2qAXUHsgOyb6YedhBYyUpWKycMXI=; b=cmSw80uWFboEvvxGh4Kj5rNKnt
        Z0lMTTv5ThkDzWIMHdcxi3XIV/nUjEO555AnAamK31xVpwRVWHptixvJ1N+gHpfZ6tWPUCb27/KmN
        heEpgySC6FYAki09T7iQYL2IpkQQPG2zi8BTl8KAMvKoFUBWB9KBhusRceIQTVbv9lU7L8gnyhBc4
        Lvb9dr5G/3Otzw7jf3BkC5GHfS+ZTIgFU6HJn9XAbYXFx4AZTkEl2XAN29aon3pIfN/EfLiBoLWWr
        O+EWAi1/SMGSuvA1sxgklyHOhCf8pNEVTSxrHeiGkRySMz3QMCdM2bvjx+LUSIiYrcZqnO4g8mM6g
        9WjOY0ig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBINq-00C63J-Hu; Mon, 19 Jun 2023 17:09:42 +0000
Date:   Mon, 19 Jun 2023 18:09:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 8/8] iomap: Copy larger chunks from userspace
Message-ID: <ZJCL1phh2UOqrM8J@casper.infradead.org>
References: <20230612203910.724378-9-willy@infradead.org>
 <877cs2o91k.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cs2o91k.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 12:43:59PM +0530, Ritesh Harjani wrote:
> >  	do {
> >  		struct folio *folio;
> > -		struct page *page;
> > -		unsigned long offset;	/* Offset into pagecache page */
> > -		unsigned long bytes;	/* Bytes to write to page */
> > +		size_t offset;		/* Offset into folio */
> > +		unsigned long bytes;	/* Bytes to write to folio */
> 
> why not keep typeof "bytes" as size_t same as of "copied".

Sure, makes sense.

> > @@ -835,6 +837,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
> >  			 */
> >  			if (copied)
> >  				bytes = copied;
> 
> I think with your code change which changes the label position of
> "again", the above lines doing bytes = copied becomes dead code.
> We anyway recalculate bytes after "again" label. 

Yes, you're right.  Removed.  I had a good think about whether this
forgotten removal meant an overlooked problem, but I can't see one.
