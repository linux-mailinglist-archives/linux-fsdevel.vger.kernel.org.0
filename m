Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0232A14E4D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3Vfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 16:35:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgA3Vfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 16:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lEn2eE0qOiISzFnNdvDGTgaPAAcv7U9pblByr/9zg6c=; b=DAFPPSbZLJzapcIIVHAkTsDui
        ESwf8hNfGcili9VLWVLlUWojxXG8dmtOkmhpNJMNDfr1NOAf2y/MTKl/wLBm+mj70IAwtT0zMpLUX
        p0r2w2q62Nzaet7BZIIXus++tM1PqmAFhj/g3rEYYneyJ72JmTx+D4DVz2k+T/qFFULwE+QSKjYJB
        igA92CNMZvne0oqySDWQBzkBi4yXRxi0SCqmwxb4rD7xsie2n7SOJ/gPBuVBkjZAW+qVS/ijKuYak
        ihfZadlAQ8kEO2vaM8l9Qz6ZGZyIMVOde4//DQ7V15gpcMX1LQ5axAcp0Nz8ErMhyDQCzyVg8fQsg
        dbclkQHtg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixHTJ-0005Mj-9O; Thu, 30 Jan 2020 21:35:33 +0000
Date:   Thu, 30 Jan 2020 13:35:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] fuse: Convert from readpages to readahead
Message-ID: <20200130213533.GN6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-12-willy@infradead.org>
 <20200129010829.GK18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129010829.GK18610@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:08:29PM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 05:35:52PM -0800, Matthew Wilcox wrote:
> > +	while (nr_pages--) {
> > +		struct page *page = readahead_page(mapping, start++);
> > +		int err = fuse_readpages_fill(&data, page);
> > +
> > +		if (!err)
> > +			continue;
> > +		nr_pages++;
> > +		goto out;
> >  	}
> 
> That's some pretty convoluted logic. Perhaps:
> 
> 	for (; nr_pages > 0 ; nr_pages--) {
> 		struct page *page = readahead_page(mapping, start++);
> 
> 		if (fuse_readpages_fill(&data, page))
> 			goto out;
> 	}

I have a bit of an aversion to that style of for loop ... I like this
instead:

        while (nr_pages) {
                struct page *page = readahead_page(mapping, start++);

                if (fuse_readpages_fill(&data, page) != 0)
                        goto out;
                nr_pages--;
        }

