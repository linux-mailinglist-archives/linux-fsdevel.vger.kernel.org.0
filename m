Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2521D17936D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgCDPeB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:34:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCDPeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AnM84Lt4VRzYoXNtkX6eksI4bqOZSqh20o6IdsuWiew=; b=BuD4KHdd9KxV+XagASjNUyxfx8
        aBjhqtDbYHpdch6wQ/cIcHejEC3wDHo9XWBknR0XlRGc4+S0FytzWooSZz+egQJZQbLehS3KgaS3H
        V96a8w5NIfrbuVAfxM8q45Qb7Bzqs5lRK8kOReBme6o+7vz3omVCndxTav4XGWxfd2KDlI/TfB8v1
        WPnfzQopOml9VwXZI/BhCn/21b+orFy3IQl88Miyw12kg1K96BiyZzQGghvrld424+Q1Kz0dwJI3M
        UtKZltVI8b02DqOXeytBNRyo5wbFZ98IAEePC4T72B7xnxTYK9YjQoUP/0tZee3TakuGRPh7lWmln
        Za/ckQ5Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9W24-0002PM-Nb; Wed, 04 Mar 2020 15:34:00 +0000
Date:   Wed, 4 Mar 2020 07:34:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] iomap: Fix writepage tracepoint pgoff
Message-ID: <20200304153400.GG29971@bombadil.infradead.org>
References: <20200304142259.GF29971@bombadil.infradead.org>
 <20200304152515.GA23148@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304152515.GA23148@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 07:25:15AM -0800, Christoph Hellwig wrote:
> On Wed, Mar 04, 2020 at 06:22:59AM -0800, Matthew Wilcox wrote:
> > From: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > page_offset() confusingly returns the number of bytes from the
> > beginning of the file and not the pgoff, which the tracepoint claims
> > to be returning.  We're already returning the number of bytes from the
> > beginning of the file in the 'offset' parameter, so correct the pgoff
> > to be what was apparently intended.
> > 
> > Fixes: 0b1b213fcf3a ("xfs: event tracing support")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I wonder if tracing the byte offset and just changing the name
> might be more useful.  But I agree that we should fix it one way or
> another.

I covered that -- "We're already returning the number of bytes from the
beginning of the file in the 'offset' parameter, so correct the pgoff
to be what was apparently intended."

I mean, we could just delete the pgoff instead.  Apparently nobody's
using it, or they would surely have noticed.

