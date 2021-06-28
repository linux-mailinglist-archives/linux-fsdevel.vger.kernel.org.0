Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B243B591D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 08:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhF1G3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1G3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:29:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105BBC061574;
        Sun, 27 Jun 2021 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kqPl8uKKTkQd95xx1nWpD57BeJxJwc5506fBPRake+o=; b=bjTS2gc/xpKd25m6OAYICQUS9j
        /uUwFApxw1ahiUWKxhO0XmORRnTfDqEnn2gf2RWXpXMP7CX9l8o8mNY2b4t6lATGRGBgogxdvUl+9
        xTAFIrUWoa45zB6hbLmc6KGpNODIq1KYtR8s3FObTmoA4mpKRZzUonTshbCuPxZsRecSxUQZNJb/c
        xR18MsOLzUiRdz+kkcUYd/C3W6db8yr+qb8JtOtMoH7JrnouybsiaZgnMOW3QCFmEF/YvgUNu2Swe
        YO23dxDeSo2tevOrHSO6QYEcfKhh1mA2VEu0cR/N/2vW8c9JEZAiO+XiWpuSQiOox69XZfjtfe0gS
        z3S+lDIQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxkhB-002eg2-Fe; Mon, 28 Jun 2021 06:24:46 +0000
Date:   Mon, 28 Jun 2021 07:24:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/46] mm/memcg: Convert
 mem_cgroup_track_foreign_dirty_slowpath() to folio
Message-ID: <YNlrJVWaz831cQas@infradead.org>
References: <20210622121551.3398730-1-willy@infradead.org>
 <20210622121551.3398730-18-willy@infradead.org>
 <YNLvBjx3mqXTjj+b@infradead.org>
 <YNTC67V2192OBiJ2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNTC67V2192OBiJ2@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 06:37:47PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 23, 2021 at 10:21:26AM +0200, Christoph Hellwig wrote:
> > Looks good,
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Although I wish we could come up with a shorter name for
> > mem_cgroup_track_foreign_dirty_slowpath somehow..
> 
> It is quite grotesque!
> 
> How about folio_track_foreign_writeback() as a replacement name for
> mem_cgroup_track_foreign_dirty() and have it call
> __folio_track_foreign_writeback()?
> 
> Although 'foreign' tends to be used in MM to mean "wrong NUMA node",
> so maybe that's misleading.  folio_track_dirty_cgroup()?
> folio_mark_dirty_cgroup()?  (the last to be read in context of
> __set_page_dirty() being renamed to __folio_mark_dirty())

That all sounds reasonable to me, hopefully someone more attached to
this code can pick one.
