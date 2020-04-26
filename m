Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704D01B946F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 00:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDZWU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 18:20:59 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:47482 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725999AbgDZWU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 18:20:58 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3F5B8821542;
        Mon, 27 Apr 2020 08:20:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jSpdu-0008Lc-3Y; Mon, 27 Apr 2020 08:20:54 +1000
Date:   Mon, 27 Apr 2020 08:20:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, willy@infradead.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 3/9] btrfs: use set/clear_fs_page_private
Message-ID: <20200426222054.GA2005@dread.disaster.area>
References: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
 <20200426214925.10970-4-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426214925.10970-4-guoqing.jiang@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=FOH2dFAWAAAA:8 a=maIFttP_AAAA:8
        a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=UgJECxHJAAAA:8 a=7-415B0cAAAA:8
        a=MCBEIW9Q5ncSm9xiMmgA:9 a=CjuIK1q_8ugA:10 a=i3VuKzQdj-NEYjvDI-p3:22
        a=qR24C9TJY6iBuJVj_x8Y:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=AjGcO6oz07-iQ99wixmX:22 a=-El7cUbtino8hM1DCn8D:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 26, 2020 at 11:49:19PM +0200, Guoqing Jiang wrote:
> Since the new pair function is introduced, we can call them to clean the
> code in btrfs.
> 
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

....

>  void set_page_extent_mapped(struct page *page)
>  {
> -	if (!PagePrivate(page)) {
> -		SetPagePrivate(page);
> -		get_page(page);
> -		set_page_private(page, EXTENT_PAGE_PRIVATE);
> -	}
> +	if (!PagePrivate(page))
> +		set_fs_page_private(page, (void *)EXTENT_PAGE_PRIVATE);

Change the definition of EXTENT_PAGE_PRIVATE so the cast is not
needed? Nothing ever reads EXTENT_PAGE_PRIVATE; it's only there to
set the private flag for other code to check and release the extent
mapping reference to the page...

> @@ -8331,11 +8328,9 @@ static int btrfs_migratepage(struct address_space *mapping,
>  
>  	if (page_has_private(page)) {
>  		ClearPagePrivate(page);
> -		get_page(newpage);
> -		set_page_private(newpage, page_private(page));
> +		set_fs_page_private(newpage, (void *)page_private(page));
>  		set_page_private(page, 0);
>  		put_page(page);
> -		SetPagePrivate(newpage);
>  	}

This is just:
		set_fs_page_private(newpage, clear_fs_page_private(page));

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
