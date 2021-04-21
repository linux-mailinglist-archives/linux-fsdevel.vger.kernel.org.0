Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF30366AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhDUM2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 08:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhDUM2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 08:28:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F2C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Apr 2021 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ngoZ/1MTJJ4JYSZxMCPmNtmeGntGYOze1kWW8n2/T8c=; b=oM7vwvuYm1u0vWYLsugDfmrNKo
        kD4forUzBM8ixmqgPNJpUKnJbUkiZ0yLYwHFQZMcpc1afAWI0cTv56jBzkU+mm0dqahTJ2ODv1nr7
        fr1mX+8kNvEKBzxqJk2m1w3MHS4NorKv1S8RHPo3UeYrIjIGugOAsfLfzm0AMPQyY9v2oC/tDkapY
        lFzTkL+IEVnn3j80WZ0H7DMhvWjHUREYF/LW3x+feUfvTZuRseAeOAHI9uhx4F0MFgRymbbWPyGSn
        o+S/1VcMlo/sTArypcNUgN5Ld8KbkAzDsdDnYxlSuL4zsXCoH5Al9SFwXr6cgiBQxDhKQ8CFGvQHA
        IHjtA0/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZBwf-00GV6C-I3; Wed, 21 Apr 2021 12:27:21 +0000
Date:   Wed, 21 Apr 2021 13:27:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: Handle ractl nr_pages being modified
Message-ID: <20210421122705.GG3596236@casper.infradead.org>
References: <20210420210328.GD3596236@casper.infradead.org>
 <20210420200116.3715790-1-willy@infradead.org>
 <3675c1d23577dded6ca97e0be78c153ce3401e10.camel@kernel.org>
 <2159218.1619001284@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2159218.1619001284@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:34:44AM +0100, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Tue, Apr 20, 2021 at 04:12:57PM -0400, Jeff Layton wrote:
> > > > @@ -210,6 +208,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > > >  			 * not worth getting one just for that.
> > > >  			 */
> > > >  			read_pages(ractl, &page_pool, true);
> > > > +			i = ractl->_index + ractl->_nr_pages - index;
> > 
> > 			i = ractl->_index + ractl->_nr_pages - index - 1;
> > 
> > > > @@ -223,6 +222,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
> > > >  					gfp_mask) < 0) {
> > > >  			put_page(page);
> > > >  			read_pages(ractl, &page_pool, true);
> > > > +			i = ractl->_index + ractl->_nr_pages - index;
> > 
> > 			i = ractl->_index + ractl->_nr_pages - index - 1;
> > 
> > > Thanks Willy, but I think this may not be quite right. A kernel with
> > > this patch failed to boot for me:
> > 
> > Silly off-by-one errors.  xfstests running against xfs is up to generic/278
> > with the off-by-one fixed.
> 
> You can add my Tested-by - or do you want me to add it to my patchset?

I think you need it as part of your patchset, ordered before
readahead_expand().  It probably needs a rewritten description ...
