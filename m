Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ED2405D4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244985AbhIIT0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIIT0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 15:26:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED0C061574;
        Thu,  9 Sep 2021 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9eYPN4SGvOoSGXLruTVuFwb68XsxZqpJHY8x5B67EyI=; b=lV2oJQVYRDMnUZkhcBngS14PQ3
        1Mb+ZPJ+jQiKNeExH1+mA4Pg5AltvuEzB5ryIu5HVcvJI9WtPbnOmb1yn6qZco+emOlvxvimLw8+R
        CXL/HiZEBWO2Umo4Q79bd3CufNZTN85rOBfsQGaHQNtTN8VhMlL0VbDnXiwKvoztdPkcxmCRCo9WP
        OzikypG0d0XqWW9lT+qkOMwApJrqWujaF2YHpH0SEVCLVS4bJu3x8GhxEHLnCemfsjLf7Hq8uSaAy
        MU/fzVHOyf+ul3Zm2LjlNd7Lot1MfgWY1Y2Y8HLJFyi6CuGTdFKbU7QVFojjqG+15132SmjujYfbq
        Uj1sZl0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOPe9-00AIXu-KF; Thu, 09 Sep 2021 19:23:49 +0000
Date:   Thu, 9 Sep 2021 20:23:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YTpfPY+jSdEGRb10@casper.infradead.org>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YToBjZPEVN9Jmp38@infradead.org>
 <6b01d707-3ead-015b-eb36-7e3870248a22@suse.cz>
 <969bf3e2-89be-c25b-938e-38430dc836d3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969bf3e2-89be-c25b-938e-38430dc836d3@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:17:00PM -0700, John Hubbard wrote:
> On 9/9/21 06:56, Vlastimil Babka wrote:
> > On 9/9/21 14:43, Christoph Hellwig wrote:
> > > So what is the result here?  Not having folios (with that or another
> > > name) is really going to set back making progress on sane support for
> > > huge pages.  Both in the pagecache but also for other places like direct
> > > I/O.
> > 
> > Yeah, the silence doesn't seem actionable. If naming is the issue, I believe
> > Matthew had also a branch where it was renamed to pageset. If it's the
> > unclear future evolution wrt supporting subpages of large pages, should we
> > just do nothing until somebody turns that hypothetical future into code and
> > we see whether it works or not?
> > 
> 
> When I saw Matthew's proposal to rename folio --> pageset, my reaction was,
> "OK, this is a huge win!". Because:
> 
> * The new name addressed Linus' concerns about naming, which unblocks it
>   there, and
> 
> * The new name seems to meet all of the criteria of the "folio" name,
>   including even grep-ability, after a couple of tiny page_set and pageset
>   cases are renamed--AND it also meets Linus' criteria for self-describing
>   names.
> 
> So I didn't want to add noise to that thread, but now that there is still
> some doubt about this, I'll pop up and suggest: do the huge
> 's/folio/pageset/g', and of course the associated renaming of the conflicting
> existing pageset and page_set cases, and then maybe it goes in.

So I've done that.

https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/tags/pageset-5.15

I sent it to Linus almost two weeks ago:
https://lore.kernel.org/linux-mm/YSmtjVTqR9%2F4W1aq@casper.infradead.org/

Still nothing, so I presume he's still thinking about it.
