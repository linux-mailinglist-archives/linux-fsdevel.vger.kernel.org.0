Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB132DD11F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 13:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgLQMNa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 07:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLQMN3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:13:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50008C061794;
        Thu, 17 Dec 2020 04:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3NOq2HRM/zQR+du5IkXzjx0QWJZ13uHg9Yb/LeK0CWE=; b=pm8QvwY7Q1MhDBoMofSnx/S3f6
        Vx5bKTtq/b0P+T11NZcf529UhTTfJIL9UXGGa6MprW9Vh6zPnFOEQBfUrHAWtqGZ8yLlnGtRyVWDP
        CicIeUfr1MmuRD/iRYsnlfz8N7f8i8Uxa28MGyos8E7qz4bkxMwvOVeAZMuDb/HGmyFIaUhP4t8ga
        wiZ2YtxcVE1AeMeukqHapi6Hyj1G0TJf1n58/yHV+eIhQo8P40ZQUQJ5y6XfcGyc3HDtw5qwbLh1m
        JyziCZhQoihHnSjeSob32qioA2mkrWubK8ZjFMH8P5OnLkeXgqitdOpurr1CzGhPx7LqCTjPGo0Is
        oplreC6g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kps9G-0000gM-4F; Thu, 17 Dec 2020 12:12:46 +0000
Date:   Thu, 17 Dec 2020 12:12:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/25] btrfs: Use readahead_batch_length
Message-ID: <20201217121246.GD15600@casper.infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
 <20201216182335.27227-19-willy@infradead.org>
 <a5b979d7-1086-fe6c-6e82-f20ecb56d24c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b979d7-1086-fe6c-6e82-f20ecb56d24c@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 01:15:10AM -0800, John Hubbard wrote:
> On 12/16/20 10:23 AM, Matthew Wilcox (Oracle) wrote:
> > Implement readahead_batch_length() to determine the number of bytes in
> > the current batch of readahead pages and use it in btrfs.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >   fs/btrfs/extent_io.c    | 6 ++----
> >   include/linux/pagemap.h | 9 +++++++++
> >   2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 6e3b72e63e42..42936a83a91b 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -4436,10 +4436,8 @@ void extent_readahead(struct readahead_control *rac)
> >   	int nr;
> >   	while ((nr = readahead_page_batch(rac, pagepool))) {
> > -		u64 contig_start = page_offset(pagepool[0]);
> > -		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
> > -
> > -		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
> > +		u64 contig_start = readahead_pos(rac);
> > +		u64 contig_end = contig_start + readahead_batch_length(rac);
> 
> Something in this tiny change is breaking btrfs: it hangs my Fedora 33 test
> system (which changed over to btrfs) on boot. I haven't quite figured out
> what's really wrong, but git bisect lands here, *and* turning the whole
> extent_readahead() function into a no-op (on top of the whole series)
> allows everything to work once again.
> 
> Sorry for not actually solving the root cause, but I figured you'd be able
> to jump straight to the answer, with the above information, so I'm sending
> it out early.

ehh ... probably an off-by-one.  Does subtracting 1 from contig_end fix it?
I'll spool up a test VM shortly and try it out.
