Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB8163CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 07:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgBSGER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 01:04:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgBSGEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AFjhUzdSTL6y+bUgZojZ9Wfk2mmuh2/h+v4Y4bp+dts=; b=euzainEafG+87t1P9h7KE5mkvI
        BHK6B7Pb2S42nRqKfcgAxHx9lFxGyY7C4gj0VsK14d+283DNJqKHVA8ulMfTJEKhRhjaq5HbAv/Bj
        yCSVjDiOvBuN5IouW8M010Z1gvID/vYICHdQtwhvOJL8WI0Prvbbr6uWzK5nJ222Oa6HP/Mr12RGo
        jPGPdHpBaPvDbncrTzOP/5LqdTrwJZFkq06bWAdt2uPG75ZDwc3cqft38JwV/UZQwpSUxvyhp1NxM
        bDCDWcvC/x8L3kKhtMOzDVs+Xy/gJ34WwhYKpGiluzGZtbEfTxXFNIj6sPNg+5CRpsUh1EjuiFaHm
        uGIQ/O2Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4IT1-0003R9-8O; Wed, 19 Feb 2020 06:04:15 +0000
Date:   Tue, 18 Feb 2020 22:04:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219060415.GO24185@bombadil.infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <20200219032900.GE10776@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219032900.GE10776@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 02:29:00PM +1100, Dave Chinner wrote:
> On Mon, Feb 17, 2020 at 10:46:11AM -0800, Matthew Wilcox wrote:
> > @@ -418,6 +412,15 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		}
> >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> >  				ctx, iomap, srcmap);
> > +		if (WARN_ON(ret == 0))
> > +			break;
> 
> This error case now leaks ctx->cur_page....

Yes ... and I see the consequence.  I mean, this is a "shouldn't happen",
so do we want to put effort into cleanup here ...

> > @@ -451,11 +454,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> >  done:
> >  	if (ctx.bio)
> >  		submit_bio(ctx.bio);
> > -	if (ctx.cur_page) {
> > -		if (!ctx.cur_page_in_bio)
> > -			unlock_page(ctx.cur_page);
> > -		put_page(ctx.cur_page);
> > -	}
> > +	BUG_ON(ctx.cur_page);
> 
> And so will now trigger both a warn and a bug....

... or do we just want to run slap bang into this bug?

Option 1: Remove the check for 'ret == 0' altogether, as we had it before.
That puts us into endless loop territory for a failure mode, and it's not
parallel with iomap_readpage().

Option 2: Remove the WARN_ON from the check.  Then we just hit the BUG_ON,
but we don't know why we did it.

Option 3: Set cur_page to NULL.  We'll hit the WARN_ON, avoid the BUG_ON,
might end up with a page in the page cache which is never unlocked.

Option 4: Do the unlock/put page dance before setting the cur_page to NULL.
We might double-unlock the page.

There are probably other options here too.
