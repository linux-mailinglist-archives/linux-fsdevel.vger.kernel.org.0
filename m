Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6648F14C3F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 01:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgA2AZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 19:25:01 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:40046 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgA2AZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 19:25:01 -0500
Received: from dread.disaster.area (pa49-195-111-217.pa.nsw.optusnet.com.au [49.195.111.217])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 32C487E9A77;
        Wed, 29 Jan 2020 11:24:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iwbA8-0005eI-Bd; Wed, 29 Jan 2020 11:24:56 +1100
Date:   Wed, 29 Jan 2020 11:24:56 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH 04/12] mm: Add readahead address space operation
Message-ID: <20200129002456.GH18610@dread.disaster.area>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125013553.24899-5-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=0OveGI8p3fsTA6FL6ss4ZQ==:117 a=0OveGI8p3fsTA6FL6ss4ZQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=bQT49A20HjYUhGx6rhoA:9
        a=UEMyszIiLG9v0jT0:21 a=UWfWf6Z2s6wDmKyN:21 a=CjuIK1q_8ugA:10
        a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 05:35:45PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This replaces ->readpages with a saner interface:
>  - Return the number of pages not read instead of an ignored error code.
>  - Pages are already in the page cache when ->readahead is called.
>  - Implementation looks up the pages in the page cache instead of
>    having them passed in a linked list.
....
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 5a6676640f20..6d65dae6dad0 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -121,7 +121,18 @@ static void read_pages(struct address_space *mapping, struct file *filp,
>  
>  	blk_start_plug(&plug);
>  
> -	if (mapping->a_ops->readpages) {
> +	if (mapping->a_ops->readahead) {
> +		unsigned left = mapping->a_ops->readahead(filp, mapping,
> +				start, nr_pages);
> +
> +		while (left) {
> +			struct page *page = readahead_page(mapping,
> +					start + nr_pages - left - 1);

Off by one? start = 2, nr_pages = 2, left = 1, this looks up the
page at index 2, which is the one we issued IO on, not the one we
"left behind" which is at index 3.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
