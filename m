Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CC14D72A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgA3IAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 03:00:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43462 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgA3IAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XnXHQPHbbFlev6SIF+EFCVeGDG26FYxTO2L/ebYCkAs=; b=bm8CJepr+Pj34KELoYqkEhCwX
        fCm7LnxR3yvUvOsU9h+7moHepsw9ZxY6bkv0zxIkXzWmgaOlhZeXRmkU3IHdA31RzYqMF6B3ezEkE
        HZD/42zes2LO55eEMAXR+7dq4wlG047PdjLDu2pKs1B/2GPNh3NrLDcuVusZaSg8RH0zFRGwPcG4D
        U3fiAtVhIvGy4Ikf+Pus5ZSsJqxHtyDXyVK72q1UEpinu8jcZnHaLrnb5SHWYYn5L8ZcDx1iU+q00
        59EPRzfQl88oljwbmQaGuaB+C9h7ksljceO2cJmAxImXrs+f9JGFUmRMf4VqSksHdLlokhYF95CJF
        ep8CWbGiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4kH-0004zP-OW; Thu, 30 Jan 2020 08:00:13 +0000
Date:   Thu, 30 Jan 2020 00:00:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
Message-ID: <20200130080013.GK6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
 <20200129002456.GH18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129002456.GH18610@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:24:56AM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 05:35:45PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This replaces ->readpages with a saner interface:
> >  - Return the number of pages not read instead of an ignored error code.
> >  - Pages are already in the page cache when ->readahead is called.
> >  - Implementation looks up the pages in the page cache instead of
> >    having them passed in a linked list.
> ....
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 5a6676640f20..6d65dae6dad0 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -121,7 +121,18 @@ static void read_pages(struct address_space *mapping, struct file *filp,
> >  
> >  	blk_start_plug(&plug);
> >  
> > -	if (mapping->a_ops->readpages) {
> > +	if (mapping->a_ops->readahead) {
> > +		unsigned left = mapping->a_ops->readahead(filp, mapping,
> > +				start, nr_pages);
> > +
> > +		while (left) {
> > +			struct page *page = readahead_page(mapping,
> > +					start + nr_pages - left - 1);
> 
> Off by one? start = 2, nr_pages = 2, left = 1, this looks up the
> page at index 2, which is the one we issued IO on, not the one we
> "left behind" which is at index 3.

Yup.  I originally had:

		while (left--) ...

decided that was too confusing and didn't quite complete that thought.
