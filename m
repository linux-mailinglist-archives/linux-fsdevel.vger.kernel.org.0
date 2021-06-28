Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAA3B5FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhF1OLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhF1OLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034BC061574;
        Mon, 28 Jun 2021 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qF4WpNkFtCRbCathzIpkiay56Nr1UozBxL+oLmBQsSA=; b=DGjhcOBHY9eRKSwrf2zrOTdeIN
        L8ySZ3asDUouy7r+aspOyt0v+QRJyksNE9MnmyTXJE9F9QoT18vGNORlInzkli+zn7Kwb6c8+JDxA
        uxGdTdBWSnelX6HWLkX0kYKFittJN8Dk9zK+S71kncg3ljarmiijpwi9H4+FhSGAjjKCNXLHOMEVc
        DLsGRRInGx8WjOSlELynIp9CHoz8XT2w72c8GigLjj/Go1jzgdZbOGTxjrsIQz6hXofBFQG1qhfK1
        Zqotj+3vF+Un6Wmeqe1MPcXf1KAlaUDpts+5IcOMeVLvf3IcKRjJD08paw/x2W8ErnWz2zrsvjEXA
        jbEpZItg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxrvL-0032i4-6g; Mon, 28 Jun 2021 14:08:10 +0000
Date:   Mon, 28 Jun 2021 15:07:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/46] mm: Add arch_make_folio_accessible()
Message-ID: <YNnXrzxdNPuBCa3N@casper.infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-6-willy@infradead.org>
 <YNLqJXTG6HwKRvdh@infradead.org>
 <YNSraZoSxNTCZf5b@casper.infradead.org>
 <YNlqTb3gUG6dVq3t@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlqTb3gUG6dVq3t@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 28, 2021 at 07:21:01AM +0100, Christoph Hellwig wrote:
> On Thu, Jun 24, 2021 at 04:57:29PM +0100, Matthew Wilcox wrote:
> > On Wed, Jun 23, 2021 at 10:00:37AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 22, 2021 at 01:15:10PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > As a default implementation, call arch_make_page_accessible n times.
> > > > If an architecture can do better, it can override this.
> > > > 
> > > > Also move the default implementation of arch_make_page_accessible()
> > > > from gfp.h to mm.h.
> > > 
> > > Can we wait with introducing arch hooks until we have an actual user
> > > lined up?
> > 
> > This one gets used in __folio_end_writeback() which is patch 24 in this
> > series.
> 
> With arch hook I mean the ifdef to allow the architeture to override
> the folio function.  Same for the previous patch, btw.

Ah.  Actually, I hope that all architectures override this.  Ideally
'accessible' and 'dcache flush needed' would be per-folio flags, set only
on the head page, but the different architectures are inconsistent about
this.  So I've gone with "safe and slow" for the default, and maybe when
all architectures have decided that they'd rather be fast than safe, we
can fix this up.  As you know, I want to get rid of tail pages eventually,
so I'm trying to enable other people to do parts of that work for me.
