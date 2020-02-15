Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B46215FBE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 02:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBOBPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 20:15:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbgBOBPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 20:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8vF3wmoykU6jc6+10TSp5NOFVxwRnMSI+FSzYO1WEQQ=; b=bYTz4ixAcXgUBn5lU/9H4Qkc8U
        psonlrVRSl1w2Efajn8sSvZ4fc66CBslbfJ8hYC7paJRLK+yJwFFKlpcmnCuSqQ3VgQIQc9bRKzS3
        RKpTi9vip5bJenIXktMAoR2hmT8VH80rF4tgY3sf4QnBz8MWKa+ALVxAEtDMgRdz1VPOIaUeTItOS
        2pxc8IX2HDPzzkM5B4sWPw6NpUySd6jYHfalkiD/26kIZxfM118k/TIVrruZyhX4bQ6tIJjKq3niB
        ldfXT72DOy+DLMs6ox4SNWF1RllK7qc+dkUXgtwEY31BR65L8+zEdJD+0mj8Hsxex+wOSOCKsfGso
        5F0cnt9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2m2z-0006lw-H3; Sat, 15 Feb 2020 01:15:05 +0000
Date:   Fri, 14 Feb 2020 17:15:05 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v5 04/13] mm: Add readahead address space operation
Message-ID: <20200215011505.GD7778@bombadil.infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-5-willy@infradead.org>
 <755399a8-8fdf-bfac-9f23-81579ff63ddf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <755399a8-8fdf-bfac-9f23-81579ff63ddf@nvidia.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:36:25PM -0800, John Hubbard wrote:
> > +static inline struct page *readahead_page(struct readahead_control *rac)
> > +{
> > +	struct page *page;
> > +
> > +	if (!rac->nr_pages)
> > +		return NULL;
> > +
> > +	page = xa_load(&rac->mapping->i_pages, rac->start);
> 
> 
> Is it worth asserting that the page was found:
> 
> 	VM_BUG_ON_PAGE(!page || xa_is_value(page), page);
> 
> ? Or is that overkill here?

It shouldn't be possible since they were just added in a locked state.
If it did happen, it'll be caught by the assert below -- dereferencing
a NULL pointer or a shadow entry is not going to go well.

> > +	VM_BUG_ON_PAGE(!PageLocked(page), page);
> > +	rac->batch_count = hpage_nr_pages(page);
> > +	rac->start += rac->batch_count;
> 
> The above was surprising, until I saw the other thread with Dave and you.
> I was reviewing this patchset in order to have a chance at understanding the 
> follow-on patchset ("Large pages in the page cache"), and it seems like that
> feature has a solid head start here. :)  

Right, I'll document that.
